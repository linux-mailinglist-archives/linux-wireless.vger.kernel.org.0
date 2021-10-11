Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56942893E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhJKI52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 04:57:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55518 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhJKI51 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 04:57:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633942528; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=e4oEXrXww1yYfubiUGcXVr2fxfbogUaDqDk4Pudbmbo=; b=dTTMslSndAD0R9QUeodIJNbMlq48OH7b7jXalKXoqUIIXg7JQmnHWB7DbHfS2LIIUeZ5kU07
 2SSa/Lzpm28gUGXWxMSROFRsgwza8IY80FSHVTvblZsy2hzfBN6KVfo7YvxlKVsIzObQQF4p
 rvCp/520sBf7/uGeFLq45Ibjqr4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6163fbfe8ea00a941f266a1c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:55:26
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5646CC4338F; Mon, 11 Oct 2021 08:55:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E85A3C43460;
        Mon, 11 Oct 2021 08:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E85A3C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath11k: Add signal report to mac80211 for QCA6390 and WCN6855
Date:   Mon, 11 Oct 2021 04:55:19 -0400
Message-Id: <20211011085519.31194-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE80211_HW_USES_RSS is set in ath11k, then the device uses RSS and
thus requires parallel RX which implies using per-CPU station statistics
in sta_get_last_rx_stats() of mac80211. Currently signal is only set in
ath11k_mgmt_rx_event(), and not set for RX data packet, then it show
signal as 0 for iw command easily.

This patch is to get signal from firmware and report to mac80211.

For QCA6390 and WCN6855, the rssi value is already in dbm unit, so
don't need to convert it again.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 20 +++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.c  | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b9a65f045b9c..0f316dd1e3f9 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -410,6 +410,7 @@ struct ath11k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	s8 rssi_beacon;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 5b0d2547939b..6178485a86ea 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6988,6 +6988,9 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
 	struct ath11k *ar = arsta->arvif->ar;
+	s8 signal;
+	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+			       ar->ab->wmi_ab.svc_map);
 
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
@@ -7018,9 +7021,20 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		ath11k_mac_put_chain_rssi(sinfo, arsta, "fw stats", true);
 	}
 
-	/* TODO: Use real NF instead of default one. */
-	sinfo->signal = arsta->rssi_comb + ATH11K_DEFAULT_NOISE_FLOOR;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	signal = arsta->rssi_comb;
+	if (!signal &&
+	    !(ath11k_debug_get_fw_stats(ar, ar->pdev->pdev_id, 0,
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
index 3d2c7ea05e20..e4e3f6696e48 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6105,6 +6105,7 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 	for (i = 0; i < ev->num_vdev_stats; i++) {
 		const struct wmi_vdev_stats *src;
 		struct ath11k_fw_stats_vdev *dst;
+		struct ath11k_vif *arvif;
 
 		src = data;
 		if (len < sizeof(*src)) {
@@ -6117,6 +6118,23 @@ int ath11k_wmi_pull_fw_stats(struct ath11k_base *ab, struct sk_buff *skb,
 		data += sizeof(*src);
 		len -= sizeof(*src);
 
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
 		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
 		if (!dst)
 			continue;
-- 
2.31.1

