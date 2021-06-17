Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B253AB896
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhFQQJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:06 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:44002
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232723AbhFQQID (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GplvK7dMZl9hNAKTK23C9x+6M80SeKi73AaoJbDkcNeOqW3WTiYyLegCRLrJ7yJ5MxcUhCaOHk/1VUYW6cM4sK9uAijIRgA4Lb878RkB+eXqgRp2FyIfLjgB4c0F8rtufFc1TlIPF8X01oI6/wy4GUUgf3BnCiHW6VZNsa0AGOHOZ+QQIzGA5bwnmkSyIjg7YPjcD2/DOdBUmZ5hSeC9uBSR07DEGg+88BvflELvw1khqW2dOtUpwKdSXwld5loJxoxvSEl2Y2/vSHM1ef6kVLoMcks8fgekbKbenJyFMdEaUfpJYiSiK4lonmXFfy8QPnUk3Vr3/SZbpY369FkMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cftqKk8CJNQMtetJC/ogXM7L567JqH2DQHp0UXWr7Z4=;
 b=Ugc+zEjrqpUQ7JKRa3k/hIWCCpdl9PoGVqZnzIfM/BPSqiWIN6q66Z3EuQjuNW9KGbg8cE4eYKxBDwH05xQwzIwKfZVggkYjP6PVPw4LvW6BLTcT2kOR1R99Ld6N9FwuRP6sLX+EfmMZxrWQZfEsyC514Sr7KpFqV6NRg6pWq9zvzlI8tsNBkByDkTVklljBHBOoPXetopxgG67wnFNhSsm6gQy7GjTLc5S16k0kjx1Y7gYvZqbI9IWxGN2ZkKAIwCaWqg+JYhqfKRLDExXnIK7K1x0+9HvpOTTKMFwVQOTPcq2WBPVbjvjqvI//LXpFtmzszn+x90pYihV4EaGeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cftqKk8CJNQMtetJC/ogXM7L567JqH2DQHp0UXWr7Z4=;
 b=2a/XCcROmASVCjxQ6eI7M+780T69N5MBS7F6kEv4czQnXnkKR0QVEcJorjaNR1MxVzus1k8j2Xar0lESAB+hwn8bcZ6c7vFrHGqHYu8NuU/adBAuCu25LyqW/TlYjISB7cJvrrw4mQ6gDiCkWmPByNmVT2uYejic56UgGlew0uE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:03 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:03 +0000
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
Subject: [RFC v1 099/256] cl8k: add hw.h
Date:   Thu, 17 Jun 2021 15:59:46 +0000
Message-Id: <20210617160223.160998-100-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: debbfd1a-92ab-48c9-2d50-08d931a992e9
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887617E1E0934093F00BFAAF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8alwTrzAmVJ2Md1n7a1+LkhWQUuxUXZ0I4eh7ADc56+Hx+kUVaDv617MiFcRt3gs5TLGvMTXq2EXHYinNFuGceZlD5ZSHzlmWTx61yGdWv90+RIqjRAyyBkwj42v/0wqDHlYH76wASRPHFwO8y19Qo0WuUiU52LeWyaHVgVz1UEZJ6/m3Jdr4ZWsf2Zt2eYoAy9dtZmhqCFqPNuSGfD6CGbzjwKyp6bYeLXZp86cneZ/gsaNyEA5eraSm4YFJA07lQjMXU6a6e/bfak16ziEk6BwX9GVmR6BfuP0bx2iCKF60KsZwZmvAdzkVX+6RkKMJhAVqh0Ydt+0kaqGC4mdqQUbN/rMEQ8JN+5abtGFs7Rz4u92E4vHf3gTpQ8teCVrjpBx+dkFIG30hRVcc7PM1S/tztW9KVwM4J8nDfG2B/b8G53PVMzYL1/acdBmyNXj2xeCJsqOs6lXvfutkjzwuram9VX6In8dACRyW6WXndHNJdGDmE+IoQ0anj02QoQWQEEiI30lqERqPY++KTI+F9zynNO8K5fL9T+yZJFzQjzPUK9Pfbmy6U8aRsH1u1ILsKz4pBbIjMuFJyETkD+7EA9+4/4u1byoE8RtyeAOU58De8eAcLF2MNzVk2ROfJn2VwptOHYrCRSDU+PN9YGOZyGVJtYPL3TEm56SddxTL5oQq/XmClQ021TCaRovEA9DvSHkvi8Bd9z5ec13ei19g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(30864003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FGft5+QP+AuMS1YmhEcmhfSxtXPIHJ7Q4Cxs1w/GAzfiYWOgvD1qsKXyENG?=
 =?us-ascii?Q?ZuVFOxEZV5SHHWPk/8o9KafuQmyxbQlMUz9ouWKbvtwjV2vTq6Es1TebX3Lv?=
 =?us-ascii?Q?QJqZhVazFjsMMoJbyXJupU9+Ti7zedc0W4dXuB785qBl6aBTLQ3jrSz2BttT?=
 =?us-ascii?Q?IDzRZmTGSdL4HdEQ5AHwKWgrNKuIZSo2lG4IdwMnmAfNGFslyMsawdOJugdZ?=
 =?us-ascii?Q?U3mcVkCb/An0XUbdA+WcdfWnKs5EZAUhlqVrraakHFY13WKJCEgJLLAEeZmw?=
 =?us-ascii?Q?t2v6IVxqx4j9LmEHEkMYqV7LbNg9iAejahX1KOngo3xQAUp8sLO5Lkpwsbzg?=
 =?us-ascii?Q?F/BqktsXpq0yq26IUR/v+/D6f956fP4QQZoL/GSa2C/qv/0ef4NQbZmmthGH?=
 =?us-ascii?Q?qs5pzRFSnHt53pl9jlCToTt35XQiQPqFyFc6CLtkS2yAKNISHGuxC6AQ0Qke?=
 =?us-ascii?Q?liVpSoTUefouyeApfNG9t8FYGFlpIOP9r+8eFUw2jSX2NladwFvLiPQv/APt?=
 =?us-ascii?Q?s24I53HfDjRBvLnFTgXJe/AwJp5CzMkUH6T/xH4gWp4yg5XAz9UBkDTj6Ttb?=
 =?us-ascii?Q?RzFfBEMvxLIlFhdW7FodsUejtmAsXlm5CXlMzFGpjzh5kYz9CUifAgxugugt?=
 =?us-ascii?Q?hVManVxhw0jyp5gmwbQCcilYAIkHsMo2e8s5IdLTi5dsHKS9A6z1wSY33986?=
 =?us-ascii?Q?xrhvd2abMMr3jRKVHPBrdu3ZM8Sp7fkP480ayCBQrcJUxB1yqihUmJRjxpH4?=
 =?us-ascii?Q?EkW1ML8Iyg6YAVroTHjV4MR6sEnNLyr9XbufAWg9+t3/A5WwSTviU2A8QpbY?=
 =?us-ascii?Q?KX4YapNT1M4NtVLGGiTBeqsoXaN1Q5RxN5NaxR9bsgzkKb94b0gJP7a6rxCA?=
 =?us-ascii?Q?Jj93fBIY6E+PgEzL46YyE0J/Kav4LchLFK2Dj3qgIp2q92cxgDNRI8v18mtC?=
 =?us-ascii?Q?LxWygEcEglk60wtDyv/4P3giwmv0W5ICqFlyAkvAiu6+BkMxW5SGYaGK8HcC?=
 =?us-ascii?Q?SFVpcaCHNnNCwLCrEsKRIJMVR7xEcqRoxINz6YCRFAroJEDG3zhGJ1CiwejY?=
 =?us-ascii?Q?XE1CgFnn+JoNMcj2ZkNmMGc9AgxgDZ75NDarkgH1Oj45AwQITKPUR3hvwjB7?=
 =?us-ascii?Q?uBW30CAVvQoGeZLHnk4ZW4k2hjukbA5Dytm92bDLyIemIDH/E3va9ASKC7pL?=
 =?us-ascii?Q?IEuatNw+3PGcIBmhy29IF8UmTyjsca2HJCPGmniJR1gZWtXvtpsPU+yTr5dH?=
 =?us-ascii?Q?6e/5JnQJxYupSpRjAg4/gknzQpIANSQzU51OvFUjzYe/KJ7g0Lw3du47gnXX?=
 =?us-ascii?Q?PthiOWvmAMVUwRzWy2ycnwJ8?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debbfd1a-92ab-48c9-2d50-08d931a992e9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:23.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ORoGdU8R7fe+fmeejr+GEj7/+Xg/joNSdGwGkF+jfxFiRtxveUe8GPlrikIokpPKnj8phkhpAXqhvlnhQnTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/hw.h | 797 ++++++++++++++++++++++++++
 1 file changed, 797 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.h

diff --git a/drivers/net/wireless/celeno/cl8k/hw.h b/drivers/net/wireless/c=
eleno/cl8k/hw.h
new file mode 100644
index 000000000000..17f8f14b9891
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/hw.h
@@ -0,0 +1,797 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_HW_H
+#define CL_HW_H
+
+#include "wrs/wrs_db.h"
+#include "traffic.h"
+#include "edca.h"
+#include "env_det.h"
+#include "temperature.h"
+#include "dfs/dfs_db.h"
+#include "chan_info.h"
+#include "calib.h"
+#include "debugfs_defs.h"
+#include "ipc_shared.h"
+#include "fw/fw_msg.h"
+#include "dfs/radar.h"
+#include "rate_ctrl.h"
+#include "power_table.h"
+#include "cca.h"
+#include "def.h"
+#include "noise.h"
+#include "mac80211.h"
+#include "tcv_config.h"
+#include "sounding.h"
+#include "rsrc_mgmt.h"
+#include "channel.h"
+#include <linux/workqueue.h>
+#include <linux/module.h>
+
+/* Max flags for driver status description is defined as 32 * MAX_CFM_FLAG=
S */
+#define MAX_CFM_FLAGS 2
+
+enum cl_radio_stats {
+       CL_RADIO_FCS_ERROR =3D 0,
+       CL_RADIO_PHY_ERROR,
+       CL_RADIO_RX_FIFO_OVERFLOW,
+       CL_RADIO_ADDRESS_MISMATCH,
+       CL_RADIO_UNDEFINED_ERROR,
+       CL_RADIO_ERRORS_MAX
+};
+
+struct cl_rx_path_info {
+       u32 rx_desc[CL_RX_BUF_MAX];
+       u32 elem_alloc_fail;
+       u32 skb_null;
+       u32 pkt_drop_amsdu_corrupted;
+       u32 pkt_drop_sub_amsdu_corrupted;
+       u32 pkt_drop_amsdu_len_error;
+       u32 pkt_drop_sub_amsdu_len_error;
+       u32 pkt_drop_wrong_pattern;
+       u32 pkt_drop_not_success;
+       u32 pkt_drop_unencrypted;
+       u32 pkt_drop_decrypt_fail;
+       u32 pkt_drop_rxhdr_len_error;
+       u32 pkt_drop_sta_null;
+       u32 pkt_drop_host_limit;
+       u32 netif_rx;
+       u32 remote_cpu[CPU_MAX_NUM];
+       u32 exceed_pkt_budget;
+       u32 pkt_handle_bucket_rxm[IPC_RXBUF_NUM_BUCKETS_RXM];
+       u32 pkt_handle_bucket_fw[IPC_RXBUF_NUM_BUCKETS_FW];
+       u32 amsdu_cnt[RX_MAX_MSDU_IN_AMSDU];
+       u32 non_amsdu;
+       u32 buffer_process_irq;
+       u32 buffer_process_tasklet;
+};
+
+/* Structure used to store information regarding E2A msg buffers in the dr=
iver */
+struct cl_e2a_msg_elem {
+       struct cl_ipc_e2a_msg *msgbuf_ptr;
+       dma_addr_t dma_addr;
+};
+
+/* Structure used to store information regarding Debug msg buffers in the =
driver */
+struct cl_dbg_elem {
+       struct cl_ipc_dbg_msg *dbgbuf_ptr;
+       dma_addr_t dma_addr;
+};
+
+struct cl_tx_power_info {
+       s8 power;
+       s8 offset;
+       s8 temperature;
+};
+
+struct cl_rx_elem {
+       int passed;
+       struct sk_buff *skb;
+       dma_addr_t dma_addr;
+};
+
+struct cl_dbg_info {
+       struct mutex mutex;
+       struct dbg_info *buf;
+       dma_addr_t dma_addr;
+       int bufsz;
+       struct timespec64 trigger_tstamp;
+};
+
+struct cl_dbg_data {
+       char *str; /* Pointer to debug strings start address */
+       int size; /* Size of debug strings pool */
+};
+
+struct cl_phy_data_info {
+       struct cl_phy_data *data;
+       u32 dma_addr;
+};
+
+struct cl_sec_phy_chan {
+       u16 prim20_freq;
+       u16 center_freq1;
+       u16 center_freq2;
+       enum nl80211_band band;
+       u8 type;
+};
+
+struct cl_amsdu_rx_state {
+       u8 msdu_cnt;
+       u8 msdu_remaining_cnt;
+       /*
+        * MSDU padding - all MSDU pkt within A-MSDU are 4byte aligned (thi=
s
+        * value holds the alignment value)
+        * According to ieee80211 spec all MSDU share the same alignment
+        */
+       u8 msdu_dma_align;
+       u8 amsdu_error;
+       u8 encrypt_len;
+       u8 sta_idx;
+       u8 tid;
+       u32 packet_len;
+       struct hw_rxhdr *rxhdr;
+       struct sk_buff *first_skb;
+       struct sk_buff_head frames;
+};
+
+struct cl_tx_queue {
+       struct list_head sched_list;
+       struct list_head hdrs;
+       struct cl_sta *cl_sta;
+       bool sched;
+       u16 fw_free_space;
+       u16 fw_max_size;
+       u8 type;
+       u8 tid;
+       u8 hw_index;
+       u16 index;
+       u16 max_packets;
+       u16 num_packets;
+       u32 total_packets;
+       u32 total_fw_push_desc;
+       u32 total_fw_push_skb;
+       u32 total_fw_cfm;
+       u32 dump_queue_full;
+       u32 dump_dma_map_fail;
+       u32 stats_hw_amsdu_cnt[CL_AMSDU_TX_PAYLOAD_MAX];
+       u32 stats_sw_amsdu_cnt[MAX_TX_SW_AMSDU_PACKET];
+};
+
+struct cl_req_agg_db {
+       bool is_used;
+       u8 sta_idx;
+       u8 tid;
+};
+
+/*
+ * struct cl_tx_queues:
+ * This structure holds all driver TX queues,
+ * The queues buffer frames pushed by upper layer and push them to lower I=
PC layer.
+ */
+struct cl_tx_queues {
+       struct cl_tx_queue agg[IPC_MAX_BA_SESSIONS];
+       struct cl_tx_queue single[MAX_SINGLE_QUEUES];
+       struct cl_tx_queue bcmc;
+};
+
+struct cl_prot_mode {
+       u8 current_val;
+       u8 default_val;
+       u8 dynamic_val;
+};
+
+struct mac_entry {
+       struct cl_hw *cl_hw;
+       struct list_head list;
+       time64_t kt_sec;
+       u8 addr[ETH_ALEN];
+       u8 state;
+       bool assoc_flag;
+       unsigned long allow_time;
+       spinlock_t entry_lock;
+       struct cl_timer timer;
+       struct cl_timer allow_timer;
+       struct work_struct cross_allow_time_work;
+};
+
+struct mac_drv {
+       struct mac_entry mac;
+       u16 list_size;
+};
+
+struct cl_hw_asserts_info {
+
+       /* Timestamp (jiffies) of the last CL_MIN_ASSERT_CNT hw assert. */
+       unsigned long timestamp[CL_MIN_ASSERT_CNT];
+       /* Hw assert index. */
+       u8 index;
+       /* Indicate if hw_restart was schedule */
+       u8 restart_sched;
+       /* Indicate if hw_restart is needed due to unrecoverable assert. */
+       u8 restart_needed;
+};
+
+struct cl_ate_db {
+       bool active;
+       s8 tx_power;
+       s8 tx_power_offset[MAX_ANTENNAS];
+       u8 ant_mask;
+       u8 mode;
+       u8 bw;
+       u8 nss;
+       u8 mcs;
+       u8 gi;
+       u8 ltf;
+       struct ate_stats stats;
+};
+
+struct cl_agg_cfm_queue {
+       struct list_head head;
+       struct cl_tx_queue *tx_queue;
+       u16 ssn;
+};
+
+struct cl_single_cfm_queue {
+       struct list_head head;
+};
+
+struct cl_assoc_queue {
+       struct list_head list;
+       spinlock_t lock;
+};
+
+struct cl_agc_cd {
+       /* Configuration */
+       u32 period;
+       bool debug;
+       /* Internal parameters */
+       bool is_on;
+       bool use_hystersis;
+       u32 maintenance;
+};
+
+struct cl_dyn_mcast_rate {
+       u8 wrs_mode_default;
+       u8 wrs_mode_curr;
+};
+
+struct cl_dyn_bcast_rate {
+       u8 sta_min_mcs;
+       u8 bcast_mcs;
+       u8 wrs_mode;
+       u8 ltf;
+};
+
+struct cl_power_db {
+       u8 curr_percentage;
+       s8 curr_offset;
+       /* Used to validate margins of MAC power */
+       s8 bw_factor_q2[CHNL_BW_MAX];
+       s8 ant_factor_q2[MAX_ANTENNAS];
+};
+
+struct cl_bf_db {
+       bool force;
+       enum cl_dbg_level dbg_level;
+};
+
+struct cl_vns_rssi_entry {
+       struct list_head list_all;
+       struct list_head list_addr;
+       unsigned long timestamp;
+       s8 strongset_rssi;
+       u8 addr[ETH_ALEN];
+};
+
+#define STA_HASH_SIZE 256
+
+struct cl_vns_mgmt_db {
+       u32 num_entries;
+       struct list_head list_all;
+       struct list_head list_addr[STA_HASH_SIZE];
+};
+
+struct cl_vns_db {
+       bool enable;
+       bool dbg;
+       bool dbg_per_packet;
+       u16 interval_period;
+       spinlock_t lock;
+       struct cl_vns_mgmt_db mgmt_db;
+};
+
+/* Cl_dbgfile.c - offload data */
+struct cl_str_offload_env {
+       char *block1;
+       u32 size1;
+       u32 base1;
+       char *block2;
+       u32 size2;
+       u32 base2;
+       char *block3;
+       u32 size3;
+       u32 base3;
+       bool enabled;
+       char buf[512];
+};
+
+struct cl_dma_accessed {
+       void *drv_v_addr;
+       u32 size;
+       u32 fw_v_addr;
+       u32 dma_addr;
+};
+
+struct cl_radar_queue {
+       struct list_head head;
+       spinlock_t lock;
+};
+
+struct cl_recovery_db {
+       unsigned long last_restart;
+       u32 restart_cnt;
+
+       u32 ela_en;
+       u32 ela_sel_a;
+       u32 ela_sel_b;
+       u32 ela_sel_c;
+
+       bool in_recovery;
+};
+
+struct cl_noise_reg {
+       struct list_head list;
+       u32 np_prim20_per_ant;
+       u32 np_prim20_per_ant2;
+       u32 nasp_prim20_per_ant;
+       u32 nasp_prim20_per_ant2;
+       u32 np_sub20_per_chn;
+       u32 np_sub20_per_chn2;
+       u32 nasp_sub20_per_chn;
+       u32 nasp_sub20_per_chn2;
+       u32 np_sec20_dens_per_ant;
+       u32 nasp_sec20_dens_per_ant;
+};
+
+struct cl_noise_db {
+       struct list_head reg_list;
+       bool hist_record;
+       u8 active_ant;
+       u8 sample_cnt;
+};
+
+struct cl_chan_info {
+       u8 channel;
+       u8 max_bw;
+       /* Resolution of 0.25dB */
+       u8 max_power_q2; /* MIN(country_max_power_q2, hardware_max_power_q2=
) */
+       u8 country_max_power_q2;
+       u8 hardware_max_power_q2;
+};
+
+struct cl_channel_info {
+       bool use_channel_info;
+       struct cl_chan_info channels[CHNL_BW_MAX][MAX_CHANNELS];
+       enum cl_reg_standard standard;
+       struct ieee80211_regdomain *rd;
+};
+
+#define CL_STA_HASH_SIZE (CL_MAX_NUM_STA / 2)
+#define CL_STA_HASH_MASK (CL_STA_HASH_SIZE - 1)
+#define CL_STA_HASH_IDX(x) ((x) & CL_STA_HASH_MASK)
+
+struct cl_sta_db {
+       struct list_head head;
+       struct cl_sta *lut[CL_MAX_NUM_STA];
+       struct list_head hash[CL_STA_HASH_SIZE];
+       rwlock_t lock;
+       u32 num;
+};
+
+struct cl_tx_inject {
+       bool continuous;
+       bool is_running;
+       bool aggressive_edca;
+       u32 alloc_counter;
+       u32 current_counter;
+       u32 max_counter;
+       u32 packet_len;
+       struct cl_sta *cl_sta;
+       struct tasklet_struct tasklet;
+};
+
+#define CL_USER_PRIO_VALS 8
+#define CL_USER_DSCP_VALS 64
+
+struct cl_vid_user {
+       u16 vid;
+       u8 user_prio;
+};
+
+struct cl_vlan_dhcp_params {
+       /* DSCP to user priority mapping */
+       u8 dscp_to_up[CL_USER_DSCP_VALS];
+       /* VLAN to user priority mapping */
+       u8 vlan_to_up[CL_USER_PRIO_VALS];
+       /*
+        * Vid-pbit to user priority mapping
+        * First index is the pbit. Second index is a running index 0
+        */
+       struct cl_vid_user vlan_pbit_to_up[CL_USER_PRIO_VALS][CL_USER_PRIO_=
VALS];
+       /* 2 - "VLAN" VLAN based only, 3 - "DSCP" DSCP based only. Any othe=
r number - Automatic */
+       u8 up_layer_based;
+       u8 default_vlan_up;
+};
+
+struct cl_vlan_dscp {
+       struct cl_vlan_dhcp_params vlan_dhcp_params[MAX_BSS_NUM];
+       bool enable[MAX_BSS_NUM];
+       bool debug;
+};
+
+struct cl_controller_reg {
+       u32 breset;
+       u32 debug_enable;
+       u32 dreset;
+       u32 ocd_halt_on_reset;
+       u32 run_stall;
+};
+
+struct cl_busytime_stats {
+       u32 rx_mine_time_us;
+       u32 tx_mine_time_us;
+       u32 edca_cca_busy_us;
+};
+
+#define CCA_MAX_SAMPLE 21
+
+struct cl_edca_hist_db {
+       u16 air_util[CCA_MAX_SAMPLE];
+       u16 wifi_air_util[CCA_MAX_SAMPLE];
+       u16 not_mine_rx_wifi[CCA_MAX_SAMPLE];
+       u16 mine[CCA_MAX_SAMPLE];
+       u16 not_mine[CCA_MAX_SAMPLE];
+       u16 non_wifi_util[CCA_MAX_SAMPLE];
+       u16 not_mine_busy[CCA_MAX_SAMPLE];
+       u16 sample_cnt;
+};
+
+struct cl_cca_db {
+       struct cl_edca_hist_db edca_hist;
+       unsigned long time;
+       u32 edca_busy;
+       u32 edca_busy_sec20;
+       u32 edca_busy_sec40;
+       u32 edca_busy_sec80;
+       u32 cca_busy_nav;
+       u32 cca_intra_bss_nav;
+       u32 cca_inter_bss_nav;
+       u32 tx_mine;
+       u32 rx_mine;
+       u32 print_tx_mine;
+       u32 print_rx_mine;
+       enum cl_cca_opt cca_opt;
+};
+
+struct cl_cpu_cntr {
+       u32 tx_agg[CPU_MAX_NUM];
+       u32 tx_single[CPU_MAX_NUM];
+};
+
+struct cl_tx_drop_cntr {
+       u32 wd_restart;
+       u32 radio_off;
+       u32 in_recovery;
+       u32 short_length;
+       u32 pending_full;
+       u32 packet_limit;
+       u32 dev_flags;
+       u32 tx_disable;
+       u32 length_limit;
+       u32 txhdr_alloc_fail;
+       u32 queue_null;
+       u32 amsdu_alloc_fail;
+       u32 amsdu_dma_map_err;
+       u32 build_hdr_fail;
+       u32 key_disable;
+       u32 queue_flush;
+       u32 sta_null_in_agg;
+};
+
+struct cl_tx_forward_cntr {
+       u32 tx_start;
+       u32 drv_fast_agg;
+       u32 drv_fast_single;
+       u32 to_mac;
+       u32 from_mac_single;
+       u32 from_mac_agg;
+};
+
+struct cl_tx_transfer_cntr {
+       u32 single_to_agg;
+       u32 agg_to_single;
+};
+
+struct cl_tx_packet_cntr {
+       struct cl_tx_forward_cntr forward;
+       struct cl_tx_drop_cntr drop;
+       struct cl_tx_transfer_cntr transfer;
+};
+
+struct cl_power_truncate {
+       u8 he[CHNL_BW_MAX][WRS_MCS_MAX_HE][PWR_TBL_HE_BF_SIZE];
+       u8 ht_vht[CHNL_BW_MAX][WRS_MCS_MAX_VHT][PWR_TBL_VHT_BF_SIZE];
+       u8 ofdm[WRS_MCS_MAX_OFDM];
+       u8 cck[WRS_MCS_MAX_CCK];
+};
+
+#define CL_TWT_MAX_SESSIONS 8
+
+struct cl_twt_session_db {
+       struct cl_sta *cl_sta;
+       struct ieee80211_twt_individual_elem twt_setup;
+};
+
+struct cl_twt_db {
+       struct cl_twt_session_db cl_twt_sessions[CL_TWT_MAX_SESSIONS];
+       u8 num_sessions;
+       u8 dialog_token;
+};
+
+struct cl_vif_db {
+       struct list_head head;
+       u8 num_iface_bcn;
+};
+
+enum cl_rx_stats_flag {
+       RX_STATS_CCK =3D 0x01,
+       RX_STATS_OFDM =3D 0x02,
+       RX_STATS_HT =3D 0x04,
+       RX_STATS_VHT =3D 0x08,
+       RX_STATS_HE_SU =3D 0x10,
+       RX_STATS_HE_MU =3D 0x20,
+       RX_STATS_HE_EXT =3D 0x40,
+       RX_STATS_HE_TRIG =3D 0x80,
+};
+
+struct cl_rx_stats {
+       u32 he_trig[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_=
HE];
+       u32 he_ext[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_H=
E];
+       u32 he_mu[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE=
];
+       u32 he_su[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE=
];
+       u32 vht[CHNL_BW_MAX_VHT][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VH=
T];
+       u32 ht[CHNL_BW_MAX_HT][WRS_SS_MAX][WRS_MCS_MAX_HT][WRS_GI_MAX_HT];
+       u32 ofdm[WRS_MCS_MAX_OFDM];
+       u32 cck[WRS_MCS_MAX_CCK];
+       u8 flag;
+};
+
+struct cl_fw_dbg {
+       char *buf;
+       int len;
+};
+
+struct cl_rx_trigger_based_stats {
+       bool enable;
+       u8 ampdu_cnt;
+       u16 data_per_agg;
+       u16 qos_null_per_agg;
+       u32 total;
+       u32 data[DBG_STATS_MAX_AGG_SIZE];
+       u32 qos_null[TID_MAX + 2];
+};
+
+enum cl_iface_conf {
+       CL_IFCONF_AP,
+       CL_IFCONF_STA,
+       CL_IFCONF_REPEATER,
+       CL_IFCONF_MESH_AP,
+       CL_IFCONF_MESH_ONLY,
+
+       CL_IFCONF_MAX
+};
+
+struct cl_vendor_msg {
+       u8 *buf;
+       u16 len;
+       u16 offset;
+       bool in_process;
+};
+
+struct cl_driver_ops {
+       int (*msg_fw_send)(struct cl_hw *cl_hw,
+                          const void *msg_params,
+                          bool background);
+       void (*pkt_fw_send)(struct cl_hw *cl_hw,
+                           struct cl_sw_txhdr *sw_txhdr,
+                           struct cl_tx_queue *tx_queue);
+};
+
+struct cl_version_db {
+       u32 dsp;
+       u32 rfic_sw;
+       u32 rfic_hw;
+       u32 agcram;
+       char fw[CL_VERSION_STR_SIZE];
+       char drv[CL_VERSION_STR_SIZE];
+       unsigned long last_update;
+};
+
+struct cl_cached_fw {
+       void *data;
+       size_t size;
+};
+
+struct cl_hw {
+       u8 idx; /* Global index (0-3) */
+       u8 tcv_idx; /* Transceiver index (0-1) */
+       struct cl_tcv_conf *conf;
+       struct cl_chip *chip;
+       struct ieee80211_hw *hw;
+       const struct cl_driver_ops *drv_ops;
+       struct cl_vif_db vif_db;
+       struct cl_fw_dbg fw_dbg;
+       enum cl_iface_conf iface_conf;
+       u32 num_ap_started;
+       u8 tx_power_version;
+       struct cl_vif *mc_vif;
+       u8 bw;
+       u32 channel;
+       u32 primary_freq;
+       u32 center_freq;
+       enum nl80211_band nl_band;
+       u8 num_antennas;
+       u8 mask_num_antennas;
+       u8 first_ant;
+       u8 last_ant;
+       u8 max_antennas;
+       u8 max_mu_cnt;
+       struct cl_sta_db cl_sta_db;
+       struct cl_ipc_e2a_irq ipc_e2a_irq;
+       struct cl_controller_reg controller_reg;
+       struct ieee80211_supported_band sband;
+       void (*ipc_host2xmac_trigger_set)(struct cl_chip *chip, u32 value);
+       unsigned long drv_flags;
+       unsigned long tx_disable_flags;
+       struct cl_ipc_host_env *ipc_env;
+       spinlock_t tx_lock_agg;
+       spinlock_t tx_lock_cfm_agg;
+       spinlock_t tx_lock_single;
+       spinlock_t tx_lock_bcmc;
+       struct mutex msg_tx_mutex;
+       wait_queue_head_t wait_queue; /* Synchronize driver<-->firmware mes=
sage exchanges */
+       unsigned long cfm_flags[MAX_CFM_FLAGS];
+       void *msg_cfm_params[MM_MAX + DBG_MAX]; /* Array of pointers per re=
ceived msg CFM */
+       bool msg_background;
+       wait_queue_head_t fw_sync_wq;
+       wait_queue_head_t radio_wait_queue;
+       struct cl_rx_elem *rx_elems;
+       struct cl_e2a_msg_elem *e2a_msg_elems;
+       struct cl_dbg_elem *dbg_elems;
+       struct cl_radar_elem *radar_elems;
+       struct dma_pool *txdesc_pool;
+       struct dma_pool *dbg_pool;
+       struct dma_pool *e2a_msg_pool;
+       struct dma_pool *radar_pool;
+       struct cl_dbg_info dbginfo;
+       struct cl_debugfs debugfs;
+       struct cl_hw_asserts_info assert_info;
+       char fw_prefix; /* Single character for fw prefix - l/u/s */
+       u8 fw_dst_kern_id; /* Firmware destination (LMAC/SMAC) */
+       bool fw_active;
+       bool fw_send_start; /* Did driver already send a start request mess=
age to firmware? */
+       struct cl_tx_inject tx_inject;
+       bool chandef_set;
+       struct cl_dbg_data dbg_data;
+       bool set_calib;
+       struct cl_tx_power_info tx_pow_info[MAX_CHANNELS][MAX_ANTENNAS];
+       struct cl_channel_info channel_info;
+       struct cl_phy_data_info phy_data_info;
+       u32 mask_hi;
+       u32 mask_low;
+       struct cl_timer maintenance_slow_timer;
+       struct cl_timer maintenance_fast_timer;
+       struct tasklet_struct tx_task;
+       struct list_head list_sched_q_agg;
+       struct list_head list_sched_q_single;
+       struct cl_ate_db ate_db;
+       struct cl_env_db env_db;
+       struct cl_req_agg_db req_agg_db[IPC_MAX_BA_SESSIONS];
+       u8 req_agg_queues;
+       u8 used_agg_queues;
+       u16 max_agg_tx_q_size;
+       bool wd_restart_drv;
+       bool is_stop_context;
+       struct workqueue_struct *drv_workqueue;
+       struct cl_amsdu_rx_state amsdu_rx_state;
+       struct cl_tx_queues tx_queues;
+       struct kmem_cache *sw_txhdr_cache;
+       struct kmem_cache *amsdu_txhdr_cache;
+       u32 radio_stats[CL_RADIO_ERRORS_MAX];
+       atomic_t tx_packet_count;
+       struct cl_rx_path_info rx_info;
+       struct cl_prot_mode prot_mode;
+       struct cl_agg_cfm_queue agg_cfm_queues[IPC_MAX_BA_SESSIONS];
+       struct cl_single_cfm_queue single_cfm_queues[MAX_SINGLE_QUEUES];
+       struct cl_single_cfm_queue bcmc_cfm_queue;
+       atomic_t radio_lock;
+       struct cl_assoc_queue assoc_queue;
+       struct cl_agc_cd agc_cd;
+       struct cl_wrs_db wrs_db;
+       struct cl_traffic_main traffic_db;
+       struct cl_rsrc_mgmt_db rsrc_mgmt_db;
+       struct cl_power_db power_db;
+       struct cl_bf_db bf_db;
+       struct cl_edca_db edca_db;
+       struct cl_vns_db vns_db;
+       struct cl_str_offload_env str_offload_env;
+       struct cl_dma_accessed fw_remote_rom;
+       struct cl_recovery_db recovery_db;
+       struct cl_radar_queue radar_queue;
+       struct tasklet_struct radar_tasklet;
+       struct cl_cached_fw cached_fw;
+       s8 rx_sensitivity[MAX_ANTENNAS];
+       struct cl_cca_db cca_db;
+       struct cl_noise_db noise_db;
+       struct cl_temp_comp_db temp_comp_db;
+       struct cl_sounding_db sounding;
+       struct cl_dyn_mcast_rate dyn_mcast_rate;
+       struct cl_dyn_bcast_rate dyn_bcast_rate;
+       struct cl_dfs_db dfs_db;
+       struct cl_version_db version_db;
+       bool entry_fixed_rate;
+       struct cl_vlan_dscp vlan_dscp;
+       unsigned long last_tbtt_irq;
+       u32 tbtt_cnt;
+       u8 mesh_tbtt_div;
+       struct tasklet_struct tx_mesh_bcn_task;
+       u32 fw_recovery_cntr;
+       u32 rx_filter;
+       ptrdiff_t mac_hw_regs_offset;
+       ptrdiff_t phy_regs_offset;
+       struct sk_buff_head tx_remote_queue;
+       struct sk_buff_head rx_remote_queue_mac;
+       struct sk_buff_head rx_skb_queue;
+       struct tasklet_struct rx_tasklet;
+       struct tasklet_struct rx_resched_tasklet;
+       u8 fem_system_mode;
+       u8 fem_ant;
+       struct cl_tx_packet_cntr tx_packet_cntr;
+       struct cl_cpu_cntr cpu_cntr;
+       struct cl_iq_dcoc_data_info iq_dcoc_data_info;
+       struct cl_power_table_info power_table_info;
+       struct ieee80211_sband_iftype_data iftype_data[3];
+       bool motion_sense_dbg;
+       struct cl_power_truncate pwr_trunc;
+       struct mutex set_channel_mutex;
+       u8 radio_status;
+       u8 rf_crystal_mhz;
+       bool calib_ready;
+       struct cl_twt_db twt_db;
+       struct mac_address addresses[MAX_BSS_NUM];
+       struct cl_rx_stats *rx_stats; /* RX statistics for production mode.=
 */
+       spinlock_t lock_stats;
+       u16 n_addresses;
+       u8 txamsdu_en;
+       bool reg_dbg;
+       struct cl_rx_trigger_based_stats tb_stats;
+       bool idle_async_set;
+       struct cl_vendor_msg vendor_msg;
+       struct cl_timer vendor_timer;
+       bool msg_calib_timeout;
+       struct cl_calib_work *calib_work;
+};
+
+void cl_hw_init(struct cl_chip *chip, struct cl_hw *cl_hw, u8 tcv_idx);
+void cl_hw_deinit(struct cl_hw *cl_hw, u8 tcv_idx);
+void cl_hw_lock(struct cl_hw *cl_hw);
+void cl_hw_unlock(struct cl_hw *cl_hw);
+struct cl_hw *cl_hw_other_tcv(struct cl_hw *cl_hw);
+bool cl_hw_is_tcv0(struct cl_hw *cl_hw);
+bool cl_hw_is_tcv1(struct cl_hw *cl_hw);
+int cl_hw_set_antennas(struct cl_hw *cl_hw);
+u8 cl_hw_ant_shift(struct cl_hw *cl_hw);
+
+#endif /* CL_HW_H */
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

