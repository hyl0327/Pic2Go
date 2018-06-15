import requests

from bs4 import BeautifulSoup


SUBSCRIPTION_KEY = '34b87b58b1bd4b8d985ff686f0f353e7'

COGNITIVE_SERVICE_URL = 'https://api.cognitive.microsoft.com/sts/v1.0/issueToken'
TOKEN = requests.post(COGNITIVE_SERVICE_URL,
                      headers={'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY}).text
APPID = 'Bearer ' + TOKEN

TRANSLATE_URL = 'https://api.microsofttranslator.com/v2/http.svc/Translate'


def call(text):
    params = {
        'appid': APPID,
        'text': text,
        'from': 'en',
        'to': 'zh-Hant'
    }

    request_headers = {'Accept': 'application/xml'}
    response = requests.get(TRANSLATE_URL, params=params, headers=request_headers)
    soup = BeautifulSoup(response.text, 'lxml')

    return soup.get_text()
