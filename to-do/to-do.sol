// SPDX-License-Identifier: GPL-3.0;
pragma solidity ^ 0.8.7;
  
  //Note to Self
  //Update the Names??
  contract ToDo{

  
    struct Task { 
          string taskName;
          bool isDone;
    }

      mapping(address => Task[]) private Users;

      // Add a task
      function addTask(string memory _task) external{
      
        Users[msg.sender].push(Task(_task, false));
      }

      //function to get details of a task 
      function getTask(uint _taskIndex) external view returns(Task memory) {
    
      Task memory task = Users[msg.sender][_taskIndex];
        return task;
      }

      //function to update status of a task
      function updateStatus(uint _taskIndex, bool _status) external {
    
        Users[msg.sender][_taskIndex].isDone = _status;
      }

      //function to delete a task
      function deleteTask(uint _taskIndex) external {
    
        delete Users[msg.sender][_taskIndex];
      }

      //function to get task count.
      function getTaskCount() external view returns(uint) {
    
        return Users[msg.sender].length;
      }
}