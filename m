Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203CF493ABF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354517AbiASNAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 08:00:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3080 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232897AbiASNAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 08:00:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20J9goUp000758;
        Wed, 19 Jan 2022 12:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZDnidk1gXJ43Oe1dzdaLJWepgjxO0YEVHH8POXWj3cI=;
 b=Zm82F1C1vd4lc1OPXR1+vPojJt0VTR1wvU5x9uZ9hqHEpkTBCv3dP3InQioEsEi/7wG6
 qkmb25I4uO4IEJpk9EYLu2Jd646rTK86gEv33Pug35oYk5t19c3EWwm4Z9N82xgJld/w
 eReEfDouZZ8kNUGhSHL6Hthoy2t+KyGy8wn9j94AwGCU+RE9Ka6NT0lflM03PhJd7RmR
 BXXhIrcb7AjuVzJ7r3OMZILMSsGOXZ65XOrxVbatOSOE+ptHZfmTTQhbPFgHer2V+28s
 TIBO+7wVQ2T19kRvnrIBJde2kLVI0tUTNMjdmjasXnRUEhg7gdAHR4uYxRjcuxV7yv/B 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vn1re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 12:59:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JCo5cw155663;
        Wed, 19 Jan 2022 12:59:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3020.oracle.com with ESMTP id 3dkqqqa0e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 12:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnLBv4H3/m7DKrdhDwjrWUO2nk/4g8vSNGB4xHb1fDlWawni+/x7iRprowURN2hzRfkoPdLpGm+zlZE5x4iS0g6nLOIrfd9CIB2AyN3dddgUv7bhmUvuNh+p1F1q8GkIKxPc8KxbUMRS2R5dxaj7h9h2TCYoc6BlNcg/zd16ccfXSw4norUf67CljwIDxCM9Mx0nWAqFgmE/D2oxyorRFp6gM2LjUpTN5kRCt29qIzNQADkIjyFbNijgyDNid83RbXV5qXyVrsELKHXZtHP+dREbHUuNU+//UE11nuiUpGtQMISzVasshmcshd+jFSdx9FT/W3P6qf/eEty+hI4GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDnidk1gXJ43Oe1dzdaLJWepgjxO0YEVHH8POXWj3cI=;
 b=GR2Xq380nzlbmdnGxWYZV7z63aFS9z3zribFKJ7ULvK2e5SKAEnTZ89DM9CECzMy9FGTY9HaGrfnCiro35X9wihkztEQj1Vgy0PKzUob2Dqt7q3TMX2bCtDg7gioDP+iRamZk5WoEjzyVuGZxW2PckAlFjXGs2BxFGoB4/SJ1C1r8S/8WbiBrUSQjCls5ZY77Iooa2QvlOtAb9sOgP7W++qlvBDKEkIsEa79VDtADBTNLfewS5PleyfQr3os4Koc1GU/6YNd935+HPfhlUqatFkOCYPuPBkCvX5gVkbGkzWqgYwbe754tIYV4HK/wOrRQDRly1lWooj8KJmxEe6/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDnidk1gXJ43Oe1dzdaLJWepgjxO0YEVHH8POXWj3cI=;
 b=NdRm1G2vRGuCLAby18iVCWntqDhskSfNdt6V22Ya0GqZAT9zjhz2M+sT51Bw/W3NdhRjR0LItPYm/TFCfPy6YGEpCC3N9ctbNfYdz6DiUHz9GMtw+LjMHjNP40IqaK74VyC/+bsv3g+P3kusHmm6FeB2yaQkf6u4RxQ0cerAQf4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2434.namprd10.prod.outlook.com
 (2603:10b6:406:c8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 12:59:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 12:59:35 +0000
Date:   Wed, 19 Jan 2022 15:59:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mac80211: prevent out of bounds access in
 ieee80211_rx_h_action()
Message-ID: <20220119125923.GB9509@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0173.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cd57756-3448-461f-eacc-08d9db4b8ae0
X-MS-TrafficTypeDiagnostic: BN7PR10MB2434:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2434EEEAD54A351592B9B6D88E599@BN7PR10MB2434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVZXg0zIy6b42LyJRomSpgcP1VSCCx3IKi6cm/d9/tKvlAC1c9zo7oL0OAEfNu7LIC8rW2aSr9ZF4jaERcz23tgS1ZBIVCsGP5hCnjJNLVNALbupPd05UPeA3ufoMsH6uvG1/oIB8GKRGRXh9Y3XgCsUYhJ66c5DhnO0DRPfgp0B6DTzBBNUWqJ3E0safh3df9luOgbzF7LI9J4NFZSTMH0GmtJEeSFJf2Y8nWeQcg+j9tngnUJDgyBicHKmvMryNvee7IuTiVbdU6m1Ax7heD0NRG+4f1Inw6YOZBuwdU7fUdLWaSkpvP/XvuVlyDPKag1aHOvdQdbMOvYb6oHFUIhKUurF2P622cDnQ44w2BRex1Zgzfssoa4X7FvkVs70erZP9Qj1d2LGnBiG4eu+gEcsbK1kxmnVlcTQb6Z5fKzmGUi/Nzrz1a5rzIIjwycQQMhm6PPBB2U1KVGFmluJzXRRlNkp4lGoA8RU8HCH+kpngIZ8RYHRi91xmIH7MsqiULW6lWJQk7cOqjkSydF/qaDQv1GSSB5URn2rV0dyRE568PXR4RiiATPcdRZBuWjvgKgj3T50V+MBcWQfU4XSemHZiAFMinaEI6eBt3z61s8xheaEH0E0QsmZkcTyxeb//O7TANPhy+4MDk2Wdxoj2Fj6XdwPAPJ4DFX3KsPRe24lkxXtHUgfLYfmJKnaUjwQQDC81qb19OamcbgJe1c57Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(44832011)(52116002)(38100700002)(38350700002)(8676002)(86362001)(2906002)(5660300002)(33716001)(8936002)(6506007)(6916009)(6486002)(4744005)(4326008)(316002)(1076003)(26005)(66476007)(66556008)(66946007)(33656002)(508600001)(6666004)(9686003)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjVIc6PlO1tZLF/d/M2QtF5IDLzFHCVZh6F162e8aiQ5bZydix29CLoZF0UG?=
 =?us-ascii?Q?zOz37x8tqr0VHAr7nRS/rY1oOyTh8H8ijfXydbd2Nc/ns74xfBdiffXjEyOb?=
 =?us-ascii?Q?oHBazURbTsc20g1sVJSMkxPD2aroIsIlXsyrQ5+oRHEe4R8gp4l6dRIPyzR7?=
 =?us-ascii?Q?0bIidDXEBEFfobnnnTSE3vIOPZVSsKeNS3FOS63EmknTM+gnG17KOrymPPJx?=
 =?us-ascii?Q?rUtIE/gO3iCichqXKULL3JpZawyxHk8rtFqr1j6IUeBt1ULTsDTuSS4kc2t7?=
 =?us-ascii?Q?qkPwlJT3zWARKag5fKv5Tg9dsfTltagiq5w33RZd7SlOqncClCl7sSdlmcLe?=
 =?us-ascii?Q?aaN7UvZQbe5QzLwVLlmaI6h4kMrpr2TSdw0aMwO/iF3/PBCd8/XRyFa7/Nvg?=
 =?us-ascii?Q?snSguxuILZEelQAAcCg47g1G04CW5fpABVo1miTZvbVqBHsy04d/xldeStm0?=
 =?us-ascii?Q?z3oC+HztQIHGQiNJEl24ebRvUns6ZL17My0C4R0dHWFNA5SPof9GhRnaITeW?=
 =?us-ascii?Q?auQMMkNsSdx1DU/h1sFhl0tQcBjnfk0KNidPAEplSWzClArrM70ztsswH87i?=
 =?us-ascii?Q?tL1o6Pw0wZ7jkeQ65cO96gWNEFg4LPmDegfFFCqPSN/m7UAFzVR9wnRazvA+?=
 =?us-ascii?Q?4jY/ho1KRhfgwaoePUabVnEbEFEXYyEg/p6z+gCLqD2OCG3BzIPMwGqXqT7n?=
 =?us-ascii?Q?MTl2jA8sNG3sfu/VGPPPJleqUGXFMDw+ftueYebaDbLG8XpAsyk+3cNrVjy7?=
 =?us-ascii?Q?NIEfQz07+QxcramMPahgSEQaVmKH5mj7O338DDnE/exgk8ZN4DjBZjA+Rz3v?=
 =?us-ascii?Q?DgrtHFl6yM7M2w8MvQWzSMEvhbVnBwMksc8yeWBj4qSAYQWYAthGWI5dUGXu?=
 =?us-ascii?Q?kqIF8vWUdpJ/wZY/Po/rcNYqWMxESY4n1XwlWitOzTGpaqIocWQd0O6Ccbco?=
 =?us-ascii?Q?BSiP20/QyTy2+M5jY0wI14vUJ9nW8DwV+NtT044V3gRWQ/IR1MaiV681Kh4G?=
 =?us-ascii?Q?sS5vyHRRP0w/gSuB+O3UenbsJkuR8rvxrdFP3sIAt8i5rz2szL+U9jlfQR+O?=
 =?us-ascii?Q?ufXqKBW+6dMuiPD0TLky7ra1LlnBSerwMAKylyX9VvD4f+xg+Cbr5JUDi5T6?=
 =?us-ascii?Q?esBElp2zzMG2FbHLQrcqg5oh3dnYOI/BZRn1U9rGPvTos9c4lf7HLNIt2idi?=
 =?us-ascii?Q?1m2s9Rke191EWFYGnkpuRaE/WUwb6ssTQfufxIQ1BhQtXQ0ZDbpdCLsA3TSz?=
 =?us-ascii?Q?lRUHW5IJf6y4mYRIhGi6RH9SDm9oE09Bj5o4SFQ+8BA2zxHFMsryUivHAZaz?=
 =?us-ascii?Q?tYSmWHzyKGKdCtvUPSUZuPDAhFyQUQVVTJkX/ongxqyERTuxDQgvMsFT7y7I?=
 =?us-ascii?Q?Y1Vxdo56oc+a3w2hyMhdXoDkgvLwi/yieOoEZVlOyFTd1c3EuIcYK3dr8nIc?=
 =?us-ascii?Q?bcrP/dy4oC7uv1vPO8/KATzp/pb/j/j4/Eliou10OIS/ncJZDUMGXIhVdX4c?=
 =?us-ascii?Q?cIGKOddPhDZnSdm0XXxeUn2z/kl7UPF2ysSBnTXNyTZle/8tw8tLsZnaf3Yx?=
 =?us-ascii?Q?qO94RlWYklX7inkUT273EApeZC0pnnv7T3A7U/IODs0EA5lXilcK8BlHbMOE?=
 =?us-ascii?Q?qcrkVc4PMZmAmXga/YHdxmUBu8H+OQxlLVRvdHSSNmsGXgsB86KcwdfYLQ+M?=
 =?us-ascii?Q?R16s8ZlGtaev/7Qdd+yw7G7dHWs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd57756-3448-461f-eacc-08d9db4b8ae0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 12:59:34.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFdRwU/nj2xZ6hzTTL7US6pLyZ1Hl5cac4l3LCc3vZRpvpKUJSYhGej0wtes+Gnd1WS65NvOIkhaw/Kz7iTIlt+pckh9DbQ5lpNh6YgHUlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190074
X-Proofpoint-GUID: 3WPuzpsQ9ezwGFoGb5kuH6xNtdV3-FSl
X-Proofpoint-ORIG-GUID: 3WPuzpsQ9ezwGFoGb5kuH6xNtdV3-FSl
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Smatch complains that status->band comes from the skb->data so it
cannot be trusted.  It's a u8 so it can be in the 0-255 range but the
rx->local->hw.wiphy->bands[] array only has 6 elements.

Fixes: 1d8d3dec5fbb ("mac80211: handle SMPS action frames")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/mac80211/rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 93680af62c47..9b0cf9e3b7bd 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3287,6 +3287,9 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	if (len < IEEE80211_MIN_ACTION_SIZE)
 		return RX_DROP_UNUSABLE;
 
+	if (status->band >= NUM_NL80211_BANDS)
+		goto invalid;
+
 	if (!rx->sta && mgmt->u.action.category != WLAN_CATEGORY_PUBLIC &&
 	    mgmt->u.action.category != WLAN_CATEGORY_SELF_PROTECTED &&
 	    mgmt->u.action.category != WLAN_CATEGORY_SPECTRUM_MGMT)
-- 
2.20.1

