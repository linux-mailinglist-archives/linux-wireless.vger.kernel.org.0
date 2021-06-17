Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E483AB914
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhFQQMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:22 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:36933
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233933AbhFQQLQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAB0dRzmN07j0OAb7vaW5VQmBDdQ3s0kec0CA5q81/jPbEqiB/vNWrgzQoQJJkqw3srlBIXas5RftGH4zaVoNUrv4wD63S55kerYffY1Bgt14uusEwjSHn0Efb6+8hU7V8EwlT1MVAwyuDP7j2gzYuYRCmyco5u25sO+Zy03KVZKfcv7UfwZC53HaqUM9ZeDgYAB+DooyboJM6hRZEW9gfXjV5yJCQtTcBFeLoWRpqImvm3MQqRQR2oSfVMs9m4OTvwaUPrHo4qQIdaUBJbG0vbU78r+kX/ya8uSw4huGh8LP9IRB9MQKToNSHAx9UqvGUrOoeFsSmadIqlAw+7Deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N5tuTY8MeA/SqUy4cLwcRZLrPtFaUfkWEYDrkKQ32s=;
 b=fY+hmtYOIp0bXrgiWi3AnUaWb9vowHnDaaTVanBmcdpeM/2S7fPcOkahZK64UDFEHuVzWr1W6AWpYR1NFUkrlHnSN4gwydQEL/p3LAFG8FnKQTWHnyEKt1o3Xe8qE51+3TrJ6PwlEJooToDKAnIOp4yZg3/ITqcIK6XKF1xBDPQJjf2CN/aIdpggkIw55l4KQWlscbxOiGTBfLFH3qSuBJEfZW0b/woD3Cn/9udub8Tq/DbjdHceAGvTY7Hr+C11JZd1i577T0IrHNqXRwGks/0vPUY0oW+E5NEw8bTiFtPnfV0mPOur3y1XYXH0gUVgvcct+ay76cBcHAqgVLclwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N5tuTY8MeA/SqUy4cLwcRZLrPtFaUfkWEYDrkKQ32s=;
 b=yvSafP1eE1opsU4RI34W6Cv29XYjs0U/iwQwDobQLnBD9O8qkh8ML0fHuqrgFeKNj4hMTjJII4UyG+5ceYe9XDaMBZbwyn36+E6mupqcaKvYMvSr4lQ5EGIUO2awckq5gnlcFDa/3BDQNeDDw1qKBGnWGORyiDz1HRMwh02eCEE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
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
Subject: [RFC v1 253/256] cl8k: add wrs/wrs_stats.h
Date:   Thu, 17 Jun 2021 16:02:20 +0000
Message-Id: <20210617160223.160998-254-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8873fd94-0db1-49a8-3d9b-08d931a9fa81
X-MS-TrafficTypeDiagnostic: AM9P192MB1014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB101491C96EBBBA7B987A08BEF60E9@AM9P192MB1014.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glylfrWB11omQPG7Rm/nlBV7PWU3s2OFCspxt1ymbf00DnOPbnlK1b8K0BHXLJhKZDvb3Tf4J0XqGz0S+P/tHchWP4JBVuGOTSsD2f+t1ceL++ttZT6FCYhqwSf3WEMpHBRJo+NwTvbZmtx24PxxZaXa8WW5nFD7I40fA28QWxAYigGLFX9kCah/wLtwlqf3timseaMN27GOVaOC0O0tXbp54Zj9Ct9rqS6NnBxBQdACfHl2Sucv6IfADP1CoMPCXZ5bXwJbbz/wDYYUqukvcyG+ldLMpHk89eK1f3NWCJA9Bjg5F26YUzHUwC8fiPWdSwcYGslKwCpP1QtE3ebZAS2YQpF3Os4b3q61TQi89Xc8POFwbkgXW7IJ2XyJBSE7EKMY4Jk9cOpgo98szxrXhKzr7QbMXHj/Mancl/+gz0PZ3RQz90s04HmZ24HeFpFI6vvVYn8c89QWN867pdQipOwdUare2su8Fc1+LdL0KUhYm7GCqBCQ72u3XmYtKmZtO+ijUDOwu0yjgv+MwMl4Ecw7I0UleGhvvmgSYKleaj5NRKM6SBEZFdCtOFeZfDecGK1txZ/9XIBZ6NnWZVeKzMG/91AlqhZB+XYxL/dBlOHfrtykjvHecMbrr93qMCNVu36Tav845erCPOZpTuuudh+01roLBn7A8cXSwU4WbnQcooVGDhPvF0oYs9ozn6oiBJqcWg3ZA8kqkw88dLgsVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(376002)(396003)(136003)(316002)(86362001)(66946007)(54906003)(4326008)(956004)(55236004)(66556008)(66476007)(508600001)(36756003)(8676002)(26005)(2616005)(6666004)(5660300002)(6506007)(107886003)(6916009)(83380400001)(2906002)(52116002)(1076003)(16526019)(38350700002)(38100700002)(6486002)(8936002)(186003)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMf1EZXJw1Uv2fO6f5PAwI787GTBa9KmLc5ckMULobdSYvGfRhfwYzw17TvB?=
 =?us-ascii?Q?gxA2AL0e5dYzfKQ4T0R1ZlBaErlEgawKWxOZcZCL0stM/FBjhLJgk3HLp4R6?=
 =?us-ascii?Q?pYNnzPdrOs+3TCYN093FJQEhFTUb7N1IKw68uCV6VCO9JUdqyzCWgLYOH+Qg?=
 =?us-ascii?Q?xhWcHJVYjsqpDkFiM/YL2zc9a0d6tSx9KoG+BkgOcRhlTB3tS74WFd6s9Z5l?=
 =?us-ascii?Q?vC1+ESvYw/fxFMrEl19vVNAAdTOU6VUedt1ymlBUjjRCFamCXbhgPBWWZglQ?=
 =?us-ascii?Q?EEj3mjGSX95veghVgy1j2dtXGIZejoNW5BAVaGUWcC3rI5+QWtMiR7vDxm1y?=
 =?us-ascii?Q?8v9+u8swaYj0oxwI8EvFA3q0eIzXB3dVnlFODwFThKWTJ+btntxEUm7WXAg4?=
 =?us-ascii?Q?gP8djo+lxnGwSW6Q05c7v/jPulHcTZ3x5CnOGkKuyhsrrFDnlNer+T4l9gK5?=
 =?us-ascii?Q?Ws2IebzhXbKqffgSx40nGtFRJPcMahcJZHZ/dqN/5Aohb5Mvgl9CsHaYFLLD?=
 =?us-ascii?Q?+9Jdi4ANXfEwLKTVudrZkVdR4JggjTaHNvi3xDQa/rVj8UhJtgFobTl/H2ju?=
 =?us-ascii?Q?ED1dslDs0hMiWWvDfS/TgmQfpG97LWkCsneHnH/KuYaBTTRhPMOrh/8CwK/a?=
 =?us-ascii?Q?B6uUgR4/YpnopNQ9YAwr91koFvCL0k7a3IAKmf7n0s9HWuRkdSEJoh+a/F84?=
 =?us-ascii?Q?Z/Z0fYSAPynxwRC4dVG19wBfapU4bzoLvrnEnswGNx0BJ7qXwXxkQ+QNorhl?=
 =?us-ascii?Q?B1AUepCyOb6AcBCwpMo68Lf0lKmMv7bK6Tq+NUycIuji627yMfe5eKX5mtGl?=
 =?us-ascii?Q?uSwb7uA6/TBY+rJygg6kQYBufTrPYOaQKfx5TxN/9kQf3A51Ky/0pCIJNNJG?=
 =?us-ascii?Q?mKIoCppPFYYvz+6NV6hNibYX6VikEiRypK4LZXHM4/1vHh2h05lbt7Dpp7TE?=
 =?us-ascii?Q?F0xJIjHPXZBygNLVkwn3GyGs762AO+XnJx/UMPfDskd991I+sroizLKFwk7L?=
 =?us-ascii?Q?QAJ/4GRdsI9kRNcg2/Rpk/cGnmjZ8xDXqcZwML4sFiwieFfJ9u6crTexnH8c?=
 =?us-ascii?Q?euafbepdb8NJERZYGapjelVontHRCObu650VICNk8xjzNVXVcogqYTPLThvR?=
 =?us-ascii?Q?qrgBnqkRUupwWLLhjmYpgu4Piw5qYU3xWx/bz8NmOFAh3GjgYypaAQJJcamB?=
 =?us-ascii?Q?PArzqs3caAJGBibh7pvu5sNu2pBbREWWLm6e5BHLuyhf3zd/MVFtwNwrCWa2?=
 =?us-ascii?Q?6CgvV/tcnQy1KiVa0kW1xbt2D5qpiOXIrX/Z9YIOt81XmyX/j1CVo93kNG7M?=
 =?us-ascii?Q?GGuZRUF9fnvVVfotixsjvWgR?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8873fd94-0db1-49a8-3d9b-08d931a9fa81
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:17.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v3XjDcGzO0+3Pq2cdSNdnBL7TlcmpVNrI1kFlCM8Jggd7dyHXo67T4BoEzBai/6HWVGncJrDmgrpXQ6nlRZ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1014
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_stats.h  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.h b/drivers/net=
/wireless/celeno/cl8k/wrs/wrs_stats.h
new file mode 100644
index 000000000000..2af2c95bda80
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_STATS_H
+#define CL_WRS_STATS_H
+
+#include "wrs/wrs_db.h"
+
+struct cl_hw;
+
+void cl_wrs_stats_per_update(struct cl_wrs_db *wrs_db,
+                            struct cl_wrs_sta *wrs_sta,
+                            struct cl_wrs_params *wrs_params,
+                            struct cl_wrs_tx_cntrs *tx_cntrs);
+void cl_wrs_stats_per_print(struct cl_hw *cl_hw,
+                           struct cl_wrs_sta *wrs_sta,
+                           struct cl_wrs_params *wrs_params);
+void cl_wrs_stats_per_reset(struct cl_wrs_params *wrs_params);
+void cl_wrs_stats_per_init(struct cl_wrs_params *wrs_params);
+void cl_wrs_stats_per_remove(struct cl_wrs_params *wrs_params);
+void cl_wrs_stats_decision_print(struct cl_wrs_params *wrs_params);
+void cl_wrs_stats_decision_reset(struct cl_wrs_params *wrs_params);
+
+#endif /* CL_WRS_STATS_H */
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

