# ESENS

#### Documentations

State Management => Provider

Architecture => Provider Model View

packages used :

    -   http: ^0.13.5
    -   provider: ^6.0.5
    -   pinch_zoom: ^1.0.0
    -   dio: ^4.0.6
    -   image_gallery_saver: ^1.7.1
    -   share_plus: ^6.3.0
    -   sqflite: ^2.2.4+1

Lib is where we can find everything we need for the app

    - Helper directory :

            The file db_helper.dart is used to handle the favorites part.
            In this file, we can create a little Database with the sqflite package : https://pub.dev/packages/sqflite
            We have three mains functions that are related to ou database :
            - getAllImageDAta() => get all the favorites images
            - addImageData() => add images to favorite
            - deleteImageData() => delete images from favorite

            thoses functions are related to our provider.

    - Model directory :

            We can find three model here :
                - model_db_helper.dart => related to our db_helper and the data we can send to our favorites table
                - model_images => related to our home page list of images (get the url and the id)
                - model_search => related to our search page list of images (get the url and the id)

    - Prodiver directory :

            We can find one file here which is provider_images.dart.
            In this File, we can handle the favorite actions management,
            fetch the datas for our home page and for our search page.
            We will call theses functions with Provider.of<ImgProvider>(context, listen: false).*functions() and used it with our FutureBuilder to displays the datas we just fetch or to handle it.

    - View directory :

            We can find all the views we need here :
                - 404 (handle navigation failed)
                - components (app_bar & bottom_bar)
                - favoris (related to our favorite pages)
                - home (first screen we saw when we launch the app and widgets that build the element we have like images_list -> image_card + full_screen.dart)
                - searchScreen (here we can find our search_bar and our search_screen that will displays images we are searching for thanks to keywords)

Globals => API url + keys
