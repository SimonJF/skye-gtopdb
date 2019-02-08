CREATE TABLE public.accessory_protein (
    object_id integer NOT NULL,
    full_name varchar(1000)
);
CREATE TABLE public.allele (
    allele_id integer ,
    accessions varchar(100) NOT NULL,
    species_id integer ,
    pubmed_ids varchar(200),
    ontology_id integer ,
    term_id varchar(100) NOT NULL,
    allelic_composition varchar(300),
    allele_symbol varchar(300),
    genetic_background varchar(300)
);

CREATE TABLE public.altered_expression (
    altered_expression_id integer ,
    object_id integer NOT NULL,
    description varchar(10000),
    species_id integer NOT NULL,
    tissue varchar(1000),
    technique varchar(500),
    description_vector tsvector,
    tissue_vector tsvector,
    technique_vector tsvector
);

CREATE TABLE public.altered_expression_refs (
    altered_expression_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.analogue_cluster (
    ligand_id integer NOT NULL,
    cluster varchar(10) NOT NULL
);
CREATE TABLE public.associated_protein (
    associated_protein_id integer ,
    object_id integer NOT NULL,
    name varchar(1000),
    type varchar(200) NOT NULL,
    associated_object_id integer,
    effect varchar(1000),
    name_vector tsvector
);
CREATE TABLE public.associated_protein_refs (
    associated_protein_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.binding_partner (
    binding_partner_id integer ,
    object_id integer NOT NULL,
    name varchar(300) NOT NULL,
    interaction varchar(200),
    effect varchar(2000),
    partner_object_id integer,
    name_vector tsvector,
    effect_vector tsvector,
    interaction_vector tsvector
);
CREATE TABLE public.binding_partner_refs (
    binding_partner_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.catalytic_receptor (
    object_id integer NOT NULL,
    rtk_class varchar(20)
);
CREATE TABLE public.celltype_assoc (
    celltype_assoc_id integer ,
    object_id integer NOT NULL,
    immuno_celltype_id integer NOT NULL,
    comment varchar(500),
    comment_vector tsvector
);
CREATE TABLE public.celltype_assoc_colist (
    celltype_assoc_id integer NOT NULL,
    co_celltype_id integer NOT NULL,
    cellonto_id varchar(50)
);
CREATE TABLE public.celltype_assoc_refs (
    celltype_assoc_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.cellular_location (
    cellular_location_id integer ,
    object_id integer NOT NULL,
    location varchar(500),
    technique varchar(500),
    comments varchar(1000)
);
CREATE TABLE public.cellular_location_refs (
    cellular_location_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.chembl_cluster (
    object_id integer NOT NULL,
    chembl_id varchar(50) NOT NULL,
    cluster varchar(10) NOT NULL,
    cluster_family varchar(10) NOT NULL
);
CREATE TABLE public.co_celltype (
    co_celltype_id integer ,
    name varchar(1000) NOT NULL,
    definition varchar(1500) NOT NULL,
    last_modified date,
    type varchar(50) NOT NULL,
    cellonto_id varchar(50) NOT NULL,
    name_vector tsvector,
    definition_vector tsvector,
    cellonto_id_vector tsvector
);
CREATE TABLE public.co_celltype_isa (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);
CREATE TABLE public.co_celltype_relationship (
    co_celltype_rel_id integer ,
    co_celltype_id integer NOT NULL,
    relationship_id varchar(50) NOT NULL,
    type varchar(100)
);
CREATE TABLE public.cofactor (
    cofactor_id integer ,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    ligand_id integer,
    name varchar(1000),
    comments varchar(1000),
    in_iuphar boolean ,
    in_grac boolean ,
    name_vector tsvector
);
CREATE TABLE public.cofactor_refs (
    cofactor_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.committee (
    committee_id integer NOT NULL,
    name varchar(1000) NOT NULL,
    description varchar(2000),
    family_id integer
);
CREATE TABLE public.conductance (
    conductance_id integer ,
    object_id integer NOT NULL,
    overall_channel_conductance varchar(500),
    macroscopic_current_rectification varchar(100),
    single_channel_current_rectification varchar(100),
    species_id integer NOT NULL
);
CREATE TABLE public.conductance_refs (
    conductance_id integer NOT NULL,
    reference_id integer NOT NULL
);
CREATE TABLE public.conductance_states (
    conductance_states_id integer ,
    object_id integer NOT NULL,
    receptor varchar(100) NOT NULL,
    state1_high double precision,
    state1_low double precision,
    state2_high double precision,
    state2_low double precision,
    state3_high double precision,
    state3_low double precision,
    state4_high double precision,
    state4_low double precision,
    state5_high double precision,
    state5_low double precision,
    state6_high double precision,
    state6_low double precision,
    most_frequent_state varchar(50)
);

CREATE TABLE public.conductance_states_refs (
    conductance_states_id integer NOT NULL,
    reference_id integer NOT NULL
);


CREATE TABLE public.contributor (
    contributor_id integer ,
    address text,
    email varchar(500),
    first_names varchar(500) NOT NULL,
    surname varchar(500) NOT NULL,
    suffix varchar(200),
    note varchar(1000),
    orcid varchar(100),
    country varchar(50),
    description varchar(1000),
    institution varchar(1000),
    name_vector tsvector
);

CREATE TABLE public.contributor2committee (
    contributor_id integer NOT NULL,
    committee_id integer NOT NULL,
    role varchar(200),
    display_order integer
);

CREATE TABLE public.contributor2family (
    contributor_id integer NOT NULL,
    family_id integer NOT NULL,
    role varchar(50),
    display_order integer,
    old_display_order integer
);

CREATE TABLE public.contributor2intro (
    contributor_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer NOT NULL
);

CREATE TABLE public.contributor2object (
    contributor_id integer NOT NULL,
    object_id integer NOT NULL,
    display_order integer
);

CREATE TABLE public.contributor_copy (
    contributor_id integer,
    address text,
    email varchar(500),
    first_names varchar(500),
    surname varchar(500),
    suffix varchar(200),
    note varchar(1000),
    orcid varchar(100),
    country varchar(50),
    description varchar(1000),
    institution varchar(1000)
);

CREATE TABLE public.contributor_link (
    contributor_id integer NOT NULL,
    url varchar(500) NOT NULL
);


CREATE TABLE public.coregulator (
    coregulator_id integer ,
    object_id integer NOT NULL,
    activity varchar(500),
    specific boolean,
    ligand_dependent boolean ,
    af2_dependent boolean,
    comments varchar(2000),
    coregulator_gene_id integer,
    activity_vector tsvector,
    comments_vector tsvector
);


CREATE TABLE public.coregulator_gene (
    coregulator_gene_id integer ,
    primary_name varchar(300) NOT NULL,
    official_gene_id varchar(100),
    other_names varchar(1000),
    species_id integer NOT NULL,
    nursa_id varchar(100),
    comments varchar(2000),
    gene_long_name varchar(2000),
    primary_name_vector tsvector,
    other_names_vector tsvector,
    comments_vector tsvector,
    gene_long_name_vector tsvector
);

CREATE TABLE public.coregulator_refs (
    coregulator_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.database (
    database_id integer ,
    name varchar(100) NOT NULL,
    url text,
    specialist boolean ,
    prefix varchar(100)
);


CREATE TABLE public.database_link (
    database_link_id integer ,
    object_id integer NOT NULL,
    species_id integer ,
    database_id integer NOT NULL,
    placeholder varchar(100) NOT NULL
);

CREATE TABLE public.deleted_family (
    family_id integer NOT NULL,
    name varchar(1000) NOT NULL,
    previous_names varchar(300),
    type varchar(25) NOT NULL,
    old_family_id integer,
    new_family_id integer
);

CREATE TABLE public.discoverx (
    cat_no varchar(100) NOT NULL,
    url varchar(500) NOT NULL,
    name varchar(500) NOT NULL,
    description varchar(1000) NOT NULL,
    species_id integer NOT NULL
);

CREATE TABLE public.disease (
    disease_id integer ,
    name varchar(1000) NOT NULL,
    description text,
    type varchar(30) ,
    name_vector tsvector,
    description_vector tsvector
);

CREATE TABLE public.disease2category (
    disease_id integer NOT NULL,
    disease_category_id integer NOT NULL,
    comment varchar(500)
);


CREATE TABLE public.disease2synonym (
    disease2synonym_id integer ,
    disease_id integer NOT NULL,
    synonym varchar(1000) NOT NULL,
    synonym_vector tsvector
);


CREATE TABLE public.disease_category (
    disease_category_id integer ,
    name varchar(1000) NOT NULL,
    description text
);


CREATE TABLE public.disease_database_link (
    disease_database_link_id integer ,
    disease_id integer NOT NULL,
    database_id integer NOT NULL,
    placeholder varchar(100) NOT NULL
);

CREATE TABLE public.disease_synonym2database_link (
    disease2synonym_id integer NOT NULL,
    disease_database_link_id integer NOT NULL
);


CREATE TABLE public.dna_binding (
    dna_binding_id integer ,
    object_id integer NOT NULL,
    structure varchar(500),
    sequence varchar(100),
    response_element varchar(500),
    structure_vector tsvector,
    sequence_vector tsvector,
    response_element_vector tsvector
);

CREATE TABLE public.dna_binding_refs (
    dna_binding_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.do_disease (
    do_disease_id integer ,
    term varchar(1000) NOT NULL,
    definition varchar(1500) NOT NULL,
    last_modified date,
    do_id varchar(50) NOT NULL
);

CREATE TABLE public.do_disease_isa (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);

CREATE TABLE public.drug2disease (
    ligand_id integer NOT NULL,
    disease_id integer NOT NULL
);

CREATE TABLE public.enzyme (
    object_id integer NOT NULL
);


CREATE TABLE public.expression_experiment (
    expression_experiment_id integer ,
    description varchar(1000),
    technique varchar(100),
    species_id integer NOT NULL,
    baseline double precision NOT NULL
);

CREATE TABLE public.expression_level (
    structural_info_id integer NOT NULL,
    tissue_id integer NOT NULL,
    expression_experiment_id integer NOT NULL,
    value double precision NOT NULL
);


CREATE TABLE public.expression_pathophysiology (
    expression_pathophysiology_id integer ,
    object_id integer NOT NULL,
    change text,
    pathophysiology text,
    species_id integer NOT NULL,
    tissue varchar(1000),
    technique varchar(500),
    change_vector tsvector,
    tissue_vector tsvector,
    pathophysiology_vector tsvector,
    technique_vector tsvector
);

CREATE TABLE public.expression_pathophysiology_refs (
    expression_pathophysiology_id integer NOT NULL,
    reference_id integer NOT NULL
);


CREATE TABLE public.family (
    family_id integer ,
    name varchar(1000) NOT NULL,
    last_modified date,
    old_family_id integer,
    type varchar(50) NOT NULL,
    display_order integer,
    annotation_status integer ,
    previous_names varchar(300),
    only_grac boolean,
    only_iuphar boolean,
    in_cgtp boolean ,
    name_vector tsvector,
    previous_names_vector tsvector
);


CREATE TABLE public.functional_assay (
    functional_assay_id integer ,
    object_id integer NOT NULL,
    description varchar(1000) NOT NULL,
    response_measured varchar(1000) NOT NULL,
    species_id integer NOT NULL,
    tissue varchar(1000) NOT NULL,
    description_vector tsvector,
    tissue_vector tsvector,
    response_vector tsvector
);

CREATE TABLE public.functional_assay_refs (
    functional_assay_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.further_reading (
    object_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.go_process (
    go_process_id integer ,
    term varchar(1000) NOT NULL,
    definition varchar(1500) NOT NULL,
    last_modified date,
    annotation varchar(200) NOT NULL,
    go_id varchar(50) NOT NULL,
    term_vector tsvector,
    definition_vector tsvector,
    go_id_vector tsvector
);

CREATE TABLE public.go_process_rel (
    parent_id integer NOT NULL,
    child_id integer NOT NULL
);

CREATE TABLE public.gpcr (
    object_id integer NOT NULL,
    class varchar(200),
    ligand varchar(500)
);

CREATE TABLE public.grac_family_text (
    family_id integer NOT NULL,
    overview text,
    comments text,
    last_modified date,
    overview_vector tsvector,
    comments_vector tsvector
);

CREATE TABLE public.grac_functional_characteristics (
    object_id integer NOT NULL,
    functional_characteristics text NOT NULL,
    functional_characteristics_vector tsvector
);

CREATE TABLE public.grac_further_reading (
    family_id integer NOT NULL,
    reference_id integer NOT NULL,
    key_ref boolean DEFAULT false NOT NULL
);


CREATE TABLE public.grac_ligand_rank_potency (
    grac_ligand_rank_potency_id integer ,
    object_id integer NOT NULL,
    description varchar(500) NOT NULL,
    rank_potency varchar(2000) NOT NULL,
    species_id integer NOT NULL,
    in_iuphar boolean ,
    rank_potency_vector tsvector
);

CREATE TABLE public.grac_ligand_rank_potency_refs (
    grac_ligand_rank_potency_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.grac_transduction (
    object_id integer NOT NULL,
    transduction varchar(1000) NOT NULL
);

CREATE TABLE public."grouping" (
    group_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer DEFAULT 1 NOT NULL
);



CREATE TABLE public.gtip2go_process (
    gtip_process_id integer NOT NULL,
    go_process_id integer NOT NULL,
    comment varchar(500),
    go_id varchar(15),
    go_term varchar(500)
);


CREATE TABLE public.gtip_process (
    gtip_process_id integer ,
    term varchar(1000) NOT NULL,
    definition varchar(1500) NOT NULL,
    last_modified date,
    short_term varchar(500),
    anchor varchar(10),
    term_vector tsvector,
    definition_vector tsvector
);




-- SJF: Note that I've renamed `date` to `topic_date`
CREATE TABLE public.hottopic_refs (
    reference_id integer NOT NULL,
    type varchar(50) NOT NULL,
    topic_date date NOT NULL
);



CREATE TABLE public.immuno2co_celltype (
    immuno_celltype_id integer NOT NULL,
    cellonto_id varchar(50) NOT NULL,
    comment varchar(500)
);


CREATE TABLE public.immuno_celltype (
    immuno_celltype_id integer ,
    term varchar(1000) NOT NULL,
    definition varchar(2500) NOT NULL,
    last_modified date,
    short_term varchar(500),
    term_vector tsvector,
    definition_vector tsvector
);



CREATE TABLE public.immuno_disease2ligand (
    immuno_disease2ligand_id integer ,
    ligand_id integer NOT NULL,
    disease_id integer,
    comment varchar(500),
    immuno boolean ,
    comment_vector tsvector
);



CREATE TABLE public.immuno_disease2ligand_refs (
    immuno_disease2ligand_id integer NOT NULL,
    reference_id integer NOT NULL
);


CREATE TABLE public.immuno_disease2object (
    immuno_disease2object_id integer ,
    object_id integer NOT NULL,
    disease_id integer,
    comment varchar(500),
    immuno boolean ,
    comment_vector tsvector
);



CREATE TABLE public.immuno_disease2object_refs (
    immuno_disease2object_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.immunopaedia2family (
    immunopaedia_case_id integer NOT NULL,
    family_id integer NOT NULL,
    section varchar(50) NOT NULL,
    url varchar(150),
    comment varchar(500)
);

CREATE TABLE public.immunopaedia2ligand (
    immunopaedia_case_id integer NOT NULL,
    ligand_id integer NOT NULL,
    section varchar(50) NOT NULL,
    url varchar(150),
    comment varchar(500)
);

CREATE TABLE public.immunopaedia2object (
    immunopaedia_case_id integer NOT NULL,
    object_id integer NOT NULL,
    section varchar(50) NOT NULL,
    url varchar(150),
    comment varchar(500)
);


CREATE TABLE public.immunopaedia_cases (
    immunopaedia_case_id integer ,
    title varchar(1000) NOT NULL,
    url varchar(150) NOT NULL,
    last_modified date,
    short_title varchar(500)
);



CREATE TABLE public.inn (
    inn_number integer NOT NULL,
    inn varchar(500) NOT NULL,
    cas varchar(100),
    smiles text,
    smiles_salts_stripped text,
    inchi_key_salts_stripped varchar(500),
    nonisomeric_smiles_salts_stripped text,
    nonisomeric_inchi_key_salts_stripped varchar(500),
    neutralised_smiles text,
    neutralised_inchi_key varchar(500),
    neutralised_nonisomeric_smiles text,
    neutralised_nonisomeric_inchi_key varchar(500),
    inn_vector tsvector
);


CREATE TABLE public.interaction (
    interaction_id integer ,
    ligand_id integer NOT NULL,
    object_id integer,
    type varchar(100) NOT NULL,
    action varchar(1000) NOT NULL,
    action_comment varchar(2000),
    species_id integer NOT NULL,
    endogenous boolean ,
    selective boolean ,
    use_dependent boolean,
    voltage_dependent boolean,
    affinity_units varchar(100) ,
    affinity_high double precision,
    affinity_median double precision,
    affinity_low double precision,
    concentration_range varchar(200),
    affinity_voltage_high real,
    affinity_voltage_median real,
    affinity_voltage_low real,
    affinity_physiological_voltage boolean,
    rank integer,
    selectivity varchar(100),
    original_affinity_low_nm double precision,
    original_affinity_median_nm double precision,
    original_affinity_high_nm double precision,
    original_affinity_units varchar(20),
    original_affinity_relation varchar(10),
    assay_description varchar(1000),
    assay_conditions varchar(1000),
    from_grac boolean ,
    only_grac boolean ,
    receptor_site varchar(300),
    ligand_context varchar(300),
    percent_activity double precision,
    assay_url varchar(500),
    primary_target boolean,
    target_ligand_id integer,
    whole_organism_assay boolean,
    hide boolean ,
    type_vector tsvector
);



CREATE TABLE public.interaction_affinity_refs (
    interaction_id integer NOT NULL,
    reference_id integer NOT NULL
);

-- SJF: Note that I've renamed "text" to "txt" here
CREATE TABLE public.introduction (
    family_id integer NOT NULL,
    txt text NOT NULL,
    last_modified date,
    annotation_status integer ,
    no_contributor_list boolean ,
    intro_vector tsvector
);

CREATE TABLE public.iuphar2discoverx (
    object_id integer NOT NULL,
    cat_no varchar(100) NOT NULL
);

CREATE TABLE public.iuphar2tocris (
    ligand_id integer NOT NULL,
    cat_no varchar(100) NOT NULL,
    exact boolean
);

CREATE TABLE public.lgic (
    object_id integer NOT NULL,
    ligand varchar(500),
    selectivity_comments text
);


CREATE TABLE public.ligand (
    ligand_id integer ,
    name varchar(1000) NOT NULL,
    pubchem_sid bigint,
    radioactive boolean ,
    old_ligand_id integer,
    type varchar(50) ,
    approved boolean,
    approved_source varchar(100),
    iupac_name varchar(1000),
    comments varchar(4000),
    withdrawn_drug boolean,
    verified boolean,
    abbreviation varchar(300),
    clinical_use text,
    mechanism_of_action text,
    absorption_distribution text,
    metabolism text,
    elimination text,
    popn_pharmacokinetics text,
    organ_function_impairment text,
    emc_url varchar(1000),
    drugs_url varchar(1000),
    ema_url varchar(1000),
    bioactivity_comments text,
    labelled boolean,
    in_gtip boolean,
    immuno_comments text,
    in_gtmp boolean,
    gtmp_comments text,
    name_vector tsvector,
    comments_vector tsvector,
    abbreviation_vector tsvector,
    clinical_use_vector tsvector,
    mechanism_of_action_vector tsvector,
    absorption_distribution_vector tsvector,
    metabolism_vector tsvector,
    elimination_vector tsvector,
    popn_pharmacokinetics_vector tsvector,
    organ_function_impairment_vector tsvector,
    bioactivity_comments_vector tsvector,
    immuno_comments_vector tsvector
);





CREATE TABLE public.ligand2family (
    ligand_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer NOT NULL
);

CREATE TABLE public.ligand2inn (
    ligand_id integer NOT NULL,
    inn_number integer NOT NULL
);

CREATE TABLE public.ligand2meshpharmacology (
    ligand_id integer NOT NULL,
    mesh_term varchar(1000) NOT NULL,
    type varchar(100) NOT NULL
);

CREATE TABLE public.ligand2subunit (
    ligand_id integer NOT NULL,
    subunit_id integer NOT NULL
);

CREATE TABLE public.ligand2synonym (
    ligand_id integer NOT NULL,
    synonym varchar(2000) NOT NULL,
    from_grac boolean ,
    ligand2synonym_id integer ,
    display boolean ,
    synonym_vector tsvector
);

CREATE TABLE public.ligand2synonym_refs (
    ligand2synonym_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.ligand_cluster (
    ligand_id integer NOT NULL,
    cluster varchar(100) NOT NULL,
    distance double precision NOT NULL,
    cluster_centre integer NOT NULL
);

CREATE SEQUENCE public.ligand_database_link_ligand_database_link_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.ligand_database_link (
    ligand_database_link_id integer ,
    ligand_id integer NOT NULL,
    database_id integer NOT NULL,
    placeholder varchar(100) NOT NULL,
    source varchar(100),
    commercial boolean ,
    species_id integer DEFAULT 9 NOT NULL
);

CREATE TABLE public.ligand_physchem (
    ligand_id integer NOT NULL,
    hydrogen_bond_acceptors integer NOT NULL,
    hydrogen_bond_donors integer NOT NULL,
    rotatable_bonds_count integer NOT NULL,
    topological_polar_surface_area double precision NOT NULL,
    molecular_weight double precision NOT NULL,
    xlogp double precision NOT NULL,
    lipinski_s_rule_of_five integer NOT NULL
);

CREATE TABLE public.ligand_physchem_public (
    ligand_id integer NOT NULL,
    hydrogen_bond_acceptors integer NOT NULL,
    hydrogen_bond_donors integer NOT NULL,
    rotatable_bonds_count integer NOT NULL,
    topological_polar_surface_area double precision NOT NULL,
    molecular_weight double precision NOT NULL,
    xlogp double precision NOT NULL,
    lipinski_s_rule_of_five integer NOT NULL
);

CREATE TABLE public.ligand_structure (
    ligand_id integer NOT NULL,
    isomeric_smiles text NOT NULL,
    isomeric_standard_inchi text,
    isomeric_standard_inchi_key varchar(300) NOT NULL,
    nonisomeric_smiles text NOT NULL,
    nonisomeric_standard_inchi text,
    nonisomeric_standard_inchi_key varchar(300) NOT NULL
);

CREATE TABLE public.list_ligand (
    object_id integer NOT NULL,
    ligand_id integer NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);

CREATE SEQUENCE public.malaria_stage_malaria_stage_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.malaria_stage (
    malaria_stage_id integer ,
    name varchar(300) NOT NULL,
    description varchar(20),
    short_name varchar(20)
);

CREATE TABLE public.malaria_stage2interaction (
    interaction_id integer NOT NULL,
    malaria_stage_id integer NOT NULL
);

CREATE TABLE public.multimer (
    object_id integer NOT NULL,
    subunit_specific_agents_comments text
);

CREATE SEQUENCE public.mutation_mutation_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.mutation (
    mutation_id integer ,
    pathophysiology_id integer,
    object_id integer NOT NULL,
    type varchar(100) NOT NULL,
    amino_acid_change varchar(100),
    species_id integer NOT NULL,
    description varchar(1000),
    nucleotide_change varchar(100)
);

CREATE TABLE public.mutation_refs (
    mutation_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.nhr (
    object_id integer NOT NULL,
    ligand varchar(500),
    binding_partner_comments text,
    coregulator_comments text,
    dna_binding_comments text,
    target_gene_comments text
);

CREATE SEQUENCE public.object_object_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.object (
    object_id integer ,
    name varchar(1000) NOT NULL,
    last_modified date,
    comments text,
    structural_info_comments text,
    old_object_id integer,
    annotation_status integer ,
    only_iuphar boolean,
    grac_comments text,
    only_grac boolean,
    no_contributor_list boolean ,
    abbreviation varchar(100),
    systematic_name varchar(100),
    quaternary_structure_comments text,
    in_cgtp boolean ,
    in_gtip boolean ,
    gtip_comment text,
    in_gtmp boolean ,
    gtmp_comment text
);









CREATE SEQUENCE public.object2celltype_object2celltype_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.object2go_process (
    object_id integer NOT NULL,
    go_process_id integer NOT NULL,
    go_evidence varchar(5),
    comment varchar(500),
    comment_vector tsvector
);

CREATE TABLE public.object2reaction (
    object_id integer NOT NULL,
    reaction_id integer NOT NULL
);

CREATE TABLE public.object_vectors (
    object_id integer NOT NULL,
    name tsvector,
    abbreviation tsvector,
    comments tsvector,
    grac_comments tsvector,
    gtip_comments tsvector,
    structural_info_comments tsvector,
    associated_proteins_comments tsvector,
    functional_assay_comments tsvector,
    tissue_distribution_comments tsvector,
    functions_comments tsvector,
    altered_expression_comments tsvector,
    expression_pathophysiology_comments tsvector,
    mutations_pathophysiology_comments tsvector,
    variants_comments tsvector,
    xenobiotic_expression_comments tsvector,
    antibody_comments tsvector,
    agonists_comments tsvector,
    antagonists_comments tsvector,
    allosteric_modulators_comments tsvector,
    activators_comments tsvector,
    inhibitors_comments tsvector,
    channel_blockers_comments tsvector,
    gating_inhibitors_comments tsvector,
    subunit_specific_agents_comments tsvector,
    selectivity_comments tsvector,
    voltage_dependence_comments tsvector,
    target_gene_comments tsvector,
    dna_binding_comments tsvector,
    coregulator_comments tsvector,
    binding_partner_comments tsvector
);

CREATE SEQUENCE public.ontology_ontology_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.ontology (
    ontology_id integer ,
    name varchar(100) NOT NULL,
    short_name varchar(100)
);

CREATE TABLE public.ontology_term (
    ontology_id integer ,
    term_id varchar(100) NOT NULL,
    term varchar(1000),
    description varchar(3000)
);

CREATE TABLE public.other_ic (
    object_id integer NOT NULL,
    selectivity_comments text
);

CREATE TABLE public.other_protein (
    object_id integer NOT NULL
);

CREATE SEQUENCE public.pathophysiology_pathophysiology_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.pathophysiology (
    pathophysiology_id integer ,
    object_id integer NOT NULL,
    disease varchar(2000),
    role varchar(2000),
    drugs varchar(2000),
    side_effects varchar(2000),
    use varchar(2000),
    omim varchar(200),
    comments text,
    orphanet varchar(200),
    disease_id integer,
    role_vector tsvector,
    drugs_vector tsvector,
    side_effects_vector tsvector,
    use_vector tsvector,
    comments_vector tsvector
);

CREATE TABLE public.pathophysiology_refs (
    pathophysiology_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.pdb_structure_pdb_structure_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.pdb_structure (
    pdb_structure_id integer ,
    object_id integer NOT NULL,
    ligand_id integer,
    endogenous boolean ,
    pdb_code varchar(4),
    description varchar(1000),
    resolution double precision,
    species_id integer NOT NULL,
    description_vector tsvector
);

CREATE TABLE public.pdb_structure_refs (
    pdb_structure_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.peptide (
    ligand_id integer NOT NULL,
    one_letter_seq text,
    three_letter_seq text,
    post_translational_modifications varchar(1000),
    chemical_modifications varchar(1000),
    medical_relevance varchar(2000)
);

CREATE TABLE public.peptide_ligand_cluster (
    ligand_id integer NOT NULL,
    cluster varchar(10)
);

CREATE TABLE public.peptide_ligand_sequence_cluster (
    ligand_id integer NOT NULL,
    cluster integer NOT NULL
);

CREATE SEQUENCE public.physiological_function_physiological_function_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.physiological_function (
    physiological_function_id integer ,
    object_id integer NOT NULL,
    description text NOT NULL,
    species_id integer NOT NULL,
    tissue text NOT NULL,
    description_vector tsvector,
    tissue_vector tsvector
);

CREATE TABLE public.physiological_function_refs (
    physiological_function_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.precursor_precursor_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.precursor (
    precursor_id integer ,
    gene_name varchar(100),
    official_gene_id varchar(100),
    protein_name varchar(200),
    species_id integer NOT NULL,
    gene_long_name varchar(2000),
    protein_name_vector tsvector,
    gene_long_name_vector tsvector
);

CREATE TABLE public.precursor2peptide (
    precursor_id integer NOT NULL,
    ligand_id integer NOT NULL
);

CREATE SEQUENCE public.precursor2synonym_precursor2synonym_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.precursor2synonym (
    precursor2synonym_id integer ,
    precursor_id integer NOT NULL,
    synonym varchar(2000) NOT NULL,
    synonym_vector tsvector
);

CREATE SEQUENCE public.primary_regulator_primary_regulator_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.primary_regulator (
    primary_regulator_id integer ,
    object_id integer NOT NULL,
    name varchar(1000),
    regulatory_effect varchar(2000),
    regulator_object_id integer
);

CREATE TABLE public.primary_regulator_refs (
    primary_regulator_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.process_assoc_process_assoc_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.process_assoc (
    object_id integer NOT NULL,
    gtip_process_id integer NOT NULL,
    comment varchar(500),
    direct_annotation boolean ,
    go_annotation integer ,
    process_assoc_id integer ,
    comment_vector tsvector
);



CREATE TABLE public.process_assoc_refs (
    process_assoc_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.prodrug (
    prodrug_ligand_id integer NOT NULL,
    drug_ligand_id integer NOT NULL
);

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.product (
    product_id integer ,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    ligand_id integer,
    name varchar(1000),
    endogenous boolean ,
    in_iuphar boolean ,
    in_grac boolean ,
    name_vector tsvector
);

CREATE TABLE public.product_refs (
    product_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.reaction_reaction_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.reaction (
    reaction_id integer ,
    ec_number varchar(50) NOT NULL,
    reaction varchar(3000)
);

CREATE SEQUENCE public.reaction_component_reaction_component_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE SEQUENCE public.reaction_mechanism_reaction_mechanism_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.receptor2family (
    object_id integer NOT NULL,
    family_id integer NOT NULL,
    display_order integer NOT NULL
);

CREATE TABLE public.receptor2subunit (
    receptor_id integer NOT NULL,
    subunit_id integer NOT NULL,
    type varchar(200)
);

CREATE TABLE public.receptor_basic (
    object_id integer NOT NULL,
    list_comments varchar(1000),
    associated_proteins_comments text,
    functional_assay_comments text,
    tissue_distribution_comments text,
    functions_comments text,
    altered_expression_comments text,
    expression_pathophysiology_comments text,
    mutations_pathophysiology_comments text,
    variants_comments text,
    xenobiotic_expression_comments text,
    antibody_comments text,
    agonists_comments text,
    antagonists_comments text,
    allosteric_modulators_comments text,
    activators_comments text,
    inhibitors_comments text,
    channel_blockers_comments text,
    gating_inhibitors_comments text
);

CREATE SEQUENCE public.reference_reference_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.reference (
    reference_id integer ,
    type varchar(50) NOT NULL,
    title varchar(2000),
    article_title varchar(1000) NOT NULL,
    year smallint,
    issue varchar(50),
    volume varchar(50),
    pages varchar(50),
    publisher varchar(500),
    publisher_address varchar(2000),
    editors varchar(2000),
    pubmed_id bigint,
    isbn varchar(13),
    pub_status varchar(100),
    topics varchar(250),
    comments varchar(500),
    read boolean,
    useful boolean,
    website varchar(500),
    url varchar(2000),
    doi varchar(500),
    accessed date,
    modified date,
    patent_number varchar(250),
    priority date,
    publication date,
    authors text,
    assignee varchar(500),
    authors_vector tsvector,
    article_title_vector tsvector
);

CREATE TABLE public.reference2immuno (
    reference_id integer NOT NULL,
    type varchar(50) NOT NULL
);



CREATE TABLE public.reference2ligand (
    reference_id integer NOT NULL,
    ligand_id integer NOT NULL
);

CREATE SEQUENCE public.screen_screen_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.screen (
    screen_id integer ,
    name varchar(500) NOT NULL,
    description text,
    url varchar(1000),
    affinity_cut_off_nm integer,
    company_logo_filename varchar(250),
    technology_logo_filename varchar(250)
);

CREATE SEQUENCE public.screen_interaction_screen_interaction_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.screen_interaction (
    screen_interaction_id integer ,
    screen_id integer NOT NULL,
    ligand_id integer NOT NULL,
    object_id integer NOT NULL,
    type varchar(100) NOT NULL,
    action varchar(1000) NOT NULL,
    action_comment varchar(2000) NOT NULL,
    species_id integer NOT NULL,
    endogenous boolean ,
    affinity_units varchar(100) ,
    affinity_high double precision,
    affinity_median double precision,
    affinity_low double precision,
    concentration_range varchar(200),
    original_affinity_low_nm double precision,
    original_affinity_median_nm double precision,
    original_affinity_high_nm double precision,
    original_affinity_units varchar(20),
    original_affinity_relation varchar(10),
    assay_description varchar(1000),
    percent_activity double precision,
    assay_url varchar(500)
);

CREATE TABLE public.screen_refs (
    screen_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.selectivity_selectivity_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.selectivity (
    selectivity_id integer ,
    object_id integer NOT NULL,
    ion varchar(20) NOT NULL,
    conductance_high real,
    conductance_low real,
    conductance_median real,
    hide_conductance boolean,
    species_id integer NOT NULL
);

CREATE TABLE public.selectivity_refs (
    selectivity_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.species_species_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.species (
    species_id integer ,
    name varchar(100) NOT NULL,
    short_name varchar(15) NOT NULL,
    scientific_name varchar(200),
    ncbi_taxonomy_id integer,
    comments text,
    description text
);



CREATE SEQUENCE public.specific_reaction_specific_reaction_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.specific_reaction (
    specific_reaction_id integer ,
    object_id integer NOT NULL,
    reaction_id integer NOT NULL,
    description varchar(1000),
    reaction varchar(3000) NOT NULL
);



CREATE TABLE public.specific_reaction_refs (
    specific_reaction_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.structural_info_structural_info_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.structural_info (
    structural_info_id integer ,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    transmembrane_domains integer,
    amino_acids integer,
    pore_loops integer,
    genomic_location varchar(50),
    gene_name varchar(100),
    official_gene_id varchar(100),
    molecular_weight integer,
    gene_long_name varchar(2000),
    gene_long_name_vector tsvector
);

CREATE TABLE public.structural_info_refs (
    structural_info_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.subcommittee (
    contributor_id integer NOT NULL,
    family_id integer NOT NULL,
    role varchar(50),
    display_order integer NOT NULL
);

CREATE SEQUENCE public.substrate_substrate_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.substrate (
    substrate_id integer ,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    ligand_id integer,
    property varchar(20) ,
    value double precision,
    units varchar(100),
    assay_description varchar(1000),
    assay_conditions varchar(1000),
    comments varchar(1000),
    name varchar(1000),
    endogenous boolean ,
    in_iuphar boolean ,
    in_grac boolean ,
    standard_property varchar(100) ,
    standard_value double precision,
    name_vector tsvector
);

CREATE TABLE public.substrate_refs (
    substrate_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.synonym_synonym_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.synonym (
    synonym_id integer ,
    object_id integer NOT NULL,
    synonym varchar(2000) NOT NULL,
    display boolean ,
    from_grac boolean ,
    display_order integer ,
    synonym_vector tsvector
);

CREATE TABLE public.synonym_refs (
    synonym_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.target_gene_target_gene_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.target_gene (
    target_gene_id integer ,
    object_id integer NOT NULL,
    species_id integer NOT NULL,
    description varchar(1000),
    official_gene_id varchar(100),
    effect varchar(300),
    technique varchar(500),
    comments varchar(2000),
    description_vector tsvector,
    effect_vector tsvector,
    technique_vector tsvector,
    comments_vector tsvector
);

CREATE TABLE public.target_gene_refs (
    target_gene_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.target_ligand_same_entity (
    object_id integer NOT NULL,
    ligand_id integer NOT NULL
);

CREATE SEQUENCE public.tissue_tissue_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.tissue (
    tissue_id integer ,
    name varchar(100) NOT NULL
);

CREATE SEQUENCE public.tissue_distribution_tissue_distribution_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.tissue_distribution (
    tissue_distribution_id integer ,
    object_id integer NOT NULL,
    tissues varchar(10000) NOT NULL,
    species_id integer NOT NULL,
    technique varchar(1000),
    expression_level integer,
    tissues_vector tsvector,
    technique_vector tsvector
);

CREATE TABLE public.tissue_distribution_refs (
    tissue_distribution_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.tocris (
    cat_no varchar(100) NOT NULL,
    url varchar(500) NOT NULL,
    name varchar(1000),
    smiles varchar(2000),
    pubchem_cid varchar(100)
);

CREATE SEQUENCE public.transduction_transduction_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.transduction (
    transduction_id integer ,
    object_id integer NOT NULL,
    secondary boolean NOT NULL,
    t01 boolean ,
    t02 boolean ,
    t03 boolean ,
    t04 boolean ,
    t05 boolean ,
    t06 boolean ,
    e01 boolean ,
    e02 boolean ,
    e03 boolean ,
    e04 boolean ,
    e05 boolean ,
    e06 boolean ,
    e07 boolean ,
    e08 boolean ,
    e09 boolean ,
    comments varchar(10000),
    comments_vector tsvector
);

CREATE TABLE public.transduction_refs (
    transduction_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.transporter (
    object_id integer NOT NULL,
    grac_stoichiometry varchar(1000),
    grac_stoichiometry_vector tsvector
);

CREATE SEQUENCE public.variant_variant_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.variant (
    variant_id integer ,
    object_id integer NOT NULL,
    description varchar(2000),
    type varchar(100),
    species_id integer NOT NULL,
    amino_acids integer,
    amino_acid_change varchar(500),
    validation varchar(1000),
    global_maf varchar(100),
    subpop_maf varchar(1000),
    minor_allele_count varchar(500),
    frequency_comment varchar(1000),
    nucleotide_change varchar(500),
    description_vector tsvector
);

CREATE TABLE public.variant2database_link (
    variant_id integer NOT NULL,
    database_link_id integer NOT NULL,
    type varchar(50) NOT NULL
);

CREATE TABLE public.variant_refs (
    variant_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.version (
    version_number varchar(100) NOT NULL,
    publish_date date
);

CREATE TABLE public.vgic (
    object_id integer NOT NULL,
    physiological_ion varchar(100),
    selectivity_comments text,
    voltage_dependence_comments text
);

CREATE TABLE public.voltage_dep_activation_refs (
    voltage_dependence_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.voltage_dep_deactivation_refs (
    voltage_dependence_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE TABLE public.voltage_dep_inactivation_refs (
    voltage_dependence_id integer NOT NULL,
    reference_id integer NOT NULL
);

CREATE SEQUENCE public.voltage_dependence_voltage_dependence_id_seq
    START WITH 1
    INCREMENT BY 1
            CACHE 1;

CREATE TABLE public.voltage_dependence (
    voltage_dependence_id integer ,
    object_id integer NOT NULL,
    cell_type varchar(500) NOT NULL,
    comments text,
    activation_v_high double precision,
    activation_v_median double precision,
    activation_v_low double precision,
    activation_t_high double precision,
    activation_t_low double precision,
    inactivation_v_high double precision,
    inactivation_v_median double precision,
    inactivation_v_low double precision,
    inactivation_t_high double precision,
    inactivation_t_low double precision,
    deactivation_v_high double precision,
    deactivation_v_median double precision,
    deactivation_v_low double precision,
    deactivation_t_high double precision,
    deactivation_t_low double precision,
    species_id integer NOT NULL,
    cell_type_vector tsvector,
    comments_vector tsvector
);

-- CREATE VIEW public.vw_interaction_summary AS
--  SELECT interaction.ligand_id,
--     interaction.object_id,
--     interaction.target_ligand_id,
--     interaction.primary_target,
--     interaction.species_id,
--     interaction.type,
--     interaction.action,
--     interaction.affinity_units,
--     GREATEST(max(interaction.affinity_high), max(interaction.affinity_median), max(interaction.affinity_low)) AS affinity_high,
--     LEAST(min(interaction.affinity_high), min(interaction.affinity_median), min(interaction.affinity_low)) AS affinity_low,
--     NULLIF((interaction.ligand_context)::text, ''::text) AS ligand_context,
--     array_agg(interaction.interaction_id) AS interaction_ids
--    FROM public.interaction
--   GROUP BY interaction.object_id, interaction.target_ligand_id, interaction.type, interaction.action, interaction.species_id, interaction.affinity_units, NULLIF((interaction.ligand_context)::text, ''::text), interaction.ligand_id, interaction.primary_target;

--  CREATE VIEW public.vw_ligand_display_synonyms AS
--   SELECT ls.ligand_id,
--      string_agg((ls.synonym)::text, '|'::text) AS synonyms
--     FROM public.ligand2synonym ls,
--      public.ligand l
--    WHERE ((ls.display IS TRUE) AND ((ls.synonym)::text <> (l.name)::text) AND (ls.ligand_id = l.ligand_id))
--    GROUP BY ls.ligand_id;
--
--  CREATE VIEW public.vw_ligand_peptide_species_ids AS
--   SELECT DISTINCT p2p.ligand_id,
--      p.species_id
--     FROM public.precursor2peptide p2p,
--      public.precursor p
--    WHERE ((p2p.precursor_id = p.precursor_id) AND (p.species_id <> 9))
--  UNION
--   SELECT DISTINCT ls.ligand_id,
--      p.species_id
--     FROM public.precursor2peptide p2p,
--      public.precursor p,
--      public.ligand2subunit ls
--    WHERE ((p2p.precursor_id = p.precursor_id) AND (p2p.ligand_id = ls.subunit_id) AND (p.species_id <> 9))
--    ORDER BY 1, 2;
--
--  CREATE VIEW public.vw_ligand_peptide_species AS
--   SELECT v.ligand_id,
--      string_agg((( SELECT DISTINCT s.name
--             FROM public.species s
--            WHERE (s.species_id = v.species_id)))::text, ', '::text) AS species
--     FROM public.vw_ligand_peptide_species_ids v
--    GROUP BY v.ligand_id;
--
--  CREATE SEQUENCE public.xenobiotic_expression_xenobiotic_expression_id_seq
--      START WITH 1
--      INCREMENT BY 1
--              CACHE 1;

CREATE TABLE public.xenobiotic_expression (
    xenobiotic_expression_id integer ,
    object_id integer NOT NULL,
    change varchar(2000),
    technique varchar(500),
    tissue varchar(1000),
    species_id integer NOT NULL,
    change_vector tsvector,
    tissue_vector tsvector,
    technique_vector tsvector
);

CREATE TABLE public.xenobiotic_expression_refs (
    xenobiotic_expression_id integer NOT NULL,
    reference_id integer NOT NULL
);
