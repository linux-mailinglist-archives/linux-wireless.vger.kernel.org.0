Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35E3AB922
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhFQQMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:52 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:26086
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231650AbhFQQLr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eigZdeckY5o0CHfB5c3c25SakOPGRnvljgFb52EhR4X7M6VO+QRIam6MTACC8+MOSGK3ylHTnnwwzsL6q9FBuCt1hREyXObzbfLFt8Rx6hOqKvat/UQPhDXg+DBCZiV1sQbBehc7/qiVb7RAHCn1JQkRWXZqCRNUzqsUd0bOrNUmVJPL3LMBC7qcIYoJR7KPW3W21YK6+6OWq1aUw0NBshp4dhkrZCkP9ETFsQgjrfikn8t7wwfCLS009QEXmHtMu+zQIZy4FvdITxa0CitsPqmhHXkm++YBiifGvCD6sjsnFCcOCwWJcJf5GB6qhQHIdsPJpypQONM+SCSPamIRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ2Ol1SSYgoj1z44wy8dF7s8F9x0+wfIvoR+sK1IHO4=;
 b=CmHshY32nTpDH9szpO0/zN2P2UMDuhqH3R29llrTWvar8j5xhupZlD8lk1MaCw69Tml5+wtxmKfjO+AVYAbflkGqZ9dYsanQLK2DQDTFC5TGeb8rlplIgTMsl3xgETtgxDDV6hAuTZ2t7ESdHrMdnBI9im/JFxPgj7mr/JOaQB+bZL6MnXGLmNeWY/HLVmdryCXHvgyOf8Wst1VaviW9MiUUFcKqlyk4URVndqK3YBCAWq7Pltu2xL4ooA2X1f7xU0S9QC8w/WVK9S16ccW42T95u6YCwGzfISY2MSljAbK+x4kkAzRdiXhT0PaHkRUycQ4m2Rqx1IgbK03bfpPSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ2Ol1SSYgoj1z44wy8dF7s8F9x0+wfIvoR+sK1IHO4=;
 b=1uO/he2b/tQmSn9gJqI9vOxmcvAOJeZIgyz6nPUGUf+sb+df2HdgDxy5kj5ewCShmRUclGGEvcGaxCZa5xSjE4tKL5jqZkloesKtvEf+GiIyBBnBVShrgknU2hEy6ylK5+NUE6cs/VTJZW1hhwaVztzmxwzSz2QmggmBZiGAE7Y=
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
Subject: [RFC v1 187/256] cl8k: add tcv_config.h
Date:   Thu, 17 Jun 2021 16:01:14 +0000
Message-Id: <20210617160223.160998-188-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57a69745-2b6d-44c8-a077-08d931a9cd3d
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB026098615C766A484208BE91F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwau+vfkMiDyMWUhBwyJzhDB8iAmQhjEHvuQdCUOeSn1SwT/Sw0/vz2KWkSh8/78IQcuYsOpIFMjVV/DOctdJiuZZ4Qn/i9F0ALooREt7lPiWkHe06V5KZYDDN4s/S5IeNO66vDdL8h9eT5FRaPOw+Y5mwbgJQirLR6KKqM9G/xO6jIMQpr0MD0YPce5LJNsFkjbcOr9rhpWxkVhsVioCKzVKSP8e88RVPmVj1ojA/GOxBfSvImCuiCBoTVDNdbsxkwJUTnFCCpAxe8XUCqbkq4OY1H05sb817zPbZvHz2cU5At99u1Q4rAvxu5XXRz+pDE0zshVgi4Qg/0DE/o2zWx70ybECtBIFHxiL9cD8I7+Fw3D9rQG0hsLQJAZvMGOxOcl5AYW5++ncC3KBUnA2BqhTMNTNcnY0ewiGUwVf9r6WGzcQvhH6PuZ5HYQybhudDUgaghzyQxTVfa5wnNcLj7c2RIoM6+ird4YLnrlTbhX0UB/6FAl6cpVWaCTJo3t3vpxRm96qpu/qeL13dhYRffz6TfFOKZ6zvgX8LTr4fgF5drmXeYXK5Kv6fFGXdtJh6mUgSZhc9RUkGPixsiQO/zfsaoEU4XCvvUlUPYYMA4oRfTBJR8cB1KPT205jfQwKkh1Te+gBwTwtoIEx4hS64KKCnY6yW9sTxenuQyTqqi+Lnkjdr65O0PMNXJBeAajjarW509qo+71Y2P2mbSwYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DjE3rLeStlOyscyq0O3dQqIBdG+wM8UVLwbr3R8puYJYoak5sYwtQavIJGpI?=
 =?us-ascii?Q?g7spYAJzfwKHVOzsAYVVDI3GpzQ/1uCAfXcqllPYtFzY7o0L2+SiIJd6UhOF?=
 =?us-ascii?Q?FPVRrPuJltNIku2HSljUrcLPeZKkSY/I7YA3uxFMU+lWCKL1tA2u199rKgS7?=
 =?us-ascii?Q?5F8owJm3s7tOnq7cCb9FDcig5JnLhmMkNV9nM+n+SAoiblyPAGXeoQnJMq/I?=
 =?us-ascii?Q?hJCN3v6ysAV/53w0YOaawBjLIq1nG7y5qJCl4KmgJhB12WqEIfYtFn8D/fIv?=
 =?us-ascii?Q?eLVIIQwHTjy0RWdpJRx6YNIjSuyDpy4LSqEZdw4pMGy6JwzstGah9eMzPm5L?=
 =?us-ascii?Q?fFN97dThROd5AfM4r6jQp6qCLGmPKvF1mNe3Ghc+Ku47HAJR355dPoaYEpaf?=
 =?us-ascii?Q?P7z7MQzhhJ7M7HZQIm+JXo1KV4KePzm4mG6ArnGGdbI+tA4YRAuR/VNRHyHP?=
 =?us-ascii?Q?9dWiEtC5tDTJGb5YnAE+RwQ1Fk2XPpRGnOt2NwOLpzNQGqZlL6TQHwnGeT4l?=
 =?us-ascii?Q?KvWw5ONpDojbDcRsxJGNHPWs1Jqx1mLTg3S/oNRwCTIg7b9poSKekcPnD8ad?=
 =?us-ascii?Q?EHRUPO7HOtbOQmWJ1pAfJj5wQoTIPknVpg7Z6b07MZ7DW9BRaM+pMAU4Vf1x?=
 =?us-ascii?Q?tctfSVXzlOuBCYW5lL5P5kT8gbsYUxo8VsFt6XtdZLQEuza6EnPPeIUzdh2J?=
 =?us-ascii?Q?XHPtuaPn/VFEo1khUJVbTWVP7oMUZ51SO46/843u1NrWj99kmT0F7CA19sIS?=
 =?us-ascii?Q?Blh3z7ar33o0Hpj12bzd+p7iK0tzO53lpcksDfqN8bwpFKDzEDlfeDCz3LrH?=
 =?us-ascii?Q?EfDhXhOk/e2g4c5cLj2VOxd4CBCNkUJXrUbLvu/rXZvVoE/qNlquwGGQEdvA?=
 =?us-ascii?Q?wV0RCAvSffDA8g0mdnisZcdsAC01+BzD/4ZbZAHUKOJdmpcpk8mLscx8GenX?=
 =?us-ascii?Q?BTgZ1uz97c6KiDQaA7hIpP+FM2ZrBtxMOoyhJbnd++KS1WExCDQQDWpZCICR?=
 =?us-ascii?Q?yOq+hknd9p8pKLMI9i5QMUCnxTeFxbRgN1Blv5Pxg1w3CrFKUMEwFx/7z9XT?=
 =?us-ascii?Q?Q1YnYoFLYU5tnNLzhRcIG40RKUFkP1ub5JnMHWSe6vrtuf6qMS6ZpPzxD5qW?=
 =?us-ascii?Q?ydl6BM0NSo3n8AS7S1qcRr0k31reGxbnOEJiX2/b0A+YLRQK9mJIrYgmXpuc?=
 =?us-ascii?Q?+SGjQMaqBM4TfYTTba1GiOSwTrfj6lEi4xPUyOVDHmu3dL1WWNBf1Wf3gP1Y?=
 =?us-ascii?Q?hJFOOAcaCI4PsQTanNmGE68dOGLYwHBaouhSfQ3DlqEm6pIJ6hHFIb5hfmLw?=
 =?us-ascii?Q?lETY7XmSLmK/2t/PRScimU/b?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a69745-2b6d-44c8-a077-08d931a9cd3d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:01.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib3YXXY6KyEQq8OSaj5jo60pNIjjfxFuHeIJyW+mez3UxA3YAj8k6CypSR162CBrDC8SxU5CDEWS/f779FvkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tcv_config.h | 333 ++++++++++++++++++
 1 file changed, 333 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv_config.h

diff --git a/drivers/net/wireless/celeno/cl8k/tcv_config.h b/drivers/net/wi=
reless/celeno/cl8k/tcv_config.h
new file mode 100644
index 000000000000..f849cecb5656
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tcv_config.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TCV_CONFIG_H
+#define CL_TCV_CONFIG_H
+
+#include "def.h"
+#include "ipc_shared.h"
+#include "wrs/wrs_db.h"
+#include "dfs/dfs_db.h"
+#include "edca.h"
+#include "utils/string.h"
+#include "sounding.h"
+
+/**
+ * TCV (=3DTranceiver) configuration, is related to the specific band on t=
op
+ * of specific chipset.
+ */
+
+#define CL_DEFAULT_HAL_IDLE_TIMEOUT 16000  /* Idle request - 16ms */
+#define CL_TX_DEFAULT_AC0_TIMEOUT   500000 /* Background - 500ms */
+#define CL_TX_DEFAULT_AC1_TIMEOUT   300000 /* Best effort - 300ms */
+#define CL_TX_DEFAULT_AC2_TIMEOUT   200000 /* Video - 200ms */
+#define CL_TX_DEFAULT_AC3_TIMEOUT   200000 /* Voice - 200ms */
+#define CL_TX_DEFAULT_BCN_TIMEOUT   150000 /* Beacon - 150ms */
+
+/* Minimal MPDU spacing we support in TX - correspond to FW NX_TX_MPDU_SPA=
CING */
+#define CL_TX_MPDU_SPACING_INVALID 0xFF
+
+/* Default Power Per MCS (PPMCS) offsets in Q1 format */
+#define PPMCS_DFLT_OFT_V1_MCS_0  8   /* 4.0 */
+#define PPMCS_DFLT_OFT_V1_MCS_1  8
+#define PPMCS_DFLT_OFT_V1_MCS_2  6   /* 3.0 */
+#define PPMCS_DFLT_OFT_V1_MCS_3  6
+#define PPMCS_DFLT_OFT_V1_MCS_4  6
+#define PPMCS_DFLT_OFT_V1_MCS_5  4   /* 2.0 */
+#define PPMCS_DFLT_OFT_V1_MCS_6  4
+#define PPMCS_DFLT_OFT_V1_MCS_7  0
+#define PPMCS_DFLT_OFT_V1_MCS_8  -2  /* -1.0 */
+#define PPMCS_DFLT_OFT_V1_MCS_9  -2
+#define PPMCS_DFLT_OFT_V1_MCS_10 -6  /* -3.0 */
+#define PPMCS_DFLT_OFT_V1_MCS_11 -10 /* -5.0 */
+
+#define PPMCS_DFLT_OFT_V2_MCS_0  6
+#define PPMCS_DFLT_OFT_V2_MCS_1  6
+#define PPMCS_DFLT_OFT_V2_MCS_2  4
+#define PPMCS_DFLT_OFT_V2_MCS_3  4
+#define PPMCS_DFLT_OFT_V2_MCS_4  4
+#define PPMCS_DFLT_OFT_V2_MCS_5  2
+#define PPMCS_DFLT_OFT_V2_MCS_6  2
+#define PPMCS_DFLT_OFT_V2_MCS_7  0
+#define PPMCS_DFLT_OFT_V2_MCS_8  -2
+#define PPMCS_DFLT_OFT_V2_MCS_9  -2
+#define PPMCS_DFLT_OFT_V2_MCS_10 -6
+#define PPMCS_DFLT_OFT_V2_MCS_11 -10
+
+#define PPMCS_DFLT_OFT_V3_MCS_0  6   /* 3.0 */
+#define PPMCS_DFLT_OFT_V3_MCS_1  6
+#define PPMCS_DFLT_OFT_V3_MCS_2  4   /* 2.0 */
+#define PPMCS_DFLT_OFT_V3_MCS_3  4
+#define PPMCS_DFLT_OFT_V3_MCS_4  4
+#define PPMCS_DFLT_OFT_V3_MCS_5  2   /* 1.0 */
+#define PPMCS_DFLT_OFT_V3_MCS_6  2
+#define PPMCS_DFLT_OFT_V3_MCS_7  0
+#define PPMCS_DFLT_OFT_V3_MCS_8  -2  /* -1.0 */
+#define PPMCS_DFLT_OFT_V3_MCS_9  -2
+#define PPMCS_DFLT_OFT_V3_MCS_10 -10 /* -5.0 */
+#define PPMCS_DFLT_OFT_V3_MCS_11 -10
+
+/* Default Power Per Bandwidth (PPBW) offsets in Q1 format*/
+#define PPBW_DFLT_OFT_BW_20  0
+#define PPBW_DFLT_OFT_BW_40  0
+#define PPBW_DFLT_OFT_BW_80  -2
+#define PPBW_DFLT_OFT_BW_160 -2
+
+enum {
+       CL_RATE_FALLBACK_COUNT_SU,
+       CL_RATE_FALLBACK_COUNT_MU,
+       CL_RATE_FALLBACK_RETRY_COUNT_THR,
+       CL_RATE_FALLBACK_BA_PER_THR,
+       CL_RATE_FALLBACK_BA_NOT_RECEIVED_THR,
+       CL_RATE_FALLBACK_DISABLE_MCS,
+
+       CL_RATE_FALLBACK_MAX,
+};
+
+struct cl_tcv_conf {
+       u8 ce_bss_num;
+       s8 ce_debug_level;
+       bool ce_radio_on;
+       bool ce_ps_ctrl_enabled;
+       u8 ha_channel;
+       bool ci_ieee80211w;
+       bool ci_ieee80211h;
+       u8 ha_short_guard_interval;
+       u8 ha_max_mpdu_len;
+       u8 ha_vht_max_ampdu_len_exp;
+       u32 ha_beacon_int;
+       s8 ce_dsp_code[STR_LEN_32B];
+       s8 ce_dsp_data[STR_LEN_32B];
+       s8 ce_dsp_external_data[STR_LEN_32B];
+       bool ce_uapsd_en;
+       bool ci_eirp_regulatory_en;
+       bool ci_agg_tx;
+       bool ci_agg_rx;
+       bool ce_txldpc_en;
+       bool ce_ht_rxldpc_en;
+       bool ce_vht_rxldpc_en;
+       bool ce_he_rxldpc_en;
+       bool ci_cs_required;
+       s8 ci_rx_sensitivity_prod[MAX_ANTENNAS];
+       s8 ci_rx_sensitivity_op[MAX_ANTENNAS];
+       bool ce_cck_bcn_en;
+       bool ci_min_he_en;
+       u8 ce_cck_tx_ant_mask;
+       u8 ce_cck_rx_ant_mask;
+       u8 ce_rx_nss;
+       u8 ce_tx_nss;
+       u8 ce_num_antennas;
+       u8 ce_wireless_mode;
+       bool ha_wmm_enabled[MAX_BSS_NUM];
+       u16 ce_max_agg_size_tx;
+       u16 ce_max_agg_size_rx;
+       bool ce_rxamsdu_en;
+       u8 ce_txamsdu_en;
+       u16 ci_tx_amsdu_min_data_rate;
+       u8 ci_tx_sw_amsdu_max_packets;
+       u16 ci_tx_packet_limit;
+       u16 ci_tx_queue_size_agg;
+       u16 ci_tx_queue_size_single;
+       u16 ci_ipc_rxbuf_size[CL_RX_BUF_MAX];
+       u16 ce_max_retry;
+       u8 ce_short_retry_limit;
+       u8 ce_long_retry_limit;
+       u8 ci_assoc_auth_retry_limit;
+       u8 ce_channel_bandwidth;
+       u8 ce_iface_type[MAX_BSS_NUM];
+       u8 ha_hw_mode;
+       s8 ce_temp_comp_slope;
+       u32 ci_fw_dbg_severity;
+       u32 ci_fw_dbg_module;
+       u32 ci_hal_idle_to;
+       u32 ci_tx_ac0_to;
+       u32 ci_tx_ac1_to;
+       u32 ci_tx_ac2_to;
+       u32 ci_tx_ac3_to;
+       u32 ci_tx_bcn_to;
+       s8 ce_hardware_power_table[STR_LEN_256B];
+       s8 ce_arr_gain[STR_LEN_32B];
+       s8 ce_bf_gain_2_ant[STR_LEN_32B];
+       s8 ce_bf_gain_3_ant[STR_LEN_32B];
+       s8 ce_bf_gain_4_ant[STR_LEN_32B];
+       s8 ce_bf_gain_5_ant[STR_LEN_32B];
+       s8 ce_bf_gain_6_ant[STR_LEN_32B];
+       s8 ce_ant_gain[STR_LEN_32B];
+       s8 ce_ant_gain_36_64[STR_LEN_32B];
+       s8 ce_ant_gain_100_140[STR_LEN_32B];
+       s8 ce_ant_gain_149_165[STR_LEN_32B];
+       s8 ci_min_ant_pwr[STR_LEN_32B];
+       s8 ci_bw_factor[STR_LEN_32B];
+       u8 ce_mcast_rate;
+       bool ce_dyn_mcast_rate_en;
+       bool ce_dyn_bcast_rate_en;
+       u8 ce_default_mcs_ofdm;
+       u8 ce_default_mcs_cck;
+       bool ce_prot_log_nav_en;
+       u8 ce_prot_mode;
+       u8 ce_prot_rate_format;
+       u8 ce_prot_rate_mcs;
+       u8 ce_prot_rate_pre_type;
+       u8 ce_bw_signaling_mode;
+       u8 ci_dyn_cts_sta_thr;
+       s8 ci_vns_pwr_limit;
+       u8 ci_vns_pwr_mode;
+       s8 ci_vns_rssi_auto_resp_thr;
+       s8 ci_vns_rssi_thr;
+       s8 ci_vns_rssi_hys;
+       u16 ci_vns_maintenance_time;
+       u16 ce_bcn_tx_path_min_time;
+       bool ci_backup_bcn_en;
+       bool ce_tx_txop_cut_en;
+       u8 ci_bcns_flushed_cnt_thr;
+       bool ci_phy_err_prevents_phy_dump;
+       u8 ci_tx_rx_delay;
+       u8 ci_fw_assert_time_diff_sec;
+       u8 ci_fw_assert_storm_detect_thd;
+       u32 ce_hw_assert_time_max;
+       u8 ce_fw_watchdog_mode;
+       u8 ce_fw_watchdog_limit_count;
+       u32 ce_fw_watchdog_limit_time;
+       s8 ci_rx_remote_cpu_drv;
+       s8 ci_rx_remote_cpu_mac;
+       s8 ci_tx_remote_cpu;
+       u16 ci_pending_queue_size;
+       u8 ce_tx_power_control;
+       bool ce_standby_mode_en;
+       bool ce_coex_en;
+       s8 ce_extension_channel;
+       u8 ci_dfs_initial_gain;
+       u8 ci_dfs_agc_cd_th;
+       u16 ci_dfs_long_pulse_min;
+       u16 ci_dfs_long_pulse_max;
+       s8 ce_dfs_tbl_overwrite[STR_LEN_64B];
+       s8 ce_dfs_jump_channels[STR_LEN_32B];
+       /* Power Per MCS values - 6g */
+       s8 ce_ppmcs_offset_he_6g[WRS_MCS_MAX_HE];
+       /* Power Per MCS values - 5g */
+       s8 ce_ppmcs_offset_he_36_64[WRS_MCS_MAX_HE];
+       s8 ce_ppmcs_offset_he_100_140[WRS_MCS_MAX_HE];
+       s8 ce_ppmcs_offset_he_149_165[WRS_MCS_MAX_HE];
+       s8 ce_ppmcs_offset_ht_vht_36_64[WRS_MCS_MAX_VHT];
+       s8 ce_ppmcs_offset_ht_vht_100_140[WRS_MCS_MAX_VHT];
+       s8 ce_ppmcs_offset_ht_vht_149_165[WRS_MCS_MAX_VHT];
+       s8 ce_ppmcs_offset_ofdm_36_64[WRS_MCS_MAX_OFDM];
+       s8 ce_ppmcs_offset_ofdm_100_140[WRS_MCS_MAX_OFDM];
+       s8 ce_ppmcs_offset_ofdm_149_165[WRS_MCS_MAX_OFDM];
+       /* Power Per MCS values - 24g */
+       s8 ce_ppmcs_offset_he[WRS_MCS_MAX_HE];
+       s8 ce_ppmcs_offset_ht[WRS_MCS_MAX_HT];
+       s8 ce_ppmcs_offset_ofdm[WRS_MCS_MAX_OFDM];
+       s8 ce_ppmcs_offset_cck[WRS_MCS_MAX_CCK];
+       /* Power Per BW values - all bands */
+       s8 ce_ppbw_offset[CHNL_BW_MAX];
+       bool ce_power_offset_prod_en;
+       bool ce_bf_en;
+       u8 ci_bf_max_nss;
+       u16 ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_MAX];
+       u8 ci_rate_fallback[CL_RATE_FALLBACK_MAX];
+       u16 ce_rx_pkts_budget;
+       u8 ci_band_num;
+       bool ci_mult_ampdu_in_txop_en;
+       u8 ce_wmm_aifsn[AC_MAX];
+       u8 ce_wmm_cwmin[AC_MAX];
+       u8 ce_wmm_cwmax[AC_MAX];
+       u16 ce_wmm_txop[AC_MAX];
+       u8 ci_su_force_min_spacing;
+       u8 ci_mu_force_min_spacing;
+       u8 ci_tf_mac_pad_dur;
+       u32 ci_cca_timeout;
+       u16 ce_tx_ba_session_timeout;
+       bool ci_motion_sense_en;
+       s8 ci_motion_sense_rssi_thr;
+       u8 ci_wrs_max_bw;
+       u8 ci_wrs_min_bw;
+       s8 ci_wrs_fixed_rate[WRS_FIXED_PARAM_MAX];
+       u8 ce_he_mcs_nss_supp_tx[WRS_SS_MAX];
+       u8 ce_he_mcs_nss_supp_rx[WRS_SS_MAX];
+       u8 ce_vht_mcs_nss_supp_tx[WRS_SS_MAX];
+       u8 ce_vht_mcs_nss_supp_rx[WRS_SS_MAX];
+       u8 ci_pe_duration;
+       u8 ci_pe_duration_bcast;
+       u32 ci_coredump_diff_time_ms;
+       u8 ci_gain_update_enable;
+       u8 ci_mcs_sig_b;
+       u8 ci_spp_ksr_value;
+       bool ci_rx_padding_en;
+       bool ci_stats_en;
+       bool ci_bar_disable;
+       bool ci_ofdm_only;
+       bool ci_drop_to_lower_bw;
+       bool ce_twt_en;
+       u32 ce_twt_default_interval;
+       u32 ce_twt_default_min_wake_duration;
+       u8 ce_twt_max_sessions;
+       u8 ci_hr_factor[CHNL_BW_MAX];
+       bool ci_csd_en;
+       bool ci_signal_extension_en;
+       bool ce_dscp_vlan_enable[MAX_BSS_NUM];
+       u8 ce_up0_7_default_vlan_user_prio[MAX_BSS_NUM];
+       u8 ce_up0_7_layer_based[MAX_BSS_NUM];
+       s8 ce_dscp_to_up0_7dec0[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec1[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec2[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec3[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec4[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec5[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec6[STR_LEN_128B];
+       s8 ce_dscp_to_up0_7dec7[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec0[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec1[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec2[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec3[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec4[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec5[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec6[STR_LEN_128B];
+       s8 ce_vlan_to_up0_7dec7[STR_LEN_128B];
+       bool ci_vht_cap_24g;
+       bool ce_omi_en;
+       u32 ci_tx_digital_gain;
+       u32 ci_tx_digital_gain_cck;
+       s8 ci_ofdm_cck_power_offset;
+       bool ci_mac_clk_gating_en;
+       bool ci_phy_clk_gating_en;
+       bool ci_imaging_blocker;
+       u8 ci_ndp_tx_chain_mask;
+       u8 ci_ndp_tx_bw;
+       u8 ci_ndp_tx_format;
+       u8 ci_ndp_tx_num_ltf;
+       u8 ci_calib_ant_tx[MAX_ANTENNAS];
+       u8 ci_calib_ant_rx[MAX_ANTENNAS];
+       s8 ci_cca_ed_rise_thr_dbm;
+       s8 ci_cca_ed_fall_thr_dbm;
+       u8 ci_cca_cs_en;
+       u8 ci_cca_modem_en;
+       u8 ci_cca_main_ant;
+       u8 ci_cca_second_ant;
+       u8 ci_cca_flag0_ctrl;
+       u8 ci_cca_flag1_ctrl;
+       u8 ci_cca_flag2_ctrl;
+       u8 ci_cca_flag3_ctrl;
+       s8 ci_cca_gi_rise_thr_dbm;
+       s8 ci_cca_gi_fall_thr_dbm;
+       s8 ci_cca_gi_pow_lim_dbm;
+       u16 ci_cca_ed_en;
+       u8 ci_cca_gi_en;
+       bool ci_rx_he_mu_ppdu;
+       bool ci_fast_rx_en;
+       u8 ci_distance_auto_resp_all;
+       u8 ci_distance_auto_resp_msta;
+
+       /* New NVRAM parameters must be added to cl_tcv_config_print() */
+};
+
+struct cl_hw;
+
+int cl_tcv_config_read(struct cl_hw *cl_hw);
+int cl_tcv_config_set(struct cl_hw *cl_hw, char *buf, size_t size);
+u8 cl_tcv_config_get_num_ap(struct cl_hw *cl_hw);
+int cl_tcv_config_alloc(struct cl_hw *cl_hw);
+void cl_tcv_config_free(struct cl_hw *cl_hw);
+void cl_tcv_config_print(struct cl_hw *cl_hw);
+
+#endif /* CL_TCV_CONFIG_H */
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

