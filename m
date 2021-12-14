Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F04740AB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhLNKnk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 05:43:40 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25022 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhLNKnj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 05:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639478619; x=1671014619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OLft2jCwrioNvzdFa7N5ld9TAlaKeRKVnr0P95vKH4U=;
  b=T+3OM9Kpp46QO1alTDSP6XWzKQCWQcq2WP/MyVWg1GvY14Fb4IsD93lH
   5uLQBvqcdEg+7Pgjl8QnM75BQ17yEHkaQllrSHxfTeUbNrnwFu+3Zj89D
   NgxbGrLJh0NtP047eotTvjFj8L+Dshw3nAF4+gGZru58PRawqaSZqxVJg
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Dec 2021 02:43:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 02:43:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 02:43:38 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 02:43:36 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v4] ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855
Date:   Tue, 14 Dec 2021 05:39:14 -0500
Message-ID: <20211214103914.5665-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Command "iw wls1 station dump" does not show each chain's rssi currently.

If the rssi of each chain from mon status which parsed in function
ath11k_hal_rx_parse_mon_status_tlv() is invalid, then ath11k send
wmi cmd WMI_REQUEST_STATS_CMDID with flag WMI_REQUEST_RSSI_PER_CHAIN_STAT
to firmware, and parse the rssi of chain in wmi WMI_UPDATE_STATS_EVENTID,
then report them to mac80211.

WMI_REQUEST_STATS_CMDID is only sent when CONFIG_ATH11K_DEBUGFS is set,
it is only called by ath11k_mac_op_sta_statistics(). It does not effect
performance and power consumption. Because after STATION connected to
AP, it is only called every 6 seconds by NetworkManager in below stack.

[  797.005587] CPU: 0 PID: 701 Comm: NetworkManager Tainted: G        W  OE     5.13.0-rc6-wt-ath+ #2
[  797.005596] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW (1.33 ) 07/29/2011
[  797.005600] RIP: 0010:ath11k_mac_op_sta_statistics+0x2f/0x1b0 [ath11k]
[  797.005644] Code: 41 56 41 55 4c 8d aa 58 01 00 00 41 54 55 48 89 d5 53 48 8b 82 58 01 00 00 48 89 cb 4c 8b 70 20 49 8b 06 4c 8b a0 90 08 00 00 <0f> 0b 48 8b 82 b8 01 00 00 48 ba 00 00 00 00 01 00 00 00 48 89 81
[  797.005651] RSP: 0018:ffffb1fc80a4b890 EFLAGS: 00010282
[  797.005658] RAX: ffff8a5726200000 RBX: ffffb1fc80a4b958 RCX: ffffb1fc80a4b958
[  797.005664] RDX: ffff8a5726a609f0 RSI: ffff8a581247f598 RDI: ffff8a5702878800
[  797.005668] RBP: ffff8a5726a609f0 R08: 0000000000000000 R09: 0000000000000000
[  797.005672] R10: 0000000000000000 R11: 0000000000000007 R12: 02dd68024f75f480
[  797.005676] R13: ffff8a5726a60b48 R14: ffff8a5702879f40 R15: ffff8a5726a60000
[  797.005681] FS:  00007f632c52a380(0000) GS:ffff8a583a200000(0000) knlGS:0000000000000000
[  797.005687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  797.005692] CR2: 00007fb025d69000 CR3: 00000001124f6005 CR4: 00000000000606f0
[  797.005698] Call Trace:
[  797.005710]  sta_set_sinfo+0xa7/0xb80 [mac80211]
[  797.005820]  ieee80211_get_station+0x50/0x70 [mac80211]
[  797.005925]  nl80211_get_station+0xd1/0x200 [cfg80211]
[  797.006045]  genl_family_rcv_msg_doit.isra.15+0x111/0x140
[  797.006059]  genl_rcv_msg+0xe6/0x1e0
[  797.006065]  ? nl80211_dump_station+0x220/0x220 [cfg80211]
[  797.006223]  ? nl80211_send_station.isra.72+0xf50/0xf50 [cfg80211]
[  797.006348]  ? genl_family_rcv_msg_doit.isra.15+0x140/0x140
[  797.006355]  netlink_rcv_skb+0xb9/0xf0
[  797.006363]  genl_rcv+0x24/0x40
[  797.006369]  netlink_unicast+0x18e/0x290
[  797.006375]  netlink_sendmsg+0x30f/0x450
[  797.006382]  sock_sendmsg+0x5b/0x60
[  797.006393]  ____sys_sendmsg+0x219/0x240
[  797.006403]  ? copy_msghdr_from_user+0x5c/0x90
[  797.006413]  ? ____sys_recvmsg+0xf5/0x190
[  797.006422]  ___sys_sendmsg+0x88/0xd0
[  797.006432]  ? copy_msghdr_from_user+0x5c/0x90
[  797.006443]  ? ___sys_recvmsg+0x9e/0xd0
[  797.006454]  ? __fget_files+0x58/0x90
[  797.006461]  ? __fget_light+0x2d/0x70
[  797.006466]  ? do_epoll_wait+0xce/0x720
[  797.006476]  ? __sys_sendmsg+0x63/0xa0
[  797.006485]  __sys_sendmsg+0x63/0xa0
[  797.006497]  do_syscall_64+0x3c/0xb0
[  797.006509]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  797.006519] RIP: 0033:0x7f632d99912d
[  797.006526] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
[  797.006533] RSP: 002b:00007ffd80808c00 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
[  797.006540] RAX: ffffffffffffffda RBX: 0000563dab99d840 RCX: 00007f632d99912d
[  797.006545] RDX: 0000000000000000 RSI: 00007ffd80808c50 RDI: 000000000000000b
[  797.006549] RBP: 00007ffd80808c50 R08: 0000000000000000 R09: 0000000000001000
[  797.006552] R10: 0000563dab96f010 R11: 0000000000000293 R12: 0000563dab99d840
[  797.006556] R13: 0000563dabbb28c0 R14: 00007f632dad4280 R15: 0000563dabab11c0
[  797.006563] ---[ end trace c9dcf08920c9945c ]---

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v4: 
   1. rebased to ath.git ath-202112130952
   2. fix initialize the variable 'len'

v3:
   1. rebased to ath.git ath-202112080842
   2. change commit log
   3. change parse method for ath11k_wmi_pull_fw_stats() with ath11k_wmi_tlv_iter()
   4. remove comment of ATH11K_INVALID_RSSI_FULL/ATH11K_INVALID_RSSI_EMPTY
   5. change ath11k_debug_get_fw_stats to ath11k_debugfs_get_fw_stats
   6. change __le32_to_cpu/FIELD_GET to le32_get_bits
   7. add supports_rssi_stats=true in ath11k_hw_params only for QCA6390/WCN6855 as well as ath10k/QCA6174-SDIO/PCIe

v2: rebased to latest ath.git master ath-202111170737

 drivers/net/wireless/ath/ath11k/core.c    |   6 +
 drivers/net/wireless/ath/ath11k/core.h    |   5 +
 drivers/net/wireless/ath/ath11k/debugfs.c |  37 +++++
 drivers/net/wireless/ath/ath11k/debugfs.h |   8 +
 drivers/net/wireless/ath/ath11k/dp_rx.c   |   8 +
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  11 ++
 drivers/net/wireless/ath/ath11k/hal_rx.h  |  12 +-
 drivers/net/wireless/ath/ath11k/hw.h      |   1 +
 drivers/net/wireless/ath/ath11k/mac.c     |  40 +++++
 drivers/net/wireless/ath/ath11k/wmi.c     | 173 +++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/wmi.h     |  11 ++
 11 files changed, 278 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 1d983fde6fc9..6bc1cff27319 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -88,6 +88,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
 		.wakeup_mhi = false,
+		.supports_rssi_stats = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -143,6 +144,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = true,
 		.wakeup_mhi = false,
+		.supports_rssi_stats = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -197,6 +199,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.wakeup_mhi = true,
+		.supports_rssi_stats = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -251,6 +254,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = true,
 		.alloc_cacheable_memory = true,
 		.wakeup_mhi = false,
+		.supports_rssi_stats = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -305,6 +309,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.wakeup_mhi = true,
+		.supports_rssi_stats = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -358,6 +363,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.wakeup_mhi = true,
+		.supports_rssi_stats = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b4203fa0452e..170fc8e66c90 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -385,6 +385,7 @@ struct ath11k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
 
@@ -415,6 +416,10 @@ enum ath11k_state {
 /* Antenna noise floor */
 #define ATH11K_DEFAULT_NOISE_FLOOR -95
 
+#define ATH11K_INVALID_RSSI_FULL -1
+
+#define ATH11K_INVALID_RSSI_EMPTY -128
+
 struct ath11k_fw_stats {
 	struct dentry *debugfs_fwstats;
 	u32 pdev_id;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index dba055d085be..ca68cf63dd27 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -126,6 +126,11 @@ void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb
 		goto complete;
 	}
 
+	if (stats.stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
+		ar->debug.fw_stats_done = true;
+		goto complete;
+	}
+
 	if (stats.stats_id == WMI_REQUEST_VDEV_STAT) {
 		if (list_empty(&stats.vdevs)) {
 			ath11k_warn(ab, "empty vdev stats");
@@ -229,6 +234,38 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 	return 0;
 }
 
+int ath11k_debugfs_get_fw_stats(struct ath11k *ar, u32 pdev_id,
+				u32 vdev_id, u32 stats_id)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	req_param.pdev_id = pdev_id;
+	req_param.vdev_id = vdev_id;
+	req_param.stats_id = stats_id;
+
+	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
+	if (ret)
+		ath11k_warn(ab, "failed to request fw stats: %d\n", ret);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
+		   pdev_id, vdev_id, stats_id);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
 static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 {
 	struct ath11k *ar = inode->i_private;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index ec743a015dc7..4c0740394c95 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -117,6 +117,8 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
 void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
+int ath11k_debugfs_get_fw_stats(struct ath11k *ar, u32 pdev_id,
+				u32 vdev_id, u32 stats_id);
 
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
@@ -216,6 +218,12 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
+static inline int ath11k_debugfs_get_fw_stats(struct ath11k *ar,
+					      u32 pdev_id, u32 vdev_id, u32 stats_id)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 38eeb6e7c6b6..ab681ca36e27 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2768,6 +2768,7 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 {
 	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
 	u32 num_msdu;
+	int i;
 
 	if (!rx_stats)
 		return;
@@ -2829,6 +2830,13 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
+
+	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
+			     ARRAY_SIZE(ppdu_info->rssi_chain_pri20));
+
+	for (i = 0; i < ARRAY_SIZE(arsta->chain_signal); i++)
+		arsta->chain_signal[i] = ppdu_info->rssi_chain_pri20[i];
+
 	rx_stats->rx_duration += ppdu_info->rx_duration;
 	arsta->rx_duration = rx_stats->rx_duration;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 1e279e99baa8..a749903e2a16 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1079,6 +1079,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		break;
 	}
 	case HAL_PHYRX_RSSI_LEGACY: {
+		int i;
+		bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+				       ab->wmi_ab.svc_map);
 		struct hal_rx_phyrx_rssi_legacy_info *rssi =
 			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
 
@@ -1089,6 +1092,14 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ppdu_info->rssi_comb =
 			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB,
 				  __le32_to_cpu(rssi->info0));
+
+		if (db2dbm) {
+			for (i = 0; i < ARRAY_SIZE(rssi->preamble); i++) {
+				ppdu_info->rssi_chain_pri20[i] =
+					le32_get_bits(rssi->preamble[i].rssi_2040,
+						      HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20);
+			}
+		}
 		break;
 	}
 	case HAL_RX_MPDU_START: {
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 8db420ef6351..8488020d3763 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -112,6 +112,7 @@ struct hal_rx_mon_ppdu_info {
 	u8 ldpc;
 	u8 beamformed;
 	u8 rssi_comb;
+	u8 rssi_chain_pri20[HAL_RX_MAX_NSS];
 	u8 tid;
 	u8 dcm;
 	u8 ru_alloc;
@@ -262,8 +263,17 @@ struct hal_rx_he_sig_b2_ofdma_info {
 
 #define HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB	GENMASK(15, 8)
 
+#define HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20	GENMASK(7, 0)
+
+struct hal_rx_phyrx_chain_rssi {
+	__le32 rssi_2040;
+	__le32 rssi_80;
+} __packed;
+
 struct hal_rx_phyrx_rssi_legacy_info {
-	__le32 rsvd[35];
+	__le32 rsvd[3];
+	struct hal_rx_phyrx_chain_rssi pre_rssi[HAL_RX_MAX_NSS];
+	struct hal_rx_phyrx_chain_rssi preamble[HAL_RX_MAX_NSS];
 	__le32 info0;
 } __packed;
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index fe6e0cb9476c..39442bde1e01 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -182,6 +182,7 @@ struct ath11k_hw_params {
 	bool supports_dynamic_smps_6ghz;
 	bool alloc_cacheable_memory;
 	bool wakeup_mhi;
+	bool supports_rssi_stats;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e8b76a311a54..cd9acc62be38 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7772,12 +7772,42 @@ static int ath11k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	return ret;
 }
 
+static void ath11k_mac_put_chain_rssi(struct station_info *sinfo,
+				      struct ath11k_sta *arsta,
+				      char *pre,
+				      bool clear)
+{
+	struct ath11k *ar = arsta->arvif->ar;
+	int i;
+	s8 rssi;
+
+	for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
+		sinfo->chains &= ~BIT(i);
+		rssi = arsta->chain_signal[i];
+		if (clear)
+			arsta->chain_signal[i] = ATH11K_INVALID_RSSI_FULL;
+
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+			   "mac sta statistics %s rssi[%d] %d\n", pre, i, rssi);
+
+		if (rssi != ATH11K_DEFAULT_NOISE_FLOOR &&
+		    rssi != ATH11K_INVALID_RSSI_FULL &&
+		    rssi != ATH11K_INVALID_RSSI_EMPTY &&
+		    rssi != 0) {
+			sinfo->chain_signal[i] = rssi;
+			sinfo->chains |= BIT(i);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+		}
+	}
+}
+
 static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
 					 struct station_info *sinfo)
 {
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -7800,6 +7830,16 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
+	ath11k_mac_put_chain_rssi(sinfo, arsta, "ppdu", false);
+
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
+	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ar->ab->hw_params.supports_rssi_stats &&
+	    !ath11k_debugfs_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+					 WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
+		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
+	}
+
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2b4d27d807ab..3dd49b9ce827 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -73,6 +73,14 @@ struct wmi_tlv_dma_buf_release_parse {
 	bool meta_data_done;
 };
 
+struct wmi_tlv_fw_stats_parse {
+	const struct wmi_stats_event *ev;
+	const struct wmi_per_chain_rssi_stats *rssi;
+	struct ath11k_fw_stats *stats;
+	int rssi_num;
+	bool chain_rssi_done;
+};
+
 static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 	[WMI_TAG_ARRAY_BYTE]
 		= { .min_len = 0 },
@@ -132,6 +140,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_obss_color_collision_event) },
 	[WMI_TAG_11D_NEW_COUNTRY_EVENT] = {
 		.min_len = sizeof(struct wmi_11d_new_cc_ev) },
+	[WMI_TAG_PER_CHAIN_RSSI_STATS] = {
+		.min_len = sizeof(struct wmi_per_chain_rssi_stats) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -5554,37 +5564,83 @@ ath11k_wmi_pull_bcn_stats(const struct wmi_bcn_stats *src,
 	dst->tx_bcn_outage_cnt = src->tx_bcn_outage_cnt;
 }
 
-int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
-			     struct ath11k_fw_stats *stats)
+static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
+					   u16 tag, u16 len,
+					   const void *ptr, void *data)
 {
-	const void **tb;
-	const struct wmi_stats_event *ev;
-	const void *data;
-	int i, ret;
-	u32 len = skb->len;
+	struct wmi_tlv_fw_stats_parse *parse = data;
+	const struct wmi_stats_event *ev = parse->ev;
+	struct ath11k_fw_stats *stats = parse->stats;
+	struct ath11k *ar;
+	struct ath11k_vif *arvif;
+	struct ieee80211_sta *sta;
+	struct ath11k_sta *arsta;
+	const struct wmi_rssi_stats *stats_rssi = (const struct wmi_rssi_stats *)ptr;
+	int j;
 
-	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, len, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return ret;
-	}
+	if (tag != WMI_TAG_RSSI_STATS)
+		return -EPROTO;
 
-	ev = tb[WMI_TAG_STATS_EVENT];
-	data = tb[WMI_TAG_ARRAY_BYTE];
-	if (!ev || !data) {
-		ath11k_warn(ab, "failed to fetch update stats ev");
-		kfree(tb);
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
+	stats->stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "wmi stats vdev id %d mac %pM\n",
+		   stats_rssi->vdev_id, stats_rssi->peer_macaddr.addr);
+
+	arvif = ath11k_mac_get_arvif(ar, stats_rssi->vdev_id);
+	if (!arvif) {
+		ath11k_warn(ab, "not found vif for vdev id %d\n",
+			    stats_rssi->vdev_id);
 		return -EPROTO;
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "wmi stats update ev pdev_id %d pdev %i vdev %i bcn %i\n",
-		   ev->pdev_id,
-		   ev->num_pdev_stats, ev->num_vdev_stats,
-		   ev->num_bcn_stats);
+		   "wmi stats bssid %pM vif %pK\n",
+		   arvif->bssid, arvif->vif);
+
+	sta = ieee80211_find_sta_by_ifaddr(ar->hw,
+					   arvif->bssid,
+					   NULL);
+	if (!sta) {
+		ath11k_warn(ab, "not found station for bssid %pM\n",
+			    arvif->bssid);
+		return -EPROTO;
+	}
+
+	arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
+		     ARRAY_SIZE(stats_rssi->rssi_avg_beacon));
+
+	for (j = 0; j < ARRAY_SIZE(arsta->chain_signal); j++) {
+		arsta->chain_signal[j] = stats_rssi->rssi_avg_beacon[j];
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi stats beacon rssi[%d] %d data rssi[%d] %d\n",
+			   j,
+			   stats_rssi->rssi_avg_beacon[j],
+			   j,
+			   stats_rssi->rssi_avg_data[j]);
+	}
+
+	return 0;
+}
+
+static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
+					      struct wmi_tlv_fw_stats_parse *parse,
+					      const void *ptr,
+					      u16 len)
+{
+	struct ath11k_fw_stats *stats = parse->stats;
+	const struct wmi_stats_event *ev = parse->ev;
+	int i;
+	const void *data = ptr;
+
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch update stats ev");
+		return -EPROTO;
+	}
 
-	stats->pdev_id = ev->pdev_id;
 	stats->stats_id = 0;
 
 	for (i = 0; i < ev->num_pdev_stats; i++) {
@@ -5592,10 +5648,8 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		struct ath11k_fw_stats_pdev *dst;
 
 		src = data;
-		if (len < sizeof(*src)) {
-			kfree(tb);
+		if (len < sizeof(*src))
 			return -EPROTO;
-		}
 
 		stats->stats_id = WMI_REQUEST_PDEV_STAT;
 
@@ -5617,10 +5671,8 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		struct ath11k_fw_stats_vdev *dst;
 
 		src = data;
-		if (len < sizeof(*src)) {
-			kfree(tb);
+		if (len < sizeof(*src))
 			return -EPROTO;
-		}
 
 		stats->stats_id = WMI_REQUEST_VDEV_STAT;
 
@@ -5640,10 +5692,8 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		struct ath11k_fw_stats_bcn *dst;
 
 		src = data;
-		if (len < sizeof(*src)) {
-			kfree(tb);
+		if (len < sizeof(*src))
 			return -EPROTO;
-		}
 
 		stats->stats_id = WMI_REQUEST_BCN_STAT;
 
@@ -5658,10 +5708,67 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		list_add_tail(&dst->list, &stats->bcn);
 	}
 
-	kfree(tb);
 	return 0;
 }
 
+static int ath11k_wmi_tlv_fw_stats_parse(struct ath11k_base *ab,
+					 u16 tag, u16 len,
+					 const void *ptr, void *data)
+{
+	struct wmi_tlv_fw_stats_parse *parse = data;
+	int ret = 0;
+
+	switch (tag) {
+	case WMI_TAG_STATS_EVENT:
+		parse->ev = (struct wmi_stats_event *)ptr;
+		parse->stats->pdev_id = parse->ev->pdev_id;
+		break;
+	case WMI_TAG_ARRAY_BYTE:
+		ret = ath11k_wmi_tlv_fw_stats_data_parse(ab, parse, ptr, len);
+		break;
+	case WMI_TAG_PER_CHAIN_RSSI_STATS:
+		parse->rssi = (struct wmi_per_chain_rssi_stats *)ptr;
+
+		if (parse->ev->stats_id & WMI_REQUEST_RSSI_PER_CHAIN_STAT)
+			parse->rssi_num = parse->rssi->num_per_chain_rssi_stats;
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi stats id 0x%x num chain %d\n",
+			   parse->ev->stats_id,
+			   parse->rssi_num);
+		break;
+	case WMI_TAG_ARRAY_STRUCT:
+		if (parse->rssi_num && !parse->chain_rssi_done) {
+			ret = ath11k_wmi_tlv_iter(ab, ptr, len,
+						  ath11k_wmi_tlv_rssi_chain_parse,
+						  parse);
+			if (ret) {
+				ath11k_warn(ab, "failed to parse rssi chain %d\n",
+					    ret);
+				return ret;
+			}
+			parse->chain_rssi_done = true;
+		}
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
+			     struct ath11k_fw_stats *stats)
+{
+	struct wmi_tlv_fw_stats_parse parse = { };
+
+	stats->stats_id = 0;
+	parse.stats = stats;
+
+	return ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				   ath11k_wmi_tlv_fw_stats_parse,
+				   &parse);
+}
+
 size_t ath11k_wmi_fw_stats_num_vdevs(struct list_head *head)
 {
 	struct ath11k_fw_stats_vdev *i;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index d79eb1b7d9c2..20aa7234fc72 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4439,6 +4439,17 @@ struct wmi_stats_event {
 	u32 num_peer_extd2_stats;
 } __packed;
 
+struct wmi_rssi_stats {
+	u32 vdev_id;
+	u32 rssi_avg_beacon[WMI_MAX_CHAINS];
+	u32 rssi_avg_data[WMI_MAX_CHAINS];
+	struct wmi_mac_addr peer_macaddr;
+} __packed;
+
+struct wmi_per_chain_rssi_stats {
+	u32 num_per_chain_rssi_stats;
+} __packed;
+
 struct wmi_pdev_ctl_failsafe_chk_event {
 	u32 pdev_id;
 	u32 ctl_failsafe_status;

base-commit: 0abfb34f907411efa6535b6438be6b2971f1e5a2
-- 
2.31.1

