Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271473EDD39
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhHPSkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 14:40:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37164 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230405AbhHPSkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 14:40:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GIZeKE022297;
        Mon, 16 Aug 2021 18:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=LgCApoZD+Lhu6FBaOLRwE9aQssaxCMN4ndWTa+6o53E=;
 b=wMJVIQmOzqrAGy5ky74Wv+FmjsvBY7e3wS6Zw4wnhPDoKe2Q6zk/0AowiNzj7xM1eDAb
 Sg1erN+tOpPWKCNKCbPMaPMlq+RJ+q0bP2SSGwELW/imlIs3h519SSokrMEdW5qPwE6e
 vzLzhHfEMVG97ksiAaBxyIay5kZNiWzWv1jY+OmbOnhE6bVo8agaDouMAUeOnyO+ubET
 f7pwFZwarTlLXDM0VFH3rrznBBbg7XcU2ZQjejJ6v+RwDqfL+nFypwmpRnZ9sPKJZT48
 m83Q9Gz8WXgBmAy69lfwlODbpIGukiq2/VOjo3usPcpUR8FkgaKnVJYzW1Bts/lotBoL ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=LgCApoZD+Lhu6FBaOLRwE9aQssaxCMN4ndWTa+6o53E=;
 b=qrUTvlC7waho4i9BUAIWlzbiJ5tmIUs8rv89rkP1JYD4Y0CHHye2VzXGef7UDI7EEFDk
 uJTkkkxJosTVYUW2Gge/bE2ixNzHRi6VDdgRNM81u5qHII8ZJVCOVsCayaIk3aFFMhau
 9/fiDbzyTAYPuQAijZuP4bmZRIJkdA1Dbb3lyVLfJadugTZIKLdm5A0jXsAw4yQlEMtf
 tpK8aI0VH4RKcNWkv98U6sF7UymPC4GFPIlRA59IqCUaJkldwhsS1UXdZDd084yS3Cfu
 70zkMStGRCjL5bfHbcui8JOaE766djl0MXeQLjVdjEbXn6k5ue+NpdA9eKXClQ/Y4Af5 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpghw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 18:39:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GIYqrt176736;
        Mon, 16 Aug 2021 18:39:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3ae3ve8d7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 18:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOL4Q+YRRherMRG7Iu9940fEihoZ5LgiHPhutelAZKLE0fmA7+XRLKcRxk+FXvJig5qxwwUA7Ke0FLxVpoLzkwMbokZ8l8bvDjH3dQKNvWR9vnZQjViCpfVXqNTF385Hm1MeKX+KDaOm2imzOw+QU/yJ92zRncBk5TtRzY6VdnN1GYS4acHJtpDQpNedzUs+xEdp5FiDT69C2pHgw0N+YWz2SMGgvPxyhn2j+HNwQDpGYpBz1i1pFNO6a0PneurO1IqwXMtD6JCZiTbJ2LTaVDSlv0rE/g8LFSgKCrXMTQU9dbzv0ErxSwxQ9n3SyL+LEISMSsC/0Nhrze5YO3ZTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgCApoZD+Lhu6FBaOLRwE9aQssaxCMN4ndWTa+6o53E=;
 b=MzIZSvJaUi8GgRL+OcWOLxgH4aOC7SiI+O7wC3Sf9wtQ69CrIv8aE4URhr+jmhV467K50icABtdY4FYX987nJ6UBoQadOqyRYmKIwgkdx4X7EGHEgPbwyA1gXsBZPOZcV18DuxaIakYlgQcy4QEJDjrrmtKSetpka1aSeruUmsHMli4GsX2cMOYJkglPWwa2ORg2F9RrVavtLvlxSHVyk6EQzST7AMHztG+OTVAAdrvCRNqkrIlS1m3Pj5XWntC2YuV0WTGRcsiN3gMmaF4LrO2l6Glfscf70rOIbmmyHqSNcZ0Rt3TNu5lF8Eqlq/Pt1FIxoVN7fAi+j/vHuK2edQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgCApoZD+Lhu6FBaOLRwE9aQssaxCMN4ndWTa+6o53E=;
 b=vAWdN4GwH4IjxOgtxMjtJmn64cocXvoM+PWdQ76Qvo7UEwDxoran9hqLjJ+RdUtPfAGdE4+P70mHbBU31mq9ghuFAS6GvGccYL/nHyH522kYjdC0LgE+y19tGZZZ+iTww+DVDcTKwa9NqMDNIuHws502HFsLcRdNQEE1HYuwZmk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2160.namprd10.prod.outlook.com
 (2603:10b6:301:36::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 18:39:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 18:39:44 +0000
Date:   Mon, 16 Aug 2021 21:39:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luca Coelho <luciano.coelho@intel.com>,
        Tova Mussai <tova.mussai@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gil Adam <gil.adam@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Harish Mitty <harish.mitty@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iwlwifi: mvm: Fix an error code in iwl_mvm_up()
Message-ID: <20210816183930.GA2068@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Mon, 16 Aug 2021 18:39:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cbe83e8-6d46-4980-ecd5-08d960e53772
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2160A4052980D1269BE03C298EFD9@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jKogrbws447+7M7/PIRpQJirZ5zlUSsCqHgL2L0ykRvrA1lLv1Yhutbajg2gR94H/DGE8wwoGDnR/OsTER1AY83Kz9cxb61T0jxtXp3G7BpEw/kP7vcC5awVzKWUDDgOLfjhGIInH6VgSjEIuYkn1lbKL9gIgOJYhDYv0GN1uJhvINxVpaTqX8dO8pvMoA0QUUKwSTx7b7PcpB3/AMvxF4KRJ/9JEbkq9bnrdS4yIhZQVL9UCGaF1cKHo47UlbvURmjUVKLF8dk3cF6NiI1uzqySrPLV6SI2Hef5d4e9SXSfsYgrQRO/I5k45BrLVKA2mAizrocyXIXVc2y4CegiJQdNR1OdQGRAMZqREQsImCflBQSX7EOhyw6MclzBONx/wkRVFX8TlbZUUbRZajwSUhRr+pMOZmkN9FrNeBN+GX12CTCYkcDb+zrwPXsyN+nCUWXynevrquppe7LbbpJnnTu6GfQxR95Tzc9VgOqAweEb4PlH7txFUVyBMNspKx3Xc7B/pYBbKfb4tgvDaxqC9yd9f1Lyt/GNbuE1+tpIVdHXbvjM6VSH2W3/n7Vtf+zCtHKGkVkxvTpkEsvYQbnKNiFb7iMngEPO4doCRy96KO+7220a3yMJOXpAWwKKazYWGZczIMO3VPRo7oKXSuTS63hhQZkv5n6/o8FvgmCGbcK9k+DSM59SbcOmN+xUzok
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(55016002)(4744005)(1076003)(33716001)(66946007)(52116002)(110136005)(54906003)(44832011)(6496006)(478600001)(316002)(6666004)(5660300002)(66556008)(66476007)(9686003)(956004)(8936002)(4326008)(86362001)(38350700002)(7416002)(26005)(186003)(9576002)(38100700002)(83380400001)(33656002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?81/bS2PpaRwBz1UbwmysVkLv++uDtwzIVjn4nHEz82ch9OzGkAt+xCckYeZG?=
 =?us-ascii?Q?e40yYnZ9s7+hBEJJVJKZAYY1g21sQLKH/nKXEeTV2eIkvCf0QG9L3GBsJTrd?=
 =?us-ascii?Q?OuqGFsRBBEjKkTcbgammnytUGMKZTVIef5oUEbZcLdYvVSk7IC4I2mX2/8Q+?=
 =?us-ascii?Q?sIg0KfGcHEYeNXzcxHQTz4ArDmzikh1uIV5/97KJfFUFxFJFAepa63qXv2pZ?=
 =?us-ascii?Q?I1YCYmYp4EJ5OODFgCP8lumDcTrYisDxA6U6EjWJqnYtrEMhhKosoEiR/S5i?=
 =?us-ascii?Q?ccQFM+TLxmSKBh2fw09eeP5JfmTlBCUzd+3Mvcp15XHzWEPGlGJ2EEZz8Loo?=
 =?us-ascii?Q?KC6Vq8xf5KxKiYzKqqhUyphv5QOiQF3RBhuOQysa/Pboufj162UxL+4jlH9l?=
 =?us-ascii?Q?Ef9+TtvJCvP01fJxUhbUFjFruMa5AoFp7gVm90iU1N57EcZ0od+urRoMOM7I?=
 =?us-ascii?Q?G0+LE6M556gTrZ5juyL2rVjmiYUHjTzDqlN1ZAldaOX+681+qNnWn3bhy/zj?=
 =?us-ascii?Q?0LTYOqYHiOdSAjjHaCeI3u2YI2OAGvm39LSF8zvdW0xB3biHqPUGUVcUTWqs?=
 =?us-ascii?Q?Arrf7tyGDouJHP7TFXqPl/3aOJUKlmHque1o3pM9Vr/1eT3J42hUUeHxUQFJ?=
 =?us-ascii?Q?B7Qurr7rb0XqVix2pM1Dl2e0CTzUDcbwhcV3NHaXLPWRGf6tUe5Nj3YyDrsh?=
 =?us-ascii?Q?9wKNXS0y/Tyq5hXSZr3DwbystdGCXqUEiIKX/13Op9hTlDIAGa0r5viCXQNz?=
 =?us-ascii?Q?deLZ5fBoPPMEq7g8HaW61JZtqyfVB7bvPRXi841n8tBLRnKLXL84Z+MJWNKr?=
 =?us-ascii?Q?aCJVsUQjOEtRvka119daHBE5HVX9Jgere3eU/F1w7+skc0QRcCMZN5TkcV8N?=
 =?us-ascii?Q?84NDyMrqGLSJ4wuP+xxpDB0IIVTG8Cg1dEMLhMzdEtS9NdKOtWe6r//t7kn6?=
 =?us-ascii?Q?iUzNz5oMWC4swlJVZ1cZuHKSXwu4p8hPVGagQmc9PcVjnF3OsLafNAIpLcKf?=
 =?us-ascii?Q?su4BW23GaHJu3lXJ9JkmO3regrpPa0SIzGdpeUHwrtvu9wPI7jSZsi5/R551?=
 =?us-ascii?Q?0jy5GbPiJqncfbxUdTDA0QkXhX3K0VIWfFE656hKEcKROlMQ0AzdQwikLqHl?=
 =?us-ascii?Q?QbtVmjRq/G7hDACGYF/Cc+F5vexUGShbkfdEd2nsiaNpa5Nl68OVpb6RLOdd?=
 =?us-ascii?Q?6eebYWFTTuSh64QELdQv5EfQBbnTk9u3bfXVlLxizXFnXO6wVY0MxHpxMJGM?=
 =?us-ascii?Q?jNtwp+GIhDXLtjLtP51Wz8mGiyR7V+nGXCXB8JIfEAlKzcBuHMtnXYxpZ5WE?=
 =?us-ascii?Q?4ALliWBaOzxS853106XYts49?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbe83e8-6d46-4980-ecd5-08d960e53772
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 18:39:44.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de7t9RH+9ycAnfKp9e2Q+oC2umP8yftJUFVzQ1ko9Y7Y3OizM6Ji5ykO94KfXgwFAJyIRL3WtABHrz+dLdlcDkOntPwAOfwI/8OTVi9CFfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160117
X-Proofpoint-GUID: XjI51Be-BJiLtaMjAUrVweBIlh1MAVf7
X-Proofpoint-ORIG-GUID: XjI51Be-BJiLtaMjAUrVweBIlh1MAVf7
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return -ENODEV instead of success on this error path.

Fixes: dd36a507c806 ("iwlwifi: mvm: look for the first supported channel when add/remove phy ctxt")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Not tested.

 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 38fd5886af2d..1962abb81faa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1461,8 +1461,10 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	while (!sband && i < NUM_NL80211_BANDS)
 		sband = mvm->hw->wiphy->bands[i++];
 
-	if (WARN_ON_ONCE(!sband))
+	if (WARN_ON_ONCE(!sband)) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	chan = &sband->channels[0];
 
-- 
2.20.1

