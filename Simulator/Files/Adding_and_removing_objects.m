% % This Script explains basic commands for adding Objects to Gazebo environment.
% %After ros is initialzied...
% gazebo = ExampleHelperGazeboCommunicator();
% ball = ExampleHelperGazeboModel('Ball');                  %Use ExampleHelperGazeboCommunicator  for making a ball
% spherelink = addLink(ball,'sphere',1,'color',[0 0 1 1])   % Adding a Link to label ball with specific properties
% spawnModel(gazebo,ball,[8.5,0,1]);                        % Add object to Gazebo

% x = [1.5    1.5    1.5   1.5   2.5     2.5  2.5    3.5    3.5   4.5];
% y = [-1.5  -0.5    0.5   1.5   -1      0    1     -0.5    0.5   0];
% pin = ExampleHelperGazeboModel('BowlPin');                 % Making BowlPins      
% link1 = addLink(pin,'cylinder',[1 0.2],'position',[0,0,0.5]);  % Adding a cylinder Link to label pin
% link2 = addLink(pin,'sphere',0.2,'position',[0,0, 1.2],'color',[0.7 0 0.2 1]); % Adding a Sphere link to label pin
% joint = addJoint(pin,link1,link2,'revolute',[0 0],[0 0 1]);   % adding a joint between 2 links of the label pin
% for i = 1:10
%     spawnModel(gazebo,pin,[x(i),y(i),0.7]);
%     pause(1);
% end
% if ismember('mobile_base',getSpawnedModels(gazebo))
%     removeModel(gazebo,'mobile_base');                      % Remove the turtlebot if it is present in gazebo
% end
% barrier = ExampleHelperGazeboModel('jersey_barrier','gazeboDB');      % Label for barriers
% spawnModel(gazebo,barrier,[1.5,-3,0]); % Right barrier
% pause(1);
% spawnModel(gazebo,barrier,[1.5,3,0]); % Left barrier
% spawnedBall = ExampleHelperGazeboSpawnedModel(ball.Name,gazebo)
% duration = 1; % Seconds
% forcevec = [-75 0 0]; % Newtons
% applyForce(spawnedBall, spherelink, duration, forcevec);
% pause(5);
exampleHelperGazeboCleanupBowling;