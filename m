Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BDC532949
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiEXLjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiEXLjJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:09 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC084C798
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2AV93BXhaOcjxhghbc1YFiVqj6LZih9teOdGGeZG9IPz7BrF0GjCPK8esax1TzEkcvkGkKXklBN1j4uPtWrTPXmQRkS0oFpg4VFYke/Spp771UsyuYW5rOvYSv+uAu3dc0TLxkdGrORhMsM0zizf/iMdLfkRnd+b+2JTJHa8EQXOpgbAjU/SIouRbaC081QT4TR6CASUJvH2N6xFbPGV7Xbm13tgjM8ksboYtGjqgVJQNtM3PlpX8zcuQ/P0gIhx8+voe3OEWp4B0l5OG/VEVh515M72oEDXAaJ/ruA2UYce3z6XWLJVlkRieYBjDZ0+zfSkStQJwcM/PIAAMsgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANHk5HwYOQqmnM3pCOWHh74wQPfY+TLoRLdTniWTask=;
 b=hGpBBdOq7uh1zQmqp5SNzpvNQ95O52F7TaqkWwUg9aQZwiM7UT1N8uwJHTxmWTUMEemKGYEqZGlCx4zlnjmnt56EUYK3/jWurOjIifEM8pqTkqXN8j6N8LTsOQcip3Udp6jw4B5o9W11jJ1eFbiF08AsQU+4zvEdEAR0/JG3G85hiLuKdbBQn0XWb3EK35CjC6QRglVltgqAJxS+zAa5wfEN6NEpokyRfF9N7mllHwPlQtYUYf8GElDyVIJ4ijKXO4N/ujQlbgxTHDFw4R3VUTE60YRcPhbzBeRA6SPv2yMKQgRaJZ+4I32T4fPLoeimc9Muyp1vqe+iG7m/ASgk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANHk5HwYOQqmnM3pCOWHh74wQPfY+TLoRLdTniWTask=;
 b=s5PLvf/k0nJswuArXQbuuhpCGVFbzAiMpqLO+9jk7MHfqsruhy35ZH6AzULCQw5vTt0UmQABylsxOAauspwvT8YC/6pbnGOEbOK45ky9GWo8x2CbBIg+F2mP8hBthPBPdjNsp8yhN9XKPTBBKN7VquHzcyqAn9FhxJAi3mRxbeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:46 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 47/96] cl8k: add motion_sense.h
Date:   Tue, 24 May 2022 14:34:13 +0300
Message-Id: <20220524113502.1094459-48-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8152312f-340d-48f3-3594-08da3d79ea25
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571757CDC21EBEFA1038564F6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzh7l82O5QR+TBKka9ZGiSkWCnFXINeYTdOugOcTfevHjsa1c9dMloj++lrim0Pqlg30wZVBR0vbC1/CGmT7T4dhT76h05unaF96mwJDDJvzLNp1869SswXFfyZCHH7a0zRTGlU7IR1x0mVyCjQwrKmDGAjPvCWENHw2BVNVnmr81QLUQNyQ/em/xMo2gHUMAvCJzcOirpFzhPWH3WeQgy2tM8eM7tvSXr/XyGHpX84czo9jm+UMusquWstbsIwHs8fV5c4FRHcn2YgEkYkp1Cgyo9TgS5ohqowheuNdQRFXXuuUunktEWYqQBZXxnuibhjyaq9TL7SxLY8Ej78AxgtbnYzvRXZExXiLi1o/YQdn3CtOxgD55AI1s2ZJSpjpnvG9ere482YejtC46n4gqhQDqG73vuS5qfttmRXEyXA7vxMF8OLymnm2dZIZlNK+4l1yf59x770sU5dUDMBXt+H7ZoXB88Tlo7Q4q7Ee1MGd7H96Dkaoa70c0bj/q7rr4I1TUTdEmFQB3B73iHDr9jCBF0ABrrYvPkESbaeDJRrJCzl+oWG5Ocg4dM3HvviSkAAGGRBY7a2KN7Xhhoxd8hjQ3moI1+v94Pyi7QZw8W+WjiTeAqXnclRQe2H9m3oc9VptuC3jcbK0M3DiI4CfzKN6YfTohyc5PX8qeuRu3fJ/MAZH+oLGpHro63yIKnkOdRbGZf4tR3R5wjNHuBr/+PHzcwJbb7ORLa6SgQuBaxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mhSwmdXo1uuRr9t4QdDAeIkJfpE5dqiRt84t9f6mcKKfdvN/YbIgCFLEUs1?=
 =?us-ascii?Q?1U5+uJeG0DGdY4t5apWXBJxLWYmFkhQx1ePtYXyc2071QfsAamXNVqR8Ipcu?=
 =?us-ascii?Q?hmJMLHHQ8tPpUY2aaCF0Cnu+MkYnIDM1zt+5RIqjjP+z7BdEIxoQUt3osAq2?=
 =?us-ascii?Q?UOmjV8N+/AxfD0ktDaimLlwFCWNkXzq30ENFp1I9lIOvUWjfqr9lrvIsCwN2?=
 =?us-ascii?Q?967ghkAmypS+Wv1z0IMxNz1DL3gdEj5ecmsZETysycIjl+yj3iqFGavzBJaX?=
 =?us-ascii?Q?+vXGVULaTTX4g5g+xIkE02pRO0i3jAFyrSZnI+FKAg6MWfQkQAL8lV15Hdad?=
 =?us-ascii?Q?h7zERLPzuq6wt1xylvm/cHjTaxQUI6m72HzjztTlMD3xYBiEP0jfDdpE6PDh?=
 =?us-ascii?Q?YnWV3/pt97xzUkepsqMz3AGfJH1nNtYFMXLfE0hTIGnR2ScPULe1lmP07d6i?=
 =?us-ascii?Q?BDUJV7J2zfRzoBa0YEeKZTsIiUzqWjkvUZZ+xHJbmqaZ+fyd7gj9Kd0s8064?=
 =?us-ascii?Q?7HdVvw/0GRJ9zUk+upkZbsQ/4DrjBCJR4hmhocd0kHyZJAw/mb4J/2q9okDh?=
 =?us-ascii?Q?Ar964kM8bQhsHOTXg4YxumqWkubZLn2TcpNwIFVF9ZmV9YnrfQ/40F1lsXCZ?=
 =?us-ascii?Q?WMfRMBoqs7vgSRG82xcnIjDwONQYAQhb1RDcnP7fkxMPmB06YJ8WubL1TXEs?=
 =?us-ascii?Q?FhWYMxKlvC+2s34H0thzZoWNjl+2nrXnQSLAlCI5qr20u9tiMRmmgPXtTUvB?=
 =?us-ascii?Q?EPXp/GtJ5jgXbrtLGml45hS9qAL+OngjHxFWgMAF3scrZ745BgHfBbYscrwt?=
 =?us-ascii?Q?yqdM5BCZBIWGB8VngMz9VE+7VkwyRcs3fxbmrAkhOfLlP8mDEU5yjk4UULLy?=
 =?us-ascii?Q?cfXaDNc2j2xdRC7XDkx3LsdjPmnrdtgd1XsazyhmIoiaiwcaamPSm4XH78Io?=
 =?us-ascii?Q?81vdiNOTzeolPmSbhLEtKTmtlAHnr20RRVL+/BXmxifD1ynBX8CT+la9B4zf?=
 =?us-ascii?Q?u5igy+4UXKyC6SkdYH6XTSd7HZbZNlLUTV69CnlV2IWzHEyw4eFIWLCEJsDJ?=
 =?us-ascii?Q?8i8ptMsLwPelANzT250yJ90ZCAYhxsTRk8tWCI49EJxpnfzph+szNznESZqx?=
 =?us-ascii?Q?ahEoGaC04AG0YYFrkdzM8JbyKvTIRyLxnXifgwgfmTQ+chP3I1MVQybcMhVl?=
 =?us-ascii?Q?bZAk8xm+ibJM+NoQhZGMMjYNtF+l0xVhLowpXeneCefZ+IthCcQ3FNnzCpd9?=
 =?us-ascii?Q?rXJcPpoCzwtnQ9tHGKUQQkZ922n6MpdAX78A+os2fWrnm5rD/DxmdPNeGdJl?=
 =?us-ascii?Q?io98VAzpv2cvpWB6Nlcaw5tuHwykxHPj3qcnRWvFohyblzduQd6xn+9nnHzy?=
 =?us-ascii?Q?RbTL97yGp1OAkByCEC+MOeWpTeBymJfX8kd5xjQpj+OSCJgQZbf0j8O8w6BZ?=
 =?us-ascii?Q?w+CRlWR2Ey9yXlaorRXgwbsCoTaaJV9Sh5R2rLc4oq2+92OW9KlJpdbZjxO6?=
 =?us-ascii?Q?6VoS9Tu2z/RhoNby2zabkyoi1+bwAl8YL0DuRvh0BdCPPETdJGKPHI7EfXQv?=
 =?us-ascii?Q?umyzmixUrPaO118PEIVUS0RmvKiZPj41ePHo4LcJdPjEDvxPuimcCddhGBVZ?=
 =?us-ascii?Q?Zsw4N2zoOfXZ1LenohS+nBZT6BuEyTXJblFC7Krmf34oXz3nk7Efl8iRDyU5?=
 =?us-ascii?Q?oNwRLYJW8WzkpdvocE6zeVZ1L2Vz3cbOc1XVhsN7YGpYEXMaNRgsjER6sAgq?=
 =?us-ascii?Q?lwaldmIil+p5UAoJJDeFXjigWPFDOM8=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8152312f-340d-48f3-3594-08da3d79ea25
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:25.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2viNaYwBKBArlWYoz1gqILrB61H+xz3GLeT8sho9vIdaFGzMop4mQnJbRTzofKMlrP9EOdCp7ZDlnW/PHIenhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/motion_sense.h   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.h

diff --git a/drivers/net/wireless/celeno/cl8k/motion_sense.h b/drivers/net/wireless/celeno/cl8k/motion_sense.h
new file mode 100644
index 000000000000..9ea63f561a92
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/motion_sense.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_MOTION_SENSE_H
+#define CL_MOTION_SENSE_H
+
+#include <linux/types.h>
+
+#include "rx.h"
+
+#define MOTION_SENSE_SIZE 30
+
+enum cl_motion_state {
+	STATE_NULL,
+	STATE_MOVING,
+	STATE_STATIC
+};
+
+struct cl_motion_rssi {
+	s32 sum[MAX_ANTENNAS];
+	s32 cnt;
+	s8 history[MOTION_SENSE_SIZE];
+	u8 idx;
+	s8 max;
+	s8 min;
+	enum cl_motion_state state;
+};
+
+struct cl_motion_sense {
+	struct cl_motion_rssi rssi_mgmt_ctl;
+	struct cl_motion_rssi rssi_data;
+	struct cl_motion_rssi rssi_ba;
+	enum cl_motion_state combined_state;
+	enum cl_motion_state forced_state;
+};
+
+void cl_motion_sense_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_motion_sense_rssi_mgmt_ctl(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				   struct hw_rxhdr *rxhdr);
+void cl_motion_sense_rssi_data(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       struct hw_rxhdr *rxhdr);
+void cl_motion_sense_rssi_ba(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rssi[MAX_ANTENNAS]);
+void cl_motion_sense_maintenance(struct cl_hw *cl_hw);
+bool cl_motion_sense_is_static(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+
+#endif /* CL_MOTION_SENSE_H */
-- 
2.36.1

