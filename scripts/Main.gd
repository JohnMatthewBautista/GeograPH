extends Node

var regions : Array[Region] = [
	Region.new("Ilocos Region", "Luzon", "San Fernando, La Union", "Region 1", ["Ilocos Norte", "Ilocos Sur", "La Union", "Pangasinan"]),
	Region.new("Cagayan Valley", "Luzon", "Tuguegarao", "Region 2", ["Batanes", "Cagayan", "Isabela", "Nueva Vizcaya", "Quirino"]),
	Region.new("Central Luzon", "Luzon", "San Fernando, Pampanga", "Region 3", ["Aurora", "Bataan", "Bulacan", "Nueva Ecija", "Pampanga", "Tarlac", "Zambales"]),
	Region.new("Calabarzon", "Luzon", "Calamba", "Region 4a", ["Batangas", "Cavite", "Laguna", "Quezon", "Rizal"]),
	Region.new("Mimaropa", "Luzon", "Calapan", "Region 4b", ["Marinduque", "Occidental Mindoro", "Oriental Mindoro", "Palawan", "Romblon"]),
	Region.new("Bicol Region", "Luzon", "Legazpi", "Region 5", ["Albay", "Camarines Norte", "Camarines Sur", "Catanduanes", "Masbate", "Sorsogon"]),
	Region.new("Western Visayas", "Visayas", "Iloilo City", "Region 6", ["Aklan", "Antique", "Capiz", "Guimaras", "Iloilo"]),
	Region.new("Negros Island Region", "Visayas", "Bacolod and Dumaguete", "NIR", ["Negros Occidental", "Negros Oriental", "Siquijor"]),
	Region.new("Central Visayas", "Visayas", "Cebu City", "Region 7", ["Bohol", "Cebu"]),
	Region.new("Eastern Visayas", "Visayas", "Tacloban", "Region 8", ["Biliran", "Eastern Samar", "Leyte", "Northern Samar", "Samar", "Southern Leyte"]),
	Region.new("Zamboanga Peninsula", "Mindanao", "Pagadian", "Region 9", ["Zamboanga del Norte", "Zamboanga del Sur", "Zamboanga Sibugay"]),
	Region.new("Northern Mindanao", "Mindanao", "Cagayan de Oro", "Region 10", ["Bukidnon", "Camiguin", "Lanao del Norte", "Misamis Occidental", "Misamis Oriental"]),
	Region.new("Davao Region", "Mindanao", "Davao City", "Region 11", ["Davao de Oro", "Davao del Norte", "Davao del Sur", "Davao Occidental", "Davao Oriental"]),
	Region.new("Soccsksargen", "Mindanao", "Koronadal", "Region 12", ["Sarangani", "South Cotabato", "Sultan Kudarat"]),
	Region.new("Caraga", "Mindanao", "Butuan", "Region 13", ["Agusan del Norte", "Agusan del Sur", "Dinagat Islands", "Surigao del Norte", "Surigao del Sur"]),
	Region.new("National Capital Region", "Luzon", "Manila", "NCR", ["Caloocan", "Las Piñas", "Makati", "Malabon", "Mandaluyong", "Marikina", "Muntinlupa", "Navotas", "Parañaque", "Pasay", "Pasig", "Pateros", "Quezon City", "San Juan", "Taguig", "Valenzuela"]),
	Region.new("Cordillera Administrative Region", "Luzon", "Baguio", "CAR", ["Abra", "Apayao", "Benguet", "Ifugao", "Kalinga", "Mountain Province"]),
	Region.new("Bangsamoro Autonomous Region", "Mindanao", "Cotabato City", "BARMM", ["Basilan", "Lanao del Sur", "Maguindanao", "Sulu", "Tawi-Tawi"])
]

@export var settings = {
	"timer_max" : 60,
	"question_mode" : "random"
}

