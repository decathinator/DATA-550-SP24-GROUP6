here::i_am("code/03_making_plots.R")

clean_data <- readRDS(
  file = here::here ("data","data_clean.rds") 
)

library(ggplot2) 
library(tidyr)
library(dplyr)

#creating dataframes for each condition by patient type (hospitalized vs return home) for Medical History & Respiratory Health Models

#Dataframes for Model 1 Plots- Medical History

obesity_hospital <- clean_data %>% 
  filter(obesity== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "obesity", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

obesity_home <- clean_data %>% 
  filter(obesity== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "obesity", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

diabetes_hosiptal <- clean_data %>% 
  filter(diabetes== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "diabetes", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

diabetes_home <- clean_data %>% 
  filter(diabetes== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "diabetes", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

inmsupr_hospital <- clean_data %>% 
  filter(inmsupr== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "inmsupr", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

inmsupr_home <- clean_data %>% 
  filter(inmsupr== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "inmsupr", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

hipertension_hospital <- clean_data %>% 
  filter(hipertension== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "hipertension", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

hipertension_home <- clean_data %>% 
  filter(hipertension== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "hipertension", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

cardiovascular_hospital <- clean_data %>% 
  filter(cardiovascular== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "cardiovascular", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

cardiovascular_home <- clean_data %>% 
  filter(cardiovascular== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "cardiovascular", n1 = sum(classification_new==1), n0 = sum(classification_new==0))


#Dataframes for Model 2 Plots- Respiratory Health

pneumonia_hospital <- clean_data %>% 
  filter(pneumonia== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "pneumonia", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

pneumonia_home <- clean_data %>% 
  filter(pneumonia== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "pneumonia", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

tobacco_hospital <- clean_data %>% 
  filter(tobacco== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "tobacco", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

tobacco_home <- clean_data %>% 
  filter(tobacco== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "tobacco", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

asthma_hospital <- clean_data %>% 
  filter(asthma== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "asthma", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

asthma_home <- clean_data %>% 
  filter(asthma== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "asthma", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

copd_hospital <- clean_data %>% 
   filter(copd== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "copd", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

copd_home <- clean_data %>% 
    filter(copd== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "copd", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

intubed_hospital <- clean_data %>% 
  filter(intubed== "Yes", patient_type=="hospitalization") %>% 
  summarize(condition = "intubed", n1 = sum(classification_new==1), n0 = sum(classification_new==0))

intubed_home <- clean_data %>% 
  filter(intubed== "Yes", patient_type=="returned home") %>% 
  summarize(condition = "intubed", n1 = sum(classification_new==1), n0 = sum(classification_new==0))


#Plots for Medical History: Hospitalized vs Returned Home

#Hospitalized 

hospitalized_medical_history <- rbind(obesity_hospital, diabetes_hosiptal,inmsupr_hospital,
                                      hipertension_hospital, cardiovascular_hospital) %>% 
                                     pivot_longer(cols=c(n1, n0), names_to = "classification_new", values_to = "n")

#creating custom labels for plots
custom_label <- c("Negative", "Positive")  
custom_label_cond1 <- c("Cardiovascular", "Diabetes", "Hypertension", "Immunosuppressed", "Obesity")
custom_label_cond2 <- c("Asthma", "COPD", "Intubated", "Pneumonia", "Tobacco User")

MH_hospitalized <- ggplot(hospitalized_medical_history, aes(x=condition, y=n, fill=classification_new)) + 
  geom_bar(stat="identity", position="stack")+
  scale_x_discrete(labels = custom_label_cond1)+
  labs(fill = "Covid-19 Status")+
  scale_fill_manual(values = c("blue", "red"), labels= custom_label)+
  xlab('Pre-conditions') +
  ylab ("Count") +
  ggtitle("Medical History and Covid-19 Status for Hospitalized Patients") 

ggsave(here::here("output", "Medical_History_hospitalized.png"), MH_hospitalized, width = 7.5, height = 4, dpi = 300)

#sent home

home_medical_history <- rbind(obesity_home, diabetes_home, inmsupr_home,
                              hipertension_home, cardiovascular_home) %>% 
                               pivot_longer(cols=c(n1, n0), names_to = "classification_new", values_to = "n")


MH_home <- ggplot(home_medical_history, aes(x=condition, y=n, fill=classification_new)) +
  geom_bar(stat="identity", position="stack")+
  scale_x_discrete(labels = custom_label_cond1)+
  labs(fill = "Covid-19 Status")+
  scale_fill_manual(values = c("blue", "red"), labels= custom_label)+
  xlab('Pre-conditions') +
  ylab ("Count") +
  ggtitle("Medical History and Covid-19 Status for Patients Sent Home") 

ggsave(here::here("output", "Medical_History_home.png"), MH_home, width = 7.5, height = 4, dpi = 300)

#plots for respiratory health: hospitalized vs return home

# hospitalized 
hospitalized_respiratory_health <- rbind(pneumonia_hospital, tobacco_hospital, asthma_hospital,
                                         copd_hospital, intubed_hospital) %>% 
                                pivot_longer(cols=c(n1, n0), names_to = "classification_new", values_to = "n")

RH_hospitalized <- ggplot(hospitalized_respiratory_health, aes(x=condition, y=n, fill=classification_new)) + 
  geom_bar(stat="identity", position="stack")+
  scale_x_discrete(labels = custom_label_cond2)+
  labs(fill = "Covid-19 Status")+
  scale_fill_manual(values = c("blue", "red"), labels= custom_label)+
  xlab('Pre-conditions') +
  ylab ("Count") +
  ggtitle("Respiratory Health and Covid-19 Status of Hospitalized Patients") 

ggsave(here::here("output", "Respiratory_Health_hospitalized.png"), RH_hospitalized, width = 7.5, height = 4, dpi = 300)

#home 
home_respiratory_health <- rbind(pneumonia_home, tobacco_home, asthma_home,
                                  copd_home, intubed_home) %>% 
  pivot_longer(cols=c(n1, n0), names_to = "classification_new", values_to = "n")

RH_home <- ggplot(home_respiratory_health, aes(x=condition, y=n, fill=classification_new)) + 
  geom_bar(stat="identity", position="stack")+
  scale_x_discrete(labels = custom_label_cond2)+
  labs(fill = "Covid-19 Status")+
  scale_fill_manual(values = c("blue", "red"), labels= custom_label)+
  xlab('Pre-conditions') +
  ylab ("Count") +
  ggtitle("Respiratory Health and Covid-19 Status for Patients Sent Home") 

ggsave(here::here("output", "Respiratory_Health_home.png"), RH_home, width = 7.5, height = 4, dpi = 300)
