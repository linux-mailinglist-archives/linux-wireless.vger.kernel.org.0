Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D068C3AB900
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhFQQLt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:49 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:26086
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232582AbhFQQKb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRENXgjrJt7sCsqpo3K8MhOS6Hir+K2see5DwFS0TyYbFxdW1fXvO3d8z3Pyq2+dh5yCwShNjUeq0zV9smHrXpFfGWRR+9GWyH/i2sIdQ6lClvc8SZmSqfe+Q5bZgbz0LIAQQM4ZwFNtvWOpQpXmjMPULUjAkl061zc0VSey1IrlLMuWex4k0bUTuzA6muAAIjrvcFYCaA24s3jo5tcseiQpQNlrZUhTYDAb9nFA515BjYSf580Pb5jHxU/d/e6JQpJEwX8isJVlGvAR8wPm7N3CyPbRHLnmSnDI2TLxiUAE5/fFxKTgHB5fOJ1VWu8OThByKBeD0UT/U6fAXpyWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPKFeQmNIHHClTPZiud1aPccgjYignzkGrl90UCOtqs=;
 b=XGq5B3e8gagCmOUmIXTUs7K6xlrJOk3R6JdKWmpUcmi3LpBp2wCATlss+oJyf8sUldZv/zALEHa/a1MUn2RltQly8aANNF3oWb91sXgaUp/lTF/r9lwnUp1HKxzhWa9jmfm3CRtHwiw5ALfAX6pVawKyXF7OHVb/2iDhW6JiK03BVJVznUF9hsvHVqQzu0xEVxZqp+TkQ1l3IPTK1Ctznx+tFaNuSTgAsvgKRymOquR/Rl4cldyXSv6FAntIrGDc6Pk9YtQHSZ6gLX8FoKq/0wX6TJKiqcY9Q1CEbPBcxvRZu+R9/+bpAi1p9ihfkxP92J1/iMbTklcqcSjiFE1SVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPKFeQmNIHHClTPZiud1aPccgjYignzkGrl90UCOtqs=;
 b=fFkNa45o6U7li5QIREJXSD12LrcsEXUBgK0WK0HPbCFfua1xukZK7VHDprr1aqj2ExJ+2AOA1bXEqwLbepbqo/+eeVxO4BYPdMd7W7GAIYbARHMRXcCwqj63w8CEfcHBMtGvnHx/009udqLOlTgLtixa1opC/4pY+dFqwrvcA2M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:09 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:09 +0000
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
Subject: [RFC v1 183/256] cl8k: add sta.h
Date:   Thu, 17 Jun 2021 16:01:10 +0000
Message-Id: <20210617160223.160998-184-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da940bb8-7116-49bd-5fa1-08d931a9ca85
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB02609B4A42E80BA392D23E21F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJjNRbcdJ+hS8N89w9lV89+14d68hkQeKW/lnoQPXLOUL/Gdjs/T1Uji+tqRG97JemkantHtrtiv57fa3pRZNswZMApuYuZnP5o7HFUdUDFO+IGQjU5gBrMN8Hcmg+SLsM3BPTF4eRB4jhlQm5Lz6RQ/rsceI756epXzhnOZrEywsdpPcCOvNGvJ0M7kjjPsnrU4tYLYey1K5QjEMEuGf8AGe02++f3LyLauNbCl9CkYqSAV5lzK38IXPa8Z0zG/h2W9gKvz7sn2kDvQBGqAmb9o0SGLQCnKOErQGiWIkgyBOpMjlb55SFU+sSK0IfGOmMDNDHiI9mowI7QdY3AMM9ggQsJz5aoD82n/CtV0Pp0/KSJXwrY58pF424Smw4tdPi6yvWOUnORrF8qMhtD8+Aqg0Fj+jpRmfXfbVHX1oykGgaZCsvERz/42Rr1s4JSsi1Knv6RQjI9UrKDwrSWcTrraqp4ypJgrW8PyK79ZH0IUwh5EjOhWIercjJJ3/cJAKnKaVeF59VtMx26YuMfISpyukw6V6/B52PqHUaUOlUdxF2DO4/9V3DF8VlCuz6wmPmZpERhNR/UjL+1Af9YUcU62lfBYZL5Dd7r9+x3cWQQSMhe37LUjMD88e3AMT76+7Nvttio3Fs2qZD8ccZF5LJgdNLc4aEgICdwmY6LtYiZfvgE+3yaUmaSmpls8Z+zEd3Ou5TvYBHtcrfI9nfBhxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQJfDEmCtrzJJrFYWaP6p/wKqVugak26SBzI61xaxs1iZs7wjFybHLE19Q9A?=
 =?us-ascii?Q?K0kMynQ83UB4fvzjHF+7b9bc5/sI2d1YY71rsPxSQN92qh8ayDTTcQnsRX4g?=
 =?us-ascii?Q?B+tRoJpOt4X0UnLQl9T8cyU3LM49LI0yzF0QDKUMeTWtdFKd3oBbpKtqF28a?=
 =?us-ascii?Q?RJWP/icoEGKWPGIRJz55d5JTUteUbbYFH6j3+IoB9sbOofSRA+hqCwYUNgQC?=
 =?us-ascii?Q?7Nprp0oZBTnIk9szAC94caHVpAYRTHkjmFFhal2RG1Lejfzh3XHOOiVfblY0?=
 =?us-ascii?Q?hItdqRTrmPbeEaGeb2wtrmxShYhAIIi2wlxo++ywGPiopROra1ML3Psa4IvM?=
 =?us-ascii?Q?XjtFr7K87CXUXtSHgLAQZklAFOf6m4CkVBO5N7sGXvTMlHFQ3b5e+b/ma9Uj?=
 =?us-ascii?Q?UuxyOP8FAabqJ31zguuCR6/hckQ6Sml3hWNVBmoP9M9bXB0hVO7Ks+7E5XGV?=
 =?us-ascii?Q?UkOPQIACtHZ6NWIPF1WGPFHchELW/nJGhLRUIIbDPsUoKyTQZe7+mEHCJHaw?=
 =?us-ascii?Q?QfcE4EGsSERDM1yQRdqXMODIdpXwPU9d+onyiarc3RTuyfkhrDONkh7/D6/I?=
 =?us-ascii?Q?Ay3pfYXLuuzAiO7xIr7b/p/QDC73rVrbluAU+W4UBwSo7+15+a/hG1yINm02?=
 =?us-ascii?Q?FQLrutF6qebgRJLTawufKs40wCXV7kENcsji5CHkuInY97Pva8owkJM6x7RW?=
 =?us-ascii?Q?lTmasCwIaXx2jff9HXFQ/KSnZ4OTcxdd3JeOM54+vOBVqr22+dccX9ZYAhfK?=
 =?us-ascii?Q?pKUdPemhI+NFcDSIjwrmAt19oVjYAuydsKqjfZ03vRLDWHkHg+tkTkxFrylL?=
 =?us-ascii?Q?FafqCtuJkLnxU1oZoRUxPrD+cRRQ5/3zGBvUAPkjMiXjwKU2fzW5Fv3IZs/+?=
 =?us-ascii?Q?b0d9PC6geBSZAU120DskmlBqWYaUwzcZ/BbkiKhjDh2d1F47vgPllanyGIWj?=
 =?us-ascii?Q?NBC9J2IBTNjfC30DQQyWJcIeWItqi9FmpFjCs1OnQ3TVqipTklfTM+FdDI2o?=
 =?us-ascii?Q?l+gioYFNlfdkle6uhNibnXzluGWldYPmwrJXFpqOhx43V3NqhXPC5Qwj1DJ3?=
 =?us-ascii?Q?zEvg3ATgi7qhIsOjGQnkzQLEDI14hU6PpNZs0d/cwSErUHygcK/lwdNwy+K/?=
 =?us-ascii?Q?E8lQwyXEvC1s4jWdFjQgdo0SgdPrdWZx+msXjGrtCTLFfW2f76x3JjTC/Ox+?=
 =?us-ascii?Q?4YAPw4yOShXeCPHoPHtuIiyTOOJGBWbcLDAGLw2TeyCEY1wvH3aWT6HjM2K0?=
 =?us-ascii?Q?01SQTCGkF3Lf1Z33NRoQTdLOpykDyygt0JbX+tv7eo7fTCZ4EEBMfDcRYspz?=
 =?us-ascii?Q?cL4nNCA372UOZL/NfrxhXADb?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da940bb8-7116-49bd-5fa1-08d931a9ca85
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:56.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMDGXnQh3DSXDmFQG7reDfcLQpKD6Oclzu5JPI5iFle6NSW8+qbmuHwsXe7rXbjxc9YsmDzgXOhjYpZ8iWijdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/sta.h | 241 +++++++++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.h

diff --git a/drivers/net/wireless/celeno/cl8k/sta.h b/drivers/net/wireless/=
celeno/cl8k/sta.h
new file mode 100644
index 000000000000..8e1e47316cf8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sta.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_STA_H
+#define CL_STA_H
+
+#include "sta_info.h"
+#include "utils/timer.h"
+#include "rate_ctrl.h"
+#include "motion_sense.h"
+
+#define IEEE80211_STA_TO_CL_STA(sta) ((struct cl_sta *)(sta)->drv_priv)
+#define STA_INFO_TO_CL_STA(sta_info) ((struct cl_sta *)(sta_info)->sta.drv=
_priv)
+
+#define STA_IDX_INVALID U8_MAX
+
+struct cl_wrs_info {
+       u64 epr_acc;
+       u32 tx_success;
+       u32 tx_fail;
+       u32 tx_fail_prev;
+       u32 ba_not_rcv;
+       u8 ba_not_rcv_consecutive;
+       u8 ba_not_rcv_consecutive_max;
+       bool synced;
+       u32 sync_attempts;
+       u8 quick_rate_agg_cntr;
+       u16 quick_rate_pkt_cntr;
+       bool quick_rate_check;
+};
+
+struct cl_wrs_rssi {
+       s32 sum[MAX_ANTENNAS];
+       s32 cnt;
+};
+
+struct cl_amsdu_ctrl {
+       struct cl_sw_txhdr *sw_txhdr;
+       u16 rem_len;
+       u16 max_len;
+       u16 hdrlen;
+       u8 packet_cnt;
+       bool is_sw_amsdu;
+};
+
+struct cl_bf_sta_db {
+       bool traffic_active;
+       bool sounding_start;
+       bool sounding_remove_required;
+       bool indication_timeout;
+       bool synced;
+       bool is_on;
+       bool is_on_fallback;
+       u8 num_ss;
+       u8 num_ss_fallback;
+       u8 beamformee_sts;
+       u8 nc;
+       u32 sounding_indications;
+       struct cl_timer timer;
+};
+
+#define RSSI_ARR_SIZE 128
+#define BF_IDX_MAX 2
+
+struct cl_tx_cntrs {
+       u32 success;
+       u32 fail;
+};
+
+struct cl_tx_stats {
+       struct cl_tx_cntrs he[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX][WRS_GI_=
MAX][BF_IDX_MAX];
+       struct cl_tx_cntrs
+               vht[CHNL_BW_MAX_VHT][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MA=
X_VHT][BF_IDX_MAX];
+       struct cl_tx_cntrs ht[CHNL_BW_MAX_HT][WRS_SS_MAX][WRS_MCS_MAX_HT][W=
RS_GI_MAX_HT];
+       struct cl_tx_cntrs ofdm[WRS_MCS_MAX_OFDM];
+       struct cl_tx_cntrs cck[WRS_MCS_MAX_CCK];
+       u32 agg_cntr;
+       u32 fail_cntr;
+};
+
+enum cl_ps_period {
+       PS_PERIOD_50MS,
+       PS_PERIOD_100MS,
+       PS_PERIOD_250MS,
+       PS_PERIOD_500MS,
+       PS_PERIOD_750MS,
+       PS_PERIOD_1000MS,
+       PS_PERIOD_2000MS,
+       PS_PERIOD_5000MS,
+       PS_PERIOD_10000MS,
+       PS_PERIOD_ABOVE,
+
+       PS_PERIOD_MAX
+};
+
+struct cl_ps_stats {
+       bool is_ps;
+       unsigned long timestamp_sleep;
+       u32 period[PS_PERIOD_MAX];
+};
+
+enum cl_fec_coding {
+       CL_FEC_CODING_BCC,
+       CL_FEC_CODING_LDPC,
+       CL_FEC_CODING_MAX
+};
+
+struct cl_stats {
+       struct cl_tx_stats tx;
+       struct cl_rx_stats rx;
+       u32 rssi[RSSI_ARR_SIZE][MAX_ANTENNAS];
+       u32 fec_coding[CL_FEC_CODING_MAX];
+       struct cl_ps_stats ps;
+};
+
+/* Per RA/TID Data for AMPDU TX */
+struct cl_baw {
+       u8 fw_agg_idx;
+       bool amsdu;
+       bool action_start;
+       u16 ssn;
+       u16 tid_seq;
+       struct sk_buff_head pending;
+};
+
+struct cl_vns_sta_db {
+       bool is_very_near;
+       bool prev_decision;
+       s32 rssi_sum[MAX_ANTENNAS];
+       s32 rssi_samples;
+};
+
+struct cl_agc_cd_rssi {
+       s32 samples;
+       s32 sum[MAX_ANTENNAS];
+       s8 prev;
+};
+
+struct cl_tid_ampdu_rx {
+       spinlock_t reorder_lock;
+       u64 reorder_buf_filtered;
+       struct sk_buff_head *reorder_buf;
+       unsigned long *reorder_time;
+       struct ieee80211_sta *sta;
+       struct cl_timer reorder_timer;
+       struct cl_hw *cl_hw;
+       u16 head_seq_num;
+       u16 stored_mpdu_num;
+       u16 ssn;
+       u16 buf_size;
+       u16 timeout;
+       u8 tid;
+       u8 auto_seq:1,
+          removed:1,
+          started:1;
+};
+
+/*
+ * Structure used to save information relative to the managed stations.
+ * Will be used as the 'drv_priv' field of the "struct ieee80211_sta" stru=
cture.
+ */
+struct cl_sta {
+       struct list_head list;
+       struct list_head list_hash;
+       u8 sta_idx;
+       u8 su_sid;
+       bool key_disable;
+       u8 addr[ETH_ALEN];
+       struct cl_baw baws[IEEE80211_NUM_TIDS];
+       struct cl_amsdu_ctrl amsdu_anchor[IEEE80211_NUM_TIDS];
+       struct cl_tx_queue *agg_tx_queues[IEEE80211_NUM_TIDS];
+       struct cl_vif *cl_vif;
+       struct sta_info *stainfo;
+       struct ieee80211_key_conf *key_conf;
+       struct cl_bf_sta_db bf_db;
+       struct cl_stats *stats;
+       s32 alpha_rssi;
+       bool manual_alpha_rssi;
+       s8 last_rssi[MAX_ANTENNAS];
+       u8 ampdu_min_spacing;
+       struct cl_traffic_sta traffic_db[TRAFFIC_DIRECTION_MAX];
+       struct cl_vns_sta_db vns_db;
+       struct cl_agc_cd_rssi agc_cd_rssi;
+       u32 retry_count;
+       u32 data_pending[AC_MAX];
+       struct cl_wrs_info wrs_info;
+       struct cl_wrs_rssi wrs_rssi;
+       bool add_complete;
+       struct cl_wrs_sta wrs_sta;
+       struct cl_motion_sense motion_sense;
+       union cl_rate_ctrl_info_he rate_ctrl_he;
+       struct cl_tid_ampdu_rx *tid_agg_rx[IEEE80211_NUM_TIDS];
+};
+
+typedef void (*sta_callback)(struct cl_hw *, struct cl_sta *);
+
+void cl_sta_init(struct cl_hw *cl_hw);
+
+/* These functions take the lock inside */
+u32 cl_sta_num(struct cl_hw *cl_hw);
+u32 cl_sta_num_bh(struct cl_hw *cl_hw);
+bool cl_sta_is_assoc(struct cl_hw *cl_hw, u8 sta_idx);
+
+/* Must take lock before calling these functions */
+struct cl_sta *cl_sta_get(struct cl_hw *cl_hw, u8 sta_idx);
+struct cl_sta *cl_sta_get_by_addr(struct cl_hw *cl_hw, u8 *addr);
+
+/* Loop over list of stations and run the callback for each station */
+void cl_sta_loop(struct cl_hw *cl_hw, sta_callback callback);
+void cl_sta_loop_bh(struct cl_hw *cl_hw, sta_callback callback);
+void cl_sta_loop_safe(struct cl_hw *cl_hw, sta_callback callback);
+
+void cl_sta_init_stainfo(struct cl_hw *cl_hw, struct sta_info *stainfo);
+int cl_sta_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct ieee=
80211_sta *sta);
+void cl_sta_mgd_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct iee=
e80211_sta *sta);
+void cl_sta_remove(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct =
ieee80211_sta *sta);
+void cl_sta_disassociate_all(struct cl_hw *cl_hw);
+void cl_sta_disassociate_ap_iface(struct cl_hw *cl_hw);
+void cl_sta_ps_notify(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool is_=
ps);
+
+static inline void cl_sta_lock_bh(struct cl_hw *cl_hw)
+{
+       read_lock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+static inline void cl_sta_unlock_bh(struct cl_hw *cl_hw)
+{
+       read_unlock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+static inline void cl_sta_lock(struct cl_hw *cl_hw)
+{
+       read_lock(&cl_hw->cl_sta_db.lock);
+}
+
+static inline void cl_sta_unlock(struct cl_hw *cl_hw)
+{
+       read_unlock(&cl_hw->cl_sta_db.lock);
+}
+
+#endif /* CL_STA_H */
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

