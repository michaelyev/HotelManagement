// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract HotelManagement{
    
    address owner;
    uint totalRooms;
    uint availableRooms;
    uint roomPrice;

    constructor(uint _totalRooms, uint _roomPrice) {
        owner = msg.sender;
        totalRooms = _totalRooms;
        roomPrice = _roomPrice;
        availableRooms = _totalRooms;
    }

    event bookedRooms(address indexed _guest, uint _requestedRooms);

    modifier checkAvailability (uint _requestedRooms) {
        require(availableRooms > _requestedRooms, 'No enough rooms availale');
        _;
    }

    
    function bookRooms (uint _requestedRooms) public checkAvailability(_requestedRooms) payable {
        require(msg.value == roomPrice * _requestedRooms, 'Not enough balance');
        availableRooms -= _requestedRooms;
        emit bookedRooms(msg.sender, _requestedRooms);
    }

    function getAvailableRooms() public view returns(uint) {
        return availableRooms;
    }

    function getTotalRooms() public view returns(uint){
        return totalRooms;
    }

    function withdrawFunds() public {
        require(msg.sender == owner, 'Only the owner can run this function');
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }




}