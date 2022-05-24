Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D430053298C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiEXLl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiEXLlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10383939BE
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeChDJQW2HtgD9WHtLgW+fgvSN7tG9L5+LCkHGO1nQSU1sWv1wo8o49UmpK0Pwd9t4c5nZ3CBfLo4UhFmVMdaHbGIr2lpm3lrNKsVc8VuxQ0a7Q3daiRPQ58eNR8n2MX3ksoF/EODNKmzlXrLH8m8Qcw0ogNPOnrM1EI8sih/vEkRlWNDt0CXm4BrKTGg0ezFwkMBL2fGg3L7h6zGlcHhKEjSqeSyqNVvC86PKWHUtJdptRofy7rgxTlrZJmjYocyP6X2oGvN3QYNTNLMSisRUV0d8UwVjlNc3+JA7F0+pSBEl7FDqf1kJSOc7/8PewcZdYLljtIBNFgfN/8vtbyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16SuCED5knND0f2MxrWSMbU0eRI0jQmTNqWcGCg9jaQ=;
 b=B/J2YQ+PqeGL7DG635pJ+A0oLRzdJ6YUdoYTbxc5ag3qv20+SDpBjeD5ywzIjXsaJaBok7biL2JtoVKPx+jyb3sgGA4hCx9w6f97L12+UfECyYC6x9ZH8lqP1CirX2aHOOsJmSZfUgxVBVP6L7R9NfJsAeowjX3Lc7PleSNp4NUm8vaIt6zVdkAOnYe7+waRPnN0ckgJBVcbqtCoValv+Z+YNAdau6TBcm8CRADH9mwNSjSWG2YWON92BIbFCfc4qH3WgTpBfd8KYWuk98HUXwE5kGry1Rrd1YcLyjhEypmGxbYO1yCs3jlxZfp6eSv7zc7I0EfZajXnnh6FSD9u9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16SuCED5knND0f2MxrWSMbU0eRI0jQmTNqWcGCg9jaQ=;
 b=D2afiEZJTtOsg82SM909VxQXOl0fmtRatxo3UuB7i2Rep1nYJWCoVWDepDg5et/uurR09nZMN/pRgXB2HizgTMkh3jMKeXsqcMM1Bf2DSnokDNGvOfEjaNwDzfp0ZSJLqepcsVouicGVSfGBns7Nd2aNK5TQ92Fnuxg31OHRg7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:32 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:32 +0000
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
Subject: [RFC v2 85/96] cl8k: add tx.h
Date:   Tue, 24 May 2022 14:34:51 +0300
Message-Id: <20220524113502.1094459-86-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7232e032-a562-418e-7c56-08da3d79fd70
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669A288A7623C73BF01F343F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBcp4u79+VEfkQf7xONjlUrmB6VtqJGNDWhXkacULVMzVCrPBwZb01aFXXUX02oAwHwcY47O3LhDNQYNDrBw89s+63XbTPAic9xMGW1u7fUjwCEejyCrxxK/ny6yBYUwuNAeuGee7PwR+XTHi/dNHZ93oU6KinJT8avoctWrBD6GxtWHDNr/L9RjKtHXT5IaIScumdyM4NvTrCofeqfPLL0YOegYF9Pq1NuhOHaO4uF/j/MnHVbbjjpKoundqzJNbeUwlfzD+ElW6jDgjVWhzU0NKKrWyJLBBJtNECmvBerII6b6RNyBFKlCNLg0oP+KhXbw7pMEG7jtkG8uyQFkZuKQ9m1rZornTxYsKhEGQOD29pY2gW7ulHVJLP3BmKO5lgjHPbmULJ5rGFxgP0Xe+nt3jCVb56059ShSveuw7s8xjj92qYLsq3eEt8Mbsa4/N7Vte6FAEVwV8dQbXJhjZf+4F2J8yP+ZrH3r+vnKEurBNTXrHxUfd86Wsf/EQkysW/+ginLZZ/Og4qltrYlwL0Kynqy/GL/PEXhVBVDopojrjgHQaxUr/YeEpmJGK74bKFW9SICF8YbT8h8tPtEswfDBW18Us5AoXumWbKAdpG+ky9G0TbBVxIL2Smq6/6g8ON/ulXZB5vaUNO9PeJKXNvdkmXqIrLOUluIq0h7iGyRT+eQjob8H2OBdlT+U6BL6MhvOrLoWZPmqwOYPQd2OqW0GLGI/8+krst3G6xie+ZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(30864003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wyL/M6hquR8nUeP0JdpImrpJ6Ao8lZ7+qBUwzqqe59pyMSXU88v5H8vcYhwX?=
 =?us-ascii?Q?VFuKGBfFZ8u0xq6M5nlcFCfMNudccDOMcKwav287wPKPkO9biU0KkixM7TUc?=
 =?us-ascii?Q?QKnVMfxS0pLLptny3Za3tOG/P0AImtm/0AI26ptTY9LLdAiTo+jUsnna5maX?=
 =?us-ascii?Q?W427/SbBFBmdl+4vYXHcUCR711FO4+RPqKxROrat1bWUv4yzJO7Q/tgotfzn?=
 =?us-ascii?Q?F4bpSDyvJE7NWv7srUim30MsBTVOtbqZBcRqflePmWF+1aZe5Qq4qkCrwdmW?=
 =?us-ascii?Q?Go396GANXUqVOSprF4xZNlClzr/lADnYId+dFPg/YDmwpOiZnU4CZNvCM1wD?=
 =?us-ascii?Q?zukITkN2FhCF7KHxXfMqKrnWLHusPlF4O4tUJXMi/g+kFFIsLdjvLHauOYJI?=
 =?us-ascii?Q?ArfznmZSKKDt6+TN4lG1UVFDlEMLVxibcoejr4TJVQT9r57Met8syWAsjxuA?=
 =?us-ascii?Q?i7KGIsP1Cc/+XuK3yUYP9Ux+J17ZLqMFEZOb5JSHOIPx7xi+TbazWP4j9HGr?=
 =?us-ascii?Q?c7M3Ob/2EkqgtCltt8nU/hWe0bfTSFlhk1F1sobq1mb7yqY/uqnBeBODarfg?=
 =?us-ascii?Q?mIpZV0h3RnKw6hAYnebkVjWFHUOSbb2M9FkK7ahHsOMxaYV3q/L5Mp8sfpCv?=
 =?us-ascii?Q?/fWZTGOPxkImgZNV9noa+YulAkylWdw2vlGEb50gtxI8PD72O+GJQFAhZ6zz?=
 =?us-ascii?Q?PlrwUAOPuPwFFEbqPp/8lDAHXnMQ/4m9tC0iGWwdCB/AAgz50EGt4iNO45ub?=
 =?us-ascii?Q?pKO3htRIHD6SjyMJ4hX1a84H5SFFvbZuz2r4d2S8uJplRbNwBla73Rpzw8V0?=
 =?us-ascii?Q?FRkackW5YDoW7+dCEM7i1RYkeetGndFurxl7tb/Evm3hg/5UBqYn9CND6keb?=
 =?us-ascii?Q?0SshfC5g2Bt9md4CgNTEB/0udZm4UnS12CVDX4jZ+tw9eu7TupXQcLQB1Kyu?=
 =?us-ascii?Q?awlXO0RP8LTBgqtn/bONue4PPRs1varkKW005R9Z5B4NprW7XnqXMaaulDRw?=
 =?us-ascii?Q?YZqXcBcz1+pSp+ONEIIgrVNbZDoEGU93VMCr5QuHFhUKZcqz0axvmE2y5So1?=
 =?us-ascii?Q?RsLYLzPzCsT12yGlH0jKEx8L3sdGLT9HuN8g6+x5viUfFfSu41zAdnu5TXAC?=
 =?us-ascii?Q?w1PgWuZ/etix305deWInEba7C2KsbC3Ba/U7dH5gT/Q4kZ6unUsgdAuzu4F4?=
 =?us-ascii?Q?226ou/5ciFtX9oJFxPP1HrwF9P/+CbSPoqPsOUB8FOyPnROUhaVjL9aTd8TX?=
 =?us-ascii?Q?/ngyAerO/36V5aBdbzXVUvvxRFmUcErF/eWWwPGhc25/Js1bfmsgXILD9MKe?=
 =?us-ascii?Q?8Qv7ztxNGJP3iDbdVRUyx2Pf086wz2+AVTUY994obW0GIUsArPOn2k373M+7?=
 =?us-ascii?Q?4uUHRwahQ4rx43VQ2mmoQhF/uQA/sxthtuy53EcbAsk2lUdPK6zFoMDhZ528?=
 =?us-ascii?Q?LRMHgcONsRFuYrcXTCv+sDeYgBRNfWv5W1UbqJRcO5+uWLhmMpuGbwVxk+U9?=
 =?us-ascii?Q?mkGkuCtahp3Sw3dI8nvmFE0mOFwPWIVkDdotUxMNPUwsguiBEfjCr3bPUW4t?=
 =?us-ascii?Q?EsI02WxlpLhVSu8MN5Ok8aRluPOPCqHtlfvSnr0SjxLdiVMedi3jt54DYo9F?=
 =?us-ascii?Q?qBQ2fqIfkKvQFzFCo0AISNefImjOdiIjm0fAk24RuChwZQqAweJ2zUY4t6i9?=
 =?us-ascii?Q?2xfQfx1FBEWvYm21V9LnSPSa2TqI51KcJNHiHW8q7ILQP4G1RNYgIT4iBvZe?=
 =?us-ascii?Q?KlXhxgKZ5vEboQGMaBXiLsQQUMZgoZU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7232e032-a562-418e-7c56-08da3d79fd70
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:58.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2de/OPgdmeBmiKg+PcNeC1HwFL4ilVXeMUlGbGxPpApIG3NeEpFYs6E44skFBK27QSvbgXfyYiDKE/QNH4+Zg==
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
 drivers/net/wireless/celeno/cl8k/tx.h | 467 ++++++++++++++++++++++++++
 1 file changed, 467 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx.h b/drivers/net/wireless/celeno/cl8k/tx.h
new file mode 100644
index 000000000000..d36a7d703df6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx.h
@@ -0,0 +1,467 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_TX_H
+#define CL_TX_H
+
+#include <linux/interrupt.h>
+
+#include "sta_info.h"
+#include "vif.h"
+#include "ipc_shared.h"
+#include "fw.h"
+#include "wrs.h"
+
+enum cl_queue_type {
+	QUEUE_TYPE_SINGLE,
+	QUEUE_TYPE_AGG,
+	QUEUE_TYPE_BCMC,
+
+	QUEUE_TYPE_MAX
+};
+
+#define QUEUE_IDX(sta, ac)  ((sta) + (ac) * FW_MAX_NUM_STA)
+
+#define TX_PUSH_LOGGER_SIZE 256
+
+#define BCMC_POLL_TIMEOUT 50
+
+enum cl_tx_push_logger_param {
+	TX_PUSH_LOGGER_DRV_CNT,
+	TX_PUSH_LOGGER_FW_CNT,
+	TX_PUSH_LOGGER_PKT_PUSHED,
+	TX_PUSH_LOGGER_MAX,
+};
+
+struct cl_tx_push_cntrs {
+	u32 tx_push_cntr_hist[TXDESC_AGG_Q_SIZE_MAX + 1];
+	u32 tx_push_logger[TX_PUSH_LOGGER_SIZE][TX_PUSH_LOGGER_MAX];
+	u32 tx_push_logger_idx;
+};
+
+struct cl_tx_queue {
+	struct list_head sched_list;
+	struct list_head hdrs;
+	struct cl_sta *cl_sta;
+	bool sched;
+	u16 fw_free_space;
+	u16 fw_max_size;
+	u8 type;
+	u8 tid;
+	u8 hw_index;
+	u16 index;
+	u16 max_packets;
+	u16 num_packets;
+	u32 total_packets;
+	u32 total_fw_push_desc;
+	u32 total_fw_push_skb;
+	u32 total_fw_cfm;
+	u32 dump_queue_full;
+	u32 dump_dma_map_fail;
+	u32 stats_hw_amsdu_cnt[CL_AMSDU_TX_PAYLOAD_MAX];
+	u32 stats_sw_amsdu_cnt[MAX_TX_SW_AMSDU_PACKET];
+	u32 hist_xmit_to_push[DELAY_HIST_SIZE];
+	u32 hist_push_to_cfm[DELAY_HIST_SIZE];
+	struct cl_tx_push_cntrs push_cntrs_db;
+};
+
+/*
+ * struct cl_tx_queues:
+ * This structure holds all driver TX queues,
+ * The queues buffer frames pushed by upper layer and push them to lower IPC layer.
+ */
+struct cl_tx_queues {
+	struct cl_tx_queue agg[IPC_MAX_BA_SESSIONS];
+	struct cl_tx_queue single[MAX_SINGLE_QUEUES];
+	struct cl_tx_queue bcmc;
+};
+
+struct cl_req_agg_db {
+	bool is_used;
+	u8 sta_idx;
+	u8 tid;
+};
+
+#define INC_SN(sn) (((sn) + 0x10) & IEEE80211_SCTL_SEQ)
+#define DEC_SN(sn) (((sn) - 0x10) & IEEE80211_SCTL_SEQ)
+
+#define CL_TX_LIFETIME_MS 4000
+
+#define CL_SKB_DATA_ALIGN_SZ      4
+#define CL_SKB_DATA_ALIGN_MSK     (CL_SKB_DATA_ALIGN_SZ - 1)
+#define CL_SKB_DATA_ALIGN_PADS(x) \
+	((CL_SKB_DATA_ALIGN_SZ - ((ptrdiff_t)(x) & CL_SKB_DATA_ALIGN_MSK)) & CL_SKB_DATA_ALIGN_MSK)
+
+#define CL_TX_MAX_FRAME_LEN_SINGLE 4096
+#define CL_TX_MAX_FRAME_LEN_AGG 2000
+
+struct cl_hw_tx_status {
+	u32 mcs_index          : 7; /* [6:0] */
+	u32 is_bcmc            : 1; /* [7] */
+	u32 num_mpdu_retries   : 4; /* [11:8] */
+	u32 rsv                : 4; /* [15:12] */
+	u32 format_mod         : 4; /* [19:16] */
+	u32 bw_requested       : 2; /* [21:20] */
+	u32 bf                 : 1; /* [22] */
+	u32 frm_successful     : 1; /* [23] */
+	u32 bw_transmitted     : 2; /* [25:24] */
+	u32 freespace_inc_skip : 1; /* [26] */
+	u32 keep_skb           : 1; /* [27] */
+	u32 gi                 : 2; /* [29:28] */
+	u32 descriptor_done_sw : 1; /* [30] */
+	u32 descriptor_done_hw : 1; /* [31] */
+};
+
+enum cl_tx_flags {
+	CL_TX_EN_DFS,
+	CL_TX_EN_SCAN
+};
+
+enum cl_tx_single_frame_type {
+	CL_TX_SINGLE_FRAME_TYPE_QOS_DATA,
+	CL_TX_SINGLE_FRAME_TYPE_QOS_NULL,
+	CL_TX_SINGLE_FRAME_TYPE_MANAGEMENT,
+	CL_TX_SINGLE_FRAME_TYPE_OTHER
+};
+
+struct cl_tx_db {
+	bool force_amsdu;
+	bool block_bcn;
+	bool block_prob_resp;
+};
+
+struct cl_tx_drop_cntr {
+	u32 radio_off;
+	u32 in_recovery;
+	u32 short_length;
+	u32 pending_full;
+	u32 packet_limit;
+	u32 dev_flags;
+	u32 tx_disable;
+	u32 length_limit;
+	u32 txhdr_alloc_fail;
+	u32 queue_null;
+	u32 amsdu_alloc_fail;
+	u32 amsdu_dma_map_err;
+	u32 build_hdr_fail;
+	u32 key_disable;
+	u32 queue_flush;
+	u32 probe_response;
+	u32 sta_null_in_agg;
+	u32 sta_stop_tx;
+};
+
+struct cl_tx_forward_cntr {
+	u32 tx_start;
+	u32 drv_fast_agg;
+	u32 drv_fast_single;
+	u32 to_mac;
+	u32 from_mac_single;
+	u32 from_mac_agg;
+};
+
+struct cl_tx_transfer_cntr {
+	u32 single_to_agg;
+	u32 agg_to_single;
+};
+
+struct cl_tx_packet_cntr {
+	struct cl_tx_forward_cntr forward;
+	struct cl_tx_drop_cntr drop;
+	struct cl_tx_transfer_cntr transfer;
+};
+
+struct cl_cpu_cntr {
+	u32 tx_agg[CPU_MAX_NUM];
+	u32 tx_single[CPU_MAX_NUM];
+};
+
+static inline bool cl_tx_ctrl_is_amsdu(struct ieee80211_tx_info *tx_info)
+{
+	return !!(tx_info->control.flags & IEEE80211_TX_CTRL_AMSDU);
+}
+
+static inline bool cl_tx_ctrl_is_eapol(struct ieee80211_tx_info *tx_info)
+{
+	return !!(tx_info->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO);
+}
+
+struct cl_agg_cfm_queue {
+	struct list_head head;
+	struct cl_tx_queue *tx_queue;
+	u16 ssn;
+};
+
+/* Structure containing the parameters of the MM_AGG_TX_REPORT_IND message. */
+struct cl_agg_tx_report {
+	__le32 rate_cntrl_info;
+	__le32 rate_cntrl_info_he;
+
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 sta_idx                    : 8,
+	    is_sta_ps                  : 1,
+	    bw_requested               : 2,
+	    is_agg                     : 1,
+	    ba_not_received            : 1,
+	    ba_received_empty          : 1,
+	    bf                         : 1,
+	    is_fallback                : 1,
+	    mu_su_gid                  : 6,
+	    mu_mimo_valid              : 1,
+	    mu_ofdma_valid             : 1,
+	    rate_fix_mcs1              : 1,
+	    rsv0                       : 7;
+
+	u32 success                    : 9,
+	    fail                       : 9,
+	    below_baw_cnt              : 9,
+	    num_prot_retries           : 5;
+
+	u32 success_after_retry        : 9,
+	    success_more_one_retry     : 9,
+	    retry_limit_reached        : 9,
+	    is_retry                   : 1,
+	    is_rts_retry_limit_reached : 1,
+	    prot_type                  : 3;
+
+	u32 rssi1                      : 8,
+	    rssi2                      : 8,
+	    rssi3                      : 8,
+	    rssi4                      : 8;
+
+	u32 rssi5                      : 8,
+	    rssi6                      : 8,
+	    rsv1                       : 16;
+#else
+	u32 rsv0                       : 7,
+	    rate_fix_mcs1              : 1,
+	    mu_ofdma_valid             : 1,
+	    mu_mimo_valid              : 1,
+	    mu_su_gid                  : 6,
+	    is_fallback                : 1,
+	    bf                         : 1,
+	    ba_received_empty          : 1,
+	    ba_not_received            : 1,
+	    is_agg                     : 1,
+	    bw_requested               : 2,
+	    is_sta_ps                  : 1,
+	    sta_idx                    : 8;
+
+	u32 num_prot_retries           : 5,
+	    below_baw_cnt              : 9,
+	    fail                       : 9,
+	    success                    : 9;
+
+	u32 prot_type                  : 3,
+	    is_rts_retry_limit_reached : 1,
+	    is_retry                   : 1,
+	    retry_limit_reached        : 9,
+	    success_more_one_retry     : 9,
+	    success_after_retry        : 9;
+
+	u32 rssi4                      : 8,
+	    rssi3                      : 8,
+	    rssi2                      : 8,
+	    rssi1                      : 8;
+
+	u32 rsv1                       : 16,
+	    rssi6                      : 8,
+	    rssi5                      : 8;
+#endif
+	u16 new_ssn;
+	u8  tx_queue_idx;
+
+};
+
+void cl_agg_tx_report_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			      struct cl_agg_tx_report *agg_report);
+void cl_agg_tx_report_simulate_for_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+					  struct cl_hw_tx_status *status);
+
+/* Per RA/TID Data for AMPDU TX */
+struct cl_baw {
+	u8 fw_agg_idx;
+	bool amsdu;
+	bool action_start;
+	u16 ssn;
+	u16 tid_seq;
+	struct sk_buff_head pending;
+};
+
+enum cl_amsdu_result {
+	CL_AMSDU_ANCHOR_SET,
+	CL_AMSDU_SUB_FRAME_SET,
+	CL_AMSDU_SKIP,
+	CL_AMSDU_FAILED
+};
+
+/* Max size of 802.11 WLAN header */
+#define CL_WLAN_HEADER_MAX_SIZE 36
+
+#define CL_AMSDU_MIN_AGG_SIZE 3
+#define CL_AMSDU_CONST_LEN    256
+
+struct cl_amsdu_txhdr {
+	struct list_head list;
+	struct list_head list_pool;
+	struct sk_buff *skb;
+	dma_addr_t dma_addr;
+};
+
+struct cl_amsdu_ctrl {
+	struct cl_sw_txhdr *sw_txhdr;
+	u16 rem_len;
+	u16 max_len;
+	u16 hdrlen;
+	u8 packet_cnt;
+	bool is_sw_amsdu;
+};
+
+struct cl_sw_txhdr {
+	struct list_head list_pool;
+	struct list_head tx_queue_list;
+	struct list_head cfm_list;
+	struct ieee80211_hdr *hdr80211;
+	struct cl_tx_queue *tx_queue;
+	struct cl_sta *cl_sta;
+	struct cl_vif *cl_vif;
+	struct cl_amsdu_txhdr amsdu_txhdr;
+	u8 hw_queue            : 3,
+	   is_bcn              : 1,
+	   tid                 : 4;
+	u8 ac                  : 2,
+	   is_sw_amsdu         : 1,
+	   sw_amsdu_packet_cnt : 4,
+	   rsv                 : 1;
+	/*
+	 * singles queue index used to push the txdesc to the ipc layer
+	 * this issue solve race condition in which we
+	 * CFM of packet that associated with disconnected STA and has invalid
+	 * cl_sta pointerinside this struct
+	 */
+	u8 sta_idx;
+	__le16 fc;
+	struct sk_buff *skb;
+	struct txdesc txdesc;
+	size_t map_len;
+	u16 total_pkt_len;
+};
+
+void cl_tx_init(struct cl_hw *cl_hw);
+void cl_tx_check_start_ba_session(struct cl_hw *cl_hw,
+				  struct ieee80211_sta *sta,
+				  struct sk_buff *skb);
+void cl_tx_bcns_tasklet(unsigned long data);
+void cl_tx_single_free_skb(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		  struct sk_buff *skb, bool is_vns, bool lock);
+void cl_tx_fast_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		       struct sk_buff *skb, bool lock);
+void cl_tx_agg_prep(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+		    u16 frame_len, u8 hdr_pads, bool hdr_conv);
+void cl_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+	       struct sk_buff *skb, bool hdr_conv, bool lock);
+void cl_tx_fast_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		    struct sk_buff *skb, bool lock);
+u16 cl_tx_prepare_wlan_hdr(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			   struct sk_buff *skb, struct ieee80211_hdr *hdr);
+void cl_tx_wlan_to_8023(struct sk_buff *skb);
+int cl_tx_8023_to_wlan(struct cl_hw *cl_hw, struct sk_buff *skb, struct cl_sta *cl_sta, u8 tid);
+void cl_tx_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, struct cl_tx_queue *tx_queue);
+void cl_tx_bcn_mesh_task(unsigned long data);
+void cl_tx_en(struct cl_hw *cl_hw, u8 reason, bool enable);
+void cl_tx_off(struct cl_hw *cl_hw);
+void cl_tx_drop_skb(struct sk_buff *skb);
+void cl_tx_update_hist_tstamp(struct cl_tx_queue *tx_queue, struct sk_buff *skb,
+			      u32 tstamp_hist[DELAY_HIST_SIZE], bool update_skb_ktime);
+bool cl_is_tx_allowed(struct cl_hw *cl_hw);
+void cl_agg_cfm_init(struct cl_hw *cl_hw);
+void cl_agg_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, u8 agg_idx);
+void cl_agg_cfm_free_head_skb(struct cl_hw *cl_hw,
+			      struct cl_agg_cfm_queue *cfm_queue,
+			      u8 ba_queue_idx);
+void cl_agg_cfm_flush_all(struct cl_hw *cl_hw);
+void cl_agg_cfm_poll_empty(struct cl_hw *cl_hw, u8 agg_idx, bool flush);
+void cl_agg_cfm_poll_empty_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_agg_cfm_clear_tim_bit_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_agg_cfm_set_ssn(struct cl_hw *cl_hw, u16 ssn, u8 idx);
+void cl_agg_cfm_set_tx_queue(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue, u8 idx);
+void cl_baw_init(struct cl_sta *cl_sta);
+void cl_baw_start(struct cl_baw *baw, u16 ssn);
+void cl_baw_operational(struct cl_hw *cl_hw, struct cl_baw *baw,
+			u8 fw_agg_idx, bool amsdu_supported);
+void cl_baw_stop(struct cl_baw *baw);
+void cl_baw_pending_to_agg(struct cl_hw *cl_hw,
+			   struct cl_sta *cl_sta,
+			   u8 tid);
+void cl_baw_pending_to_single(struct cl_hw *cl_hw,
+			      struct cl_sta *cl_sta,
+			      struct cl_baw *baw);
+void cl_baw_pending_purge(struct cl_baw *baw);
+
+void cl_bcmc_cfm_init(struct cl_hw *cl_hw);
+void cl_bcmc_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+struct cl_sw_txhdr *cl_bcmc_cfm_find(struct cl_hw *cl_hw, dma_addr_t dma_addr,
+				     bool keep_in_list);
+void cl_bcmc_cfm_flush_queue(struct cl_hw *cl_hw, struct cl_vif *cl_vif);
+void cl_bcmc_cfm_poll_empty_per_vif(struct cl_hw *cl_hw,
+				    struct cl_vif *cl_vif);
+
+struct cl_single_cfm_queue {
+	struct list_head head;
+};
+
+void cl_single_cfm_init(struct cl_hw *cl_hw);
+void cl_single_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, u32 queue_idx);
+struct cl_sw_txhdr *cl_single_cfm_find(struct cl_hw *cl_hw, u32 queue_idx,
+				       dma_addr_t dma_addr);
+void cl_single_cfm_flush_all(struct cl_hw *cl_hw);
+void cl_single_cfm_flush_sta(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_single_cfm_poll_empty(struct cl_hw *cl_hw, u32 queue_idx);
+void cl_single_cfm_poll_empty_sta(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_single_cfm_clear_tim_bit_sta(struct cl_hw *cl_hw, u8 sta_idx);
+
+int cl_sw_txhdr_init(struct cl_hw *cl_hw);
+void cl_sw_txhdr_deinit(struct cl_hw *cl_hw);
+struct cl_sw_txhdr *cl_sw_txhdr_alloc(struct cl_hw *cl_hw);
+void cl_sw_txhdr_free(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+void cl_tx_amsdu_anchor_init(struct cl_amsdu_ctrl *amsdu_anchor);
+void cl_tx_amsdu_anchor_reset(struct cl_amsdu_ctrl *amsdu_anchor);
+void cl_tx_amsdu_set_max_len(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 tid);
+void cl_tx_amsdu_first_sub_frame(struct cl_sw_txhdr *sw_txhdr, struct cl_sta *cl_sta,
+				 struct sk_buff *skb, u8 tid);
+void cl_tx_amsdu_flush_sub_frames(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+void cl_tx_amsdu_transfer_single(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+int cl_tx_amsdu_set(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb, u8 tid);
+void cl_tx_amsdu_unset(struct cl_sw_txhdr *sw_txhdr);
+
+int cl_tx_amsdu_txhdr_init(struct cl_hw *cl_hw);
+void cl_tx_amsdu_txhdr_deinit(struct cl_hw *cl_hw);
+void cl_tx_amsdu_txhdr_free(struct cl_hw *cl_hw, struct cl_amsdu_txhdr *amsdu_txhdr);
+
+void cl_txq_init(struct cl_hw *cl_hw);
+void cl_txq_stop(struct cl_hw *cl_hw);
+struct cl_tx_queue *cl_txq_get(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+void cl_txq_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+void cl_txq_sched(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue);
+void cl_txq_agg_alloc(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		      struct mm_ba_add_cfm *ba_add_cfm, u16 buf_size);
+void cl_txq_agg_free(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue,
+		     struct cl_sta *cl_sta, u8 tid);
+void cl_txq_agg_stop(struct cl_sta *cl_sta, u8 tid);
+void cl_txq_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_txq_sta_remove(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_txq_transfer_agg_to_single(struct cl_hw *cl_hw, struct cl_tx_queue *agg_queue);
+void cl_txq_flush_agg(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue, bool lock);
+void cl_txq_flush_all_agg(struct cl_hw *cl_hw);
+void cl_txq_flush_all_single(struct cl_hw *cl_hw);
+void cl_txq_flush_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_txq_agg_request_add(struct cl_hw *cl_hw, u8 sta_idx, u8 tid);
+void cl_txq_agg_request_del(struct cl_hw *cl_hw, u8 sta_idx, u8 tid);
+bool cl_txq_is_agg_available(struct cl_hw *cl_hw);
+bool cl_txq_is_fw_empty(struct cl_tx_queue *tx_queue);
+bool cl_txq_is_fw_full(struct cl_tx_queue *tx_queue);
+u16 cl_txq_desc_in_fw(struct cl_tx_queue *tx_queue);
+bool cl_txq_frames_pending(struct cl_hw *cl_hw);
+
+#endif /* CL_TX_H */
-- 
2.36.1

