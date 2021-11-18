Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360EB4558FD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 11:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbhKRK1E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:27:04 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29976 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245133AbhKRK0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637231027; x=1668767027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XDCaE2beDEl9RU18faXJHnFJuctQe+e/zHJV3hiCqW8=;
  b=d1uTUOvyxvD679XlYWDnMIOlfFrMx+BYPCr50scOsdve2Kp3YFGoh1QO
   n06gZn1/ehqT+xCOYqRmX+IpG2AuJnVeoqRpFNjgCTYlh4/jYOoStuNiu
   Sjk+RlmF7jyhTevy6emwda9r26HVJ6WrMpcnFRjbPJRtMhr3GM1+laeja
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Nov 2021 02:23:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 02:23:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 02:23:46 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 02:23:45 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: report rssi of each chain to mac80211
Date:   Thu, 18 Nov 2021 05:23:31 -0500
Message-ID: <20211118102331.10726-1-quic_wgong@quicinc.com>
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

This patch is to change like this:
If the rssi of each chain from mon status is invalid, then ath11k send
wmi cmd WMI_REQUEST_STATS_CMDID with flag WMI_REQUEST_RSSI_PER_CHAIN_STAT
to firmware, and parse the rssi of chain in wmi WMI_UPDATE_STATS_EVENTID,
then report them to mac80211.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: rebased to latest ath.git master ath-202111170737

 drivers/net/wireless/ath/ath11k/core.h    |   7 ++
 drivers/net/wireless/ath/ath11k/debugfs.c |  36 ++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |   7 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c   |   8 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  13 +++
 drivers/net/wireless/ath/ath11k/hal_rx.h  |  12 ++-
 drivers/net/wireless/ath/ath11k/mac.c     |  38 ++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     | 107 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h     |  14 +++
 9 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bbfc10fd5c6d..12bb78f2c7a8 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -382,6 +382,7 @@ struct ath11k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
 
@@ -412,6 +413,12 @@ enum ath11k_state {
 /* Antenna noise floor */
 #define ATH11K_DEFAULT_NOISE_FLOOR -95
 
+/* signed value, 11111111h, it is full bit value, invalid */
+#define ATH11K_INVALID_RSSI_FULL -1
+
+/* signed value, 10000000h, it is empty value, invalid */
+#define ATH11K_INVALID_RSSI_EMPTY -128
+
 struct ath11k_fw_stats {
 	struct dentry *debugfs_fwstats;
 	u32 pdev_id;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index dba055d085be..9e3bc177a626 100644
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
@@ -229,6 +234,37 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 	return 0;
 }
 
+int ath11k_debug_get_fw_stats(struct ath11k *ar, u32 pdev_id, u32 vdev_id, u32 stats_id)
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
index ec743a015dc7..fd71ec207786 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -117,6 +117,7 @@ void ath11k_debugfs_unregister(struct ath11k *ar);
 void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
 
 void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
+int ath11k_debug_get_fw_stats(struct ath11k *ar, u32 pdev_id, u32 vdev_id, u32 stats_id);
 
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
@@ -216,6 +217,12 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
+static inline int ath11k_debug_get_fw_stats(struct ath11k *ar,
+					    u32 pdev_id, u32 vdev_id, u32 stats_id)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index fcd7a6d27d12..85352e7a7f32 100644
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
index 329c404cfa80..bb478771dfea 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1080,6 +1080,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		break;
 	}
 	case HAL_PHYRX_RSSI_LEGACY: {
+		int i;
+		bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+				       ab->wmi_ab.svc_map);
 		struct hal_rx_phyrx_rssi_legacy_info *rssi =
 			(struct hal_rx_phyrx_rssi_legacy_info *)tlv_data;
 
@@ -1090,6 +1093,16 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		ppdu_info->rssi_comb =
 			FIELD_GET(HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO1_RSSI_COMB,
 				  __le32_to_cpu(rssi->info0));
+
+		if (db2dbm) {
+			for (i = 0; i < ARRAY_SIZE(rssi->preamble); i++) {
+				u32 rssi2040 = __le32_to_cpu(rssi->preamble[i].rssi_2040);
+
+				ppdu_info->rssi_chain_pri20[i] =
+					FIELD_GET(HAL_RX_PHYRX_RSSI_PREAMBLE_PRI20,
+						  rssi2040);
+			}
+		}
 		break;
 	}
 	case HAL_RX_MPDU_START: {
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 0f1f04b812b9..46597b15fb33 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -98,6 +98,7 @@ struct hal_rx_mon_ppdu_info {
 	u8 ldpc;
 	u8 beamformed;
 	u8 rssi_comb;
+	u8 rssi_chain_pri20[HAL_RX_MAX_NSS];
 	u8 tid;
 	u8 dcm;
 	u8 ru_alloc;
@@ -248,8 +249,17 @@ struct hal_rx_he_sig_b2_ofdma_info {
 
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
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 292b2b7eab11..acb6a513954e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7481,12 +7481,42 @@ static int ath11k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
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
@@ -7509,6 +7539,14 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 	}
 
+	ath11k_mac_put_chain_rssi(sinfo, arsta, "ppdu", false);
+
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
+	    !ath11k_debug_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				       WMI_REQUEST_RSSI_PER_CHAIN_STAT)) {
+		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
+	}
+
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 614b2f6bcc8e..9c3a7c453588 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -130,6 +130,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
 	[WMI_TAG_OBSS_COLOR_COLLISION_EVT] = {
 		.min_len = sizeof(struct wmi_obss_color_collision_event) },
+	[WMI_TAG_PER_CHAIN_RSSI_STATS] = {
+		.min_len = sizeof(struct wmi_per_chain_rssi_stats) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -5432,10 +5434,17 @@ ath11k_wmi_pull_bcn_stats(const struct wmi_bcn_stats *src,
 int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 			     struct ath11k_fw_stats *stats)
 {
+	struct ath11k *ar;
 	const void **tb;
 	const struct wmi_stats_event *ev;
+	const struct wmi_per_chain_rssi_stats *rssi;
+	const struct wmi_rssi_stats *stats_rssi;
+	struct ieee80211_sta *sta;
+	struct ath11k_sta *arsta;
 	const void *data;
-	int i, ret;
+	const struct wmi_tlv *tlv;
+	u16 tlv_tag, tlv_len;
+	int i, ret, rssi_num = 0;
 	u32 len = skb->len;
 
 	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, len, GFP_ATOMIC);
@@ -5447,12 +5456,18 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 
 	ev = tb[WMI_TAG_STATS_EVENT];
 	data = tb[WMI_TAG_ARRAY_BYTE];
+	rssi = tb[WMI_TAG_PER_CHAIN_RSSI_STATS];
 	if (!ev || !data) {
 		ath11k_warn(ab, "failed to fetch update stats ev");
 		kfree(tb);
 		return -EPROTO;
 	}
 
+	if (rssi && (ev->stats_id & WMI_REQUEST_RSSI_PER_CHAIN_STAT))
+		rssi_num = rssi->num_per_chain_rssi_stats;
+
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
+
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
 		   "wmi stats update ev pdev_id %d pdev %i vdev %i bcn %i\n",
 		   ev->pdev_id,
@@ -5533,6 +5548,96 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		list_add_tail(&dst->list, &stats->bcn);
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "wmi stats id 0x%x num chain %d\n",
+		   ev->stats_id,
+		   rssi_num);
+
+	if (rssi_num) {
+		/* This TLV of WMI_TAG_PER_CHAIN_RSSI_STATS is followed by
+		 * another TLV of array of structs
+		 * wmi_rssi_stats rssi_stats[num_per_chain_rssi_stats].
+		 * So add check integrity for the TLVs.
+		 * rssi is behind the TLV of WMI_TAG_PER_CHAIN_RSSI_STATS.
+		 */
+		tlv = (struct wmi_tlv *)((u8 *)rssi - sizeof(*tlv));
+		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
+
+		/* Skip wmi_per_chain_rssi_stats to get the TLV of array structs */
+		tlv = (struct wmi_tlv *)((u8 *)rssi + tlv_len);
+		if (((u8 *)tlv - skb->data) >= skb->len)
+			goto fin;
+
+		tlv_tag = FIELD_GET(WMI_TLV_TAG, tlv->header);
+		if (tlv_tag != WMI_TAG_ARRAY_STRUCT)
+			rssi_num = 0;
+
+		/* Skip array struct TLV to get the array of structs */
+		tlv++;
+		if (((u8 *)tlv - skb->data) >= skb->len)
+			goto fin;
+
+		tlv_len = FIELD_GET(WMI_TLV_LEN, tlv->header);
+	}
+
+	for (i = 0; i < rssi_num; i++) {
+		struct ath11k_vif *arvif;
+		int j;
+
+		stats_rssi = (struct wmi_rssi_stats *)((u8 *)tlv + i *
+			(sizeof(*tlv) + tlv_len));
+		if (((u8 *)stats_rssi - skb->data) >= skb->len)
+			goto fin;
+
+		tlv_tag = FIELD_GET(WMI_TLV_TAG, stats_rssi->tlv_header);
+		if (tlv_tag != WMI_TAG_RSSI_STATS) {
+			ath11k_warn(ab, "invalid rssi stats TLV data\n");
+			break;
+		}
+
+		stats->stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi stats vdev id %d mac %pM\n",
+			   stats_rssi->vdev_id, stats_rssi->peer_macaddr.addr);
+
+		arvif = ath11k_mac_get_arvif(ar, stats_rssi->vdev_id);
+		if (!arvif) {
+			ath11k_warn(ab, "not found vif for vdev id %d\n",
+				    stats_rssi->vdev_id);
+			continue;
+		}
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "wmi stats bssid %pM vif %pK\n",
+			   arvif->bssid, arvif->vif);
+
+		sta = ieee80211_find_sta_by_ifaddr(ar->hw,
+						   arvif->bssid,
+						   NULL);
+		if (!sta) {
+			ath11k_warn(ab, "not found station for bssid %pM\n",
+				    arvif->bssid);
+			continue;
+		}
+
+		arsta = (struct ath11k_sta *)sta->drv_priv;
+
+		BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
+			     ARRAY_SIZE(stats_rssi->rssi_avg_beacon));
+
+		for (j = 0; j < ARRAY_SIZE(arsta->chain_signal); j++) {
+			arsta->chain_signal[j] = stats_rssi->rssi_avg_beacon[j];
+			ath11k_dbg(ab, ATH11K_DBG_WMI,
+				   "wmi stats beacon rssi[%d] %d data rssi[%d] %d\n",
+				   j,
+				   stats_rssi->rssi_avg_beacon[j],
+				   j,
+				   stats_rssi->rssi_avg_data[j]);
+		}
+	}
+
+fin:
 	kfree(tb);
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4eb06cb7f883..6d703216550f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4394,6 +4394,20 @@ struct wmi_stats_event {
 	u32 num_peer_extd2_stats;
 } __packed;
 
+#define WMI_MAX_CHAINS 8
+
+struct wmi_rssi_stats {
+	u32 tlv_header;
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

base-commit: 63ec871bc50a306aac550e2d85f697ca2d5f5deb
-- 
2.31.1

