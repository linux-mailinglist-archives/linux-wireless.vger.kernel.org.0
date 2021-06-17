Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD33AB837
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhFQQFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:47 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:15895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232689AbhFQQFq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQmIR9Bd/V8N5DqfyMqlt5ntOvb2E99Hw+EGXnrcFuS09BjmGBWdSyaGz63ETq0t9U2r5t2NiMCSrcoGCs40AMtTPFi1rotCRpo9lHCz824X9y/EnAm0yBge1okBBDO7pnfBLaxgIsVhV3SgXILzf5/uLUaE5jtLnfsxABMJY33e0Xhfdabob8i4JFHWvBaYE75IDBkafc1VffsM1DJdnmZKbviUoPezDL4iQT6X2+gUT5WWats6ndLCbeE1S4lhw2fYBieDrRPpGTVhVoC6SXkxSQAIJAQq9syQItcv/ofiB9zrp/GuNfxamv0yrwT12BWXrjQhKIvqJkABgbFiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIc9XmJrKSeo8/+txte4p6CC86yFuF2x/k5B+enT1EU=;
 b=f5Pc15/r4KnjunvYD/3DtmGauGOYksoYtJQ3YaQLDPNesj3TTAjYKU0U9lvoiuGjdheTsM2gj2ZmI964Gp8bftmK0247jvcoUneZ+gdKn/uYg/xw84YNQQTGvDNFcU8U3q2YC3VRdfR9bqHwDDr7ZuKVNd7fOFywkQS1xaVH+N/tXpMmqvGlU/zUpZmdHpkdBcGJGLcqk9crfRoCn1p3npWabgWCY34ybaYDUQelxYHX1IOeQ3fLnjmY7dvkrOF0G5REj7l7WBOBTsrl1k11t9gtEoUQjlg9WirEVO1R5DE6lmg3y4/IskoCghZSzbctImkEWqj6TVypqKxMZ7Ficw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIc9XmJrKSeo8/+txte4p6CC86yFuF2x/k5B+enT1EU=;
 b=ikaaA3kl/LxcN+miRzjPGaJb9hgNk9yyUMrVB1DqtmSglkXRJ7zDmLqr3hVwrMPs/ssKLPGobb683PhbYDk2ZDEK/HKsiRsneSYah4kru4WQ1Ivs8wxlikMfbOUBqS1C8o+nPcNQ/ujRKv3WVmZfmdHQoEM/45q7peRTkTl/MBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0966.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 17 Jun
 2021 16:03:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:37 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 031/256] cl8k: add cap.h
Date:   Thu, 17 Jun 2021 15:58:38 +0000
Message-Id: <20210617160223.160998-32-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b73210cd-8c08-4751-985f-08d931a96635
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09665181A776E745ADB297E0F60E9@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaqjKhS7A5X4600qrHQ1N08DbgQu1yrgkNXd4107d4DSnwn2jxkad9N/jpM2h7eVi4rEXV4N9bN5NAosBxIH8HLY7mFGb3sKoc3PlvpTDglEqTF4peK9oXLadXc/1M/MtJPpldusKN/5hNtEflM7YiysnbBum9nH0q4SxbhjZF2nx8GWTrsQqymsxiYrkgmTWvq9XxJfu+bihq5VZ3kzwXtOkteLorGZHoiH8P8T2y9ljEDomr9Q+wYDKbmUSCHdyYXhyYPBf1EKczgCm498Ye9nQUmZ7FTGN8GtiA6w+hwJFJI0MNMjIugngUJbSfw1OO4SE6muSY5d20rHPgf/oJ7vRMNNKZCCAeyvv/Rrb0v69Nw5hJ+dsFsDZNsS8G24LdLCPzqiaBh4BbvBZgf/wUpxLslWFD53wbN8PUwGr1qmpAnRyqanKRPrRRbnPgfyelmA4HM84po+fOmCB0njLimnPSchSgfSzOu6odILiBhk1wrXrp9qotQRzhtDntvnlq7p8chNOjTEY5cDsNqOZ+sI/RKsiwfUJZpu+iRTeREGyHqoArHwblDzGYmvjoRK28qe7BKOwoPwfmUm0559klJ/u9XH2eHG/0AYOVVASdJ+8G4Xip9OEON2fs2EKiNsHXPaUnDVrbiYhGdSPhPEMc/f+XsaIz4b+oUEnm+JDDvgT0XzvIUTRhKiVw73PO5V9OAvTi2vYaHPVWt5G41u6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(4326008)(1076003)(2616005)(8676002)(186003)(6512007)(6486002)(107886003)(83380400001)(6916009)(38100700002)(55236004)(316002)(16526019)(6506007)(38350700002)(6666004)(54906003)(8936002)(26005)(508600001)(36756003)(2906002)(9686003)(52116002)(956004)(5660300002)(66946007)(66556008)(66476007)(86362001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tbwue881yQ85eXNpKPRrq1hOCeaR49rw9kJUu6sbr+CkKOSF2Xfjtl9f9SY?=
 =?us-ascii?Q?DpPu+6eWpAQ3GRa1lqIvPCl+LokfGZP8uw+B29ZKhhEJNz3w+xULQJfDx66t?=
 =?us-ascii?Q?j9QJoqFngpks5rVO4PxeBQgA6czXh5b+Kssc6gnbu65LwzhnS0zQb2mLiObw?=
 =?us-ascii?Q?fcJVjr5ZsaFXCRFKcQGF0KC4PcmtNHkIvVLcOXeyCNHMTx4Dvg3wbeQ690d0?=
 =?us-ascii?Q?mjVZxdUXN2y3Jz1UmzKKA4nXJiH0dcACUdn/XPEQu4/Xl9a41dtme18lMGvT?=
 =?us-ascii?Q?LWz1DsPsIQ9IG119Y7gu6L+uaoZ2lUeM6WgR6UR/Y4/NHOL4HU0zfiiV1zFT?=
 =?us-ascii?Q?/lLdCJCjLW0TS3uhNyg8J2ptMhlMjKlztjjUcqqTuPlprp8tU768TlJcteWu?=
 =?us-ascii?Q?/VRx/Rz35LCfPuIev+0/+cDZxJXmCRjxknCe0Bg0cVttEqHfBXp1Qs0DLlCg?=
 =?us-ascii?Q?08nJB7kH0QAP8h4ME/s+dWVCeswubwElr5sjVaLmpt6riQI8YONtRe0p7bMV?=
 =?us-ascii?Q?PLLxRsCiev/pd9ADGG2EVu7AZj/QsmwT9Dz57SvvPZrT/HP+pLdTqdFrd/8m?=
 =?us-ascii?Q?pjrGNQM+2TFMHQ5iX2suIVHrlXUIylP68MVGi1I1M4FA4KYoElAFlDuxYvmS?=
 =?us-ascii?Q?dRfsUvctBuXmHb31gYrMUKlCHurllBhITviQ2Yv2Gk5VNwdOodoJeLWJxIdp?=
 =?us-ascii?Q?gGR6ICPR94F4lhb5tZ6Rc0Iq3Ev9spwhRpsgTc4wyDdsf9KiyA6gF3OKvVYw?=
 =?us-ascii?Q?jcGYNBy/y3NUoGYBpZif/zWUM19NqiwXHzhTfMQC0x6mric42BXiasXes9DL?=
 =?us-ascii?Q?Y/jCtvWdP/icKFVA5z8krroNNfjHrLvlg8pPY64PHatgkOdrZn24J2agbwUR?=
 =?us-ascii?Q?NNYh5XNBlXaY7yh/uOOjBQQj/DxLBpGH+ZZGekr05+YbVTvH0UV2njfTq8ll?=
 =?us-ascii?Q?oxbdFdbw/X1hiu6vgvoAcKd83e+ShvSybKwsfTTN7OiReLwuDAMjlXAkW8PQ?=
 =?us-ascii?Q?a2jB+Fu11c0fwXtvLs/iIVMGFXd8UPPOaueFq5SlTwFd+iey+ZZTGmXh9pnR?=
 =?us-ascii?Q?sWBy/mu3t+D8RMAlYRctQX7s6aUHcjRIuUjncVuXyHJXXBIatTzSqG6c6VCt?=
 =?us-ascii?Q?WthnDOwQM/ifaPdvVILAg08chTO9NEvqL1LWicTxaMu0Sz/vw+A/v5cA9NvB?=
 =?us-ascii?Q?rjMtdBrNNS/79i1wasF+xyIMHn2c1NRbedklR0V3PfqpNQ7s1NG39xvzf2vm?=
 =?us-ascii?Q?FR4+AvARdBqfKFBDliSpeQusKYpIYtOS0HTpU9+1NsDoYvQm1GXYvVQCZPDP?=
 =?us-ascii?Q?ebxv5fNk03M9WQoRAP42efC9?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73210cd-8c08-4751-985f-08d931a96635
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:08.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACcLOqxUb2szT/63coXuo3S/ikmm3/Z2hsgiv1tli/Zed40MAEXyO8ADe3GUmQJzYuzlOaghh2PirqocIHacsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/cap.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/cap.h

diff --git a/drivers/net/wireless/celeno/cl8k/cap.h b/drivers/net/wireless/=
celeno/cl8k/cap.h
new file mode 100644
index 000000000000..5bbbccf3daaa
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/cap.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CAP_H
+#define CL_CAP_H
+
+#include "hw.h"
+
+/**
+ * Capabilities indication to the cfg80211/mac80211 layer
+ */
+
+#define PPE_0US 0
+#define PPE_8US 1
+#define PPE_16US 2
+
+void cl_cap_dyn_params(struct cl_hw *cl_hw);
+void cl_cap_ppe_duration(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+                        u8 pe_dur[CHNL_BW_MAX][WRS_MCS_MAX_HE]);
+
+#endif /* CL_CAP_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

