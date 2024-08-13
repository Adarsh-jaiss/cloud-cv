from flask import jsonify
from google.cloud import firestore


def get_resume(request):
    "Retrive the resume from the firestore and returns it as Json Response"

    # Get the resume data from firestore
    resume_data = firestore.Client().collection(
        'resumes').document('KOZnif7tHyn5DZEE1scy').get().to_dict()

    return jsonify(resume_data, 200)
