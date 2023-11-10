%% load data

clear;

path_to_inputFolder = "../data/";
path_to_inputDataFile = fullfile(path_to_inputFolder, 'resilience_data');
T = readtable(path_to_inputDataFile);

%% make output folder
output_folder = '../results/';

if ~exist(output_folder, 'dir')
    mkdir(output_folder)
end

%% replace NaN with 0

% study design
T.RCT(isnan(T.RCT)) = 0;
T.non_RCT(isnan(T.non_RCT)) = 0;
T.Analytical(isnan(T.Analytical)) = 0;
T.Descriptive(isnan(T.Descriptive)) = 0;

% crisis
T.Political(isnan(T.Political)) = 0;
T.Economic(isnan(T.Economic)) = 0;
T.Social(isnan(T.Social)) = 0;
T.Technological(isnan(T.Technological)) = 0;
T.Legal(isnan(T.Legal)) = 0;
T.Environmental(isnan(T.Environmental)) = 0;

% resilience characteristics
T.Adaptiveness(isnan(T.Adaptiveness)) = 0;
T.Awareness(isnan(T.Awareness)) = 0;
T.Integration(isnan(T.Integration)) = 0;
T.ResourceAvailabilityAndAccess(isnan(T.ResourceAvailabilityAndAccess)) = 0;
T.Self_regulation(isnan(T.Self_regulation)) = 0;

% continent
T.Africa(isnan(T.Africa)) = 0;
T.Asia(isnan(T.Asia)) = 0;
T.Australia(isnan(T.Australia)) = 0;
T.Europe(isnan(T.Europe)) = 0;
T.NorthAmerica(isnan(T.NorthAmerica)) = 0;
T.SouthAmerica(isnan(T.SouthAmerica)) = 0;

%% get numeric variables

% publication year
publication_years = double(T.Year);

% study design
rct = double(T.RCT);
nonrct = double(T.non_RCT);
analytical = double(T.Analytical);
descriptive = double(T.Descriptive);

% crisis
political = double(T.Political);
economic = double(T.Economic);
social = double(T.Social);
technological = double(T.Technological);
legal = double(T.Legal);
environmental = double(T.Environmental);

% resilience characteristic
adaptiveness = double(T.Adaptiveness);
awareness = double(T.Awareness);
integration = double(T.Integration);
resources = double(T.ResourceAvailabilityAndAccess);
selfregulation = double(T.Self_regulation);

% continent
africa = double(T.Africa);
asia = double(T.Asia);
australia = double(T.Australia);
europe = double(T.Europe);
northamerica = double(T.NorthAmerica);
southamerica = double(T.SouthAmerica);

%% Resilience characteristics analysis: calculate sums and percentages

adaptiveness_sum = sum(adaptiveness);
awareness_sum = sum(awareness);
integration_sum = sum(integration);
resources_sum = sum(resources);
selfregulation_sum = sum(selfregulation);

adaptiveness_pct = round((sum(adaptiveness) / length(adaptiveness)) * 100);
awareness_pct = round((sum(awareness) / length(awareness)) * 100);
integration_pct = round((sum(integration) / length(integration)) * 100);
resources_pct = round((sum(resources) / length(resources)) * 100);
selfregulation_pct = round((sum(selfregulation) / length(selfregulation)) * 100);


%% publication year: prep plot data

unique_years = sort(unique(publication_years));
unique_years_min = min(unique_years);
unique_years_max = max(unique_years);

x_year = zeros(((unique_years_max - unique_years_min) + 1), 1);
y_year = zeros(((unique_years_max - unique_years_min) + 1), 1);

yearinit = unique_years_min - 1;

for unique_year_counter = 1 : ((unique_years_max - unique_years_min) + 1)
    year = yearinit + unique_year_counter;
    x_year(unique_year_counter) = year;
    y_year(unique_year_counter) = sum(publication_years == year);
end


%% study design: prep plot data

rct_sum = sum(rct);
nonrct_sum = sum(nonrct);
analytical_sum = sum(analytical);
descriptive_sum = sum(descriptive);

x_studydesign = categorical({'Descriptive', 'Analytical', 'RCT', 'non-RCT'});
x_studydesign = reordercats(x_studydesign,{'Descriptive', 'Analytical', 'RCT', 'non-RCT'});

y_studydesign = [descriptive_sum, analytical_sum, rct_sum, nonrct_sum];


%% crisis: prep plot data

political_sum = sum(political);
economic_sum = sum(economic);
social_sum = sum(social);
technological_sum = sum(technological);
legal_sum = sum(legal);
environmental_sum = sum(environmental);

x_crisis = categorical({'Environmental', 'Social', 'Legal', 'Political', 'Economic', 'Technological'});
x_crisis = reordercats(x_crisis,{'Environmental', 'Social', 'Legal', 'Political', 'Economic', 'Technological'});

y_crisis = [environmental_sum, social_sum, legal_sum, political_sum, economic_sum, technological_sum];


%% continent: prep plot data

africa_sum = sum(africa);
asia_sum = sum(asia);
australia_sum = sum(australia);
europe_sum = sum(europe);
northamerica_sum = sum(northamerica);
southamerica_sum = sum(southamerica);

x_continent = categorical({'Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia'});
x_continent = reordercats(x_continent,{'Africa', 'Asia', 'Europe', 'North America', 'South America', 'Australia'});

y_continent = [africa_sum, asia_sum, europe_sum, northamerica_sum, southamerica_sum, australia_sum];


%% make plot

box_on_or_off = "on";

figure;

% publication year

subplot(4,1,1)

hold on;

bar(x_year, y_year)

for i=1:numel(x_year)

    if y_year(i) ~= 0
    text(x_year(i), y_year(i)+0.1, num2str(y_year(i)),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    end

end

xlabel('Publication year')
ylabel('Publication count')
xlim([unique_years_min - 0.8, unique_years_max + 0.8]);
ylim([0, (max(y_year) + 2)])
xticks(unique_years_min : 1 : unique_years_max)

plot(2015,0, 'r.', 'MarkerSize', 20)

ax = gca;
ax.Box = box_on_or_off;

hold off;

% study design

subplot(4,1,2)

bar(x_studydesign, y_studydesign)

for i=1:numel(x_studydesign)

    if y_studydesign(i) ~= 0
    text(x_studydesign(i), y_studydesign(i)+0.1, num2str(y_studydesign(i)),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    end
    
end

xlabel('Study design')
ylabel('Publication count')
ylim([0, (max(y_studydesign) + 5)])
ax = gca;
ax.Box = box_on_or_off;


% crisis

subplot(4,1,3)

bar(x_crisis, y_crisis)

for i=1:numel(x_crisis)

    if y_crisis(i) ~= 0
    text(x_crisis(i), y_crisis(i)+0.1, num2str(y_crisis(i)),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    end
    
end

xlabel('Crisis')
ylabel('Publication count')
ylim([0, (max(y_crisis) + 6)])
ax = gca;
ax.Box = box_on_or_off;


% continent

subplot(4,1,4)

bar(x_continent, y_continent)

for i=1:numel(x_continent)

    if y_continent(i) ~= 0
    text(x_continent(i), y_continent(i)+0.1, num2str(y_continent(i)),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    end
    
end

xlabel('Continent')
ylabel('Publication count')
ylim([0, (max(y_continent) + 3)])
ax = gca;
ax.Box = box_on_or_off;

fig_size_x = 12;
fig_size_y = 10;

set(gcf,...
    'Units', 'Inches', ...
    'Position', [0, 0, fig_size_x, fig_size_y], ...
    'PaperPositionMode', 'auto');

section_labels_x = 0.062;
section_labels_y = [0.955, 0.735, 0.515, 0.295];
section_labels_fontsize = 17;

a = annotation('textbox', [section_labels_x, section_labels_y(1), 0, 0], 'string', 'a.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x, section_labels_y(2), 0, 0], 'string', 'b.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x, section_labels_y(3), 0, 0], 'string', 'c.');
a.FontSize = section_labels_fontsize;

a = annotation('textbox', [section_labels_x, section_labels_y(4), 0, 0], 'string', 'd.');
a.FontSize = section_labels_fontsize;


%%
% saveas(gcf, 'resilience_figure_2', 'epsc');

fig_file_name = strcat(output_folder, 'resilience_figure_2.pdf');
exportgraphics(gcf,fig_file_name)

