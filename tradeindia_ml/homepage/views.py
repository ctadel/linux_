from django.shortcuts import render

def homepage(request,**kwargs):
    laguage = kwargs.get('language','en')
    templates = dict(
        en='homepage/homepage.html',
        hi='homepage/homepage_hi.html',
        bn='homepage/homepage_bn.html',
        np='homepage/homepage_np.html'
            )

    template = templates.get(laguage,'homepage.html')

    return render(request,template)
