Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B69476AC7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 08:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhLPHFy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 02:05:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:49145 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhLPHFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 02:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639638354; x=1671174354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XE/Ve63VLVQ+hTzTqweqeznGKtPu/uPxQbv6WbvIVC0=;
  b=TIUoSmpi/NpYyE6mxLIq6luKN/yzD26KAYqbwgIHFfl+fq9vE1f6rx0H
   bLcrY37PCU/1w6KWSn1sn/ZhI3ojSD5kU7OJ5EaA5IqGb0l9eE0B/3oDi
   k1iBeIfaCIdPn6HzSO1Rj6+6T26eCqiygc8V9syJCr/v5wF5dOG9hZylE
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Dec 2021 23:05:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 23:05:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 23:05:53 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 23:05:52 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: add signal report to mac80211 for QCA6390 and WCN6855
Date:   Thu, 16 Dec 2021 02:05:35 -0500
Message-ID: <20211216070535.31732-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE80211_HW_USES_RSS is set in ath11k, then the device uses RSS and
thus requires parallel RX which implies using per-CPU station statistics
in sta_get_last_rx_stats() of mac80211. Currently signal is only set in
ath11k_mgmt_rx_event(), and not set for RX data packet, then it show
signal as 0 for iw command easily.

Change to get signal from firmware and report to mac80211.

For QCA6390 and WCN6855, the rssi value is already in dbm unit, so
don't need to convert it again.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2:
    1. rebased to ath.git ath-202112141538
    2. change commit log
depends on patch "[v6] ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855"
https://patchwork.kernel.org/project/linux-wireless/patch/20211215090944.19729-1-quic_wgong@quicinc.com/

 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 22 ++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c  | 49 +++++++++++++++++++++-----
 3 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 170fc8e66c90..aa6d51d17e31 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -385,6 +385,7 @@ struct ath11k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	s8 rssi_beacon;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ef4859a5887b..f135a3dd2f4e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7811,6 +7811,9 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
 	struct ath11k *ar = arsta->arvif->ar;
+	s8 signal;
+	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+			       ar->ab->wmi_ab.svc_map);
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -7843,9 +7846,22 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
 	}
 
-	/* TODO: Use real NF instead of default one. */
-	sinfo->signal = arsta->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	signal = arsta->rssi_comb;
+	if (!signal &&
+	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    ar->ab->hw_params.supports_rssi_stats &&
+	    !(ath11k_debugfs_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+					WMI_REQUEST_VDEV_STAT)))
+		signal = arsta->rssi_beacon;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "mac sta statistics db2dbm %u rssi comb %d rssi beacon %d\n",
+		   db2dbm, arsta->rssi_comb, arsta->rssi_beacon);
+
+	if (signal) {
+		sinfo->signal = db2dbm ? signal : signal + ATH11K_DEFAULT_NOISE_FLOOR;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	}
 }
 
 static const struct ieee80211_ops ath11k_ops = {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b7bdc37f24fd..6d92bb9483be 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5639,7 +5639,11 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 {
 	struct ath11k_fw_stats *stats = parse->stats;
 	const struct wmi_stats_event *ev = parse->ev;
-	int i;
+	struct ath11k *ar;
+	struct ath11k_vif *arvif;
+	struct ieee80211_sta *sta;
+	struct ath11k_sta *arsta;
+	int i, ret = 0;
 	const void *data = ptr;
 
 	if (!ev) {
@@ -5649,13 +5653,19 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 
 	stats->stats_id = 0;
 
+	rcu_read_lock();
+
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
+
 	for (i = 0; i < ev->num_pdev_stats; i++) {
 		const struct wmi_pdev_stats *src;
 		struct ath11k_fw_stats_pdev *dst;
 
 		src = data;
-		if (len < sizeof(*src))
-			return -EPROTO;
+		if (len < sizeof(*src)) {
+			ret = -EPROTO;
+			goto exit;
+		}
 
 		stats->stats_id = WMI_REQUEST_PDEV_STAT;
 
@@ -5677,11 +5687,30 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 		struct ath11k_fw_stats_vdev *dst;
 
 		src = data;
-		if (len < sizeof(*src))
-			return -EPROTO;
+		if (len < sizeof(*src)) {
+			ret = -EPROTO;
+			goto exit;
+		}
 
 		stats->stats_id = WMI_REQUEST_VDEV_STAT;
 
+		arvif = ath11k_mac_get_arvif(ar, src->vdev_id);
+		if (arvif) {
+			sta = ieee80211_find_sta_by_ifaddr(ar->hw,
+							   arvif->bssid,
+							   NULL);
+			if (sta) {
+				arsta = (struct ath11k_sta *)sta->drv_priv;
+				arsta->rssi_beacon = src->beacon_snr;
+				ath11k_dbg(ab, ATH11K_DBG_WMI,
+					   "wmi stats vdev id %d snr %d\n",
+					   src->vdev_id, src->beacon_snr);
+			} else {
+				ath11k_warn(ab, "not found station for bssid %pM\n",
+					    arvif->bssid);
+			}
+		}
+
 		data += sizeof(*src);
 		len -= sizeof(*src);
 
@@ -5698,8 +5727,10 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 		struct ath11k_fw_stats_bcn *dst;
 
 		src = data;
-		if (len < sizeof(*src))
-			return -EPROTO;
+		if (len < sizeof(*src)) {
+			ret = -EPROTO;
+			goto exit;
+		}
 
 		stats->stats_id = WMI_REQUEST_BCN_STAT;
 
@@ -5714,7 +5745,9 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 		list_add_tail(&dst->list, &stats->bcn);
 	}
 
-	return 0;
+exit:
+	rcu_read_unlock();
+	return ret;
 }
 
 static int ath11k_wmi_tlv_fw_stats_parse(struct ath11k_base *ab,

base-commit: f21e9b6adc354bfa274d4510df602f081a08194e
prerequisite-patch-id: ea323ac33f40186a1950044c1997e9c4509c5725
-- 
2.31.1

