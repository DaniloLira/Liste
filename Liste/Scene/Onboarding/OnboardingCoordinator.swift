//
//  OnboardingCoordinator.swift
//  Liste
//
//  Created by Danilo on 09/11/21.
//

import Foundation
import UIKit


class OnboardingCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .onboarding
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        navigate(to: .setStudyTime)
    }
    
    func navigate(to route: Route) {
        switch route {
        case .welcome:
            createOnboardingIntroVC(
                title: "Bem vindo",
                subtitle: "Liste é um app para anotar suas tarefas de forma a respeitar sua rotina e suas necessidades",
                image: UIImage(named: "firstOnboarding"),
                nextPage: .knowYourPriorities
            )
        case .knowYourPriorities:
            createOnboardingIntroVC(
                title: "Saiba suas prioridades",
                subtitle: "O app avalia quais as tarefas devem ser feitas antes para se evitar a correria e ansiedade.",
                image: UIImage(named: "secondOnboarding"),
                nextPage: .rememberToDeliver
            )
        case .rememberToDeliver:
            createOnboardingIntroVC(
                title: "Não deixe de entregar",
                subtitle: "Cada task possui a possibilidade de ser entregável. Assim, você será lembrado com antecedência e evitará atrasos.",
                image: UIImage(named: "thirdOnboarding"),
                nextPage: .setRoutine,
                showButton: true
            )
        case .setRoutine:
            let vc = SetRoutineViewController(viewModel: .init(coordinator: self))
            navigationController.pushViewController(vc, animated: true)
            
        case .setSleepTime:  //TODO: Set views properties
            let vc = SetTimeViewController(viewModel: .init(coordinator: self))
            navigationController.pushViewController(vc, animated: true)
            
        case .setFunTime:  //TODO: Set views properties
            let vc = SetTimeViewController(viewModel: .init(coordinator: self))
            navigationController.pushViewController(vc, animated: true)
            
        case .setSportsTime:  //TODO: Set views properties
            let vc = SetTimeViewController(viewModel: .init(coordinator: self))
            navigationController.pushViewController(vc, animated: true)
            
        case .setStudyTime: //TODO: Set views properties
            let vc = SetTimeViewController(viewModel: .init(coordinator: self))
            navigationController.pushViewController(vc, animated: true)

        case .allReady:
            createOnboardingIntroVC(
                title: "Estamos prontos!",
                subtitle: "Agora é só adicionar suas tasks e organizar sua rotina!",
                image: UIImage(named: "fourthOnboarding"),
                nextPage: .welcome) //TODO: Modificar página para sair do onboarding
        
        case .dismiss:
            self.finish()
        }
    }
}

extension OnboardingCoordinator {
    func createOnboardingIntroVC(title: String,
                                 subtitle: String,
                                 image: UIImage?,
                                 nextPage: Route,
                                 showButton: Bool = false) {

        let onboardingVC = OnboardingViewController(
            viewModel: .init(coordinator: self, nextPage: nextPage),
            title: title,
            subtitle: subtitle,
            image: image,
            showButton: showButton
        )

        navigationController.pushViewController(onboardingVC, animated: true)
    }
}
extension OnboardingCoordinator {
    enum Route {
        case welcome
        case knowYourPriorities
        case rememberToDeliver
        case setRoutine
        case setSleepTime
        case setStudyTime
        case setFunTime
        case setSportsTime
        case allReady
        case dismiss
    }
}
