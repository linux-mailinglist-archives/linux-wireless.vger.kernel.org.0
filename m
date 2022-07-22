Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593ED57DA69
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiGVGjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiGVGjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 02:39:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7A15A3B;
        Thu, 21 Jul 2022 23:39:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M6StTv024613;
        Fri, 22 Jul 2022 06:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=uCIN/8XaJgi6e3IbwBUCecPlvzCWF1lGoIxOTMtCieI=;
 b=txEWToUJl/NB0cWsMIrnM5widT6PO33/EAqUvcDAuLV0TfXmUPyl0HIcETnMladVIy++
 5hVKSkonHlMcvRXWVlq41YC2qGvWWcOWY37W7UBBy9mCSN1C5NVJJ4ZbUeYmEVlEKhbf
 LLbLDtUl5BJVvpmDBT3fPNCnqAw33GQw6jQJs/zwMAmaGXL3Hbgtq+VWchC0xYqYIhzZ
 ccSRjHwzhUE04Eea6pFomTsWcbNfEjAptyVolZYsZGEipz7bZoymLIaA0YBbgMbv95rq
 8Jom5Kg+j80JPtUkVnzxJUCOUkQcrpbgiezszqqdTKcXlCr/KWy21LE/ho9GgmLGmBod /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrce5px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:38:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M4dTi0022155;
        Fri, 22 Jul 2022 06:38:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1huqpax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffMusE1D+irzC3cejrcNknrUMi9Eow2cxsKVvCuQmBuecHCZVVV2LHyPa8PEmnCwgYs4zRjUlVn2VnCOfNQyYJpajXGpWDkEevyd7d1aajGWCTmmm4206Ak1td4KZ/DdONpUsCaTSjNoZgTMTgQ6Wp1k7Yj7NopI7UuM/rXAD0Z/GjB2RVyiWd5Ghm5yjKtWpW4mXKt6NlQQ+sUuP5K9Nf7soFA75XyFk2dN7uDQhFkf/9b5gZdcyaMgWpmwNEkm7lYqx8mvjbRBxNV1vjHO2gVRdnPHDWXhQpc4lvmlnB+en+cpS/gKj2/L3hFlDpBDa0dwxXPCSnsdNDh60jPCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCIN/8XaJgi6e3IbwBUCecPlvzCWF1lGoIxOTMtCieI=;
 b=adhJI+g4KzgUwvzHy7cF12mnlzAI6CLcdR0HIlX062wuk2jd4oknH2ZzcurtuQEvjQ6kjefe1lH6T9Tw74JwvLFsTObMufvZiEfHUTO8gS12H2vGW2Wi3YpL4aLRI1mBsp0ivVUvpcRAozrGCEj+Rdk2Ndyu/CD8SPmgleB+4DiYfGmgaaV/uRLW+cAdvXmlo+KHExQhUgELJwli/cuoGsLXxPSv9dDb1V/+FcuKcmpnX/Nhy80C5Yii6hbHf/L+auxKyXH8AHQop05IqOzbKffS6sFG0vE63HavRzH2LOn+yxEzu6Ya0F91K7NMqcDBTVbYYkGpXpu6b5x/bq7CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCIN/8XaJgi6e3IbwBUCecPlvzCWF1lGoIxOTMtCieI=;
 b=PN9/uMfqayNVQKJc1CwoiBzRx4sJPyFtaGvUmDnwNVFxCeiA9sf71EGp19ZaNm2BP0bYEvEWnJ4Fdji8UoYmJb3lTl4kZVw2lqVjbP/H8AWBtzn+U1Xwym3MgIrCYDeekPdp6zBCWLb1jPQFA67o6y/GTzQX1poE0RfZzx5uhyU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6196.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 06:38:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 06:38:51 +0000
Date:   Fri, 22 Jul 2022 09:38:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7921: delete stray if statement
Message-ID: <YtpF8OycSrEzcLg1@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffaf0a6a-b72a-44e2-358e-08da6bacd71e
X-MS-TrafficTypeDiagnostic: IA1PR10MB6196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHyA2K8DPcLFVgBTOa4bne3m8xe5een5uzaCt+upubcFU5IrApHfPPoE/cviaEpvsF00pusu2LrlOE33B03B2pG5qomVJCemNuI//o8EqsvcU+FsyC/pAbYM3PppqkAKgcwUNwNCDNLvT4ipKD23/NAtG4Qb/NJWBltQNUinKTr2L2RoV5B7jNPT7hyJikwtkmi+4pyFJQmljCTikVXi+psVCqMYj5oHaAn8vYkmmK0Nju1aTBp3mNJXbJUmlaCfNn+ctBzIukbewdE5Wco5xZCwjLg8N9ANWFxtKg0qy0mPTjxO7G4L1ZcN0KRTnpCrNJbSfZ2//mW+O07rLq0fvsvBYKId8DlkaKwZ0z/Aaee0BEvpXr3BGoOqAv6Nkeu+GHK3uPwi/4pSZRmT5oY5LEBXdosS2ovLw/VDx2y3mjqZoiDJAIz8WSk5yv+SxypidZiM3063KstihUXwFT1RzIz6RQJEbP6iGdygEXpHOxyykivduQhxX244locqE7BoR9s6NEX4HLExHIKXabqX62bcZEqEfoVyjWCA2qBCxpoAgyd/AZ1tnirDE9ppIPqYwZCNDujKCzB9tAsaBs05VK2skmmvMP6I2gcYaxsEV9ANaYM56O18RzMV3UiXFfIkZMN+jnn4V0mBq4A456nwBYrxZIMmI2gxIJbES57/43gy/jPKcKiV1TNwnKFXT7dxgr7OiqWNldeWd3tQYwJ0YkIJ7QmKINKx7BmDtIujcmU6WgLyhvIdTGNx4C3Zx1CyULS2A56RgwXi03aJyWBh4g9jCfDB5b3l79LDpuRYc5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(4326008)(66946007)(33716001)(8936002)(7416002)(4744005)(66476007)(66556008)(44832011)(9686003)(5660300002)(6506007)(38350700002)(2906002)(38100700002)(6916009)(478600001)(26005)(6486002)(41300700001)(83380400001)(86362001)(54906003)(316002)(6666004)(186003)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EXZQLVVqDFPZU8zcnRT8SBiLmCptC8RTqo7CNu0f8cCiUdBrs1BNrkB6NPVc?=
 =?us-ascii?Q?q3FB8sUYdf5P9Pa9I57vLwRq8LB0KtOk5nRiQ39Q5VilkNKBR2OiIDYM7Asv?=
 =?us-ascii?Q?VvirrdokJWpY14woE5KC0uO7cVHRW0GtoQVUJbF6w3mhmCfiCNBps8g3ct4s?=
 =?us-ascii?Q?VWeKq4qkiGGGkIGiSwXEndWb5MQIxIulxZ5W06OnFqXttEs8WEHxT6v45Z7x?=
 =?us-ascii?Q?wqkrsuvHP/cv/mk7TSUIwHKPz+KM3bv58+QNVp0WBWSV/u/6zmJw/bqhWKww?=
 =?us-ascii?Q?91HTM93jjxb2gZiyBxFWi2V26cTa0sy4VBqWhP38byAsr2mX6VMFNUMmRJk8?=
 =?us-ascii?Q?BwxLs+35VWZqEAHG3uLRDA4g7dYRUtp8cOqvfOantnW/Hm0e1x3g+XjOIQFc?=
 =?us-ascii?Q?SsPRljlojTN9tR7UHVJ6zXP2lZ2qmc76vpIAR4r00nFexBEPewZ7DkiS9dvc?=
 =?us-ascii?Q?eg+PtbgGLRVcztCIewp7bhSBMmqEQbeeDkJKKC6oZfZKpn7RtPRsnLT/xYQU?=
 =?us-ascii?Q?o74kq4hWbMTAVFuzPdSR+wmA+MmwDdF7TX+8zoH/z9uoXdJqeUi6ucZyR4kX?=
 =?us-ascii?Q?Rfk/gCxDDi7gnkis0OYGLoUB3Bx6tUrC723E27SmQvuDui8TviDt+5zDenLn?=
 =?us-ascii?Q?PDoH0k65JgbKUjHx/jNpKDtS4y30AqI8up4Y0b15DZgBqG5q92Cz/goxQ6pu?=
 =?us-ascii?Q?0QoMEmHsCZnpEu2CHn33eYDFjfglgincTlkdS9Dd+NCzSSL5/GYQYNEcj3Sy?=
 =?us-ascii?Q?dv5Cls5PdMjfvdQHF0A8csVSCx0ZxI+uoGYJgkxhxZOOijO3/ZDod+GphR/i?=
 =?us-ascii?Q?dPe09fZTNjyDIs685G5UScHispl7pB6HxjqikBfqtuy5X7ts6HvEcDUueAqJ?=
 =?us-ascii?Q?QzfbjhFR1vF3dAAxjXiegijrUgpnHdcn2Pxo5i1/ZhJcZz7Q/BtOqDtRkCqu?=
 =?us-ascii?Q?eRXH0jYipF5vq0M/3c4Pz9laCOPmE+ghcBbJHASjHfOYETyXECHtgEeQ1TkW?=
 =?us-ascii?Q?2G4BCHjLSH/a91klgR66CJc6jVeLJvrXx5+wfFTHvZbj5J35XiYk8jck1/TA?=
 =?us-ascii?Q?bRnTc9fMyfVOJwkEY6dsA9tfichNSbvtfCRuKOIDzNTsGyoXRVkSFvjqlZ1w?=
 =?us-ascii?Q?aYz+Psn1UgYzjkpsqyQPIcDuUS1B3hSWlKS4Jyuq3Ch1i0rKBlzzaJLH3KPc?=
 =?us-ascii?Q?dCORTQC889ooEWkSfLJHBZSc8g6heeZPGygsR6ThnbbEWc1xYT4LoNspSxa/?=
 =?us-ascii?Q?KzBdrQkRAfpJBGVZG9/Dwbofn/j0gbseYqmit4RapTOxsYwtJ0v+QQWgt1Yv?=
 =?us-ascii?Q?zINEJaACWgxDSOmye1FjlAj8z6i7PmXEE095NGSgsvV9iyJCI5HdQPvH13xA?=
 =?us-ascii?Q?F7ohmx3UmodZmxqt2+dDMgRPDS1HYkZUEO+cw8u7IIIPiz5YdqBVZCLF3Fqu?=
 =?us-ascii?Q?eX2Z8nKGwk0zefOfTbuiz0l0qBFH4WuMacsmcqLmAKUJtF3kvRMWcN6zFmUV?=
 =?us-ascii?Q?9fhV+ZtewEYZBAJmGSfu+mYzoA6U8XZ26+UiP2LGhLqM+lqOY91RxCQxEtbB?=
 =?us-ascii?Q?GIk8i7K6SolsKj4Iwa4KbN7+NgUig1DRBKY4RFsAtZtgFfAg/kAmqvm0MRr9?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf0a6a-b72a-44e2-358e-08da6bacd71e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 06:38:51.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oS08ofrtdNutC3mtk6qIw4J7Yfhls7EPn83+yz0Gb1NZ2Bpo0VOA5tuzxCdjPY9jPmlgWHfsvBzvQvF/FSoq9qPQcW8GRdxxduFgxy/A2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220026
X-Proofpoint-GUID: iP9BJnJQUwSJW2cyKkc_t9GvIHMaOZZs
X-Proofpoint-ORIG-GUID: iP9BJnJQUwSJW2cyKkc_t9GvIHMaOZZs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This if statement is never true.  It was supposed to have been deleted
as part of commit 454b768f9ba6 ("mt76: mt7921: Let PCI core handle
power state and use pm_sleep_ptr()") but was missed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ea3069d18c35..f72379d4f31b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -409,9 +409,6 @@ static int mt7921_pci_suspend(struct device *device)
 	if (err)
 		goto restore_napi;
 
-	if (err)
-		goto restore_napi;
-
 	return 0;
 
 restore_napi:
-- 
2.35.1

