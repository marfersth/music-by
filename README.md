# README

## Notes
* There are three main entities: Artists, Albums and Songs
* If an Album is deleted, then all the songs of that album get deleted as well
* A song have two attributes that only can be set if the song is of type "featured", those attributes are `feature_text` and `image`
* The song track number have to be unique in the album it belongs to
* The song name have to be unique in the album it belongs to

## Endpoints
### Albums
* index
    * request
    ```bash
    GET /albums
    ````
    * response
    ```bash
    [
        {
          id: 1,
          year: 2016,
          name: "Christiane Wolff",
          created_at: "2020-10-01T18:11:14.876Z",
          updated_at: "2020-10-01T18:11:14.876Z"
        },
        {...}
    ]
    ````
* show
    * request
     ```bash
    GET /albums/:id
     ````
    * response
     ```bash
    {
        id: 1, 
        year: 2018,
        name: "Roxanne Armstrong",
        created_at: "2020-10-01T18:16:12.414Z",
        updated_at: "2020-10-01T18:16:12.414Z",
        artists: [{...}, {...}],
        songs: [{...}, {...}]
    }
    ```
* update
    * request
     ```bash
    PUT /albums/:id
    {
        album: {
            year: <integer>,
            name: <string>,
            songs_attributes: [
                {
                    track_num: <integer>,
                    genre: <string>,
                    duration: <integer>,
                    name: <string>,
                    featured: <boolean>,
                    feature_text: <string>,
                    image: <base64>
                },
                {
                    id: song.id,
                    _destroy: true
                }
            ]
        }
    }
     ````
    * response
     ```bash
    same response that `GET /albums/:id`
    ```
* create
    * request
     ```bash
    POST /albums
    {
        album: {
            year: <integer>,
            name: <string>,
            songs_attributes: [
                {
                    track_num: <integer>,
                    genre: <string>,
                    duration: <integer>,
                    name: <string>,
                    featured: <boolean>,
                    feature_text: <string>,
                    image: <base64>
                }
            ]
        }
    }
    ```
    * response
     ```bash
    same response that `GET /albums/:id`
    ```
* delete
    * request
     ```bash
    DELETE /albums/:id
    ```
    * response
     ```bash
    status 204
    ```

### Artists
* index 
    * request
     ```bash
    GET /artists
    ```
    * response
     ```bash
    [
        {
            id: 1,
            biography : "Smokin' weed nothing can save",
            name: "Veronika Yundt",
            created_at: "2020-10-01T18:36:15.430Z",
            updated_at: "2020-10-01T18:36:15.430Z"
        },
        {...}
    ]
    ```
* show
     * request
     ```bash
    GET /artists/:id
    ```
    * response
     ```bash
    {
        id: 1,
        biography: "Why is you roll with Mr. Buckwort",
        name: "Maddie Wyman",
        created_at: "2020-10-01T18:39:56.882Z",
        updated_at: "2020-10-01T18:39:56.882Z",
        albums: [{...}, {...}],
        songs: [{...}, {...}]
    }
    ```
* update
    * request
    ```bash
    PUT /artists/:id
    {
        artist:{
            biography: <string>,
            name: <string>,
            albums_attributes: [
                {
                    name: <string>,
                    year: <integer>
                },
                {
                    id: album.id,
                    _destroy: true
                },
                {
                    id: album.id
                }
            ]
        }
    }
    ```
    * response
    ```bash
    same response that `GET /artists/:id`
    ```
* create
    * request
    ```bash
    POST /artists/
    {
      artist:{
          biography: <string>,
          name: <string>,
          albums_attributes: [
            {
                name: <string>,
                year: <integer>
            },
            {
                id: album.id
            }
          ]
      }
    }
    ```
    * response
    ```bash
    same response that `GET /artists/:id`
    ```
* delete
    * request
     ```bash
    DELETE /artists/:id
    ```
    * response
     ```bash
    status 204
    ```
### Songs
* index 
    * request
     ```bash
    GET /songs
    ```
    * response
     ```bash
    [
        {   
            id: 1,
            track_num: 10,
            genre: "Moral",
            duration: 89,
            name: "Machelle Emard",
            created_at: "2020-10-01T18:49:18.148Z",
            updated_at: "2020-10-01T18:49:18.277Z",
            feature_text: "Rolling down the street",                                        # only visible if song is is type "featured"
            image_url: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWV/sample_image.jpeg"  # only visible if song is is type "featured"
        },
        {...}
  ]
    ```
* show
     * request
     ```bash
    GET /songs/:id
    ```
    * response
     ```bash
    {   
        id: 1,
        track_num: 10,
        genre: "Moral",
        duration: 89,
        name: "Machelle Emard",
        created_at: "2020-10-01T18:49:18.148Z",
        updated_at: "2020-10-01T18:49:18.277Z",
        feature_text: "Rolling down the street",                                        # only visible if song is is type "featured"
        image_url: "/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWV/sample_image.jpeg",  # only visible if song is is type "featured"
        album: {...},
        artists: [{...}, {...}]
    }
    ```
* update
    * request
    ```bash
    PUT /songs/:id
    {
        song:{
            track_num: <integer>,
            genre: <string>,
            duration: <integer>,
            name: <string>,
            featured: <boolean>,
            feature_text: <string>,
            image: <base64_image>
            artists_attributes: [
                {
                    name: <string>,
                    biography: <sring>
                },
                {
                    id: artist.id,
                    _destroy: true
                },
                {
                    id: artist.id,
                }
            ]
        }
    }
    ```
    * response
    ```bash
    same response that `GET /songs/:id`
    ```
* create
    * request
    ```bash
    POST /songs/
    {
        song:{
          track_num: <integer>,
          genre: <string>,
          duration: <integer>,
          name: <string>,
          featured: <boolean>,
          feature_text: <string>,
          image: <base64_image>
          artists_attributes: [
            {
                name: <string>,
                biography: <sring>
            },
            {
                id: artist.id,
            }
          ]
        }
    }
    ```
    * response
    ```bash
    same response that `GET /songs/:id`
    ```
* delete
    * request
     ```bash
    DELETE /songs/:id
    ```
    * response
     ```bash
    status 204
    ```




