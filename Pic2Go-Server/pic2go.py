import os
import uuid
import pickle
import json
import re

from flask import Flask, request, send_from_directory, jsonify, url_for
from scipy import sparse
from sklearn.metrics.pairwise import cosine_similarity

from .lib import vision, translate


app = Flask(__name__)

@app.route('/', methods=['POST'])
def index():
    f = request.files['pic']
    pic_data = f.read()

    # Call Azure Vision API
    response = vision.call(pic_data)
    tags = response['description']['tags']
    print('[Debug] Tags: {}'.format(tags))

    # Translate the tags into Traditional Chinese (zh-TW)
    zhtw_tags = list(filter(lambda x: x != '', re.split('\W', translate.call(str(tags)))))
    print('[Debug] Tags (zh-TW): {}'.format(zhtw_tags))

    # Store the tags into a temporary file (because TfidfVectorizer needs it)
    tmp_filepath = os.path.join('tmp/', '{}.tags'.format(uuid.uuid4()))
    with open(tmp_filepath, 'w') as f:
        for tag in zhtw_tags:
            print(tag, end=' ', file=f)
        print(file=f)

    # Query
    tfidf = sparse.load_npz('models/tfidf.npz')

    with open('models/tfidf_vectorizer.pkl', 'rb') as f:
        tfidf_vectorizer = pickle.load(f)
    query_tfidf = tfidf_vectorizer.transform([tmp_filepath])

    scores = cosine_similarity(query_tfidf, tfidf).flatten()
    n = 5; top_n_indices = scores.argsort()[::-1][:n]

    # Output
    with open('data/data.json') as f:
        data = json.load(f)['Infos']['Info']

    output = []
    for i in top_n_indices:
        spot = data[i]
        output.append({
            'name': spot['Name'],
            'description': spot['Toldescribe'],
            'address': spot['Add'],
            'travellingInformation': spot['Travellinginfo'],
            'openingHours': spot['Opentime'],
            'image': url_for('images', _external=True, filename=(spot['Id'] + '.jpg'))
        })

    # Clean up
    os.remove(tmp_filepath)

    return jsonify(output)

@app.route('/images/<filename>')
def images(filename):
    return send_from_directory('images', filename)
