
/*:
 # Congressional App Challenge 2022 Dementia AI Playground 
 Playground is developed by Tanay Panja
 
 # Problem
 An increasing number of older adults suffer from Alzheimer's disease and other related dementias (ADRD), a major cause of disability. According to the World Health Organization, dementia is one of the most common neurological disorders, with over 55 million people currently diagnosed and 10 million cases are diagnosed every year. Even worse, only about 20-50% of cases are recognized properly according to Alzheimer’s Disease International. 
 
 
 # Clock Drawing Test (CDT)
 Diagnosis for cognitive dysfunction can be made through a simple Clock Drawing Test (CDT). The CDT asks subjects to draw a clock with hands showing 10 after 11, and then assigns either a binary score (normal vs. abnormal) or ordinal score (0 to 5). A significant limitation of large-scale studies is the fact that CDTs require manual coding, meaning that there is a risk of biases arising when coders interpret and apply coding rules differently.
 
 
 # Features in the app include:
 * A CoreML model to automate the coding of paper-based Clock Drawing Tests (CDT), widely available for evaluating cognitive impairment such as Dementia, Alzheimer’s, Huntington’s disease, delirium, multiple sclerosis, etc.
 * The camera to take a photo of paper based test by using a mobile device (iPad)
 * CoreML model to automate and provide an ordinal score (0-5) instead of binary and code using neural networks and Artificial Intelligence to lead to more reliable CDT coding.
 * A large data set of clock drawings from the 2011-2019 National Health and Aging Trends Study (NHATS), a study of Medicare beneficiaries ages 65 and older funded by the National Institute on Aging to develop and train my own CoreML model.
 * SwiftUI views to maximize user experience with the playground.
 * It runs entirely on the user's device, avoiding the need for a network connection and keeping the app and users' health data private.
 * Better diagnosis and classification of dementia, especially mild cognitive dysfunction.
 * This screening tool can be used with non-English speaking populations.
 
 # Credits
 * NHATS Public Clock Image Dataset
 * Shulman, K. I., Shedletsky, R. & Silver, I. L. The challenge of time: clock-drawing and cognitive function in the elderly. Int. J.
 Geriatric Psychiatry 1, 135–140 (1986)
 */
import PlaygroundSupport
PlaygroundPage.current.setLiveView(HomeView())
