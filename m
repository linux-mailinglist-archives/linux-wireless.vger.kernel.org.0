Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE22146D7
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2020 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgGDPO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jul 2020 11:14:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24517 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgGDPO2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jul 2020 11:14:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593875666; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cAITVvJ43llTp7CniJ0rrQsw+4YRnGAOhaLUzdWhaHA=; b=KadsMaI52qbga6BCaVik5dOdfPY+TzXOEDCXNnxouorjJPc1GoWi1ki18Q2NmAoh/u5Yt/zD
 SEe/S3tSyMAAWpJ+ehOjzR6X6BMBJyR9GuJviCwMJ8NZ9kXtTPvJPtmRkz/zg6LpjlTrn0J4
 VsHBmZEUuSSEmPSLA6CoPoHiEy4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f009ccc117610c7ff0b7948 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 04 Jul 2020 15:14:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 224D7C433CA; Sat,  4 Jul 2020 15:14:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tamizhr-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29D76C433C6;
        Sat,  4 Jul 2020 15:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29D76C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv2 3/4] ath10k: Add new api to support TID specific configuration
Date:   Sat,  4 Jul 2020 20:43:33 +0530
Message-Id: <1593875614-5683-4-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593875614-5683-1-git-send-email-tamizhr@codeaurora.org>
References: <1593875614-5683-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch add ops for set_tid_config to support TID
specific configuration. Station specific TID configuration
will have more priority than vif specific TID configuration.
WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT service flag introduced
to notify host for TID config support. And RTS_CTS extended tid
configuration support advertised through the service flag
WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT.

TID specific noack configuration requires
aggregation should be disabled and rate for the data TID packets
should be basic rates. So, if the TID already configured
with noack policy then driver will ignore the aggregation
or TX rate related configuration for the same data TID.

In TX rate configuration should be applied with highest
preamble configuration(HT rates should not be applied
for the station which supports vht rates).

Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00021

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c |   4 +
 drivers/net/wireless/ath/ath10k/core.h |  19 ++
 drivers/net/wireless/ath/ath10k/mac.c  | 575 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/txrx.c |  11 +-
 drivers/net/wireless/ath/ath10k/wmi.c  |   9 +-
 drivers/net/wireless/ath/ath10k/wmi.h  |  20 ++
 6 files changed, 629 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 22b6937..18b7587 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2797,6 +2797,10 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		if (test_bit(WMI_SERVICE_REPORT_AIRTIME, ar->wmi.svc_map))
 			val |= WMI_10_4_REPORT_AIRTIME;
 
+		if (test_bit(WMI_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
+			     ar->wmi.svc_map))
+			val |= WMI_10_4_EXT_PEER_TID_CONFIGS_SUPPORT;
+
 		status = ath10k_mac_ext_resource_config(ar, val);
 		if (status) {
 			ath10k_err(ar,
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5c18f6c..939cf01 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -82,6 +82,8 @@
 /* Default Airtime weight multipler (Tuned for multiclient performance) */
 #define ATH10K_AIRTIME_WEIGHT_MULTIPLIER  4
 
+#define ATH10K_MAX_RETRY_COUNT 30
+
 struct ath10k;
 
 static inline const char *ath10k_bus_str(enum ath10k_bus bus)
@@ -109,6 +111,7 @@ enum ath10k_skb_flags {
 	ATH10K_SKB_F_MGMT = BIT(3),
 	ATH10K_SKB_F_QOS = BIT(4),
 	ATH10K_SKB_F_RAW_TX = BIT(5),
+	ATH10K_SKB_F_NOACK_TID = BIT(6),
 };
 
 struct ath10k_skb_cb {
@@ -509,6 +512,8 @@ struct ath10k_htt_tx_stats {
 	u64 ack_fails;
 };
 
+#define ATH10K_TID_MAX	8
+
 struct ath10k_sta {
 	struct ath10k_vif *arvif;
 
@@ -542,6 +547,13 @@ struct ath10k_sta {
 #endif
 	/* Protected with ar->data_lock */
 	u32 peer_ps_state;
+	struct work_struct tid_config_wk;
+	int noack[ATH10K_TID_MAX];
+	int retry_long[ATH10K_TID_MAX];
+	int ampdu[ATH10K_TID_MAX];
+	u8 rate_ctrl[ATH10K_TID_MAX];
+	u32 rate_code[ATH10K_TID_MAX];
+	int rtscts[ATH10K_TID_MAX];
 };
 
 #define ATH10K_VDEV_SETUP_TIMEOUT_HZ	(5 * HZ)
@@ -614,6 +626,13 @@ struct ath10k_vif {
 	/* For setting VHT peer fixed rate, protected by conf_mutex */
 	int vht_num_rates;
 	u8 vht_pfr;
+	u32 tid_conf_changed[ATH10K_TID_MAX];
+	int noack[ATH10K_TID_MAX];
+	int retry_long[ATH10K_TID_MAX];
+	int ampdu[ATH10K_TID_MAX];
+	u8 rate_ctrl[ATH10K_TID_MAX];
+	u32 rate_code[ATH10K_TID_MAX];
+	int rtscts[ATH10K_TID_MAX];
 };
 
 struct ath10k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7023ccf..991f274 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3018,6 +3018,66 @@ static void ath10k_bss_disassoc(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
 }
 
+static int ath10k_new_peer_tid_config(struct ath10k *ar,
+				      struct ieee80211_sta *sta,
+				      struct ath10k_vif *arvif)
+{
+	struct wmi_per_peer_per_tid_cfg_arg arg = {};
+	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
+	bool config_apply;
+	int ret, i;
+
+	for (i = 0; i < ATH10K_TID_MAX; i++) {
+		config_apply = false;
+		if (arvif->retry_long[i] || arvif->ampdu[i] ||
+		    arvif->rate_ctrl[i] || arvif->rate_ctrl[i] ||
+		    arvif->rtscts[i]) {
+			config_apply = true;
+			arg.tid = i;
+			arg.vdev_id = arvif->vdev_id;
+			arg.retry_count = arvif->retry_long[i];
+			arg.aggr_control = arvif->ampdu[i];
+			arg.rate_ctrl = arvif->rate_ctrl[i];
+			arg.rcode_flags = arvif->rate_code[i];
+			if (arvif->rtscts[i])
+				arg.ext_tid_cfg_bitmap =
+					WMI_EXT_TID_RTS_CTS_CONFIG;
+			else
+				arg.ext_tid_cfg_bitmap = 0;
+			arg.rtscts_ctrl = arvif->rtscts[i];
+		}
+
+		if (arvif->noack[i]) {
+			arg.ack_policy	= arvif->noack[i];
+			arg.rate_ctrl =
+				WMI_TID_CONFIG_RATE_CONTROL_DEFAULT_LOWEST_RATE;
+			arg.aggr_control = WMI_TID_CONFIG_AGGR_CONTROL_DISABLE;
+			config_apply = true;
+		}
+
+		/* Assign default value(-1) to newly connected station.
+		 * This is to identify station specific tid configuration not
+		 * configured for the station.
+		 */
+		arsta->retry_long[i] = -1;
+		arsta->noack[i] = -1;
+		arsta->ampdu[i] = -1;
+
+		if (!config_apply)
+			continue;
+
+		ether_addr_copy(arg.peer_macaddr.addr, sta->addr);
+		ret = ath10k_wmi_set_per_peer_per_tid_cfg(ar, &arg);
+		if (ret) {
+			ath10k_warn(ar, "failed to set per tid retry/aggr config for sta %pM: %d\n",
+				    sta->addr, ret);
+			return ret;
+		}
+		memset(&arg, 0, sizeof(arg));
+	}
+	return 0;
+}
+
 static int ath10k_station_assoc(struct ath10k *ar,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta,
@@ -3083,7 +3143,10 @@ static int ath10k_station_assoc(struct ath10k *ar,
 		}
 	}
 
-	return ret;
+	if (!test_bit(WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, ar->wmi.svc_map))
+		return ret;
+
+	return ath10k_new_peer_tid_config(ar, sta, arvif);
 }
 
 static int ath10k_station_disassoc(struct ath10k *ar,
@@ -3631,7 +3694,10 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 	const struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool is_data = ieee80211_is_data(hdr->frame_control) ||
 			ieee80211_is_data_qos(hdr->frame_control);
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
 	struct ath10k_sta *arsta;
+	u8 tid, *qos_ctl;
+	bool noack = false;
 
 	cb->flags = 0;
 	if (!ath10k_tx_h_use_hwcrypto(vif, skb))
@@ -3640,8 +3706,26 @@ static void ath10k_mac_tx_h_fill_cb(struct ath10k *ar,
 	if (ieee80211_is_mgmt(hdr->frame_control))
 		cb->flags |= ATH10K_SKB_F_MGMT;
 
-	if (ieee80211_is_data_qos(hdr->frame_control))
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		cb->flags |= ATH10K_SKB_F_QOS;
+		qos_ctl = ieee80211_get_qos_ctl(hdr);
+		tid = (*qos_ctl) & IEEE80211_QOS_CTL_TID_MASK;
+
+		if (arvif->noack[tid] == WMI_PEER_TID_CONFIG_NOACK)
+			noack = true;
+
+		if (sta) {
+			arsta = (struct ath10k_sta *)sta->drv_priv;
+			if (arsta->noack[tid] == WMI_PEER_TID_CONFIG_NOACK)
+				noack = true;
+
+			if (arsta->noack[tid] == WMI_PEER_TID_CONFIG_ACK)
+				noack = false;
+		}
+
+		if (noack)
+			cb->flags |= ATH10K_SKB_F_NOACK_TID;
+	}
 
 	/* Data frames encrypted in software will be posted to firmware
 	 * with tx encap mode set to RAW. Ex: Multicast traffic generated
@@ -6602,6 +6686,11 @@ static int ath10k_sta_set_txpwr(struct ieee80211_hw *hw,
 	return ret;
 }
 
+struct ath10k_mac_iter_tid_conf_data {
+	struct ieee80211_vif *curr_vif;
+	struct ath10k *ar;
+};
+
 static bool
 ath10k_mac_bitrate_mask_has_single_rate(struct ath10k *ar,
 					enum nl80211_band band,
@@ -6689,6 +6778,421 @@ static int ath10k_sta_set_txpwr(struct ieee80211_hw *hw,
 	return -EINVAL;
 }
 
+static int ath10k_mac_validate_rate_mask(struct ath10k *ar,
+					 struct ieee80211_sta *sta,
+					 u32 rate_ctrl_flag, u8 nss)
+{
+	if (nss > sta->rx_nss) {
+		ath10k_warn(ar, "Invalid nss field, configured %u limit %u\n",
+			    nss, sta->rx_nss);
+		return -EINVAL;
+	}
+
+	if (ATH10K_HW_PREAMBLE(rate_ctrl_flag) == WMI_RATE_PREAMBLE_VHT) {
+		if (!sta->vht_cap.vht_supported) {
+			ath10k_warn(ar, "Invalid VHT rate for sta %pM\n",
+				    sta->addr);
+			return -EINVAL;
+		}
+	} else if (ATH10K_HW_PREAMBLE(rate_ctrl_flag) == WMI_RATE_PREAMBLE_HT) {
+		if (!sta->ht_cap.ht_supported || sta->vht_cap.vht_supported) {
+			ath10k_warn(ar, "Invalid HT rate for sta %pM\n",
+				    sta->addr);
+			return -EINVAL;
+		}
+	} else {
+		if (sta->ht_cap.ht_supported || sta->vht_cap.vht_supported) {
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int
+ath10k_mac_tid_bitrate_config(struct ath10k *ar,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      u32 *rate_ctrl_flag, u8 *rate_ctrl,
+			      enum nl80211_tx_rate_setting txrate_type,
+			      const struct cfg80211_bitrate_mask *mask)
+{
+	struct cfg80211_chan_def def;
+	enum nl80211_band band;
+	u8 nss, rate;
+	int vht_num_rates, ret;
+
+	if (WARN_ON(ath10k_mac_vif_chan(vif, &def)))
+		return -EINVAL;
+
+	if (txrate_type == NL80211_TX_RATE_AUTOMATIC) {
+		*rate_ctrl = WMI_TID_CONFIG_RATE_CONTROL_AUTO;
+		*rate_ctrl_flag = 0;
+		return 0;
+	}
+
+	band = def.chan->band;
+
+	if (!ath10k_mac_bitrate_mask_has_single_rate(ar, band, mask,
+						     &vht_num_rates)) {
+		return -EINVAL;
+	}
+
+	ret = ath10k_mac_bitrate_mask_get_single_rate(ar, band, mask,
+						      &rate, &nss, false);
+	if (ret) {
+		ath10k_warn(ar, "failed to get single rate: %d\n",
+			    ret);
+		return ret;
+	}
+	*rate_ctrl_flag = rate;
+
+	if (sta && ath10k_mac_validate_rate_mask(ar, sta, *rate_ctrl_flag, nss))
+		return -EINVAL;
+
+	if (txrate_type == NL80211_TX_RATE_FIXED)
+		*rate_ctrl = WMI_TID_CONFIG_RATE_CONTROL_FIXED_RATE;
+	else if (txrate_type == NL80211_TX_RATE_LIMITED &&
+		 (test_bit(WMI_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
+			   ar->wmi.svc_map)))
+		*rate_ctrl = WMI_PEER_TID_CONFIG_RATE_UPPER_CAP;
+	else
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static int ath10k_mac_set_tid_config(struct ath10k *ar, struct ieee80211_sta *sta,
+				     struct ieee80211_vif *vif, u32 changed,
+				     struct wmi_per_peer_per_tid_cfg_arg *arg)
+{
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k_sta *arsta;
+	int ret;
+
+	if (sta) {
+		if (!sta->wme)
+			return -ENOTSUPP;
+
+		arsta = (struct ath10k_sta *)sta->drv_priv;
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_NOACK)) {
+			if ((arsta->retry_long[arg->tid] > 0 ||
+			     arsta->rate_code[arg->tid] > 0 ||
+			     arsta->ampdu[arg->tid] ==
+					WMI_TID_CONFIG_AGGR_CONTROL_ENABLE) &&
+			     arg->ack_policy == WMI_PEER_TID_CONFIG_NOACK) {
+				changed &= ~BIT(NL80211_TID_CONFIG_ATTR_NOACK);
+				arg->ack_policy = 0;
+				arg->aggr_control = 0;
+				arg->rate_ctrl = 0;
+				arg->rcode_flags = 0;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL)) {
+			if (arsta->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK ||
+			    arvif->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg->aggr_control = 0;
+				changed &= ~BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG);
+			}
+		}
+
+		if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+		    BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
+			if (arsta->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK ||
+			    arvif->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg->rate_ctrl = 0;
+				arg->rcode_flags = 0;
+			}
+		}
+
+		ether_addr_copy(arg->peer_macaddr.addr, sta->addr);
+		ret = ath10k_wmi_set_per_peer_per_tid_cfg(ar, arg);
+		if (ret)
+			return ret;
+
+		/* Store the configured parameters in success case */
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_NOACK)) {
+			arsta->noack[arg->tid] = arg->ack_policy;
+			arg->ack_policy = 0;
+			arg->aggr_control = 0;
+			arg->rate_ctrl = 0;
+			arg->rcode_flags = 0;
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG)) {
+			arsta->retry_long[arg->tid] = arg->retry_count;
+			arg->retry_count = 0;
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL)) {
+			arsta->ampdu[arg->tid] = arg->aggr_control;
+			arg->aggr_control = 0;
+		}
+
+		if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+		    BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
+			arsta->rate_ctrl[arg->tid] = arg->rate_ctrl;
+			arg->rate_ctrl = 0;
+			arg->rcode_flags = 0;
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL)) {
+			arsta->rtscts[arg->tid] = arg->rtscts_ctrl;
+			arg->ext_tid_cfg_bitmap = 0;
+		}
+	} else {
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_NOACK)) {
+			if ((arvif->retry_long[arg->tid] ||
+			     arvif->rate_code[arg->tid] ||
+			     arvif->ampdu[arg->tid] ==
+					WMI_TID_CONFIG_AGGR_CONTROL_ENABLE) &&
+			     arg->ack_policy == WMI_PEER_TID_CONFIG_NOACK) {
+				changed &= ~BIT(NL80211_TID_CONFIG_ATTR_NOACK);
+			} else {
+				arvif->noack[arg->tid] = arg->ack_policy;
+				arvif->ampdu[arg->tid] = arg->aggr_control;
+				arvif->rate_ctrl[arg->tid] = arg->rate_ctrl;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG)) {
+			if (arvif->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK)
+				changed &= ~BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG);
+			else
+				arvif->retry_long[arg->tid] = arg->retry_count;
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL)) {
+			if (arvif->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK)
+				changed &= ~BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL);
+			else
+				arvif->ampdu[arg->tid] = arg->aggr_control;
+		}
+
+		if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+		    BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
+			if (arvif->noack[arg->tid] == WMI_PEER_TID_CONFIG_NOACK) {
+				changed &= ~(BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+					     BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE));
+			} else {
+				arvif->rate_ctrl[arg->tid] = arg->rate_ctrl;
+				arvif->rate_code[arg->tid] = arg->rcode_flags;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL)) {
+			arvif->rtscts[arg->tid] = arg->rtscts_ctrl;
+			arg->ext_tid_cfg_bitmap = 0;
+		}
+
+		if (changed)
+			arvif->tid_conf_changed[arg->tid] |= changed;
+	}
+
+	return 0;
+}
+
+static int
+ath10k_mac_parse_tid_config(struct ath10k *ar,
+			    struct ieee80211_sta *sta,
+			    struct ieee80211_vif *vif,
+			    struct cfg80211_tid_cfg *tid_conf,
+			    struct wmi_per_peer_per_tid_cfg_arg *arg)
+{
+	u32 changed = tid_conf->mask;
+	int ret = 0, i = 0;
+
+	if (!changed)
+		return -EINVAL;
+
+	while (i < ATH10K_TID_MAX) {
+		if (!(tid_conf->tids & BIT(i))) {
+			i++;
+			continue;
+		}
+
+		arg->tid = i;
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_NOACK)) {
+			if (tid_conf->noack == NL80211_TID_CONFIG_ENABLE) {
+				arg->ack_policy = WMI_PEER_TID_CONFIG_NOACK;
+				arg->rate_ctrl =
+				WMI_TID_CONFIG_RATE_CONTROL_DEFAULT_LOWEST_RATE;
+				arg->aggr_control =
+					WMI_TID_CONFIG_AGGR_CONTROL_DISABLE;
+			} else {
+				arg->ack_policy =
+					WMI_PEER_TID_CONFIG_ACK;
+				arg->rate_ctrl =
+					WMI_TID_CONFIG_RATE_CONTROL_AUTO;
+				arg->aggr_control =
+					WMI_TID_CONFIG_AGGR_CONTROL_ENABLE;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG))
+			arg->retry_count = tid_conf->retry_long;
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL)) {
+			if (tid_conf->noack == NL80211_TID_CONFIG_ENABLE)
+				arg->aggr_control = WMI_TID_CONFIG_AGGR_CONTROL_ENABLE;
+			else
+				arg->aggr_control = WMI_TID_CONFIG_AGGR_CONTROL_DISABLE;
+		}
+
+		if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+		    BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
+			ret = ath10k_mac_tid_bitrate_config(ar, vif, sta,
+							    &arg->rcode_flags,
+							    &arg->rate_ctrl,
+							    tid_conf->txrate_type,
+							&tid_conf->txrate_mask);
+			if (ret) {
+				ath10k_warn(ar, "failed to configure bitrate mask %d\n",
+					    ret);
+				arg->rcode_flags = 0;
+				arg->rate_ctrl = 0;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL)) {
+			if (tid_conf->rtscts)
+				arg->rtscts_ctrl = tid_conf->rtscts;
+
+			arg->ext_tid_cfg_bitmap = WMI_EXT_TID_RTS_CTS_CONFIG;
+		}
+
+		ret = ath10k_mac_set_tid_config(ar, sta, vif, changed, arg);
+		if (ret)
+			return ret;
+		i++;
+	}
+	return ret;
+}
+
+static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
+{
+	struct wmi_per_peer_per_tid_cfg_arg arg = {};
+	struct ieee80211_sta *sta;
+	struct ath10k_sta *arsta;
+	struct ath10k_vif *arvif;
+	struct ath10k *ar;
+	bool config_apply;
+	int ret, i;
+	u32 changed;
+
+	arsta = container_of(wk, struct ath10k_sta, tid_config_wk);
+	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
+	arvif = arsta->arvif;
+	ar = arvif->ar;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ether_addr_copy(arg.peer_macaddr.addr, sta->addr);
+	for (i = 0; i < ATH10K_TID_MAX; i++) {
+		config_apply = false;
+		changed = arvif->tid_conf_changed[i];
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_NOACK)) {
+			if (arsta->noack[i] != -1) {
+				arg.ack_policy  = 0;
+			} else {
+				config_apply = true;
+				arg.ack_policy = arvif->noack[i];
+				arg.aggr_control = arvif->ampdu[i];
+				arg.rate_ctrl = arvif->rate_ctrl[i];
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG)) {
+			if (arsta->retry_long[i] != -1 ||
+			    arsta->noack[i] == WMI_PEER_TID_CONFIG_NOACK ||
+			    arvif->noack[i] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg.retry_count = 0;
+			} else {
+				arg.retry_count = arvif->retry_long[i];
+				config_apply = true;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL)) {
+			if (arsta->ampdu[i] != -1 ||
+			    arsta->noack[i] == WMI_PEER_TID_CONFIG_NOACK ||
+			    arvif->noack[i] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg.aggr_control = 0;
+			} else {
+				arg.aggr_control = arvif->ampdu[i];
+				config_apply = true;
+			}
+		}
+
+		if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+		    BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
+			if (arvif->rate_ctrl[i] > WMI_TID_CONFIG_RATE_CONTROL_AUTO &&
+			    ath10k_mac_validate_rate_mask(ar, sta, arvif->rate_code[i],
+						ATH10K_HW_NSS(arvif->rate_code[i]))) {
+				arg.rate_ctrl = 0;
+				arg.rcode_flags = 0;
+			}
+
+			if (arsta->rate_ctrl[i] >
+			    WMI_TID_CONFIG_RATE_CONTROL_AUTO ||
+			    arsta->noack[i] == WMI_PEER_TID_CONFIG_NOACK ||
+			    arvif->noack[i] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg.rate_ctrl = 0;
+				arg.rcode_flags = 0;
+			} else {
+				arg.rate_ctrl = arvif->rate_ctrl[i];
+				arg.rcode_flags = arvif->rate_code[i];
+				config_apply = true;
+			}
+		}
+
+		if (changed & BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL)) {
+			if (arsta->rtscts[i]) {
+				arg.rtscts_ctrl = 0;
+				arg.ext_tid_cfg_bitmap = 0;
+			} else {
+				arg.rtscts_ctrl = arvif->rtscts[i] - 1;
+				arg.ext_tid_cfg_bitmap =
+					WMI_EXT_TID_RTS_CTS_CONFIG;
+				config_apply = true;
+			}
+		}
+
+		arg.tid = i;
+
+		if (config_apply) {
+			ret = ath10k_wmi_set_per_peer_per_tid_cfg(ar, &arg);
+			if (ret)
+				ath10k_warn(ar, "failed to set per tid config for sta %pM: %d\n",
+					    sta->addr, ret);
+		}
+
+		arg.ack_policy  = 0;
+		arg.retry_count  = 0;
+		arg.aggr_control  = 0;
+		arg.rate_ctrl = 0;
+		arg.rcode_flags = 0;
+	}
+
+	mutex_unlock(&ar->conf_mutex);
+}
+
+static void ath10k_mac_vif_stations_tid_conf(void *data,
+					     struct ieee80211_sta *sta)
+{
+	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
+	struct ath10k_mac_iter_tid_conf_data *iter_data = data;
+	struct ieee80211_vif *sta_vif = arsta->arvif->vif;
+
+	if (sta_vif != iter_data->curr_vif || !sta->wme)
+		return;
+
+	ieee80211_queue_work(iter_data->ar->hw, &arsta->tid_config_wk);
+}
+
 static int ath10k_sta_state(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
@@ -6708,6 +7212,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		arsta->arvif = arvif;
 		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
 		INIT_WORK(&arsta->update_wk, ath10k_sta_rc_update_wk);
+		INIT_WORK(&arsta->tid_config_wk, ath10k_sta_tid_cfg_wk);
 
 		for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 			ath10k_mac_txq_init(sta->txq[i]);
@@ -6715,8 +7220,10 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
-	     new_state == IEEE80211_STA_NOTEXIST))
+	     new_state == IEEE80211_STA_NOTEXIST)) {
 		cancel_work_sync(&arsta->update_wk);
+		cancel_work_sync(&arsta->tid_config_wk);
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -8557,6 +9064,45 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	ath10k_mac_sta_get_peer_stats_info(ar, sta, sinfo);
 }
 
+static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct cfg80211_tid_config *tid_config)
+{
+	struct ath10k *ar = hw->priv;
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k_mac_iter_tid_conf_data data = {};
+	struct wmi_per_peer_per_tid_cfg_arg arg = {};
+	int ret, i;
+
+	mutex_lock(&ar->conf_mutex);
+	arg.vdev_id = arvif->vdev_id;
+
+	memset(arvif->tid_conf_changed, 0, sizeof(arvif->tid_conf_changed));
+
+	for (i = 0; i < tid_config->n_tid_conf; i++) {
+		ret = ath10k_mac_parse_tid_config(ar, sta, vif,
+						  &tid_config->tid_conf[i],
+						  &arg);
+		if (ret)
+			goto exit;
+	}
+
+	if (sta)
+		goto exit;
+
+	ret = 0;
+	data.curr_vif = vif;
+	data.ar = ar;
+
+	ieee80211_iterate_stations_atomic(hw, ath10k_mac_vif_stations_tid_conf,
+					  &data);
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static const struct ieee80211_ops ath10k_ops = {
 	.tx				= ath10k_mac_op_tx,
 	.wake_tx_queue			= ath10k_mac_op_wake_tx_queue,
@@ -8600,6 +9146,7 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	.switch_vif_chanctx		= ath10k_mac_op_switch_vif_chanctx,
 	.sta_pre_rcu_remove		= ath10k_mac_op_sta_pre_rcu_remove,
 	.sta_statistics			= ath10k_sta_statistics,
+	.set_tid_config			= ath10k_mac_op_set_tid_config,
 
 	CFG80211_TESTMODE_CMD(ath10k_tm_cmd)
 
@@ -9270,6 +9817,28 @@ int ath10k_mac_register(struct ath10k *ar)
 	if (test_bit(WMI_SERVICE_TX_PWR_PER_PEER, ar->wmi.svc_map))
 		wiphy_ext_feature_set(ar->hw->wiphy,
 				      NL80211_EXT_FEATURE_STA_TX_PWR);
+
+	if (test_bit(WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, ar->wmi.svc_map)) {
+		ar->hw->wiphy->tid_config_support.vif |=
+				BIT(NL80211_TID_CONFIG_ATTR_NOACK) |
+				BIT(NL80211_TID_CONFIG_ATTR_RETRY_SHORT) |
+				BIT(NL80211_TID_CONFIG_ATTR_RETRY_LONG) |
+				BIT(NL80211_TID_CONFIG_ATTR_AMPDU_CTRL) |
+				BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
+				BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE);
+
+		if (test_bit(WMI_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
+			     ar->wmi.svc_map)) {
+			ar->hw->wiphy->tid_config_support.vif |=
+				BIT(NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL);
+		}
+
+		ar->hw->wiphy->tid_config_support.peer =
+				ar->hw->wiphy->tid_config_support.vif;
+		ar->hw->wiphy->max_data_retry_count = ATH10K_MAX_RETRY_COUNT;
+	} else {
+		ar->ops->set_tid_config = NULL;
+	}
 	/*
 	 * on LL hardware queues are managed entirely by the FW
 	 * so we only advertise to mac we can do the queues thing
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index f46b908..aefe1f7 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -50,6 +50,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	struct ath10k_skb_cb *skb_cb;
 	struct ath10k_txq *artxq;
 	struct sk_buff *msdu;
+	u8 flags;
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT,
 		   "htt tx completion msdu_id %u status %d\n",
@@ -78,6 +79,7 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 		artxq->num_fw_queued--;
 	}
 
+	flags = skb_cb->flags;
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
 	ath10k_htt_tx_dec_pending(htt);
 	if (htt->num_pending_tx == 0)
@@ -101,18 +103,21 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	trace_ath10k_txrx_tx_unref(ar, tx_done->msdu_id);
 
-	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
+	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK) &&
+	    !(flags & ATH10K_SKB_F_NOACK_TID))
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
 	if (tx_done->status == HTT_TX_COMPL_STATE_NOACK)
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
 
 	if ((tx_done->status == HTT_TX_COMPL_STATE_ACK) &&
-	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
+	    ((info->flags & IEEE80211_TX_CTL_NO_ACK) ||
+	    (flags & ATH10K_SKB_F_NOACK_TID)))
 		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 
 	if (tx_done->status == HTT_TX_COMPL_STATE_DISCARD) {
-		if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		if ((info->flags & IEEE80211_TX_CTL_NO_ACK) ||
+		    (flags & ATH10K_SKB_F_NOACK_TID))
 			info->flags &= ~IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 		else
 			info->flags &= ~IEEE80211_TX_STAT_ACK;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 4316551..a489cfb 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -9027,11 +9027,14 @@ static u32 ath10k_wmi_prepare_peer_qos(u8 uapsd_queues, u8 sp)
 	cmd->rate_control = cpu_to_le32(arg->rate_ctrl);
 	cmd->retry_count = cpu_to_le32(arg->retry_count);
 	cmd->rcode_flags = cpu_to_le32(arg->rcode_flags);
+	cmd->ext_tid_cfg_bitmap = cpu_to_le32(arg->ext_tid_cfg_bitmap);
+	cmd->rtscts_ctrl = cpu_to_le32(arg->rtscts_ctrl);
 
 	ath10k_dbg(ar, ATH10K_DBG_WMI,
-		   "wmi noack tid %d vdev id %d ack_policy %d aggr %u rate_ctrl %u rcflag %u retry_count %d mac_addr %pM\n",
-		   arg->tid, arg->vdev_id, arg->ack_policy, arg->aggr_control, arg->rate_ctrl,
-		   arg->rcode_flags, arg->retry_count, arg->peer_macaddr.addr);
+		   "wmi noack tid %d vdev id %d ack_policy %d aggr %u rate_ctrl %u rcflag %u retry_count %d rtscts %d ext_tid_cfg_bitmap %d mac_addr %pM\n",
+		   arg->tid, arg->vdev_id, arg->ack_policy, arg->aggr_control,
+		   arg->rate_ctrl, arg->rcode_flags, arg->retry_count, arg->rtscts_ctrl,
+		   arg->ext_tid_cfg_bitmap, arg->peer_macaddr.addr);
 	return skb;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 7fed735..ed5ff67 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -204,6 +204,7 @@ enum wmi_service {
 	WMI_SERVICE_TX_PWR_PER_PEER,
 	WMI_SERVICE_SUPPORT_EXTEND_ADDRESS,
 	WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT,
+	WMI_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
 
 	/* Remember to add the new value to wmi_service_name()! */
 
@@ -505,6 +506,7 @@ static inline char *wmi_service_name(enum wmi_service service_id)
 	SVCSTR(WMI_SERVICE_TX_PWR_PER_PEER);
 	SVCSTR(WMI_SERVICE_SUPPORT_EXTEND_ADDRESS);
 	SVCSTR(WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT);
+	SVCSTR(WMI_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT);
 
 	case WMI_SERVICE_MAX:
 		return NULL;
@@ -838,6 +840,8 @@ static inline void wmi_10_4_svc_map(const __le32 *in, unsigned long *out,
 	       WMI_SERVICE_RESET_CHIP, len);
 	SVCMAP(WMI_10_4_SERVICE_PEER_TID_CONFIGS_SUPPORT,
 	       WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, len);
+	SVCMAP(WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
+	       WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, len);
 }
 
 #undef SVCMAP
@@ -7244,6 +7248,16 @@ enum wmi_tid_rate_ctrl_conf {
 	WMI_TID_CONFIG_RATE_CONTROL_AUTO,
 	WMI_TID_CONFIG_RATE_CONTROL_FIXED_RATE,
 	WMI_TID_CONFIG_RATE_CONTROL_DEFAULT_LOWEST_RATE,
+	WMI_PEER_TID_CONFIG_RATE_UPPER_CAP,
+};
+
+enum wmi_tid_rtscts_control_conf {
+	WMI_TID_CONFIG_RTSCTS_CONTROL_ENABLE,
+	WMI_TID_CONFIG_RTSCTS_CONTROL_DISABLE,
+};
+
+enum wmi_ext_tid_config_map {
+	WMI_EXT_TID_RTS_CTS_CONFIG = BIT(0),
 };
 
 struct wmi_per_peer_per_tid_cfg_arg {
@@ -7255,6 +7269,8 @@ struct wmi_per_peer_per_tid_cfg_arg {
 	u8 rate_ctrl;
 	u32 retry_count;
 	u32 rcode_flags;
+	u32 ext_tid_cfg_bitmap;
+	u32 rtscts_ctrl;
 };
 
 struct wmi_peer_per_tid_cfg_cmd {
@@ -7270,6 +7286,10 @@ struct wmi_peer_per_tid_cfg_cmd {
 	__le32 rate_control;
 	__le32 rcode_flags;
 	__le32 retry_count;
+	/* See enum wmi_ext_tid_config_map */
+	__le32 ext_tid_cfg_bitmap;
+	/* see enum wmi_tid_rtscts_control_conf */
+	__le32 rtscts_ctrl;
 } __packed;
 
 enum wmi_txbf_conf {
-- 
1.9.1

