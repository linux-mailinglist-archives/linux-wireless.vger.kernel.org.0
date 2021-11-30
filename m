Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84146312B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 11:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhK3KlV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 05:41:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61080 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232930AbhK3KlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 05:41:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAUn7O026611;
        Tue, 30 Nov 2021 10:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=G7+oK6NeQf9H0rp5jDkJ1uEC872l/GdyM5G5UhVqsos=;
 b=SzrzquFEFesP0BaaCLcOf0P98E7ZPM/l+wiUrRMzlfJH2CMjezRTlwWFSOjvA5Tce6MB
 1iYuuefXvjSF+pLy1pqucRCsjCzJEPL7xv4ekcTSo9IqDh5zTMUg6UUReMb36Ijl3h6r
 q6m9/3wAHf4Xanioyl126HFBM2Wp0hsf9CPY2nioz/s7mQobI8V1NnL9nIwgvm7XOCvw
 HCcQr4jY/hzQI68OtyaEyU4GjiMxfMtqgHeC0L9M7+oNAgF+FE4rufq59YY2le45UFE+
 CAxPnGzpPCPY2NJFKC4AO+P9dPBRrccLAzmcIFN1p9l73eEafyJUWkkLmX52eJl45Y8D oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c7ys9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:37:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAUK34141040;
        Tue, 30 Nov 2021 10:37:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3cke4p9yr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:37:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9AFS/VDyq1mhIJ/ZYBSTI6tDgbVS76vdQVH6QJsrstajwKx2F+oPZyyD/UBRxxLE9mC0bIT2jHHs1/8aM7Bavz/nTnFRmsU1wZeaNpLQp6sMdDgV5rFkMCN1Citiv6Vb04U+i2bLZ2vmQbp3/dMVkM+qOZceJDx9lImV9s2frOeHe51jxoYMsOvTnnQ9JJd9R17vgVEyAkxFImXFTUSnV/uzFRFxRUZj+I7L/iJSkc8ems5htRu1SX7xK98yTQJP+/K79IUiUozhOpNp+jpowmTARUS3eylCydzMWPTbLnOGIRe41rfcGyICKtAbWfW11MzS/Y/q1PvYVswOb6NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7+oK6NeQf9H0rp5jDkJ1uEC872l/GdyM5G5UhVqsos=;
 b=QTd8NLZhCAllc9jA/k39aRjG805Y9I/+HFUWWNg4EGZOpIYUctrgOEK+xdvXzduh3+IFMX4WIBpvgmiNOMvlj85UX1rdd7deMSlXO4m3tFbQEF+KRxS/HVmtUN2BYXz3qRaVZOpRrJm90HNOge2EPK3OgCVrKanColH+VDhN6hpTfnJRBe2hAT+7E549+6f03Uy7jmgw/123P6NliOv103/Lwhhm6HloDpZSxLIWayLxtxENB4UYEUcxTkq4Z1em2bs5hmjsEsAZQPXkHM0boMCogS1N+JLifgKhY4fjaTyMEwa1YYkOR6gkqIyfkHVdr4uGTCJY3a65VhFFlKwAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7+oK6NeQf9H0rp5jDkJ1uEC872l/GdyM5G5UhVqsos=;
 b=WkyQhksOpukbg0EKBvFSEfarQlMdFwrnwEQ+aWIEpteNZ7XKnNujXzYjYXKtIatfSMJ31FwzyNRq5rKA0Pz4+/qO/VoC+7ydPyDRUI9zaxnq7C2hWuRZdFpymZ3F0mK+wlwyP+ICEVmEEPTHhF2ktlzPqLb5Od7CaBkRLB6tOZA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1357.namprd10.prod.outlook.com
 (2603:10b6:300:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:37:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:37:56 +0000
Date:   Tue, 30 Nov 2021 13:37:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     emmanuel.grumbach@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: mei: add the driver to allow cooperation with
 CSME
Message-ID: <20211130103746.GA5779@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 10:37:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1deceb63-8fc4-443e-4ce7-08d9b3ed78bc
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1357075BA44B0026207AF7F38E679@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1g9zLxnKvQ6V/qQsfRzzufJ8tm1J0zaQ3d9ctb0nqkAgWx4e5jbhpSwQ9yszH15v60Lils78sL15q7DRqOBXvDizTxpYT4ntiIRyyfbUSVTjupRnh6WtgzsIvxmfVH+s9DGGpcnobWXgZ/tEfRG4PV2DmHz+eJ0SJcVIr7SbkoYBQmi+QAwHtEqlKbmiQMcQ4YsJ5mFS6inArvdruJEe8aZWG1/3h1QCAfI2s/v7xAjFudOSAfexls4UwOOlWMlJkj3V0m0zmaUgYe7bhSfbYha1It5xYRoQ6WFvRV3cDhMiO50xV372GKiKVGNMDk2zYl3FA6+X1VoT/mrWCf7PH6Po/mt6ipRKeScNvQJ/VejCy3q22h2X7AsW18G22R67yjBdr1VmlZWFHLotFxJoVcgeoBTPxiuAM8r+DoTIfLBx6aSrtvLkE+U4tou2kqGi94JfXRThOxy4Ev7Avp+qzsRw9hB5eThE23XFrSTYEtduda523MVSZoLLrMs/Ngr1WgRyWvbcwsQcs/PZmeN6thPxfkhQfRBGC6mxQPdJTP/T2jV0/0wstA8vnto4iooith9OJ2P2Bw06fM+xv7tY+U1TIj7sRfV05J4w5UV1JLxA0k565PZCahmcwjzCu8n8yh3sH7y65hhg+sLzPtKw7ft+CvbVRRlpJxTmFJYMkOW/yHjnFR/IS6UWGJ4IvAQD8hAnRFye21Emruk1zwIIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33716001)(9576002)(316002)(66476007)(8936002)(66946007)(44832011)(38100700002)(6666004)(83380400001)(38350700002)(956004)(9686003)(26005)(6496006)(186003)(5660300002)(86362001)(33656002)(508600001)(1076003)(8676002)(52116002)(6916009)(4326008)(66556008)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWZOPHf+T5Iu9xVWhiDIsjEQvWjAAWavUHicmvOQ0MKAk3w0m0Fkutq/pK/2?=
 =?us-ascii?Q?EmaTHEBDN3g+0k0ylAHvkoMCFr7LAO33TVr4eaB/UzH//77mzh5hdadyL47u?=
 =?us-ascii?Q?AyyjBdIhIFtkZWaelKtvLNF780voNq0fNWZFsBNFGIHIxOrS/c73SXDXOI2c?=
 =?us-ascii?Q?zFkdST9pEC8HMCM8pdTdQlLXkkEne6Erv0C8GpAjN1TmQ09tGL6/Tv9ElqoB?=
 =?us-ascii?Q?GQW36DI6XLDm2RC5Gv0AfOzwUaUor5fIxwlRt6fguF32xKdLgG8c4VgkmswW?=
 =?us-ascii?Q?qSb4RdTLdiycprKCgsf64o2iT5P21CgLUMNd64pBNC7iyV46EFNC6aPJ3dkV?=
 =?us-ascii?Q?pfne9IeZ8o+GSATQFpwLN2xztvHEuqDmpfkY3L4sGA8a0RNS9bS2OZ0YtMja?=
 =?us-ascii?Q?BcEE+okmZLad9AXUijOOxAJstKLmxcUFaJQQrFAqOWBXTW1g/fF5e1gbkeJM?=
 =?us-ascii?Q?sN+zPVZq1T2yMlwVOrPbgkuEVdULYbRjJoy4k78e/+TPtLJfWikuMvs7kdNw?=
 =?us-ascii?Q?q/Gnywz5EQE2HUSMDLzlTPNIqe4w8fBV3L0E7yTrj0wuCaLUyD0ns3KLpHrF?=
 =?us-ascii?Q?47ODAJ+JMDkvj4ciyItZC12gj92Z1ByFqYCaBBiTJvPR/QlEKxR3GOf3h7to?=
 =?us-ascii?Q?5QDfOZp7+DHDl2kLZyKC7q7uz85BoM9DqLKrgB1HkYBltQYSsIJrs2DYnL8r?=
 =?us-ascii?Q?nEkFSxwjWOmzi+RSQPOixUrevDrNzZEH4BcX7JIiQjBkuFFuy802JNLCRoU+?=
 =?us-ascii?Q?kLahvM+FAt0omnNPzao7i2ZA4XiiZ1MEYDodkmsiICzab+z2upX+KlW/XYYi?=
 =?us-ascii?Q?vkcH1tyqLdYtXQnh/tYbys9Dc3N6/IE9EvfW7P3fHv/Qe6cV677sW0yGqsWl?=
 =?us-ascii?Q?odBdA0UzdwV1LX61WR+0Okm/DQgVDc5mqRyWqCD5VGwRc+ek7oQK9oDxpWiB?=
 =?us-ascii?Q?MeQbzKcN19c1QvoXiKa0soZGsRsteXvZrHasIqseFaMtq182Pp6AQjHQtxuR?=
 =?us-ascii?Q?F+zdBuxFoLhwYCJuKoPJxrEnQv7NFIujjm9LDaSBg9Cy/6S83aA5MKuPR600?=
 =?us-ascii?Q?JiiFUOAUB3TYTy6sY4LR2yMoBgjeNefrbV7gMs5EeBNCe785D62IDWVRfzFM?=
 =?us-ascii?Q?0iCgCjFrdewcajX+YLCMPG2K+jM9GoLuhf6d3Sw2eieNXHTHzSrCf5C2aIMO?=
 =?us-ascii?Q?NLIF5SJ90Cvbr6rBDvOkBlWFtD3S7kDo+Unczw5AR3MDU76meFsDuztlZ+5Q?=
 =?us-ascii?Q?ZX7+CoBU2kUlIBd8Ouhe53iu1+9i7TuzOWs2BRRb0v6gHVeo1FHSLmQcUNwH?=
 =?us-ascii?Q?/UdDgROTzlcRZOFKwKkCjb9aDIunCHFQqzIzLw6TT30G/RWXQD0/Igwju3/0?=
 =?us-ascii?Q?xn2f5dNgObouxCsIBtlq/beSfZr8I5hWyNkwNgJJoivsO1x2/JJSaDjo7Nr/?=
 =?us-ascii?Q?P3OV49z7VjKXkeTxc9x2lqBwD7cE+C6jIWQsgJys862ovSBb3xyNDGB5Ezkr?=
 =?us-ascii?Q?XoNjcnggo3kBr24b2Io9EqPbds3Snu8DTjAGJlUzLu8I0yC/rXh6t1YXDprK?=
 =?us-ascii?Q?65pr17LIDCgx3Ff2eOU53WEyJ6Fke7E6t59dowIk56KQB2vJMNq28tVU6RYn?=
 =?us-ascii?Q?vUY8rGbJRWs1vtvv4gv/IF1fyJLHamKyHZ4jQvHtJsnOxX3cGR/pdrtFks/k?=
 =?us-ascii?Q?IamcNLoeb1aGBB3i+E234MzQQGE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deceb63-8fc4-443e-4ce7-08d9b3ed78bc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:37:56.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLPcH71/6eIYVV4lP/U6yOl5txgVIag+shxce0BunL/7yXFTJB3HOkBIG1dsJreq8KRsOhcK9wpJYU29oLlizM5rQKywBmiZWaJl8lwNQXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=795
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300060
X-Proofpoint-ORIG-GUID: BYJiy9M4YlEbjKa0-Wa3St2sHP_XV6O3
X-Proofpoint-GUID: BYJiy9M4YlEbjKa0-Wa3St2sHP_XV6O3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Emmanuel Grumbach,

The patch 2da4366f9e2c: "iwlwifi: mei: add the driver to allow
cooperation with CSME" from Nov 12, 2021, leads to the following
Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mei/main.c:632 iwl_mei_handle_csme_filters()
	error: potential null dereference 'new_filters'.  (kzalloc returns null)

drivers/net/wireless/intel/iwlwifi/mei/main.c
    618 static void iwl_mei_handle_csme_filters(struct mei_cl_device *cldev,
    619                                         const struct iwl_sap_csme_filters *filters)
    620 {
    621         struct iwl_mei *mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
    622         struct iwl_mei_filters *new_filters;
    623         struct iwl_mei_filters *old_filters;
    624 
    625         old_filters =
    626                 rcu_dereference_protected(mei->filters,
    627                                           lockdep_is_held(&iwl_mei_mutex));
    628 
    629         new_filters = kzalloc(sizeof(*new_filters), GFP_KERNEL);
                ^^^^^^^^^^^^^^^^^^^^^
No check for NULL on this allocation.

    630 
    631         /* Copy the OOB filters */
--> 632         new_filters->filters = filters->filters;
    633 
    634         rcu_assign_pointer(mei->filters, new_filters);
    635 
    636         if (old_filters)
    637                 kfree_rcu(old_filters, rcu_head);
    638 }

regards,
dan carpenter
