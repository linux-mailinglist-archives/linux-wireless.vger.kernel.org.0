Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA713AB920
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhFQQMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:50 -0400
Received: from mail-db8eur05on2083.outbound.protection.outlook.com ([40.107.20.83]:54592
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231196AbhFQQLq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIg8U1JJF837EIACupFbGxbbICbV0QW5CxZIC8fZAwNza69fSWq7u14T0kHZv9SCo2lqVxrv9kntwyUfF5ss+7oj3KbLU37pm/PSYsuMyaBhoD7+jmMD280e2I06F156zxzsJUUBRTcFUL+yHCY4BEzHX9qRUvZO0jmx4bxA5GH4THKWk9JBYx0FTc/8G7fokc7kV2Zhq67sYQ5xdEajVZuU4BNlvChYHNNDCLcCa0nWNFn3cO29rpkEFzPwOE06y7K8dscMBUu5dXMPR8YpSukHxwAmm+Q/d51A5D2kGHvfqETgmzrAnk7jkS0dGvV+SwuAAhZDL1LFjoQmnaa1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HptxUT8lsxJVlBKSUc/uzT4Bxm30hRzP+5ZLopMe08=;
 b=QdPI3GaqXLerIuOfvnfyQuiHkNeofXQ+s67g/sBCloJneivN+uQop3vA1eYQrTdn+qEtIAzQNu34jxqYaz3nFspKP4BYv25UZ7DZibabSgkjDYrjTmzqSBQlpBenYAt2stHDzcJHfi1p76u8kDMdzerCfxMoDv6oP2KrCWrql/tUUDYqXQTMtUH3W31nbNY5/DyHWr3qZa2Q1Rz3h51hm6ulkBDjEKKHZHH4NqGYhRJ7kj9U67XInE9v4MNAV0DWLAWoc+QbGL6LV7UcsaVTXnAxFBomR0fx9A6EOIjRxup+UpyS1sOyQyCfLkqwRBhaI0wJbe6DjHbRSJG3TPeorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HptxUT8lsxJVlBKSUc/uzT4Bxm30hRzP+5ZLopMe08=;
 b=JqP38W8ss4uHrn7hobGLbQxoims/oUoE/5usK+Q6NQnnYVsY5UBQCvgYrgwa8EOHxCzPZZbJUCmhYGAO4b8oplLGZdF7xvI0Cp/Cozn2IZDxbBOTtnweTvJp0cEdljeW5Omkqdh/kV9HpdcUxjiCB5I8H/jFt0IfS0eia5g6BaI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:08:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:37 +0000
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
Subject: [RFC v1 255/256] cl8k: add wrs/wrs_tables.h
Date:   Thu, 17 Jun 2021 16:02:22 +0000
Message-Id: <20210617160223.160998-256-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0acb7621-d6a9-4929-8d57-08d931a9fc11
X-MS-TrafficTypeDiagnostic: AM9P192MB1014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB10145308BC70D20B1D6833B8F60E9@AM9P192MB1014.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bf2rY+inH4A2WHNpADYfsAxG838SNKyoVmpVBxqP3EYvtx4Al+Rm0F9g2HJxhcOMZBOL9QMeqJSTU/9INp2rOqfHj/cyu60xEO9CCvRh405fTIrq3cPidDJ52q2bAdMN2krLc+Ph+0Fopm91iYYp7CMJ/9tponj68q2hOm26Qhry1kdqWlrkH3Hp/J+FHnTLcYRBMDtqPY1YmlseOyiFEKMQ98E8lyTripU9mf7jWoU6js/yJXE8fpWxxp2phuzSGmSFBReGUZZiaoI43ukZ7j1ssln1ltibBnf/2t4DfrXw0zJ4aNDI4HEb/ItU54mPieRWz0DFsiVE0vSTyW+zCNB0TOGGqhN68VOykGoW8qImEn1JTfmq4m24mB9kV5f9Dz8Qgczl4WjYhNrgYvuFtu32DbKai5BZKBR9p8+Z2zYS7eLivgKqT6LgVJWYvyyMTtov2uLqDdVSiqJx4UtwqufTTvnnwUVGd1odbMNXfiW4D6d68AgbCKeYTn4RfiBYhlRQbyOqcWg4bSwVWKuAKsX5mWGLt9v51fus/m1V5FTXIn6IPDLYp76hAmy6jcmS8dI+mPm5VIYDJ16yNwOSJXDprkte4+cgewLEc7r4H+KjMOLgQzIY06UYmycf+1FatmyuHcOglNfK9ETfiOCp1kLnVzic8tM9BWNghX0GPzlysAgCyJqFwt/L9EQAMcQyXA9r8JLl6eEh7sXweKNBuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(376002)(396003)(136003)(316002)(86362001)(66946007)(54906003)(4326008)(956004)(55236004)(66556008)(66476007)(508600001)(36756003)(8676002)(26005)(2616005)(6666004)(5660300002)(6506007)(107886003)(6916009)(83380400001)(2906002)(52116002)(1076003)(16526019)(38350700002)(38100700002)(6486002)(8936002)(186003)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nHIdfwpU05T3R3iGGj2QTrPsLxjb96astKArziWAFJun0NwZgMOk7BUO0Axm?=
 =?us-ascii?Q?93dDDnDC/URymQJaCnwoCV836nzdMq44CqVlJUvzviMmspZ+BP0QIfnEKlVm?=
 =?us-ascii?Q?SJsJs46tcDDfOP+wHIf5hmxjrUUibNE6NVtHnKaAmJJMylGtxtQenOgphQn7?=
 =?us-ascii?Q?LSuz3cqWmVILPQcAdSDebKjgylr/Ek7oI9kWoFmXIMu6IO/DV0sm3cKbVDwy?=
 =?us-ascii?Q?+rhAYy52UsGfROB9vmCpa7Zy2j48kyK9UUsNf4beSGl1wr1GQa6QRUHU/akQ?=
 =?us-ascii?Q?S6lgZbpmkJ6XI+6jdS+Oj+wESTJYvfArNQX8jGsGQjwHlqYzZVLNVnMRl9uH?=
 =?us-ascii?Q?LkfbnW16INO4oA3PJhMtJ5Lo3CeLmo67OwHYsi4E/ymUfO2qE7Yfprza1w5q?=
 =?us-ascii?Q?AU8MQbtZItDd+XmfPb1s/+0hLB8HqGNQKcY8Xsb4eA5Iujm3w/LcjzqcgVdl?=
 =?us-ascii?Q?3N4dMcMDFQkf/lUaOTbNGinjcYdDIc6jfMa4lZAciVb2plQP7YGXGb6qPXmS?=
 =?us-ascii?Q?AZGpQqySUCOKXW5nw8A6P9Bq/jV/fOW8zLeMzuDSoQJovMtzkM5Mh3vmCVDk?=
 =?us-ascii?Q?S7MgqiVQaAyzUrZQg6pTMqj/K180vM0+hJmOT791gzSHS56fU1bUbXXJbEFG?=
 =?us-ascii?Q?1X2IjGsAUQzR6wPsp4Uq69zkDONVC8tsfzr+LR5jX3nk0lOFUB8Vuldh3c42?=
 =?us-ascii?Q?6QbJ2bQYfL0CFnBZJJiMaXWFzyogJeiMxTjd8tWnl4EHDsiD8sGbATiKqHnH?=
 =?us-ascii?Q?TGpea9dBc1qx2wAim7h2kW21E11mPGU1rmM1hnJ0IW88mik6H4RxhZcGv6HT?=
 =?us-ascii?Q?pKLCh/IyLUNYe36rpVNoBEik1c1mH4/TQeXDuAVS/AArCGVvZc8657fvH+bV?=
 =?us-ascii?Q?u48nNfxfyzxWnGwUQZJCNjrOVfc1asDCUJvQ0EDuUSfiNNO+BVZ70DOW+Zrz?=
 =?us-ascii?Q?1watkKAz9Fwm21DkPuafwOQT1Due/dS/6atSaMW31lZkqjbAS24+1an7WL14?=
 =?us-ascii?Q?jiUFIjxZR0NKkUd1kEeyqG7lWxXRY4iGkPIsWI+vMv0ABRvhut7bGyvNZ2Vl?=
 =?us-ascii?Q?8jz78nz+/tP+66zBvju7B5OqDPiAC+/CNKZUnNnookalVE8EgOcS0cKfxex1?=
 =?us-ascii?Q?etws+VuGJ/XfeOM/aKIuS1hY3klB5NIWG7ANk9zv17vaQM2pyQxXcddCOgXd?=
 =?us-ascii?Q?I7qCFR6P805f8gP2EA52Ntr+8yKHhNdvncV4aOn9Lk8bFrZvnPbJB8pGW2KU?=
 =?us-ascii?Q?weYAZZGn2JplgfgvhiR0fPZI43rnj2DElQetf1gvnhOxEbKt1YpIGqw7QQZX?=
 =?us-ascii?Q?1AALJQbkoUOnE1X5LePNF4kM?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acb7621-d6a9-4929-8d57-08d931a9fc11
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:19.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBwzQJ3a910liFBncVOeyacGMhXhjLW1ACa35/W33maO2xcGzAmXerNvtgbawWXCy9WiR8YbtpK8ba/nZqCOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1014
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_tables.h | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.h b/drivers/ne=
t/wireless/celeno/cl8k/wrs/wrs_tables.h
new file mode 100644
index 000000000000..250755533f28
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_TABLES_H
+#define CL_WRS_TABLES_H
+
+#include <linux/types.h>
+
+/* Rate Table Size */
+#define WRS_HE_RATE_TABLE_SIZE     (WRS_MCS_MAX_HE * WRS_SS_MAX * CHNL_BW_=
MAX * WRS_GI_MAX_HE)
+#define WRS_HT_VHT_RATE_TABLE_SIZE (WRS_MCS_MAX_VHT * WRS_SS_MAX * CHNL_BW=
_MAX * WRS_GI_MAX_VHT)
+
+/* Initial Thresholds */
+#define WRS_INIT_MSEC_WEIGHT_DOWN  (WRS_MAINTENANCE_PERIOD_MS * 3) /* Msec=
 */
+#define WRS_INIT_MSEC_WEIGHT_UP    (WRS_MAINTENANCE_PERIOD_MS * 3) /* Msec=
 */
+
+#define WRS_MSEC_WEIGHT_MIN        (WRS_MAINTENANCE_PERIOD_MS * 2) /* Msec=
 */
+#define WRS_MSEC_WEIGHT_MAX_UP     30000 /* Msec */
+#define WRS_MSEC_WEIGHT_MAX_DOWN   4000  /* Msec */
+#define WRS_MSEC_STEP_DOWN         5000  /* Msec */
+#define WRS_MSEC_STEP_UP_SAME      1000  /* Msec */
+#define WRS_INVALID_RATE           ((u16)(~0))
+
+enum cl_wrs_table_node_up {
+       WRS_TABLE_NODE_UP_MCS,
+       WRS_TABLE_NODE_UP_BW,
+       WRS_TABLE_NODE_UP_NSS,
+       WRS_TABLE_NODE_UP_BF,
+       WRS_TABLE_NODE_UP_GI,
+
+       WRS_TABLE_NODE_UP_MAX
+};
+
+struct cl_wrs_table_validity {
+       bool is_valid;
+       u16 new_rate_idx;
+};
+
+struct cl_wrs_table_node {
+       u16 rate_idx;
+       u16 time_th;
+       bool quick_up_check;
+};
+
+struct cl_wrs_rate {
+       u16 mcs : 4,
+           nss : 3,
+           bw  : 2,
+           gi  : 2,
+           rsv : 2;
+};
+
+struct cl_wrs_table {
+       struct cl_wrs_rate rate;
+       struct cl_wrs_table_node rate_down;
+       struct cl_wrs_table_node rate_up[WRS_TABLE_NODE_UP_MAX];
+       u32 frames_total;
+       u32 ba_not_rcv_total;
+       u64 epr_acc;
+};
+
+struct cl_hw;
+struct cl_wrs_db;
+struct cl_wrs_sta;
+struct cl_wrs_params;
+
+void cl_wrs_tables_global_build(void);
+void cl_wrs_tables_print(struct cl_hw *cl_hw, struct cl_wrs_params *wrs_pa=
rams);
+void cl_wrs_tables_reset(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_=
sta,
+                        struct cl_wrs_params *wrs_params);
+void cl_wrs_tables_build(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+                        struct cl_wrs_params *wrs_params);
+u16 cl_wrs_tables_find_rate_idx(struct cl_wrs_params *wrs_params,
+                               u8 bw, u8 nss, u8 mcs, u8 gi);
+
+#endif /* CL_WRS_TABLES_H */
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

