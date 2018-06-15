import urllib
import requests


API_URL = 'http://westus.api.cognitive.microsoft.com/vision/v1.0/analyze'

SUBSCRIPTION_KEY = 'bf7998ddb2c64237a0f442d8b3952118'

HEADERS = {
    'Content-Type': 'application/octet-stream',
    'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY,
}

PARAMS = urllib.parse.urlencode({
    'visualFeatures': 'Categories,Description,Color',
    'language': 'en',
})


def call(pic_data):
    response = requests.post(API_URL,
                             params=PARAMS,
                             headers=HEADERS,
                             data=pic_data)
    return response.json()
