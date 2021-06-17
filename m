Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EAC3AB912
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhFQQMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:21 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:32846
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233907AbhFQQLG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmsTr0d2dx3LAkGFEBCzQ2NFxG5/AHhBzr+kUaE7pS8GgSD4CjIY8WN7uUCY4r2Ep53B32D+cUHaGN6idI8BhrP51nhxjoi3Za2TBi4na3sjRB+m0TVci0LyEM3POQ50cdORc0uSgiRhveB89MrtLxWAR20P0xVrVNeNqsHdTnE5CmYL37mmMr+ebUa8m/lrUAdwj3DBi7MAd3WYS/6qSuJ2Sddgc31175HXnvGtwmG6Wvc7qDGPxouA1YG9GI40H2Yj67gRuTx6HZGHsG+eESVmR4PlQcfAroe6LVirZGOxx7jNdrHLTeeILxqspwXu7KLFg8GfoTZd2RPdSllrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jygGGnUUGwOABUD182EYStfbXZp5b+zGJ296cge4o0o=;
 b=gpU5VPFuCBYSNkfDR3L5+eiMyu9aRX5CNIYy66rpo7yiSaIitOal5oR3gMEM2Iz+t6A4aUsNYiVo3+7enemn5KFeIMPhkMaGQouZAgd9BnCTkfPzShTbRHF2zfyeWpPh+HwSMIwDpCarA6cEErH/+NHUrykpxRjUEhXcISIBF1alzLlTkMWob5fTnrvKETti6Hu+HHNA6+EqxgJd/CKhwQgM1W61/bb4kgw7kEgOvgWQOX7q/HHB76RggRs8XGycdhS3J8W4Mp0YWBib4D9ZuphB/P/U/ur4+A+wiDN0shKmxofW55fzUXlmj/Yw918e9VwY0I2k7Z94L9W93s90NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jygGGnUUGwOABUD182EYStfbXZp5b+zGJ296cge4o0o=;
 b=pZ7akrZTGPcRTQ8Boxd7WiHin6dDkIkBvObR1eMr9wVIDkSNzE8cZlXBvE9f1/2YGtt1E4lK1335OgMoWgdIa/1viUWY75BVtzd/TGNS8O1asx9/lqLvhtLb9NDcCBzuUPSkbUvSd5JBsi68SzugomV8YCy3rEJ0iS6P0KXoAqI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:10 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:10 +0000
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
Subject: [RFC v1 185/256] cl8k: add stats.h
Date:   Thu, 17 Jun 2021 16:01:12 +0000
Message-Id: <20210617160223.160998-186-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3820dcd5-e286-42a6-662b-08d931a9cbe3
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB026027FAD17F89BB05514FCAF60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWQtPBp3G8v1bXH7nvcNew4azXGLQa6v9/PUYn5yWsDbjac8HXq2yNUpYwHpkoMANiicnwl1bpef09P8pS8p+IzxqiGTNVhzPYbDxLkv0yHodqZz9HeMh2y+qdrFo5YIDXVbxpBwaVJKgUhdZM3vEPJ2yZ2eBR5//5Q1+sVUs4JsJ28bUHHf7cPQua7ee/k5RvYa3JBSfDL3FuTdfDsb3e0Myeerm8ikjMe64sPLocl/cg37YYOBFSFekMIvXvDmQZIJtOYO5hJLNR2zAsm9kkhrblQvl7swhypYV2G2XUXejrr7rN+FL1YRGDWBN7PChEF11x05em05SIwOPcGcZfZ/PMOoKv6Uqxnq1c1fnhb8tiQv6aoAWJFxP7QAMyqgxgD4J115jRmAXw6prUB93OV7qfFYihXTLXUkpd+NtQmKyxz9he7CbwssG1KqwMxm6DY9AHT5Yn6pBWLCGm/RbWPT6M2IolRXtoqmRUF8RpSVnHBFO4FfGGKR38LpFZy60btDrPiS1DTcTySHnp38Wgb3+uLKX8BL1pZD1+pvtuZRjH2T7MhZhhRrF8RKdkTYCUxeBAx4j8M5Rsgh3Uin1t7yVxJpDs7t1uHE/hw9mSyVC6UKuma7iHLw86O4cKCURLNIuNbXsmBYP4CPFfVbG1647eAGt2oRSJCTgsnGgWbOQU8CiSsSo/i0hCvsbLg0/pZ/5kriA+WBzcqv5eiCcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dei20I/EAo65zY8FAcFinyfyMQUqssXZpEPeB5sRcVNVoLoaWiftG4pJsxLL?=
 =?us-ascii?Q?JsPEtw8GDLXvAHtUnYp/zcXpaDEjyFq0b8ZX3JKQqqQFHbnHE+hjlHlvEi+Q?=
 =?us-ascii?Q?Z/QIoLRz7auW49vTa6aBiNwwirvBer0HBex9l9qFo/1fBkbUXXzdrreTs8MH?=
 =?us-ascii?Q?nO9BIjLez8/sY5lw2K7MqfoMkAcHLYoBnuIkyIjcaT0ZaDJrDkiPxopzsU0P?=
 =?us-ascii?Q?BDpA9FiF5UZaNLnwG7pf1UMoWcl8YCeM+61QBwhJ8ffB1PHnpZgE0fMzmgtn?=
 =?us-ascii?Q?I5ZApAH2CUyoT+VbgQa7JJcPbzC3EWM5J5n2Tc/ixhHk6M1RqswVTG1zu9Ne?=
 =?us-ascii?Q?QvnATvyvC92SL1ZWUseWo6Dhs7powX5LnEK+WCLpSwqIdGRPxYepacWRf3XQ?=
 =?us-ascii?Q?K0NHbG2UiTup1kR6QwEQxErwKEtZNRckxdUReuCNLu2fVef2rDLW9umY7ASR?=
 =?us-ascii?Q?SJ+/M9SzztRTOKdDQ650GIX9AaKb3Llme6LmERjx+8LiIvCOXujGaVFBLV+8?=
 =?us-ascii?Q?/ZiNIosUrC5KN6KJvc483QWdHp0yXWJnUTuHWUsQxf8SZEfa7oMy/96KSr6Q?=
 =?us-ascii?Q?zjy5VERg666LANQnyzWcR8xsqgTVogjghH3UbJVP4vx21QDESnY8NUB5IHN+?=
 =?us-ascii?Q?aXmDZufsMDkBKf4fzLjPCqw3IOHAWWFcn7hJCeJSLh44gsdVaWWCPXK9/1E7?=
 =?us-ascii?Q?8Me1KHnjec9MUKJlSW5hNqRvvADnIdyfZ2rOR4LpS3BUTQ4RhfvSFzj3+xdb?=
 =?us-ascii?Q?J7kSYioAZpSftPHqRDu05tLMUzc8N9Gd9HpyNJxnmPIWEE7QOH+q9BnuiYwZ?=
 =?us-ascii?Q?EmI94zFEHjIAGBZ2G6r1fVbpbs/Qhv63kmQYzT8L3ccmMrK+SFuslHFv3MJG?=
 =?us-ascii?Q?4FAouC1ipr5UcG5np23JXgjbXTjt4ITIgDwOBw1ZMfAYt/dDQArIaULrn5j8?=
 =?us-ascii?Q?w+l7QEdBZE00UZFgf3nYypWQpKxEtr+whS/hCD4VQzK7RplpNAXAKKF3ELyn?=
 =?us-ascii?Q?qEok737W0z4/a95tsQCx/8vYmSYie2+zLG5BV/7d+ehUG5+Tz2/1nzGjVQ8C?=
 =?us-ascii?Q?LoT0ac1SKr4mqh5p7NhQCpulXStEMY6gNbxDbrYtanGTT/Vhhu9KueJuA71z?=
 =?us-ascii?Q?I66VK4LrXFlrwQJ7NHMVyeOAJG3Uj3VzfijeCXrjbO4azmmZy+t1Y7S1uGJ1?=
 =?us-ascii?Q?a851ArknWZ0DrwFySguUP9lj9ad21GNB0FyVAKO5edof1zCK6aJJhP7yi37O?=
 =?us-ascii?Q?UqrOWsN25+f3KAzEQEOCmUW+8aZN7oDHmMxCOVJ8xM/UYXXfLwrN7qBnK4rX?=
 =?us-ascii?Q?ccKPyWf3fLKeAhzp4mLVcJOP?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3820dcd5-e286-42a6-662b-08d931a9cbe3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:59.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: optsRIMkKd1C7AZ1C3a3r5zee0PXWYfUKujHuQxdn1nBaXcUDJpgKlDBBMA3FPvFbr0x/qTgl/h4Nd6S56wvrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/stats.h | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.h

diff --git a/drivers/net/wireless/celeno/cl8k/stats.h b/drivers/net/wireles=
s/celeno/cl8k/stats.h
new file mode 100644
index 000000000000..91a7bed25a2a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/stats.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_STATS_H
+#define CL_STATS_H
+
+#include "hw.h"
+#include "rx/rx.h"
+#include "utils/timer.h"
+#include "tx/agg_tx_report.h"
+#include "vendor_cmd.h"
+
+void cl_stats_init(struct cl_hw *cl_hw);
+void cl_stats_deinit(struct cl_hw *cl_hw);
+void cl_stats_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_stats_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_stats_update_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                           struct cl_agg_tx_report *agg_report);
+void cl_stats_update_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              struct cl_agg_tx_report *agg_report);
+void cl_stats_update_rx_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
8 rssi[MAX_ANTENNAS]);
+void cl_stats_update_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
truct hw_rxhdr *rxhdr);
+void cl_stats_update_rx_rate_production(struct cl_hw *cl_hw, struct hw_rxh=
dr *rxhdr);
+void cl_stats_update_ps(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool i=
s_ps);
+int cl_stats_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cli_pa=
rams *cli_params);
+
+#endif /* CL_STATS_H */
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

