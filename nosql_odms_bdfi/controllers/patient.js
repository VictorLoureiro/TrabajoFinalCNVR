// Cargamos los modelos para usarlos posteriormente
const Patient = require('../models/patient');

exports.list = async function() {
    let pacientes = await Patient.find();
    return pacientes;
}

exports.read = async function(patientId) {
    
	let paciente = await Patient.findById(patientId);
	//console.log(typeof(paciente));
	console.log(paciente);
	return paciente;
}

exports.create = async function(body) {
	let newDoc = new Patient(body);
    let nuevoPaciente = await newDoc.save();
    return nuevoPaciente;
}

exports.update= async function(patientId, body) {
	let paciente = await Patient.findOneAndUpdate({_id:patientId},body,{new:true});
	return paciente;

}

exports.delete = async function(patientId) {
	let paciente = await Patient.deleteOne({_id:patientId});
	return paciente;
}

exports.filterPatientsByCity = async function (city) {
    let pacientes = await Patient.find({city:city});
    return pacientes;

}

exports.filterPatientsByDiagnosis = async function (diagnosis) {
    let pacientes = await Patient.find({"medicalHistory.diagnosis":diagnosis});
    return pacientes;

}

exports.filterPatientsBySpeacialistAndDate = async function (specialist, sDate,fDate) {
	
	let pacientes = await Patient.aggregate([
		{$unwind: "$medicalHistory"},
		{$match:{"medicalHistory.specialist": specialist, "medicalHistory.date":{$gte: new Date(sDate),$lte: new Date(fDate)}}}
	]);
	console.log(pacientes)
	return pacientes;

    
}

exports.addPatientHistory = async function (patientId, medicalRecord) {
	let patient = await Patient.findById(patientId);
	patient.medicalHistory.push(medicalRecord);
	let result = await paciente.save();
	return result;

}
