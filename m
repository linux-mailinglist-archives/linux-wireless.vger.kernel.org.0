Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A8532941
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiEXLjB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiEXLjB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF58CCFF
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSV0H9mRmQaYB8ux4et05pqvVxA1JVNwJOzkmxZwsByQgXYZLdr2Uox39B5RAnCo7raoJ7spPnAG0vUMVgjKHCKNSfZP6Asim8mgNcmjglmx/hEeLFAGVl4KW/QtCfMQZTY3ps/DFhjhSLvz4B6/s3JUbmziTkp77PEiaJUF3Tpagt0vSo6QYLj0/QaUgMV3XLSzg0flx67EEiTD/cXIyQYUSpyjiTMznzLYBk80hrXqmz7hmcq9U+CTAioqAnP/zyGETl2N1TxNfJmsc2l3NvnUSC81VT0obDEB2bFZyhtXG5cVoBpNtsLHZ5KWJQbg0vQzv3QvqkcxykiyX88Utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPmbr2CTVs8CdY+F0+fdiSG0bK2SC0pjIPt1Fblu9gc=;
 b=FZZVTXptVSfRSMw07hZqAvxt1TOmBnNRfkoEZ83RAOt+watGpM2mxgZ7DFYbDL/DbmyaFrGYBGY0lXenZEx8engpbAuNfoOn913eSQEKZ2J2XvNNYi7uwzweziU2LyixduaweexZcaaJG5I7ncP8pnGG7a7ZyRL/WPd9xyg1XSKpfJI6/M3Y7G6mHScMLChO/WGM1ZlhZ0msG9jdTtQqNjaZUZnGb826ABQTpIO+Um4vjPNYLqafTin1tcU7lhKKeNO2K28/4iJIS/UDUbqXcVFddVf3o343IXi+OhcBDgkGWSlxx0DSmwbzCZSt0B9JymEUmCsvMnVLdnflZt3Xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPmbr2CTVs8CdY+F0+fdiSG0bK2SC0pjIPt1Fblu9gc=;
 b=Yd5ncC7lKghzHMcijOulnjtyasNzi1yiG/gyWYNPxG4cefq/otyFWJhjD7AGVb3VM6EOWlIb1cP3EdX6MVdnxn9yJ2XyzeQw57+BPsakv2UhqJPNxqnSOJFsCcwURFW78T4jMl9AV3cUBc60Z75LM+OoojpkxbSLAujTLD6x6hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:39 +0000
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
Subject: [RFC v2 34/96] cl8k: add hw.h
Date:   Tue, 24 May 2022 14:34:00 +0300
Message-Id: <20220524113502.1094459-35-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99891eb9-15e8-485c-8999-08da3d79e01d
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384A29185B7F6A036FDEF6CF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZS7AH6cVa65a4MscWO2vEQT8xsatIhbwUAvg8CH00utK/3BycGk7CGXPOM4EOt8JROds1qN/Zh/qA8sPBUXYH6alFEkc7DGOo+VOwLh2tjoMk7r7r0BPx7zL3R51F+ljgzrli1E3lcOlpLW+QrMOAOr2/Nl7AL7pNfuad1C7KGpinkElaWjpT6lfnIU1AynOeLVCb9PcJ6myvR0z5F0SGRlK1BxdMrSfqDdhdfJLzx1ALDe0HLOxay3VzOIFuIOIuTQ1MBnMpkwGuSPO9IdJd7rphCqMriptdS9T2JIt+cCaSlBM5xweoC3uqF+AAbGQ0xxPpbDiFSNJeAc+5HGe2jxv3ZolqKUgIPneggu2XaWoGuOLJT+sPMNFJmGdHpa18GYTkCrxTayWxDIi/vTa8DkHsbDCwWmkqmTeirZEHMabdHwaX70Nhi9BaYVFzI9ERMEwGrCSVfY9tpL6OvFO7vYZ8Xyllg4NZw4KJ/XBsQbyHiOL0wjTXt+whA3S3LHpSi2rZ+TntIt//Yu6AVGlgec9uPZ3WBa5pksjxNJeJqEkHaCrp2DLJNKSCQ3Wg45Prrpa7UoTsZVzwIGNajY9xQaiTsb1iT1RvP5vF95ps7S2J9k3ZMm+oh2q2LR/90Boor7f091x83z0w92SEvfUzMqnaKd/3qE4p9peduBNwRdEY4eSzD6mdDCQHf2mHQ1Eg7caPmCeGApqdUYoxKlS0OzPjnmRH9V6kWbMUyR2IrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0TsvF6DJVPOI7I8UlO4rg+jal1XZZHwSecXH5vsInmC5f48emS2xhr7i96b?=
 =?us-ascii?Q?4gB6zFQ8kawGi3ITFj3jt6RfsqpK6BmqWqS/2fQJNDg4241ioR+uJ1gwZmk5?=
 =?us-ascii?Q?lN9Qnx6YfkTH/7V5Bcoa3PW42sOyXMH1gc+wZogk4zZL8NQ6xvLUJjW6MPic?=
 =?us-ascii?Q?FtbFjMD7MHshAzDNnmaTTp3N1kc2QkxtjF0sa6RNOxXgNKCApjxarRwIEj/y?=
 =?us-ascii?Q?wrkOQFiyJasbTBeNnGyWvyo20pr5PMhezMtkzG8MOh5LmRTUO2EQxJZqGszg?=
 =?us-ascii?Q?cDhEipj4dI6yCjcFQ/VG3II8CW/QoLcsaw8AMsiLWkDKHUx2SshB4G7dp/li?=
 =?us-ascii?Q?O2GAYM8wgxEQctytCHIuYRGsZ4VRcjrDGqeJXl+Yrkh3e+hCs+PamIL8ZLXb?=
 =?us-ascii?Q?oj3ywCd4oQHfCAvKZh8ddy0cH/Vw98j/YKRTneZ2zLYyXujK6QB/GMzABq3k?=
 =?us-ascii?Q?jqDNhdA+GX0zVFm49Z8W0Rax+No98HNzbRkM76GSiBQ49lCq5Yzub+ldN5hr?=
 =?us-ascii?Q?tuPruxTu5wfdx2QzMYCBl5VkxqWWffaDtnO9DaqS0qoXl1u4ngwOjN5gz4nw?=
 =?us-ascii?Q?mwZROitkhLrddCkcjQp5aP2Zidy2OAFyTrA6cMUZk1WxG0fXL8m70P9kxDhm?=
 =?us-ascii?Q?szkv1U+KOE/tCF+kwE1k3PDydi36ro676yO0CLUB2q1mp4jjw3mFGp40MGVF?=
 =?us-ascii?Q?ZE10BkXayPuJa6hc8SxJ6bjqnlDik0mloZVLETjJJKKQxjIaT7yUAc48R0S+?=
 =?us-ascii?Q?9u4VPuYVPOCUlzcLupW5SMSIi6WMEg41Sf467liMGHtfsxC69xGWfiJi/KXX?=
 =?us-ascii?Q?/40vpQy5UIFQ/wcMrhmv5Uhg8UeNwmvFPp+RV2fasGHSXqQhpE3jSOumx8c2?=
 =?us-ascii?Q?Yr1ocKJMY2xozjRVjG85LwgtwDOHpaRcNnW4GpAQqjKWyil6B+O5FzsLWTvi?=
 =?us-ascii?Q?fztDIbfbFfHOi7CJ4I0Me/yW7azCLABaj9610fEM8GQ+kknxyUAmyU5n1463?=
 =?us-ascii?Q?GfvZCOxWHfVyxhMP+UTeBIaV6/GBlODMRfe31DtN3fRMteD2oQTTQosWub8K?=
 =?us-ascii?Q?sF/aVxp3R5xUzShKojQ+VG4jGgQkJ5MVgxeaPzdbrNRLbWeN9dGMTfJ9kF9i?=
 =?us-ascii?Q?L+lNhad7ME3wRkLyfX7R/C2+mr+UB3KkX+jwmte+tR3Lx8gcIMfy29lHjpc7?=
 =?us-ascii?Q?GEnbrdY2NFIAWbfvvC7l0SADMNgyXve17Th4ATG06aer1uVTOjz0LVUZxPP6?=
 =?us-ascii?Q?2hy2X5tqM7Esxvg/acLC/5GwXnEUWqFWTMW1BWMqnpPNnUT6BbbWWhzhxw2N?=
 =?us-ascii?Q?gMEHJcFi35i51cNHXn0OhDQ8v+QocrVL/Bjen6NLjV8hs6c1NLP/sbi0yLa0?=
 =?us-ascii?Q?LQ1jdeg7r4eV7Mseug+AEESDh6eMS3s4s+CJxHXSW9JxDloZgbL62j/dkvH7?=
 =?us-ascii?Q?YLCPLOZCflBSKwsBFDYHEXGPGwfBOCRVwVhmHl0uIMBNN8CAohrEIj+eO0Kv?=
 =?us-ascii?Q?ZlUg6IxlPDJQ6ABBrtSw/m89Wy8Ud80ldzS7qwK6MNjmKFtFhBjwN4WRGZ88?=
 =?us-ascii?Q?8iZjJjx7YrCx7zR7mBrayFhRcsypKMNlIFY0EKMDpJDkPhHs5WKe97fhszrf?=
 =?us-ascii?Q?oDiZmF4C7r7IKlIlaIhDVXV3FiuZoSZ1Y3kZbzuYCj15clhgS+abWErGj0RJ?=
 =?us-ascii?Q?IPeXv9HcdscJZcCRCnjzZgpgy5gl3hWs+0EIzH6TJPfBpbuXepHl1DbCt5aI?=
 =?us-ascii?Q?yfuUkO7U50L0ib5AQzLrLAVqPEzS8Uc=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99891eb9-15e8-485c-8999-08da3d79e01d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:08.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv8MlRWW7vDK5R914OBNbsE4a20dZQUcRT8hyBrbFSe8vm5e/IP+YcDTF/XUcvSvU+xm1iCZ3c0WgRdEDFvCtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/hw.h | 280 ++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.h

diff --git a/drivers/net/wireless/celeno/cl8k/hw.h b/drivers/net/wireless/celeno/cl8k/hw.h
new file mode 100644
index 000000000000..c34a2bc0d990
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/hw.h
@@ -0,0 +1,280 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_HW_H
+#define CL_HW_H
+
+#include <linux/module.h>
+
+#include "traffic.h"
+#include "temperature.h"
+#include "dfs.h"
+#include "calib.h"
+#include "ipc_shared.h"
+#include "fw.h"
+#include "rates.h"
+#include "def.h"
+#include "tx.h"
+#include "radio.h"
+#include "mac80211.h"
+#include "scan.h"
+#include "rx.h"
+#include "wrs.h"
+#include "vns.h"
+#include "sta.h"
+#include "debug.h"
+#include "chip.h"
+#include "recovery.h"
+#include "bf.h"
+#include "power.h"
+#include "phy.h"
+#include "vif.h"
+#include "tcv.h"
+#include "sounding.h"
+#include "version.h"
+
+#define cl_hw_get_iface_conf(cl_hw) atomic_read(&(cl_hw)->iface_conf)
+#define cl_hw_set_iface_conf(cl_hw, value) atomic_set(&(cl_hw)->iface_conf, value)
+
+/* Structure used to store information regarding E2A msg buffers in the driver */
+struct cl_e2a_msg_elem {
+	struct cl_ipc_e2a_msg *msgbuf_ptr;
+	dma_addr_t dma_addr;
+};
+
+enum cl_iface_conf {
+	CL_IFCONF_AP,
+	CL_IFCONF_STA,
+	CL_IFCONF_REPEATER,
+	CL_IFCONF_MESH_AP,
+	CL_IFCONF_MESH_ONLY,
+
+	CL_IFCONF_MAX
+};
+
+struct cl_hw_asserts_info {
+	/* Timestamp (jiffies) of the last CL_MIN_ASSERT_CNT hw assert. */
+	unsigned long timestamp[CL_MIN_ASSERT_CNT];
+	/* Hw assert index. */
+	u8 index;
+	/* Indicate if hw_restart was schedule */
+	u8 restart_sched;
+};
+
+struct cl_hw {
+	u8 idx; /* Global index (0-3) */
+	u8 tcv_idx; /* Transceiver index (0-1) */
+	u8 sx_idx;
+	struct cl_tcv_conf *conf;
+	struct cl_chip *chip;
+	struct ieee80211_hw *hw;
+	const struct cl_driver_ops *drv_ops;
+	struct cl_vif_db vif_db;
+	atomic_t iface_conf;
+	u32 num_ap_started;
+	u8 hw_mode;
+	enum cl_wireless_mode wireless_mode;
+	u8 tx_power_version;
+	struct cl_vif *mc_vif;
+	u8 bw;
+	u32 channel;
+	u32 primary_freq;
+	u32 center_freq;
+	enum nl80211_band nl_band;
+	u8 num_antennas;
+	u8 mask_num_antennas;
+	u8 first_ant;
+	u8 first_riu_chain;
+	u8 last_riu_chain;
+	u8 max_antennas;
+	struct cl_tx_db tx_db;
+	struct cl_sta_db cl_sta_db;
+	struct cl_ipc_e2a_irq ipc_e2a_irq;
+	struct cl_controller_reg controller_reg;
+	struct ieee80211_supported_band sband;
+	void (*ipc_host2xmac_trigger_set)(struct cl_chip *chip, u32 value);
+	unsigned long drv_flags;
+	unsigned long tx_disable_flags;
+	struct cl_ipc_host_env *ipc_env;
+	spinlock_t tx_lock_agg;
+	spinlock_t tx_lock_cfm_agg;
+	spinlock_t tx_lock_single;
+	spinlock_t tx_lock_bcmc;
+	struct mutex msg_tx_mutex;
+	wait_queue_head_t wait_queue; /* Synchronize driver<-->firmware message exchanges */
+	unsigned long cfm_flags[MAX_CFM_FLAGS];
+	void *msg_cfm_params[MM_MAX + DBG_MAX]; /* Array of pointers per received msg CFM */
+	bool msg_background;
+	wait_queue_head_t fw_sync_wq;
+	wait_queue_head_t radio_wait_queue;
+	struct cl_rx_elem *rx_elems;
+	struct cl_e2a_msg_elem *e2a_msg_elems;
+	struct cl_dbg_elem *dbg_elems;
+	struct cl_radar_elem *radar_elems;
+	struct dma_pool *txdesc_pool;
+	struct dma_pool *dbg_pool;
+	struct dma_pool *e2a_msg_pool;
+	struct dma_pool *radar_pool;
+	struct cl_debug_info dbginfo;
+	struct cl_hw_asserts_info assert_info;
+	char fw_prefix; /* Single character for fw prefix - l/u/s */
+	u8 fw_dst_kern_id; /* Firmware destination (LMAC/SMAC) */
+	bool fw_active; /* Firmware is active */
+	bool fw_send_start; /* Did driver already send a start request message to firmware? */
+	struct cl_dbg_data dbg_data;
+	struct cl_tx_power_info tx_pow_info[MAX_EXT_CHANNELS][MAX_ANTENNAS];
+	spinlock_t channel_info_lock;
+	struct cl_channel_info channel_info;
+	struct cl_phy_data_info phy_data_info;
+	u32 mask_hi;
+	u32 mask_low;
+	struct timer_list maintenance_slow_timer;
+	struct timer_list maintenance_fast_timer;
+	struct tasklet_struct tx_task;
+	struct list_head list_sched_q_agg;
+	struct list_head list_sched_q_single;
+	struct cl_req_agg_db req_agg_db[IPC_MAX_BA_SESSIONS];
+	u8 req_agg_queues;
+	u8 used_agg_queues;
+	bool is_stop_context;
+	struct workqueue_struct *drv_workqueue;
+	struct cl_amsdu_rx_state amsdu_rx_state;
+	struct cl_tx_queues *tx_queues;
+	struct kmem_cache *sw_txhdr_cache;
+	struct kmem_cache *amsdu_txhdr_cache;
+	u32 radio_stats[CL_RADIO_ERRORS_MAX];
+	struct cl_rx_path_info rx_info;
+	struct cl_prot_mode prot_mode;
+	struct cl_agg_cfm_queue agg_cfm_queues[IPC_MAX_BA_SESSIONS];
+	struct cl_single_cfm_queue single_cfm_queues[MAX_SINGLE_QUEUES];
+	struct cl_single_cfm_queue bcmc_cfm_queue;
+	atomic_t radio_lock;
+	struct cl_assoc_queue assoc_queue;
+	struct cl_wrs_db wrs_db;
+	struct cl_traffic_main traffic_db;
+	struct cl_power_db power_db;
+	struct cl_bf_db bf_db;
+	struct cl_edca_db edca_db;
+	struct cl_vns_db *vns_db;
+	struct cl_str_offload_env str_offload_env;
+	struct cl_dma_accessed fw_remote_rom;
+	struct cl_recovery_db recovery_db;
+	struct cl_radar_queue radar_queue;
+	struct tasklet_struct radar_tasklet;
+	struct cl_cached_fw cached_fw;
+	s8 rx_sensitivity[MAX_ANTENNAS];
+	struct cl_cca_db cca_db;
+	struct cl_noise_db noise_db;
+	struct cl_temp_comp_db temp_comp_db;
+	struct cl_sounding_db sounding;
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	struct cl_dyn_mcast_rate dyn_mcast_rate;
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	struct cl_dyn_bcast_rate dyn_bcast_rate;
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+	struct cl_dfs_db dfs_db;
+	struct cl_version_db version_db;
+	bool entry_fixed_rate;
+	unsigned long last_tbtt_irq;
+	u16 smallest_beacon_int;
+	u32 tbtt_cnt;
+	u8 mesh_tbtt_div;
+	struct tasklet_struct tx_mesh_bcn_task;
+	u32 fw_recovery_cntr;
+	u32 rx_filter;
+	ptrdiff_t mac_hw_regs_offset;
+	ptrdiff_t phy_regs_offset;
+	struct list_head head_amsdu_txhdr_pool;
+	struct list_head head_sw_txhdr_pool;
+	spinlock_t lock_sw_txhdr_pool;
+	struct sk_buff_head rx_remote_queue_mac;
+	struct sk_buff_head rx_skb_queue;
+	struct tasklet_struct rx_tasklet;
+	struct tasklet_struct rx_resched_tasklet;
+	u8 fem_mode;
+	struct cl_tx_packet_cntr tx_packet_cntr;
+	struct cl_cpu_cntr cpu_cntr;
+	struct cl_iq_dcoc_data_info iq_dcoc_data_info;
+	struct cl_power_table_info power_table_info;
+	struct ieee80211_sband_iftype_data iftype_data[3];
+	bool motion_sense_dbg;
+	struct cl_power_truncate pwr_trunc;
+	struct mutex set_channel_mutex;
+	u8 radio_status;
+	u8 rf_crystal_mhz;
+	bool iq_cal_ready;
+	s8 rssi_simulate;
+	struct mac_address addresses[MAX_BSS_NUM];
+	struct cl_rx_stats *rx_stats; /* RX statistics for production mode. */
+	spinlock_t lock_stats;
+	u16 n_addresses;
+	u8 txamsdu_en;
+	bool reg_dbg;
+	s32 new_tx_power;
+	struct cl_rx_trigger_based_stats *tb_stats;
+	struct cl_rx_trigger_based_sta_stats *tb_sta_stats;
+	bool idle_async_set;
+	bool msg_calib_timeout;
+	struct cl_calib_work *calib_work;
+	struct cl_chan_scanner *scanner;
+	bool calib_runtime_needed;
+	u8 ht40_preffered_ch_type;
+	u8 sw_scan_in_progress;
+};
+
+void cl_hw_init(struct cl_chip *chip, struct cl_hw *cl_hw, u8 tcv_idx);
+void cl_hw_deinit(struct cl_hw *cl_hw, u8 tcv_idx);
+struct cl_hw *cl_hw_other_tcv(struct cl_hw *cl_hw);
+bool cl_hw_is_tcv0(struct cl_hw *cl_hw);
+bool cl_hw_is_tcv1(struct cl_hw *cl_hw);
+bool cl_hw_is_first_tcv(struct cl_hw *cl_hw);
+int cl_hw_set_antennas(struct cl_hw *cl_hw);
+u8 cl_hw_ant_shift(struct cl_hw *cl_hw);
+u8 cl_hw_ant_to_riu_chain(struct cl_hw *cl_hw, u8 ant);
+u8 cl_hw_ant_mask_to_riu_chain_mask(struct cl_hw *cl_hw, u8 ant_mask);
+bool cl_hw_is_prod_or_listener(struct cl_hw *cl_hw);
+void cl_hw_assert_info_init(struct cl_hw *cl_hw);
+void cl_hw_assert_print(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg);
+void cl_hw_assert_check(struct cl_hw *cl_hw);
+
+static inline void cl_sta_lock_bh(struct cl_hw *cl_hw)
+{
+	read_lock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+static inline void cl_sta_unlock_bh(struct cl_hw *cl_hw)
+{
+	read_unlock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+static inline void cl_sta_lock(struct cl_hw *cl_hw)
+{
+	read_lock(&cl_hw->cl_sta_db.lock);
+}
+
+static inline void cl_sta_unlock(struct cl_hw *cl_hw)
+{
+	read_unlock(&cl_hw->cl_sta_db.lock);
+}
+
+/* FW communication opses */
+static inline int cl_drv_ops_msg_fw_send(struct cl_hw *cl_hw,
+					 const void *msg_params,
+					 bool background)
+{
+	if (cl_hw->drv_ops->msg_fw_send)
+		return cl_hw->drv_ops->msg_fw_send(cl_hw, msg_params,
+						   background);
+	return 0;
+}
+
+static inline void cl_drv_ops_pkt_fw_send(struct cl_hw *cl_hw,
+					  struct cl_sw_txhdr *sw_txhdr,
+					  struct cl_tx_queue *tx_queue)
+{
+	if (cl_hw->drv_ops->pkt_fw_send)
+		cl_hw->drv_ops->pkt_fw_send(cl_hw, sw_txhdr, tx_queue);
+}
+
+#endif /* CL_HW_H */
-- 
2.36.1

