// SPDX-License-Identifier: GPL-3.0;
pragma solidity ^ 0.8.7;
  
contract ToDo{

  struct Task{
    string  taskName;
    bool isComplete;
  }

  mapping(address => Task[]) taskCreators;

  event taskAdded(string taskName);
  event taskStatusUpdated(string taskName, uint index);
  event taskDeleted(uint index);

  function addTask(string memory _taskName) external{
    taskCreators[msg.sender].push(Task(_taskName, false));
    emit taskAdded(_taskName);
  }

  function getTask(uint _taskIndex) public view returns(Task memory) {
    Task memory task = taskCreators[msg.sender][_taskIndex];
    return task;
  }

  function updateTask(string memory _taskName, uint _taskIndex) external{
    Task memory task = taskCreators[msg.sender][_taskIndex];
    task.taskName = _taskName;
    emit taskStatusUpdated(_taskName, _taskIndex);
  }

  function toggleTaskComplete(uint _taskIndex)external{
    taskCreators[msg.sender][_taskIndex].isComplete = false;
  }

  function deleteTask(uint _taskIndex) external{
    delete taskCreators[msg.sender][_taskIndex];
    emit taskDeleted(_taskIndex);
  }
}