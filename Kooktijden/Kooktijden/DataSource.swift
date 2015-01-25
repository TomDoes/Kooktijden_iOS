//
//  DataSource.swift
//  Kooktijden
//
//  Created by Harm Brugge on 07-11-14.
//  Copyright (c) 2014 De appothekers. All rights reserved.
//

import Foundation
import SQLite

class DataSource {
    
    var path: String
    let db: Database
    
    init() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String
        path = documentsDirectory.stringByAppendingPathComponent("foods.sqlite")
        
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path))
        {
            // If it doesn't, copy it from the default file in the Resources folder
            let bundle = NSBundle.mainBundle().pathForResource("foods", ofType: "sqlite")
            fileManager.copyItemAtPath(bundle!, toPath: path, error:nil)
        }
        
        db = Database(path)
        
    }
    
    func getFoods() -> [FoodItem] {
        var items: [FoodItem] = []
        
        let foods = db["foods"]
        
        for food in foods {
            var foodItem = FoodItem()
            
            foodItem.id = food[Expression<Int>("id")]!
            foodItem.nameEN = food[Expression<String>("name_EN")]!
            foodItem.nameNL = food[Expression<String>("name_NL")]!
            foodItem.descriptionEN = food[Expression<String>("description_EN")]
            foodItem.descriptionNL = food[Expression<String>("description_NL")]
            foodItem.cookingTimeMin = food[Expression<Int>("cooking_time_min")]!
            foodItem.cookingTimeMax = food[Expression<Int>("cooking_time_max")]!

            items.append(foodItem)
        }
    
        return items
    }
    func writeFoods() {        
        let id = Expression<Int>("id")
        let nameEN = Expression<String>("name_EN")
        let nameNL = Expression<String>("name_NL")
        let descriptionEN = Expression<String>("description_EN")
        let descriptionNL = Expression<String>("description_NL")
        let cookingTimeMin = Expression<Int>("cooking_time_min")
        let cookingTimeMax = Expression<Int>("cooking_time_max")
        
        let foods = db["foods"]
        
        
        foods.insert(nameEN <- "Artichoke", nameNL <- "Artisjok", cookingTimeMin <- 25 * 60, cookingTimeMax <- 25 * 60, descriptionEN <- "Artichokes look more like a Flower than a vegetable. To prepare an artichoke you have to cut of the stem and remove the tougher leaves until only the soft remain.", descriptionNL <- "Artisjokken lijken meer op een bloem dan een groente. Om een artisjok te bereiden moet je de steel er af snijden en verwijder je de harde bladeren totdat er alleen nog zachte over zijn.")?
        
        foods.insert(nameEN <- "Asparagus (whole)", nameNL <- "Asperges (heel)", cookingTimeMin <- 15 * 60, cookingTimeMax <- 15 * 60 , descriptionEN <- "Before cooking asparagus you have to peel them. This easiest way is to leave them for 30 minutes in a bit of water before peeling them. To peel them grab the head and move your knife from the top downwards. Next cut a small piece from the bottom. Cook the asparagus with the peels and the bottom ens for more flavour.", descriptionNL <- "Voordat asperges in de pan kunnen, moeten ze geschild worden. Dit gaat het makkelijkst wanneer je ze een half uur laat weken in koud water voordat je ze schilt. Pak vervolgens een asperge bij de kop en schil van boven naar beneden en verwijder een stukje van de onderkant. Kook de asperges vervolgens met de schillen en de uiteinden voor meer smaak.")?
        
        foods.insert(nameEN <- "Beans", nameNL <- "Sperziebonen", cookingTimeMin <- 8  * 60, cookingTimeMax <- 8 * 60, descriptionEN <- "Remove both ends of the beans and place them in boiling water. After 8 minutes rinse the beans with cold water to preserve the green color and prevent overcooking", descriptionNL <- "Snij de uiteinden van de sperziebonen af en plaats ze in kokend water. Giet de sperziebonen na 8 minuten af en spoel ze kort af met koud water om de mooie groene kleur te behouden en te voorkomen dat ze nog verder garen.")?
        
        foods.insert(nameEN <- "Beetroot", nameNL <- "Bieten", cookingTimeMin <- 40 * 60, cookingTimeMax <- 60 * 60, descriptionEN <- "If there's a stem remove it. Put it in water and heat it. Boil them with the lid on the pan until there done. Use a fork to test if the beetroot is ready. If it's soft, it's probably done.", descriptionNL <- "Als er nog een stengel aan de bieten zit, kun je deze er af snijden. Maak de bieten schoon, breng ze in een pan aan de kook en kook ze gaar. Check of ze gaar zijn door er met een vork in te prikken. Als de bieten zacht zijn, zijn ze klaar.")?
        
        foods.insert(nameEN <- "Bok choy", nameNL <- "Paksoi / Chinese kool", cookingTimeMin <- 10 * 60, cookingTimeMax <- 10 * 60, descriptionEN <- "Cut the bok choy in large strokes and wash is thoroughly. You may then cook it, however you could also eat it raw", descriptionNL <- "Snij de chinese kool in stroken en was deze goed. Vervolgens kun je ze koken, maar je kunt ze ook rauw eten")?
        
        foods.insert(nameEN <- "Broccoli", nameNL <- "Broccoli", cookingTimeMin <- 8 * 60, cookingTimeMax <- 8 * 60, descriptionEN <- "Before placing the broccoli in the pan, cut the bottom of the broccoli and cut it into small florets", descriptionNL <- "Voordat je broccoli in de pan doet, verwijder je de onderkant en snijd je de broccoli in roosjes.")?
        
        foods.insert(nameEN <- "Brussels sprouts", nameNL <- "Spruitjes", cookingTimeMin <- 10 * 60, cookingTimeMax <- 10 * 60, descriptionEN <- "Prepare Brussels sprouts by removing the outer leaves and a small piece from the bottom. Place them in water and bring it to boil.", descriptionNL <- "Ter voorbereiding van het koken van spruitjes verwijder je de onderkant en de buitenste blaadjes. Doe ze vervolgens in de pan en breng het water aan de kook.")?
        
        foods.insert(nameEN <- "Cabbage", nameNL <- "Witte kool", cookingTimeMin <- 10 * 60, cookingTimeMax <- 15 * 60, descriptionEN <- "Cabbage is rich in vitamin C and is often used in stews and salads. Remove the thick outer leaves and cut the cabbage into pieces. Clean the pieces using running water before cooking.", descriptionNL <- "Witte kool is rijk aan vitamine C en bovendien een goedkope groente die zich uitstekend leent voor bijvoorbeeld stamppot, ovenschotels en salades. Haal de buitenste bladen weg en snijd de kool in stukken. Spoel de stukken kool af voor het koken")?
        
        foods.insert(nameEN <- "Carrots", nameNL <- "Wortels", cookingTimeMin <- 10 * 60, cookingTimeMax <- 10 * 60, descriptionEN <- "Gently scrub the carrots under cold running water to remove the dirt on the surface. Trim both ends of each carrots. Use a kitchen knife or vegetable peeler to peel the top layer. Submerge the carrots in salted water and let it boil for roughly 10 minutes.", descriptionNL <- "Snijd de boven- en onderkant van de wortels af. Schraap vervolgens met een keukenmes alle vuil en onregelmatigheden weg. Grotere en grovere wortels kun je beter helemaal schillen. Hierna kunnen de wortels in de pan. Vul deze met koud water tot de wortels er net onder staan en voeg wat zout toe. Laat het water ongeveer 10 minuten koken.")?
        
        foods.insert(nameEN <- "Cauliflower", nameNL <- "Bloemkool", cookingTimeMin <- 12 * 60, cookingTimeMax <- 12 * 60, descriptionEN <- "Remove the leaves and stem of the cauliflower, then wash under running water. Submerge in salted water and boil the cauliflower.", descriptionNL <- "Verwijder de bladeren van de bloemkool en een stuk van de stronk. Was de bloemkool in zijn geheel met de stronk naar beneden gehouden. Zet de bloemkool in een pan met water met zout en breng aan de kook.")?
        
        foods.insert(nameEN <- "Corn on the cob", nameNL <- "Maiskolf", cookingTimeMin <- 15 * 60, cookingTimeMax <- 25 * 60, descriptionEN <- "Remove the husks, clean the cob and cook in water without salt. The cooking time depends on the size and it's best not to overcook the corn. The corn is done if you can pop it from the cob using a fork. Serve with butter and salt.", descriptionNL <- "Verwijder het groene omhulsel, maak de maiskolf schoon en kook in ruim water zonder zout. Kleinere kolven zijn sneller gaar dan grotere en te lang koken gaat ten koste van de smaak. Controleer daarom regelmatig of de mais gaar is. De mais is gaar als je de korrels zonder veel moeite van de kolf kunt wippen met een vork. Serveer met een klontje boter en wat zout.")?
        
        foods.insert(nameEN <- "Endive", nameNL <- "Witlof", cookingTimeMin <- 12 * 60, cookingTimeMax <- 15 * 60, descriptionEN <- "Pull of any brown outer leaves and clean the endive with water. The green tip and heart are quite bitter and is many people prefer to remove it. Remove the stem, then cut the endive up and boil in water. ", descriptionNL <- "Trek eventuele bruine bladeren van de witlof af en spoel de stronk af. Daarna kan je een klein plakje van het bruine voetje weghalen. Verwijder het hart van de witlof aan de binnenkant, die is namelijk erg bitter. Snijd vervolgens de witlof in reepjes en leg deze in onder een laagje water in de pan, breng ze vervolgens aan de kook.")?
        
        foods.insert(nameEN <- "Leek", nameNL <- "Prei", cookingTimeMin <- 15 * 60, cookingTimeMax <- 15 * 60, descriptionEN <- "To prepare leeks, cut off and discard the dark green parts that are tough. Trim the leek's beard at the bottom. You'll often find dirt on the leek. The easiest way to clean leeks is to cut them into rings, and swirl them in water to remove the grit, then drain them well. Cook the rings in water with a pinch of salt.", descriptionNL <- "Voor je begint met prei koken, is het belangrijk dat je de prei goed wast. Vooral tussen de bladeren van de stengels zit vaak aarde. Snijd ook de wortel en de donkergroene stukken van de prei af. Vervolgens snijd je de prei in ringetjes die je ook goed moet wassen. Kook de ringetjes in een pan met een snufje zout.")?
        
        foods.insert(nameEN <- "Peas", nameNL <- "Erwten", cookingTimeMin <- 5 * 60, cookingTimeMax <- 5 * 60, descriptionEN <- "Peas exist in loads of variants. The pea is a vegetable that grows inside a legume (a carpel which is folded around the peas). Peas are round or oval shaped. Most types don't need a lot of cooking, a good warm-up of approximately 5 minutes is enough.", descriptionNL <- "Erwten bestaan in veel verschillende varianten. Het is een groente die groeit binnenin een peul (een langwerpig vruchtblad dat dichtgevouwen om de erwten zit). Erwten zijn rond of ovaal van vorm. De meeste soorten hoeven niet lang te koken, vaak zo'n 5 minuten goed opwarmen al voldoende.")?
        
        foods.insert(nameEN <- "Potatoes (halves)", nameNL <- "Aardappelen (halven)", cookingTimeMin <- 10 * 60, cookingTimeMax <- 15 * 60, descriptionEN <- "Peal or wash the potatoes before cooking. Cutting the potatoes in halves decreases the cooking time substantially. Make sure you cut the potatoes in equally sized parts, else the parts will not cook through simultaneously. Submerge the potatoes in a pan filled with water. If desired, add a pinch of salt to the water.", descriptionNL <- "Schil of was de aardappelen voor je ze gaat koken. Door de aardappelen doormidden te snijden voor je ze gaat koken verkort je de kooktijd aanzienlijk. Zorg er hierbij wel voor dat je de aardappelen in delen van gelijke grootte snijd, anders zijn de delen niet gelijktijdig gaar. Doe de aardappelen in een pan met water en voeg eventueel een snufje zout toe.")?
        
        foods.insert(nameEN <- "Potatoes (whole)", nameNL <- "Aardappelen (heel)", cookingTimeMin <- 15 * 60, cookingTimeMax <- 20 * 60, descriptionEN <- "Peal or wash the potatoes before cooking. Submerge the potatoes in a pan filled with water. If desired, add a pinch of salt to the water.", descriptionNL <- "Schil of was de aardappelen voor je ze gaat koken. Doe de aardappelen in een pan met water en voeg eventueel een snufje zout toe.")?
        
        foods.insert(nameEN <- "Red cabbage (shredded)", nameNL <- "Rodekool (gesneden)", cookingTimeMin <- 15 * 60, cookingTimeMax <- 20 * 60, descriptionEN <- "Remove the outer leaves of the cabbage. Cut the cabbage into quarters and remove the hard stalk. Scrape or cut the leaves into thin strips and place them in a pan. Add a little water and salt to taste and bring to the boil.", descriptionNL <- "Verwijder de buitenste bladen van de kool. Snijd vervolgens de kool in vieren en verwijder de harde stronk. Schaaf of snijd dan de bladeren in dunne sliertjes en doe deze in de pan. Voeg een beetje water en zout toe en breng aan de kook.")?
        
        foods.insert(nameEN <- "Spinach", nameNL <- "Spinazie", cookingTimeMin <- 4 * 60, cookingTimeMax <- 5 * 60, descriptionEN <- "Fresh spinach is very healthy and versatile. Rinse the spinach before use to remove any left-over grains of sand. Remove the thick petioles from the leaves. Place the spinach in a large pan with a small amount of water and a pinch of salt, and bring to the boil. Note: spinach shrinks tremendously during cooking!", descriptionNL <- "Verse spinazie is bijzonder gezond en veelzijdig. Spoel voor gebruik de spinazie goed af om eventuele zandkorrels te verwijderen. Haal de dikke bladstengels van de bladeren. Plaats de spinazie in een ruime pan met een klein laagje water en een snufje zout en breng het aan de kook. Let op: spinazie slinkt enorm tijdens het koken!")?
        
        foods.insert(nameEN <- "Sweet potatoes (whole)", nameNL <- "Zoete aardappelen (heel)", cookingTimeMin <- 15 * 60, cookingTimeMax <- 20 * 60, descriptionEN <- "Boiling sweet potatoes is almost the same process as that of the normal potato. Peel and wash the potatoes and cut them into uniform pieces. Place the pieces in a pan and add water so that the majority of the potatoes are submerged. Add a pinch of salt and bring to a boil. Make sure that the potatoes are cooked with the aid of a fork. If you can easily pierce the potatoes then they are done.", descriptionNL <- "Het koken van zoete aardappelen is bijna hetzelfde proces als dat van de normale aardappel. Schil of was de aardappels en snijd ze in gelijkmatige stukken. Plaats de delen in een pan en zet ze voor het grootste deel onder water. Doe hier een snufje zout bij en breng aan de kook. Controleer of de aardappels gaar zijn met behulp van een vork. De aardappels zijn gaar als je gemakkelijk in de aardappels kunt prikken.")?
        
        foods.insert(nameEN <- "Test", nameNL <- "Test", cookingTimeMin <- 1 * 60, cookingTimeMax <- 1 * 60, descriptionEN <- "Boiling sweet potatoes is almost the same process as that of the normal potato. Peel and wash the potatoes and cut them into uniform pieces. Place the pieces in a pan and add water so that the majority of the potatoes are submerged. Add a pinch of salt and bring to a boil. Make sure that the potatoes are cooked with the aid of a fork. If you can easily pierce the potatoes then they are done.", descriptionNL <- "Het koken van zoete aardappelen is bijna hetzelfde proces als dat van de normale aardappel. Schil of was de aardappels en snijd ze in gelijkmatige stukken. Plaats de delen in een pan en zet ze voor het grootste deel onder water. Doe hier een snufje zout bij en breng aan de kook. Controleer of de aardappels gaar zijn met behulp van een vork. De aardappels zijn gaar als je gemakkelijk in de aardappels kunt prikken.")?
        
    }

}










