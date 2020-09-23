//
//  InformationViewController.swift
//  Corona-App
//
//  Created by BB1151 on 07.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit


struct SectionData {
    var opened = Bool()
    var title = String()
    var cellData = [String]()
    var image = UIImage()
}

struct CellData {
    var text = String()
}

class ButtonWithImage: UIButton {
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: (bounds.width - 35), bottom: 5, right: 5)
            contentHorizontalAlignment = .left
            let availableSpace = bounds.inset(by: contentEdgeInsets)
            let availableWidth = availableSpace.width - imageEdgeInsets.left
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: availableWidth)
        }
    }
}

class InformationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var informationTableView: UITableView!
    
    var button3: UIButton?
    
    private let CELL_ID = "informationCell"
    private var sections : [SectionData] = [
        SectionData(
            opened: false,
            title: "Was sind Coronaviren?",
            cellData: [
                "Coronaviren wurden erstmals Mitte der 1960er Jahre identifiziert. Sie können sowohl Menschen als auch verschiedene Tiere infizieren, darunter Vögel und Säugetiere. Mit SARS-CoV-2 sind insgesamt sieben humanpathogene Coronaviren bekannt. Coronaviren verursachen beim Menschen verschiedene Krankheiten, von gewöhnlichen Erkältungen bis hin zu gefährlichen oder sogar potenziell tödlich verlaufenden Krankheiten wie dem Middle East Respiratory Syndrome (MERS) oder dem Severe Acute Respiratory Syndrome (SARS). Es gibt immer die Möglichkeit, dass Viren sich genetisch verändern. Mutationen verändern aber nicht automatisch die Eigenschaften des Virus."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was ist COVID-19?",
            cellData: [
                "COVID-19 ist die Infektionskrankheit, die durch das kürzlich entdeckte Coronavirus verursacht wird. Dieses neue Virus und diese Krankheit waren vor Beginn des Ausbruchs in Wuhan, China, im Dezember 2019 unbekannt. COVID-19 ist heute eine Pandemie, die viele Länder weltweit betrifft."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was ist über die Ursache dieses Ausbruchs bekannt?",
            cellData: [
                "Man nimmt an, dass SARS-CoV-2 von Fledermäusen stammt, Zwischenwirte wurden jedoch noch nicht identifiziert. Derzeit wird davon ausgegangen, dass sich die ersten Patienten Anfang Dezember auf einem Markt in Wuhan in der Provinz Hubei, China, angesteckt haben."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Wie verbreitet sich COVID-19?",
            cellData: [
                "Menschen können sich bei anderen Personen, die das Virus haben, mit COVID-19 anstecken. Die Krankheit breitet sich vor allem durch kleine Tröpfchen aus der Nase oder dem Mund von Mensch zu Mensch aus, die ausgestoßen werden, wenn eine Person mit COVID-19 hustet, niest oder spricht. Diese Tröpfchen sind relativ schwer, reisen nicht weit und sinken schnell auf den Boden. Menschen können sich mit COVID-19 anstecken, wenn sie diese Tröpfchen von einer mit dem Virus infizierten Person einatmen. Deshalb ist es wichtig, sich mindestens 1 Meter von anderen Personen fernzuhalten. Diese Tröpfchen können auf Gegenständen und Oberflächen um die Person herum wie Tischen, Türklinken und Handläufen landen. Personen können sich infizieren, indem sie diese Gegenstände oder Oberflächen berühren und dann ihre Augen, Nase oder ihren Mund berühren. Deshalb ist es wichtig, sich regelmäßig die Hände mit Wasser und Seife zu waschen oder mit alkoholhaltigem Handreiben zu reinigen."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Gibt es eine Saisonalität bei SARS-CoV-2?",
            cellData: [
                "Ob die Aktivität von SARS-CoV-2 saisonal beeinflusst wird, ist noch offen. Viele Viren, die akute Atemwegserkrankungen verursachen, verbreiten sich im Sommer generell schlechter: Grund dafür sind unter anderem die höheren Temperaturen, die UV-Strahlung, aber auch die Tatsache, dass man weniger Zeit dicht gedrängt in Räumen verbringt. Eine solche Saisonalität wurde bei anderen humanen Coronaviren beobachtet (Schnupfenviren). Ein saisonaler Effekt ist auch bei SARS-CoV-2 denkbar, es ist jedoch offen, wie groß ein solcher Effekt sein würde, da das Virus immer noch auf eine Bevölkerung trifft, die kaum Immunschutz gegen SARS-CoV-2 aufweist"
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Wie lange überlebt das Virus auf Oberflächen?",
            cellData: [
                "Das Wichtigste, was man über Coronaviren auf Oberflächen wissen muss, ist, dass diese leicht mit haushaltsüblichen Desinfektionsmitteln gereinigt werden können, die das Virus abtöten. Studien haben gezeigt, dass das COVID-19-Virus auf Kunststoff und Edelstahl bis zu 72 Stunden, auf Kupfer weniger als 4 Stunden und auf Karton weniger als 24 Stunden überleben kann. Reinigen Sie Ihre Hände immer mit einem alkoholhaltigen Handwaschmittel oder waschen Sie sie mit Wasser und Seife. Vermeiden Sie es, Ihre Augen, Ihren Mund oder Ihre Nase zu berühren."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Kann COVID-19 bei einer Person gefangen werden, die keine Symptome hat?",
            cellData: [
                "COVID-19 wird hauptsächlich durch Atemtröpfchen verbreitet, die von jemandem ausgestoßen werden, der hustet oder andere Symptome wie Fieber oder Müdigkeit hat. Bei vielen Menschen mit COVID-19 treten nur leichte Symptome auf. Dies gilt insbesondere in den frühen Stadien der Erkrankung. Es ist möglich, sich COVID-19 von jemandem anzustecken, der nur einen leichten Husten hat und sich nicht krank fühlt. Einige Berichte haben darauf hingewiesen, dass Menschen ohne Symptome das Virus übertragen können. Es ist noch nicht bekannt, wie oft dies geschieht. Die WHO wertet die laufenden Forschungsarbeiten zu diesem Thema aus und wird weiterhin aktualisierte Ergebnisse mitteilen."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was sollte ich tun, wenn ich COVID-19-Symptome habe, und wann sollte ich mich in ärztliche Behandlung begeben?",
            cellData: [
                "Wenn Sie leichte Symptome wie leichten Husten oder leichtes Fieber haben, besteht in der Regel keine Notwendigkeit, ärztliche Hilfe in Anspruch zu nehmen. Bleiben Sie zu Hause, isolieren Sie sich selbst und beobachten Sie Ihre Symptome. Befolgen Sie die nationalen Richtlinien zur Selbstisolierung. Wenn Sie jedoch in einem Gebiet mit Malaria oder Dengue-Fieber leben, ist es wichtig, dass Sie die Symptome des Fiebers nicht ignorieren. Suchen Sie medizinische Hilfe auf. Tragen Sie beim Besuch der Gesundheitseinrichtung nach Möglichkeit eine Maske, halten Sie mindestens 1 Meter Abstand zu anderen Personen und berühren Sie Oberflächen nicht mit den Händen. Wenn es sich um ein krankes Kind handelt, helfen Sie dem Kind, sich an diesen Rat zu halten. Suchen Sie sofort ärztliche Hilfe auf, wenn Sie Atembeschwerden oder Schmerzen/Druck in der Brust haben. Wenn möglich, rufen Sie Ihren Arzt oder Ihre Ärztin im Voraus an, damit er/sie Sie an die richtige Gesundheitseinrichtung verweisen kann."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was soll ich tun, wenn ich in engen Kontakt mit jemandem gekommen bin, der COVID-19 hat?",
            cellData: [
                "Wenn Sie in engem Kontakt mit jemandem mit COVID-19 waren, sind Sie möglicherweise infiziert. Enger Kontakt bedeutet, dass Sie in einem Umfeld leben oder waren, das weniger als 1 Meter von den Erkrankten entfernt ist. In diesen Fällen ist es am besten, zu Hause zu bleiben. Wenn Sie jedoch in einem Gebiet mit Malaria oder Dengue-Fieber leben, ist es wichtig, dass Sie die Symptome des Fiebers nicht ignorieren. Suchen Sie medizinische Hilfe auf. Wenn Sie die Gesundheitseinrichtung aufsuchen, tragen Sie möglichst eine Maske, halten Sie einen Mindestabstand von 1 Meter zu anderen Personen ein und berühren Sie Oberflächen nicht mit den Händen. Wenn es sich um ein krankes Kind handelt, helfen Sie dem Kind, sich an diesen Rat zu halten. Wenn Sie nicht in einem Gebiet mit Malaria oder Dengue-Fieber leben, gehen Sie bitte wie folgt vor:\n\n • Wenn Sie krank werden, müssen Sie sich auch bei sehr leichten Symptomen selbst isolieren\n\n• Selbst wenn Sie nicht glauben, dass Sie COVID-19 ausgesetzt waren, aber Symptome entwickeln, sollten Sie sich selbst isolieren und überwachen\n\n• Es ist wahrscheinlicher, dass Sie andere im Frühstadium der Krankheit anstecken, wenn Sie nur leichte Symptome haben, daher ist eine frühe Selbstisolierung sehr wichtig.\n\n• Wenn Sie keine Symptome haben, aber einer infizierten Person ausgesetzt waren, Selbstquarantäne für 14 Tage.\n\nWenn Sie definitiv 14 Tage lang COVID-19 (durch einen Test bestätigt) vorsichtshalber selbst isoliert haben, auch nachdem die Symptome verschwunden sind - es ist noch nicht genau bekannt, wie lange Menschen nach ihrer Genesung infektiös bleiben. Befolgen Sie die nationalen Ratschläge zur Selbstisolierung."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Wie können wir andere und uns selbst schützen, wenn wir nicht wissen, wer infiziert ist?",
            cellData: [
                "Das Üben von Hand- und Atemwegshygiene ist zu ALLEN Zeiten wichtig und der beste Weg, andere und sich selbst zu schützen. Halten Sie nach Möglichkeit einen Abstand von mindestens 1 Meter zwischen sich und anderen Personen ein. Dies ist besonders wichtig, wenn Sie neben jemandem stehen, der hustet oder niest. Da einige infizierte Personen möglicherweise noch keine oder nur leichte Symptome aufweisen, ist es ratsam, einen körperlichen Abstand zu allen Personen einzuhalten, wenn Sie sich in einem Gebiet aufhalten, in dem COVID-19 im Umlauf ist."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was bedeutet es, sich selbst zu isolieren?",
            cellData: [
                "Die Selbstisolierung ist eine wichtige Maßnahme, die von denjenigen ergriffen wird, die COVID-19-Symptome haben, um die Ansteckung anderer in der Gemeinde, einschließlich der Familienmitglieder, zu vermeiden. Selbstisolation liegt vor, wenn eine Person, die Fieber, Husten oder andere COVID-19-Symptome hat, zu Hause bleibt und nicht zur Arbeit, zur Schule oder an öffentliche Orte geht. Dies kann freiwillig oder auf Empfehlung seines/ihres Gesundheitsversorgers geschehen. Wenn Sie jedoch in einem Gebiet mit Malaria oder Dengue-Fieber leben, ist es wichtig, dass Sie Fiebersymptome nicht ignorieren. Suchen Sie medizinische Hilfe auf. Wenn Sie die Gesundheitseinrichtung besuchen, tragen Sie nach Möglichkeit eine Maske, halten Sie einen Mindestabstand von 1 Meter zu anderen Personen ein und berühren Sie Oberflächen nicht mit den Händen. Wenn es sich um ein krankes Kind handelt, helfen Sie dem Kind, sich an diesen Rat zu halten. Wenn Sie nicht in einem Gebiet mit Malaria oder Dengue-Fieber leben, gehen Sie bitte wie folgt vor: - Wenn sich eine Person in Selbstisolation befindet, dann deshalb, weil sie krank, aber nicht schwer krank ist (und medizinische Hilfe benötigt) \n\n• über ein großes, gut belüftetes Gebäude mit Handhygiene- und Toiletteneinrichtungen \n\n• Wenn dies nicht möglich ist, stellen Sie Betten im Abstand von mindestens 1 Meter auf. \n\n• Halten Sie mindestens 1 Meter Abstand zu anderen Personen, auch zu Ihren Familienmitgliedern. \n\n• Überwachen Sie Ihre Symptome täglich \n\n• Isolieren Sie 14 Tage lang, auch wenn Sie sich gesund fühlen \n\n• Wenn Sie Atembeschwerden haben, wenden Sie sich sofort an Ihren medizinischen Betreuer - wenn möglich, rufen Sie ihn zuerst an \n\n• Bleiben Sie positiv und voller Energie, indem Sie mit Ihren Lieben per Telefon oder online in Kontakt bleiben und indem Sie sich zu Hause sportlich betätigen."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was ist der Unterschied zwischen Selbstisolation, Selbstquarantäne und Distanzierung?",
            cellData: [
                "Quarantäne bedeutet die Einschränkung von Aktivitäten oder die Trennung von Personen, die selbst nicht krank sind, aber möglicherweise COVID-19 ausgesetzt waren. Ziel ist es, die Ausbreitung der Krankheit zu dem Zeitpunkt zu verhindern, an dem die Menschen gerade Symptome entwickeln. Isolation bedeutet die Trennung von Menschen, die an Symptomen von COVID-19 erkrankt sind und möglicherweise infektiös sind, um die Ausbreitung der Krankheit zu verhindern. Physische Distanzierung bedeutet, physisch getrennt zu sein. Die WHO empfiehlt, einen Abstand von mindestens 1 Meter zu anderen Personen einzuhalten. Dies ist eine allgemeine Maßnahme, die jeder ergreifen sollte, auch wenn es ihm gut geht und keine bekannte Exposition gegenüber COVID-19 vorliegt."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Wie sicher ist ein neuer Impfstoff?",
            cellData: [
                "Ein Impfstoff wird erst nach ausreichender Überprüfung auf den Markt gebracht (präklinische und klinische Phase, Zulassungsprüfung, Auflagen der Zulassungsbehörden und Marktzulassung, Nachzulassungsbeobachtung). Nach seiner Marktzulassung erfolgt eine ständige Kontrolle („Surveillance“) zum Erfassen von Wirksamkeit und möglichen Nebenwirkungen. Nebenwirkungen und Impfreaktionen werden in Deutschland zentral – und Hersteller-unabhängig - vom Paul-EhrlichInstitut (PEI) erfasst. Durch die Zusammenfassung von nationalen und internationalen Beobachtungen kann sichergestellt werden, dass auch Risiken von Impfstoffen erfasst werden, die so selten sind, dass sie erst bei einer sehr großen Anzahl durchgeführter Impfungen sichtbar werden. Auch bei einem neuen Impfstoff gegen SARS-CoV-2 ist es möglich, dass sehr seltene Nebenwirkungen (sehr selten heißt z.B. 1 Fall auf > 10.000 Geimpfte) erst im Verlauf der Surveillance erfasst werden. Sowohl die Weltgesundheitsorganisation (WHO) als auch die Europäische Arzneimittelagentur (EMA) haben angekündigt, den Zulassungsprozess aufgrund der Dringlichkeit in einzelnen Punkten zu vereinfachen. Dabei bleibt die Sicherheit der Impfstoffe jedoch oberste Priorität."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Wie lange dauert es nach der Exposition gegenüber COVID-19, bis sich Symptome entwickeln?",
            cellData: [
                "Die Zeit zwischen der Exposition gegenüber COVID-19 und dem Zeitpunkt des Auftretens der Symptome beträgt in der Regel etwa fünf bis sechs Tage, kann aber zwischen 1 und 14 Tagen liegen."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Ist man nach einer durchgemachten SARS-CoV-2-Infektion immun?",
            cellData: [
                "Derzeit gehen Experten davon aus, dass genesene Patienten nur ein geringes Risiko haben, ein zweites Mal an COVID-19 zu erkranken. Erste Studien haben gezeigt, dass Personen nach durchgemachter SARS-CoV-2-Infektion spezifische Antikörper entwickeln, die das Virus in Labortesten neutralisieren können. Unklar ist jedoch noch, wie robust und dauerhaft dieser Immunstatus aufgebaut wird und ob es möglicherweise von Mensch zu Mensch Unterschiede gibt. Die Erfahrungen mit anderen Coronavirus-Erkrankungen wie SARS und MERS deuten darauf hin, dass ein zumindest partieller Immunstatus bis zu drei Jahre anhalten könnte. Um diesen Aspekt für COVID-19 Erkrankungen genau bewerten zu können, sind serologische Längsschnittstudien erforderlich, die den Immunstatus von Rekonvaleszenten über einen längeren Zeitraum beobachten."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was ist über COVID-19 bei Kindern bekannt?",
            cellData: [
                "In der Mehrzahl der vorliegenden Studien sind Kinder seltener von einer Infektion mit SARS-CoV-2 betroffen als Erwachsene. Ob Kinder genauso empfänglich für eine Infektion sind wie Erwachsene, ist nicht endgültig geklärt. Die Symptomatik der Erkrankung ist bei Kindern häufig geringer ausgeprägt als bei Erwachsenen, auch asymptomatische Verläufe kommen häufiger als bei Erwachsenen vor. Schwere Verläufe sind selten und betreffen insbesondere Säuglinge und Kleinkinder, einzelne Todesfälle im Zusammenhang mit COVID-19 sind im Kindesalter beschrieben. In sehr seltenen Fällen können erkrankte Kinder und Jugendliche eine schwere, aber behandelbare Entzündungsreaktion entwickeln (u.a. bezeichnet als „multisystemisches inflammatorisches Syndrom“). Zur Frage, inwiefern Kinder und Jugendliche zur Verbreitung von SARS-CoV-2 in der Bevölkerung beitragen, liegen bislang nur wenige Daten vor. In den meisten Studien zeigte sich, dass Kinder durch Erwachsene infiziert wurden. Da die Betreuungs- und Bildungseinrichtungen während der meisten Untersuchungen geschlossen bzw. nur eingeschränkt geöffnet waren, sind die Ergebnisse nicht auf die Alltagssituation übertragbar."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was ist über COVID-19 bei Schwangeren bekannt?",
            cellData: [
                "Aktuell gibt es keine Daten zur Empfänglichkeit für eine SARS-CoV-2-Infektion in der Schwangerschaft. Aufgrund der physiologischen Anpassungen und immunologischen Vorgänge kann eine erhöhte Empfänglichkeit nicht ausgeschlossen werden. Im Fall einer Infektion scheinen Schwangere jedoch häufiger keine oder nur milde Symptome (z.B. seltener Fieber) zu entwickeln. Bei Verdacht auf eine Infektion sollte daher die Indikation für eine Testung auf SARS-CoV- 2 großzügig gestellt werden. Zur Frage der Schwere des Krankheitsverlaufs geben die bisherigen Studien und Fallberichte, in denen Schwangere mit COVID-19 untersucht wurden, keinen Hinweis darauf, dass die Krankheit bei Schwangeren schwerer verläuft als bei Nicht-Schwangeren, in Einzelfällen kann eine intensivmedizinische Behandlung erforderlich sein. Todesfälle, darunter auch im Wochenbett, die möglicherweise in Zusammenhang mit einer Erkrankung stehen, wurden bislang nur vereinzelt berichtet. Hinsichtlich möglicher Auswirkungen einer COVID-19 Erkrankung auf das Ungeborene gibt es bisher nur wenige Daten, insbesondere fehlen hier Langzeituntersuchungen. Daher können zu dieser Fragestellung keine validen Aussagen gemacht werden. Generell kann hohes Fieber während des ersten Schwangerschaftsdrittels das Risiko von Komplikationen und Fehlbildungen erhöhen. Die Möglichkeit einer Übertragung im Mutterleib kann, basierend auf den bisher vorliegenden wenigen Untersuchungen und Fallberichten aus China zu Immunreaktionen bei Neugeborenen, nicht ausgeschlossen werden. In den meisten Fällen zeigen die Kinder SARS-CoV-2-positiver Mütter nach der Geburt keine Krankheitszeichen. Bislang sind nur einzelne Fälle von Erkrankungen bei Neugeborenen beschrieben, die möglicherweise Folge einer Infektion im Mutterleib sind. Eine Übertragung von der Mutter auf das neugeborene Kind ist - sofern keine geeigneten Schutzmaßnahmen ergriffen werden - bei engem Kontakt möglich. Es gibt nur wenige Untersuchungen zur Fragestellung, ob das Virus in der Muttermilch nachweisbar ist. Bislang gelang nur in einem Fall der Nachweis von Virus -RNA. Allerdings kann die beobachtete Infektion des Neugeborenen hier auf anderem Wege erfolgt sein, weshalb ungeklärt bleibt, ob das Virus in der Muttermilch tatsächlich auch infektiös und eine Übertragung durch das Stillen damit möglich ist."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was versteht man unter der Reproduktionszahl R, und wie wichtig ist sie für die Bewertung der Lage? ",
            cellData: [
                "Die Reproduktionszahl beschreibt, wie viele Menschen eine infizierte Person im Mittel ansteckt. Sie kann nicht alleine als Maß für Wirksamkeit/Notwendigkeit von Maßnahmen herangezogen werden. Wichtig sind außerdem u.a. die absolute Zahl der täglichen Neuinfektionen sowie die Schwere der Erkrankungen. Die absolute Zahl der Neuinfektionen muss klein genug sein, um eine effektive Kontaktpersonennachverfolgung zu ermöglichen und die Kapazitäten von Intensivbetten nicht zu überlasten. Am Anfang einer Pandemie gibt es den Startwert R0 (auch: Basisreproduktionszahl), der beschreibt, wie viele Menschen ein Infizierter im Mittel ansteckt, wenn die gesamte Bevölkerung empfänglich für das Virus ist (weil es noch keine Immunität in der Bevölkerung gibt), noch kein Impfstoff verfügbar und noch keine Infektionsschutzmaßnahmen getroffen wurden. Bei SARS -CoV-2 liegt R0 zwischen 2,4 und 3,3, das heißt jeder Infizierte steckt im Mittel etwas mehr als zwei bis etwas mehr als drei Personen an. Ohne Gegenmaßnahmen würde die Zahl der Infektionen rasch exponentiell ansteigen und erst stoppen, wenn bis zu 70 % der Bevölkerung eine Infektion bzw. Erkrankung durchgemacht haben, also immun sind und das Virus ihrerseits nicht mehr weiterverbreiten können. Durch Infektionsschutzmaßnahmen lässt sich die Reproduktionszahl verringern. Man spricht von einer zeitabhängigen Reproduktionszahl R(t). Es gilt: \n\n• Wenn R > 1, dann steigende Anzahl täglicher Neuinfektionen, \n\n• Wenn R = 1, dann konstante Anzahl täglicher Neuinfektionen \n\n• Wenn R < 1, dann sinkende Anzahl täglicher Neuinfektionen. Bei SARS-CoV-2 ist das Ziel, die Reproduktionszahl stabil bei unter 1 zu halten."
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Wie werden Todesfälle erfasst?",
            cellData: [
                "In der Statistik des RKI werden die COVID-19-Todesfälle gezählt, bei denen ein laborbestätigter Nachweis von SARS-CoV-2 (direkter Erregernachweis) vorliegt und die in Bezug auf diese Inf ektion verstorben sind. Das Risiko an COVID-19 zu versterben ist bei Personen, bei denen bestimmte Vorerkrankungen bestehen, höher. Daher ist es in der Praxis häufig schwierig zu entscheiden, inwieweit die SARS-CoV-2 Infektion direkt zum Tode beigetragen hat. Sowohl Menschen, die unmittelbar an der Erkrankung verstorben sind („gestorben an“), als auch Personen mit Vorerkrankungen, die mit SARS-CoV-2 infiziert waren und bei denen sich nicht abschließend nachweisen lässt, was die Todesursache war („gestorben mit“) werden derzeit erfasst. Verstorbene, die zu Lebzeiten nicht auf COVID-19 getestet wurden, aber in Verdacht stehen, an COVID-19 verstorben zu sein, können post mortem auf das Virus untersucht werden. Darüber hinaus wird in fast allen Bundesländern der vertrauliche Teil der Todesbescheinigung an das Gesundheitsamt gesendet. Dort kann ein Abgleich mit den Meldedaten erfolgen, wenn auf der Todesbescheinigung als Todesursache eine Infektionskrankheit angegeben ist"
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Was ist der Zusammenhang zwischen COVID-19 und Tieren?",
            cellData: [
                "COVID-19 wird durch Übertragung von Mensch zu Mensch verbreitet. Wir wissen bereits eine Menge über andere Viren aus der Familie der Coronaviren, und die meisten dieser Virustypen haben ihren Ursprung bei Tieren. Das COVID-19- Virus (auch SARS-CoV-2 genannt) ist ein neues Virus beim Menschen. Die mögliche tierische Quelle von COVID-19 wurde noch nicht bestätigt, aber die Forschung ist im Gange. "
            ],
            image: UIImage(named: "ArrowDown")!
        ),
        SectionData(
            opened: false,
            title: "Kann ich COVID-19 von meinem Haustier oder anderen Tieren einfangen?",
            cellData: [
                "Mehrere Hunde und Katzen (Hauskatzen und Tiger) in Kontakt mit infizierten Menschen wurden positiv auf COVID-19 getestet. Darüber hinaus scheinen Frettchen für die Infektion empfänglich zu sein. Unter Versuchsbedingungen waren sowohl Katzen als auch Frettchen in der Lage, die Infektion auf andere Tiere derselben Art zu übertragen. Es gibt jedoch keine Hinweise darauf, dass diese Tiere die Krankheit auf den Menschen übertragen und COVID-19 verbreiten können. COVID-19 wird hauptsächlich durch Tröpfchen verbreitet, die entstehen, wenn eine infizierte Person hustet, niest oder spricht. Auch in landwirtschaftlichen Betrieben aufgezogene Nerze wurden mit dem Virus nachgewiesen. Höchstwahrscheinlich sind sie von Landarbeitern infiziert worden. In einigen wenigen Fällen haben die Nerze, die von Menschen infiziert wurden, das Virus auf andere Menschen übertragen. Dies sind die ersten gemeldeten Fälle einer Übertragung von Tier zu Mensch. Es wird nach wie vor empfohlen, dass Menschen, die an COVID-19 erkrankt sind, und Menschen, die einem Risiko ausgesetzt sind, den Kontakt mit Haustieren und anderen Tieren einschränken. Bei der Handhabung und Pflege von Tieren sollten stets grundlegende Hygienemaßnahmen durchgeführt werden. Dazu gehört das Händewaschen nach dem Umgang mit Tieren, ihrem Futter oder ihren Vorräten sowie das Vermeiden von Küssen, Lecken oder Teilen von Futter."
            ],
            image: UIImage(named: "ArrowDown")!
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationTableView.dataSource = self
        informationTableView.delegate = self
        informationTableView.separatorColor = .clear
        informationTableView.rowHeight = UITableView.automaticDimension
        informationTableView.estimatedRowHeight = 600
    
        
        // header separotor
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    
    
    
    
    
    //MARK: - UITableViewDataSource and UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !sections[section].opened {
            return 0
        }
        return sections[section].cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID)
        
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.textAlignment = .left
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 17) as Any
        ]
        
        let attributeString = NSAttributedString(string: sections[indexPath.section].cellData[indexPath.row], attributes: yourAttributes)
        cell?.textLabel?.attributedText = attributeString
        
        return cell!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        informationTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Cell Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let button = ButtonWithImage()

        
        button.setImage(sections[section].image, for: .normal)

        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.darkGray.cgColor

        let yourAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont(name: "Raleway-Medium", size: 17) as Any
        ]

        let attributeString = NSMutableAttributedString(string: sections[section].title, attributes: yourAttributes)
        button.setAttributedTitle(attributeString, for: .normal)

        //Change Color while section is opened
        if sections[section].opened {
            button.backgroundColor = UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1.0)
            button.setImage(UIImage(named: "ArrowUp"), for: .normal)


            let yourAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "Raleway-Medium", size: 17) as Any
            ]

            let attributeString = NSMutableAttributedString(string: sections[section].title, attributes: yourAttributes)
            button.setAttributedTitle(attributeString, for: .normal)
        }else{
            button.backgroundColor = .clear
        }

        // Set the tag as section number
        button.tag = section
        button.addTarget(self, action: #selector(self.openSection), for: .touchUpInside)


        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 63
    }

    
    @objc func openSection(button: UIButton){
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in sections[section].cellData.indices {
            let indexPathToDelete = IndexPath(row: row , section: section)
            indexPaths.append(indexPathToDelete)
        }
        
        //Switching da opened Bool to visible the button
        let isOpen = sections[section].opened
        if isOpen {
            button.backgroundColor = UIColor(red: 255/255, green: 97/255, blue: 97/255, alpha: 1.0)
            button.setImage(UIImage(named: "ArrowUp"), for: .normal)
            
        }
        sections[section].opened = !isOpen
        
        if isOpen{
            informationTableView.deleteRows(at: indexPaths, with: .fade)
        }else{
            informationTableView.insertRows(at: indexPaths, with: .fade)
        }
    
        informationTableView.reloadData()
        
        
    }
    
    
    
}

