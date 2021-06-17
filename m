Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A533AB892
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFQQJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:03 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:5985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229805AbhFQQIC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwG3CwBofSEaonW7oyhPAqflszx+4urSVxKexf+G8li8PGxQMK2HJKWPlXojFn7XNelrRE+z3HS7YpLYy8nY/s4Uuy2XX9Sv1SPntTWCmhjn3SEU+69ZcoiTTa/vD8F9fpP9LUB4AaaI1NNXe5AIKIexGJKmKbWcAmAYgHKVquLmSFyMJFH6ZhWbMax1OUfzn2pu+dqJgwQEHObnv8dT5i5CgUlzo8gwcrieXvXIe88thDWGFJWgMl3G+2QCe18zuV6gkFThxj4RQdnca9oyrkiGGyHNDsPWyLlP/+CmSMUBAIC0y0GPFP6+4wP+26jn6h5cKDMZ7BGZsNOpOLtBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWW59LN2ZDQGaa5RSVtdOC16w8Ffj+cuIFYvIYC8uro=;
 b=AnopNszkU+HWqWR6oj6qJzxLM6oOTDCPyWVGV+X+O1SwNsFq8c4+Ez28JP9e872UwYRBjxuRoWwrtZXLUG2lDp3SoaoWe2qWmvKsMOZypNxPuphE5GeeAIzTpBDgkzV9bySKoDoJ4P8pW7ZjsbrS87WM63Su5HIyouOCA7cINlUJPtSOE7flqwYoercHWOO3rWTCirRyFeei179SZ1dvh3c1Zi7pnudmEho68BNWmWG7bOeV/K/bML04qol/BhUQqeP/yQDXYXXDWyIa7jl+3w/7DRAewbj9FxZiOIbJ5UOxvwEAOpo2weMxjoI0fe6HYcJ6MRvXZVk+49QBmtLZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWW59LN2ZDQGaa5RSVtdOC16w8Ffj+cuIFYvIYC8uro=;
 b=q0PKbS6rHSb7Gn81IA1yRhuZSKWD6pZkq7Yxk5NX9lgUPFdbW4ApIt7GJQ+lxwAMdo8Uc9BYhsMxcR2WloKt1OgeQtOtexoWefIoh4C7znNz64/4ILB6NNA7tEy+EUI5xQOPGKzAdI9N8/fRMyTd3hhTL4ZVpl/FhoHJ6Kxn01U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:28 +0000
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
Subject: [RFC v1 086/256] cl8k: add fw/fw_dbg.c
Date:   Thu, 17 Jun 2021 15:59:33 +0000
Message-Id: <20210617160223.160998-87-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04f886ee-9d3b-4f62-fe95-08d931a989e8
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871B635B3A52F78E77BFC73F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkgmy34eEN31rmpjoLP9tNIQBHL7UT1MuhyAz/G+twqbOZRhivhjDeGxnDng1WFrOxPxRCH8SGr4Ae3k3ithFm+Gq2u+V0P9VdK60mYmO+8nFcA+l9PWXiFTxHH/Siio9WQP4GfB/EMkuzMof9RmRaxPMrsxgQGSMwgWTS+cNOcu+2qFybaAhHZu1DTDJ7wE7L/poevvT8RoQjtfH9/d1CWe/qI63t5UKLLC9QBDnF/C2YE6sWCykg8G3ETh9u3gmUyYhQR8hu7lO7wUtRa3k8umdppy5KqRKXp6QURRhLbphsG+6Y3f5nkA+aEEYRj0uJC5bI0bP87O91JruqPOiytnjGUBCGa3wVI2TSgLw1V7ArZU6wSQSojBmaR9mYL3hjI7VYSyEkOJf4lM7SNxTR4Ktsa7mJXPSVlzyKZuX92qSFFaEj6dQGB5Mr2PT4qsVXzwBCsG8o88UPYVgBc6rEvwoa05b9/FPL+FvC6caAEjhuCEffPWEATpQO+7tdjRDQmVYmvj9rN7eOPi3EFclEG+Sy27y2059utY5OgbT1AomX6Xyo9HD4tfKSnEP2vpkvTCncuAJWzWAY1Wlv2J7yHr6MjKDur6+qxcJqmGzS6YvjcjhsqtgcqQQcGamrZA5oPaDVLgAw9yhdrXi1K6kolbC7GVHcAb4L7E0g72SB80t3/g9YHmWzt8V5MouUhEN9727PP41xTv2gLEd15iIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(30864003)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tLXKPHBllQL13gTyrCM1G8sJrfXbxEOcrR4v9Ywdhs6CDeuIwbm28XHcER+A?=
 =?us-ascii?Q?4IyH7IHuyx0QHBg2UeopyrgrL4RvvPQjq4rhJWngy2WX0hw4inVpUMtjdfci?=
 =?us-ascii?Q?uFJCxi7y7ZcHLIMB7FEe5gh9ERBen+GdsKwEM0sN1r5xEZtMIojGnioHhmIj?=
 =?us-ascii?Q?AzMG17UgUgtvHdUK/3DP5CxmRLtmUoCIioCspIVkzqEjYts7uKqeU/wUjKPO?=
 =?us-ascii?Q?r8OqBVlsapZaMzFKEfMhYC2UqIpNGiGEojLU482/PgbylcEpSHdyfp7LABwM?=
 =?us-ascii?Q?skvbzfW5nMy8E3Ouj2NYwIq99vhIdsFEj0ZWo9bsDsr8K+RcbkKF7IKHleZD?=
 =?us-ascii?Q?Cil7gvF2+WoEfHfGx8H44lpuTJz/uO0Y/lqiLOU08tgMS9pQCcA5hl0eX1qT?=
 =?us-ascii?Q?xw7nLUeY/ujK0CWErPpPAyA5mvXDNRAsU+zQGlFSFsdNZpwewhTVMZSykoVA?=
 =?us-ascii?Q?4XmAa+Efgla/mqa7uZmoFJEimCGLmh8yqUV/xtjy9Jmiv55YWaTbyb8HTvC/?=
 =?us-ascii?Q?jRMVDZSfRLkt9nyguHpVLIUV/qtmccxND8ZSGIo5A/m38k30AQjfMJM6R/9T?=
 =?us-ascii?Q?O4BF5w2p3lkBwoNhaozpF85r0DeAO65FhpjZi2i3v9bGwlD9Zz3NAu1Vv3AH?=
 =?us-ascii?Q?cXi8mUSanf7BahX9osWp1/CN2sMDrOuaBSGGUl/HrCiSSaBHpEo2hqTYMkbS?=
 =?us-ascii?Q?5R2qgY+h18uDvpXRQecMcsX8MK1cEtWVROutyGerW6cHudREgxxrJWvPTLSo?=
 =?us-ascii?Q?Oq1WNCV8a3hPQY2yjIuRP9W+30VmwWNqxUNfjDHua9N3wKtgGOu+BJeYZHFC?=
 =?us-ascii?Q?hh00YIf5VW+dt+vSMHEOSB7ts7N6ZDMqYmuJcgPOmquhdxPVu7Y42yuy30p5?=
 =?us-ascii?Q?QtM/7f76FMLTe3o8OKtH37NfN4cFvlyiJj1FogE29dJAShu6xugDo1Z8L83o?=
 =?us-ascii?Q?9HOssX2R2r69IvSHqdgvz8P8ZVZK1FTOWbMjQIuco3dtPuhrtZq6gCAAVIXh?=
 =?us-ascii?Q?9McL8K07RLgz8ecUMj9GTy8zNg5sOqM59VdwB1pXctv0vdK9vFj+BMLtCYNI?=
 =?us-ascii?Q?Lk8FuzO4XwprIIYJ4F87zW6XihQ147ZJatI0GOd0oQwraRdfcPeQzddt2N4T?=
 =?us-ascii?Q?PKYSf+WnDjwc5UH98fn6bmeEXbJSnVCLAHmmLMJ7ZED4E/M4+FPPqN/S+t3F?=
 =?us-ascii?Q?bDkMb5N9/TYI493vhYpft7P/9poGXIU850H8qBICWaU2mPwqfG/eVyI2fKj5?=
 =?us-ascii?Q?rk09Sf4Dp8tgMsCta52y2EeM78QyJoOmMk927zgFZUW/JMsPVOEhcraw8yHg?=
 =?us-ascii?Q?bfKVZP9lZNpTuV+K+duc37/q?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f886ee-9d3b-4f62-fe95-08d931a989e8
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:08.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7uOVgeZRhyWsAKe0R+nP1v9ntFy0FZcojvJUGngmMkor5azIsTqvgmpLzfjliAtlzWexmDf4PhLVDKj2vV7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.c | 2686 ++++++++++++++++++
 1 file changed, 2686 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_dbg.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw/fw_dbg.c b/drivers/net/wir=
eless/celeno/cl8k/fw/fw_dbg.c
new file mode 100644
index 000000000000..413f45b433c6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/fw_dbg.c
@@ -0,0 +1,2686 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+#include <linux/utsname.h>
+
+#include "utils/utils.h"
+#include "fw/fw_dbg.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/ipc.h"
+#endif
+#include "band.h"
+#include "chip.h"
+#include "coredump.h"
+#include "ela.h"
+#include "utils/file.h"
+#include "dbgfile.h"
+#include "rx/rx.h"
+#include "fw/msg_tx.h"
+
+/* Work struct wrapper for print statistics */
+struct cl_print_stats_work {
+       struct work_struct ws;
+       struct cl_hw *cl_hw;
+       u32 dbg_info_type;
+};
+
+#define FW_DBG_INVALID_SESSION U8_MAX
+
+#define PRINT_FW(cl_hw, fmt, ...) \
+       pr_debug("%cmac%u " fmt, (cl_hw)->fw_prefix, (cl_hw)->chip->idx, ##=
__VA_ARGS__)
+
+/*
+ * Display 2 digit decimal fraction.
+ * Example: x =3D 541, y =3D 19 =3D 28.47368
+ *   =3D=3D> 47
+ */
+#define DECIMAL_FRACTION_X2(x, y) (100 * ((x) - (y) * ((x) / (y))) / (y))
+
+static void cl_print_tx_stats(struct cl_hw *cl_hw, struct cl_txl_statistic=
s *tx_stats)
+{
+       int i;
+       u8 per =3D 0;
+       u64 total_retry =3D 0;
+       u64 total_tx =3D 0;
+       u32 total_natt =3D 0;
+       u32 avg_backoff =3D 0;
+       u32 agg_size_total =3D 0;
+       u32 agg_size_x100 =3D 0;
+       u32 total_vns_off =3D 0;
+       u32 total_vns_on =3D 0;
+       bool is_agg_in_txop =3D false;
+       struct cl_txl_agg_statistics *agg =3D &tx_stats->agg;
+       struct cl_txl_htp_statistics *htp =3D &tx_stats->htp;
+       struct cl_txl_natt_statistics *natt =3D &tx_stats->natt;
+       struct cl_txl_vns_statistics *vns =3D &tx_stats->vns;
+       struct cl_txl_fec_statistics *fec =3D &tx_stats->fec;
+       struct cl_txl_backoff_params *backoff_params =3D &tx_stats->backoff=
_params;
+       struct cl_txl_rts_cts_statistics *rts_cts =3D &tx_stats->rts_cts;
+       struct cl_txl_underrun_statistics *underrun =3D &tx_stats->underrun=
;
+
+       const char *fw_tx_backoff_str[CL_MAX_FRM_TYPE] =3D {
+               [CE_BACKOFF_25]          =3D "<25",
+               [CE_BACKOFF_50]          =3D "50",
+               [CE_BACKOFF_100]         =3D "100",
+               [CE_BACKOFF_500]         =3D "500",
+               [CE_BACKOFF_1000]        =3D "1000",
+               [CE_BACKOFF_5000]        =3D "5000",
+               [CE_BACKOFF_10000]       =3D "10000",
+               [CE_BACKOFF_20000]       =3D "20000",
+               [CE_BACKOFF_20000_ABOVE] =3D ">20000",
+       };
+
+       /* Singles info */
+       PRINT_FW(cl_hw, "TX statistics - singles\n");
+       PRINT_FW(cl_hw, "--------------------------------------------------=
----------------\n");
+       PRINT_FW(cl_hw, "| q |sent      |retry     |lft exp   |ret limit |r=
et lim ps|per %%|\n");
+       PRINT_FW(cl_hw, "|---+----------+----------+----------+----------+-=
---------+-----|\n");
+
+       for (i =3D 0; i < IPC_TX_QUEUE_CNT; i++) {
+               total_retry =3D tx_stats->single[i].total_rtx_cnt +
+                       tx_stats->single[i].total_lifetime_expired_cnt +
+                       tx_stats->single[i].total_rtx_limit_reached;
+
+               total_tx =3D tx_stats->single[i].total_cnt + total_retry;
+
+               if (total_tx =3D=3D 0)
+                       continue;
+
+               per =3D (u8)div64_u64(total_retry * 100, total_tx);
+
+               PRINT_FW(cl_hw, "|%3u|%10u|%10u|%10u|%10u|%10u|%5u|\n",
+                        i,
+                        tx_stats->single[i].total_cnt,
+                        tx_stats->single[i].total_rtx_cnt,
+                        tx_stats->single[i].total_lifetime_expired_cnt,
+                        tx_stats->single[i].total_rtx_limit_reached,
+                        tx_stats->single[i].total_rtx_limit_reached_ps,
+                        per);
+       }
+
+       PRINT_FW(cl_hw, "--------------------------------------------------=
----------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* Aggregation info */
+       PRINT_FW(cl_hw, "TX statistics - aggregations - MAX [%u]\n", IPC_MA=
X_BA_SESSIONS);
+       PRINT_FW(cl_hw, "--------------------------------------------------=
---------------------------------------------------------------------------=
\n");
+       PRINT_FW(cl_hw, "|Q |Total    |Total    |Lifetime|Retry |BA       |=
BA not   |BA     |BA     |BA    |Below BA|Above BA|ACK    |PS BA not|Total|=
\n");
+       PRINT_FW(cl_hw, "|  |sent     |retry    |expired |Limit |received |=
received |Cleared|Invalid|un-exp|window  |window  |inst BA|received |Per %%=
|\n");
+       PRINT_FW(cl_hw, "|--+---------+---------+--------+------+---------+=
---------+-------+-------+------+--------+--------+-------+---------+-----|=
\n");
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+               total_retry =3D tx_stats->ba[i].total_rtx_cnt +
+                       tx_stats->ba[i].total_lifetime_expired_cnt +
+                       tx_stats->ba[i].total_rtx_limit_reached;
+
+               total_tx =3D tx_stats->ba[i].total_cnt;
+
+               if (total_tx =3D=3D 0)
+                       continue;
+
+               per =3D (u8)div64_u64(total_retry * 100, total_tx);
+
+               PRINT_FW(cl_hw, "|%2u|%9u|%9u|%8u|%6u|%9u|%9u|%7u|%7u|%6u|%=
8u|%8u|%7u|%9u|%5u|\n",
+                        i,
+                        tx_stats->ba[i].total_cnt,
+                        tx_stats->ba[i].total_rtx_cnt,
+                        tx_stats->ba[i].total_lifetime_expired_cnt,
+                        tx_stats->ba[i].total_rtx_limit_reached,
+                        tx_stats->ba[i].total_ba_received,
+                        tx_stats->ba[i].total_ba_not_received_cnt,
+                        tx_stats->ba[i].total_cleard_ba,
+                        tx_stats->ba[i].total_invalid_ba,
+                        tx_stats->ba[i].total_unexpected_ba,
+                        tx_stats->ba[i].total_packets_below_baw,
+                        tx_stats->ba[i].total_packets_above_baw,
+                        tx_stats->ba[i].total_ack_instead_ba,
+                        tx_stats->ba[i].total_ba_not_received_cnt_ps,
+                        per);
+       }
+       PRINT_FW(cl_hw, "--------------------------------------------------=
---------------------------------------------------------------------------=
\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* TID info */
+       PRINT_FW(cl_hw, "----------------\n");
+       PRINT_FW(cl_hw, "|TID|NumPackets|\n");
+       PRINT_FW(cl_hw, "|---+----------|\n");
+
+       for (i =3D 0; i < TID_MAX; i++) {
+               if (tx_stats->tid[i].total_tid_desc_cnt =3D=3D 0)
+                       continue;
+
+               PRINT_FW(cl_hw, "|%3d|%10u|\n", i, tx_stats->tid[i].total_t=
id_desc_cnt);
+       }
+
+       PRINT_FW(cl_hw, "----------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* AC info */
+       PRINT_FW(cl_hw, "--------------------------------------------------=
-------------------\n");
+       PRINT_FW(cl_hw, "|     AC     |    0     |    1     |    2     |   =
 3     |    4     |\n");
+       PRINT_FW(cl_hw, "|------------+----------+----------+----------+---=
-------+----------|\n");
+       PRINT_FW(cl_hw, "|Num switches|%10u|%10u|%10u|%10u|%10u|\n",
+                tx_stats->ac[0].total_q_switch_cnt,
+                tx_stats->ac[1].total_q_switch_cnt,
+                tx_stats->ac[2].total_q_switch_cnt,
+                tx_stats->ac[3].total_q_switch_cnt,
+                tx_stats->ac[4].total_q_switch_cnt);
+       PRINT_FW(cl_hw, "|Num txdesc  |%10u|%10u|%10u|%10u|%10u|\n",
+                tx_stats->ac[0].total_ac_desc_cnt,
+                tx_stats->ac[1].total_ac_desc_cnt,
+                tx_stats->ac[2].total_ac_desc_cnt,
+                tx_stats->ac[3].total_ac_desc_cnt,
+                tx_stats->ac[4].total_ac_desc_cnt);
+       PRINT_FW(cl_hw, "--------------------------------------------------=
-------------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* Underrun info */
+       if (underrun->length_cnt || underrun->pattern_cnt) {
+               PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D Underrun recovery=
 statistics =3D=3D=3D=3D=3D=3D=3D\n");
+               PRINT_FW(cl_hw, "Length underrun %u\n",
+                        underrun->length_cnt);
+               PRINT_FW(cl_hw, "Pattern underrun %u\n",
+                        underrun->pattern_cnt);
+               PRINT_FW(cl_hw, "Total frames flushed in underrun %u\n",
+                        underrun->flushed_frames_cnt);
+               PRINT_FW(cl_hw, "\n");
+       }
+
+       /* BW drop fail info */
+       if (tx_stats->tx_obtain_bw_fail_cnt) {
+               PRINT_FW(cl_hw, "Failed to obtain BW count %u\n", tx_stats-=
>tx_obtain_bw_fail_cnt);
+               PRINT_FW(cl_hw, "\n");
+       }
+
+       /* Backoff time info */
+       PRINT_FW(cl_hw, "Backoff Time [us]\n");
+       PRINT_FW(cl_hw, "--------------------------------------------------=
----\n");
+       PRINT_FW(cl_hw, "|Backoff |   AC 0   |   AC 1   |   AC 2   |   AC 3=
   |\n");
+
+       for (i =3D 0; i < CE_BACKOFF_MAX; i++) {
+               if (tx_stats->backoff_stats[AC_BK].backoff_hist[i] =3D=3D 0=
 &&
+                   tx_stats->backoff_stats[AC_BE].backoff_hist[i] =3D=3D 0=
 &&
+                   tx_stats->backoff_stats[AC_VI].backoff_hist[i] =3D=3D 0=
 &&
+                   tx_stats->backoff_stats[AC_VO].backoff_hist[i] =3D=3D 0=
)
+                       continue;
+
+               PRINT_FW(cl_hw, "|--------+----------+----------+----------=
+----------|\n");
+               PRINT_FW(cl_hw, "| %6s |%10u|%10u|%10u|%10u|\n",
+                        fw_tx_backoff_str[i],
+                        tx_stats->backoff_stats[AC_BK].backoff_hist[i],
+                        tx_stats->backoff_stats[AC_BE].backoff_hist[i],
+                        tx_stats->backoff_stats[AC_VI].backoff_hist[i],
+                        tx_stats->backoff_stats[AC_VO].backoff_hist[i]);
+       }
+
+       PRINT_FW(cl_hw, "--------------------------------------------------=
----\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* AMSDU Packet cnt */
+       PRINT_FW(cl_hw, "|--------------------|\n");
+       PRINT_FW(cl_hw, "|  AMSDU Packet cnt  |\n");
+       PRINT_FW(cl_hw, "|--------------------|\n");
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+               if (agg->amsdu_stat[i].packet_cnt_2 =3D=3D 0 &&
+                   agg->amsdu_stat[i].packet_cnt_3 =3D=3D 0 &&
+                   agg->amsdu_stat[i].packet_cnt_4 =3D=3D 0 &&
+                   agg->amsdu_stat[i].packet_cnt_5_or_more =3D=3D 0)
+                       continue;
+
+               PRINT_FW(cl_hw, "# session=3D%u\n", i);
+               PRINT_FW(cl_hw, "packet_cnt  =3D 2: [%u]\n",
+                        agg->amsdu_stat[i].packet_cnt_2);
+               PRINT_FW(cl_hw, "packet_cnt  =3D 3: [%u]\n",
+                        agg->amsdu_stat[i].packet_cnt_3);
+               PRINT_FW(cl_hw, "packet_cnt  =3D 4: [%u]\n",
+                        agg->amsdu_stat[i].packet_cnt_4);
+               PRINT_FW(cl_hw, "packet_cnt >=3D 5: [%u]\n",
+                        agg->amsdu_stat[i].packet_cnt_5_or_more);
+               PRINT_FW(cl_hw, "\n");
+       }
+       PRINT_FW(cl_hw, "\n");
+
+       /* Agg statistics */
+       for (i =3D 1; i < CL_MAX_AGG_IN_TXOP; i++) {
+               if (agg->agg_in_txop_statistics[i]) {
+                       is_agg_in_txop =3D true;
+                       break;
+               }
+       }
+
+       if (is_agg_in_txop) {
+               /* Agg in TXOP */
+               PRINT_FW(cl_hw, "Agg in TXOP\n");
+               PRINT_FW(cl_hw, "|----------------|\n");
+               PRINT_FW(cl_hw, "| Agg |  Count   |\n");
+               PRINT_FW(cl_hw, "|-----+----------|\n");
+
+               for (i =3D 1; i < CL_MAX_AGG_IN_TXOP; i++) {
+                       if (!agg->agg_in_txop_statistics[i])
+                               continue;
+
+                       PRINT_FW(cl_hw, "|%5u|%10u|\n",
+                                i + 1, agg->agg_in_txop_statistics[i]);
+               }
+
+               PRINT_FW(cl_hw, "|----------------|\n");
+               PRINT_FW(cl_hw, "\n");
+
+               /* Agg close reason & Agg queue switch */
+               PRINT_FW(cl_hw, "Agg close reason:\n");
+               PRINT_FW(cl_hw, "  Not enough txdescs =3D %u\n",
+                        agg->agg_in_txop_close_reason[AGG_IN_TXOP_CLOSE_RE=
ASON_NO_TXDESC]);
+               PRINT_FW(cl_hw, "  TXOP expired       =3D %u\n",
+                        agg->agg_in_txop_close_reason[AGG_IN_TXOP_CLOSE_RE=
ASON_TXOP_EXPIRED]);
+               PRINT_FW(cl_hw, "  Delba in process   =3D %u\n",
+                        agg->agg_in_txop_close_reason[AGG_IN_TXOP_CLOSE_RE=
ASON_ACTIVE_DELBA]);
+               PRINT_FW(cl_hw, "Agg queue switch:\n");
+               PRINT_FW(cl_hw, "  Queue switch within TXOP               =
=3D %u\n",
+                        agg->agg_in_txop_queue_switch);
+               PRINT_FW(cl_hw, "  Queue switch abort due diff bw in TXOP =
=3D %u\n",
+                        agg->agg_in_txop_queue_switch_abort_bw);
+               PRINT_FW(cl_hw, "\n");
+       }
+
+       /* RTS-CTS statistics */
+       if (rts_cts->fw_rts_cnt ||
+           rts_cts->fw_cts_cnt ||
+           rts_cts->hw_rts_cnt ||
+           rts_cts->hw_cts_cnt) {
+               PRINT_FW(cl_hw, "RTS-CTS statistics\n");
+               PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D\n");
+               PRINT_FW(cl_hw, "FW RTS frame count =3D %u\n", rts_cts->fw_=
rts_cnt);
+               PRINT_FW(cl_hw, "FW CTS frame count =3D %u\n", rts_cts->fw_=
cts_cnt);
+               PRINT_FW(cl_hw, "HW RTS frame count =3D %u\n", rts_cts->hw_=
rts_cnt);
+               PRINT_FW(cl_hw, "HW CTS frame count =3D %u\n", rts_cts->hw_=
cts_cnt);
+               PRINT_FW(cl_hw, "\n");
+       }
+
+       /* Natt statistics */
+       PRINT_FW(cl_hw, "natt statistics\n");
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       PRINT_FW(cl_hw, "agg size[0] =3D %u <singeltons>\n", agg->agg_size_=
statistics[0]);
+       PRINT_FW(cl_hw, "\n");
+
+       PRINT_FW(cl_hw, "--------------------------------------------------=
---------\n");
+       PRINT_FW(cl_hw, "|agg | num sent |percent | pass per | drop per | P=
ER per  |\n");
+       PRINT_FW(cl_hw, "|size| per size |per size| agg size | agg size | a=
gg size |\n");
+       PRINT_FW(cl_hw, "|----+----------+--------+----------+----------+--=
--------|\n");
+
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++)
+               agg_size_total +=3D agg->agg_size_statistics[i];
+
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++) {
+               if (agg->agg_size_statistics[i] =3D=3D 0)
+                       continue;
+
+               total_natt =3D agg->packet_failed_statistics[i] + agg->pack=
et_passed_statistics[i];
+
+               if (total_natt =3D=3D 0)
+                       continue;
+
+               agg_size_x100 =3D 100 * agg->agg_size_statistics[i];
+
+               PRINT_FW(cl_hw, "|%4u|%10u|%5u.%02u|%10u|%10u|%10u|\n",
+                        i,
+                        agg->agg_size_statistics[i],
+                        agg_size_x100 / agg_size_total,
+                        DECIMAL_FRACTION_X2(agg_size_x100, agg_size_total)=
,
+                        agg->packet_passed_statistics[i],
+                        agg->packet_failed_statistics[i],
+                        ((agg->packet_failed_statistics[i] * 100) / total_=
natt));
+       }
+       PRINT_FW(cl_hw, "--------------------------------------------------=
---------\n");
+       PRINT_FW(cl_hw, "Amount of all su aggregations: %u\n", agg_size_tot=
al);
+       PRINT_FW(cl_hw, "\n");
+
+       /* Natt statistics (HTP flows) */
+       PRINT_FW(cl_hw, "natt statistics HTP flows\n");
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       PRINT_FW(cl_hw, "--------------------------------------------------=
---------\n");
+       PRINT_FW(cl_hw, "|agg |num sent| percent  | pass per | drop per | P=
ER per  |\n");
+       PRINT_FW(cl_hw, "|size|per size| per size | agg size | agg size | a=
gg size |\n");
+       PRINT_FW(cl_hw, "|----+--------+----------+----------+----------+--=
--------|\n");
+
+       agg_size_total =3D 0;
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++)
+               agg_size_total +=3D agg->htp_agg_size_statistics[i];
+
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++) {
+               if (agg->htp_agg_size_statistics[i] =3D=3D 0)
+                       continue;
+
+               total_natt =3D agg->htp_packet_failed_statistics[i] +
+                       agg->htp_packet_passed_statistics[i];
+
+               if (total_natt =3D=3D 0)
+                       continue;
+
+               agg_size_x100 =3D 100 * agg->htp_agg_size_statistics[i];
+
+               PRINT_FW(cl_hw, "|%4u|%10u|%5u.%02u|%10u|%10u|%10u|\n",
+                        i,
+                        agg->htp_agg_size_statistics[i],
+                        agg_size_x100 / agg_size_total,
+                        DECIMAL_FRACTION_X2(agg_size_x100, agg_size_total)=
,
+                        agg->htp_packet_passed_statistics[i],
+                        agg->htp_packet_failed_statistics[i],
+                        (agg->htp_agg_size_statistics[i] * 100 / total_nat=
t));
+       }
+       PRINT_FW(cl_hw, "--------------------------------------------------=
---------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* Chosen frame BW */
+       PRINT_FW(cl_hw, "Chosen frame BW\n");
+       for (i =3D 0; i < NATT_BW_MAX; i++)
+               PRINT_FW(cl_hw, "BW[%u] =3D %u\n", i, natt->chosen_frame_bw=
[i]);
+       PRINT_FW(cl_hw, "\n");
+
+       /* Natt operation mode */
+       PRINT_FW(cl_hw, "Natt operation mode\n");
+       for (i =3D 0; i < 8; i++)
+               if (natt->operation_mode[i] !=3D 0)
+                       PRINT_FW(cl_hw, "[0x%x] =3D %u\n", i, natt->operati=
on_mode[i]);
+       PRINT_FW(cl_hw, "\n");
+
+       /* Natt agg close reason */
+       PRINT_FW(cl_hw, "natt agg close reason\n");
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
+       PRINT_FW(cl_hw, "Max length exceed  %u\n", natt->agg_close_reason[N=
ATT_REASON_MAX_LEN]);
+       PRINT_FW(cl_hw, "TXOP limit exceed  %u\n", natt->agg_close_reason[N=
ATT_REASON_TXOP_LIMIT]);
+       PRINT_FW(cl_hw, "MPDU number exceed %u\n", natt->agg_close_reason[N=
ATT_REASON_MPDU_NUM]);
+       PRINT_FW(cl_hw, "\n");
+
+       /* Recovery count */
+       if (tx_stats->recovery_count) {
+               PRINT_FW(cl_hw, "Recovery count\n");
+               PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n");
+               PRINT_FW(cl_hw, "Total: %u\n", tx_stats->recovery_count);
+               PRINT_FW(cl_hw, "\n");
+       }
+
+       /* Singelton backoff_params time */
+       PRINT_FW(cl_hw, "Singelton backoff_params time:\n");
+       for (i =3D 0; i < AC_MAX; i++) {
+               if (backoff_params->singelton_cnt[i]) {
+                       avg_backoff =3D backoff_params->singelton_total[i] =
/
+                               backoff_params->singelton_cnt[i];
+                       PRINT_FW(cl_hw, "ac%d avarage backoff_params %u\n",=
 i, avg_backoff);
+               } else {
+                       PRINT_FW(cl_hw, "ac%d avarage backoff_params 0\n", =
i);
+               }
+       }
+       PRINT_FW(cl_hw, "\n");
+
+       /* Aggregation backoff_params time */
+       PRINT_FW(cl_hw, "Aggregation backoff_params time:\n");
+       for (i =3D 0; i < AC_VO; i++) {
+               if (backoff_params->agg_cnt[i]) {
+                       avg_backoff =3D backoff_params->agg_total[i] /
+                               backoff_params->agg_cnt[i];
+                       PRINT_FW(cl_hw, "ac%d avarage backoff_params %u\n",=
 i, avg_backoff);
+               } else {
+                       PRINT_FW(cl_hw, "ac%d avarage backoff_params 0\n", =
i);
+               }
+       }
+       PRINT_FW(cl_hw, "\n");
+
+       /* Trigger Based traffic statistics */
+       PRINT_FW(cl_hw, "Trigger Based traffic statistics:\n");
+       for (i =3D 0; i < TID_MAX; i++)
+               if (htp->total_cnt[i])
+                       PRINT_FW(cl_hw, "TID%d total_cnt %u\n", i, htp->tot=
al_cnt[i]);
+       PRINT_FW(cl_hw, "\n");
+
+       if (htp->need_response || htp->tb_response_required) {
+               PRINT_FW(cl_hw, "need_response         =3D %u\n", htp->need=
_response);
+               PRINT_FW(cl_hw, "tb_response_required  =3D %u\n", htp->tb_r=
esponse_required);
+               PRINT_FW(cl_hw, "ac_not_found          =3D %u\n", htp->ac_n=
ot_found);
+               PRINT_FW(cl_hw, "end_of_packet_int     =3D %u\n", htp->end_=
of_packet_int);
+               PRINT_FW(cl_hw, "tb_bw_decision        =3D %u\n", htp->tb_b=
w_decision);
+               PRINT_FW(cl_hw, "tb_ba_thd_removed     =3D %u\n", htp->tb_b=
a_thd_removed);
+               PRINT_FW(cl_hw, "tb_ac_unchain         =3D %u\n", htp->tb_a=
c_unchain);
+               PRINT_FW(cl_hw, "tb_htp_unchain        =3D %u\n", htp->tb_h=
tp_unchain);
+               PRINT_FW(cl_hw, "tb_dummy_htp_tx       =3D %u\n", htp->tb_d=
ummy_htp_tx);
+               PRINT_FW(cl_hw, "tb_dummy_no_tx        =3D %u\n", htp->tb_d=
ummy_no_tx);
+               PRINT_FW(cl_hw, "msta_ba_received      =3D %u\n", htp->msta=
_ba_received);
+               PRINT_FW(cl_hw, "msta_ba_aid_not_found =3D %u\n", htp->msta=
_ba_aid_not_found);
+       }
+
+       total_vns_off =3D vns->off_cck + vns->off_ofdm + vns->off_ht_vht + =
vns->off_he;
+       total_vns_on =3D vns->on_cck + vns->on_ofdm + vns->on_ht_vht + vns-=
>on_he;
+
+       if (total_vns_off || total_vns_on) {
+               PRINT_FW(cl_hw, "       -----------------------\n");
+               PRINT_FW(cl_hw, "       | VNS-OFF  |  VNS-ON  |\n");
+               PRINT_FW(cl_hw, "-------+----------+----------|\n");
+               PRINT_FW(cl_hw, "|CCK   |%10u|%10u|\n", vns->off_cck, vns->=
on_cck);
+               PRINT_FW(cl_hw, "|OFDM  |%10u|%10u|\n", vns->off_ofdm, vns-=
>on_ofdm);
+               PRINT_FW(cl_hw, "|HT-VHT|%10u|%10u|\n", vns->off_ht_vht, vn=
s->on_ht_vht);
+               PRINT_FW(cl_hw, "|HE    |%10u|%10u|\n", vns->off_he, vns->o=
n_he);
+               PRINT_FW(cl_hw, "|------+----------+----------|\n");
+               PRINT_FW(cl_hw, "|TOTAL |%10u|%10u|\n", total_vns_off, tota=
l_vns_on);
+               PRINT_FW(cl_hw, "------------------------------\n");
+               PRINT_FW(cl_hw, "\n");
+       }
+
+       if (fec->ldpc || fec->bcc) {
+               PRINT_FW(cl_hw, "FEC Coding:\n");
+               PRINT_FW(cl_hw, "LDPC =3D %u\n", fec->ldpc);
+               PRINT_FW(cl_hw, "BCC  =3D %u\n", fec->bcc);
+               PRINT_FW(cl_hw, "\n");
+       }
+}
+
+static void cl_print_tx_mu_stats(struct cl_hw *cl_hw, struct cl_txl_statis=
tics *tx_stats)
+{
+       int i;
+       struct cl_txl_agg_statistics *agg =3D &tx_stats->agg;
+
+       if (agg->mu_stats[CL_MU1_IDX].chain_cnt =3D=3D 0) {
+               PRINT_FW(cl_hw, "~~~~~~~~~~~~~~~~~~  MU  statistics - EMPTY=
  ~~~~~~~~~~~~~~~~~~\n");
+               return;
+       }
+
+       PRINT_FW(cl_hw, "~~~~~~~~~~~~~~~~~~~~~~~~~  MU  statistics  ~~~~~~~=
~~~~~~~~~~~~~~~~~~\n");
+       PRINT_FW(cl_hw, "\n");
+
+#if (MU_MAX_STREAMS >=3D 4)
+       /* MU status statistics */
+       PRINT_FW(cl_hw, "--------------------------------------------------=
------\n");
+       PRINT_FW(cl_hw, "|            | MU1 | MU2 | MU3 | MU4 | MU5 | MU6 |=
 MU7 |\n");
+       PRINT_FW(cl_hw, "|------------+-----+-----+-----+-----+-----+-----+=
-----|\n");
+       PRINT_FW(cl_hw, "|Chain count |%5u|%5u|%5u|%5u|%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU1_IDX].chain_cnt,
+                agg->mu_stats[CL_MU2_IDX].chain_cnt,
+                agg->mu_stats[CL_MU3_IDX].chain_cnt,
+                agg->mu_stats[CL_MU4_IDX].chain_cnt,
+                agg->mu_stats[CL_MU5_IDX].chain_cnt,
+                agg->mu_stats[CL_MU6_IDX].chain_cnt,
+                agg->mu_stats[CL_MU7_IDX].chain_cnt);
+       PRINT_FW(cl_hw, "|Status count|%5u|%5u|%5u|%5u|%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU1_IDX].status_cnt,
+                agg->mu_stats[CL_MU2_IDX].status_cnt,
+                agg->mu_stats[CL_MU3_IDX].status_cnt,
+                agg->mu_stats[CL_MU4_IDX].status_cnt,
+                agg->mu_stats[CL_MU5_IDX].status_cnt,
+                agg->mu_stats[CL_MU6_IDX].status_cnt,
+                agg->mu_stats[CL_MU7_IDX].status_cnt);
+       PRINT_FW(cl_hw, "--------------------------------------------------=
------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* MU agg-size statistics */
+       PRINT_FW(cl_hw, "--------------------------------------------------=
----------\n");
+       PRINT_FW(cl_hw, "| agg size | MU0 | MU1 | MU2 | MU3 | MU4 | MU5 | M=
U6 | MU7 |\n");
+       PRINT_FW(cl_hw, "|----------+-----+-----+-----+-----+-----+-----+--=
---+-----|\n");
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++) {
+               if (agg->mu_agg_size_statistics[CL_MU0_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU1_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU2_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU3_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU4_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU5_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU6_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU7_IDX][i]) {
+                       PRINT_FW(cl_hw, "|%10u|%5u|%5u|%5u|%5u|%5u|%5u|%5u|=
%5u|\n",
+                                i,
+                                agg->mu_agg_size_statistics[CL_MU0_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU1_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU2_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU3_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU4_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU5_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU6_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU7_IDX][i]=
);
+               }
+       }
+       PRINT_FW(cl_hw, "--------------------------------------------------=
----------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* MU BA statistics */
+       PRINT_FW(cl_hw, "--------------------------------------------------=
------------------\n");
+       PRINT_FW(cl_hw, "| MU BA statistics | MU0 | MU1 | MU2 | MU3 | MU4 |=
 MU5 | MU6 | MU7 |\n");
+       PRINT_FW(cl_hw, "|------------------+-----+-----+-----+-----+-----+=
-----+-----+-----|\n");
+       PRINT_FW(cl_hw, "|  BA Received     |%5u|%5u|%5u|%5u|%5u|%5u|%5u|%5=
u|\n",
+                agg->mu_stats[CL_MU0_IDX].ba_received,
+                agg->mu_stats[CL_MU1_IDX].ba_received,
+                agg->mu_stats[CL_MU2_IDX].ba_received,
+                agg->mu_stats[CL_MU3_IDX].ba_received,
+                agg->mu_stats[CL_MU4_IDX].ba_received,
+                agg->mu_stats[CL_MU5_IDX].ba_received,
+                agg->mu_stats[CL_MU6_IDX].ba_received,
+                agg->mu_stats[CL_MU7_IDX].ba_received);
+       PRINT_FW(cl_hw, "|  --Unexpected BA |%5u|%5u|%5u|%5u|%5u|%5u|%5u|%5=
u|\n",
+                agg->mu_stats[CL_MU0_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU1_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU2_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU3_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU4_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU5_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU6_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU7_IDX].unexpected_ba);
+       PRINT_FW(cl_hw, "|  --Cleared    BA |%5u|%5u|%5u|%5u|%5u|%5u|%5u|%5=
u|\n",
+                agg->mu_stats[CL_MU0_IDX].clear_ba,
+                agg->mu_stats[CL_MU1_IDX].clear_ba,
+                agg->mu_stats[CL_MU2_IDX].clear_ba,
+                agg->mu_stats[CL_MU3_IDX].clear_ba,
+                agg->mu_stats[CL_MU4_IDX].clear_ba,
+                agg->mu_stats[CL_MU5_IDX].clear_ba,
+                agg->mu_stats[CL_MU6_IDX].clear_ba,
+                agg->mu_stats[CL_MU7_IDX].clear_ba);
+       PRINT_FW(cl_hw, "|  --Invalid    BA |%5u|%5u|%5u|%5u|%5u|%5u|%5u|%5=
u|\n",
+                agg->mu_stats[CL_MU0_IDX].invalid_ba,
+                agg->mu_stats[CL_MU1_IDX].invalid_ba,
+                agg->mu_stats[CL_MU2_IDX].invalid_ba,
+                agg->mu_stats[CL_MU3_IDX].invalid_ba,
+                agg->mu_stats[CL_MU4_IDX].invalid_ba,
+                agg->mu_stats[CL_MU5_IDX].invalid_ba,
+                agg->mu_stats[CL_MU6_IDX].invalid_ba,
+                agg->mu_stats[CL_MU7_IDX].invalid_ba);
+       PRINT_FW(cl_hw, "|  --Correct    BA |%5u|%5u|%5u|%5u|%5u|%5u|%5u|%5=
u|\n",
+                agg->mu_stats[CL_MU0_IDX].correct_ba,
+                agg->mu_stats[CL_MU1_IDX].correct_ba,
+                agg->mu_stats[CL_MU2_IDX].correct_ba,
+                agg->mu_stats[CL_MU3_IDX].correct_ba,
+                agg->mu_stats[CL_MU4_IDX].correct_ba,
+                agg->mu_stats[CL_MU5_IDX].correct_ba,
+                agg->mu_stats[CL_MU6_IDX].correct_ba,
+                agg->mu_stats[CL_MU7_IDX].correct_ba);
+       PRINT_FW(cl_hw, "|  BA not Received |%5u|%5u|%5u|%5u|%5u|%5u|%5u|%5=
u|\n",
+                agg->mu_stats[CL_MU0_IDX].ba_no_received,
+                agg->mu_stats[CL_MU1_IDX].ba_no_received,
+                agg->mu_stats[CL_MU2_IDX].ba_no_received,
+                agg->mu_stats[CL_MU3_IDX].ba_no_received,
+                agg->mu_stats[CL_MU4_IDX].ba_no_received,
+                agg->mu_stats[CL_MU5_IDX].ba_no_received,
+                agg->mu_stats[CL_MU6_IDX].ba_no_received,
+                agg->mu_stats[CL_MU7_IDX].ba_no_received);
+       PRINT_FW(cl_hw, "--------------------------------------------------=
------------------\n");
+#elif (MU_MAX_STREAMS =3D=3D 3)
+       /* MU status statistics */
+       PRINT_FW(cl_hw, "--------------------------\n");
+       PRINT_FW(cl_hw, "|            | MU1 | MU2 |\n");
+       PRINT_FW(cl_hw, "|------------+-----+-----|\n");
+       PRINT_FW(cl_hw, "|Chain count |%5u|%5u|\n",
+                agg->mu_stats[CL_MU1_IDX].chain_cnt,
+                agg->mu_stats[CL_MU2_IDX].chain_cnt);
+       PRINT_FW(cl_hw, "|Status count|%5u|%5u|\n",
+                agg->mu_stats[CL_MU1_IDX].status_cnt,
+                agg->mu_stats[CL_MU2_IDX].status_cnt);
+       PRINT_FW(cl_hw, "--------------------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* MU agg-size statistics */
+       PRINT_FW(cl_hw, "------------------------------\n");
+       PRINT_FW(cl_hw, "| agg size | MU0 | MU1 | MU2 |\n");
+       PRINT_FW(cl_hw, "|----------+-----+-----+-----|\n");
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++) {
+               if (agg->mu_agg_size_statistics[CL_MU0_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU1_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU2_IDX][i]) {
+                       PRINT_FW(cl_hw, "|%10u|%5u|%5u|%5u|\n",
+                                i,
+                                agg->mu_agg_size_statistics[CL_MU0_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU1_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU2_IDX][i]=
);
+               }
+       }
+       PRINT_FW(cl_hw, "------------------------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* MU BA statistics */
+       PRINT_FW(cl_hw, "--------------------------------------\n");
+       PRINT_FW(cl_hw, "| MU BA statistics | MU0 | MU1 | MU2 |\n");
+       PRINT_FW(cl_hw, "|------------------+-----+-----+-----|\n");
+       PRINT_FW(cl_hw, "|  BA Received     |%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].ba_received,
+                agg->mu_stats[CL_MU1_IDX].ba_received,
+                agg->mu_stats[CL_MU2_IDX].ba_received);
+       PRINT_FW(cl_hw, "|  --Unexpected BA |%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU1_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU2_IDX].unexpected_ba);
+       PRINT_FW(cl_hw, "|  --Cleared    BA |%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].clear_ba,
+                agg->mu_stats[CL_MU1_IDX].clear_ba,
+                agg->mu_stats[CL_MU2_IDX].clear_ba);
+       PRINT_FW(cl_hw, "|  --Invalid    BA |%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].invalid_ba,
+                agg->mu_stats[CL_MU1_IDX].invalid_ba,
+                agg->mu_stats[CL_MU2_IDX].invalid_ba);
+       PRINT_FW(cl_hw, "|  --Correct    BA |%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].correct_ba,
+                agg->mu_stats[CL_MU1_IDX].correct_ba,
+                agg->mu_stats[CL_MU2_IDX].correct_ba);
+       PRINT_FW(cl_hw, "|  BA not Received |%5u|%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].ba_no_received,
+                agg->mu_stats[CL_MU1_IDX].ba_no_received,
+                agg->mu_stats[CL_MU2_IDX].ba_no_received);
+       PRINT_FW(cl_hw, "--------------------------------------\n");
+#else
+       /* MU status statistics */
+       PRINT_FW(cl_hw, "--------------------\n");
+       PRINT_FW(cl_hw, "|            | MU1 |\n");
+       PRINT_FW(cl_hw, "|------------+-----|\n");
+       PRINT_FW(cl_hw, "|Chain count |%5u|\n",
+                agg->mu_stats[CL_MU1_IDX].chain_cnt);
+       PRINT_FW(cl_hw, "|Status count|%5u|\n",
+                agg->mu_stats[CL_MU1_IDX].status_cnt);
+       PRINT_FW(cl_hw, "--------------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* MU agg-size statistics */
+       PRINT_FW(cl_hw, "------------------------\n");
+       PRINT_FW(cl_hw, "| agg size | MU0 | MU1 |\n");
+       PRINT_FW(cl_hw, "|----------+-----+-----|\n");
+       for (i =3D 1; i < DBG_STATS_MAX_AGG_SIZE; i++) {
+               if (agg->mu_agg_size_statistics[CL_MU0_IDX][i] ||
+                   agg->mu_agg_size_statistics[CL_MU1_IDX][i]) {
+                       PRINT_FW(cl_hw, "|%10u|%5u|%5u|\n",
+                                i,
+                                agg->mu_agg_size_statistics[CL_MU0_IDX][i]=
,
+                                agg->mu_agg_size_statistics[CL_MU1_IDX][i]=
);
+               }
+       }
+       PRINT_FW(cl_hw, "------------------------\n");
+       PRINT_FW(cl_hw, "\n");
+
+       /* MU BA statistics */
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "| MU BA statistics | MU0 | MU1 |\n");
+       PRINT_FW(cl_hw, "|------------------+-----+-----|\n");
+       PRINT_FW(cl_hw, "|  BA Received     |%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].ba_received,
+                agg->mu_stats[CL_MU1_IDX].ba_received);
+       PRINT_FW(cl_hw, "|  --Unexpected BA |%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].unexpected_ba,
+                agg->mu_stats[CL_MU1_IDX].unexpected_ba);
+       PRINT_FW(cl_hw, "|  --Cleared    BA |%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].clear_ba,
+                agg->mu_stats[CL_MU1_IDX].clear_ba);
+       PRINT_FW(cl_hw, "|  --Invalid    BA |%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].invalid_ba,
+                agg->mu_stats[CL_MU1_IDX].invalid_ba);
+       PRINT_FW(cl_hw, "|  --Correct    BA |%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].correct_ba,
+                agg->mu_stats[CL_MU1_IDX].correct_ba);
+       PRINT_FW(cl_hw, "|  BA not Received |%5u|%5u|\n",
+                agg->mu_stats[CL_MU0_IDX].ba_no_received,
+                agg->mu_stats[CL_MU1_IDX].ba_no_received);
+       PRINT_FW(cl_hw, "--------------------------------\n");
+#endif
+}
+
+static void cl_print_bcn_stats(struct cl_hw *cl_hw, struct cl_bcn_statisti=
cs *bcn_stats)
+{
+       struct beacon_timing *bcn_timing_stats =3D &bcn_stats->beacon_timin=
g;
+       struct beacon_counters *bcn_cnt_stats =3D &bcn_stats->beacon_counte=
rs;
+       struct bcn_backup_stats *bcn_backup_stats =3D &bcn_stats->bcn_backu=
p_stats;
+       u32 avg_time_between_bcn =3D 0, avg_time_bcn_chain =3D 0;
+
+       if (bcn_cnt_stats->nof_time_intervals_between_beacons !=3D 0)
+               avg_time_between_bcn =3D (bcn_timing_stats->total_bcn_time =
/
+                                       bcn_cnt_stats->nof_time_intervals_b=
etween_beacons);
+
+       if (bcn_cnt_stats->bcn_chain_total_cnt !=3D 0)
+               avg_time_bcn_chain =3D ((bcn_timing_stats->bcn_chain_total_=
time) /
+                                     (bcn_cnt_stats->bcn_chain_total_cnt))=
;
+
+       PRINT_FW(cl_hw, "----------------------------------------\n");
+       PRINT_FW(cl_hw, "Number of beacon flushed\n");
+       PRINT_FW(cl_hw, "+---------+-------------+--------------+\n");
+       PRINT_FW(cl_hw, "| pending | downloading | transmitting |\n");
+       PRINT_FW(cl_hw, "+---------+-------------+--------------+\n");
+       PRINT_FW(cl_hw, "|%-9u|%-13u|%-14u|\n",
+                bcn_cnt_stats->ce_txl_flushed_beacons[BCN_FLUSH_PENDING],
+                bcn_cnt_stats->ce_txl_flushed_beacons[BCN_FLUSH_DOWNLOADIN=
G],
+                bcn_cnt_stats->ce_txl_flushed_beacons[BCN_FLUSH_TRANSMITTI=
NG]);
+       PRINT_FW(cl_hw, "+---------+-------------+--------------+\n\n");
+
+       PRINT_FW(cl_hw, "----------------------------------------\n");
+       PRINT_FW(cl_hw, "Time between transmission of two beacons\n");
+       PRINT_FW(cl_hw, "+----------+----------+---------+----------------+=
\n");
+       PRINT_FW(cl_hw, "| min time | max time | bcn cnt | avg time[mSec] |=
\n");
+       PRINT_FW(cl_hw, "+----------+----------+---------+----------------+=
\n");
+       PRINT_FW(cl_hw, "|%-10u|%-10u|%-9u|%-16u|\n",
+                bcn_timing_stats->min_time_from_last_bcn,
+                bcn_timing_stats->max_time_from_last_bcn,
+                bcn_cnt_stats->total_cnt,
+                avg_time_between_bcn);
+       PRINT_FW(cl_hw, "+----------+----------+---------+----------------+=
\n\n");
+
+       PRINT_FW(cl_hw, "--------------------------------------------------=
-------------\n");
+       PRINT_FW(cl_hw, "Time of beacon until chain\n");
+       PRINT_FW(cl_hw, "+----------+----------+---------------+----------+=
\n");
+       PRINT_FW(cl_hw, "| min time | max time | bcn chain cnt | avg time |=
\n");
+       PRINT_FW(cl_hw, "+----------+----------+---------------+----------+=
\n");
+       PRINT_FW(cl_hw, "|%-10u|%-10u|%-15u|%-10u|\n",
+                bcn_timing_stats->bcn_chain_min_time,
+                bcn_timing_stats->bcn_chain_max_time,
+                bcn_cnt_stats->bcn_chain_total_cnt,
+                avg_time_bcn_chain);
+       PRINT_FW(cl_hw, "+----------+----------+---------------+----------+=
\n\n");
+
+       PRINT_FW(cl_hw, "--------------------------------------------------=
-------------------\n");
+       PRINT_FW(cl_hw, " beacon pending-chain path max time =3D %u\n",
+                bcn_timing_stats->bcn_pending_2_chain_max_time);
+       PRINT_FW(cl_hw, " beacon pending-chain not in time count =3D %u\n",
+                bcn_cnt_stats->pending2chain_not_in_threshold_cnt);
+       PRINT_FW(cl_hw, " Max time until recievd beacon from driver =3D %u\=
n",
+                bcn_timing_stats->max_bcn_time_until_get_beacon_from_drive=
r_in_tbtt);
+       PRINT_FW(cl_hw, " Total count of beacon flushed because didn't rece=
ived in time =3D %u\n",
+                bcn_cnt_stats->bcn_time_from_driver_not_in_threshold_cnt);
+       PRINT_FW(cl_hw, " Max num of beacon not received from driver =3D %u=
\n",
+                bcn_cnt_stats->max_bcn_not_received_from_host);
+       PRINT_FW(cl_hw, "--------------------------------------------------=
-------------------\n");
+
+       PRINT_FW(cl_hw, "+--------------------------------------+\n");
+       PRINT_FW(cl_hw, "|        Backup beacon stats           |\n");
+       PRINT_FW(cl_hw, "+------+------+---------+--------------+\n");
+       PRINT_FW(cl_hw, "| Used |  TX  | flushed | Max in a row |\n");
+       PRINT_FW(cl_hw, "+------+------+---------+--------------+\n");
+       PRINT_FW(cl_hw, "|%6u|%6u|%9u|%14u|\n",
+                bcn_backup_stats->bcn_backup_used_cnt,
+                bcn_backup_stats->bcn_backup_tx_cnt,
+                bcn_backup_stats->bcn_backup_flushed_cnt,
+                bcn_backup_stats->bcn_backup_max_used_in_arow_cnt);
+       PRINT_FW(cl_hw, "+------+------+---------+--------------+\n");
+}
+
+static void cl_print_rate_fallback_stats(struct cl_hw *cl_hw,
+                                        struct cl_rate_drop_statistics *st=
ats)
+{
+       PRINT_FW(cl_hw, "\n");
+       PRINT_FW(cl_hw, "---------------------------\n");
+       PRINT_FW(cl_hw, "   Fallback statistics\n");
+       PRINT_FW(cl_hw, "---------------------------\n");
+       PRINT_FW(cl_hw, "ba_per_stats          =3D %u\n",
+                stats->drop_reason[AGG_TX_RATE_DROP_MAX_BA_PER_REACHED]);
+       PRINT_FW(cl_hw, "ba_not_received_stats =3D %u\n",
+                stats->drop_reason[AGG_TX_RATE_DROP_MAX_BA_NOT_RECEIVED_RE=
ACHED]);
+       PRINT_FW(cl_hw, "max_retry_reached     =3D %u\n",
+                stats->drop_reason[AGG_TX_RATE_DROP_MAX_RETRY_REACHED]);
+}
+
+static void cl_print_rx_stats_precent(struct cl_hw *cl_hw, const char *str=
, u32 x, u32 y)
+{
+       /*
+        * Example:
+        * x =3D 541, y =3D 19
+        * Result 28.4736
+        */
+       u32 integer =3D x / y;
+       u32 fraction =3D 10000 * (x - y * (x / y)) / y;
+
+       PRINT_FW(cl_hw, "%s =3D %u.%04u\n", str, integer, fraction);
+}
+
+static void cl_print_rx_stats(struct cl_hw *cl_hw, struct cl_rxl_statistic=
s *rx_stats)
+{
+       int i, mu_idx, total_rx =3D 0;
+       enum format_mode fm;
+
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n");
+       PRINT_FW(cl_hw, "        Global RX stats\n");
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n");
+       PRINT_FW(cl_hw, "host rxelem not ready      =3D %u\n",
+                rx_stats->host_rxelem_not_ready_cnt);
+       PRINT_FW(cl_hw, "MSDU host rxelem not ready =3D %u\n",
+                rx_stats->msdu_host_rxelem_not_ready_cnt);
+       PRINT_FW(cl_hw, "MSDU dma pool not ready    =3D %u\n",
+                rx_stats->dma_rx_pool_not_ready_cnt);
+       PRINT_FW(cl_hw, "Percent of Rx CCA busy      =3D %u\n",
+                rx_stats->cca_busy_percent);
+       PRINT_FW(cl_hw, "Percent of Rx mine CCA busy =3D %u\n",
+                rx_stats->rx_mine_busy_percent);
+       PRINT_FW(cl_hw, "Percent of Tx mine busy     =3D %u\n",
+                rx_stats->tx_mine_busy_percent);
+       PRINT_FW(cl_hw, "\n");
+
+       PRINT_FW(cl_hw, "=3D=3D=3D Rx Format =3D=3D\n");
+       for (fm =3D 0; fm < FORMATMOD_MAX; fm++)
+               if (rx_stats->stats_rx_format[fm])
+                       PRINT_FW(cl_hw, "Rx Format[%d] =3D %u\n", fm, rx_st=
ats->stats_rx_format[fm]);
+
+       PRINT_FW(cl_hw, "=3D=3D=3D Rx Decryption errors =3D=3D\n");
+       for (i =3D RHD_DECR_ICVFAIL_IDX; i < RHD_DECR_IDX_MAX; i++)
+               if (rx_stats->decrypt_err[i])
+                       PRINT_FW(cl_hw, "decrypt_err[%d] =3D %u\n", i, rx_s=
tats->decrypt_err[i]);
+
+       /* RX prints */
+       for (mu_idx =3D 0; mu_idx < MU_UL_MAX; mu_idx++) {
+               PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
+               PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D         RX MAC HW MU [%2d]=
       =3D=3D=3D=3D=3D\n", mu_idx);
+               PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
+               total_rx =3D rx_stats->total_rx_packets[mu_idx] +
+                       rx_stats->fcs_error_counter[mu_idx] +
+                       rx_stats->phy_error_counter[mu_idx] +
+                       rx_stats->ampdu_incorrect_received_counter[mu_idx] =
+
+                       rx_stats->delimiter_error_counter[mu_idx] +
+                       rx_stats->rx_fifo_overflow_err_cnt[mu_idx];
+
+               if (total_rx =3D=3D 0)
+                       continue;
+
+               for (i =3D 0; i < MAX_HANDLED_FRM_TYPE; i++) {
+                       if (!rx_stats->emb_ll1_handled_frame_counter[mu_idx=
][i])
+                               continue;
+
+                       PRINT_FW(cl_hw, "emb_handled_packet[%d] - %u\n",
+                                i, rx_stats->emb_ll1_handled_frame_counter=
[mu_idx][i]);
+               }
+
+               PRINT_FW(cl_hw, "Total packets dropped (pckt_len > %u) %u\n=
",
+                        rx_stats->max_mpdu_data_len[mu_idx],
+                        rx_stats->rx_pckt_exceed_max_len_cnt[mu_idx]);
+               PRINT_FW(cl_hw, "Number of bad formated BA frames =3D %u\n"=
,
+                        rx_stats->rx_pckt_bad_ba_statinfo_cnt[mu_idx]);
+               PRINT_FW(cl_hw, "Max occupancy list2 =3D %u\n",
+                        rx_stats->rhd_ll2_max_cnt[mu_idx]);
+               PRINT_FW(cl_hw, "Max occupancy list1 =3D %u\n",
+                        rx_stats->rhd_ll1_max_cnt[mu_idx]);
+               PRINT_FW(cl_hw, "\n");
+               PRINT_FW(cl_hw, "Total Qos MPDU received    =3D %u\n",
+                        rx_stats->total_rx_packets[mu_idx]);
+               PRINT_FW(cl_hw, "Total Aggregation received =3D %u\n",
+                        rx_stats->total_agg_packets[mu_idx]);
+               PRINT_FW(cl_hw, "Number of Rx Fifo Overflow =3D %u\n",
+                        rx_stats->rx_fifo_overflow_err_cnt[mu_idx]);
+               PRINT_FW(cl_hw, "Number of FCS ERROR        =3D %u\n",
+                        rx_stats->fcs_error_counter[mu_idx]);
+               PRINT_FW(cl_hw, "Number of PHY ERROR        =3D %u\n",
+                        rx_stats->phy_error_counter[mu_idx]);
+               PRINT_FW(cl_hw, "Number of AMPDUS           =3D %u\n",
+                        rx_stats->ampdu_received_counter[mu_idx]);
+               PRINT_FW(cl_hw, "Number of Incorrect AMPDUS =3D %u\n",
+                        rx_stats->ampdu_incorrect_received_counter[mu_idx]=
);
+               PRINT_FW(cl_hw, "Number of Delimiter errors =3D %u\n",
+                        rx_stats->delimiter_error_counter[mu_idx]);
+
+               if (rx_stats->total_rx_packets[mu_idx]) {
+                       u32 total_rx_packets =3D rx_stats->total_rx_packets=
[mu_idx] +
+                               rx_stats->rx_fifo_overflow_err_cnt[mu_idx] =
+
+                               rx_stats->fcs_error_counter[mu_idx] +
+                               rx_stats->phy_error_counter[mu_idx] +
+                               rx_stats->delimiter_error_counter[mu_idx];
+
+                       cl_print_rx_stats_precent(cl_hw,
+                                                 "Rx Fifo Overflow percent=
  ",
+                                                 100 * rx_stats->rx_fifo_o=
verflow_err_cnt[mu_idx],
+                                                 total_rx_packets);
+                       cl_print_rx_stats_precent(cl_hw,
+                                                 "FCS Error percent       =
  ",
+                                                 100 * rx_stats->fcs_error=
_counter[mu_idx],
+                                                 total_rx_packets);
+                       cl_print_rx_stats_precent(cl_hw,
+                                                 "Phy Error percent       =
  ",
+                                                 100 * rx_stats->phy_error=
_counter[mu_idx],
+                                                 total_rx_packets);
+                       cl_print_rx_stats_precent(cl_hw,
+                                                 "Delimiter Error percent =
  ",
+                                                 100 * rx_stats->delimiter=
_error_counter[mu_idx],
+                                                 total_rx_packets);
+               }
+
+               PRINT_FW(cl_hw, "Current NAV value          =3D %u\n", rx_s=
tats->nav_value[mu_idx]);
+
+               PRINT_FW(cl_hw, "\n");
+               PRINT_FW(cl_hw, "Rx LL split stats: 1st LL interrupts =3D %=
u\n",
+                        rx_stats->counter_timer_trigger_ll1[mu_idx]);
+               PRINT_FW(cl_hw, "Rx LL split stats: 2nd LL interrupts =3D %=
u\n",
+                        rx_stats->counter_timer_trigger_ll2[mu_idx]);
+               PRINT_FW(cl_hw, "Number of incorrect format mode received =
=3D %u\n",
+                        rx_stats->rx_incorrect_format_mode[mu_idx]);
+
+               for (i =3D 0; i < RX_CLASSIFICATION_MAX; i++) {
+                       if (!rx_stats->rx_class_counter[mu_idx][i])
+                               continue;
+
+                       PRINT_FW(cl_hw, "Rx classification rules stats: Rx =
rule%d=3D %u\n",
+                                i, rx_stats->rx_class_counter[mu_idx][i]);
+               }
+
+               if (rx_stats->rx_class_int_counter[mu_idx])
+                       PRINT_FW(cl_hw, "Rx classification interrupts rules=
 =3D %u\n",
+                                rx_stats->rx_class_int_counter[mu_idx]);
+
+               PRINT_FW(cl_hw, "\n");
+               PRINT_FW(cl_hw, "Rx Implicit BF statistics:      =3D %u\n",
+                        rx_stats->rx_imp_bf_counter[mu_idx]);
+               PRINT_FW(cl_hw, "Rx Implicit BF interrupts stats =3D %u\n",
+                        rx_stats->rx_imp_bf_int_counter[mu_idx]);
+               PRINT_FW(cl_hw, "RXM STATISTICS\n");
+               PRINT_FW(cl_hw, "rxm_stats_overflow      =3D %u\n",
+                        rx_stats->rxm_stats_overflow[mu_idx]);
+               PRINT_FW(cl_hw, "rx_incorrect_format_mode=3D %u\n",
+                        rx_stats->rx_incorrect_format_mode[mu_idx]);
+               PRINT_FW(cl_hw, "correct_received_mpdu   =3D %u\n",
+                        rx_stats->correct_received_mpdu[mu_idx]);
+               PRINT_FW(cl_hw, "incorrect_received_mpdu =3D %u\n",
+                        rx_stats->incorrect_received_mpdu[mu_idx]);
+               PRINT_FW(cl_hw, "discarded_mpdu          =3D %u\n",
+                        rx_stats->discarded_mpdu[mu_idx]);
+               PRINT_FW(cl_hw, "incorrect_delimiter     =3D %u\n",
+                        rx_stats->incorrect_delimiter[mu_idx]);
+               PRINT_FW(cl_hw, "rts_bar_cnt             =3D %u\n",
+                        rx_stats->rts_bar_cnt[mu_idx]);
+               PRINT_FW(cl_hw, "rxm_mpdu_cnt            =3D %u\n",
+                        rx_stats->rxm_mpdu_cnt[mu_idx]);
+
+               if (rx_stats->rxm_mpdu_cnt[mu_idx]) {
+                       PRINT_FW(cl_hw, "rxm_rule0_match        =3D %u\n",
+                                rx_stats->rxm_rule0_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_rule1_match        =3D %u\n",
+                                rx_stats->rxm_rule1_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_rule2_match        =3D %u\n",
+                                rx_stats->rxm_rule2_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_rule3_match        =3D %u\n",
+                                rx_stats->rxm_rule3_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_rule4_match        =3D %u\n",
+                                rx_stats->rxm_rule4_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_rule5_match        =3D %u\n",
+                                rx_stats->rxm_rule5_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_rule6_match        =3D %u\n",
+                                rx_stats->rxm_rule6_match[mu_idx]);
+                       PRINT_FW(cl_hw, "rxm_default_rule_match =3D %u\n",
+                                rx_stats->rxm_default_rule_match[mu_idx]);
+                       PRINT_FW(cl_hw, "RXM amsdu stat not supported. use =
iwcl stats instead\n");
+               }
+
+               /* RX AMSDU prints */
+               PRINT_FW(cl_hw, "\n");
+               PRINT_FW(cl_hw, "RX AMSDU STATS\n");
+
+               PRINT_FW(cl_hw, "AMSDU RX cnt  =3D %u\n",
+                        rx_stats->stats_tot_rx_amsdu_cnt[mu_idx]);
+
+               for (i =3D 0; i < ARRAY_SIZE(rx_stats->stats_rx_amsdu_cnt[m=
u_idx]); i++)
+                       if (rx_stats->stats_rx_amsdu_cnt[mu_idx][i])
+                               PRINT_FW(cl_hw, "A-MSDU of %d =3D %u\n",
+                                        i + 1, rx_stats->stats_rx_amsdu_cn=
t[mu_idx][i]);
+
+               PRINT_FW(cl_hw, "A-MSDU RX errors:\n");
+               for (i =3D 0; i < AMSDU_DEAGGREGATION_ERR_MAX; i++)
+                       if (rx_stats->stats_rx_amsdu_err[mu_idx][i])
+                               PRINT_FW(cl_hw, " err_id[%d] =3D %u\n",
+                                        i, rx_stats->stats_rx_amsdu_err[mu=
_idx][i]);
+       }
+
+       PRINT_FW(cl_hw, "Frequency offset:\n");
+       for (i =3D 0; i < FREQ_OFFSET_TABLE_IDX_MAX; i++)
+               if (rx_stats->frequency_offset[i])
+                       PRINT_FW(cl_hw, "frequency_offset =3D %u\n", rx_sta=
ts->frequency_offset[i]);
+}
+
+static void cl_print_trigger_flow_stats(struct cl_hw *cl_hw,
+                                       struct cl_trigger_flow_statistics *=
tf_stats)
+{
+       u16 idx;
+       struct cl_rx_trigger_based_stats *tb_stats =3D &cl_hw->tb_stats;
+
+       if (!tb_stats->enable) {
+               PRINT_FW(cl_hw, "WARNING: Trigger based statistics are disa=
bled!\n");
+               return;
+       }
+
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "     Trigger flow statistics\n");
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "Sent trigger frames\n");
+       PRINT_FW(cl_hw, "---------------|---AC0---|---AC1---|---AC2---|---A=
C3---|\n");
+       PRINT_FW(cl_hw, "BASIC TRIGGER: |%9u|%9u|%9u|%9u|\n",
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BASIC_TRIGGER_T=
YPE][AC_BK],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BASIC_TRIGGER_T=
YPE][AC_BE],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BASIC_TRIGGER_T=
YPE][AC_VI],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BASIC_TRIGGER_T=
YPE][AC_VO]);
+       PRINT_FW(cl_hw, "BSRP:          |%9u|%9u|%9u|%9u|\n",
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BSRP_TYPE][AC_B=
K],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BSRP_TYPE][AC_B=
E],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BSRP_TYPE][AC_V=
I],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BSRP_TYPE][AC_V=
O]);
+       PRINT_FW(cl_hw, "BFRP:          |%9u|%9u|%9u|%9u|\n",
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BFRP_TYPE][AC_B=
K],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BFRP_TYPE][AC_B=
E],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BFRP_TYPE][AC_V=
I],
+                tf_stats->single_trigger_sent[TRIGGER_FLOW_BFRP_TYPE][AC_V=
O]);
+       PRINT_FW(cl_hw, "HTP FAILURE:   |%9u|%9u|%9u|%9u|\n",
+                tf_stats->htp_rx_failure[AC_BK],
+                tf_stats->htp_rx_failure[AC_BE],
+                tf_stats->htp_rx_failure[AC_VI],
+                tf_stats->htp_rx_failure[AC_VO]);
+
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "TRIGGER BASED MPDUs PER MAC HW\n");
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       tf_stats->trigger_based_mpdu[0] =3D tb_stats->total;
+
+       for (idx =3D 1; idx < MU_UL_MAX; idx++)
+               tf_stats->trigger_based_mpdu[0] -=3D tf_stats->trigger_base=
d_mpdu[idx];
+
+       for (idx =3D 0; idx < MU_UL_MAX; idx++)
+               PRINT_FW(cl_hw, "MAC HW %u - %10u\n", idx, tf_stats->trigge=
r_based_mpdu[idx]);
+
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "TRIGGER BASED AGGREGATIONS SIZE\n");
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "|-SIZE-|---TB AGGS---|\n");
+
+       for (idx =3D 1; idx < DBG_STATS_MAX_AGG_SIZE; idx++) {
+               if (tb_stats->data[idx] =3D=3D 0)
+                       continue;
+
+               PRINT_FW(cl_hw, "| %4u |%13u|\n", idx, tb_stats->data[idx])=
;
+       }
+
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "TRIGGER BASED QOS NULL AGGR SIZE\n");
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "|-SIZE-|---TB AGGS---|\n");
+
+       for (idx =3D 1; idx < TID_MAX + 1; idx++)
+               if (tb_stats->qos_null[idx] > 0)
+                       PRINT_FW(cl_hw, "| %4u |%13u|\n", idx, tb_stats->qo=
s_null[idx]);
+
+       if (tb_stats->qos_null[TID_MAX + 1] > 0)
+               PRINT_FW(cl_hw, "|  >8  |%13u|\n", tb_stats->qos_null[TID_M=
AX + 1]);
+}
+
+static void cl_print_dyn_calib_stats(struct cl_hw *cl_hw,
+                                    struct cl_dyn_calib_statistics *dyn_ca=
l_stats)
+{
+       u8 i, j;
+
+       PRINT_FW(cl_hw, "--------------------------------\n");
+       PRINT_FW(cl_hw, "Dynamic Calibration Information\n");
+       PRINT_FW(cl_hw, "--------------------------------\n\n");
+
+       PRINT_FW(cl_hw, "Default Dynamic Calibation Value =3D %u\n\n",
+                dyn_cal_stats->default_dyn_cal_val);
+
+       for (i =3D dyn_cal_stats->dyn_cal_debug_info_ix, j =3D 0;
+            j < DYN_CAL_DEBUG_NUM_ITER;
+            (i =3D ((i + 1) % 3)), j++) {
+               struct dyn_cal_debug_info_t *dyn_cal_debug_info =3D
+                       &dyn_cal_stats->dyn_cal_debug_info[i];
+
+               if (dyn_cal_stats->is_multi_client_mode)
+                       PRINT_FW(cl_hw,
+                                "calib_num =3D %u, min_val =3D %d, max_val=
 =3D %d, min_config =3D %u, "
+                                "max_config =3D %u, curr_config =3D %u, ne=
w_config =3D %u\n",
+                                dyn_cal_debug_info->calib_num,
+                                (s32)dyn_cal_debug_info->dyn_cal_min_val,
+                                (s32)dyn_cal_debug_info->dyn_cal_max_val,
+                                dyn_cal_debug_info->min_config,
+                                dyn_cal_debug_info->max_config,
+                                dyn_cal_debug_info->curr_config,
+                                dyn_cal_debug_info->new_config);
+               else
+                       PRINT_FW(cl_hw,
+                                "calib_num =3D %u, iter_num =3D %u, config=
_val_prev =3D %u, "
+                                "measured_val =3D %u, new_config_val =3D %=
u\n",
+                                dyn_cal_debug_info->calib_num,
+                                dyn_cal_debug_info->iter_num,
+                                dyn_cal_debug_info->curr_config,
+                                dyn_cal_debug_info->measured_val,
+                                dyn_cal_debug_info->new_config);
+       }
+
+       if (dyn_cal_stats->mac_phy_sync_err_cnt)
+               PRINT_FW(cl_hw, "mac_phy_sync_err_cnt =3D %u\n\n",
+                        dyn_cal_stats->mac_phy_sync_err_cnt);
+
+       PRINT_FW(cl_hw, "\n-----------------------------------------\n\n");
+}
+
+static void cl_print_bf_stats(struct cl_hw *cl_hw, struct cl_bf_statistics=
 *bf_stats)
+{
+       u32 idx;
+       bool should_print =3D false;
+       u16 *tx_bf_data_err;
+
+       for (idx =3D 0; idx < BF_DB_MAX; idx++)
+               if (bf_stats->print_active_free_list =3D=3D bf_stats->stats=
_data[idx].is_active_list) {
+                       should_print =3D true;
+                       break;
+               }
+
+       if (!should_print)
+               return;
+
+       /* Info phase 1 */
+       PRINT_FW(cl_hw, "List of non active BFs:\n");
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       PRINT_FW(cl_hw, "BF_CTRL statistics\n");
+       PRINT_FW(cl_hw, "+-----+----+----+-------+-------+----------------+=
-----------------+--------------+---------------+-----------------+--------=
-------+--------------+------------+-------+\n");
+       PRINT_FW(cl_hw, "|INDEX|#NDP|#BFP|#SU BFR|#MU BFR|#BFR_BW_MISMATCH|=
#BFR_NSS_MISMATCH|#SOUNDING_CHBW|#TOKEN_MISMATCH|#NDP_NDPA_TX_DROP|#BFR_RX_=
ERR_ACK|#BFR SEGMENTED|#RESOURCE_NA|STA_IDX|\n");
+       PRINT_FW(cl_hw, "+-----+----+----+-------+-------+----------------+=
-----------------+--------------+---------------+-----------------+--------=
-------+--------------+------------+-------+\n");
+
+       for (idx =3D 0; idx < BF_DB_MAX; idx++) {
+               if (bf_stats->print_active_free_list !=3D bf_stats->stats_d=
ata[idx].is_active_list)
+                       continue;
+
+               PRINT_FW(cl_hw,
+                        "|%5u|%4u|%4u|%7u|%7u|%16u|%17u|%14u|%15u|%17u|%15=
u|%14u|%12u|%7u|\n",
+                        idx,
+                        bf_stats->stats_data[idx].dbg.ndp_cnt,
+                        bf_stats->stats_data[idx].dbg.bfp_cnt,
+                        bf_stats->stats_data[idx].dbg.su_bfr_cnt,
+                        bf_stats->stats_data[idx].dbg.mu_bfr_cnt,
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_BW_MISMATCH],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_NSS_MISMATCH],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_SOUNDING_CHBW],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_TOKEN_MISMATCH],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_NDP_DROP],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_MISS_ACK],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_S=
EGMENTED_DROP],
+                        bf_stats->stats_data[idx].dbg.bf_invalid_cnt[BFR_R=
X_ERR_RESOURCE_NA],
+                        bf_stats->stats_data[idx].sta_idx);
+       }
+
+       PRINT_FW(cl_hw, "+-----+----+----+-------+-------+----------------+=
-----------------+--------------+---------------+-----------------+--------=
-------+--------------+------------+-------+\n");
+
+       /* Info phase 2 */
+       PRINT_FW(cl_hw, "statistic BF DATA FRAMESs:\n");
+       PRINT_FW(cl_hw, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       PRINT_FW(cl_hw, "BF_CTRL statistics\n");
+       PRINT_FW(cl_hw, "+-----+-----------+------------+-------------+----=
-------------+----------------+-----------------+-----------+-----------+--=
--------+------------------+-----------------+-------+\n");
+       PRINT_FW(cl_hw, "|INDEX|#ACTIVE_IDX|#PASSIVE_IDX|#ERR_BFR_MISS|#ERR=
_BFR_OUTDATED|#ERR_BW_MISMATCH|#ERR_NSS_MISMATCH|#BF_DATA_OK|#BUFF_IN_PS|#R=
EL_IN_PS|#BUFF_RESOURCE_ERR|#REL_RESOURCE_ERR|STA_IDX|\n");
+       PRINT_FW(cl_hw, "+-----+-----------+------------+-------------+----=
-------------+----------------+-----------------+-----------+-----------+--=
--------+------------------+-----------------+-------+\n");
+
+       for (idx =3D 0; idx < BF_DB_MAX; idx++) {
+               if (bf_stats->print_active_free_list !=3D bf_stats->stats_d=
ata[idx].is_active_list)
+                       continue;
+
+               tx_bf_data_err =3D bf_stats->stats_data[idx].dbg.tx_bf_data=
_err;
+
+               PRINT_FW(cl_hw,
+                        "|%5u|%11u|%12u|%13u|%17u|%16u|%17u|%11u|%11u|%10u=
|%18u|%17u|%7u|\n",
+                        idx,
+                        bf_stats->stats_data[idx].active_dsp_idx,
+                        bf_stats->stats_data[idx].passive_dsp_idx,
+                        tx_bf_data_err[TX_BF_DATA_ERR_BFR_MISS],
+                        tx_bf_data_err[TX_BF_DATA_ERR_BFR_OUTDATED],
+                        tx_bf_data_err[TX_BF_DATA_ERR_MISMATCH_BW],
+                        tx_bf_data_err[TX_BF_DATA_ERR_MISMATCH_NSS],
+                        tx_bf_data_err[TX_BF_DATA_OK],
+                        tx_bf_data_err[TX_BF_DATA_BUFFERED_PS_STA],
+                        tx_bf_data_err[TX_BF_DATA_RELEASED_PS_STA],
+                        tx_bf_data_err[TX_BF_DATA_BUFFERED_RESOURCE_ERR],
+                        tx_bf_data_err[TX_BF_DATA_RELEASED_RESOURCE_ERR],
+                        bf_stats->stats_data[idx].sta_idx);
+       }
+
+       PRINT_FW(cl_hw, "+-----+-----------+------------+-------------+----=
-------------+----------------+-----------------+-----------+-----------+--=
--------+------------------+-----------------+-------+\n");
+}
+
+static void cl_print_stats_handler(struct work_struct *ws)
+{
+       struct cl_print_stats_work *stats_work =3D container_of(ws, struct =
cl_print_stats_work, ws);
+       struct cl_hw *cl_hw =3D stats_work->cl_hw;
+       u32 dbg_info_type =3D stats_work->dbg_info_type;
+
+       if (dbg_info_type =3D=3D DBG_INFO_TX_STATS) {
+               struct cl_txl_statistics *tx_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.tx_sta=
ts);
+
+               cl_print_tx_stats(cl_hw, tx_stats);
+               cl_print_tx_mu_stats(cl_hw, tx_stats);
+       } else if (dbg_info_type =3D=3D DBG_INFO_BCN_STATS) {
+               struct cl_bcn_statistics *bcn_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.bcn_st=
ats);
+
+               cl_print_bcn_stats(cl_hw, bcn_stats);
+       } else if (dbg_info_type =3D=3D DBG_INFO_RX_STATS) {
+               struct cl_rxl_statistics *rx_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.rx_sta=
ts);
+
+               cl_print_rx_stats(cl_hw, rx_stats);
+       } else if (dbg_info_type =3D=3D DBG_INFO_DYN_CAL_STATS) {
+               struct cl_dyn_calib_statistics *dyn_cal_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.dyn_ca=
lib_stats);
+
+               cl_print_dyn_calib_stats(cl_hw, dyn_cal_stats);
+       } else if (dbg_info_type =3D=3D DBG_INFO_RATE_FALLBACK_STATS) {
+               struct cl_rate_drop_statistics *agg_rate_drop_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.rate_d=
rop_stats);
+
+               cl_print_rate_fallback_stats(cl_hw, agg_rate_drop_stats);
+       } else if (dbg_info_type =3D=3D DBG_INFO_BF) {
+               struct cl_bf_statistics *bf_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.bf_sta=
ts);
+
+               cl_print_bf_stats(cl_hw, bf_stats);
+       } else if (dbg_info_type =3D=3D DBG_INFO_TRIGGER_FLOW) {
+               struct cl_trigger_flow_statistics *tf_stats =3D
+                       &(((struct dbg_info *)cl_hw->dbginfo.buf)->u.trigge=
r_flow_stats);
+
+               cl_print_trigger_flow_stats(cl_hw, tf_stats);
+       }
+
+#ifdef CONFIG_CL_PCIE
+       cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+#endif
+       kfree(stats_work);
+}
+
+static void cl_schedule_print_stats(struct cl_hw *cl_hw, u32 dbg_info_type=
)
+{
+       struct cl_print_stats_work *stats_work =3D
+               kzalloc(sizeof(*stats_work), GFP_ATOMIC);
+
+       if (stats_work) {
+               INIT_WORK(&stats_work->ws, cl_print_stats_handler);
+               stats_work->cl_hw =3D cl_hw;
+               stats_work->dbg_info_type =3D dbg_info_type;
+
+               /* Schedule work, the work will be executed in the backgrou=
nd */
+               queue_work(cl_hw->drv_workqueue, &stats_work->ws);
+       } else {
+               cl_dbg_err(cl_hw, "stats_work allocation failed\n");
+       }
+}
+
+void cl_fw_dbg_handler(struct cl_hw *cl_hw)
+{
+       struct dbg_info *dbg_info =3D NULL;
+
+       /* Function called upon DBG_INFO_IND message reception. */
+       dma_sync_single_for_device(cl_hw->chip->dev, cl_hw->dbginfo.dma_add=
r,
+                                  cl_hw->dbginfo.bufsz, DMA_FROM_DEVICE);
+       dbg_info =3D (struct dbg_info *)cl_hw->dbginfo.buf;
+
+       if (dbg_info->u.type =3D=3D DBG_INFO_DUMP) {
+               cl_dbg_info(cl_hw, "type %u): dump received\n",
+                           cl_hw->dbginfo.buf->u.dump.general_data.error_t=
ype);
+               cl_coredump_trigger(cl_hw);
+       } else if (dbg_info->u.type < DBG_INFO_MAX) {
+               cl_schedule_print_stats(cl_hw, dbg_info->u.type);
+       } else {
+               cl_dbg_warn(cl_hw, "Debug info wrong type - %u\n", dbg_info=
->u.type);
+       }
+}
+
+static int cl_fw_dbg_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "fw usage:\n"
+                "-a : Trigger assert error (echo ASSERT_ERR > errsim)\n"
+                "-b : Trigger assert recovery (echo 1 > test_mode)\n"
+                "-d : Set trigger-based debug statistics [0-dis/1-en]\n"
+                "-m : Trigger firmware dump (echo 1 > mactrace)\n"
+                "-s : Print statistics (echo param > stat_print)\n"
+                "-t : Test mode command (cmd + 0 to 5 parameters)\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_fw_dbg_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool assert_err =3D false;
+       bool assert_rec =3D false;
+       bool dbg_tb_stats =3D false;
+       bool mactrace =3D false;
+       bool stat_print =3D false;
+       bool test_mode =3D false;
+
+       switch (cli_params->option) {
+       case 'a':
+               assert_err =3D true;
+               expected_params =3D 0;
+               break;
+       case 'b':
+               assert_rec =3D true;
+               expected_params =3D 0;
+               break;
+       case 'd':
+               dbg_tb_stats =3D true;
+               expected_params =3D 1;
+               break;
+       case 'm':
+               mactrace =3D true;
+               expected_params =3D 0;
+               break;
+       case 's':
+               stat_print =3D true;
+               expected_params =3D 1;
+               break;
+       case 't':
+               test_mode =3D true;
+               break;
+       case '?':
+               return cl_fw_dbg_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if ((expected_params !=3D cli_params->num_params) && !test_mode) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (assert_err) {
+               cl_msg_tx_key_del(cl_hw, 0xFF);
+               return 0;
+       }
+
+       if (assert_rec) {
+               u32 params[TEST_MODE_PARAM_MAX + 1] =3D {1, 0, 0, 0, 0, 0};
+
+               cl_msg_tx_dbg_test_mode(cl_hw, params);
+               return 0;
+       }
+
+       if (dbg_tb_stats) {
+               cl_hw->tb_stats.enable =3D (bool)cli_params->params[0];
+               pr_debug("TB statistics %s\n", cl_hw->tb_stats.enable ? "en=
able" : "disable");
+               return 0;
+       }
+
+       if (mactrace) {
+               cl_msg_tx_dbg_trigger(cl_hw, "Force trigger");
+               return 0;
+       }
+
+       if (stat_print) {
+               u32 bitmap =3D (u32)cli_params->params[0];
+
+               cl_msg_tx_dbg_print_stats(cl_hw, bitmap, 0, 0, 0, 0);
+               return 0;
+       }
+
+       if (test_mode) {
+               u32 params[TEST_MODE_PARAM_MAX + 1] =3D {0};
+               u8 i;
+
+               if (cli_params->num_params =3D=3D 0 ||
+                   cli_params->num_params > TEST_MODE_PARAM_MAX + 1) {
+                       cl_dbg_err(cl_hw, "Test mode expects cmd + 0 to 5 p=
arameters\n");
+                       goto out_err;
+               }
+
+               for (i =3D 0; i < cli_params->num_params; i++)
+                       params[i] =3D (u32)cli_params->params[i];
+
+               cl_msg_tx_dbg_test_mode(cl_hw, params);
+               return 0;
+       }
+
+out_err:
+       return -EIO;
+}
+
+static void cl_dbg_dump_check_params(struct cl_hw *cl_hw,
+                                    u8 *buf, int bufsz, int *pos,
+                                    struct dbg_error_trace_info_drv *dump)
+{
+       int is_mismatch =3D false;
+       struct dbg_meta_data *dbg_metadata =3D &dump->common_info.dbg_metad=
ata;
+
+       if (dbg_metadata->lmac_req_buf_size !=3D sizeof(struct dbg_error_tr=
ace_info_drv) ||
+           dbg_metadata->physical_queue_cnt !=3D CL_MAX_BA_PHYSICAL_QUEUE_=
CNT ||
+           dbg_metadata->agg_index_max !=3D AGG_IDX_MAX ||
+           dbg_metadata->ce_ac_max !=3D CE_AC_MAX ||
+           dbg_metadata->mu_user_max !=3D MU_MAX_STREAMS ||
+           dbg_metadata->txl_exch_trace_depth !=3D DBG_TXL_FRAME_EXCH_TRAC=
E_DEPTH ||
+           dbg_metadata->mac_hw_regs_max !=3D HAL_MACHW_REG_NUM ||
+           dbg_metadata->phy_hw_regs_max !=3D PHY_HW_DBG_REGS_CNT)
+               is_mismatch =3D true;
+
+       if (is_mismatch) {
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "\nWarning!!!!\n");
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "DBG metadata mismatch bwtween FW & DRV!!=
!!\n");
+       }
+
+       if (dbg_metadata->lmac_req_buf_size !=3D (u32)(sizeof(struct dbg_er=
ror_trace_info_drv)))
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "FW buf size       %u expected %u\n",
+                                 dbg_metadata->lmac_req_buf_size,
+                                 (u32)(sizeof(struct dbg_error_trace_info_=
drv)));
+
+       if (dbg_metadata->physical_queue_cnt !=3D CL_MAX_BA_PHYSICAL_QUEUE_=
CNT)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "physical queue cn %u expected %u\n",
+                                 dbg_metadata->physical_queue_cnt,
+                                 CL_MAX_BA_PHYSICAL_QUEUE_CNT);
+
+       if (dbg_metadata->agg_index_max !=3D AGG_IDX_MAX)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "agg idx max       %u expected %u\n",
+                                 dbg_metadata->agg_index_max, AGG_IDX_MAX)=
;
+
+       if (dbg_metadata->ce_ac_max !=3D CE_AC_MAX)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "ac max            %u expected %u\n",
+                                 dbg_metadata->ce_ac_max, CE_AC_MAX);
+
+       if (dbg_metadata->mu_user_max !=3D MU_MAX_STREAMS)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "MU MAX            %u expected %u\n",
+                                 dbg_metadata->mu_user_max, MU_MAX_STREAMS=
);
+
+       if (dbg_metadata->txl_exch_trace_depth !=3D DBG_TXL_FRAME_EXCH_TRAC=
E_DEPTH)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "txl trace depth   %u expected %u\n",
+                                 dbg_metadata->txl_exch_trace_depth,
+                                 DBG_TXL_FRAME_EXCH_TRACE_DEPTH);
+
+       if (dbg_metadata->mac_hw_regs_max !=3D HAL_MACHW_REG_NUM)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "MAC HW regs cnt   %u expected %u\n",
+                                 dbg_metadata->mac_hw_regs_max,
+                                 HAL_MACHW_REG_NUM);
+
+       if (dbg_metadata->phy_hw_regs_max !=3D PHY_HW_DBG_REGS_CNT)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "PHY HW regs       %u expected %u\n",
+                                 dbg_metadata->phy_hw_regs_max,
+                                 PHY_HW_DBG_REGS_CNT);
+}
+
+static void cl_dbg_policy_table_print(struct cl_hw *cl_hw,
+                                     u8 *buf, int bufsz, int *pos,
+                                     struct tx_policy_tbl *policy_table_pt=
r,
+                                     u32 policy_table_addr)
+{
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D"
+                         "=3D Policy Table 0x%x =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+                        policy_table_addr);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| upatterntx         =3D 0x%08x| phycntrlinfo1  =
    =3D 0x%08x"
+                         "| phycntrlinfo2     =3D 0x%08x| maccntrlinfo1   =
   =3D 0x%08x|\n",
+                         policy_table_ptr->upatterntx,
+                         policy_table_ptr->phycntrlinfo1,
+                         policy_table_ptr->phycntrlinfo2,
+                         policy_table_ptr->maccntrlinfo1);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| maccntrlinfo2      =3D 0x%08x| ratecntrlinfo[0=
]   =3D 0x%08x"
+                         "| ratecntrlinfo[1]  =3D 0x%08x| ratecntrlinfo[2]=
   =3D 0x%08x|\n",
+                         policy_table_ptr->maccntrlinfo2,
+                         policy_table_ptr->ratecntrlinfo[0],
+                         policy_table_ptr->ratecntrlinfo[1],
+                         policy_table_ptr->ratecntrlinfo[2]);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| ratecntrlinfo[3]   =3D 0x%08x| phycntrlinfo3  =
    =3D 0x%08x"
+                         "| phycntrlinfo4     =3D 0x%08x| phycntrlinfo5   =
   =3D 0x%08x|\n",
+                         policy_table_ptr->ratecntrlinfo[3],
+                         policy_table_ptr->phycntrlinfo3,
+                         policy_table_ptr->phycntrlinfo4,
+                         policy_table_ptr->phycntrlinfo5);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| stationinfo        =3D 0x%08x| ratecntrlinfohe=
[0] =3D 0x%08x"
+                         "| ratecntrlinfohe[1]=3D 0x%08x| ratecntrlinfohe[=
2] =3D 0x%08x|\n",
+                         policy_table_ptr->stationinfo,
+                         policy_table_ptr->ratecntrlinfohe[0],
+                         policy_table_ptr->ratecntrlinfohe[1],
+                         policy_table_ptr->ratecntrlinfohe[2]);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| ratecntrlinfohe[3] =3D 0x%08x| maccntrlinfo3  =
    =3D 0x%08x"
+                         "| triggercommoninfo =3D 0x%08x| trigperuserinfo[=
0] =3D 0x%08x|\n",
+                         policy_table_ptr->ratecntrlinfohe[3],
+                         policy_table_ptr->maccntrlinfo3,
+                         policy_table_ptr->triggercommoninfo,
+                         policy_table_ptr->triggerperuserinfo[0]);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| trigperuserinfo[1] =3D 0x%08x| trigperuserinfo=
[2] =3D 0x%08x"
+                         "| trigperuserinfo[3]=3D 0x%08x| trigperuserinfo[=
4] =3D 0x%08x|\n",
+                         policy_table_ptr->triggerperuserinfo[1],
+                         policy_table_ptr->triggerperuserinfo[2],
+                         policy_table_ptr->triggerperuserinfo[3],
+                         policy_table_ptr->triggerperuserinfo[4]);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| trigperuserinfo[5] =3D 0x%08x| trigperuserinfo=
[6] =3D 0x%08x"
+                         "| trigperuserinfo[7]=3D 0x%08x|\n",
+                         policy_table_ptr->triggerperuserinfo[5],
+                         policy_table_ptr->triggerperuserinfo[6],
+                         policy_table_ptr->triggerperuserinfo[7]);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| triginforallocau0u3=3D 0x%08x| triginforalloca=
u4u7=3D 0x%08x |\n",
+                         policy_table_ptr->triggerinforuallocationu0u3,
+                         policy_table_ptr->triggerinforuallocationu4u7);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n");
+}
+
+static void cl_dbg_thd_print(struct cl_hw *cl_hw,
+                            u8 *buf, int bufsz, int *pos,
+                            struct tx_hd *thd_ptr, u32 thd_addr)
+{
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
+                         "=3D       THD 0x%x      =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n",
+                         thd_addr);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| upatterntx   =3D 0x%08x | nextfrmexseq_ptr =3D=
 0x%08x "
+                         "| nextmpdudesc_ptr =3D 0x%08x | first_pbd_ptr =
=3D 0x%08x|\n",
+                        thd_ptr->upatterntx,
+                        thd_ptr->nextfrmexseq_ptr,
+                        thd_ptr->nextmpdudesc_ptr,
+                        thd_ptr->first_pbd_ptr);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| datastartptr =3D 0x%08x | dataendptr       =3D=
 0x%08x "
+                         "| frmlen           =3D 0x%08x | spacinginfo   =
=3D 0x%08x|\n",
+                         thd_ptr->datastartptr,
+                         thd_ptr->dataendptr,
+                         thd_ptr->frmlen,
+                         thd_ptr->spacinginfo);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| phyctrlinfo1 =3D 0x%08x | policyentryaddr  =3D=
 0x%08x "
+                         "| macctrlinfo1     =3D 0x%08x | macctrlinfo2  =
=3D 0x%08x|\n",
+                         thd_ptr->phyctrlinfo1,
+                         thd_ptr->policyentryaddr,
+                         thd_ptr->macctrlinfo1,
+                         thd_ptr->macctrlinfo2);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| statinfo     =3D 0x%08x | phyctrlinfo2     =3D=
 0x%08x |\n",
+                         thd_ptr->statinfo,
+                         thd_ptr->phyctrlinfo2);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n");
+}
+
+static void cl_dbg_pbd_print(struct cl_hw *cl_hw,
+                            u8 *buf, int bufsz, int *pos,
+                            struct tx_pbd *pbd_ptr, u32 pbd_addr)
+{
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                        "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D"
+                        "=3D=3D=3D      PBD 0x%x     =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                        "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D\n",
+                        pbd_addr);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| upatterntx =3D 0x%08x | next =3D 0x%08x| datas=
tartptr =3D 0x%08x"
+                         "| dataendptr =3D 0x%08x| bufctrlinfo =3D 0x%08x|=
\n",
+                         pbd_ptr->upatterntx,
+                         pbd_ptr->next,
+                         pbd_ptr->datastartptr,
+                         pbd_ptr->dataendptr,
+                         pbd_ptr->bufctrlinfo);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
+                         "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n");
+}
+
+static void cl_dbg_dump_txm_regs(struct cl_hw *cl_hw,
+                                u8 *buf, int bufsz, int *pos,
+                                struct dbg_error_trace_info_drv *dump)
+{
+       int stream_idx;
+       struct dbg_fw_info *fw_info =3D &dump->common_info.fw_info;
+
+       for (stream_idx =3D 0; stream_idx < ARRAY_SIZE(fw_info->txlist_info=
_agg); ++stream_idx) {
+               struct dbg_txm_regs *txm_regs;
+
+               if (!fw_info->txlist_info_agg[stream_idx].curr_session_idx)
+                       continue;
+
+               txm_regs =3D &dump->common_info.hw_info.txm_regs[stream_idx=
];
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "#### TXM stream %u Registers\n", stream_=
idx);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|---------------------------------------=
-----------------------------|\n");
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "| HW state =3D %3u FW state =3D %3u SPX =
state =3D %3u free buff state =3D %3u|\n",
+                                 txm_regs->hw_state, txm_regs->fw_state,
+                                 txm_regs->spx_state, txm_regs->free_buf_s=
tate);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "| MPDU cnt =3D %3u LLI cnt  =3D %3u LLI =
done mpdu num =3D %3u  reason =3D %3u|\n",
+                                 txm_regs->mpdu_cnt, txm_regs->lli_cnt,
+                                 txm_regs->lli_done_mpdu_num, txm_regs->ll=
i_done_reason);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "| active bytes   =3D 0x%08x prefetch byt=
es =3D 0x%08x            |\n",
+                                 txm_regs->active_bytes, txm_regs->prefetc=
h_bytes);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "| last THD: addr =3D 0x%x MPDU number =
=3D %3u underrun cnt =3D %3u   |\n",
+                                 txm_regs->last_thd_done_addr,
+                                 txm_regs->last_thd_done_mpdu_num, txm_reg=
s->underrun_cnt);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                "|----------------------------------------=
----------------------------|\n\n");
+       }
+}
+
+static void cl_dbg_dump_machw_regs(struct cl_hw *cl_hw,
+                                  u8 *buf, int bufsz, int *pos,
+                                  struct dbg_error_trace_info_drv *dump)
+{
+       u8 i =3D 0, mu_idx;
+       struct dbg_hw_reg_info *hw_info =3D &dump->common_info.hw_info;
+
+       const char *hal_machw_reg_str[HAL_MACHW_REG_NUM] =3D {
+               [HAL_MACHW_AGGR_STATUS]                    =3D "AGGR_STATUS=
",
+               [HAL_MACHW_DEBUG_HWSM_1]                   =3D "DBG_HWSM_1"=
,
+               [HAL_MACHW_DEBUG_HWSM_2]                   =3D "DBG_HWSM_2"=
,
+               [HAL_MACHW_DEBUG_HWSM_3]                   =3D "DBG_HWSM_3"=
,
+               [HAL_MACHW_DMA_STATUS_1]                   =3D "DMA_STATUS_=
1",
+               [HAL_MACHW_DMA_STATUS_2]                   =3D "DMA_STATUS_=
2",
+               [HAL_MACHW_DMA_STATUS_3]                   =3D "DMA_STATUS_=
3",
+               [HAL_MACHW_DMA_STATUS_4]                   =3D "DMA_STATUS_=
4",
+               [HAL_MACHW_RX_HEADER_H_PTR]                =3D "RX_HEADER_H=
EAD_PTR",
+               [HAL_MACHW_RX_PAYLOAD_H_PTR]               =3D "RX_PAYLOAD_=
HEAD_PTR",
+               [HAL_MACHW_DEBUG_BCN_S_PTR]                =3D "DBG_BCN_STA=
TUS_PTR",
+               [HAL_MACHW_DEBUG_AC0_S_PTR]                =3D "DBG_AC_0_ST=
ATUS_PTR",
+               [HAL_MACHW_DEBUG_AC1_S_PTR]                =3D "DBG_AC_1_ST=
ATUS_PTR",
+               [HAL_MACHW_DEBUG_AC2_S_PTR]                =3D "DBG_AC_2_ST=
ATUS_PTR",
+               [HAL_MACHW_DEBUG_AC3_S_PTR]                =3D "DBG_AC_3_ST=
ATUS_PTR",
+               [HAL_MACHW_DEBUG_HTP_S_PTR]                =3D "DBG_HTP_STA=
TUS_PTR",
+               [HAL_MACHW_DEBUG_TX_C_PTR]                 =3D "DBG_TX_CURR=
ENT_PTR",
+               [HAL_MACHW_DEBUG_RX_HDR_C_PTR]             =3D "DBG_RX_HDR_=
CURRENT_PTR",
+               [HAL_MACHW_DEBUG_RX_PAY_C_PTR]             =3D "DBG_RX_PAY_=
CURRENT_PTR",
+               [HAL_MACHW_MU0_TX_POWER_LEVEL_DELTA_1]     =3D "DBG_MU0_TX_=
PWR_LEVEL_DELTA_1",
+               [HAL_MACHW_MU0_TX_POWER_LEVEL_DELTA_2]     =3D "DBG_MU0_TX_=
PWR_LEVEL_DELTA_2",
+               [HAL_MACHW_POWER_BW_CALIB_FACTOR]          =3D "DBG_TX_POWE=
R_BW_CALIB_FACTOR",
+               [HAL_MACHW_TX_POWER_ANTENNA_FACTOR_1_ADDR] =3D "DBG_tX_POWE=
R_ANT_FACTOR_1",
+               [HAL_MACHW_TX_POWER_ANTENNA_FACTOR_2_ADDR] =3D "DBG_TX_POWE=
R_ANT_FACTOR_2"
+       };
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "\n##### MAC HW regs =
####\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(hw_info->mac_hw_reg); ++i)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "%30s =3D 0x%08x\n",
+                                 hal_machw_reg_str[i], hw_info->mac_hw_reg=
[i]);
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#########################\n\n");
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "############# MAC HW Secondary FSMs ############=
#\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
----------|\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                        "|MU IDX|%12s|%12s|%12s|%11s|\n",
+                         hal_machw_reg_str[HAL_MACHW_AGGR_STATUS],
+                         hal_machw_reg_str[HAL_MACHW_DEBUG_HWSM_1],
+                         hal_machw_reg_str[HAL_MACHW_DEBUG_HWSM_2],
+                         hal_machw_reg_str[HAL_MACHW_DEBUG_HWSM_3]);
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
----------|\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(hw_info->mac_hw_sec_fsm); ++i) {
+               mu_idx =3D CL_MU1_IDX + i;
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "| MU %u | 0x%08x | 0x%08x | 0x%08x | 0x%=
08x|\n",
+                                 mu_idx,
+                                 hw_info->mac_hw_sec_fsm[i][HAL_MACHW_AGGR=
_STATUS],
+                                 hw_info->mac_hw_sec_fsm[i][HAL_MACHW_DEBU=
G_HWSM_1],
+                                 hw_info->mac_hw_sec_fsm[i][HAL_MACHW_DEBU=
G_HWSM_2],
+                                 hw_info->mac_hw_sec_fsm[i][HAL_MACHW_DEBU=
G_HWSM_3]);
+       }
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
----------|\n\n");
+
+       /* Write THD data if valid */
+       for (i =3D HAL_MACHW_DEBUG_BCN_S_PTR; i <=3D HAL_MACHW_DEBUG_TX_C_P=
TR; ++i)
+               if (hw_info->mac_hw_reg[i]) {
+                       u8 thd_idx =3D i - HAL_MACHW_DEBUG_BCN_S_PTR;
+
+                       cl_dbg_thd_print(cl_hw, buf, bufsz, pos,
+                                        &dump->machw_thd_info.thd[thd_idx]=
,
+                                        hw_info->mac_hw_reg[i]);
+               }
+
+       cl_dbg_dump_txm_regs(cl_hw, buf, bufsz, pos, dump);
+}
+
+static void cl_dbg_dump_phyhw_regs(struct cl_hw *cl_hw,
+                                  u8 *buf, int bufsz, int *pos,
+                                  struct dbg_error_trace_info_drv *dump)
+{
+       int i =3D 0;
+       const char *phy_hw_mpu_reg_str[PHY_HW_DBG_REGS_CNT] =3D {
+               [MPU_COMMON_FORMAT]       =3D "MPU_COMMON_FORMAT",
+               [MPU_COMMON_FIELD_CTRL]   =3D "MPU_COMMON_FIELD_CTRL",
+               [MPU_COMMON_LEGACY_INFO]  =3D "MPU_COMMON_LEGACY_INFO",
+               [MPU_COMMON_COMMON_CFG_1] =3D "MPU_COMMON_COMMON_CFG_1",
+               [MPU_COMMON_COMMON_CFG_2] =3D "MPU_COMMON_COMMON_CFG_2",
+               [MPU_COMMON_COMMON_CFG_3] =3D "MPU_COMMON_COMMON_CFG_3",
+               [MPU_COMMON_HE_CFG_1]     =3D "MPU_COMMON_HE_CFG_1",
+               [MPU_COMMON_HE_CFG_2]     =3D "MPU_COMMON_HE_CFG_2",
+               [MPU_COMMON_INT_STAT_RAW] =3D "MPU_COMMON_INT_STAT_RAW",
+               [RIU_CCAGENSTAT]          =3D "RIU_CCAGENSTAT",
+       };
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "##### PHY HW regs ##=
##\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(dump->common_info.hw_info.phy_mpu_hw_r=
eg); ++i)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "%25s =3D 0x%=
08x\n",
+                                 phy_hw_mpu_reg_str[i],
+                                 dump->common_info.hw_info.phy_mpu_hw_reg[=
i]);
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "####################=
#####\n\n");
+}
+
+static void cl_dbg_dump_ac_info(struct cl_hw *cl_hw,
+                               u8 *buf, int bufsz, int *pos,
+                               struct dbg_error_trace_info_drv *dump)
+{
+       int i =3D 0;
+       struct dbg_fw_info *fw_info =3D &dump->common_info.fw_info;
+       const char *fw_tx_state_str[CE_TXL_TX_PATH_MAX] =3D {
+               [CE_TXL_TX_PATH_IDLE]                  =3D "PATH_IDLE",
+               [CE_TXL_TX_PATH_START]                 =3D "PATH_START",
+               [CE_TXL_TX_PATH_POST_START_DOWNLOAD]   =3D "POST_START_DOWN=
LOAD",
+               [CE_TXL_TX_PATH_TX_DATA_DOWNLOADING]   =3D "TX_DATA_DOWNLOA=
DING",
+               [CE_TXL_TX_PATH_MU_RECOVERY]           =3D "MU_RECOVERY",
+               [CE_TXL_TX_PATH_LAST_DOWNLOADING]      =3D "LAST_DOWNLOADIN=
G",
+               [CE_TXL_TX_PATH_NEXT_SESSION_PREPARED] =3D "NEXT_SESSION_PR=
EP",
+               [CE_TXL_TX_PATH_MU_NEXT_JOB_READY]     =3D "MU_NEXT_JOB_REA=
DY",
+       };
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "\n#####  Per AC info  ####\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
---------|\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|AC|MU|session|phys queue|check_state|   TX path=
 state   |\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(fw_info->ac_info); ++i) {
+               u32 mu_idx =3D (i >=3D IPC_TX_QUEUE_CNT) ? (i - IPC_TX_QUEU=
E_CNT + 1) : 0;
+               u32 session_idx =3D (fw_info->ac_info[i].active_session !=
=3D FW_DBG_INVALID_SESSION) ?
+                       fw_info->ac_info[i].active_session : 0;
+
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|--+--+-------+----------+-----------+--=
-----------------|\n");
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|%2u|%2u|%7u|%10u|%11u|%19s|\n",
+                                 i,
+                                 mu_idx,
+                                 session_idx,
+                                 fw_info->ac_info[i].physical_queue_idx,
+                                 fw_info->ac_info[i].chk_state,
+                                 fw_tx_state_str[fw_info->ac_info[i].tx_pa=
th_state]);
+       }
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
---------|\n");
+}
+
+static void cl_dbg_dump_single_tx_list_info(struct cl_hw *cl_hw,
+                                           u8 *buf, int bufsz, int *pos,
+                                           struct dbg_error_trace_info_drv=
 *dump)
+{
+       int i =3D 0;
+       struct dbg_fw_info *fw_info =3D &dump->common_info.fw_info;
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "\n##### Singles txdesc lists info ####\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|----|---------|-------------|--------------|\n"=
);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "| AC | pending | downloading | transmitting |\n"=
);
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|----|---------|-------------|--------------|\n"=
);
+
+       for (i =3D 0; i < ARRAY_SIZE(fw_info->txlist_info_singles); ++i) {
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|%4u|%9u|%13u|%14u|\n",
+                                 i,
+                                 fw_info->txlist_info_singles[i].pending_c=
nt,
+                                 fw_info->txlist_info_singles[i].download_=
cnt,
+                                 fw_info->txlist_info_singles[i].transmit_=
cnt);
+
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|----|---------|-------------|----------=
----|\n");
+       }
+}
+
+static void cl_dbg_dump_agg_tx_list_info(struct cl_hw *cl_hw,
+                                        u8 *buf, int bufsz, int *pos,
+                                        struct dbg_error_trace_info_drv *d=
ump)
+{
+       int i =3D 0;
+       u32 mu_idx;
+       struct dbg_fw_info *fw_info =3D &dump->common_info.fw_info;
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "\n##### Agg txdesc lists info ####\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
-----------------|\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|idx|mu|session|pending|download|transmit|wait4b=
a|next   |next   |\n");
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|   |  |       |       |        |        |      =
 |session|pending|\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(fw_info->txlist_info_agg); ++i) {
+               mu_idx =3D ((i >=3D AGG_MU1_IDX) && (i <=3D AGG_MU7_IDX)) ?=
 (i - AGG_MU1_IDX + 1) : 0;
+
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|---+--+-------+-------+--------+-------=
-+--"
+                                 "-----+-------+-------|\n");
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|%3u|%2u|%7u|%7u|%8u|%8u|%7u|%7u|%7u|\n"=
,
+                                 i,
+                                 mu_idx,
+                                 fw_info->txlist_info_agg[i].curr_session_=
idx,
+                                 fw_info->txlist_info_agg[i].pending_cnt,
+                                 fw_info->txlist_info_agg[i].download_cnt,
+                                 fw_info->txlist_info_agg[i].transmit_cnt,
+                                 fw_info->txlist_info_agg[i].wait_for_ba_c=
nt,
+                                 fw_info->txlist_info_agg[i].next_session_=
idx,
+                                fw_info->txlist_info_agg[i].next_pending_c=
nt);
+       }
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "|-----------------------------------------------=
-----------------|\n");
+}
+
+static void cl_dbg_dump_thd_chains_info(struct cl_hw *cl_hw,
+                                       u8 *buf, int bufsz, int *pos,
+                                       struct dbg_error_trace_info_drv *du=
mp, u8 ac)
+{
+       int i =3D 0;
+       u32 data_offset =3D 0;
+       struct dbg_thd_chains_info *chain_info =3D &dump->thd_chains_info[a=
c];
+       struct dbg_thd_chains_data *chain_data =3D &dump->thd_chains_data[a=
c];
+       struct tx_hd *hd;
+       struct tx_policy_tbl *policy_tbl;
+       struct tx_pbd *pbd;
+
+       while (chain_info->type_array[i] !=3D DBG_CHAINS_INFO_EMPTY) {
+               switch (chain_info->type_array[i]) {
+               case DBG_CHAINS_INFO_THD:
+                       hd =3D (struct tx_hd *)&chain_data->data[data_offse=
t];
+                       cl_dbg_thd_print(cl_hw, buf, bufsz, pos, hd,
+                                        chain_info->elem_address[i]);
+                       data_offset +=3D sizeof(struct tx_hd);
+                       break;
+
+               case DBG_CHAINS_INFO_PT:
+                       policy_tbl =3D (struct tx_policy_tbl *)&chain_data-=
>data[data_offset];
+                       cl_dbg_policy_table_print(cl_hw, buf, bufsz, pos,
+                                                 policy_tbl,
+                                                 chain_info->elem_address[=
i]);
+                       data_offset +=3D sizeof(struct tx_policy_tbl);
+                       break;
+
+               case DBG_CHAINS_INFO_PBD:
+                       pbd =3D (struct tx_pbd *)&chain_data->data[data_off=
set];
+                       cl_dbg_pbd_print(cl_hw, buf, bufsz, pos, pbd,
+                                        chain_info->elem_address[i]);
+                       data_offset +=3D sizeof(struct tx_pbd);
+                       break;
+
+               default:
+                       return;
+               }
+
+               i++;
+               if (i >=3D DBG_CHAINS_INFO_ELEM_CNT)
+                       break;
+       }
+}
+
+static void cl_dbg_dump_agg_thd_info(struct cl_hw *cl_hw,
+                                    u8 *buf, int bufsz, int *pos,
+                                    struct dbg_error_trace_info_drv *dump,
+                                    u8 ac, u8 mu_idx)
+{
+       u8 agg_idx =3D (ac < AGG_MU1_IDX) ? ac : (mu_idx + AGG_MU1_IDX - 1)=
;
+       u32 addr =3D dump->common_info.agg_thds_addr[agg_idx].rts_cts_thd_a=
ddr;
+
+       if (addr) {
+               /* RTS CTS THD print */
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "\n  RTS CTS =
THD 0x%x\n", addr);
+               cl_dbg_thd_print(cl_hw, buf, bufsz, pos,
+                                &dump->agg_thd_info[agg_idx].rts_cts_thd, =
addr);
+       }
+
+       addr =3D dump->common_info.agg_thds_addr[agg_idx].athd_addr;
+       if (addr) {
+               /* ATHD print */
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "\n  ATHD 0x%=
x\n", addr);
+               cl_dbg_thd_print(cl_hw, buf, bufsz, pos,
+                                &dump->agg_thd_info[agg_idx].athd, addr);
+       }
+
+       addr =3D dump->common_info.agg_thds_addr[agg_idx].policy_table_addr=
;
+       if (addr) {
+               /* Policy Table print */
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "  Policy Tab=
le 0x%x\n", addr);
+               cl_dbg_policy_table_print(cl_hw, buf, bufsz, pos,
+                                         &dump->agg_thd_info[agg_idx].poli=
cy_table,
+                                         addr);
+       }
+
+       addr =3D dump->common_info.agg_thds_addr[agg_idx].tf_thd_addr;
+       if (addr) {
+               /* TF-THD print */
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "  TF-THD 0x%=
x\n", addr);
+               cl_dbg_thd_print(cl_hw, buf, bufsz, pos,
+                                &dump->agg_thd_info[agg_idx].tf_thd, addr)=
;
+       }
+
+       cl_dbg_dump_thd_chains_info(cl_hw, buf, bufsz, pos, dump, ac);
+
+       addr =3D dump->common_info.agg_thds_addr[agg_idx].bar_thd_addr;
+       if (addr) {
+               /* BAR THD print */
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "  BAR THD 0x=
%x\n", addr);
+               cl_dbg_thd_print(cl_hw, buf, bufsz, pos,
+                                &dump->agg_thd_info[agg_idx].bar_thd, addr=
);
+       }
+}
+
+static void cl_dbg_dump_thd_info(struct cl_hw *cl_hw,
+                                u8 *buf, int bufsz, int *pos,
+                                struct dbg_error_trace_info_drv *dump,
+                                u8 ac, u8 mu_idx)
+{
+       u32 session_idx =3D dump->common_info.fw_info.ac_info[ac].active_se=
ssion;
+
+       if (session_idx !=3D FW_DBG_INVALID_SESSION) {
+               bool is_agg =3D ((mu_idx > 0) || (session_idx >=3D IPC_TX_Q=
UEUE_CNT)) ? true : false;
+
+               if (is_agg)
+                       cl_dbg_dump_agg_thd_info(cl_hw, buf, bufsz, pos, du=
mp, ac, mu_idx);
+               else
+                       cl_dbg_dump_thd_chains_info(cl_hw, buf, bufsz, pos,=
 dump, ac);
+       }
+}
+
+static void cl_dbg_dump_tx_trace_info(struct cl_hw *cl_hw,
+                                     u8 *buf, int bufsz, int *pos,
+                                     struct dbg_error_trace_info_drv *dump=
)
+{
+       int i =3D 0;
+       const char *fw_tx_frame_type_str[CL_MAX_FRM_TYPE] =3D {
+               [SING_FRM_TYPE]             =3D "MPDU",
+               [AGG_FRM_TYPE]              =3D "AMPDU",
+               [AGG_NEXT_IN_TXOP_FRM_TYPE] =3D "TXOP",
+               [INT_FRM_TYPE]              =3D "INTERNAL",
+               [BCN_FRM_TYPE]              =3D "BCN",
+               [MU_FRM_TYPE]               =3D "MU_AMPDU",
+               [FRM_TYPE_BASIC_TRIGGER]    =3D "BASIC_TF",
+               [FRM_TYPE_MU_BAR_TRIGGER]   =3D "MU_BAR",
+               [BCK_BCN_TYPE]              =3D "BCN_BCK",
+               [QOS_NULL]                  =3D "QOSNULL",
+               [AGG_TB]                    =3D "AGG_TB",
+               [RTS_TYPE]                  =3D "RTS_FW",
+               [CTS_TYPE]                  =3D "CTS_FW",
+               [TB_SINGLE_FRM_TYPE]        =3D "TB_SMPDU",
+               [TF_AMPDU_TYPE]             =3D "TF_AMPDU"
+       };
+
+       *pos +=3D scnprintf(buf + *pos,
+                         bufsz - *pos,
+                         "\n#### TX Trace ####\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(dump->common_info.fw_info.txl_ac_chain=
_trace); ++i) {
+               u8 trace_idx =3D 0, table_idx =3D 0;
+               u32 mu_idx;
+               struct dbg_txl_ac_chain_trace *trace_ptr =3D
+                       &dump->common_info.fw_info.txl_ac_chain_trace[i];
+               struct cl_dbg_txl_chain_info *data;
+
+               if (trace_ptr->next_chain_index =3D=3D 0)
+                       table_idx =3D DBG_TXL_FRAME_EXCH_TRACE_DEPTH - 1;
+               else
+                       table_idx =3D trace_ptr->next_chain_index - 1;
+
+               data =3D &trace_ptr->data[table_idx];
+
+               if (data->count =3D=3D 0)
+                       continue;
+
+               mu_idx =3D (i >=3D IPC_TX_QUEUE_CNT) ? (i - IPC_TX_QUEUE_CN=
T + 1) : 0;
+
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "\n AC %u MU =
idx %u:\n", i, mu_idx);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=
=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                                 "|=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=
=3D=3D"
+                                 "|=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=
=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|\n"
+                                 "|#PPDU   | Type   |First THD | Last THD =
| Prev THD "
+                                 "|Req BW| PTalbe   |PTalbe_HE |queue|Leng=
th "
+                                 "|#MPDU |Chosen BW|TX time| txstatus |\n"
+                                 "|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=
=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+                                 "|=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=
=3D=3D"
+                                 "|=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=
=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|\n");
+
+               for (trace_idx =3D 0; trace_idx < DBG_TXL_FRAME_EXCH_TRACE_=
DEPTH; ++trace_idx) {
+                       *pos +=3D scnprintf(buf + *pos,
+                                         bufsz - *pos,
+                                         "|%8u|%8s|0x%08x|0x%08x|0x%08x|%6=
u|0x%08x"
+                                         "|0x%08x|%5u|%7u|%6u|%9u|%7u|0x%0=
8x|\n",
+                                         data->count,
+                                         fw_tx_frame_type_str[data->frm_ty=
pe],
+                                         data->first_thd_ptr,
+                                         data->last_thd_ptr,
+                                         data->prev_thd_ptr,
+                                         data->reqbw,
+                                         data->rate_ctrl_info,
+                                         data->rate_ctrl_info_he,
+                                         data->ce_txq_idx,
+                                         data->length,
+                                         data->mpdu_count,
+                                         data->chbw,
+                                         data->tx_time,
+                                         data->txstatus);
+
+                       if (!table_idx)
+                               table_idx =3D DBG_TXL_FRAME_EXCH_TRACE_DEPT=
H - 1;
+                       else
+                               table_idx--;
+
+                       data =3D &trace_ptr->data[table_idx];
+               }
+
+               *pos +=3D scnprintf(buf + *pos,
+                                 bufsz - *pos,
+                                 "|=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=
=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=
=3D=3D=3D"
+                                 "=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=
=3D|=3D"
+                                 "=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D|=
=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D|\n");
+
+               cl_dbg_dump_thd_info(cl_hw, buf, bufsz, pos, dump, i, mu_id=
x);
+       }
+}
+
+static void cl_dbg_dump_error_info(struct cl_hw *cl_hw,
+                                  u8 *buf, int bufsz, int *pos,
+                                  struct dbg_error_trace_info_drv *trace)
+{
+       struct dbg_print_ind *ind =3D &trace->common_info.error_info;
+       const char *assert_string;
+       u16 file_id =3D le16_to_cpu(ind->file_id);
+       u16 line =3D le16_to_cpu(ind->line);
+       u16 has_param =3D le16_to_cpu(ind->has_param);
+       u32 param =3D has_param ? le32_to_cpu(ind->param) : 0;
+
+       if (file_id && line) {
+               *pos +=3D scnprintf(buf + *pos,
+                                bufsz - *pos,
+                                "ASSERT_TCV%u @ FILE=3D%hu LINE=3D%hu para=
m=3D0x%08X\n",
+                                cl_hw->idx, file_id, line, param);
+
+               /* Get assert string */
+               assert_string =3D cl_dbgfile_get_msg_txt(&cl_hw->dbg_data, =
file_id, line);
+               if (!assert_string)
+                       assert_string =3D "ASSERT STRING NOT FOUND";
+
+               *pos +=3D scnprintf(buf + *pos,
+                                 bufsz - *pos,
+                                 "%s\n", assert_string);
+       } else {
+               struct dbg_info *dbg_info =3D (struct dbg_info *)cl_hw->dbg=
info.buf;
+
+               *pos +=3D snprintf(buf + *pos,
+                                bufsz - *pos,
+                                "%s\n", dbg_info->u.dump.general_data.erro=
r);
+       }
+}
+
+static void cl_dbg_dump_fw_trace_info(struct cl_hw *cl_hw,
+                                     u8 *buf, int bufsz, int *pos,
+                                     struct dbg_error_trace_info_drv *dump=
)
+{
+       int i =3D 0;
+
+       *pos +=3D scnprintf(buf + *pos,
+                         bufsz - *pos,
+                         "\n###   FW trace dump   ###\n"
+                         "------------------------------------------------=
------"
+                         "-----------------------------------\n"
+                         "|idx|   String        | value 1  | value 2  | va=
lue 3 "
+                         "| value 4  | value 5  | value 6  |\n"
+                         "|---+-----------------+----------+----------+---=
------"
+                         "-+----------+----------+----------|\n");
+
+       for (i =3D 0; i < ARRAY_SIZE(dump->common_info.fw_info.fw_trace); +=
+i) {
+               u8 dbg_idx =3D (dump->common_info.fw_info.fw_trace_idx + i)=
 % DBG_FW_TRACE_SIZE;
+               struct dbg_fw_trace *trace =3D &dump->common_info.fw_info.f=
w_trace[dbg_idx];
+               char *str =3D trace->string_ptr ? trace->string_char : "NUL=
L";
+
+               *pos +=3D scnprintf(buf + *pos,
+                                 bufsz - *pos,
+                                 "|%3u|%17s|0x%08x|0x%08x|0x%08x|0x%08x|0x=
%08x|0x%08x|\n",
+                                 i,
+                                 str,
+                                 trace->var_1,
+                                 trace->var_2,
+                                 trace->var_3,
+                                 trace->var_4,
+                                 trace->var_5,
+                                 trace->var_6);
+       }
+
+       *pos +=3D scnprintf(buf + *pos,
+                         bufsz - *pos,
+                         "------------------------------------------------=
----"
+                         "-------------------------------------\n");
+}
+
+static int cl_dbg_dump_host_descr(struct cl_hw *cl_hw,
+                                 u8 *buf, int bufsz, int *pos)
+{
+       struct new_utsname *nu =3D init_utsname();
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### KERNEL ####\n"
+                         "release: %s\n"
+                         "version: %s\n"
+                         "machine: %s\n",
+                         nu->release,
+                         nu->version,
+                         nu->machine);
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### CPUs ####\n"
+                         "num online  : %d\n"
+                         "num possible: %d\n"
+                         "num present : %d\n"
+                         "num active  : %d\n",
+                         num_online_cpus(),
+                         num_possible_cpus(),
+                         num_present_cpus(),
+                         num_active_cpus());
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### ENDIANNESS ####\n"
+                         "LE (byte) : %u\n"
+                         "LE (bits) : %u\n"
+                         "BE (byte) : %u\n"
+                         "BE (bits) : %u\n",
+                         cl_are_host_bytes_le(),
+                         cl_are_host_bits_le(),
+                         cl_are_host_bytes_be(),
+                         cl_are_host_bits_be());
+       return 0;
+}
+
+static int cl_dbg_dump_chip_descr(struct cl_hw *cl_hw,
+                                 u8 *buf, int bufsz, int *pos)
+{
+       struct cl_version_db *vd =3D &cl_hw->version_db;
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### BASE ####\n"
+                         "chip : %u\n"
+                         "TCV  : %u\n"
+                         "bus  : %u\n",
+                         cl_hw->chip->idx,
+                         cl_hw->tcv_idx,
+                         cl_hw->chip->bus_type);
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### VERSIONS ####\n"
+                         "drv     : %s\n"
+                         "FW      : %s\n"
+                         "DSP     : 0x%-.8X\n"
+                         "RFIC SW : %u\n"
+                         "RFIC HW : 0x%X\n",
+                         vd->drv,
+                         vd->fw,
+                         vd->dsp,
+                         vd->rfic_sw,
+                         vd->rfic_hw);
+       /* TODO: AGC info */
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### STATE ####\n"
+                         "recoveries : %u\n"
+                         "DRV flags  : %lu\n"
+                         "TCV-0 en   : %u\n"
+                         "TCV-1 en   : %u\n",
+                         cl_hw->fw_recovery_cntr,
+                         cl_hw->drv_flags,
+                         cl_chip_is_tcv0_enabled(cl_hw->chip),
+                         cl_chip_is_tcv1_enabled(cl_hw->chip));
+       return 0;
+}
+
+static int cl_dbg_dump_ela_descr(struct cl_hw *cl_hw,
+                                u8 *buf, int bufsz, int *pos)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       int ret =3D 0;
+
+       if (cl_ela_is_on(chip)) {
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "#### CONF SOURCE ####\n"
+                                 "ELA mode: %s #\n",
+                                 chip->conf->ce_ela_mode);
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "#### CONF LIFETIME ####\n"
+                                 "adaptations  : %u #\n"
+                                 "applications : %u #\n"
+                                 "error state  : %d #\n",
+                                 ed->stats.adaptations_cnt,
+                                 ed->stats.applications_cnt,
+                                 ed->error_state);
+       } else {
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "#### DISABLED ####\n");
+       }
+       return ret;
+}
+
+static int cl_dbg_dump_raw_lcu_conf(struct cl_hw *cl_hw,
+                                   u8 *buf, int bufsz, int *pos)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       int ret =3D 0;
+
+       if (cl_ela_is_on(chip) && ed->raw_lcu_config)
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "%s", ed->raw=
_lcu_config);
+       else
+               ret =3D -ENODATA;
+       return ret;
+}
+
+static int cl_dbg_dump_adapted_lcu_conf(struct cl_hw *cl_hw,
+                                       u8 *buf, int bufsz, int *pos)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       struct cl_lcu_cmd *cmd =3D NULL, *cmd_tmp =3D NULL;
+       int ret =3D 0;
+
+       if (cl_ela_is_on(chip)) {
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "#### CONF SOURCE ####\n"
+                                 "# %s #\n",
+                                 cl_ela_lcu_config_name(chip));
+               *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                 "#### CONF COMMANDS ####\n");
+
+               list_for_each_entry_safe(cmd, cmd_tmp, &ed->cmd_head, cmd_l=
ist)
+                       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                                         "%s 0x%X 0x%X\n",
+                                         cl_ela_lcu_cmd_str(cmd->type),
+                                         cmd->offset,
+                                         cmd->value);
+       } else {
+               ret =3D -ENODATA;
+       }
+       return ret;
+}
+
+static int cl_dbg_dump_la_mem(struct cl_hw *cl_hw,
+                             u8 *buf, int bufsz, int *pos,
+                             int idx, struct dbg_info *dbg_info)
+{
+       size_t la_size =3D 0;
+
+       if (ARRAY_SIZE(dbg_info->u.dump.la_mem) < idx + 1)
+               return -EINVAL;
+
+       la_size =3D ARRAY_SIZE(dbg_info->u.dump.la_mem[idx]);
+       if (la_size > (bufsz - *pos))
+               return -ENOBUFS;
+
+       memcpy(buf + *pos, &dbg_info->u.dump.la_mem[idx], la_size);
+       *pos +=3D la_size;
+
+       return 0;
+}
+
+static int cl_dbg_dump_la_conf(struct cl_hw *cl_hw,
+                              u8 *buf, int bufsz, int *pos,
+                              int idx, struct dbg_debug_info_tag *gdata)
+{
+       size_t la_size =3D 0;
+
+       if (ARRAY_SIZE(gdata->la_conf) < idx + 1)
+               return -EINVAL;
+
+       la_size =3D sizeof(gdata->la_conf[idx]);
+       if (la_size > (bufsz - *pos))
+               return -ENOBUFS;
+
+       memcpy(buf + *pos, &gdata->la_conf[idx], la_size);
+       *pos +=3D la_size;
+
+       return 0;
+}
+
+static int cl_dbg_dump_mac_diags(struct cl_hw *cl_hw,
+                                u8 *buf, int bufsz, int *pos,
+                                struct dbg_debug_info_tag *gdata)
+{
+       size_t la_size =3D ARRAY_SIZE(gdata->diags_mac);
+
+       if (la_size > (bufsz - *pos))
+               return -ENOBUFS;
+
+       memcpy(buf + *pos, &gdata->diags_mac, la_size);
+       *pos +=3D la_size;
+
+       return 0;
+}
+
+static int cl_dbg_dump_hw_diags(struct cl_hw *cl_hw,
+                               u8 *buf, int bufsz, int *pos,
+                               struct dbg_debug_info_tag *gdata)
+{
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos, "%08X\n", gdata->hw_d=
iag);
+
+       return 0;
+}
+
+static int cl_dbg_dump_sw_diags(struct cl_hw *cl_hw,
+                               u8 *buf, int bufsz, int *pos,
+                               struct dbg_debug_info_tag *gdata)
+{
+       size_t la_size =3D min_t(size_t, ARRAY_SIZE(gdata->sw_diag),
+                              gdata->sw_diag_len);
+
+       if (la_size > (bufsz - *pos))
+               return -ENOBUFS;
+
+       memcpy(buf + *pos, &gdata->sw_diag, la_size);
+       *pos +=3D la_size;
+
+       return 0;
+}
+
+static int cl_dbg_dump_chan_info(struct cl_hw *cl_hw,
+                                u8 *buf, int bufsz, int *pos,
+                                struct dbg_debug_info_tag *gdata)
+{
+       u32 info1 =3D le32_to_cpu(gdata->chan_info.info1);
+       u32 info2 =3D le32_to_cpu(gdata->chan_info.info2);
+       u8 band =3D info1 & 0xFF;
+       u8 type =3D (info1 >> 8) & 0xFF;
+       u16 prim20 =3D (info1 >> 16) & 0xFFFF;
+       u16 center1 =3D info2 & 0xFFFF;
+
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### FW ####\n"
+                         "band         : %u\n"
+                         "type         : %u\n"
+                         "prim20_freq  : %u.%u MHz\n"
+                         "center1_freq : %u.%u MHz\n",
+                         band,
+                         type,
+                         Q2_TO_FREQ(prim20), Q2_TO_FREQ_FRAC(prim20),
+                         Q2_TO_FREQ(center1), Q2_TO_FREQ_FRAC(center1));
+       *pos +=3D scnprintf(buf + *pos, bufsz - *pos,
+                         "#### DRIVER ####\n"
+                         "channel      : %u\n"
+                         "bw           : %u\n"
+                         "primary_freq : %u MHz\n"
+                         "center_freq  : %u MHz\n",
+                         cl_hw->channel,
+                         cl_hw->bw,
+                         cl_hw->primary_freq,
+                         cl_hw->center_freq);
+       return 0;
+}
+
+/**
+ * pre_fill_hook - initialize record data in coredump container
+ *
+ * Each record presents some section of information. Since, at this stage =
we
+ * have no idea about estimated data length, we shift "pos" only for size
+ * of header information, actual number of written bytes should be calcula=
ted
+ * in the post_fill_hook.
+ *
+ * @record: (NLEV) Name-Length-Error-Values record.
+ * @d: Coredump to fill in.
+ * @name: Name to set for this specific record;
+ * @pos: Position of last filled in element in the coredump (equal prev_po=
s till
+ *  fill in).
+ * @prev_pos: Position of the previous filled in element in the coredump.
+ *
+ * Returns nothing.
+ */
+static void pre_fill_hook(struct cl_nlev **record, struct cl_coredump *cd,
+                         char *name, int *pos, int *prev_pos)
+{
+       size_t coredump_space =3D le32_to_cpu(cd->len) - sizeof(*cd);
+       size_t free_space =3D coredump_space - *pos;
+
+       /* Save prev postion for NLEV length calculation in "post" hook */
+       *prev_pos =3D *pos;
+
+       /* Check if there is enough space for NLE (w/o V) */
+       if (free_space < sizeof(**record))
+               return;
+
+       /* Set pointer of the record to proper buffer place */
+       *record =3D (struct cl_nlev *)(cd->data + *pos);
+
+       /* Fill type info string */
+       scnprintf(cd->data + *pos, free_space, "%s", name);
+
+       /* Adjust position as like as new NLEV was added */
+       *pos +=3D sizeof(**record);
+}
+
+/**
+ * post_fill_hook - finalize record data in the coredump container
+ *
+ * @record: (NLEV) Name-Length-Error-Values record.
+ * @err_code: processing error indication, typical errno
+ * @pos: Position of last filled in element in the coredump.
+ * @prev_pos: Position of the previous filled in element in the coredump,
+ *  in conjunction with "pos" is used to calculated filled in data and set
+ *  it as "Length" in the NLEV header.
+ *
+ * Returns nothing.
+ */
+static void post_fill_hook(struct cl_nlev **record, int *err_code, int *po=
s,
+                          int *prev_pos)
+{
+       /* Finalize what we know about NLEV - size (without headers)
+        * and processing error codeA
+        */
+       (**record).l =3D cpu_to_le32(*pos - *prev_pos - sizeof(**record));
+       (**record).e =3D cpu_to_le32(*err_code);
+
+       /* Reset error code for further usage */
+       *err_code =3D 0;
+}
+
+struct cl_coredump *cl_fw_dbg_prepare_coredump(struct cl_hw *cl_hw)
+{
+       struct dbg_info *dbg_info =3D (struct dbg_info *)cl_hw->dbginfo.buf=
;
+       struct dbg_error_trace_info_drv *fdump =3D &dbg_info->u.dump.fw_dum=
p;
+       struct dbg_debug_info_tag *gdata =3D &dbg_info->u.dump.general_data=
;
+       struct cl_coredump *cd;
+       unsigned char *buf;
+       /* TODO: Make this size dynamic */
+       size_t len =3D PAGE_SIZE * 100;
+       size_t data_len =3D len - sizeof(*cd);
+       int pos =3D 0;
+       int prev_pos =3D 0;
+       int e =3D 0;
+       struct cl_nlev *rec =3D NULL;
+
+       buf =3D vzalloc(len);
+       if (!buf)
+               goto out;
+
+       cd =3D (typeof(cd))buf;
+       cd->len =3D cpu_to_le32(len);
+       cd->self_version =3D cpu_to_le32((CL_COREDUMP_V1 << 28) +
+                                      sizeof(*cd) + sizeof(*rec));
+       /* TODO: Mask support */
+       cd->dump_mask =3D cpu_to_le32(0);
+       cd->trig_tv_sec =3D cpu_to_le64(cl_hw->dbginfo.trigger_tstamp.tv_se=
c);
+       cd->trig_tv_nsec =3D cpu_to_le64(cl_hw->dbginfo.trigger_tstamp.tv_n=
sec);
+       scnprintf(cd->magic, sizeof(cd->magic), "CE_CL8K_DUMP");
+
+       /* Main section with dynamic dump data filling */
+       mutex_lock(&cl_hw->dbginfo.mutex);
+
+       pre_fill_hook(&rec, cd, "chip_descr", &pos, &prev_pos);
+       e =3D cl_dbg_dump_chip_descr(cl_hw, cd->data, data_len, &pos);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       pre_fill_hook(&rec, cd, "host_descr", &pos, &prev_pos);
+       e =3D cl_dbg_dump_host_descr(cl_hw, cd->data, data_len, &pos);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       pre_fill_hook(&rec, cd, "error", &pos, &prev_pos);
+       cl_dbg_dump_error_info(cl_hw, cd->data, data_len, &pos, fdump);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Embedded logic analyzer info */
+       pre_fill_hook(&rec, cd, "ela_descr", &pos, &prev_pos);
+       e =3D cl_dbg_dump_ela_descr(cl_hw, cd->data, data_len, &pos);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       pre_fill_hook(&rec, cd, "raw_lcu_conf", &pos, &prev_pos);
+       e =3D cl_dbg_dump_raw_lcu_conf(cl_hw, cd->data, data_len, &pos);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       pre_fill_hook(&rec, cd, "adapted_lcu_conf", &pos, &prev_pos);
+       e =3D cl_dbg_dump_adapted_lcu_conf(cl_hw, cd->data, data_len, &pos)=
;
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Stringified FW state conents */
+       pre_fill_hook(&rec, cd, "fw_dump", &pos, &prev_pos);
+       cl_dbg_dump_check_params(cl_hw, cd->data, data_len, &pos, fdump);
+       cl_dbg_dump_machw_regs(cl_hw, cd->data, data_len, &pos, fdump);
+       cl_dbg_dump_phyhw_regs(cl_hw, cd->data, data_len, &pos, fdump);
+       cl_dbg_dump_ac_info(cl_hw, cd->data, data_len, &pos, fdump);
+       cl_dbg_dump_single_tx_list_info(cl_hw, cd->data, data_len, &pos, fd=
ump);
+       cl_dbg_dump_agg_tx_list_info(cl_hw, cd->data, data_len, &pos, fdump=
);
+       cl_dbg_dump_tx_trace_info(cl_hw, cd->data, data_len, &pos, fdump);
+       cl_dbg_dump_fw_trace_info(cl_hw, cd->data, data_len, &pos, fdump);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       pre_fill_hook(&rec, cd, "hw_diags", &pos, &prev_pos);
+       e =3D cl_dbg_dump_hw_diags(cl_hw, cd->data, data_len, &pos, gdata);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* FW/DRV-view of channel and freqs */
+       pre_fill_hook(&rec, cd, "chan_info", &pos, &prev_pos);
+       e =3D cl_dbg_dump_chan_info(cl_hw, cd->data, data_len, &pos, gdata)=
;
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Logic analyzer (0) memory - MAC */
+       pre_fill_hook(&rec, cd, "la_mac_trace", &pos, &prev_pos);
+       e =3D cl_dbg_dump_la_mem(cl_hw, cd->data, data_len, &pos, LA_MAC_ID=
X, dbg_info);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Logic analyzer (0) conf - MAC */
+       pre_fill_hook(&rec, cd, "la_mac_conf", &pos, &prev_pos);
+       e =3D cl_dbg_dump_la_conf(cl_hw, cd->data, data_len, &pos, LA_MAC_I=
DX, gdata);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Logic analyzer (1) memory - PHY */
+       pre_fill_hook(&rec, cd, "la_phy_trace", &pos, &prev_pos);
+       e =3D cl_dbg_dump_la_mem(cl_hw, cd->data, data_len, &pos, LA_PHY_ID=
X, dbg_info);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Logic analyzer (1) conf - PHY */
+       pre_fill_hook(&rec, cd, "la_phy_conf", &pos, &prev_pos);
+       e =3D cl_dbg_dump_la_conf(cl_hw, cd->data, data_len, &pos, LA_PHY_I=
DX, gdata);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* Diagnotics port - MAC */
+       pre_fill_hook(&rec, cd, "mac_diags", &pos, &prev_pos);
+       e =3D cl_dbg_dump_mac_diags(cl_hw, cd->data, data_len, &pos, gdata)=
;
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       /* SW diagnostics port */
+       pre_fill_hook(&rec, cd, "sw_diags", &pos, &prev_pos);
+       e =3D cl_dbg_dump_sw_diags(cl_hw, cd->data, data_len, &pos, gdata);
+       post_fill_hook(&rec, &e, &pos, &prev_pos);
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+
+       /* devcoredump will take care of memory free process */
+       return cd;
+out:
+       return NULL;
+}
+
+#define INVALID_AMPDU_CNT U8_MAX
+
+void cl_fw_dbg_trigger_based_init(struct cl_hw *cl_hw)
+{
+       memset(&cl_hw->tb_stats, 0, sizeof(cl_hw->tb_stats));
+       cl_hw->tb_stats.ampdu_cnt =3D INVALID_AMPDU_CNT;
+}
+
+void cl_fw_dbg_trigger_based_update(struct cl_hw *cl_hw, struct hw_rxhdr *=
rxhdr,
+                                   struct ieee80211_hdr *hdr)
+{
+       struct cl_rx_trigger_based_stats *tb_stats =3D &cl_hw->tb_stats;
+
+       if (!tb_stats->enable)
+               return;
+
+       if (tb_stats->ampdu_cnt =3D=3D INVALID_AMPDU_CNT) {
+               tb_stats->ampdu_cnt =3D rxhdr->ampdu_cnt;
+               if (rxhdr->format_mod =3D=3D FORMATMOD_HE_TRIG) {
+                       if (ieee80211_is_qos_nullfunc(hdr->frame_control))
+                               tb_stats->qos_null_per_agg +=3D rxhdr->frm_=
successful_rx;
+                       else
+                               tb_stats->data_per_agg +=3D rxhdr->frm_succ=
essful_rx;
+
+                       tb_stats->total +=3D rxhdr->frm_successful_rx;
+               }
+       } else if (tb_stats->ampdu_cnt =3D=3D rxhdr->ampdu_cnt) {
+               if (rxhdr->format_mod =3D=3D FORMATMOD_HE_TRIG) {
+                       if (ieee80211_is_qos_nullfunc(hdr->frame_control))
+                               tb_stats->qos_null_per_agg +=3D rxhdr->frm_=
successful_rx;
+                       else
+                               tb_stats->data_per_agg +=3D rxhdr->frm_succ=
essful_rx;
+
+                       tb_stats->total +=3D rxhdr->frm_successful_rx;
+               }
+       } else {
+               tb_stats->ampdu_cnt =3D rxhdr->ampdu_cnt;
+               if (unlikely(tb_stats->data_per_agg >=3D DBG_STATS_MAX_AGG_=
SIZE))
+                       cl_dbg_err(cl_hw, "rx trigger_based agg size %u > 2=
56\n",
+                                  tb_stats->data_per_agg);
+               else
+                       tb_stats->data[tb_stats->data_per_agg]++;
+
+               if (unlikely(tb_stats->qos_null_per_agg > TID_MAX))
+                       tb_stats->qos_null[TID_MAX + 1]++;
+               else
+                       tb_stats->qos_null[tb_stats->qos_null_per_agg]++;
+
+               tb_stats->data_per_agg =3D 0;
+               tb_stats->qos_null_per_agg =3D 0;
+
+               if (rxhdr->format_mod =3D=3D FORMATMOD_HE_TRIG) {
+                       if (ieee80211_is_qos_nullfunc(hdr->frame_control))
+                               tb_stats->qos_null_per_agg +=3D rxhdr->frm_=
successful_rx;
+                       else
+                               tb_stats->data_per_agg +=3D rxhdr->frm_succ=
essful_rx;
+
+                       tb_stats->total +=3D rxhdr->frm_successful_rx;
+               }
+       }
+}
+
+void cl_fw_dbg_trigger_based_reset(struct cl_hw *cl_hw)
+{
+       u32 idx;
+       struct cl_rx_trigger_based_stats *tb_stats =3D &cl_hw->tb_stats;
+
+       tb_stats->total =3D 0;
+
+       for (idx =3D 0; idx < ARRAY_SIZE(tb_stats->data); idx++)
+               tb_stats->data[idx] =3D 0;
+
+       for (idx =3D 0; idx < ARRAY_SIZE(tb_stats->qos_null); idx++)
+               tb_stats->qos_null[idx] =3D 0;
+}
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

