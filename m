Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C93AB946
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhFQQOI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:14:08 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:36864
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230217AbhFQQNC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:13:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6kiNRRbJvdfzMdFDL5FRsljgFiVAPIukLURWERrwBzpj4AX2DCcZnMZonHpQ+YGgHtRO7XXxS4vkrauk05ciUSnM21wmxmsJ7E8iBksNeNl4nuQE0w9QT9IV7PYiVagbOxvU+CMbJxV4C78h48XHrRDdPJzdRr2ithWGLVMyZYvkd63P5mLyU704TulXA5CFyzH2GBk1WpFSEQUWnakLnQjgRDXvKzYxAbdKtZkzotlAYCRaJYuOmieW5yCgXU+gZyye1NMRu5S0CJu7G9cFwFoKS7mGqHlSf6DTelDtDUGzY5+dfPGF6qvOMoaTqWFKD44XRuQ1zOojrGi4QASAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rei7KdCF2VCadfU16T4RbQVJDr+hC1d+W6L5PGjkau0=;
 b=LhzA+Rh5KX1QkLNzGC5WYk3LxPrAEXwRGsAQYGnJyST6OPCFDIKX7xB9+EgQPPxYrY+KZ9cnxpEWSwHtZp4MPeKqk3V07zYsO64c+sTXOChFXd/BoDouLvjie7AFzJes6d/wv5gNPzK5ur8K6003s/hRbUhMPLzzZh5+qamCDW0xG5z8N38An4eAu0Qm74gfbqK3bbjoOBxvdpee26T/oDWbOHZCpI52u2T0EYEu+Z/cHTy8MN/4LYHLpMx1tMv06q9hLVYys32Z3Oz1OvwxGUBtXXcZIU2sJvPjiLojTzTteROsfRqxTLaSY6IFPdR8QCbtuUMVEEg2f1pZtwBPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rei7KdCF2VCadfU16T4RbQVJDr+hC1d+W6L5PGjkau0=;
 b=0y26qD12s0Z93u1364qZ35eBubFn+kqQSxsQy57se6TPvT+dI3dvyyi+mpXC6iRXF0x4Lf4DGgP+PGruq1WhKmdYFQSsmANDhN07fMh53ROod0C8X3ldEn0IgdEcHEvyNA4uPi7YMR9JliY6YQK55e0w7NKWdbZpYtzH18ApMbE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:36 +0000
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
Subject: [RFC v1 251/256] cl8k: add wrs/wrs_sta.h
Date:   Thu, 17 Jun 2021 16:02:18 +0000
Message-Id: <20210617160223.160998-252-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1dcf2b1-4557-4b3a-d96c-08d931a9f92d
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB09783FA6C931D59DB31F1BA4F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjU97uA87WBbFR3UBNx9HZEHWTCkKLXM6/yj+pSZ15K5ek+qFyX+zab9TOYFglyxTjJ9qbQrbshzYurMhAFS2YKAEWIoE8JpbuzVeLJwb2xJLwHZyq391ucVpMPYmLYC7Fac1OWLjT1xTGLlb+p6sOJ1kCixro3f2Rkubsa+wrUnouZsOtrUiKeJbIX2SjEqcnAyEq9hRrSjWEkmmKdXvnIffiLhnTleAKbscoE1j2xR/NndxvwDteWAOkISvGeNdrbgMea9kcBQhOOOFBsiVKbAlXkMIRzZ0Wek9unQFV9JDtvzp2wh3BK9PeQguCM5Km2NU/rudZ0lyVKmmS3D1G/VrKWGt83pUyyYwbnKOldQ6lOsmA8yaTwkI0Iz4RIzIY4T0SRgT6BqgMeQhKLWSBxseYas6/RhSY6z5Fau4Qy+0oHttYkG8WbiqzdGd0nv57A9kkUdMlr2Jo8OaBZbJUlzBTJP5Ir1UQQjXDkKO9P35+SQT/9rzsCKF+IepStCfHAZv/VNgF6BfcRKPkTfZceec5520reZsF9Bc+mYF0ZXZr+m+J7FTAQNV7wRHCkG9TvfweqR7fzEdKow6APSd+YHOEBqcFYrSOMrwMSQEVWmNkKUsHqsax1kBV25EEAIOiA0m432ztwciNcp09jqnCpLmQ+nUeoI/7qOTujlr8N8//OAMoDHTprcBFieXPBqKcrZ2RmNOPsc2RgpF3Ag2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+0dUeI4qkKw37pRRV3P2NmF05NrxCO8rQVwljiazVMWgb73rdg66NhJeR3CH?=
 =?us-ascii?Q?VxXvrsEb06aXTGKoLu5s57oAU2SoHwl2+RF+XcijowR5YO3/QbDqb2PFAyoV?=
 =?us-ascii?Q?+QeoaE7XYSjmuyxr0xfD33y15jiC71mFR4PO+uLdiD+YBQGNSDNJ0QL6WnUF?=
 =?us-ascii?Q?1Gfm4u03OoARUqd+075AhcTbh1aszmI4D/n/M5CFDaAbJqoCxOwRfIi6+rSb?=
 =?us-ascii?Q?nIPKK2tC79VAuH1K1ePMDt81G0ZHoXGXXjUwKirZ0FDpwIfxFF01txjZQbc2?=
 =?us-ascii?Q?qZ2SgnqA4zyyZiSqHbrmNBNU1d7+2asYwdaW5jHu+57a4BjA24vo7KTQOrUF?=
 =?us-ascii?Q?21WROla2ZkwZLkdtQmevYitys2pi+ngCq8MaFUGQ1hJNoQ2OA0ZHO8TOVA2N?=
 =?us-ascii?Q?XioY52sRIekNTQQLWXKUw22mINbhY+uFr+3CsbSqf+KpePOo622Eh/ZHIIwM?=
 =?us-ascii?Q?861rNOd6bcWQHABF95ZJ4RJEDOctmcVE7JYCaXl7GloP/SVo3aAnvXEDnE6h?=
 =?us-ascii?Q?xvwSbR0+YYYo0tKskMGkJ5uOVCkxlO+mJEI4Af90NzV3irys+OUElm7QH865?=
 =?us-ascii?Q?RZOyl5S71qr1DpYCkX1AxMK00f1l/5vYRYR9nYgavShWD1GPkyV4DtjMbqOg?=
 =?us-ascii?Q?0E/CBvt4cnWDE2kUZ6OXLjAZ9nhDva7DcMLs6fjP9qez9vJGzKP8348ujNbj?=
 =?us-ascii?Q?R1y4vM0MJr8EDYqJ+5nuU9U5ztjUSa3jOULXNu1B0ZorV6EUQ44rTmOnLswM?=
 =?us-ascii?Q?NbV3WRBMxhtVhGJm98POoRqKxJMfX7xWgf/9bgT3Mtcw2/vm+QY5QehZjgkm?=
 =?us-ascii?Q?L2TFFyvKUifGRxFR5fZ9lC2gx7zwRYTPM/UhcweQjGmGOLPaHlFenqa/UNEh?=
 =?us-ascii?Q?d+dM+ywVo1tMSoWXxOVNBRXFwFLdB5PeUmwCveFGUtLxPwNxt0euL8yQNFZ/?=
 =?us-ascii?Q?sBk5CPKs31pnWLV8VXpyta42wKzJvmZlEn+u1gtQaQDTllbjaG1TZw19FYTb?=
 =?us-ascii?Q?MiSCtNWvsvKuifQi9t70Ay7VVJYlqw/u6v/3ifw+KCoOOulf6+O0w8HHEiyG?=
 =?us-ascii?Q?C/r8SzjpfO4q6Q0NxKr/vjyHBE4BavVQFloJGoyo9cmJ9cOOKIqIoFWNNsxS?=
 =?us-ascii?Q?7REa/twQ8kSg+jzn918iZ1WwLcmBrdUcaTsfqfYvh7UUUxhDGZzPokd7ZY+0?=
 =?us-ascii?Q?7b7ZYwbowi5vy5Wlj9Ye2GqCbxDo3YC8difnfVR8YF7ojHhK/puRgYWv36yj?=
 =?us-ascii?Q?InZvffC5/xRvHx3WjwACiRO60QTTIfZm5K6iwTVbZGlNgeERkDBp++U3EujW?=
 =?us-ascii?Q?VabheMJeVmablvad8W+0sxhN?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dcf2b1-4557-4b3a-d96c-08d931a9f92d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:15.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNXo5290GN0MY7Es+W24va8l50uRWoe6+3p0jVLG4e2KyAbccrtbmJf16qFMJT4f+iEvvOVToq6JabhqkCPkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_sta.h    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.h b/drivers/net/w=
ireless/celeno/cl8k/wrs/wrs_sta.h
new file mode 100644
index 000000000000..a7a06f71c548
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_sta.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_STA_H
+#define CL_WRS_STA_H
+
+#include "wrs/wrs_db.h"
+#include "vif.h"
+#include "hw.h"
+
+void cl_wrs_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta);
+void cl_wrs_sta_remove(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, stru=
ct cl_sta *cl_sta);
+struct cl_wrs_sta *cl_wrs_sta_get(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_wrs_sta_print_list(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db);
+void cl_wrs_sta_select_first_rate(struct cl_hw *cl_hw, struct cl_wrs_db *w=
rs_db,
+                                 struct cl_wrs_sta *wrs_sta, struct cl_wrs=
_params *wrs_params);
+void cl_wrs_sta_capabilities_set(struct cl_wrs_db *wrs_db, struct ieee8021=
1_sta *sta);
+void cl_wrs_sta_set_supported_rate(struct cl_wrs_sta *wrs_sta, u8 bw, u8 n=
ss, u8 mcs);
+
+#endif /* CL_WRS_STA_H */
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

