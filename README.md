## DYNAMIC PATH PLANNING

Please refer to the Path Planning report for detailed analysis.

The report is structured as; section 2 discusses the ACO algorithm briefly
and the MATLAB results obtained to support the theory. In section 3 a
brief introduction of Artifcial Neural Network and later Backpropagation
algorithm is given. In section 4 we have discussed the dynamic vehicle model
we have built using mathematical models for path planning controller and in
section 5 we have discussed our model and the results obtained. Finally we
conclude in section 6 and propose the future expectations.

Robot navigation is governed and managed by a neural network working on
the data obtained. We have learned about the neural networks and used
back propagation algorithm to train the network. Number of layers in the
network are 4. The output of our neural network gives the heading angle to
the bot. **The trained neural network was successfully implemented and the
bot was able to trace the desired path, avoiding obstacles, to reach the final
destination**. Due to non-ideal setup of the prototype a small amount of noise
was observed in the data obtained from the sensors. As a result of which
the bot movement was not as accurate as expected at a few instances. In an
attempt to improve the accuracy of the results obtained from the noisy data
we aim to implement Q-learning or Recurrent learning after learning their
application feasibility on our model.

The project was done as a part of Design Project at **BITS Pilani** under the guidence and supervision of Dr **Surekha Bhanot**.

Authors : **Rasal Kumar, Arjun Gupta, Abhinav Modi**
 







