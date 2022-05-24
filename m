Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6187B532979
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiEXLlr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiEXLlk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D56BFB
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdGhyxI7oDxVtIRTddic9qgcFcmAcy3DuCsiLKBdw/X1mUe9Ruz1Z1JFnL1wrzwoQYwfsGtqFr98b5QQsTIXqX42QoxrxC1aCk7bzPmEMOjCYoxLQ2y/h4XUbrnYV2mwNBbdovjIuix72RLl/HNDFGtSnq9+ZsJ8TkX1v83BFAQEeh05BkXmOOVrZgf1K/9PUjSYBf9JmTDFMCSDFv3cpe6kMXidxg6lF2q5DBjRV+An6Z2d9n3/FJ6yCdjnRSXo3/QgbLytWPeKsRSqceyMpMtrwq4DonbCyvDCihUgK/V7q0iYOXba8LzoI8WX2nhVb4at636MOZLk42FqdNg/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgD513CnW7Cnv2NkpNG6OpPUMuAKEBnc0sjA00HpdEw=;
 b=CdrUmUIpPr/Voo8yrhJ/LNEL0coPngxr1E24sRCa4DGkuKsMIL2w+YNcApatteJzqvL+8Y5RDZrJL99E+jQXK52ArfCe1raIToU/0XKwHaoueY9m2h+yy1F3PZGREzNh1jvjdUNWcELQ6ZLZmLSK8Eqp9cHy7g51dEh18Nyvglw3aup/cGleLr7UYjZ+gQnfnOefifiPAEhPkDhcQmcyxn1sJTFOlNyZj5NRCmWZTSkqW5qtEJ8tDIuJbs4N43JZyL3qPqz9Tf0Iw48ITahJ97oWhr4hnE1js6uaG0tjQrhjDi61RVOi3rvcrvkWPPSQzWD1VWoms0WT7xFqLfmTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgD513CnW7Cnv2NkpNG6OpPUMuAKEBnc0sjA00HpdEw=;
 b=fy3bAzlYM6QAUq3dgkTcTD3nc7+rgoz2a3OTht3vqq0z7mhN5h24vtPizGnvwIUYoGeVsCWKPKxP1BuznlghGXWU8lv8SBzqcA074lKIl5jTpclzwTpVLtUvSrVOqpyIYJHrleZ6ldLjW9fWidLUc4SvJFsF9doWj0XKYJAdRV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:31 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:31 +0000
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
Subject: [RFC v2 84/96] cl8k: add tx.c
Date:   Tue, 24 May 2022 14:34:50 +0300
Message-Id: <20220524113502.1094459-85-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2204166-cb8c-47a7-6c7a-08da3d79fcc9
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669375B524EFC9F035BAACDF6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KikxTzTUIEOlSG4+HUdeNzSdrO9PmHT/nh5cDkEDhPFdnCGqdl8s+o6ONvKkvTpayqN7A3+Qm9TlewPemsFUPzYyiuXqncFmp7uP8d2l0R1CmB5f51/YlJwW8wNqcNaEwgYfYIF2pg4DzXkGgliDOWsiUsUHeP4o5AQQ0W9tZOZ582qtdTj8C0eEqAtlI7bN7SUboj8t1YMLQYdNJmS7Z+pQPba3sIgOxFB4y4rXKLGBCfpdUnithNT/Ez9bYbiEZxMRkJQp/Z67f568Vev6qljbvPslA/Or3KKXqWcB+mV2I4m4q+v/sO+Fe63J/ZL8zYxO+EjjKi9YlshEpQKmh40wzynCVL3MKUCyeYJD+xa6ZTLE4WKvX/zgqEZpHfELEQJatJafxcxF8zBuF42cTmc5uXnjFbXD/GaUpPXYd8NUKFGWfJmiJQUdRswVOJCFeI4wXMwm+i/BXN8MwNh2/2p0SC2RBxC/1RdouFwUmBWRzULoMgZmN3fPKrpXgwoG7yvpQpViPc8pZHTr/fJcFw8HsBl+Cl/7VFXXHoxlhSx/fRCz71j5bLrX9XlslRb7aw/pJpWJs5DJb1MCi0wVMsWwM4zoo3r2UWFAhPEPVNUO9L0aJkNr/2XN+GJl0HZXmPcVHP8STdGgRcRR8iN10lhlZD2lu3EgYwDBL+yXUhS1nZu7kza+VtPdUdpbEhXjSJqAoeBAkp7MxsYgDA1wHwHVl8DQAgzC9UN+AJL5Po2BpoyxPawnLoKDrFIHQbT9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(30864003)(32563001)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTsN+dIaVG+GQy+SwvtwT7U4cuhMMv8t+i11uY0tZl2eZMx/p3dvo07ZC2vO?=
 =?us-ascii?Q?gnXR9ixf4uwT/pEJqmY7qKIyoXoG7G8L7gDdilhxniDhqTe7lv7uFQ0CapUa?=
 =?us-ascii?Q?5a8k4hheQGLs/rtF2ulG6oSG6Z1B/4Ew3eOJb/vExZIxEFHhNOQ0eCEff6HW?=
 =?us-ascii?Q?2GH3QI735UV8dpY1NRQgbm+RrPqCqvxRCjzQwR1WMSF758zGcolwY8xiHUhh?=
 =?us-ascii?Q?n2u8dfus9Kgfi6XYWw5QlgcQaWXcZy4qpcfu30TK3jt0RrFGSYVe5RO4ndCC?=
 =?us-ascii?Q?d6xPxU4uw/tct8WdmS3KaphGqzggAY7deZ1d3Z45fw5CVrHpJYbgDrv/aO/R?=
 =?us-ascii?Q?gSUljmfbZfkoVTHvdFSXxXJMQG2qDW3HbpdmDFnsOMhsn1//bGTQ36KwnmMc?=
 =?us-ascii?Q?PpfBO0TnoA/1IUweznzPgC6+uPslE109HKIouRyde5RToFFGJEfwph8rMrUv?=
 =?us-ascii?Q?N+fRdIGZx+aAwwWOdf18W+bHvb/1LHWpD0ZyJvB48LaY14UPydYkYpaV63c0?=
 =?us-ascii?Q?+OmQNl/ORAvcjsL7+8Mzo6rcrZlk5Tu3TQXXdzsmvuNABmtIvLz8ZEE0kOQn?=
 =?us-ascii?Q?wJwp4XFGGyPHO66Lle0cIxI8mt8bZR9S+A4rSjWG87VAwsOEt8WdfVKtZdk3?=
 =?us-ascii?Q?5fl4qlJQj5Kw+5AWqpZgbJayPWbwgwEr6YwQdgMAqEmCYGVasB9pgG0SZZc3?=
 =?us-ascii?Q?ErFn4+9r7s3WIs8ICiWVRsS+droopwihJkh+H4fhq+pTVOlSO93kk+rRbbBy?=
 =?us-ascii?Q?+/YzlnnA5rBzuoWRQslVW4zC/17IR37xHmclqJQoLwZN8buLp5LjgrIsTlDU?=
 =?us-ascii?Q?dNS7EnlAkB1CSMIcN1DXT0OsxWbyjHxTZzIFrhZR7wJMnh9tJrYGC9J7Ufhp?=
 =?us-ascii?Q?m+Qs5q89Q9SWe4suPwOPtxLUMIXzpMJtBfeiJFWzpCGk/5y2oosM4oh21VI1?=
 =?us-ascii?Q?SMDf4t9Cj+7MyEUSfhQ3lv05zrUP1d9PNjZQEmJgnA8Wy8g7Z0BgEmmqFKzi?=
 =?us-ascii?Q?LqfZOPZUZp2DquDQrU9nXZYND7c3hJsCv6YPcCK8ldCCw0QvzpmUAmporvBX?=
 =?us-ascii?Q?wJg9ZNKHIdo7UXhw4KhOI+Sf9Qu0C8GLP6xcqudkbleL0dREzAtzZokQhvUD?=
 =?us-ascii?Q?jBRrJjAG1Z88FzCWbFRF4rT781n0VHzLrBd9bjIEiHnsEMDna37ZRQBGSaME?=
 =?us-ascii?Q?T5cN+JBuDHfgvbiVd+CWQNoVtGjwx8pF6oQ1xWw+67AX1LPZKhUE7ipVeeTB?=
 =?us-ascii?Q?wwYO2oEysMucZj7EHBGaPsDKwuBDUPz/E7yKEkGkurIpMAZ5lQFKff9yFlIh?=
 =?us-ascii?Q?uZAC2wAhOsWhsvm7444Xjv0esX7mTwt5aBmoTAOykM9C5uFzAfStVlXX4KeD?=
 =?us-ascii?Q?r3Z321UKORDyrZwwaRExZJVAo/REiEFKTqXqQC1cK9+7OjnBwcghmLgyQuPH?=
 =?us-ascii?Q?Rr8wFCENxZCPfB8wRLQekEHglBJRsBYBrdkFg9I/NgIvoEl9vn1zSzprpUbz?=
 =?us-ascii?Q?EpE/X+dWZi0xEz2z6aP/d6xB8rF3GkxgbpgzEorQ8hVUVSd1sp4ngeQqyVJH?=
 =?us-ascii?Q?Czzzc22R9KgcchTyP6mAqyI0bxr0vV1a1U3rxPWgH8hl+KQdS0HUatzV1lwZ?=
 =?us-ascii?Q?Rnt38uA36pKiFj/IolzOxIRZSg/SxX/lEEbpmyoZnCO+mNMR68J6n9OpJzZc?=
 =?us-ascii?Q?x0s4FqAjmPSc+3nGcLlo2fNkK8ofZZL4q2yrjoR1HP41Ccja5xFE4itmlDCc?=
 =?us-ascii?Q?LOSyJAngUCxKf68wBUxLZOcRAw1h9fE=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2204166-cb8c-47a7-6c7a-08da3d79fcc9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:57.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/hHB7pdupO8ZzwP0fICReXcWAzMBn0IislwnIOWXwsV66VF/X9+0V+IgyRe9eN0KmqnRXPwFxLpKR7T8ZYUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
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
 drivers/net/wireless/celeno/cl8k/tx.c | 3397 +++++++++++++++++++++++++
 1 file changed, 3397 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx.c b/drivers/net/wireless/celeno/cl8k/tx.c
new file mode 100644
index 000000000000..52a8d558f3f2
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx.c
@@ -0,0 +1,3397 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "mac_addr.h"
+#include "sta.h"
+#include "hw.h"
+#include "utils.h"
+#include "fw.h"
+#include "key.h"
+#include "dfs.h"
+#include "radio.h"
+#include "enhanced_tim.h"
+#include "rates.h"
+#include "stats.h"
+#include "debug.h"
+#include "tx.h"
+
+/* Expected Acknowledgment */
+#define EXPECTED_NO_ACK 0
+#define EXPECTED_ACK    1
+
+void cl_tx_update_hist_tstamp(struct cl_tx_queue *tx_queue, struct sk_buff *skb,
+			      u32 tstamp_hist[], bool update_skb_ktime)
+{
+	s64 diff_ms;
+	ktime_t ktime = ktime_get();
+
+	diff_ms = ktime_ms_delta(ktime, skb->tstamp);
+
+	if (diff_ms >= DELAY_HIST_SIZE)
+		diff_ms = DELAY_HIST_SIZE - 1;
+
+	tstamp_hist[diff_ms]++;
+
+	if (update_skb_ktime)
+		skb->tstamp = ktime;
+}
+
+static void cl_tx_cpu_single(struct cl_hw *cl_hw)
+{
+	u32 processor_id = smp_processor_id();
+
+	if (processor_id < CPU_MAX_NUM)
+		cl_hw->cpu_cntr.tx_single[processor_id]++;
+}
+
+static void cl_tx_cpu_agg(struct cl_hw *cl_hw)
+{
+	u32 processor_id = smp_processor_id();
+
+	if (processor_id < CPU_MAX_NUM)
+		cl_hw->cpu_cntr.tx_agg[processor_id]++;
+}
+
+static char cl_tx_ctrl_single_frame_type(__le16 fc)
+{
+	if (ieee80211_is_data_qos(fc))
+		return CL_TX_SINGLE_FRAME_TYPE_QOS_DATA;
+	else if (ieee80211_is_qos_nullfunc(fc))
+		return CL_TX_SINGLE_FRAME_TYPE_QOS_NULL;
+	else if (ieee80211_is_mgmt(fc))
+		return CL_TX_SINGLE_FRAME_TYPE_MANAGEMENT;
+	else
+		return CL_TX_SINGLE_FRAME_TYPE_OTHER;
+}
+
+static void cl_tx_single_prep(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+			      u16 frame_len, u8 hdr_pads, bool is_vns)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+	struct ieee80211_key_conf *key_conf = tx_info->control.hw_key;
+	struct txdesc *txdesc = &sw_txhdr->txdesc;
+	struct tx_host_info *host_info = &txdesc->host_info;
+	struct cl_vif *cl_vif = NULL;
+
+	/* Reset txdesc */
+	memset(txdesc, 0, sizeof(struct txdesc));
+
+	/* Vif_index must be filled in even without header conversion */
+	cl_vif = (struct cl_vif *)tx_info->control.vif->drv_priv;
+	host_info->vif_index = cl_vif->vif_index;
+
+	if (hdr_pads)
+		host_info->host_padding |= BIT(0);
+
+	host_info->is_bcn = sw_txhdr->is_bcn;
+	host_info->expected_ack = (tx_info->flags & IEEE80211_TX_CTL_NO_ACK) ?
+		EXPECTED_NO_ACK : EXPECTED_ACK;
+
+	/* Beware when prot and sta is unknown */
+	if (key_conf) {
+		frame_len += key_conf->icv_len;
+		host_info->is_protected = true;
+		host_info->hw_key_idx = key_conf->hw_key_idx;
+	}
+
+	host_info->packet_cnt = 1;
+
+	txdesc->umacdesc.packet_len[0] = cpu_to_le16(frame_len);
+	txdesc->e2w_txhdr_param.frame_ctrl = sw_txhdr->fc;
+	txdesc->e2w_result.bcmc = (sw_txhdr->sta_idx == STA_IDX_INVALID);
+	txdesc->e2w_result.tid = sw_txhdr->tid;
+	txdesc->e2w_result.is_vns = is_vns;
+	txdesc->e2w_result.is_txinject = false;
+	txdesc->e2w_result.single_type = cl_tx_ctrl_single_frame_type(sw_txhdr->fc);
+	txdesc->e2w_result.single_valid_sta__agg_e2w_tx_done = !!sw_txhdr->cl_sta;
+	txdesc->e2w_natt_param.sta_index = sw_txhdr->sta_idx;
+
+	/* Set rate control */
+	cl_rate_ctrl_update_desc_single(cl_hw, host_info, sw_txhdr);
+}
+
+static void cl_tx_sub_frame_set(struct cl_sta *cl_sta, u8 tid)
+{
+	struct cl_tx_queue *tx_queue = cl_sta->agg_tx_queues[tid];
+
+	if (tx_queue)
+		tx_queue->total_packets++;
+}
+
+static void cl_tx_send(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+		       struct cl_amsdu_ctrl *amsdu_anchor)
+{
+	struct cl_tx_queue *tx_queue = sw_txhdr->tx_queue;
+	struct cl_sta *cl_sta = sw_txhdr->cl_sta;
+
+	tx_queue->total_packets++;
+
+	if (cl_txq_is_fw_full(tx_queue) || (cl_sta && cl_sta->pause_tx)) {
+		/* If firmware is full push the packet to the queue */
+		cl_txq_push(cl_hw, sw_txhdr);
+	} else if (amsdu_anchor && amsdu_anchor->is_sw_amsdu) {
+		cl_txq_push(cl_hw, sw_txhdr);
+		tasklet_schedule(&cl_hw->tx_task);
+	} else if (!list_empty(&tx_queue->hdrs) || cl_hw->tx_db.force_amsdu) {
+		/*
+		 * If queue in driver is not empty push the packet to the queue,
+		 * and call cl_txq_sched() to transfer packets from the queue to firmware
+		 */
+		cl_txq_push(cl_hw, sw_txhdr);
+		cl_txq_sched(cl_hw, tx_queue);
+	} else {
+		/* Push the packet directly to firmware */
+		cl_tx_push(cl_hw, sw_txhdr, tx_queue);
+	}
+}
+
+void cl_tx_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, struct cl_tx_queue *tx_queue)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+	struct ieee80211_key_conf *keyconf = tx_info->control.hw_key;
+	struct cl_sta *cl_sta = sw_txhdr->cl_sta;
+	struct cl_vif *cl_vif = sw_txhdr->cl_vif;
+	u8 tid = sw_txhdr->tid;
+	struct txdesc *txdesc = &sw_txhdr->txdesc;
+	struct tx_host_info *host_info = &txdesc->host_info;
+	struct cl_e2w_txhdr_param *e2w_txhdr_param = &txdesc->e2w_txhdr_param;
+	struct ieee80211_hdr *hdr80211 = sw_txhdr->hdr80211;
+	u8 queue_type = tx_queue->type;
+	bool is_mgmt = ieee80211_is_mgmt(sw_txhdr->fc);
+
+	if (cl_key_is_cipher_ccmp_gcmp(keyconf)) {
+		/*
+		 * In case of CCMP or GCMP encryption we need to inc pn.
+		 * In case of amsdu/header_conversion we need to pass it to firmware as well
+		 */
+		u64 pn = atomic64_inc_return(&keyconf->tx_pn);
+
+		if (txdesc->e2w_natt_param.hdr_conv_enable) {
+			memcpy(&e2w_txhdr_param->encrypt_pn, &pn, CL_CCMP_GCMP_PN_SIZE);
+		} else {
+			u8 hdrlen = ieee80211_hdrlen(sw_txhdr->fc);
+
+			cl_key_ccmp_gcmp_pn_to_hdr((u8 *)hdr80211 + hdrlen, pn, keyconf->keyidx);
+		}
+	}
+
+	if (queue_type == QUEUE_TYPE_AGG) {
+		struct cl_baw *baw = &cl_sta->baws[tid];
+		bool is_amsdu = cl_tx_ctrl_is_amsdu(tx_info);
+
+		if (is_amsdu) {
+			struct cl_amsdu_ctrl *amsdu_anchor = &cl_sta->amsdu_anchor[tid];
+
+			if (sw_txhdr->is_sw_amsdu) {
+				u8 pkt_cnt = sw_txhdr->sw_amsdu_packet_cnt;
+
+				if (pkt_cnt == 1)
+					cl_tx_amsdu_unset(sw_txhdr); /* Clear AMSDU bit. */
+
+				if (hdr80211)
+					hdr80211->seq_ctrl = cpu_to_le16(baw->tid_seq);
+
+				tx_queue->stats_sw_amsdu_cnt[pkt_cnt - 1]++;
+			} else {
+				u8 pkt_cnt = host_info->packet_cnt;
+
+				if (pkt_cnt == 1)
+					cl_tx_amsdu_unset(sw_txhdr); /* Clear AMSDU bit. */
+
+				tx_queue->stats_hw_amsdu_cnt[pkt_cnt - 1]++;
+			}
+
+			/* Reset anchor if needed */
+			if (amsdu_anchor->sw_txhdr == sw_txhdr)
+				cl_tx_amsdu_anchor_init(amsdu_anchor);
+		}
+
+		if (hdr80211)
+			hdr80211->seq_ctrl = cpu_to_le16(baw->tid_seq);
+
+		/* Update sequence number and increase it */
+		e2w_txhdr_param->seq_ctrl = cpu_to_le16(baw->tid_seq);
+		baw->tid_seq = INC_SN(baw->tid_seq);
+
+	} else {
+		/*
+		 * Update sequence number and increase it
+		 * Management sequence number is set by firmware.
+		 */
+		if (!is_mgmt) {
+			hdr80211->seq_ctrl |= cpu_to_le16(cl_vif->sequence_number);
+			cl_vif->sequence_number = INC_SN(cl_vif->sequence_number);
+		} else {
+			if (ieee80211_vif_is_mesh(cl_vif->vif)) {
+				struct ieee80211_mgmt *mgmt = (void *)sw_txhdr->skb->data;
+				u16 capab;
+
+				if (mgmt->u.action.u.addba_req.action_code ==
+				    WLAN_ACTION_ADDBA_RESP) {
+					capab = le16_to_cpu(mgmt->u.action.u.addba_resp.capab);
+					capab &= ~IEEE80211_ADDBA_PARAM_AMSDU_MASK;
+					mgmt->u.action.u.addba_resp.capab = cpu_to_le16(capab);
+				}
+			}
+		}
+	}
+
+	cl_drv_ops_pkt_fw_send(cl_hw, sw_txhdr, tx_queue);
+}
+
+void cl_tx_single_free_skb(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+	if (IEEE80211_SKB_CB(skb)->ack_frame_id)
+		ieee80211_tx_status(cl_hw->hw, skb);
+	else
+		dev_kfree_skb_any(skb);
+}
+
+void cl_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		  struct sk_buff *skb, bool is_vns, bool lock)
+{
+	struct cl_tx_queue *tx_queue;
+	struct cl_sw_txhdr *sw_txhdr;
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct cl_vif *cl_vif = TX_INFO_TO_CL_VIF(cl_hw, tx_info);
+	struct ieee80211_hdr *hdr80211 = (struct ieee80211_hdr *)skb->data;
+	u8 hdr_pads = CL_SKB_DATA_ALIGN_PADS(hdr80211);
+	__le16 fc = hdr80211->frame_control;
+	u16 frame_len = (u16)skb->len;
+	u8 tid = ieee80211_is_data_qos(fc) ? ieee80211_get_tid(hdr80211) : 0;
+	u8 ac = tid_to_ac[tid];
+	bool is_beacon = ieee80211_is_beacon(fc);
+
+	cl_tx_cpu_single(cl_hw);
+
+	if (unlikely(!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+		     test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))) {
+		cl_tx_single_free_skb(cl_hw, skb);
+		cl_hw->tx_packet_cntr.drop.dev_flags++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	if (unlikely(!cl_vif->tx_en || cl_hw->tx_disable_flags)) {
+		cl_tx_single_free_skb(cl_hw, skb);
+		cl_hw->tx_packet_cntr.drop.tx_disable++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	/* Check if packet length exceeds max size */
+	if (unlikely(frame_len > CL_TX_MAX_FRAME_LEN_SINGLE)) {
+		cl_tx_single_free_skb(cl_hw, skb);
+		cl_dbg_err(cl_hw, "frame_len (%u) exceeds max size\n", frame_len);
+		cl_hw->tx_packet_cntr.drop.length_limit++;
+		cl_vif->trfc_cntrs[ac].tx_errors++;
+		return;
+	}
+
+	if (cl_sta && cl_sta->key_disable) {
+		cl_tx_single_free_skb(cl_hw, skb);
+		cl_hw->tx_packet_cntr.drop.key_disable++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	/* Allocate sw_txhdr */
+	sw_txhdr = cl_sw_txhdr_alloc(cl_hw);
+
+	if (unlikely(!sw_txhdr)) {
+		cl_tx_single_free_skb(cl_hw, skb);
+		cl_dbg_verbose(cl_hw, "sw_txhdr alloc failed\n");
+		cl_hw->tx_packet_cntr.drop.txhdr_alloc_fail++;
+		cl_vif->trfc_cntrs[ac].tx_errors++;
+		return;
+	}
+
+	/* Prepare sw_txhdr */
+	sw_txhdr->hdr80211 = hdr80211;
+	sw_txhdr->hw_queue = tx_info->hw_queue;
+	sw_txhdr->is_bcn = is_beacon;
+	sw_txhdr->skb = skb;
+	sw_txhdr->map_len = frame_len + hdr_pads;
+	sw_txhdr->fc = fc;
+	sw_txhdr->cl_vif = cl_vif;
+	sw_txhdr->tid = tid;
+	sw_txhdr->ac = ac;
+
+	if (cl_sta) {
+		sw_txhdr->cl_sta = cl_sta;
+		sw_txhdr->sta_idx = cl_sta->sta_idx;
+	} else {
+		sw_txhdr->cl_sta = NULL;
+		sw_txhdr->sta_idx = STA_IDX_INVALID;
+	}
+
+	/* Prepare txdesc */
+	cl_tx_single_prep(cl_hw, sw_txhdr, frame_len, hdr_pads, is_vns);
+
+	/*
+	 * Fetch the driver queue.
+	 * IEEE80211_TX_CTL_AMPDU is not set in tx_info->flags, otherwise cl_tx_agg()
+	 * would have been called and not cl_tx_single().
+	 * Therefore there is no need to check if tx_queue is NULL or if queue type
+	 * is QUEUE_TYPE_AGG.
+	 */
+	tx_queue = cl_txq_get(cl_hw, sw_txhdr);
+	if (!tx_queue) {
+		cl_tx_single_free_skb(cl_hw, skb);
+		cl_dbg_verbose(cl_hw, "tx_queue is NULL\n");
+		cl_vif->trfc_cntrs[ac].tx_errors++;
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+		return;
+	}
+
+	sw_txhdr->tx_queue = tx_queue;
+
+	if (lock) {
+		if (tx_queue->type == QUEUE_TYPE_BCMC) {
+			/*
+			 * All other broadcast/multicast packets are buffered in
+			 * ieee80211_tx_h_multicast_ps_buf() and will follow the beacon.
+			 */
+			spin_lock_bh(&cl_hw->tx_lock_bcmc);
+			cl_tx_send(cl_hw, sw_txhdr, NULL);
+			spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+		} else {
+			spin_lock_bh(&cl_hw->tx_lock_single);
+			cl_tx_send(cl_hw, sw_txhdr, NULL);
+			spin_unlock_bh(&cl_hw->tx_lock_single);
+		}
+	} else {
+		cl_tx_send(cl_hw, sw_txhdr, NULL);
+	}
+}
+
+void cl_tx_fast_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		       struct sk_buff *skb, bool lock)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+
+	/* hw_key must be set before calling cl_tx_8023_to_wlan() */
+	tx_info->control.hw_key = cl_key_get(cl_sta);
+
+	/* Convert 802.3 to 802.11 header */
+	if (cl_tx_8023_to_wlan(cl_hw, skb, cl_sta, tid) == 0) {
+		bool is_vns = cl_vns_is_very_near(cl_hw, cl_sta, skb);
+		u8 ac = tid_to_ac[tid];
+
+		tx_info->hw_queue = ac;
+		tx_info->control.vif = cl_sta->cl_vif->vif;
+
+		cl_hw->tx_packet_cntr.forward.drv_fast_single++;
+
+		cl_tx_single(cl_hw, cl_sta, skb, is_vns, lock);
+	}
+}
+
+void cl_tx_agg_prep(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+		    u16 frame_len, u8 hdr_pads, bool hdr_conv)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+	struct ieee80211_key_conf *key_conf = tx_info->control.hw_key;
+	struct txdesc *txdesc = &sw_txhdr->txdesc;
+	struct lmacapi *umacdesc = &txdesc->umacdesc;
+	struct tx_host_info *host_info = &txdesc->host_info;
+	u16 qos_ctrl = sw_txhdr->tid;
+
+	/* Reset txdesc */
+	memset(txdesc, 0, sizeof(struct txdesc));
+
+	txdesc->e2w_result.tid = sw_txhdr->tid;
+	txdesc->e2w_result.is_txinject = false;
+	txdesc->e2w_natt_param.sta_index = sw_txhdr->sta_idx;
+	txdesc->e2w_natt_param.ampdu = true;
+	txdesc->e2w_natt_param.hdr_conv_enable = hdr_conv;
+
+	if (hdr_conv) {
+		if (cl_tx_ctrl_is_amsdu(tx_info))
+			qos_ctrl |= IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+
+		txdesc->e2w_txhdr_param.frame_ctrl = sw_txhdr->fc;
+		txdesc->e2w_txhdr_param.qos_ctrl = cpu_to_le16(qos_ctrl);
+	}
+
+	if (hdr_pads)
+		host_info->host_padding |= BIT(0);
+
+	/* Vif_index must be filled in even without header conversion */
+	host_info->vif_index = sw_txhdr->cl_sta->cl_vif->vif_index;
+
+	/* Set the expected_ack flag */
+	host_info->expected_ack = (tx_info->flags & IEEE80211_TX_CTL_NO_ACK) ?
+		EXPECTED_NO_ACK : EXPECTED_ACK;
+
+	if (key_conf) {
+		host_info->is_protected = true;
+		host_info->hw_key_idx = key_conf->hw_key_idx;
+
+		if (!hdr_conv)
+			frame_len += key_conf->icv_len;
+	}
+
+	host_info->packet_cnt = 1;
+	umacdesc->packet_len[0] = cpu_to_le16(frame_len);
+
+	/* Set rate control */
+	cl_rate_ctrl_update_desc_agg(cl_hw, host_info);
+}
+
+static __le16 cl_tx_agg_frame_control(struct cl_vif *cl_vif,
+				      struct ieee80211_key_conf *key_conf,
+				      u8 *hdrlen)
+{
+	struct ieee80211_vif *vif = cl_vif->vif;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	enum nl80211_iftype type = vif->type;
+	__le16 fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA);
+
+	if (type == NL80211_IFTYPE_AP) {
+		fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS);
+		*hdrlen = 26;
+	} else if (type == NL80211_IFTYPE_STATION) {
+		fc |= cpu_to_le16(IEEE80211_FCTL_TODS);
+
+		if (sdata->u.mgd.use_4addr) {
+			fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS);
+			*hdrlen = 32;
+		} else {
+			*hdrlen = 26;
+		}
+	}
+
+	if (key_conf)
+		fc |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+
+	return fc;
+}
+
+static void _cl_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		       struct sk_buff *skb, bool hdr_conv)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key_conf = tx_info->control.hw_key;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	struct cl_tx_queue *tx_queue = NULL;
+	struct cl_vif *cl_vif = cl_sta->cl_vif;
+	u16 frame_len = (u16)skb->len;
+	u16 total_frame_len = 0;
+	u8 hdr_pads = CL_SKB_DATA_ALIGN_PADS(skb->data);
+	u8 is_amsdu = cl_tx_ctrl_is_amsdu(tx_info);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	u8 ac = tid_to_ac[tid];
+	u8 hdrlen = 0;
+
+	cl_tx_cpu_agg(cl_hw);
+
+	if (unlikely(!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+		     test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))) {
+		kfree_skb(skb);
+		cl_hw->tx_packet_cntr.drop.dev_flags++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	if (unlikely(!cl_vif->tx_en || cl_hw->tx_disable_flags)) {
+		kfree_skb(skb);
+		cl_hw->tx_packet_cntr.drop.tx_disable++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	/* Check if packet length exceeds max size */
+	if (unlikely(frame_len > CL_TX_MAX_FRAME_LEN_AGG)) {
+		kfree_skb(skb);
+		cl_dbg_err(cl_hw, "frame_len exceeds max size %d\n", frame_len);
+		cl_hw->tx_packet_cntr.drop.length_limit++;
+		cl_vif->trfc_cntrs[ac].tx_errors++;
+		return;
+	}
+
+	if (cl_sta->key_disable) {
+		kfree_skb(skb);
+		cl_hw->tx_packet_cntr.drop.key_disable++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	/* Check if amsdu is enable for current skb */
+	if (is_amsdu) {
+		enum cl_amsdu_result amsdu_res = cl_tx_amsdu_set(cl_hw, cl_sta, skb, tid);
+
+		switch (amsdu_res) {
+		case CL_AMSDU_SKIP:
+			is_amsdu = false;
+			tx_info->control.flags &= ~IEEE80211_TX_CTRL_AMSDU;
+		case CL_AMSDU_ANCHOR_SET:
+			/*
+			 * If new anchor was set, or AMSDU is
+			 * skipped continue building sw_txhdr
+			 */
+			break;
+		case CL_AMSDU_SUB_FRAME_SET:
+			cl_tx_sub_frame_set(cl_sta, tid);
+			fallthrough;
+		case CL_AMSDU_FAILED:
+		default:
+			return;
+		}
+	} else {
+		/*
+		 * If not amsdu & anchor exist. reset current anchor
+		 * in order to avoid reordring packets.
+		 */
+		if (cl_sta->amsdu_anchor[tid].sw_txhdr)
+			cl_tx_amsdu_anchor_init(&cl_sta->amsdu_anchor[tid]);
+	}
+
+	/* Allocate sw_txhdr */
+	sw_txhdr = cl_sw_txhdr_alloc(cl_hw);
+	if (unlikely(!sw_txhdr)) {
+		kfree_skb(skb);
+		cl_dbg_err(cl_hw, "sw_txhdr alloc failed\n");
+		cl_hw->tx_packet_cntr.drop.txhdr_alloc_fail++;
+		cl_vif->trfc_cntrs[ac].tx_errors++;
+		return;
+	}
+
+	if (cl_vif->vif->type == NL80211_IFTYPE_MESH_POINT)
+		tx_info->hw_queue = ac;
+
+	/* Fill sw_txhdr */
+	sw_txhdr->tid = tid;
+	sw_txhdr->ac = ac;
+	sw_txhdr->hw_queue = tx_info->hw_queue;
+	sw_txhdr->cl_sta = cl_sta;
+	sw_txhdr->sta_idx = cl_sta->sta_idx;
+	sw_txhdr->is_bcn = 0;
+	sw_txhdr->skb = skb;
+	sw_txhdr->map_len = frame_len + hdr_pads;
+	sw_txhdr->cl_vif = cl_vif;
+
+	if (cl_sta->amsdu_anchor[tid].is_sw_amsdu) {
+		sw_txhdr->is_sw_amsdu = true;
+		sw_txhdr->sw_amsdu_packet_cnt = 1;
+	} else {
+		sw_txhdr->is_sw_amsdu = false;
+	}
+
+	if (hdr_conv) {
+		sw_txhdr->hdr80211 = NULL;
+		sw_txhdr->fc = cl_tx_agg_frame_control(cl_vif, key_conf, &hdrlen);
+	} else {
+		struct ieee80211_hdr *hdr80211 = (struct ieee80211_hdr *)skb->data;
+		__le16 fc = hdr80211->frame_control;
+
+		sw_txhdr->hdr80211 = hdr80211;
+		sw_txhdr->fc = fc;
+		hdrlen = ieee80211_hdrlen(fc);
+	}
+
+	/* Fetch the relevant agg queue */
+	tx_queue = cl_sta->agg_tx_queues[tid];
+
+	if (unlikely(!tx_queue)) {
+		kfree_skb(skb);
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+		cl_dbg_err(cl_hw, "tx_queue is NULL [sta_idx = %u] [tid = %u]\n",
+			   cl_sta->sta_idx, tid);
+		cl_hw->tx_packet_cntr.drop.queue_null++;
+		cl_vif->trfc_cntrs[ac].tx_dropped++;
+		return;
+	}
+
+	sw_txhdr->tx_queue = tx_queue;
+
+	total_frame_len = frame_len + hdrlen - sizeof(struct ethhdr);
+
+	if (key_conf)
+		total_frame_len += key_conf->icv_len;
+
+	/* Prepare txdesc */
+	cl_tx_agg_prep(cl_hw, sw_txhdr, frame_len, hdr_pads, hdr_conv);
+
+	/*
+	 * AMSDU - first sub frame
+	 * !!! Must be done after calling cl_tx_agg_prep() !!!
+	 */
+	if (is_amsdu)
+		cl_tx_amsdu_first_sub_frame(sw_txhdr, cl_sta, skb, tid);
+
+	cl_tx_send(cl_hw, sw_txhdr, &cl_sta->amsdu_anchor[tid]);
+}
+
+void cl_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+	       struct sk_buff *skb, bool hdr_conv, bool lock)
+{
+	if (lock) {
+		spin_lock_bh(&cl_hw->tx_lock_agg);
+		_cl_tx_agg(cl_hw, cl_sta, skb, hdr_conv);
+		spin_unlock_bh(&cl_hw->tx_lock_agg);
+	} else {
+		_cl_tx_agg(cl_hw, cl_sta, skb, hdr_conv);
+	}
+}
+
+static void cl_tx_reset_session_timer(struct ieee80211_sta *sta, u8 tid)
+{
+	struct tid_ampdu_tx *tid_tx = NULL;
+	struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(sta);
+
+	tid_tx = rcu_dereference(stainfo->ampdu_mlme.tid_tx[tid]);
+
+	if (tid_tx && tid_tx->timeout)
+		tid_tx->last_tx = jiffies;
+}
+
+void cl_tx_fast_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		    struct sk_buff *skb, bool lock)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = cl_sta->cl_vif->vif;
+	u16 ac = skb_get_queue_mapping(skb);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+
+	tx_info->control.vif = vif;
+	tx_info->control.hw_key = cl_key_get(cl_sta);
+	tx_info->hw_queue = vif->hw_queue[ac];
+	tx_info->flags |= IEEE80211_TX_CTL_AMPDU;
+
+	if (cl_sta->baws[tid].amsdu &&
+	    (cl_wrs_api_get_tx_sta_data_rate(cl_sta) > cl_hw->conf->ci_tx_amsdu_min_data_rate))
+		tx_info->control.flags |= IEEE80211_TX_CTRL_AMSDU;
+
+	cl_tx_agg(cl_hw, cl_sta, skb, true, lock);
+	cl_tx_reset_session_timer(cl_sta->sta, tid);
+	cl_hw->tx_packet_cntr.forward.drv_fast_agg++;
+}
+
+void cl_tx_wlan_to_8023(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ethhdr tmp_eth;
+	struct ethhdr *ehdr;
+	struct {
+		u8 hdr[ETH_ALEN]__aligned(2);
+		__be16 proto;
+	} payload;
+	u16 hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	u8 enc_len = cl_key_get_cipher_len(skb);
+
+	cl_mac_addr_copy(tmp_eth.h_dest, ieee80211_get_DA(hdr));
+	cl_mac_addr_copy(tmp_eth.h_source, ieee80211_get_SA(hdr));
+	skb_copy_bits(skb, hdrlen, &payload, sizeof(payload));
+	tmp_eth.h_proto = payload.proto;
+
+	if (enc_len) {
+		memcpy(skb->data + hdrlen,
+		       skb->data + hdrlen + enc_len,
+		       skb->len - hdrlen - enc_len);
+		skb_trim(skb, skb->len - enc_len);
+	}
+
+	if (likely((ether_addr_equal(payload.hdr, rfc1042_header) &&
+		    tmp_eth.h_proto != htons(ETH_P_AARP) &&
+		    tmp_eth.h_proto != htons(ETH_P_IPX)) ||
+		   ether_addr_equal(payload.hdr, bridge_tunnel_header)))
+		/* Remove RFC1042 or Bridge-Tunnel encapsulation and replace ether_type */
+		hdrlen += ETH_ALEN + 2;
+	else
+		tmp_eth.h_proto = htons(skb->len - hdrlen);
+
+	skb_pull(skb, hdrlen);
+	ehdr = skb_push(skb, sizeof(struct ethhdr));
+	memcpy(ehdr, &tmp_eth, sizeof(tmp_eth));
+}
+
+u16 cl_tx_prepare_wlan_hdr(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			   struct sk_buff *skb, struct ieee80211_hdr *hdr)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	u16 hdrlen = 0;
+	__le16 fc = cpu_to_le16(IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA);
+	struct ieee80211_vif *vif = cl_sta->cl_vif->vif;
+
+	if (tx_info->control.hw_key)
+		fc |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+		fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS);
+		/* DA BSSID SA */
+		memcpy(hdr->addr1, skb->data, ETH_ALEN);
+		memcpy(hdr->addr2, vif->addr, ETH_ALEN);
+		memcpy(hdr->addr3, skb->data + ETH_ALEN, ETH_ALEN);
+		hdrlen = 24;
+		break;
+	case NL80211_IFTYPE_STATION:
+		{
+			struct wireless_dev *wdev = skb->dev->ieee80211_ptr;
+
+			if (wdev && wdev->use_4addr) {
+				fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS |
+						IEEE80211_FCTL_TODS);
+				/* RA TA DA SA */
+				memcpy(hdr->addr1, vif->bss_conf.bssid, ETH_ALEN);
+				memcpy(hdr->addr2, vif->addr, ETH_ALEN);
+				memcpy(hdr->addr3, skb->data, ETH_ALEN);
+				memcpy(hdr->addr4, skb->data + ETH_ALEN, ETH_ALEN);
+				hdrlen = 30;
+			} else {
+				fc |= cpu_to_le16(IEEE80211_FCTL_TODS);
+				/* BSSID SA DA */
+				memcpy(hdr->addr1, vif->bss_conf.bssid, ETH_ALEN);
+				memcpy(hdr->addr2, skb->data + ETH_ALEN, ETH_ALEN);
+				memcpy(hdr->addr3, skb->data, ETH_ALEN);
+				hdrlen = 24;
+			}
+		}
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		cl_dbg_trace(cl_hw, "vif type mesh_point, invalid tx path\n");
+		return 0;
+	default:
+		cl_dbg_err(cl_hw, "Unknown vif type %d !!!\n", vif->type);
+		return 0;
+	}
+
+	if (cl_sta->sta->wme) {
+		fc |= cpu_to_le16(IEEE80211_STYPE_QOS_DATA);
+		hdrlen += 2;
+	}
+
+	hdr->frame_control = fc;
+	hdr->duration_id = 0;
+	hdr->seq_ctrl = 0;
+
+	return hdrlen;
+}
+
+int cl_tx_8023_to_wlan(struct cl_hw *cl_hw, struct sk_buff *skb, struct cl_sta *cl_sta, u8 tid)
+{
+	struct ieee80211_hdr hdr;
+	int head_need, ret = 0;
+	u16 ethertype, hdrlen;
+	const u8 *encaps_data = NULL;
+	int encaps_len = 0, skip_header_bytes = ETH_HLEN;
+	u8 enc_len = cl_key_get_cipher_len(skb);
+
+	/* Convert Ethernet header to proper 802.11 header */
+	ethertype = (skb->data[12] << 8) | skb->data[13];
+
+	hdrlen = cl_tx_prepare_wlan_hdr(cl_hw, cl_sta, skb, &hdr);
+	if (!hdrlen) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (ethertype >= ETH_P_802_3_MIN) {
+		encaps_data = rfc1042_header;
+		encaps_len = sizeof(rfc1042_header);
+		skip_header_bytes -= 2;
+	}
+
+	skb_pull(skb, skip_header_bytes);
+	head_need = hdrlen + enc_len + encaps_len - skb_headroom(skb);
+
+	if (head_need > 0) {
+		head_need = ((head_need + 3) & ~3);
+		if (pskb_expand_head(skb, head_need, 0, GFP_ATOMIC)) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
+
+	if (encaps_data)
+		memcpy(skb_push(skb, encaps_len), encaps_data, encaps_len);
+
+	skb_push(skb, hdrlen + enc_len);
+
+	if (cl_sta->sta->wme) {
+		u16 qos_ctrl = tid;
+
+		memcpy(skb->data, &hdr, hdrlen - 2);
+		memcpy(skb->data + hdrlen - 2, &qos_ctrl, 2);
+	} else {
+		memcpy(skb->data, &hdr, hdrlen);
+	}
+
+	skb_reset_mac_header(skb);
+
+	return ret;
+free:
+	cl_hw->tx_packet_cntr.drop.build_hdr_fail++;
+	cl_sta->cl_vif->trfc_cntrs[tid_to_ac[tid]].tx_errors++;
+	kfree_skb(skb);
+	skb = NULL;
+
+	return ret;
+}
+
+void cl_tx_check_start_ba_session(struct cl_hw *cl_hw,
+				  struct ieee80211_sta *sta,
+				  struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(sta);
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	u8 tid;
+
+	/* TODO: What about HE? */
+	if (!sta->ht_cap.ht_supported &&
+	    !sta->vht_cap.vht_supported &&
+	    !cl_band_is_6g(cl_hw))
+		return;
+
+	if (test_sta_flag(stainfo, WLAN_STA_PS_STA))
+		return;
+
+	if ((tx_info->flags & IEEE80211_TX_CTL_AMPDU) &&
+	    !(tx_info->flags & IEEE80211_TX_STAT_AMPDU))
+		return;
+
+	if (cl_tx_ctrl_is_eapol(tx_info))
+		return;
+
+	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
+		return;
+
+	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+		return;
+
+	tid = ieee80211_get_tid(hdr);
+
+	if (likely(stainfo->ampdu_mlme.tid_tx[tid]))
+		return;
+
+	ieee80211_start_tx_ba_session(sta, tid, cl_hw->conf->ce_tx_ba_session_timeout);
+}
+
+static void cl_tx_handle_beacon_tim(struct ieee80211_hw *hw, struct sk_buff *skb)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)hw->priv;
+	struct cl_sta *cl_sta = NULL;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	const u8 *tim_ie = cfg80211_find_ie(WLAN_EID_TIM, mgmt->u.beacon.variable, skb->len);
+	struct ieee80211_tim_ie *tim = NULL;
+
+	/* Offset of the element */
+	tim = (void *)(tim_ie + BCN_IE_TIM_BIT_OFFSET);
+
+	cl_sta_lock(cl_hw);
+
+	/* Loop through all STA's */
+	list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+		if (cl_traffic_is_sta_tx_exist(cl_hw, cl_sta)) {
+			u8 sta_aid = cl_sta->sta->aid;
+			u8 map_index = sta_aid / BITS_PER_BYTE;
+
+			/* Update STA's AID in TIM bit */
+			tim->virtual_map[map_index] |= BIT(sta_aid % BITS_PER_BYTE);
+		}
+	}
+
+	cl_sta_unlock(cl_hw);
+}
+
+static struct sk_buff *cl_tx_beacon_get(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = NULL;
+
+	skb = ieee80211_beacon_get(hw, vif);
+
+	/* Handle beacon TIM bitmap */
+	if (skb)
+		cl_tx_handle_beacon_tim(hw, skb);
+
+	return skb;
+}
+
+static void cl_tx_mc(struct cl_vif *cl_vif, int *mc_fw_free)
+{
+	struct cl_hw *cl_hw = cl_vif->cl_hw;
+	struct ieee80211_vif *vif = cl_vif->vif;
+	struct sk_buff *skb = NULL;
+	struct ieee80211_tx_info *tx_info;
+
+	if (unlikely(!vif))
+		return;
+
+	while (((*mc_fw_free) > 0) &&
+	       (skb = ieee80211_get_buffered_bc(cl_hw->hw, vif))) {
+		/* Route this MCBC frame to the BCN ipc queue */
+		tx_info = IEEE80211_SKB_CB(skb);
+		tx_info->hw_queue = CL_HWQ_BCN;
+
+		(*mc_fw_free)--;
+
+		/* Clear more data bit if this is the last frame in this SP */
+		if (*mc_fw_free == 0) {
+			struct ieee80211_hdr *hdr =
+					(struct ieee80211_hdr *)skb->data;
+			hdr->frame_control &=
+					cpu_to_le16(~IEEE80211_FCTL_MOREDATA);
+		}
+
+		cl_tx_single(cl_hw, NULL, skb, false, true);
+	}
+}
+
+void cl_tx_bcn_mesh_task(unsigned long data)
+{
+	struct cl_vif *cl_vif = NULL;
+	struct cl_hw *cl_hw = NULL;
+	struct ieee80211_tx_info *tx_info;
+	struct sk_buff *skb;
+	int mc_fw_free;
+
+	cl_vif = (struct cl_vif *)data;
+	if (!cl_vif)
+		return;
+
+	cl_hw = cl_vif->cl_hw;
+
+	if (!cl_hw || !cl_vif->vif || cl_vif->vif->type != NL80211_IFTYPE_MESH_POINT ||
+	    cl_radio_is_off(cl_hw) ||
+	    cl_recovery_in_progress(cl_hw) ||
+	    !test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+	    test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags) ||
+	    cl_hw->tx_disable_flags)
+		return;
+
+	skb = cl_tx_beacon_get(cl_hw->hw, cl_vif->vif);
+	if (!skb)
+		return;
+
+	/* Route this BCN to the BCN ipc queue */
+	tx_info = IEEE80211_SKB_CB(skb);
+	tx_info->hw_queue = CL_HWQ_BCN;
+
+	cl_tx_single(cl_hw, NULL, skb, false, true);
+
+	mc_fw_free = cl_hw->tx_queues->bcmc.fw_free_space;
+	cl_tx_mc(cl_vif, &mc_fw_free);
+}
+
+static void cl_tx_bcn(struct cl_vif *cl_vif)
+{
+	struct cl_hw *cl_hw = cl_vif->cl_hw;
+	struct ieee80211_vif *vif = cl_vif->vif;
+	struct ieee80211_tx_info *tx_info;
+	struct sk_buff *skb;
+
+	if (!vif || vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	/*
+	 * If we are in the middle of the CAC, we allow regular channel switch
+	 * and retrigger the CAC (If needed).
+	 * Or - if radar is detected, we wait for all CSAs to be transmitted,
+	 * before allowing channel switch
+	 */
+	if (cl_dfs_is_in_cac(cl_hw) && vif->csa_active) {
+		ieee80211_csa_finish(vif);
+		return;
+	}
+
+	skb = cl_tx_beacon_get(cl_hw->hw, vif);
+	if (!skb)
+		return;
+
+	/* Route this BCN to the BCN ipc queue */
+	tx_info = IEEE80211_SKB_CB(skb);
+	tx_info->hw_queue = CL_HWQ_BCN;
+
+	cl_tx_single(cl_hw, NULL, skb, false, true);
+}
+
+bool cl_is_tx_allowed(struct cl_hw *cl_hw)
+{
+	return !(cl_radio_is_off(cl_hw) ||
+		 cl_hw->vif_db.num_iface_bcn == 0 ||
+		 cl_recovery_in_progress(cl_hw) ||
+		 cl_hw->tx_db.block_bcn ||
+		 cl_hw->tx_disable_flags ||
+		 !test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+		 test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags));
+}
+
+/* cl_tx_bcns_tasklet - generate BCNs and TX buffered MC frames each BCN DTIM interval
+ *
+ * Beacons are sent first followed by cyclic MC for fairness between VIF's
+ * the FW buffer is restricted to "IPC_TXDESC_CNT_BCMC" buffer size.
+ */
+void cl_tx_bcns_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct cl_vif *cl_vif = NULL;
+	int mc_fw_free = 0;
+
+	read_lock(&cl_hw->vif_db.lock);
+
+	if (!cl_is_tx_allowed(cl_hw))
+		goto out;
+	list_for_each_entry(cl_vif, &cl_hw->vif_db.head, list)
+		cl_tx_bcn(cl_vif);
+
+	cl_vif = cl_hw->mc_vif;
+	mc_fw_free = cl_hw->tx_queues->bcmc.fw_free_space;
+
+	do {
+		cl_tx_mc(cl_vif, &mc_fw_free);
+		/* Cl_vif_get_next() is cyclic */
+		cl_vif = cl_vif_get_next(cl_hw, cl_vif);
+	} while ((cl_vif != cl_hw->mc_vif) && mc_fw_free);
+
+	cl_hw->mc_vif = cl_vif_get_next(cl_hw, cl_hw->mc_vif);
+
+out:
+	read_unlock(&cl_hw->vif_db.lock);
+}
+
+void cl_tx_en(struct cl_hw *cl_hw, u8 reason, bool enable)
+{
+	unsigned long tx_disable_flags_prev = cl_hw->tx_disable_flags;
+
+	if (enable) {
+		clear_bit(reason, &cl_hw->tx_disable_flags);
+
+		if (tx_disable_flags_prev != 0 && cl_hw->tx_disable_flags == 0)
+			if (cl_hw->conf->ci_backup_bcn_en)
+				cl_msg_tx_backup_bcn_en(cl_hw, true);
+	} else {
+		set_bit(reason, &cl_hw->tx_disable_flags);
+
+		if (tx_disable_flags_prev == 0)
+			if (cl_hw->conf->ci_backup_bcn_en)
+				cl_msg_tx_backup_bcn_en(cl_hw, false);
+	}
+}
+
+static void cl_tx_flush(struct cl_hw *cl_hw)
+{
+	/* Flush bcmc */
+	spin_lock_bh(&cl_hw->tx_lock_bcmc);
+	cl_bcmc_cfm_flush_queue(cl_hw, NULL);
+	spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+
+	/* Flush single */
+	spin_lock_bh(&cl_hw->tx_lock_single);
+	cl_txq_flush_all_single(cl_hw);
+	cl_single_cfm_flush_all(cl_hw);
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+
+	/* Flush agg */
+	spin_lock_bh(&cl_hw->tx_lock_agg);
+	cl_txq_flush_all_agg(cl_hw);
+	cl_agg_cfm_flush_all(cl_hw);
+	spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+void cl_tx_off(struct cl_hw *cl_hw)
+{
+	cl_txq_stop(cl_hw);
+	cl_tx_flush(cl_hw);
+}
+
+void cl_tx_drop_skb(struct sk_buff *skb)
+{
+	skb->dev->stats.rx_dropped++;
+	kfree_skb(skb);
+}
+
+#define AGG_POLL_TIMEOUT 50
+
+/*
+ * cl_hw->agg_cfm_queues:
+ * These queues are used to keep pointers to skb's sent
+ * as aggregation and waiting for confirmation.
+ */
+
+void cl_agg_cfm_init(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++)
+		INIT_LIST_HEAD(&cl_hw->agg_cfm_queues[i].head);
+}
+
+void cl_agg_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, u8 agg_idx)
+{
+	spin_lock(&cl_hw->tx_lock_cfm_agg);
+	list_add_tail(&sw_txhdr->cfm_list, &cl_hw->agg_cfm_queues[agg_idx].head);
+	spin_unlock(&cl_hw->tx_lock_cfm_agg);
+}
+
+static void cl_agg_cfm_amsdu_free(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	struct cl_amsdu_txhdr *amsdu_txhdr = NULL;
+	struct cl_amsdu_txhdr *tmp = NULL;
+	struct sk_buff *sub_skb = NULL;
+	struct ieee80211_tx_info *tx_info_sub_skb = NULL;
+
+	list_for_each_entry_safe(amsdu_txhdr, tmp, &sw_txhdr->amsdu_txhdr.list, list) {
+		sub_skb = amsdu_txhdr->skb;
+		tx_info_sub_skb = IEEE80211_SKB_CB(sub_skb);
+
+		list_del(&amsdu_txhdr->list);
+		dma_unmap_single(cl_hw->chip->dev, amsdu_txhdr->dma_addr,
+				 (size_t)sub_skb->len, DMA_TO_DEVICE);
+		kfree_skb(sub_skb);
+		cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+	}
+}
+
+void cl_agg_cfm_free_head_skb(struct cl_hw *cl_hw,
+			      struct cl_agg_cfm_queue *cfm_queue,
+			      u8 ba_queue_idx)
+{
+	struct cl_sw_txhdr *sw_txhdr = list_first_entry(&cfm_queue->head,
+							struct cl_sw_txhdr,
+							cfm_list);
+	struct sk_buff *skb = sw_txhdr->skb;
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	dma_addr_t dma_addr = le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]);
+
+	if (cl_hw->conf->ci_tx_delay_tstamp_en)
+		cl_tx_update_hist_tstamp(cfm_queue->tx_queue, skb,
+					 cfm_queue->tx_queue->hist_push_to_cfm, false);
+
+	dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA_TO_DEVICE);
+
+	/* If amsdu list not empty free sub MSDU frames first, including amsdu_txhdr */
+	if (cl_tx_ctrl_is_amsdu(tx_info))
+		if (!list_empty(&sw_txhdr->amsdu_txhdr.list))
+			cl_agg_cfm_amsdu_free(cl_hw, sw_txhdr);
+
+	consume_skb(skb);
+	list_del(&sw_txhdr->cfm_list);
+	cl_sw_txhdr_free(cl_hw, sw_txhdr);
+}
+
+static void cl_agg_cfm_flush_queue(struct cl_hw *cl_hw, u8 agg_idx)
+{
+	struct cl_agg_cfm_queue *cfm_queue = &cl_hw->agg_cfm_queues[agg_idx];
+	struct cl_tx_queue *tx_queue = cfm_queue->tx_queue;
+	struct sk_buff *skb = NULL;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	dma_addr_t dma_addr = 0;
+	struct ieee80211_tx_info *tx_info;
+
+	if (!tx_queue)
+		return;
+
+	if (list_empty(&cfm_queue->head))
+		return;
+
+	do {
+		sw_txhdr = list_first_entry(&cfm_queue->head, struct cl_sw_txhdr, cfm_list);
+		skb = sw_txhdr->skb;
+
+		dma_addr = le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]);
+		dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA_TO_DEVICE);
+
+		tx_info = IEEE80211_SKB_CB(skb);
+
+		/* If amsdu list not empty free sub MSDU frames first, including amsdu_txhdr */
+		if (cl_tx_ctrl_is_amsdu(tx_info))
+			if (!list_empty(&sw_txhdr->amsdu_txhdr.list))
+				cl_agg_cfm_amsdu_free(cl_hw, sw_txhdr);
+
+		tx_queue->total_fw_cfm++;
+
+		kfree_skb(skb);
+		list_del(&sw_txhdr->cfm_list);
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+	} while (!list_empty(&cfm_queue->head));
+
+	/*
+	 * Set fw_free_space back to maximum after flushing the queue
+	 * and clear the enhanced TIM.
+	 */
+	tx_queue->fw_free_space = tx_queue->fw_max_size;
+	cl_enhanced_tim_clear_tx_agg(cl_hw, agg_idx, tx_queue->hw_index,
+				     tx_queue->cl_sta, tx_queue->tid);
+
+	cfm_queue->tx_queue = NULL;
+}
+
+void cl_agg_cfm_flush_all(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	/* Don't use BH lock, because cl_agg_cfm_flush_all() is called with BH disabled */
+	spin_lock(&cl_hw->tx_lock_cfm_agg);
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++)
+		cl_agg_cfm_flush_queue(cl_hw, i);
+
+	spin_unlock(&cl_hw->tx_lock_cfm_agg);
+}
+
+static void cl_agg_cfm_poll_timeout(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue,
+				    u8 agg_idx, bool flush)
+{
+	/*
+	 * When polling failed clear the enhanced TIM so that firmware will
+	 * not try to transmit these packets.
+	 * If flush is set cl_enhanced_tim_clear_tx_agg() is called inside
+	 * cl_agg_cfm_flush_queue().
+	 */
+	cl_dbg_err(cl_hw, "Polling timeout (queue_idx = %u)\n", agg_idx);
+
+	spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+
+	if (flush)
+		cl_agg_cfm_flush_queue(cl_hw, agg_idx);
+	else
+		cl_enhanced_tim_clear_tx_agg(cl_hw, agg_idx, tx_queue->hw_index,
+					     tx_queue->cl_sta, tx_queue->tid);
+
+	spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+}
+
+void cl_agg_cfm_poll_empty(struct cl_hw *cl_hw, u8 agg_idx, bool flush)
+{
+	struct cl_agg_cfm_queue *cfm_queue = &cl_hw->agg_cfm_queues[agg_idx];
+	bool empty = false;
+	int i = 0;
+
+	if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+		return;
+
+	while (true) {
+		spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+		empty = list_empty(&cfm_queue->head);
+		spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+
+		if (empty)
+			return;
+
+		if (++i == AGG_POLL_TIMEOUT) {
+			cl_agg_cfm_poll_timeout(cl_hw, cfm_queue->tx_queue, agg_idx, flush);
+			return;
+		}
+
+		msleep(20);
+	}
+}
+
+void cl_agg_cfm_poll_empty_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	int i = 0;
+	struct cl_tx_queue *tx_queue = NULL;
+
+	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
+		tx_queue = cl_sta->agg_tx_queues[i];
+
+		if (tx_queue)
+			cl_agg_cfm_poll_empty(cl_hw, tx_queue->index, false);
+	}
+}
+
+void cl_agg_cfm_clear_tim_bit_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	int i = 0;
+	struct cl_tx_queue *tx_queue = NULL;
+
+	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
+		tx_queue = cl_sta->agg_tx_queues[i];
+
+		if (tx_queue) {
+			spin_lock_bh(&cl_hw->tx_lock_agg);
+			cl_enhanced_tim_clear_tx_agg(cl_hw, tx_queue->index, tx_queue->hw_index,
+						     tx_queue->cl_sta, tx_queue->tid);
+			spin_unlock_bh(&cl_hw->tx_lock_agg);
+		}
+	}
+}
+
+void cl_agg_cfm_set_ssn(struct cl_hw *cl_hw, u16 ssn, u8 idx)
+{
+	spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+	cl_hw->agg_cfm_queues[idx].ssn = ssn;
+	spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+}
+
+void cl_agg_cfm_set_tx_queue(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue, u8 idx)
+{
+	spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+	cl_hw->agg_cfm_queues[idx].tx_queue = tx_queue;
+	spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+}
+
+static bool cl_is_same_rate(struct cl_agg_tx_report *agg_report,
+			    struct cl_wrs_rate_params *rate_params)
+{
+	union cl_rate_ctrl_info rate_ctrl_info = {
+		.word = le32_to_cpu(agg_report->rate_cntrl_info)};
+	u8 mcs = U8_MAX, nss = U8_MAX;
+
+	if (agg_report->bw_requested != rate_params->bw)
+		return false;
+
+	cl_rate_ctrl_parse(&rate_ctrl_info, &nss, &mcs);
+
+	return ((mcs == rate_params->mcs) && (nss == rate_params->nss));
+}
+
+static void cl_sync_tx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			    struct cl_agg_tx_report *agg_report,
+			    struct cl_wrs_info *wrs_info, struct cl_wrs_params *wrs_params)
+{
+	if (!agg_report->is_fallback && cl_is_same_rate(agg_report, &wrs_params->rate_params)) {
+		cl_wrs_api_rate_sync(cl_hw, cl_sta, wrs_params);
+
+		wrs_info->synced = true;
+		wrs_info->quick_rate_check = true;
+		wrs_info->quick_rate_agg_cntr = 0;
+		wrs_info->quick_rate_pkt_cntr = 0;
+	} else {
+		wrs_info->sync_attempts++;
+	}
+}
+
+static void cl_ba_not_received_handler(struct cl_hw *cl_hw, struct cl_wrs_info *wrs_info,
+				       struct cl_agg_tx_report *agg_report)
+{
+	/* Ignore 'BA not received' if station is in power-save or if RTS limit was reached */
+	if (agg_report->is_sta_ps || agg_report->is_rts_retry_limit_reached)
+		return;
+
+	/* Count number of consecutive 'BA not received' */
+	wrs_info->ba_not_rcv_consecutive++;
+
+	/* Save longest sequence of consecutive 'BA not received' */
+	if (wrs_info->ba_not_rcv_consecutive > wrs_info->ba_not_rcv_consecutive_max)
+		wrs_info->ba_not_rcv_consecutive_max = wrs_info->ba_not_rcv_consecutive;
+
+	if (cl_hw->wrs_db.ba_not_rcv_collision_filter) {
+		/*
+		 * First 'BA not received' - might just be a collision.
+		 * Don't add fail to ba_not_rcv but keep aside.
+		 * Second consecutive 'BA not received' - not likely to be a collisions.
+		 * Add fail to ba_not_rcv including previous fail that was kept aside.
+		 * More than two consecutive 'BA not received' - very unlikely to be a collisions.
+		 * Add fail to ba_not_rcv.
+		 */
+		if (wrs_info->ba_not_rcv_consecutive == 1)
+			wrs_info->fail_prev = agg_report->fail;
+		else if (wrs_info->ba_not_rcv_consecutive == 2)
+			wrs_info->ba_not_rcv += (agg_report->fail + wrs_info->fail_prev);
+		else
+			wrs_info->ba_not_rcv += agg_report->fail;
+	} else {
+		wrs_info->ba_not_rcv += agg_report->fail;
+	}
+}
+
+void cl_agg_tx_report_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			      struct cl_agg_tx_report *agg_report)
+{
+	struct cl_wrs_info *wrs_info = NULL;
+	struct cl_wrs_params *wrs_params = NULL;
+	u8 group_id;
+	bool skip_epr_update = false;
+	union cl_rate_ctrl_info rate_ctrl_info = {
+		.word = le32_to_cpu(agg_report->rate_cntrl_info)};
+
+	wrs_params = &cl_sta->wrs_sta.tx_su_params;
+	wrs_info = &cl_sta->wrs_info_tx_su;
+	group_id = 0;
+
+	/* Retry_count for cl_wlan */
+	cl_sta->retry_count += agg_report->success_after_retry;
+
+	/*
+	 * In case of big packets (4300 in VHT and 5400 in HE) and low
+	 * rate (BW 20, NSS 1, MCS 0), firmware will increase rate to MCS 1,
+	 * and give an indication to driver (set rate_fix_mcs1 in cl_agg_tx_report).
+	 * WRS should also move to MCS 1, and give the maximum time
+	 * penalty time from MCS 0 toMCS 1.
+	 */
+	if (agg_report->rate_fix_mcs1 &&
+	    !agg_report->is_fallback &&
+	    cl_wrs_api_up_mcs1(cl_hw, cl_sta, wrs_params))
+		return;
+
+	/* WRS sync mechanism */
+	if (!wrs_info->synced)
+		cl_sync_tx_rate(cl_hw, cl_sta, agg_report, wrs_info, wrs_params);
+
+	if (agg_report->bf && cl_sta->bf_db.is_on && !cl_sta->bf_db.synced) {
+		cl_sta->bf_db.synced = true;
+		/* Resetting the WRS UP weights */
+		cl_wrs_api_beamforming_sync(cl_hw, cl_sta);
+	}
+
+	if (agg_report->ba_not_received) {
+		cl_ba_not_received_handler(cl_hw, wrs_info, agg_report);
+	} else {
+		if (!skip_epr_update)
+			wrs_info->fail += agg_report->fail;
+
+		wrs_info->ba_not_rcv_consecutive = 0;
+	}
+
+	if (!skip_epr_update) {
+		u8 mcs = 0, nss = 0, bw = 0;
+		u16 data_rate = 0;
+
+		switch (agg_report->bw_requested) {
+		case CHNL_BW_160:
+			bw = (cl_hw->wrs_db.adjacent_interference20 ||
+			      cl_hw->wrs_db.adjacent_interference40 ||
+			      cl_hw->wrs_db.adjacent_interference80) ?
+				rate_ctrl_info.field.bw : agg_report->bw_requested;
+			break;
+		case CHNL_BW_80:
+			bw = (cl_hw->wrs_db.adjacent_interference20 ||
+			      cl_hw->wrs_db.adjacent_interference40) ?
+				rate_ctrl_info.field.bw : agg_report->bw_requested;
+			break;
+		case CHNL_BW_40:
+			bw = cl_hw->wrs_db.adjacent_interference20 ?
+				rate_ctrl_info.field.bw : agg_report->bw_requested;
+			break;
+		case CHNL_BW_20:
+			bw = agg_report->bw_requested;
+			break;
+		}
+
+		cl_rate_ctrl_parse(&rate_ctrl_info, &nss, &mcs);
+
+		data_rate = cl_data_rates_get_x10(rate_ctrl_info.field.format_mod,
+						  bw,
+						  nss,
+						  mcs,
+						  rate_ctrl_info.field.gi);
+
+		wrs_info->epr_acc += ((u64)agg_report->success * data_rate);
+		wrs_info->success += agg_report->success;
+	}
+
+	if (cl_hw->wrs_db.quick_down_en &&
+	    wrs_info->quick_rate_check &&
+	    cl_is_same_rate(agg_report, &wrs_params->rate_params)) {
+		wrs_info->quick_rate_agg_cntr++;
+		wrs_info->quick_rate_pkt_cntr += (agg_report->success + agg_report->fail);
+
+		if (wrs_info->quick_rate_agg_cntr >= cl_hw->wrs_db.quick_down_agg_thr &&
+		    wrs_info->quick_rate_pkt_cntr > cl_hw->wrs_db.quick_down_pkt_thr) {
+			wrs_info->quick_rate_check = false;
+			cl_wrs_api_quick_down_check(cl_hw, cl_sta, wrs_params);
+		}
+	}
+}
+
+void cl_agg_tx_report_simulate_for_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+					  struct cl_hw_tx_status *status)
+{
+	/* Assign statistics struct */
+	struct cl_agg_tx_report agg_report;
+	union cl_rate_ctrl_info rate_ctrl_info;
+
+	memset(&agg_report, 0, sizeof(struct cl_agg_tx_report));
+
+	agg_report.bf = status->bf;
+	agg_report.success = status->frm_successful;
+	agg_report.fail = status->num_mpdu_retries + (status->frm_successful ? 0 : 1);
+	agg_report.success_after_retry =
+		(status->frm_successful && status->num_mpdu_retries);
+	agg_report.retry_limit_reached = !status->frm_successful;
+	agg_report.success_more_one_retry =
+		(status->frm_successful && (status->num_mpdu_retries > 1));
+	agg_report.sta_idx = cl_sta->sta_idx;
+	agg_report.bw_requested = status->bw_requested;
+
+	rate_ctrl_info.field.bw = status->bw_transmitted;
+	rate_ctrl_info.field.gi = status->gi;
+	rate_ctrl_info.field.format_mod = status->format_mod;
+	rate_ctrl_info.field.mcs_index = status->mcs_index;
+
+	cl_rate_ctrl_convert(&rate_ctrl_info);
+
+	agg_report.rate_cntrl_info = cpu_to_le32(rate_ctrl_info.word);
+	cl_agg_tx_report_handler(cl_hw, cl_sta, &agg_report);
+	cl_stats_update_tx_single(cl_hw, cl_sta, &agg_report);
+}
+
+void cl_baw_init(struct cl_sta *cl_sta)
+{
+	u8 tid;
+
+	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++)
+		__skb_queue_head_init(&cl_sta->baws[tid].pending);
+}
+
+void cl_baw_start(struct cl_baw *baw, u16 ssn)
+{
+	baw->ssn = ssn;
+	baw->action_start = true;
+}
+
+void cl_baw_operational(struct cl_hw *cl_hw, struct cl_baw *baw,
+			u8 fw_agg_idx, bool amsdu_supported)
+{
+	baw->fw_agg_idx = fw_agg_idx;
+	baw->tid_seq = IEEE80211_SN_TO_SEQ(baw->ssn);
+	baw->action_start = false;
+	baw->amsdu = (cl_hw->txamsdu_en && amsdu_supported);
+}
+
+void cl_baw_stop(struct cl_baw *baw)
+{
+	baw->action_start = false;
+}
+
+void cl_baw_pending_to_agg(struct cl_hw *cl_hw,
+			   struct cl_sta *cl_sta,
+			   u8 tid)
+{
+	struct cl_baw *baw = &cl_sta->baws[tid];
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(&baw->pending)) {
+		skb = __skb_dequeue(&baw->pending);
+		cl_tx_fast_agg(cl_hw, cl_sta, skb, false);
+	}
+}
+
+void cl_baw_pending_to_single(struct cl_hw *cl_hw,
+			      struct cl_sta *cl_sta,
+			      struct cl_baw *baw)
+{
+	struct sk_buff *skb;
+
+	while (!skb_queue_empty(&baw->pending)) {
+		skb = __skb_dequeue(&baw->pending);
+		cl_tx_fast_single(cl_hw, cl_sta, skb, false);
+	}
+}
+
+void cl_baw_pending_purge(struct cl_baw *baw)
+{
+	if (!skb_queue_empty(&baw->pending))
+		__skb_queue_purge(&baw->pending);
+}
+
+/*
+ * cl_hw->bcmc_cfm_queue:
+ * This queue is used to keep pointers to already sent
+ * beacon skb's that are waiting for confirmation.
+ */
+
+static void cl_bcmc_free_sw_txhdr(struct cl_hw *cl_hw,
+				  struct cl_sw_txhdr *sw_txhdr)
+{
+	dma_addr_t dma_addr;
+	struct sk_buff *skb = NULL;
+
+	dma_addr = le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]);
+	skb = sw_txhdr->skb;
+
+	dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA_TO_DEVICE);
+	dev_kfree_skb_irq(skb);
+	list_del(&sw_txhdr->cfm_list);
+	cl_sw_txhdr_free(cl_hw, sw_txhdr);
+}
+
+static bool cl_bcmc_is_list_empty_per_vif(struct cl_hw *cl_hw,
+					  struct cl_vif *cl_vif)
+{
+	struct cl_single_cfm_queue *cfm_queue = &cl_hw->bcmc_cfm_queue;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+
+	list_for_each_entry(sw_txhdr, &cfm_queue->head, cfm_list)
+		if (sw_txhdr->cl_vif == cl_vif)
+			return false;
+
+	return true;
+}
+
+void cl_bcmc_cfm_init(struct cl_hw *cl_hw)
+{
+	INIT_LIST_HEAD(&cl_hw->bcmc_cfm_queue.head);
+}
+
+void cl_bcmc_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	list_add_tail(&sw_txhdr->cfm_list, &cl_hw->bcmc_cfm_queue.head);
+}
+
+struct cl_sw_txhdr *cl_bcmc_cfm_find(struct cl_hw *cl_hw, dma_addr_t dma_addr, bool keep_in_list)
+{
+	struct cl_single_cfm_queue *cfm_queue = &cl_hw->bcmc_cfm_queue;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	struct cl_sw_txhdr *tmp = NULL;
+
+	list_for_each_entry_safe(sw_txhdr, tmp, &cfm_queue->head, cfm_list) {
+		if (le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]) == dma_addr) {
+			if (!keep_in_list)
+				list_del(&sw_txhdr->cfm_list);
+
+			return sw_txhdr;
+		}
+	}
+
+	return NULL;
+}
+
+void cl_bcmc_cfm_flush_queue(struct cl_hw *cl_hw,
+			     struct cl_vif *cl_vif)
+{
+	struct cl_single_cfm_queue *cfm_queue = &cl_hw->bcmc_cfm_queue;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	struct cl_sw_txhdr *tmp = NULL;
+
+	/* Only flush the specific cl_vif related confirmations */
+	if (cl_vif) {
+		list_for_each_entry_safe(sw_txhdr, tmp, &cfm_queue->head, cfm_list) {
+			if (sw_txhdr->cl_vif == cl_vif) {
+				cl_bcmc_free_sw_txhdr(cl_hw, sw_txhdr);
+				cl_hw->tx_queues->bcmc.fw_free_space++;
+			}
+		}
+
+		return;
+	}
+
+	while (!list_empty(&cfm_queue->head)) {
+		sw_txhdr = list_first_entry(&cfm_queue->head, struct cl_sw_txhdr, cfm_list);
+		cl_bcmc_free_sw_txhdr(cl_hw, sw_txhdr);
+	}
+
+	/* Set fw_free_space back to maximum after flushing the queue */
+	cl_hw->tx_queues->bcmc.fw_free_space = cl_hw->tx_queues->bcmc.fw_max_size;
+}
+
+void cl_bcmc_cfm_poll_empty_per_vif(struct cl_hw *cl_hw,
+				    struct cl_vif *cl_vif)
+{
+	bool empty = false;
+	int i = 0;
+
+	if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+		return;
+
+	while (i++ < BCMC_POLL_TIMEOUT) {
+		spin_lock_bh(&cl_hw->tx_lock_bcmc);
+		empty = cl_bcmc_is_list_empty_per_vif(cl_hw, cl_vif);
+		spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+
+		if (empty)
+			return;
+
+		msleep(20);
+	}
+
+	cl_dbg_err(cl_hw, "Polling timeout vif_index %d\n", cl_vif->vif_index);
+
+	spin_lock_bh(&cl_hw->tx_lock_bcmc);
+	cl_bcmc_cfm_flush_queue(cl_hw, cl_vif);
+	spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+}
+
+/*
+ * cl_hw->single_cfm_queues:
+ * These queues are used to keep pointers to skb's sent
+ * as singles and waiting for confirmation.
+ */
+
+#define SINGLE_POLL_TIMEOUT 50
+
+void cl_single_cfm_init(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++)
+		INIT_LIST_HEAD(&cl_hw->single_cfm_queues[i].head);
+}
+
+void cl_single_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, u32 queue_idx)
+{
+	list_add_tail(&sw_txhdr->cfm_list, &cl_hw->single_cfm_queues[queue_idx].head);
+}
+
+struct cl_sw_txhdr *cl_single_cfm_find(struct cl_hw *cl_hw, u32 queue_idx,
+				       dma_addr_t dma_addr)
+{
+	struct cl_single_cfm_queue *cfm_queue = NULL;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	struct cl_sw_txhdr *tmp = NULL;
+
+	if (queue_idx >= MAX_SINGLE_QUEUES)
+		return NULL;
+
+	cfm_queue = &cl_hw->single_cfm_queues[queue_idx];
+
+	list_for_each_entry_safe(sw_txhdr, tmp, &cfm_queue->head, cfm_list)
+		if (le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]) == dma_addr) {
+			list_del(&sw_txhdr->cfm_list);
+
+			return sw_txhdr;
+		}
+
+	return NULL;
+}
+
+static void cl_single_cfm_flush_queue(struct cl_hw *cl_hw, u32 queue_idx)
+{
+	struct cl_single_cfm_queue *cfm_queue = &cl_hw->single_cfm_queues[queue_idx];
+	struct cl_tx_queue *tx_queue = NULL;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	struct sk_buff *skb = NULL;
+	struct ieee80211_tx_info *tx_info = NULL;
+	dma_addr_t dma_addr;
+
+	if (list_empty(&cfm_queue->head))
+		return;
+
+	do {
+		sw_txhdr = list_first_entry(&cfm_queue->head, struct cl_sw_txhdr, cfm_list);
+		dma_addr = le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]);
+		skb = sw_txhdr->skb;
+		tx_info = IEEE80211_SKB_CB(skb);
+
+		dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA_TO_DEVICE);
+
+		cl_tx_single_free_skb(cl_hw, skb);
+		list_del(&sw_txhdr->cfm_list);
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+	} while (!list_empty(&cfm_queue->head));
+
+	/*
+	 * Set fw_free_space back to maximum after flushing the queue
+	 * and clear the enhanced TIM.
+	 */
+	tx_queue = &cl_hw->tx_queues->single[queue_idx];
+	tx_queue->fw_free_space = tx_queue->fw_max_size;
+	cl_enhanced_tim_clear_tx_single(cl_hw, queue_idx, tx_queue->hw_index,
+					false, tx_queue->cl_sta, tx_queue->tid);
+}
+
+void cl_single_cfm_flush_all(struct cl_hw *cl_hw)
+{
+	u32 i = 0;
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++)
+		cl_single_cfm_flush_queue(cl_hw, i);
+}
+
+void cl_single_cfm_flush_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	/* Flush all single confirmation queues of this sta, and reset write index */
+	u8 ac;
+	u16 queue_idx;
+
+	spin_lock_bh(&cl_hw->tx_lock_single);
+
+	for (ac = 0; ac < AC_MAX; ac++) {
+		queue_idx = QUEUE_IDX(sta_idx, ac);
+		cl_single_cfm_flush_queue(cl_hw, queue_idx);
+
+		cl_hw->ipc_env->ring_indices_elem->indices->txdesc_write_idx.single[queue_idx] = 0;
+	}
+
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_single_cfm_poll_timeout(struct cl_hw *cl_hw, u32 queue_idx)
+{
+	/*
+	 * When polling failed clear the enhanced TIM so that firmware will
+	 * not try to transmit these packets.
+	 */
+	struct cl_tx_queue *tx_queue = &cl_hw->tx_queues->single[queue_idx];
+
+	cl_dbg_err(cl_hw, "Polling timeout (queue_idx = %u)\n", queue_idx);
+
+	spin_lock_bh(&cl_hw->tx_lock_single);
+	cl_enhanced_tim_clear_tx_single(cl_hw, queue_idx, tx_queue->hw_index,
+					false, tx_queue->cl_sta, tx_queue->tid);
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_single_cfm_poll_empty(struct cl_hw *cl_hw, u32 queue_idx)
+{
+	struct cl_single_cfm_queue *cfm_queue = &cl_hw->single_cfm_queues[queue_idx];
+	bool empty = false;
+	int i = 0;
+
+	if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+		return;
+
+	while (true) {
+		spin_lock_bh(&cl_hw->tx_lock_single);
+		empty = list_empty(&cfm_queue->head);
+		spin_unlock_bh(&cl_hw->tx_lock_single);
+
+		if (empty)
+			return;
+
+		if (++i == SINGLE_POLL_TIMEOUT) {
+			cl_single_cfm_poll_timeout(cl_hw, queue_idx);
+			return;
+		}
+
+		msleep(20);
+	}
+}
+
+static bool cl_list_hp_empty_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	struct cl_single_cfm_queue *hp_cfm_queue = &cl_hw->single_cfm_queues[HIGH_PRIORITY_QUEUE];
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+
+	list_for_each_entry(sw_txhdr, &hp_cfm_queue->head, cfm_list)
+		if (sw_txhdr->sta_idx == sta_idx)
+			return false;
+
+	return true;
+}
+
+static void cl_single_cfm_poll_empty_hp(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	bool empty = false;
+	int i = 0;
+
+	if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+		return;
+
+	while (true) {
+		spin_lock_bh(&cl_hw->tx_lock_single);
+		empty = cl_list_hp_empty_sta(cl_hw, sta_idx);
+		spin_unlock_bh(&cl_hw->tx_lock_single);
+
+		if (empty)
+			return;
+
+		if (++i == SINGLE_POLL_TIMEOUT) {
+			cl_single_cfm_poll_timeout(cl_hw, HIGH_PRIORITY_QUEUE);
+			return;
+		}
+
+		msleep(20);
+	}
+}
+
+void cl_single_cfm_poll_empty_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	/*
+	 * Poll all single queues belonging to this station, and poll all
+	 * packets belonging to this station in the high priority queue.
+	 */
+	u8 ac;
+	u16 queue_idx;
+
+	for (ac = 0; ac < AC_MAX; ac++) {
+		queue_idx = QUEUE_IDX(sta_idx, ac);
+		cl_single_cfm_poll_empty(cl_hw, queue_idx);
+	}
+
+	cl_single_cfm_poll_empty_hp(cl_hw, sta_idx);
+}
+
+void cl_single_cfm_clear_tim_bit_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	u8 ac;
+	u16 queue_idx;
+	struct cl_tx_queue *tx_queue = NULL;
+
+	for (ac = 0; ac < AC_MAX; ac++) {
+		queue_idx = QUEUE_IDX(sta_idx, ac);
+		tx_queue = &cl_hw->tx_queues->single[queue_idx];
+
+		spin_lock_bh(&cl_hw->tx_lock_single);
+		cl_enhanced_tim_clear_tx_single(cl_hw, queue_idx, tx_queue->hw_index,
+						false, tx_queue->cl_sta, tx_queue->tid);
+		spin_unlock_bh(&cl_hw->tx_lock_single);
+	}
+
+	tx_queue = &cl_hw->tx_queues->single[HIGH_PRIORITY_QUEUE];
+
+	spin_lock_bh(&cl_hw->tx_lock_single);
+	cl_enhanced_tim_clear_tx_single(cl_hw, HIGH_PRIORITY_QUEUE, tx_queue->hw_index,
+					false, tx_queue->cl_sta, tx_queue->tid);
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static int cl_sw_txhdr_init_pool(struct cl_hw *cl_hw, u16 sw_txhdr_pool)
+{
+	u16 i = 0;
+	u32 sw_txhdr_pool_size = sw_txhdr_pool * sizeof(struct cl_sw_txhdr);
+	struct cl_sw_txhdr *sw_txhdr;
+
+	INIT_LIST_HEAD(&cl_hw->head_sw_txhdr_pool);
+	spin_lock_init(&cl_hw->lock_sw_txhdr_pool);
+
+	for (i = 0; i < sw_txhdr_pool; i++) {
+		sw_txhdr = kzalloc(sizeof(*sw_txhdr), GFP_ATOMIC);
+
+		if (unlikely(!sw_txhdr)) {
+			cl_dbg_verbose(cl_hw, "sw_txhdr NULL\n");
+			return -1;
+		}
+
+		list_add(&sw_txhdr->list_pool, &cl_hw->head_sw_txhdr_pool);
+	}
+
+	cl_dbg_verbose(cl_hw, " - pool %u, size %u\n", sw_txhdr_pool, sw_txhdr_pool_size);
+
+	return 0;
+}
+
+static int cl_sw_txhdr_init_cache(struct cl_hw *cl_hw)
+{
+	char sw_txhdr_cache_name[MODULE_NAME_LEN + 32] = {0};
+
+	snprintf(sw_txhdr_cache_name, sizeof(sw_txhdr_cache_name),
+		 "%s_sw_txhdr_cache", THIS_MODULE->name);
+
+	cl_hw->sw_txhdr_cache = kmem_cache_create(sw_txhdr_cache_name,
+						  sizeof(struct cl_sw_txhdr),
+						  0,
+						  (SLAB_HWCACHE_ALIGN | SLAB_PANIC),
+						  NULL);
+
+	if (!cl_hw->sw_txhdr_cache) {
+		cl_dbg_verbose(cl_hw, "sw_txhdr_cache NULL\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+int cl_sw_txhdr_init(struct cl_hw *cl_hw)
+{
+	u16 sw_txhdr_pool = cl_hw->conf->ci_sw_txhdr_pool;
+
+	if (sw_txhdr_pool)
+		return cl_sw_txhdr_init_pool(cl_hw, sw_txhdr_pool);
+	else
+		return cl_sw_txhdr_init_cache(cl_hw);
+}
+
+static void cl_sw_txhdr_deinit_pool(struct cl_hw *cl_hw)
+{
+	struct cl_sw_txhdr *sw_txhdr, *tmp;
+
+	list_for_each_entry_safe(sw_txhdr, tmp, &cl_hw->head_sw_txhdr_pool, list_pool) {
+		list_del(&sw_txhdr->list_pool);
+		kfree(sw_txhdr);
+	}
+}
+
+static void cl_sw_txhdr_deinit_cache(struct cl_hw *cl_hw)
+{
+	kmem_cache_destroy(cl_hw->sw_txhdr_cache);
+}
+
+void cl_sw_txhdr_deinit(struct cl_hw *cl_hw)
+{
+	if (cl_hw->conf->ci_sw_txhdr_pool)
+		cl_sw_txhdr_deinit_pool(cl_hw);
+	else
+		cl_sw_txhdr_deinit_cache(cl_hw);
+}
+
+static inline struct cl_sw_txhdr *cl_sw_txhdr_alloc_pool(struct cl_hw *cl_hw)
+{
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+
+	spin_lock_bh(&cl_hw->lock_sw_txhdr_pool);
+	sw_txhdr = list_first_entry_or_null(&cl_hw->head_sw_txhdr_pool,
+					    struct cl_sw_txhdr, list_pool);
+
+	if (sw_txhdr) {
+		list_del(&sw_txhdr->list_pool);
+		spin_unlock_bh(&cl_hw->lock_sw_txhdr_pool);
+		return sw_txhdr;
+	}
+
+	spin_unlock_bh(&cl_hw->lock_sw_txhdr_pool);
+	return NULL;
+}
+
+static inline struct cl_sw_txhdr *cl_sw_txhdr_alloc_cache(struct cl_hw *cl_hw)
+{
+	return kmem_cache_alloc(cl_hw->sw_txhdr_cache, GFP_ATOMIC);
+}
+
+struct cl_sw_txhdr *cl_sw_txhdr_alloc(struct cl_hw *cl_hw)
+{
+	if (cl_hw->conf->ci_sw_txhdr_pool)
+		return cl_sw_txhdr_alloc_pool(cl_hw);
+	else
+		return cl_sw_txhdr_alloc_cache(cl_hw);
+}
+
+static inline void cl_sw_txhdr_free_pool(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	spin_lock_bh(&cl_hw->lock_sw_txhdr_pool);
+	list_add_tail(&sw_txhdr->list_pool, &cl_hw->head_sw_txhdr_pool);
+	spin_unlock_bh(&cl_hw->lock_sw_txhdr_pool);
+}
+
+static inline void cl_sw_txhdr_free_cache(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	kmem_cache_free(cl_hw->sw_txhdr_cache, sw_txhdr);
+}
+
+void cl_sw_txhdr_free(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	if (cl_hw->conf->ci_sw_txhdr_pool)
+		cl_sw_txhdr_free_pool(cl_hw, sw_txhdr);
+	else
+		cl_sw_txhdr_free_cache(cl_hw, sw_txhdr);
+}
+
+#define CL_AMSDU_HDR_LEN 14
+
+static bool cl_tx_amsdu_is_sw(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			      struct sk_buff *skb, u16 pkt_len)
+{
+	bool syn_rst_push = false;
+	bool tcp_ack = false;
+
+	if (cl_hw->conf->ci_tx_sw_amsdu_max_packets <= 1)
+		return false;
+
+	tcp_ack = cl_is_tcp_ack(skb, &syn_rst_push);
+
+	if (!tcp_ack || syn_rst_push)
+		return false;
+
+	if ((cl_wrs_api_get_tx_sta_data_rate(cl_sta) * cl_sta->ampdu_min_spacing) <=
+	    (pkt_len << 3))
+		return false;
+
+	return true;
+}
+
+static int cl_tx_amsdu_anchor_set(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				  struct sk_buff *skb, u8 tid)
+{
+	/*
+	 * Packet length calculation in HW -
+	 * Add 802.11 header (maximum possible size) instead if 802.3
+	 * Add AMSDU header
+	 * Add RFC1042 header (according to ether-type)
+	 * Add IV and ICV (if there is encryption)
+	 */
+	struct cl_amsdu_ctrl *amsdu_anchor = &cl_sta->amsdu_anchor[tid];
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key_conf = tx_info->control.hw_key;
+	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
+	u16 pkt_len = skb->len + CL_WLAN_HEADER_MAX_SIZE;
+
+	if (key_conf)
+		pkt_len += (key_conf->iv_len + key_conf->icv_len);
+
+	if (ethertype >= ETH_P_802_3_MIN)
+		pkt_len += sizeof(rfc1042_header);
+
+	amsdu_anchor->rem_len = amsdu_anchor->max_len - pkt_len;
+	amsdu_anchor->packet_cnt = 1;
+	amsdu_anchor->is_sw_amsdu = cl_tx_amsdu_is_sw(cl_hw, cl_sta, skb, pkt_len);
+
+	return CL_AMSDU_ANCHOR_SET;
+}
+
+static void cl_tx_amsdu_anchor_umacdesc_update(struct txdesc *txdesc, u8 idx,
+					       u16 len, dma_addr_t dma_addr,
+					       bool is_padding)
+{
+	struct lmacapi *umacdesc = &txdesc->umacdesc;
+
+	umacdesc->packet_len[idx] = cpu_to_le16(len);
+	umacdesc->packet_addr[idx] = cpu_to_le32(dma_addr);
+	txdesc->host_info.packet_cnt++;
+
+	/* Update padding bit of current msdu sub-frame */
+	if (is_padding)
+		txdesc->host_info.host_padding |= BIT(idx);
+}
+
+static struct cl_amsdu_txhdr *cl_tx_amsdu_txhdr_alloc(struct cl_hw *cl_hw)
+{
+	if (cl_hw->conf->ci_amsdu_txhdr_pool) {
+		struct cl_amsdu_txhdr *amsdu_txhdr =
+			list_first_entry_or_null(&cl_hw->head_amsdu_txhdr_pool,
+						 struct cl_amsdu_txhdr,
+						 list_pool);
+
+		if (amsdu_txhdr) {
+			list_del(&amsdu_txhdr->list_pool);
+			return amsdu_txhdr;
+		}
+
+		return NULL;
+	} else {
+		return kmem_cache_alloc(cl_hw->amsdu_txhdr_cache, GFP_ATOMIC);
+	}
+}
+
+static void _cl_tx_amsdu_transfer_single(struct cl_hw *cl_hw,
+					 struct sk_buff *skb,
+					 struct cl_sta *cl_sta,
+					 u8 tid)
+{
+	struct ieee80211_tx_info *tx_info;
+
+	tx_info = IEEE80211_SKB_CB(skb);
+	tx_info->flags &= ~IEEE80211_TX_CTL_AMPDU;
+	tx_info->control.flags &= ~IEEE80211_TX_CTRL_AMSDU;
+
+	if (cl_tx_8023_to_wlan(cl_hw, skb, cl_sta, tid) == 0) {
+		cl_hw->tx_packet_cntr.transfer.agg_to_single++;
+		cl_tx_single(cl_hw, cl_sta, skb, false, false);
+	}
+}
+
+static void cl_tx_amsdu_set_sw_sub_amsdu_hdr(struct sk_buff *skb)
+{
+	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
+	int rfc1042_len = 0;
+	void *data;
+	struct ethhdr *amsdu_hdr;
+
+	if (ethertype >= ETH_P_802_3_MIN)
+		rfc1042_len = sizeof(rfc1042_header);
+
+	data = skb_push(skb, rfc1042_len + 2);
+	memmove(data, data + rfc1042_len + 2, 2 * ETH_ALEN);
+
+	amsdu_hdr = (struct ethhdr *)data;
+	amsdu_hdr->h_proto = cpu_to_be16(skb->len - ETH_HLEN);
+
+	memcpy(data + ETH_HLEN, rfc1042_header, rfc1042_len);
+}
+
+static int cl_tx_amsdu_add_sw_amsdu_hdr(struct cl_hw *cl_hw,
+					struct cl_amsdu_ctrl *amsdu_anchor)
+{
+	struct cl_sw_txhdr *anchor_sw_txhdr = amsdu_anchor->sw_txhdr;
+	struct sk_buff *skb = anchor_sw_txhdr->skb;
+	struct cl_sta *cl_sta = anchor_sw_txhdr->cl_sta;
+	struct ieee80211_hdr hdr;
+	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
+	u16 hdrlen = cl_tx_prepare_wlan_hdr(cl_hw, cl_sta, skb, &hdr);
+	int rfc1042_len = 0;
+	int head_need = 0;
+	u8 enc_len = cl_key_get_cipher_len(skb);
+	u16 qos_ctrl = anchor_sw_txhdr->tid | IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+
+	if (!hdrlen)
+		return -EINVAL;
+
+	if (ethertype >= ETH_P_802_3_MIN)
+		rfc1042_len = sizeof(rfc1042_header);
+
+	amsdu_anchor->hdrlen = hdrlen;
+	head_need = hdrlen + enc_len + rfc1042_len - skb_headroom(skb);
+	if (head_need > 0) {
+		head_need = ((head_need + 3) & ~3);
+		if (pskb_expand_head(skb, head_need, 0, GFP_ATOMIC))
+			return -ENOMEM;
+	}
+
+	cl_tx_amsdu_set_sw_sub_amsdu_hdr(skb);
+
+	skb_push(skb, hdrlen + enc_len);
+	memcpy(skb->data, &hdr, hdrlen - 2);
+	memcpy(skb->data + hdrlen - 2, &qos_ctrl, 2);
+	skb_reset_mac_header(skb);
+	anchor_sw_txhdr->txdesc.e2w_natt_param.hdr_conv_enable = false;
+	anchor_sw_txhdr->hdr80211 = (struct ieee80211_hdr *)skb->data;
+
+	return 0;
+}
+
+static int cl_tx_amsdu_sw_aggregate(struct cl_hw *cl_hw,
+				    struct cl_amsdu_ctrl *amsdu_anchor,
+				    struct sk_buff *skb)
+{
+	struct cl_sw_txhdr *anchor_sw_txhdr = amsdu_anchor->sw_txhdr;
+	struct sk_buff *anchor_skb = anchor_sw_txhdr->skb;
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(anchor_skb);
+	struct ieee80211_key_conf *key_conf = tx_info->control.hw_key;
+	u16 total_frame_len = 0;
+	struct cl_tx_queue *tx_queue = anchor_sw_txhdr->tx_queue;
+	int head_pad = 0;
+	int sub_pad = 0;
+	bool syn_rst_push = false;
+	bool tcp_ack = cl_is_tcp_ack(skb, &syn_rst_push);
+
+	/* Worst case: rfc1042(6) + ET(2) + pad(2) = 10 */
+	if (!tcp_ack ||
+	    (skb_tailroom(anchor_skb) < (skb->len + 10))) {
+		if (tx_queue->num_packets == 1)
+			cl_txq_sched(cl_hw, tx_queue);
+		cl_tx_amsdu_anchor_init(amsdu_anchor);
+		return cl_tx_amsdu_anchor_set(cl_hw, anchor_sw_txhdr->cl_sta,
+					      skb, anchor_sw_txhdr->tid);
+	}
+
+	if (amsdu_anchor->packet_cnt == 1 &&
+	    cl_tx_amsdu_add_sw_amsdu_hdr(cl_hw, amsdu_anchor))
+		return CL_AMSDU_FAILED;
+
+	cl_tx_amsdu_set_sw_sub_amsdu_hdr(skb);
+	sub_pad = CL_SKB_DATA_ALIGN_PADS(anchor_skb->len -
+					 amsdu_anchor->hdrlen);
+	memset(skb_push(skb, sub_pad), 0, sub_pad);
+	memcpy(skb_put(anchor_skb, skb->len), skb->data, skb->len);
+
+	kfree_skb(skb);
+	amsdu_anchor->packet_cnt++;
+	anchor_sw_txhdr->sw_amsdu_packet_cnt++;
+	head_pad = CL_SKB_DATA_ALIGN_PADS(anchor_skb->data);
+
+	if (head_pad) {
+		anchor_sw_txhdr->map_len = anchor_skb->len + head_pad;
+		anchor_sw_txhdr->txdesc.host_info.host_padding |= BIT(0);
+	} else {
+		anchor_sw_txhdr->map_len = anchor_skb->len;
+		anchor_sw_txhdr->txdesc.host_info.host_padding = 0;
+	}
+
+	total_frame_len = anchor_skb->len;
+	if (key_conf)
+		total_frame_len += key_conf->icv_len;
+
+	anchor_sw_txhdr->txdesc.umacdesc.packet_len[0] = cpu_to_le16(total_frame_len);
+
+	if (amsdu_anchor->packet_cnt == cl_hw->conf->ci_tx_sw_amsdu_max_packets ||
+	    syn_rst_push) {
+		if (tx_queue->num_packets == 1)
+			cl_txq_sched(cl_hw, tx_queue);
+		cl_tx_amsdu_anchor_init(amsdu_anchor);
+	}
+
+	return CL_AMSDU_SUB_FRAME_SET;
+}
+
+void cl_tx_amsdu_anchor_init(struct cl_amsdu_ctrl *amsdu_anchor)
+{
+	amsdu_anchor->rem_len = amsdu_anchor->max_len;
+	amsdu_anchor->sw_txhdr = NULL;
+	amsdu_anchor->packet_cnt = 0;
+	amsdu_anchor->is_sw_amsdu = false;
+}
+
+void cl_tx_amsdu_anchor_reset(struct cl_amsdu_ctrl *amsdu_anchor)
+{
+	amsdu_anchor->sw_txhdr = NULL;
+	amsdu_anchor->rem_len = 0;
+	amsdu_anchor->max_len = 0;
+	amsdu_anchor->packet_cnt = 0;
+	amsdu_anchor->is_sw_amsdu = false;
+}
+
+void cl_tx_amsdu_set_max_len(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 tid)
+{
+	struct ieee80211_sta_vht_cap *vht_cap = &cl_sta->sta->vht_cap;
+	struct cl_amsdu_ctrl *amsdu_anchor = &cl_sta->amsdu_anchor[tid];
+	u32 length = U32_MAX;
+
+	amsdu_anchor->max_len = 3839;
+
+	if (cl_band_is_6g(cl_hw)) {
+		u16 capa = le16_to_cpu(cl_sta->sta->he_6ghz_capa.capa);
+
+		length = (capa & IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN) >>
+			HE_6GHZ_CAP_MAX_MPDU_LEN_OFFSET;
+	} else if (vht_cap->vht_supported) {
+		length = vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK;
+	}
+
+	switch (length) {
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
+		amsdu_anchor->max_len = 3895;
+		break;
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
+		amsdu_anchor->max_len = 7991;
+		break;
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
+		amsdu_anchor->max_len = 11454;
+		break;
+	default:
+		break;
+	}
+
+	amsdu_anchor->rem_len = amsdu_anchor->max_len;
+
+	cl_dbg_trace(cl_hw, "AMSDU supported - sta_idx=%u, max_len=%d\n",
+		     cl_sta->sta_idx, amsdu_anchor->max_len);
+}
+
+void cl_tx_amsdu_first_sub_frame(struct cl_sw_txhdr *sw_txhdr, struct cl_sta *cl_sta,
+				 struct sk_buff *skb, u8 tid)
+{
+	/* Set the anchor sw_txhdr */
+	cl_sta->amsdu_anchor[tid].sw_txhdr = sw_txhdr;
+
+	INIT_LIST_HEAD(&sw_txhdr->amsdu_txhdr.list);
+	sw_txhdr->amsdu_txhdr.skb = skb;
+}
+
+void cl_tx_amsdu_flush_sub_frames(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	struct cl_amsdu_txhdr *amsdu_txhdr = NULL, *tmp = NULL;
+	struct sk_buff *sub_skb = NULL;
+
+	/* Free mid & last AMSDU sub frames */
+	list_for_each_entry_safe(amsdu_txhdr, tmp, &sw_txhdr->amsdu_txhdr.list, list) {
+		sub_skb = amsdu_txhdr->skb;
+		list_del(&amsdu_txhdr->list);
+
+		dma_unmap_single(cl_hw->chip->dev, amsdu_txhdr->dma_addr,
+				 (size_t)sub_skb->len, DMA_TO_DEVICE);
+		kfree_skb(sub_skb);
+		cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+		cl_hw->tx_packet_cntr.drop.queue_flush++;
+		sw_txhdr->cl_vif->trfc_cntrs[sw_txhdr->ac].tx_dropped++;
+	}
+
+	/* Free first AMSDU sub frame */
+	kfree_skb(sw_txhdr->skb);
+	cl_sw_txhdr_free(cl_hw, sw_txhdr);
+}
+
+void cl_tx_amsdu_transfer_single(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	/*
+	 * Transfer all skbs in sw_txhdr to a temporary list, free sw_txhdr,
+	 * and then push the temporary list to the single path.
+	 */
+	struct cl_amsdu_txhdr *amsdu_txhdr, *tmp;
+	struct sk_buff *skb;
+	struct cl_sta *cl_sta = sw_txhdr->cl_sta;
+	u8 tid = sw_txhdr->tid;
+
+	/* Transfer first AMSDU sub frame */
+	_cl_tx_amsdu_transfer_single(cl_hw, sw_txhdr->skb, cl_sta, tid);
+
+	/* Transfer mid & last AMSDU sub frames */
+	list_for_each_entry_safe(amsdu_txhdr, tmp, &sw_txhdr->amsdu_txhdr.list, list) {
+		skb = amsdu_txhdr->skb;
+
+		list_del(&amsdu_txhdr->list);
+		dma_unmap_single(cl_hw->chip->dev, amsdu_txhdr->dma_addr,
+				 (size_t)skb->len, DMA_TO_DEVICE);
+		cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+
+		_cl_tx_amsdu_transfer_single(cl_hw, skb, cl_sta, tid);
+	}
+}
+
+int cl_tx_amsdu_set(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb, u8 tid)
+{
+	struct cl_amsdu_ctrl *amsdu_anchor = &cl_sta->amsdu_anchor[tid];
+	struct cl_sw_txhdr *anchor_sw_txhdr = amsdu_anchor->sw_txhdr;
+	u16 packet_len = skb->len;
+	u8 packet_cnt;
+	bool is_mesh = ieee80211_vif_is_mesh(cl_sta->cl_vif->vif);
+	u8 packet_cnt_max = cl_hw->txamsdu_en;
+
+	/* Check if anchor exist */
+	if (!anchor_sw_txhdr) {
+		/* Sanity check - skb len < amsdu_max_len */
+		if (unlikely(packet_len > amsdu_anchor->max_len) || is_mesh)
+			return CL_AMSDU_SKIP;
+		else
+			return cl_tx_amsdu_anchor_set(cl_hw, cl_sta, skb, tid);
+	}
+
+	if (amsdu_anchor->is_sw_amsdu)
+		return cl_tx_amsdu_sw_aggregate(cl_hw, amsdu_anchor, skb);
+
+	/*
+	 * 1. Check if there is enough space in AMSDU
+	 * 2. Check if A-MSDU packet count is less than maximum.
+	 */
+	packet_cnt = amsdu_anchor->packet_cnt;
+
+	if (amsdu_anchor->rem_len > packet_len &&
+	    packet_cnt < packet_cnt_max &&
+	    !is_mesh) {
+		struct cl_amsdu_txhdr *amsdu_txhdr = NULL;
+		u8 hdr_pads = CL_SKB_DATA_ALIGN_PADS(skb->data);
+		u16 ethertype = (skb->data[12] << 8) | skb->data[13];
+		u16 total_packet_len = packet_len + hdr_pads;
+		u16 curr_amsdu_len = amsdu_anchor->max_len - amsdu_anchor->rem_len;
+		dma_addr_t dma_addr;
+
+		if (ethertype >= ETH_P_802_3_MIN)
+			total_packet_len += sizeof(rfc1042_header);
+
+		/*
+		 * High number of MSDUs in AMSDU can cause underrun in the
+		 * E2W module.
+		 * Therefore, host is required to set Num MSDU in AMSDU using
+		 * the following rules
+		 *
+		 * AMSDU Length      AMSDU agg size
+		 * len  < 4*256      3 or less
+		 * len >= 4*256      4 or less
+		 * len >= 5*256      5 or less
+		 * len >= 6*256      6 or less
+		 * len >= 7*256      7 or less
+		 * len >= 8*256      8 or less
+		 */
+		if (packet_cnt >= CL_AMSDU_MIN_AGG_SIZE) {
+			u16 new_amsdu_len = curr_amsdu_len + packet_len;
+
+			if (new_amsdu_len < ((packet_cnt + 1) * CL_AMSDU_CONST_LEN))
+				return cl_tx_amsdu_anchor_set(cl_hw, cl_sta, skb, tid);
+		}
+
+		amsdu_txhdr = cl_tx_amsdu_txhdr_alloc(cl_hw);
+		if (unlikely(!amsdu_txhdr)) {
+			kfree_skb(skb);
+			cl_dbg_err(cl_hw, "AMSDU FAILED to alloc amsdu txhdr\n");
+			cl_hw->tx_packet_cntr.drop.amsdu_alloc_fail++;
+			cl_sta->cl_vif->trfc_cntrs[anchor_sw_txhdr->ac].tx_errors++;
+			return CL_AMSDU_FAILED;
+		}
+
+		amsdu_txhdr->skb = skb;
+		list_add_tail(&amsdu_txhdr->list, &anchor_sw_txhdr->amsdu_txhdr.list);
+
+		/* Update anchor fields */
+		amsdu_anchor->rem_len -= total_packet_len;
+		amsdu_anchor->packet_cnt++;
+
+		/* Get DMA address for skb */
+		dma_addr = dma_map_single(cl_hw->chip->dev, (u8 *)skb->data - hdr_pads,
+					  packet_len + hdr_pads, DMA_TO_DEVICE);
+		if (WARN_ON(dma_mapping_error(cl_hw->chip->dev, dma_addr))) {
+			kfree_skb(skb);
+			cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+			cl_dbg_err(cl_hw, "dma_mapping_error\n");
+			cl_hw->tx_packet_cntr.drop.amsdu_dma_map_err++;
+			cl_sta->cl_vif->trfc_cntrs[anchor_sw_txhdr->ac].tx_errors++;
+			return CL_AMSDU_FAILED;
+		}
+
+		/* Add AMSDU HDR len of the first packet */
+		if (amsdu_anchor->packet_cnt == 2)
+			total_packet_len += CL_AMSDU_HDR_LEN;
+
+		amsdu_txhdr->dma_addr = dma_addr;
+
+		/* Update sw_txhdr packet_len, packet_addr, packet_cnt fields */
+		cl_tx_amsdu_anchor_umacdesc_update(&anchor_sw_txhdr->txdesc, packet_cnt,
+						   packet_len, dma_addr, hdr_pads);
+
+		/* If we reached max AMSDU payload count, mark anchor as NULL */
+		if (amsdu_anchor->packet_cnt >= packet_cnt_max)
+			cl_tx_amsdu_anchor_init(amsdu_anchor);
+
+		return CL_AMSDU_SUB_FRAME_SET;
+	}
+	/* Not enough space remain, set new anchor length is ok */
+	if (unlikely(packet_len > amsdu_anchor->max_len) || is_mesh) {
+		cl_tx_amsdu_anchor_init(amsdu_anchor);
+		return CL_AMSDU_SKIP;
+	} else {
+		return cl_tx_amsdu_anchor_set(cl_hw, cl_sta, skb, tid);
+	}
+}
+
+void cl_tx_amsdu_unset(struct cl_sw_txhdr *sw_txhdr)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+
+	tx_info->control.flags &= ~IEEE80211_TX_CTRL_AMSDU;
+
+	sw_txhdr->txdesc.e2w_txhdr_param.qos_ctrl &=
+				~cpu_to_le16(IEEE80211_QOS_CTL_A_MSDU_PRESENT);
+}
+
+/*
+ * Two options for allocating cl_amsdu_txhdr:
+ * 1) pool
+ * 2) cache
+ */
+
+static int cl_tx_amsdu_txhdr_init_pool(struct cl_hw *cl_hw)
+{
+	u16 amsdu_txhdr_pool = cl_hw->conf->ci_amsdu_txhdr_pool;
+	u32 i = 0;
+	u32 amsdu_txhdr_pool_size = amsdu_txhdr_pool * sizeof(struct cl_amsdu_txhdr);
+	struct cl_amsdu_txhdr *amsdu_txhdr;
+
+	INIT_LIST_HEAD(&cl_hw->head_amsdu_txhdr_pool);
+
+	for (i = 0; i < amsdu_txhdr_pool; i++) {
+		amsdu_txhdr = kzalloc(sizeof(*amsdu_txhdr), GFP_ATOMIC);
+
+		if (unlikely(!amsdu_txhdr)) {
+			cl_dbg_err(cl_hw, "amsdu_txhdr NULL\n");
+			return -1;
+		}
+
+		list_add(&amsdu_txhdr->list_pool, &cl_hw->head_amsdu_txhdr_pool);
+	}
+
+	cl_dbg_verbose(cl_hw, " - pool %u, size %u\n",
+		       amsdu_txhdr_pool, amsdu_txhdr_pool_size);
+
+	return 0;
+}
+
+static int cl_tx_amsdu_txhdr_init_cache(struct cl_hw *cl_hw)
+{
+	char amsdu_txhdr_cache_name[MODULE_NAME_LEN + 32] = {0};
+
+	snprintf(amsdu_txhdr_cache_name, sizeof(amsdu_txhdr_cache_name),
+		 "%s_amsdu_txhdr_cache", THIS_MODULE->name);
+
+	cl_hw->amsdu_txhdr_cache = kmem_cache_create(amsdu_txhdr_cache_name,
+						     sizeof(struct cl_amsdu_txhdr),
+						     0,
+						     (SLAB_HWCACHE_ALIGN | SLAB_PANIC),
+						     NULL);
+
+	if (!cl_hw->amsdu_txhdr_cache) {
+		cl_dbg_err(cl_hw, "amsdu_txhdr_cache NULL\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+int cl_tx_amsdu_txhdr_init(struct cl_hw *cl_hw)
+{
+	if (cl_hw->conf->ci_amsdu_txhdr_pool)
+		return cl_tx_amsdu_txhdr_init_pool(cl_hw);
+	else
+		return cl_tx_amsdu_txhdr_init_cache(cl_hw);
+}
+
+static void cl_tx_amsdu_txhdr_deinit_pool(struct cl_hw *cl_hw)
+{
+	struct cl_amsdu_txhdr *amsdu_txhdr, *tmp;
+
+	list_for_each_entry_safe(amsdu_txhdr, tmp, &cl_hw->head_amsdu_txhdr_pool, list_pool) {
+		list_del(&amsdu_txhdr->list_pool);
+		kfree(amsdu_txhdr);
+	}
+}
+
+static void cl_tx_amsdu_txhdr_deinit_cache(struct cl_hw *cl_hw)
+{
+	kmem_cache_destroy(cl_hw->amsdu_txhdr_cache);
+}
+
+void cl_tx_amsdu_txhdr_deinit(struct cl_hw *cl_hw)
+{
+	if (cl_hw->conf->ci_amsdu_txhdr_pool)
+		cl_tx_amsdu_txhdr_deinit_pool(cl_hw);
+	else
+		cl_tx_amsdu_txhdr_deinit_cache(cl_hw);
+}
+
+void cl_tx_amsdu_txhdr_free(struct cl_hw *cl_hw, struct cl_amsdu_txhdr *amsdu_txhdr)
+{
+	if (cl_hw->conf->ci_amsdu_txhdr_pool)
+		list_add_tail(&amsdu_txhdr->list_pool, &cl_hw->head_amsdu_txhdr_pool);
+	else
+		kmem_cache_free(cl_hw->amsdu_txhdr_cache, amsdu_txhdr);
+}
+
+static const u8 cl_tid2hwq[IEEE80211_NUM_TIDS] = {
+	CL_HWQ_BE,
+	CL_HWQ_BK,
+	CL_HWQ_BK,
+	CL_HWQ_BE,
+	CL_HWQ_VI,
+	CL_HWQ_VI,
+	CL_HWQ_VO,
+	CL_HWQ_VO,
+	/* At the moment, all others TID are mapped to BE */
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+	CL_HWQ_BE,
+};
+
+static void cl_txq_sched_list_add(struct cl_tx_queue *tx_queue, struct cl_hw *cl_hw)
+{
+	/* Add to schedule queue */
+	if (tx_queue->sched)
+		return;
+
+	tx_queue->sched = true;
+	if (tx_queue->type == QUEUE_TYPE_AGG)
+		list_add_tail(&tx_queue->sched_list, &cl_hw->list_sched_q_agg);
+	else
+		list_add_tail(&tx_queue->sched_list, &cl_hw->list_sched_q_single);
+}
+
+static void cl_txq_sched_list_remove(struct cl_tx_queue *tx_queue)
+{
+	/* Remove from schedule queue */
+	if (tx_queue->sched) {
+		tx_queue->sched = false;
+		list_del(&tx_queue->sched_list);
+	}
+}
+
+static void cl_txq_sched_list_remove_if_empty(struct cl_tx_queue *tx_queue)
+{
+	/* If queue is empty remove it from schedule list */
+	if (list_empty(&tx_queue->hdrs))
+		cl_txq_sched_list_remove(tx_queue);
+}
+
+static void cl_txq_transfer_single_to_agg(struct cl_hw *cl_hw,
+					  struct cl_tx_queue *single_queue,
+					  struct cl_tx_queue *agg_queue, u8 tid)
+{
+	struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+	struct ieee80211_tx_info *tx_info;
+	struct sk_buff *skb;
+	u8 hdr_pads;
+
+	spin_lock_bh(&cl_hw->tx_lock_single);
+
+	if (single_queue->num_packets == 0)
+		goto out;
+
+	list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &single_queue->hdrs, tx_queue_list) {
+		if (sw_txhdr->tid != tid)
+			continue;
+
+		if (!ieee80211_is_data_qos(sw_txhdr->fc))
+			continue;
+
+		cl_hw->tx_packet_cntr.transfer.single_to_agg++;
+
+		/* Remove from single queue */
+		list_del(&sw_txhdr->tx_queue_list);
+
+		/* Update single queue counters */
+		single_queue->num_packets--;
+		single_queue->total_packets--;
+
+		/* Turn on AMPDU flag */
+		skb = sw_txhdr->skb;
+		tx_info = IEEE80211_SKB_CB(skb);
+		tx_info->flags |= IEEE80211_TX_CTL_AMPDU;
+
+		/* Convert header back and Push skb to agg queue */
+		cl_tx_wlan_to_8023(skb);
+		hdr_pads = CL_SKB_DATA_ALIGN_PADS(skb->data);
+		cl_tx_agg_prep(cl_hw, sw_txhdr, skb->len, hdr_pads, true);
+		agg_queue->total_packets++;
+		sw_txhdr->hdr80211 = NULL;
+		sw_txhdr->tx_queue = agg_queue;
+		cl_txq_push(cl_hw, sw_txhdr);
+
+		/* Schedule tasklet to try and empty the queue */
+		tasklet_schedule(&cl_hw->tx_task);
+	}
+
+	/* If single queue is empty remove it from schedule list */
+	cl_txq_sched_list_remove_if_empty(single_queue);
+
+out:
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_delete_packets(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue, u8 sta_idx)
+{
+	struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+
+	list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &tx_queue->hdrs, tx_queue_list) {
+		/*
+		 * Brodcast frames do not have cl_sta and should not be
+		 * deleted at station remove sequence.
+		 */
+		if (!sw_txhdr->cl_sta)
+			continue;
+
+		if (sw_txhdr->sta_idx != sta_idx)
+			continue;
+
+		list_del(&sw_txhdr->tx_queue_list);
+		tx_queue->num_packets--;
+
+		cl_tx_single_free_skb(cl_hw, sw_txhdr->skb);
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+	}
+
+	/* If queue is empty remove it from schedule list */
+	cl_txq_sched_list_remove_if_empty(tx_queue);
+}
+
+static void cl_txq_reset_counters(struct cl_tx_queue *tx_queue)
+{
+	tx_queue->total_fw_push_desc = 0;
+	tx_queue->total_fw_push_skb = 0;
+	tx_queue->total_fw_cfm = 0;
+	tx_queue->total_packets = 0;
+	tx_queue->dump_queue_full = 0;
+	tx_queue->dump_dma_map_fail = 0;
+
+	memset(tx_queue->stats_hw_amsdu_cnt, 0,
+	       sizeof(tx_queue->stats_hw_amsdu_cnt));
+
+	memset(tx_queue->stats_sw_amsdu_cnt, 0,
+	       sizeof(tx_queue->stats_sw_amsdu_cnt));
+}
+
+static void cl_txq_flush(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue)
+{
+	struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+	struct ieee80211_tx_info *tx_info;
+
+	if (tx_queue->num_packets == 0)
+		return;
+
+	list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &tx_queue->hdrs, tx_queue_list) {
+		list_del(&sw_txhdr->tx_queue_list);
+		tx_queue->num_packets--;
+
+		/* Can not send AMSDU frames as singles */
+		tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+
+		/* Free mid & last AMSDU sub frames */
+		if (cl_tx_ctrl_is_amsdu(tx_info)) {
+			cl_tx_amsdu_flush_sub_frames(cl_hw, sw_txhdr);
+		} else {
+			if (tx_queue->type == QUEUE_TYPE_SINGLE)
+				cl_tx_single_free_skb(cl_hw, sw_txhdr->skb);
+			else
+				kfree_skb(sw_txhdr->skb);
+
+			cl_hw->tx_packet_cntr.drop.queue_flush++;
+			sw_txhdr->cl_vif->trfc_cntrs[sw_txhdr->ac].tx_dropped++;
+			cl_sw_txhdr_free(cl_hw, sw_txhdr);
+		}
+	}
+
+	/* Remove from schedule queue */
+	cl_txq_sched_list_remove(tx_queue);
+
+	/* Sanity check that queue is empty */
+	WARN_ON(tx_queue->num_packets > 0);
+}
+
+static void cl_txq_agg_size_set(struct cl_hw *cl_hw)
+{
+	struct cl_tx_queue *tx_queue = NULL;
+	u16 new_size = 0;
+	u16 drv_max_size = 0;
+	int i = 0;
+	int j = 0;
+
+	if (!cl_hw->used_agg_queues || !cl_hw->conf->ci_tx_packet_limit)
+		return;
+
+	new_size = cl_hw->conf->ci_tx_packet_limit / cl_hw->used_agg_queues;
+	drv_max_size = max(new_size, cl_hw->conf->ci_tx_queue_size_agg);
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++) {
+		tx_queue = &cl_hw->tx_queues->agg[i];
+
+		if (!tx_queue->cl_sta)
+			continue;
+
+		tx_queue->max_packets = drv_max_size;
+
+		j++;
+		if (j == cl_hw->used_agg_queues)
+			break;
+	}
+
+	cl_dbg_trace(cl_hw, "drv_max_size = %u\n", drv_max_size);
+}
+
+static int cl_txq_request_find(struct cl_hw *cl_hw, u8 sta_idx, u8 tid)
+{
+	int i = 0;
+	struct cl_req_agg_db *req_agg_db = NULL;
+	u8 req_agg_queues = 0;
+
+	for (i = 0; (i < IPC_MAX_BA_SESSIONS) && (req_agg_queues < cl_hw->req_agg_queues); i++) {
+		req_agg_db = &cl_hw->req_agg_db[i];
+
+		if (!req_agg_db->is_used)
+			continue;
+
+		req_agg_queues++;
+
+		if (sta_idx == req_agg_db->sta_idx && tid == req_agg_db->tid)
+			return i;
+	}
+
+	return -1;
+}
+
+static void cl_txq_push_cntrs_update(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue,
+				     u32 orig_drv_cnt, u32 orig_fw_cnt)
+{
+	u32 total_pushed;
+	u32 idx;
+
+	if (!cl_hw->conf->ci_tx_push_cntrs_stat_en)
+		return;
+
+	total_pushed = orig_drv_cnt - tx_queue->num_packets;
+	idx = tx_queue->push_cntrs_db.tx_push_logger_idx % TX_PUSH_LOGGER_SIZE;
+	tx_queue->push_cntrs_db.tx_push_cntr_hist[total_pushed]++;
+	tx_queue->push_cntrs_db.tx_push_logger[idx][TX_PUSH_LOGGER_DRV_CNT] = orig_drv_cnt;
+	tx_queue->push_cntrs_db.tx_push_logger[idx][TX_PUSH_LOGGER_FW_CNT] = orig_fw_cnt;
+	tx_queue->push_cntrs_db.tx_push_logger[idx][TX_PUSH_LOGGER_PKT_PUSHED] = total_pushed;
+	++tx_queue->push_cntrs_db.tx_push_logger_idx;
+}
+
+static void cl_txq_task_single(struct cl_hw *cl_hw)
+{
+	/* Schedule single queues */
+	struct cl_tx_queue *tx_queue, *tx_queue_tmp;
+
+	spin_lock(&cl_hw->tx_lock_single);
+
+	list_for_each_entry_safe(tx_queue, tx_queue_tmp, &cl_hw->list_sched_q_single, sched_list)
+		cl_txq_sched(cl_hw, tx_queue);
+
+	/* Rotate the queue so next schedule will start with a different queue */
+	list_rotate_left(&cl_hw->list_sched_q_single);
+
+	spin_unlock(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_task_agg(struct cl_hw *cl_hw)
+{
+	/* Schedule agg queueus */
+	struct cl_tx_queue *tx_queue, *tx_queue_tmp;
+
+	spin_lock(&cl_hw->tx_lock_agg);
+
+	list_for_each_entry_safe(tx_queue, tx_queue_tmp, &cl_hw->list_sched_q_agg, sched_list)
+		cl_txq_sched(cl_hw, tx_queue);
+
+	/* Rotate the queue so next schedule will start with a different queue */
+	list_rotate_left(&cl_hw->list_sched_q_agg);
+
+	spin_unlock(&cl_hw->tx_lock_agg);
+}
+
+static void cl_txq_task(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+
+	cl_txq_task_single(cl_hw);
+	cl_txq_task_agg(cl_hw);
+}
+
+static void cl_txq_agg_inc_usage_cntr(struct cl_hw *cl_hw)
+{
+	/* Should be called in cl_hw->tx_lock_agg context */
+	cl_hw->used_agg_queues++;
+	cl_txq_agg_size_set(cl_hw);
+}
+
+static void cl_txq_agg_dec_usage_cntr(struct cl_hw *cl_hw)
+{
+	/* Should be called in cl_hw->tx_lock_agg context */
+	WARN_ON_ONCE(cl_hw->used_agg_queues == 0);
+
+	cl_hw->used_agg_queues--;
+	cl_txq_agg_size_set(cl_hw);
+}
+
+static void cl_txq_init_single(struct cl_hw *cl_hw)
+{
+	struct cl_tx_queue *tx_queue;
+	u32 i;
+
+	spin_lock_bh(&cl_hw->tx_lock_single);
+
+	INIT_LIST_HEAD(&cl_hw->list_sched_q_single);
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++) {
+		tx_queue = &cl_hw->tx_queues->single[i];
+		memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+		INIT_LIST_HEAD(&tx_queue->hdrs);
+		tx_queue->hw_index = i / FW_MAX_NUM_STA;
+		tx_queue->fw_max_size = IPC_TXDESC_CNT_SINGLE;
+		tx_queue->fw_free_space = IPC_TXDESC_CNT_SINGLE;
+		tx_queue->index = i;
+		tx_queue->max_packets = cl_hw->conf->ci_tx_queue_size_single;
+		tx_queue->type = QUEUE_TYPE_SINGLE;
+	}
+
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_init_bcmc(struct cl_hw *cl_hw)
+{
+	struct cl_tx_queue *tx_queue;
+
+	spin_lock_bh(&cl_hw->tx_lock_bcmc);
+
+	tx_queue = &cl_hw->tx_queues->bcmc;
+	memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+	INIT_LIST_HEAD(&tx_queue->hdrs);
+	tx_queue->hw_index = CL_HWQ_BCN;
+	tx_queue->fw_max_size = IPC_TXDESC_CNT_BCMC;
+	tx_queue->fw_free_space = IPC_TXDESC_CNT_BCMC;
+	tx_queue->index = 0;
+	tx_queue->max_packets = 0;
+	tx_queue->type = QUEUE_TYPE_BCMC;
+
+	spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+}
+
+static void cl_txq_init_agg(struct cl_hw *cl_hw)
+{
+	spin_lock_bh(&cl_hw->tx_lock_agg);
+	INIT_LIST_HEAD(&cl_hw->list_sched_q_agg);
+	spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+static void cl_txq_agg_request_reset(struct cl_hw *cl_hw)
+{
+	cl_hw->req_agg_queues = 0;
+	memset(cl_hw->req_agg_db, 0, sizeof(cl_hw->req_agg_db));
+}
+
+void cl_txq_init(struct cl_hw *cl_hw)
+{
+	tasklet_init(&cl_hw->tx_task, cl_txq_task, (unsigned long)cl_hw);
+
+	cl_txq_agg_request_reset(cl_hw);
+	cl_txq_init_single(cl_hw);
+	cl_txq_init_bcmc(cl_hw);
+	cl_txq_init_agg(cl_hw);
+}
+
+void cl_txq_stop(struct cl_hw *cl_hw)
+{
+	tasklet_kill(&cl_hw->tx_task);
+}
+
+struct cl_tx_queue *cl_txq_get(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	struct cl_sta *cl_sta = sw_txhdr->cl_sta;
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+	u8 hw_queue = sw_txhdr->hw_queue;
+
+	if (!cl_sta &&
+	    hw_queue == CL_HWQ_VO &&
+	    is_multicast_ether_addr(sw_txhdr->hdr80211->addr1)) {
+		/*
+		 * If HW queue is VO and packet is multicast, it was not buffered
+		 * by mac80211, and it should be pushed to the high-priority queue
+		 * and not to the bcmc queue.
+		 */
+		return &cl_hw->tx_queues->single[HIGH_PRIORITY_QUEUE];
+	} else if (!cl_sta &&
+		   (hw_queue != CL_HWQ_BCN) &&
+		   !(tx_info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER)) {
+		/*
+		 * If station is NULL, but HW queue is not BCN,
+		 * it most go to the high-priority queue.
+		 */
+		tx_info->flags |= IEEE80211_TX_CTL_NO_PS_BUFFER;
+		sw_txhdr->hw_queue = CL_HWQ_VO;
+		return &cl_hw->tx_queues->single[HIGH_PRIORITY_QUEUE];
+	} else if (cl_sta && (tx_info->flags & IEEE80211_TX_CTL_AMPDU)) {
+		/* Agg packet */
+		return cl_sta->agg_tx_queues[sw_txhdr->tid];
+	} else if (hw_queue == CL_HWQ_BCN) {
+		return &cl_hw->tx_queues->bcmc;
+	} else if (tx_info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER) {
+		/*
+		 * Only frames that are power save response or non-bufferable MMPDU
+		 * will have this flag set our driver will push those frame to the
+		 * highiest priority queue.
+		 */
+		return &cl_hw->tx_queues->single[HIGH_PRIORITY_QUEUE];
+	}
+
+	return &cl_hw->tx_queues->single[QUEUE_IDX(sw_txhdr->sta_idx, hw_queue)];
+}
+
+void cl_txq_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+	struct cl_tx_queue *tx_queue = sw_txhdr->tx_queue;
+
+	if (tx_queue->num_packets < tx_queue->max_packets) {
+		tx_queue->num_packets++;
+
+		/*
+		 * This prioritization of action frames helps Samsung Galaxy Note 8 to
+		 * open BA session more easily, when phy dev is PHY_DEV_OLYMPUS
+		 * and helps open BA on all system emulators
+		 */
+		if (ieee80211_is_action(sw_txhdr->fc) && !IS_REAL_PHY(cl_hw->chip))
+			list_add(&sw_txhdr->tx_queue_list, &tx_queue->hdrs);
+		else
+			list_add_tail(&sw_txhdr->tx_queue_list, &tx_queue->hdrs);
+
+		/* If it is the first packet in the queue, add the queue to the sched list */
+		cl_txq_sched_list_add(tx_queue, cl_hw);
+	} else {
+		struct cl_sta *cl_sta = sw_txhdr->cl_sta;
+		u8 tid = sw_txhdr->tid;
+
+		/* If the SW queue full, release the packet */
+		tx_queue->dump_queue_full++;
+
+		if (cl_sta && cl_sta->amsdu_anchor[tid].sw_txhdr) {
+			if (cl_sta->amsdu_anchor[tid].sw_txhdr == sw_txhdr) {
+				cl_sta->amsdu_anchor[tid].sw_txhdr = NULL;
+				cl_sta->amsdu_anchor[tid].packet_cnt = 0;
+			}
+		}
+
+		dev_kfree_skb_any(sw_txhdr->skb);
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+
+		/* Schedule tasklet to try and empty the queue */
+		tasklet_schedule(&cl_hw->tx_task);
+	}
+}
+
+void cl_txq_sched(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue)
+{
+	struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+	u32 orig_drv_cnt = tx_queue->num_packets;
+	u32 orig_fw_cnt = cl_txq_desc_in_fw(tx_queue);
+	struct cl_sta *cl_sta = tx_queue->cl_sta;
+
+	if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+	    cl_hw->tx_disable_flags ||
+	    cl_txq_is_fw_full(tx_queue) ||
+	    (cl_sta && cl_sta->pause_tx))
+		return;
+
+	/* Go over all descriptors in queue */
+	list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &tx_queue->hdrs, tx_queue_list) {
+		list_del(&sw_txhdr->tx_queue_list);
+		tx_queue->num_packets--;
+
+		if (cl_hw->tx_db.force_amsdu &&
+		    sw_txhdr->txdesc.host_info.packet_cnt < cl_hw->txamsdu_en)
+			break;
+
+		cl_tx_push(cl_hw, sw_txhdr, tx_queue);
+
+		if (cl_txq_is_fw_full(tx_queue))
+			break;
+	}
+
+	cl_txq_push_cntrs_update(cl_hw, tx_queue, orig_drv_cnt, orig_fw_cnt);
+
+	/* If queue is empty remove it from schedule list */
+	cl_txq_sched_list_remove_if_empty(tx_queue);
+}
+
+void cl_txq_agg_alloc(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		      struct mm_ba_add_cfm *ba_add_cfm, u16 buf_size)
+{
+	u8 tid = ba_add_cfm->tid;
+	u8 fw_agg_idx = ba_add_cfm->agg_idx;
+	u8 sta_idx = cl_sta->sta_idx;
+	u8 ac = cl_tid2hwq[tid];
+	u16 single_queue_idx = QUEUE_IDX(sta_idx, ac);
+	struct cl_tx_queue *tx_queue = &cl_hw->tx_queues->agg[fw_agg_idx];
+
+	spin_lock_bh(&cl_hw->tx_lock_agg);
+
+	/* Init aggregated queue struct */
+	memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+	INIT_LIST_HEAD(&tx_queue->hdrs);
+
+	/*
+	 * Firmware agg queues size is static and set to 512, so that for the worst
+	 * case of HE stations,that support AMPDU of 256, it has room for two full
+	 * aggregation.
+	 * To keep this logic, of room for two aggregations, for non-HE stations, or
+	 * for HE stations that do not support AMPDU of 256, we initialize fw_max_size
+	 to twice the buffer size supported by the station.
+	 */
+	tx_queue->fw_max_size = min_t(u16, TXDESC_AGG_Q_SIZE_MAX, buf_size * 2);
+	tx_queue->fw_free_space = tx_queue->fw_max_size;
+
+	tx_queue->max_packets = cl_hw->conf->ci_tx_queue_size_agg;
+	tx_queue->hw_index = ac;
+	tx_queue->cl_sta = cl_sta;
+	tx_queue->type = QUEUE_TYPE_AGG;
+	tx_queue->tid = tid;
+	tx_queue->index = fw_agg_idx;
+
+	/* Reset the synchronization counters between the fw and the IPC layer */
+	cl_hw->ipc_env->ring_indices_elem->indices->txdesc_write_idx.agg[fw_agg_idx] = 0;
+
+	/* Attach the cl_hw chosen queue to the station and agg queues DB */
+	cl_sta->agg_tx_queues[tid] = tx_queue;
+	cl_agg_cfm_set_tx_queue(cl_hw, tx_queue, fw_agg_idx);
+
+	/* Notify upper mac80211 layer of queues resources status */
+	cl_txq_agg_inc_usage_cntr(cl_hw);
+	cl_txq_agg_request_del(cl_hw, sta_idx, tid);
+
+	/*
+	 * Move the qos descriptors to the new allocated aggregated queues,
+	 * otherwise we might reorder packets)
+	 */
+	cl_txq_transfer_single_to_agg(cl_hw, &cl_hw->tx_queues->single[single_queue_idx],
+				      tx_queue, tid);
+	/* Move the BA window pending packets to agg path */
+	cl_baw_pending_to_agg(cl_hw, cl_sta, tid);
+
+	spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+	cl_dbg_trace(cl_hw, "Allocate queue [%u] to station [%u] tid [%u]\n",
+		     fw_agg_idx, sta_idx, tid);
+}
+
+void cl_txq_agg_free(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue,
+		     struct cl_sta *cl_sta, u8 tid)
+{
+	spin_lock_bh(&cl_hw->tx_lock_agg);
+
+	cl_dbg_trace(cl_hw, "Free queue [%u] of station [%u] tid [%u]\n",
+		     tx_queue->index, cl_sta->sta_idx, tid);
+
+	memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+
+	cl_txq_agg_dec_usage_cntr(cl_hw);
+
+	spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+void cl_txq_agg_stop(struct cl_sta *cl_sta, u8 tid)
+{
+	cl_sta->agg_tx_queues[tid] = NULL;
+}
+
+void cl_txq_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	/* Set cl_sta field for all single queues of this station */
+	u8 ac;
+	u16 queue_idx;
+
+	for (ac = 0; ac < AC_MAX; ac++) {
+		queue_idx = QUEUE_IDX(cl_sta->sta_idx, ac);
+		cl_hw->tx_queues->single[queue_idx].cl_sta = cl_sta;
+	}
+
+	/* Reset pointers to TX agg queues */
+	memset(cl_sta->agg_tx_queues, 0, sizeof(cl_sta->agg_tx_queues));
+}
+
+void cl_txq_sta_remove(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	/* Clear cl_sta field for all single queues of this station */
+	u8 ac;
+	u16 queue_idx;
+
+	for (ac = 0; ac < AC_MAX; ac++) {
+		queue_idx = QUEUE_IDX(sta_idx, ac);
+		cl_hw->tx_queues->single[queue_idx].cl_sta = NULL;
+	}
+}
+
+void cl_txq_transfer_agg_to_single(struct cl_hw *cl_hw, struct cl_tx_queue *agg_queue)
+{
+	/*
+	 * 1) Remove from aggregation queue
+	 * 2) Free sw_txhdr
+	 * 3) Push to single queue
+	 */
+	struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+	struct sk_buff *skb;
+	struct ieee80211_tx_info *tx_info;
+	struct cl_tx_queue *single_queue;
+	struct cl_sta *cl_sta = agg_queue->cl_sta;
+	u16 single_queue_idx = 0;
+
+	if (agg_queue->num_packets == 0)
+		return;
+
+	single_queue_idx = QUEUE_IDX(cl_sta->sta_idx, agg_queue->hw_index);
+	single_queue = &cl_hw->tx_queues->single[single_queue_idx];
+
+	list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &agg_queue->hdrs, tx_queue_list) {
+		list_del(&sw_txhdr->tx_queue_list);
+		agg_queue->num_packets--;
+
+		skb = sw_txhdr->skb;
+		tx_info = IEEE80211_SKB_CB(skb);
+
+		if (cl_tx_ctrl_is_amsdu(tx_info)) {
+			cl_tx_amsdu_transfer_single(cl_hw, sw_txhdr);
+		} else {
+			tx_info->flags &= ~IEEE80211_TX_CTL_AMPDU;
+
+			if (cl_tx_8023_to_wlan(cl_hw, skb, cl_sta, sw_txhdr->tid) == 0) {
+				cl_hw->tx_packet_cntr.transfer.agg_to_single++;
+				cl_tx_single(cl_hw, cl_sta, skb, false, false);
+			}
+		}
+
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+	}
+
+	/* If queue is empty remove it from schedule list */
+	cl_txq_sched_list_remove_if_empty(agg_queue);
+}
+
+void cl_txq_flush_agg(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue, bool lock)
+{
+	if (lock) {
+		spin_lock_bh(&cl_hw->tx_lock_agg);
+		cl_txq_flush(cl_hw, tx_queue);
+		spin_unlock_bh(&cl_hw->tx_lock_agg);
+	} else {
+		cl_txq_flush(cl_hw, tx_queue);
+	}
+}
+
+void cl_txq_flush_all_agg(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++)
+		cl_txq_flush(cl_hw, &cl_hw->tx_queues->agg[i]);
+}
+
+void cl_txq_flush_all_single(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++)
+		cl_txq_flush(cl_hw, &cl_hw->tx_queues->single[i]);
+}
+
+void cl_txq_flush_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	int i = 0;
+	u8 sta_idx = cl_sta->sta_idx;
+	u32 queue_idx = 0;
+	struct cl_tx_queue *tx_queue = NULL;
+
+	spin_lock_bh(&cl_hw->tx_lock_agg);
+
+	/* Flush all aggregation queues for this station */
+	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
+		if (cl_sta->agg_tx_queues[i])
+			cl_txq_flush(cl_hw, cl_sta->agg_tx_queues[i]);
+
+	spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+	spin_lock_bh(&cl_hw->tx_lock_single);
+
+	/* Flush all single queues for this station */
+	for (i = 0; i < AC_MAX; i++) {
+		queue_idx = QUEUE_IDX(sta_idx, i);
+		tx_queue = &cl_hw->tx_queues->single[queue_idx];
+		cl_txq_flush(cl_hw, tx_queue);
+		cl_txq_reset_counters(tx_queue);
+	}
+
+	/* Go over high prioirty queue and delete packets belonging to this station */
+	cl_txq_delete_packets(cl_hw, &cl_hw->tx_queues->single[HIGH_PRIORITY_QUEUE], sta_idx);
+
+	spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_txq_agg_request_add(struct cl_hw *cl_hw, u8 sta_idx, u8 tid)
+{
+	int i = cl_txq_request_find(cl_hw, sta_idx, tid);
+	struct cl_req_agg_db *req_agg_db = NULL;
+
+	if (i != -1) {
+		cl_dbg_trace(cl_hw, "ALREADY_ADDED - entry = %d, sta_idx = %u, tid = %u\n",
+			     i, sta_idx, tid);
+		return;
+	}
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++) {
+		req_agg_db = &cl_hw->req_agg_db[i];
+
+		if (!req_agg_db->is_used) {
+			cl_dbg_trace(cl_hw, "ADD - entry = %d, sta_idx = %u, tid = %u\n",
+				     i, sta_idx, tid);
+			req_agg_db->is_used = true;
+			req_agg_db->sta_idx = sta_idx;
+			req_agg_db->tid = tid;
+			cl_hw->req_agg_queues++;
+			return;
+		}
+	}
+}
+
+void cl_txq_agg_request_del(struct cl_hw *cl_hw, u8 sta_idx, u8 tid)
+{
+	int i = cl_txq_request_find(cl_hw, sta_idx, tid);
+
+	if (i != -1) {
+		cl_dbg_trace(cl_hw, "DEL - entry = %d, sta_idx = %u, tid = %u\n",
+			     i, sta_idx, tid);
+		cl_hw->req_agg_db[i].is_used = false;
+		cl_hw->req_agg_queues--;
+	}
+}
+
+bool cl_txq_is_agg_available(struct cl_hw *cl_hw)
+{
+	u8 total_agg_queues = cl_hw->used_agg_queues + cl_hw->req_agg_queues;
+
+	return (total_agg_queues < IPC_MAX_BA_SESSIONS);
+}
+
+bool cl_txq_is_fw_empty(struct cl_tx_queue *tx_queue)
+{
+	return (tx_queue->fw_free_space == tx_queue->fw_max_size);
+}
+
+bool cl_txq_is_fw_full(struct cl_tx_queue *tx_queue)
+{
+	return (tx_queue->fw_free_space == 0);
+}
+
+u16 cl_txq_desc_in_fw(struct cl_tx_queue *tx_queue)
+{
+	return (tx_queue->fw_max_size - tx_queue->fw_free_space);
+}
+
+bool cl_txq_frames_pending(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	/* Check if we have multicast/bradcast frame in FW queues */
+	if (!cl_txq_is_fw_empty(&cl_hw->tx_queues->bcmc))
+		return true;
+
+	/* Check if we have singles frame in FW queues */
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++)
+		if (!cl_txq_is_fw_empty(&cl_hw->tx_queues->single[i]))
+			return true;
+
+	/* Check if we have aggregation frame in FW queues */
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++)
+		if (!cl_txq_is_fw_empty(&cl_hw->tx_queues->agg[i]))
+			return true;
+
+	return false;
+}
+
-- 
2.36.1

