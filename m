Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8321344BC9A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 09:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhKJIM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 03:12:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7556 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhKJIM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 03:12:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA72bGI003762;
        Wed, 10 Nov 2021 08:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=PldHrQXhHPwh4YE6rMcTWdlWoyQue8Lqro8luknb/3Q=;
 b=0DlvuDnqOvWy8J/X0eEYMGK/gJIuG9QvLLB7kn11pOJykNAg6V2vdP//GRo4lqEFFnAL
 inuo5i8N/OGGib9fLQ6RpfC38/DduseOTFpHXxh92jQ/tVt15HBL7pkmRDGgt5y/azii
 rpcYNcv7+riTYiiH8d2Ws/TE494YGU/nONMVzkYhC0G4tRWuJisLxi9vUV/hvBbaArVJ
 9BbV5gcZLdmOg0Duk3jb6abYHPcttQWoq2vU99h1bzBRwSOf5PKt1WUPlSrrTKAPDImR
 RJqC8+14uuio6VvttfDcYMIKaqZ5EGhv6Z3EvYiT7zyYHSAdHr0VHMyUQ6DyUYJyexz4 xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c87vxgqea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:09:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA81QgO088594;
        Wed, 10 Nov 2021 08:09:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 3c842bvyw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5P3ihZ952dhjIsdiiWSRiBeknP6ypHgMlcX/A+Q6r1eQrG2IKbn76/VLjV6hkc+3AYMaLvNAkxhRr+HmZdqB68hnZ3AR6gDcxCTtiQ2WpOI5bWITU3U+oE3rKzocb+BNAjlv//VOKU6VjyCXK6O8iUl6OUiuTkqP4gBWiqbqNNVI4KygRCN7rFMNB7gItFBO+1xMk2CqA6RFQeYbVvXAudvW7DdLH9r5/AkdXMkesuS7uuA6AL+UapjYmtk/X4E1PpFwwp43JjPvMY5Ozijyrd5Dj8yxYewnhSmXLRozFpKy29wQy0qwRwjOkmXKdh4QfPbfrOy5IYw2mS1f3i+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PldHrQXhHPwh4YE6rMcTWdlWoyQue8Lqro8luknb/3Q=;
 b=TIYHH31givOQDxqJFgSduYzRkf4ddxKa7aNCLbu0GSktd/1W0edz5lIP/d1EFEkv8qg2lvBJHWzZ+2qgUcuYcbsb02jF8sAKBABK10QdS4VPgFk/9/M9uzr2S7D0D/BNAK3ahwHVztYnYv0TL1sxQCRrV0dhvhuWlhOZTUYwV+q5Ui31IP4Ze/WBS0sQDP/DMv2WWVILWBM/+k/pznJ3q0PZUl8TVdRxj9TcoeTZBLLSvj9BQXZDIgQRcmtnhp+mI5zFBZnHExlb4RVFyM7vrEvOrm88aM97BgEbkAFAvvwN2I+Z9J/jcedYDii3pPdFG5xb24EAr9q5A+5YPu8kYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PldHrQXhHPwh4YE6rMcTWdlWoyQue8Lqro8luknb/3Q=;
 b=vt6+A680+2H53q8D4QH3vLzokI+z61bXoawv4D3uM6/sZS2U2p1/0pi0AuaIwv6SUHX1COgfxCc3d4xStjHbwnEEzmPYEuBP2/+imlJgwAStvbKZH3QlR96QYlrZa8/T/iCvY0eA2kZWxYJRrMBDHA43HQ/+MPNUEQLhaXDZ9Ms=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1950.namprd10.prod.outlook.com
 (2603:10b6:300:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 08:09:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 08:09:34 +0000
Date:   Wed, 10 Nov 2021 11:09:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iwlwifi: mvm: clean up indenting in
 iwl_mvm_tlc_update_notif()
Message-ID: <20211110080922.GF5176@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM6PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by AM6PR10CA0004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 08:09:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7c961a2-436c-4fc9-a7dc-08d9a4216e34
X-MS-TrafficTypeDiagnostic: MWHPR10MB1950:
X-Microsoft-Antispam-PRVS: <MWHPR10MB19509BE0291319D6BC0E77E08E939@MWHPR10MB1950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o94e324xoCbjzrKe1NJBjQs2LQoCWXWcB88wNGXR9su87tIs5urzvUgWeSWeqWUkmC1plEKSj0pxWokLBa8a1FQ4Kxt5tKBNj0d+EpO7oP7KWeMf9ONVk8lskBRlag2rt9vjtgp8TVxwhQlmFuwD7RFxMbR3ZdfGgxejTF1kK/GLxK1OygCou1H/U/QVAmHohyNIyc4fPrsu3dLo5GLPYOtORixB/VA8iu1kfUybW2VtaU5x0+cJQ93jeHt2nQ9MOfWP6grXl0g45Qz0FHYBeR8Mt5ZtClJMHrgGHzM970UbyOvDT6wSpuOF9DeVc3QQ0ku77yqOVAzyKvAH1FLoznUzt7NATWQa6Yt33+2TEGH9AS1G6y/TUBSHA2DfPC9CPd62idsL7zrekUd4mBqAceKVtRf7oD9z7iiWmWOiHf3AldpRA4MILyGernCKKgUnptKxo2J1x8SxqXh5xxp2y9CBz0edlR61+axchBEx4ukZIdstXoq1WIxHNWTDrfpqtQItyTSkf0z4x51WMw3KaasBYRZqTLho0qo6pdO1qaUFKEkwBUCdMd9G2RFJQmPNW93azf64Zcqj9REcUhctbW1154p5q3mC9HEAkZZvUmbL/S3AtLCFM2Y7ZPvBwNVbImynJ51m3d7R9Rhx/qfdxzCKVioZEMeSxcrw5kSGuSLekgIIPGNdFo9oPpYPNm7XGuhTk0oH9X5IjBkOFG8Ddg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(186003)(38100700002)(8676002)(6666004)(2906002)(33656002)(66556008)(1076003)(6916009)(86362001)(4326008)(66946007)(5660300002)(66476007)(33716001)(54906003)(9576002)(508600001)(956004)(55016002)(26005)(83380400001)(52116002)(6496006)(9686003)(8936002)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9SdfBZInQ5pTYqiSHORnQxCP48Wmpo2nudjAmlLswEtEF+kCGGc72rWm6HR?=
 =?us-ascii?Q?SzuPwOywnSgGk4JwVJO0O3CqPELWvvqBok7V36mvONZK3AguPAifsKScEmxm?=
 =?us-ascii?Q?d6ReW8vtWgURDgpILdJj4OfpMO/CbIGPFaQxX16dd+MhLtN5n7wlnb0NZQAJ?=
 =?us-ascii?Q?GalcM2vQ28GH/QFQk24J6dkFB4rKOGPOTm9hOhpW2VeklC76GREoSI2vFNlE?=
 =?us-ascii?Q?iEBkJkBNZgsZ1wqgn5E8uxEeIVcgevSoHhqmAUDTItoPzryvv1AEzdbv1Cx2?=
 =?us-ascii?Q?+EUTu30RbNlWA1lmj4M81j9HKIIWJzSKeOIfMa1E8EI65dziJ9R1o2Ew95dC?=
 =?us-ascii?Q?RWQZGP0RnLAA130r9RPf18O2Mp4zwoi/e5BjkqR9wesRQoNd1PMQzV2YxFY6?=
 =?us-ascii?Q?8H21UA9iaMP+KmngWsyanGT0gff6pCHeB42LcAGUPTDjLml7n1aOZ+vGt4yU?=
 =?us-ascii?Q?NylHdjO7knbBmy3sOvGTsYpiCRGyQJzjEUpmZtlAfvDB2bOQWULbiP1k64HN?=
 =?us-ascii?Q?AwrLSCugRgj2bCzCGXjBGELAEV6Ar08R3hy848+9KSlbH5sYV8wWE58eSddt?=
 =?us-ascii?Q?qQf1UO5ztTJLCSukO7t19mg2I8U9+RHWi7sET0rg6Q+QRe/AJEDA0FH2N/Mn?=
 =?us-ascii?Q?0enBfPVHOLkmoizYJ+Zb5oYp48rLAXSZgwWnLrP22RIbkTk3IVDfoc/uDxY2?=
 =?us-ascii?Q?9BvHF873t4ePaZW6ZVwBQlKXg2BgY6UNXy3iitxuzSkkWPcLaNUjnCv0TNGL?=
 =?us-ascii?Q?R+OHjgC9t2IEBf4sJcGw+xFboEFe69zmpnU+GHkHTWqhohiRHTbERxmrEWRz?=
 =?us-ascii?Q?0nz42fegDGURnYTyyj1VmSTRLVdyW+JzgpgOTsk0/HgKAhTVK4s06LLTaqaL?=
 =?us-ascii?Q?mBvsB7+fCYoJBz8516ficy/FC/Whrx0a7dXgK1N6CAcoSwlYQKONotGA+SOe?=
 =?us-ascii?Q?HRx/QOG8KeCHrZBJjq7MLALvA0NFg06wTgx9RWiS2gl7WEPw6RbAOmYXTV5W?=
 =?us-ascii?Q?DxOxurAN3fB0+qVdjp6ttmqMy7nSunq+4/RqdQFdLJ5fHhM6gDdgqmEwUiQ5?=
 =?us-ascii?Q?0TMoAWe9QHpySOn8OcM7PeOI6fmxTUDlRLR0s5f2RHWHfMPcWQqPoZGmeRbE?=
 =?us-ascii?Q?Gw3n2+k5DCt0SMBS+R3wwt+ZSbnP8ljHWCJ10nQKymnjyXPXkrB42DfvJRGM?=
 =?us-ascii?Q?Shym5WgxJfKAE5Mw8tfTW8kNPu0kTRe/6Sihpmp8EfBgDkl6ydeH92H9LJbj?=
 =?us-ascii?Q?FqN4oUo3YgBbeilTEFFA3UOLgUtex/4w9pviRdQ9IXj1SC5jNWNpEBgy9Ws7?=
 =?us-ascii?Q?1qkI7Cxj78q/tB/If5PYQk8E5iys0XTaRw89/lTheFAK6iE5tmU/sZ24KCcO?=
 =?us-ascii?Q?nr59+14LcB+5MEbCkn7rPkgrQyykt7RUvOA37eJkFSKv2pSFY95l1qUhw4C+?=
 =?us-ascii?Q?GUjrknjNB7RWNdf2xrXLDNX2ZFM8ThNPh825DyToi8DT86X1SIAEyM9PmdZ6?=
 =?us-ascii?Q?4Zmj3w9pshwHigWLbB+d2k4dUFMzmtPMMBe7JpSFuBmo3IAat2tPFIKLVQGT?=
 =?us-ascii?Q?LL22DQCV4mU9sigoalsRsLVPt2foWwl7xLkcG/QWrsijXrGX/fpxSpGkJlVe?=
 =?us-ascii?Q?RXXsGxsX8bZytM5+ZWDUMfoQmt3+R3upeljPVuzYgJ1mt8mtiXBenAbziuUt?=
 =?us-ascii?Q?XURhdM7puhid/HWe4/MQKsqPZgs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c961a2-436c-4fc9-a7dc-08d9a4216e34
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 08:09:34.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x09xHQ6SQbHIk5YwfdJGdmCI3n2CVy94gAKco+/cDUWfyZGrkkvaPS05Lvxv+eV169mJv4tzlDoCRueohoTPacahNA8uIDPBVcxZh710LDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100043
X-Proofpoint-ORIG-GUID: zKWpyia9gD1swfgCNd25cho6PqWpijJl
X-Proofpoint-GUID: zKWpyia9gD1swfgCNd25cho6PqWpijJl
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These lines need to be indented one more tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 958702403a45..5c38451151fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -311,18 +311,19 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 	if (flags & IWL_TLC_NOTIF_FLAG_RATE) {
 		char pretty_rate[100];
 
-	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
-				    TLC_MNG_UPDATE_NOTIF, 0) < 3) {
-		rs_pretty_print_rate_v1(pretty_rate, sizeof(pretty_rate),
-					le32_to_cpu(notif->rate));
-		IWL_DEBUG_RATE(mvm,
-			       "Got rate in old format. Rate: %s. Converting.\n",
-			       pretty_rate);
-		lq_sta->last_rate_n_flags =
-			iwl_new_rate_from_v1(le32_to_cpu(notif->rate));
-	} else {
-		lq_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
-	}
+		if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
+					    TLC_MNG_UPDATE_NOTIF, 0) < 3) {
+			rs_pretty_print_rate_v1(pretty_rate,
+						sizeof(pretty_rate),
+						le32_to_cpu(notif->rate));
+			IWL_DEBUG_RATE(mvm,
+				       "Got rate in old format. Rate: %s. Converting.\n",
+				       pretty_rate);
+			lq_sta->last_rate_n_flags =
+				iwl_new_rate_from_v1(le32_to_cpu(notif->rate));
+		} else {
+			lq_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
+		}
 		rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
 				     lq_sta->last_rate_n_flags);
 		IWL_DEBUG_RATE(mvm, "new rate: %s\n", pretty_rate);
-- 
2.20.1

