# Twitter Sentiment 

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

A mobile app that determines the sentiment (positive, negative, neutral) of a topic based on conversations happening on Twitter by leveraging natural language processing and machine learning. 

### Built With
* [SwiftUI](https://www.javascript.com/)
* [CoreML](https://nodejs.org/en/)
* [CreateML](https://developer.apple.com/machine-learning/create-ml/)


<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

- Twitter Developers Account 
- Twitter Account

### Installation

1. Download or clone this repo 
    ```bash
    $ git clone git@github.com:ellojess/Twitter-Sentiment-iOS.git
    ```
2. Get your free credentials from Twitter at [https://developer.twitter.com/en/dashboard](https://example.com)

    Use the credentials from the Developers Account to get the following values. 
    
    Add them in the `Constants.swift` file by replacing *VALUE* with your personal credentials
    ```
    let apiKey="VALUE"
    let apiSecretKey="VALUE"
    let bearerToken="VALUE"
    ```
3. `cd` into the project folder and open it in Xcode (or use `xed .` to open it from terminal) 
    ```bash
    $ cd Twitter-Sentiment

    $ xed . 
    ```
4. If your local project has an error with `Swifter` you can delete `SwifteriOS` from the file hierarchy
    
    Then download and embed `SwifteriOS` from [here](https://github.com/mattdonnelly/Swifter)
  
<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/ellojess/Twitter-Sentiment-iOS/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request using this [template](https://github.com/embeddedartistry/templates/blob/master/oss_docs/PULL_REQUEST_TEMPLATE.md)

### Possible Contributions 
- [ ] Add a new feature (accessibilities, etc.)
- [ ] New UI elements (animations, dark-mode, etc)
- [ ] Increase accuracy of model (handle sarcasm & emojis)

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Jessica Trinh - [@ellojesss](https://twitter.com/ellojesss) - jtjessicatrinh@gmail.com

Project Link: [https://github.com/ellojess/Twitter-Sentiment-iOS](https://github.com/ellojess/Twitter-Sentiment-iOS)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Swift](https://developer.apple.com/swift/)
* [SwiftUI](https://developer.apple.com/documentation/swiftui/)
* [CoreML](https://developer.apple.com/documentation/coreml)
* [SwifteriOS](https://github.com/mattdonnelly/Swifter)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* Twitter Sanders Apple3 dataset
