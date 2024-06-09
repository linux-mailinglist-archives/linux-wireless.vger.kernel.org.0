Return-Path: <linux-wireless+bounces-8727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34090179D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065EC1C20BBB
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50374073;
	Sun,  9 Jun 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c5IqkGLv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A504C627;
	Sun,  9 Jun 2024 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957377; cv=none; b=Vq202Fz8TkvfUS3f+C1r/GXyDwcFpDOmMGFcWe7HoRQWClXS0K0L1U6jj6uHQ41V3J/gi1xnRFj1S7tllCsoZznbeVpAVm2P58h0UeJMK+rRPUl6LZIiHwXHDpdXjYHVUpJOH+J6vrhmQ04eKA4qoQT+t52AsfJxT5t62APDdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957377; c=relaxed/simple;
	bh=aRmKcWXQafwNWb6hLvwA5vYpBG3/bxg+2E4SJDaiOhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLAekncuBJ431Ysy9P7l/mj6P4N9Slp0Iz2u0cyvB2ONkV5I8/4M/CpzHjUAe3r9lNulNP3XWVN5/evjiJ6fJc2AfN2XQr2xze8czcvJYVCruRAlIAgbfPqLrnM+kgrc43vk0aPOHK/crtjMgh/+ntFlb+LhxNNPypkccx8tCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c5IqkGLv; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMWor075075;
	Sun, 9 Jun 2024 13:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957352;
	bh=TyKwLW4pEQsvyHLyQ27qmXOLTMjKjp2QGK8VtWbX3B8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c5IqkGLvtEPTgVBELvM6exhOdNo3jLBSapJyxHiGXAwo38h051LooHbId2paLA2UP
	 K/23husGH2lhxb4c24IjGSHbx3jiDkgEueoshFIQ3Mf8te1Q9GwZIfdK55W7uf7bdY
	 3PWUbC/+7TfpBd/ve/B3hQ19tQfRegVsHhB5Dv/o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMWCA027527
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:32 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMVgi067548;
	Sun, 9 Jun 2024 13:22:31 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>
Subject: [PATCH v2 01/17] wifi: cc33xx: Add cc33xx.h, cc33xx_i.h
Date: Sun, 9 Jun 2024 21:20:46 +0300
Message-ID: <20240609182102.2950457-2-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

These are header files with definitions common to the entire driver.
---
 drivers/net/wireless/ti/cc33xx/cc33xx.h   | 483 ++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/cc33xx_i.h | 459 ++++++++++++++++++++
 2 files changed, 942 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/cc33xx.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/cc33xx_i.h

diff --git a/drivers/net/wireless/ti/cc33xx/cc33xx.h b/drivers/net/wireless/ti/cc33xx/cc33xx.h
new file mode 100644
index 000000000000..6270aec2b753
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/cc33xx.h
@@ -0,0 +1,483 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __CC33XX_H__
+#define __CC33XX_H__
+
+#include "cc33xx_i.h"
+#include "rx.h"
+
+/* The maximum number of Tx descriptors in all chip families */
+#define CC33XX_MAX_TX_DESCRIPTORS 32
+
+#define CC33XX_CMD_MAX_SIZE          (896)
+#define CC33XX_INI_PARAM_COMMAND_SIZE (16UL)
+#define CC33XX_INI_CMD_MAX_SIZE      (CC33X_CONF_SIZE + CC33XX_INI_PARAM_COMMAND_SIZE + sizeof(int))
+
+#define CC33XX_CMD_BUFFER_SIZE ((CC33XX_INI_CMD_MAX_SIZE > CC33XX_CMD_MAX_SIZE)\
+				? CC33XX_INI_CMD_MAX_SIZE : CC33XX_CMD_MAX_SIZE)
+
+#define CC33XX_NUM_MAC_ADDRESSES 3
+
+#define CC33XX_AGGR_BUFFER_SIZE		(8 * PAGE_SIZE)
+
+#define CC33XX_NUM_TX_DESCRIPTORS 32
+#define CC33XX_NUM_RX_DESCRIPTORS 32
+
+#define CC33XX_RX_BA_MAX_SESSIONS 13
+
+#define CC33XX_MAX_AP_STATIONS 16
+
+struct cc33xx_tx_hw_descr;
+struct cc33xx_rx_descriptor;
+struct partial_rx_frame;
+struct core_fw_status;
+struct core_status;
+
+enum wl_rx_buf_align;
+
+struct cc33xx_stats {
+	void *fw_stats;
+	unsigned long fw_stats_update;
+	unsigned int retry_count;
+	unsigned int excessive_retries;
+};
+
+struct cc33xx_ant_diversity {
+	u8 diversity_enable;
+	s8 rssi_threshold;
+	u8 default_antenna;
+	u8 padding;
+};
+
+struct cc33xx {
+	bool initialized;
+	struct ieee80211_hw *hw;
+	bool mac80211_registered;
+
+	struct device *dev;
+	struct platform_device *pdev;
+
+	struct cc33xx_if_operations *if_ops;
+
+	int wakeirq;
+
+	/* Protects all mac80211 operations and parts of Rx, Tx and IRQ handling.
+	 * All functions postfixed with "_locked" (i.e, cc33xx_irq_locked)
+	 * assume this lock is held by caller.
+	 */
+	struct mutex mutex;
+
+	/* Used independently from above mutex to protect short critical sections.
+	 * Though many of these sections may theoretically execute in parallel, a
+	 * single lock will be used for simplicity.
+	 */
+	spinlock_t cc_lock;
+
+	enum cc33xx_state state;
+	bool plt;
+	enum plt_mode plt_mode;
+	u8 plt_role_id;
+	u8 fem_manuf;
+	u8 last_vif_count;
+
+	struct core_status *core_status;
+	u8 last_fw_rls_idx;
+	u8 command_result[CC33XX_CMD_MAX_SIZE];
+	u16 result_length;
+	struct partial_rx_frame partial_rx;
+
+	unsigned long flags;
+
+	void *nvs_mac_addr;
+	size_t nvs_mac_addr_len;
+	struct cc33xx_fw_download *fw_download;
+
+	struct mac_address addresses[CC33XX_NUM_MAC_ADDRESSES];
+
+	unsigned long links_map[BITS_TO_LONGS(CC33XX_MAX_LINKS)];
+	unsigned long roles_map[BITS_TO_LONGS(CC33XX_MAX_ROLES)];
+	unsigned long roc_map[BITS_TO_LONGS(CC33XX_MAX_ROLES)];
+	unsigned long rate_policies_map[BITS_TO_LONGS(CC33XX_MAX_RATE_POLICIES)];
+
+	u8 session_ids[CC33XX_MAX_LINKS];
+
+	struct list_head wlvif_list;
+
+	u8 sta_count;
+	u8 ap_count;
+
+	struct cc33xx_acx_mem_map *target_mem_map;
+
+	/* Accounting for allocated / available TX blocks on HW */
+
+	u32 tx_blocks_available;
+	u32 tx_allocated_blocks;
+
+	/* Accounting for allocated / available Tx packets in HW */
+
+	u32 tx_allocated_pkts[NUM_TX_QUEUES];
+
+	/* Time-offset between host and chipset clocks */
+
+	/* Frames scheduled for transmission, not handled yet */
+	int tx_queue_count[NUM_TX_QUEUES];
+	unsigned long queue_stop_reasons[NUM_TX_QUEUES * CC33XX_NUM_MAC_ADDRESSES];
+
+	/* Frames received, not handled yet by mac80211 */
+	struct sk_buff_head deferred_rx_queue;
+
+	/* Frames sent, not returned yet to mac80211 */
+	struct sk_buff_head deferred_tx_queue;
+
+	struct work_struct tx_work;
+	struct workqueue_struct *freezable_wq;
+
+	/*freezable wq for netstack_work*/
+	struct workqueue_struct *freezable_netstack_wq;
+
+	/* Pending TX frames */
+	unsigned long tx_frames_map[BITS_TO_LONGS(CC33XX_MAX_TX_DESCRIPTORS)];
+	struct sk_buff *tx_frames[CC33XX_MAX_TX_DESCRIPTORS];
+	int tx_frames_cnt;
+
+	/* FW Rx counter */
+	u32 rx_counter;
+
+	/* Intermediate buffer, used for packet aggregation */
+	u8 *aggr_buf;
+	u32 aggr_buf_size;
+	size_t max_transaction_len;
+
+	/* Reusable dummy packet template */
+	struct sk_buff *dummy_packet;
+
+	/* Network stack work  */
+	struct work_struct netstack_work;
+	/* FW log buffer */
+	u8 *fwlog;
+
+	/* Number of valid bytes in the FW log buffer */
+	ssize_t fwlog_size;
+
+	/* Hardware recovery work */
+	struct work_struct recovery_work;
+
+	struct work_struct irq_deferred_work;
+
+	/* Reg domain last configuration */
+	DECLARE_BITMAP(reg_ch_conf_last, 64);
+	/* Reg domain pending configuration */
+	DECLARE_BITMAP(reg_ch_conf_pending, 64);
+
+	/* Lock-less list for deferred event handling */
+	struct llist_head event_list;
+	/* The mbox event mask */
+	u32 event_mask;
+	/* events to unmask only when ap interface is up */
+	u32 ap_event_mask;
+
+	/* Are we currently scanning */
+	struct cc33xx_vif *scan_wlvif;
+	struct cc33xx_scan scan;
+	struct delayed_work scan_complete_work;
+
+	struct ieee80211_vif *roc_vif;
+	struct delayed_work roc_complete_work;
+
+	struct cc33xx_vif *sched_vif;
+
+	u8 mac80211_scan_stopped;
+
+	/* The current band */
+	enum nl80211_band band;
+
+	/* in dBm */
+	int power_level;
+
+	struct cc33xx_stats stats;
+
+	__le32 *buffer_32;
+
+	/* Current chipset configuration */
+	struct cc33xx_conf_file conf;
+
+	bool enable_11a;
+
+	/* bands supported by this instance of cc33xx */
+	struct ieee80211_supported_band bands[CC33XX_NUM_BANDS];
+
+	/* wowlan trigger was configured during suspend.
+	 * (currently, only "ANY" and "PATTERN" trigger is supported)
+	 */
+
+	bool keep_device_power;
+
+	/* AP-mode - links indexed by HLID. The global and broadcast links
+	 * are always active.
+	 */
+	struct cc33xx_link links[CC33XX_MAX_LINKS];
+
+	/* number of currently active links */
+	int active_link_count;
+
+	/* AP-mode - a bitmap of links currently in PS mode according to FW */
+	unsigned long ap_fw_ps_map;
+
+	/* AP-mode - a bitmap of links currently in PS mode in mac80211 */
+	unsigned long ap_ps_map;
+
+	/* Quirks of specific hardware revisions */
+	unsigned int quirks;
+
+	/* number of currently active RX BA sessions */
+	int ba_rx_session_count;
+
+	/* AP-mode - number of currently connected stations */
+	int active_sta_count;
+
+	/* last wlvif we transmitted from */
+	struct cc33xx_vif *last_wlvif;
+
+	/* work to fire when Tx is stuck */
+	struct delayed_work tx_watchdog_work;
+
+	/* HW HT (11n) capabilities */
+	struct ieee80211_sta_ht_cap ht_cap[CC33XX_NUM_BANDS];
+
+	/* the current dfs region */
+	enum nl80211_dfs_regions dfs_region;
+	bool radar_debug_mode;
+
+	/* RX Data filter rule state - enabled/disabled */
+	/* used in CONFIG PM AND W8 Code */
+	unsigned long rx_filter_enabled[BITS_TO_LONGS(CC33XX_MAX_RX_FILTERS)];
+
+	/* mutex for protecting the tx_flush function */
+	struct mutex flush_mutex;
+
+	/* sleep auth value currently configured to FW */
+	int sleep_auth;
+
+	/*ble_enable value - 1=enabled, 0=disabled. */
+	int ble_enable;
+
+	/* parameters for joining a TWT agreement */
+	int min_wake_duration_usec;
+	int min_wake_interval_mantissa;
+	int min_wake_interval_exponent;
+	int max_wake_interval_mantissa;
+	int max_wake_interval_exponent;
+
+	/* the number of allocated MAC addresses in this chip */
+	int num_mac_addr;
+
+	/* sta role index - if 0 - wlan0 primary station interface,
+	 * if 1 - wlan2 - secondary station interface
+	 */
+	u8 sta_role_idx;
+
+	u16 max_cmd_size;
+
+	struct completion nvs_loading_complete;
+	struct completion command_complete;
+
+	/* dynamic fw traces */
+	u32 dynamic_fw_traces;
+
+	/* buffer for sending commands to FW */
+	u8 cmd_buf[CC33XX_CMD_BUFFER_SIZE];
+
+	/* number of keys requiring extra spare mem-blocks */
+	int extra_spare_key_count;
+
+	u8 efuse_mac_address[ETH_ALEN];
+
+	u32 fuse_rom_structure_version;
+	u32 device_part_number;
+	u32 pg_version;
+	u8 disable_5g;
+	u8 disable_6g;
+
+	struct cc33xx_acx_fw_versions *fw_ver;
+
+	u8 antenna_selection;
+
+	/* burst mode cfg */
+	u8 burst_disable;
+
+	struct cc33xx_ant_diversity diversity;
+};
+
+void cc33xx_update_inconn_sta(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			      struct cc33xx_station *wl_sta, bool in_conn);
+
+void cc33xx_irq(void *cookie);
+
+/* Quirks */
+
+/* the first start_role(sta) sometimes doesn't work on wl12xx */
+#define CC33XX_QUIRK_START_STA_FAILS		BIT(1)
+
+/* wl127x and SPI don't support SDIO block size alignment */
+#define CC33XX_QUIRK_TX_BLOCKSIZE_ALIGN		BIT(2)
+
+/* means aggregated Rx packets are aligned to a SDIO block */
+#define CC33XX_QUIRK_RX_BLOCKSIZE_ALIGN		BIT(3)
+
+/* pad only the last frame in the aggregate buffer */
+#define CC33XX_QUIRK_TX_PAD_LAST_FRAME		BIT(7)
+
+/* extra header space is required for TKIP */
+#define CC33XX_QUIRK_TKIP_HEADER_SPACE		BIT(8)
+
+/* Some firmwares not support sched scans while connected */
+#define CC33XX_QUIRK_NO_SCHED_SCAN_WHILE_CONN	BIT(9)
+
+/* separate probe response templates for one-shot and sched scans */
+#define CC33XX_QUIRK_DUAL_PROBE_TMPL		BIT(10)
+
+/* Firmware requires reg domain configuration for active calibration */
+#define CC33XX_QUIRK_REGDOMAIN_CONF		BIT(11)
+
+/* The FW only support a zero session id for AP */
+#define CC33XX_QUIRK_AP_ZERO_SESSION_ID		BIT(12)
+
+/* TODO: move all these common registers and values elsewhere */
+#define HW_ACCESS_ELP_CTRL_REG		0x1FFFC
+
+enum CC33xx_FRAME_FORMAT {
+	CC33xx_B_SHORT = 0,
+	CC33xx_B_LONG,
+	CC33xx_LEGACY_OFDM,
+	CC33xx_HT_MF,
+	CC33xx_HT_GF,
+	CC33xx_HE_SU,
+	CC33xx_HE_MU,
+	CC33xx_HE_SU_ER,
+	CC33xx_HE_TB,
+	CC33xx_HE_TB_NDP_FB,
+	CC33xx_VHT
+};
+
+/* CC33xx HW Common Definitions */
+
+#define HOST_SYNC_PATTERN	0x5C5C5C5C
+#define DEVICE_SYNC_PATTERN	0xABCDDCBA
+#define NAB_DATA_ADDR		0x0000BFF0
+#define NAB_CONTROL_ADDR	0x0000BFF8
+#define NAB_STATUS_ADDR		0x0000BFFC
+
+#define NAB_SEND_CMD			0x940d
+#define NAB_SEND_FLAGS			0x08
+#define CC33xx_INTERNAL_DESC_SIZE	200
+#define NAB_EXTRA_BYTES			4
+
+#define TX_RESULT_QUEUE_SIZE  108
+
+struct control_info_descriptor {
+	__le16 type_and_length;
+};
+
+enum control_message_type {
+	CTRL_MSG_NONE = 0,
+	CTRL_MSG_EVENT = 1,
+	CTRL_MSG_COMMND_COMPLETE = 2
+};
+
+struct core_fw_status {
+	u8	tx_result_queue_index;
+	u8	reserved1[3];
+	u8	tx_result_queue[TX_RESULT_QUEUE_SIZE];
+
+	/* A bitmap (where each bit represents a single HLID)
+	 * to indicate PS/Active mode of the link
+	 */
+	__le32	link_ps_bitmap;
+
+	/* A bitmap (where each bit represents a single HLID)
+	 * to indicate if the station is in Fast mode
+	 */
+	__le32	link_fast_bitmap;
+
+	/* A bitmap (where each bit represents a single HLID)
+	 * to indicate if a links is suspended/aboout to be suspended
+	 */
+	__le32	link_suspend_bitmap;
+
+	/* Host TX Flow Control descriptor per AC threshold */
+	u8      tx_flow_control_ac_threshold;
+
+	/* Host TX Flow Control descriptor PS link threshold */
+	u8      tx_ps_threshold;
+
+	/* Host TX Flow Control descriptor Suspended link threshold */
+	u8      tx_suspend_threshold;
+
+	/* Host TX Flow Control descriptor Slow link threshold */
+	u8      tx_slow_link_prio_threshold;
+
+	/* Host TX Flow Control descriptor Fast link threshold */
+	u8      tx_fast_link_prio_threshold;
+
+	/* Host TX Flow Control descriptor Stop Slow link threshold */
+	u8      tx_slow_stop_threshold;
+
+	/* Host TX Flow Control descriptor Stop Fast link threshold */
+	u8      tx_fast_stop_threshold;
+
+	u8      reserved2;
+	/* Additional information can be added here */
+} __packed;
+
+struct core_status {
+	__le32 block_pad[28];
+	__le32 host_interrupt_status;
+	__le32 rx_status;
+	struct core_fw_status fw_info;
+	__le32 tsf;
+} __packed;
+
+struct NAB_header {
+	__le32 sync_pattern;
+	__le16 opcode;
+	__le16 len;
+};
+
+/* rx_status lower bytes hold the rx byte count */
+#define RX_BYTE_COUNT_MASK 0xFFFF
+
+#define HINT_NEW_TX_RESULT			0x1
+#define HINT_COMMAND_COMPLETE			0x2
+#define HINT_ROM_LOADER_INIT_COMPLETE		0x8
+#define HINT_SECOND_LOADER_INIT_COMPLETE	0x10
+#define HINT_FW_WAKEUP_COMPLETE			0x20
+#define HINT_FW_INIT_COMPLETE			0x40
+#define HINT_GENERAL_ERROR			0x80000000
+
+#define BOOT_TIME_INTERRUPTS (\
+	HINT_ROM_LOADER_INIT_COMPLETE    | \
+	HINT_SECOND_LOADER_INIT_COMPLETE | \
+	HINT_FW_WAKEUP_COMPLETE | \
+	HINT_FW_INIT_COMPLETE)
+
+struct NAB_tx_header {
+	__le32 sync;
+	__le16 opcode;
+	__le16 len;
+	__le16 desc_length;
+	u8     sd;
+	u8     flags;
+} __packed;
+
+struct NAB_rx_header {
+	__le32 cnys;
+	__le16 opcode;
+	__le16 len;
+	__le32 rx_desc;
+	__le32 reserved;
+} __packed;
+
+#endif /* __CC33XX_H__ */
diff --git a/drivers/net/wireless/ti/cc33xx/cc33xx_i.h b/drivers/net/wireless/ti/cc33xx/cc33xx_i.h
new file mode 100644
index 000000000000..9437f78b364f
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/cc33xx_i.h
@@ -0,0 +1,459 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __CC33XX_I_H__
+#define __CC33XX_I_H__
+
+#include <net/mac80211.h>
+#include <linux/platform_device.h>
+
+#include "conf.h"
+
+struct cc33xx_family_data {
+	const char *name;
+	const char *nvs_name;	/* nvs file */
+	const char *cfg_name;	/* cfg file */
+};
+
+#define CC33XX_TX_SECURITY_LO16(s) ((u16)((s) & 0xffff))
+#define CC33XX_TX_SECURITY_HI32(s) ((u32)(((s) >> 16) & 0xffffffff))
+#define CC33XX_TX_SQN_POST_RECOVERY_PADDING 0xff
+/* Use smaller padding for GEM, as some  APs have issues when it's too big */
+#define CC33XX_TX_SQN_POST_RECOVERY_PADDING_GEM 0x20
+
+#define CC33XX_CIPHER_SUITE_GEM 0x00147201
+
+#define CC33XX_BUSY_WORD_LEN (sizeof(u32))
+
+#define CC33XX_DEFAULT_BEACON_INT  100
+
+#define CC33XX_MAX_ROLES           4
+#define CC33XX_INVALID_ROLE_ID     0xff
+#define CC33XX_INVALID_LINK_ID     0xff
+
+#define CC33XX_MAX_LINKS 21
+
+/* the driver supports the 2.4Ghz and 5Ghz bands */
+#define CC33XX_NUM_BANDS           2
+
+#define CC33XX_MAX_RATE_POLICIES 16
+
+/* Defined by FW as 0. Will not be freed or allocated. */
+#define CC33XX_SYSTEM_HLID         0
+
+/* When in AP-mode, we allow (at least) this number of packets
+ * to be transmitted to FW for a STA in PS-mode. Only when packets are
+ * present in the FW buffers it will wake the sleeping STA. We want to put
+ * enough packets for the driver to transmit all of its buffered data before
+ * the STA goes to sleep again. But we don't want to take too much memory
+ * as it might hurt the throughput of active STAs.
+ */
+#define CC33XX_PS_STA_MAX_PACKETS  2
+
+#define CC33XX_AP_BSS_INDEX        0
+
+enum cc33xx_state {
+	CC33XX_STATE_OFF,
+	CC33XX_STATE_RESTARTING,
+	CC33XX_STATE_ON,
+};
+
+struct cc33xx;
+
+#define NUM_TX_QUEUES              4
+
+#define CC33XX_MAX_CHANNELS 64
+struct cc33xx_scan {
+	struct cfg80211_scan_request *req;
+	unsigned long scanned_ch[BITS_TO_LONGS(CC33XX_MAX_CHANNELS)];
+	bool failed;
+	u8 state;
+	u8 ssid[IEEE80211_MAX_SSID_LEN + 1];
+	size_t ssid_len;
+};
+
+struct cc33xx_if_operations {
+	void (*interface_claim)(struct device *child);
+	void (*interface_release)(struct device *child);
+	int __must_check (*read)(struct device *child, int addr, void *buf,
+				 size_t len, bool fixed);
+	int __must_check (*write)(struct device *child, int addr, void *buf,
+				  size_t len, bool fixed);
+	void (*reset)(struct device *child);
+	void (*init)(struct device *child);
+	int (*power)(struct device *child, bool enable);
+	void (*set_block_size)(struct device *child, unsigned int blksz);
+	size_t (*get_max_transaction_len)(struct device *child);
+	void (*set_irq_handler)(struct device *child, void *irq_handler);
+	void (*enable_irq)(struct device *child);
+	void (*disable_irq)(struct device *child);
+};
+
+struct cc33xx_platdev_data {
+	struct cc33xx_if_operations *if_ops;
+	const struct cc33xx_family_data *family;
+	void (*irq_handler)(struct platform_device *pdev);
+	int  gpio_irq_num;
+
+	bool ref_clock_xtal;	/* specify whether the clock is XTAL or not */
+	bool pwr_in_suspend;
+};
+
+#define MAX_NUM_KEYS 14
+#define MAX_KEY_SIZE 32
+
+struct cc33xx_ap_key {
+	u8 id;
+	u8 key_type;
+	u8 key_size;
+	u8 key[MAX_KEY_SIZE];
+	u8 hlid;
+	u32 tx_seq_32;
+	u16 tx_seq_16;
+};
+
+enum cc33xx_flags {
+	CC33XX_FLAG_GPIO_POWER,
+	CC33XX_FLAG_TX_PENDING,
+	CC33XX_FLAG_IN_ELP,
+	CC33XX_FLAG_FW_TX_BUSY,
+	CC33XX_FLAG_DUMMY_PACKET_PENDING,
+	CC33XX_FLAG_SUSPENDED,
+	CC33XX_FLAG_PENDING_WORK,
+	CC33XX_FLAG_SOFT_GEMINI,
+	CC33XX_FLAG_DRIVER_REMOVED,
+	CC33XX_FLAG_RECOVERY_IN_PROGRESS,
+	CC33XX_FLAG_VIF_CHANGE_IN_PROGRESS,
+	CC33XX_FLAG_IO_FAILED,
+	CC33XX_FLAG_REINIT_TX_WDOG,
+};
+
+enum cc33xx_vif_flags {
+	WLVIF_FLAG_INITIALIZED,
+	WLVIF_FLAG_STA_ASSOCIATED,
+	WLVIF_FLAG_STA_AUTHORIZED,
+	WLVIF_FLAG_IBSS_JOINED,
+	WLVIF_FLAG_AP_STARTED,
+	WLVIF_FLAG_IN_PS,
+	WLVIF_FLAG_STA_STATE_SENT,
+	WLVIF_FLAG_PSPOLL_FAILURE,
+	WLVIF_FLAG_CS_PROGRESS,
+	WLVIF_FLAG_AP_PROBE_RESP_SET,
+	WLVIF_FLAG_IN_USE,
+	WLVIF_FLAG_ACTIVE,
+	WLVIF_FLAG_BEACON_DISABLED,
+};
+
+struct cc33xx_vif;
+
+struct cc33xx_link {
+	/* AP-mode - TX queue per AC in link */
+	struct sk_buff_head tx_queue[NUM_TX_QUEUES];
+
+	/* accounting for allocated / freed packets in FW */
+	u8 allocated_pkts;
+	u8 prev_freed_pkts;
+
+	u8 addr[ETH_ALEN];
+
+	/* bitmap of TIDs where RX BA sessions are active for this link */
+	u8 ba_bitmap;
+
+	/* the last fw rate index we used for this link */
+	u8 fw_rate_idx;
+
+	/* the last fw rate [Mbps] we used for this link */
+	u8 fw_rate_mbps;
+
+	/* The wlvif this link belongs to. Might be null for global links */
+	struct cc33xx_vif *wlvif;
+
+	/* total freed FW packets on the link - used for tracking the
+	 * AES/TKIP PN across recoveries. Re-initialized each time
+	 * from the cc33xx_station structure.
+	 */
+	u64 total_freed_pkts;
+};
+
+#define CC33XX_MAX_RX_FILTERS 5
+#define CC33XX_RX_FILTER_MAX_FIELDS 8
+
+#define CC33XX_RX_FILTER_ETH_HEADER_SIZE 14
+#define CC33XX_RX_FILTER_MAX_FIELDS_SIZE 95
+#define RX_FILTER_FIELD_OVERHEAD				\
+	(sizeof(struct cc33xx_rx_filter_field) - sizeof(u8 *))
+#define CC33XX_RX_FILTER_MAX_PATTERN_SIZE			\
+	(CC33XX_RX_FILTER_MAX_FIELDS_SIZE - RX_FILTER_FIELD_OVERHEAD)
+
+#define CC33XX_RX_FILTER_FLAG_IP_HEADER           0
+#define CC33XX_RX_FILTER_FLAG_ETHERNET_HEADER     BIT(1)
+
+struct ieee80211_header {
+	__le16 frame_ctl;
+	__le16 duration_id;
+	u8 da[ETH_ALEN];
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 seq_ctl;
+	u8 payload[];
+} __packed;
+
+enum rx_filter_action {
+	FILTER_DROP = 0,
+	FILTER_SIGNAL = 1,
+	FILTER_FW_HANDLE = 2
+};
+
+enum plt_mode {
+	PLT_OFF = 0,
+	PLT_ON = 1,
+	PLT_FEM_DETECT = 2,
+	PLT_CHIP_AWAKE = 3
+};
+
+struct cc33xx_rx_filter_field {
+	__le16 offset;
+	u8 len;
+	u8 flags;
+	u8 *pattern;
+} __packed;
+
+struct cc33xx_rx_filter {
+	u8 action;
+	int num_fields;
+	struct cc33xx_rx_filter_field fields[CC33XX_RX_FILTER_MAX_FIELDS];
+};
+
+struct cc33xx_station {
+	u8 hlid;
+	bool in_connection;
+
+	/* total freed FW packets on the link to the STA - used for tracking the
+	 * AES/TKIP PN across recoveries. Re-initialized each time from the
+	 * cc33xx_station structure.
+	 * Used in both AP and STA mode.
+	 */
+	u64 total_freed_pkts;
+};
+
+struct cc33xx_vif {
+	struct cc33xx *cc;
+	struct list_head list;
+	unsigned long flags;
+	u8 bss_type;
+	u8 p2p; /* we are using p2p role */
+	u8 role_id;
+
+	/* sta/ibss specific */
+	u8 dev_role_id;
+	u8 dev_hlid;
+
+	union {
+		struct {
+			u8 hlid;
+
+			u8 basic_rate_idx;
+			u8 ap_rate_idx;
+			u8 p2p_rate_idx;
+
+			bool qos;
+			/* channel type we started the STA role with */
+			enum nl80211_channel_type role_chan_type;
+		} sta;
+		struct {
+			u8 global_hlid;
+			u8 bcast_hlid;
+
+			/* HLIDs bitmap of associated stations */
+			unsigned long sta_hlid_map[BITS_TO_LONGS(CC33XX_MAX_LINKS)];
+
+			/* recoreded keys - set here before AP startup */
+			struct cc33xx_ap_key *recorded_keys[MAX_NUM_KEYS];
+
+			u8 mgmt_rate_idx;
+			u8 bcast_rate_idx;
+			u8 ucast_rate_idx[CONF_TX_MAX_AC_COUNT];
+		} ap;
+	};
+
+	/* the hlid of the last transmitted skb */
+	int last_tx_hlid;
+
+	/* counters of packets per AC, across all links in the vif */
+	int tx_queue_count[NUM_TX_QUEUES];
+
+	unsigned long links_map[BITS_TO_LONGS(CC33XX_MAX_LINKS)];
+
+	u8 ssid[IEEE80211_MAX_SSID_LEN + 1];
+	u8 ssid_len;
+
+	/* The current band */
+	enum nl80211_band band;
+	int channel;
+	enum nl80211_channel_type channel_type;
+
+	u32 bitrate_masks[CC33XX_NUM_BANDS];
+	u32 basic_rate_set;
+
+	/* currently configured rate set:
+	 *	bits  0-15 - 802.11abg rates
+	 *	bits 16-23 - 802.11n   MCS index mask
+	 * support only 1 stream, thus only 8 bits for the MCS rates (0-7).
+	 */
+	u32 basic_rate;
+	u32 rate_set;
+
+	/* probe-req template for the current AP */
+	struct sk_buff *probereq;
+
+	/* Beaconing interval (needed for ad-hoc) */
+	u32 beacon_int;
+
+	/* Default key (for WEP) */
+	u32 default_key;
+
+	/* Our association ID */
+	u16 aid;
+
+	/* retry counter for PSM entries */
+	u8 psm_entry_retry;
+
+	/* in dBm */
+	int power_level;
+
+	int rssi_thold;
+	int last_rssi_event;
+
+	/* save the current encryption type for auto-arp config */
+	u8 encryption_type;
+	__be32 ip_addr;
+
+	/* RX BA constraint value */
+	bool ba_support;
+	bool ba_allowed;
+
+	bool wmm_enabled;
+
+	bool radar_enabled;
+
+	struct delayed_work channel_switch_work;
+	struct delayed_work connection_loss_work;
+
+	/* number of in connection stations */
+	int inconn_count;
+
+	/* This vif's queues are mapped to mac80211 HW queues as:
+	 * VO - hw_queue_base
+	 * VI - hw_queue_base + 1
+	 * BE - hw_queue_base + 2
+	 * BK - hw_queue_base + 3
+	 */
+	int hw_queue_base;
+
+	/* do we have a pending auth reply? (and ROC) */
+	bool ap_pending_auth_reply;
+
+	/* time when we sent the pending auth reply */
+	unsigned long pending_auth_reply_time;
+
+	/* work for canceling ROC after pending auth reply */
+	struct delayed_work pending_auth_complete_work;
+
+	struct delayed_work roc_timeout_work;
+
+	/* update rate conrol */
+	enum ieee80211_sta_rx_bandwidth rc_update_bw;
+	struct ieee80211_sta_ht_cap rc_ht_cap;
+	struct work_struct rc_update_work;
+
+	/* total freed FW packets on the link.
+	 * For STA this holds the PN of the link to the AP.
+	 * For AP this holds the PN of the broadcast link.
+	 */
+	u64 total_freed_pkts;
+
+	/* for MBSSID: this BSS is a nontransmitted BSS profile
+	 * Relevant for STA role
+	 */
+	bool nontransmitted;
+
+	/* for MBSSID: update transmitter BSSID */
+	u8 transmitter_bssid[ETH_ALEN];
+
+	/* for MBSSID: BSSID index */
+	u8 bssid_index;
+
+	/* for MBSSID: BSSID indicator */
+	u8 bssid_indicator;
+
+	/* for STA: if connection established and has HE support*/
+	u8 sta_has_he;
+
+	/* This struct must be last!
+	 * data that has to be saved acrossed reconfigs (e.g. recovery)
+	 * should be declared in this struct.
+	 */
+	u8 persistent[];
+};
+
+static inline struct cc33xx_vif *cc33xx_vif_to_data(struct ieee80211_vif *vif)
+{
+	WARN_ON(!vif);
+	return (struct cc33xx_vif *)vif->drv_priv;
+}
+
+static inline
+struct ieee80211_vif *cc33xx_wlvif_to_vif(struct cc33xx_vif *wlvif)
+{
+	return container_of((void *)wlvif, struct ieee80211_vif, drv_priv);
+}
+
+static inline bool cc33xx_is_p2p_mgmt(struct cc33xx_vif *wlvif)
+{
+	return cc33xx_wlvif_to_vif(wlvif)->type == NL80211_IFTYPE_P2P_DEVICE;
+}
+
+#define cc33xx_for_each_wlvif(cc, wlvif) \
+		list_for_each_entry(wlvif, &(cc)->wlvif_list, list)
+
+#define cc33xx_for_each_wlvif_continue(cc, wlvif) \
+		list_for_each_entry_continue(wlvif, &(cc)->wlvif_list, list)
+
+#define cc33xx_for_each_wlvif_bss_type(cc, wlvif, _bss_type)	\
+		cc33xx_for_each_wlvif((cc), (wlvif))		\
+			if ((wlvif)->bss_type == (_bss_type))
+
+#define cc33xx_for_each_wlvif_sta(cc, wlvif)	\
+		cc33xx_for_each_wlvif_bss_type(cc, wlvif, BSS_TYPE_STA_BSS)
+
+#define cc33xx_for_each_wlvif_ap(cc, wlvif)	\
+		cc33xx_for_each_wlvif_bss_type(cc, wlvif, BSS_TYPE_AP_BSS)
+
+int cc33xx_plt_start(struct cc33xx *cc, const enum plt_mode plt_mode);
+int cc33xx_plt_stop(struct cc33xx *cc);
+void cc33xx_queue_recovery_work(struct cc33xx *cc);
+void cc33xx_flush_deferred_work(struct cc33xx *cc);
+
+#define SESSION_COUNTER_INVALID 7 /* used with dummy_packet */
+
+#define CC33XX_MAX_TXPWR 21 /* maximum power limit is 21dBm */
+#define CC33XX_MIN_TXPWR -10 /* minmum power limit is -10dBm */
+
+#define CC33XX_TX_QUEUE_LOW_WATERMARK  32
+#define CC33XX_TX_QUEUE_HIGH_WATERMARK 256
+
+#define CC33XX_RX_QUEUE_MAX_LEN 256
+
+/* cc33xx needs a 200ms sleep after power on, and a 20ms sleep before power
+ * on in case is has been shut down shortly before
+ */
+#define CC33XX_PRE_POWER_ON_SLEEP 20 /* in milliseconds */
+#define CC33XX_POWER_ON_SLEEP 200 /* in milliseconds */
+
+/* Macros to handle cc33xx.sta_rate_set */
+#define HW_HT_RATES_OFFSET	16
+#define HW_MIMO_RATES_OFFSET	24
+
+#endif /* __CC33XX_I_H__ */
-- 
2.25.1


