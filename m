Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDF49933
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfFRGrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 02:47:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfFRGrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3EA860FEA; Tue, 18 Jun 2019 05:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835673;
        bh=Ss7LLc7blP5PFXSleGejCjR+qYJkcJwoOqOtKIJLM4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUqOE39nYLJ41zza8NNPxE5OCgq31yJ6YdTUAfYlAqGh4rXTCkXhxUE01fSTfytoE
         WdkCsF3v3tJ7hxhrb17tgRFixrERG52FJsVVi4nob3v9tRE+2+5rOzSk/3aqXtHOz1
         gY1VsGYUYBlACkoMlxUbV8jO58oSHYyoYWI5Z2RM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 900D460DB3;
        Tue, 18 Jun 2019 05:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560835672;
        bh=Ss7LLc7blP5PFXSleGejCjR+qYJkcJwoOqOtKIJLM4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dw/8PQ7DR1tlJDVw/r7T8O06v/Eh6zJ84dqF7AdEv0Q3A3UBXxUcag75j+CvBy60g
         GfZCJA/dwZCu8yq1fkqvWkG8hN0DBwD16yva0OhVYG6bbxp5vfpAlVsw+0LxriIogH
         UJxs9luDV+T9NpwyoyRsuwXx3Cs/Z+RxSTZIQf2M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 900D460DB3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv6 8/9] ath10k: Add new api to support TID specific configuration
Date:   Tue, 18 Jun 2019 10:57:11 +0530
Message-Id: <1560835632-17405-9-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch add ops for set_tid_config to support TID
specific configuration. STA information along with the
TID config change mask to notify driver that which configuration
needs to be applied for this current command.
If the STA info not available in the command then the
configuration will be applied for all connected stations
in the vif. TID specific noack configuration requires
aggregation disabled and rate for the data TID packets
should be basic rates. So, if the TID already configured
with noack policy then driver will ignore the aggregation
or TX rate related configuration for the same data TID.
In TX rate configuration should be applied with highest
preamble configuration(HT rates should not be applied
for the station which supports vht rates).

Vif specific TID configuration will be applied for all
the connected stations except for the station which
already applied with the same configuration for the TID
through station specific command. Newly connecting stations
will be applied with vif TID configuration which will be stored
in ieee80211_vif.

Testing:
        * Tested HW: QCA9888
        * Tested FW: 10.4-3.5.1-00052

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h |    6 +
 drivers/net/wireless/ath/ath10k/mac.c  |  633 ++++++++++++++++++++++++++++----
 2 files changed, 559 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index e35aae5..3d1b06a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -82,6 +82,8 @@
 /* Default Airtime weight multipler (Tuned for multiclient performance) */
 #define ATH10K_AIRTIME_WEIGHT_MULTIPLIER  4
 
+#define ATH10K_MAX_RETRY_COUNT 29
+
 struct ath10k;
 
 static inline const char *ath10k_bus_str(enum ath10k_bus bus)
@@ -504,6 +506,7 @@ struct ath10k_sta {
 #endif
 	/* Protected with ar->data_lock */
 	u32 peer_ps_state;
+	struct work_struct tid_config_wk;
 };
 
 #define ATH10K_VDEV_SETUP_TIMEOUT_HZ (5 * HZ)
@@ -571,6 +574,9 @@ struct ath10k_vif {
 	struct work_struct ap_csa_work;
 	struct delayed_work connection_loss_work;
 	struct cfg80211_bitrate_mask bitrate_mask;
+	u32 tid_conf_changed[IEEE80211_TID_MAX];
+
+	struct ieee80211_tid_config *tid_config;
 };
 
 struct ath10k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 9c703d2..0ce9720 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2930,6 +2930,59 @@ static void ath10k_bss_disassoc(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
 }
 
+static int ath10k_new_peer_tid_config(struct ath10k *ar,
+				      struct ieee80211_sta *sta,
+				      struct ath10k_vif *arvif)
+{
+	struct wmi_per_peer_per_tid_cfg_arg arg = {};
+	struct ieee80211_vif *vif = arvif->vif;
+	bool config_apply;
+	int ret, i;
+
+	for (i = 0; i < IEEE80211_TID_MAX; i++) {
+		config_apply = false;
+		if (vif->retry_long[i] || vif->ampdu[i] ||
+		    vif->rate_code[i]) {
+			config_apply = true;
+			arg.tid = i;
+			arg.vdev_id = arvif->vdev_id;
+			arg.retry_count = vif->retry_long[i];
+			arg.aggr_control = vif->ampdu[i];
+			arg.rate_ctrl = vif->rate_ctrl[i];
+			arg.rcode_flags = vif->rate_code[i];
+		}
+
+		if (vif->noack[i]) {
+			arg.ack_policy	= vif->noack[i];
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
+		sta->retry_long[i] = -1;
+		sta->noack[i] = -1;
+		sta->ampdu[i] = -1;
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
@@ -2995,7 +3048,10 @@ static int ath10k_station_assoc(struct ath10k *ar,
 		}
 	}
 
-	return ret;
+	if (!test_bit(WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, ar->wmi.svc_map))
+		return ret;
+
+	return ath10k_new_peer_tid_config(ar, sta, arvif);
 }
 
 static int ath10k_station_disassoc(struct ath10k *ar,
@@ -6350,6 +6406,340 @@ static void ath10k_mac_dec_num_stations(struct ath10k_vif *arvif,
 	ar->num_stations--;
 }
 
+struct ath10k_mac_iter_tid_conf_data {
+	struct ieee80211_vif *curr_vif;
+	struct ath10k *ar;
+};
+
+static bool
+ath10k_mac_bitrate_mask_has_single_rate(struct ath10k *ar,
+					enum nl80211_band band,
+					const struct cfg80211_bitrate_mask *mask)
+{
+	int num_rates = 0;
+	int i;
+
+	num_rates += hweight32(mask->control[band].legacy);
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
+		num_rates += hweight8(mask->control[band].ht_mcs[i]);
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++)
+		num_rates += hweight16(mask->control[band].vht_mcs[i]);
+
+	return num_rates == 1;
+}
+
+static int
+ath10k_mac_bitrate_mask_get_single_rate(struct ath10k *ar,
+					enum nl80211_band band,
+					const struct cfg80211_bitrate_mask *mask,
+					u8 *rate, u8 *nss)
+{
+	int rate_idx;
+	int i;
+	u16 bitrate;
+	u8 preamble;
+	u8 hw_rate;
+
+	if (hweight32(mask->control[band].legacy) == 1) {
+		rate_idx = ffs(mask->control[band].legacy) - 1;
+
+		if (ar->phy_capability & WHAL_WLAN_11A_CAPABILITY)
+			rate_idx += ATH10K_MAC_FIRST_OFDM_RATE_IDX;
+
+		hw_rate = ath10k_wmi_legacy_rates[rate_idx].hw_value;
+		bitrate = ath10k_wmi_legacy_rates[rate_idx].bitrate;
+
+		if (ath10k_mac_bitrate_is_cck(bitrate))
+			preamble = WMI_RATE_PREAMBLE_CCK;
+		else
+			preamble = WMI_RATE_PREAMBLE_OFDM;
+
+		*nss = 1;
+		*rate = preamble << 6 |
+			(*nss - 1) << 4 |
+			hw_rate << 0;
+
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++) {
+		if (hweight8(mask->control[band].ht_mcs[i]) == 1) {
+			*nss = i + 1;
+			*rate = WMI_RATE_PREAMBLE_HT << 6 |
+				(*nss - 1) << 4 |
+				(ffs(mask->control[band].ht_mcs[i]) - 1);
+
+			return 0;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
+		if (hweight16(mask->control[band].vht_mcs[i]) == 1) {
+			*nss = i + 1;
+			*rate = WMI_RATE_PREAMBLE_VHT << 6 |
+				(*nss - 1) << 4 |
+				(ffs(mask->control[band].vht_mcs[i]) - 1);
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
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
+		if (sta->ht_cap.ht_supported || sta->vht_cap.vht_supported)
+			return -EINVAL;
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
+	int ret;
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
+	if (!ath10k_mac_bitrate_mask_has_single_rate(ar, band, mask))
+		return -EINVAL;
+
+	ret = ath10k_mac_bitrate_mask_get_single_rate(ar, band, mask,
+						      &rate, &nss);
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
+	else
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static void
+ath10k_mac_parse_tid_config(struct ath10k *ar,
+			    struct ieee80211_sta *sta,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_tid_cfg *tid_conf,
+			    struct wmi_per_peer_per_tid_cfg_arg *arg)
+{
+	u8 changed = tid_conf->tid_conf_mask;
+	int ret;
+
+	arg->tid = tid_conf->tid;
+
+	if (changed & IEEE80211_TID_CONF_NOACK) {
+		if (tid_conf->noack == NL80211_TID_CONFIG_ENABLE) {
+			arg->ack_policy = WMI_PEER_TID_CONFIG_NOACK;
+			arg->rate_ctrl =
+				WMI_TID_CONFIG_RATE_CONTROL_DEFAULT_LOWEST_RATE;
+			arg->aggr_control = WMI_TID_CONFIG_AGGR_CONTROL_DISABLE;
+		} else {
+			arg->ack_policy = WMI_PEER_TID_CONFIG_ACK;
+			arg->rate_ctrl = WMI_TID_CONFIG_RATE_CONTROL_AUTO;
+			arg->aggr_control = WMI_TID_CONFIG_AGGR_CONTROL_ENABLE;
+		}
+	}
+
+	if (changed & IEEE80211_TID_CONF_RETRY) {
+		if (tid_conf->retry_long == -1) {
+			if (vif->retry_long[arg->tid])
+				arg->retry_count = vif->retry_long[arg->tid];
+			else
+				arg->retry_count = ATH10K_MAX_RETRY_COUNT + 1;
+		} else {
+			/* firmware expects tx attempt value */
+			arg->retry_count = tid_conf->retry_long + 1;
+		}
+	}
+
+	if (changed & IEEE80211_TID_CONF_AMPDU) {
+		if (tid_conf->ampdu) {
+			arg->aggr_control = tid_conf->ampdu;
+		} else {
+			if (vif->ampdu[arg->tid])
+				arg->aggr_control = vif->ampdu[arg->tid];
+			else
+				arg->aggr_control =
+					WMI_TID_CONFIG_AGGR_CONTROL_DISABLE;
+		}
+	}
+
+	if (changed & IEEE80211_TID_CONF_TX_BITRATE) {
+		ret = ath10k_mac_tid_bitrate_config(ar, vif, sta,
+						    &arg->rcode_flags,
+						    &arg->rate_ctrl,
+						    tid_conf->txrate_type,
+						    tid_conf->mask);
+		if (ret) {
+			ath10k_warn(ar, "failed to configure bitrate mask %d\n",
+				    ret);
+			arg->rcode_flags = 0;
+			arg->rate_ctrl = 0;
+		}
+		kfree(tid_conf->mask);
+	}
+}
+
+static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
+{
+	struct wmi_per_peer_per_tid_cfg_arg arg = {};
+	struct ieee80211_vif *vif;
+	struct ieee80211_sta *sta;
+	struct ath10k_sta *arsta;
+	struct ath10k_vif *arvif;
+	struct ath10k *ar;
+	bool config_apply;
+	int ret, i;
+	u8 changed;
+
+	arsta = container_of(wk, struct ath10k_sta, tid_config_wk);
+	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
+	arvif = arsta->arvif;
+	vif = arvif->vif;
+	ar = arvif->ar;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ether_addr_copy(arg.peer_macaddr.addr, sta->addr);
+	for (i = 0; i < IEEE80211_TID_MAX; i++) {
+		config_apply = false;
+		changed = arvif->tid_conf_changed[i];
+
+		if (changed & IEEE80211_TID_CONF_NOACK) {
+			if (sta->noack[i] != -1) {
+				arg.ack_policy  = 0;
+			} else {
+				config_apply = true;
+				arg.ack_policy = vif->noack[i];
+				arg.aggr_control = vif->ampdu[i];
+				arg.rate_ctrl = vif->rate_ctrl[i];
+			}
+		}
+
+		if (changed & IEEE80211_TID_CONF_RETRY) {
+			if (sta->retry_long[i] != -1 ||
+			    sta->noack[i] == WMI_PEER_TID_CONFIG_NOACK ||
+			    vif->noack[i] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg.retry_count = 0;
+			} else {
+				arg.retry_count = vif->retry_long[i];
+				config_apply = true;
+			}
+		}
+
+		if (changed & IEEE80211_TID_CONF_AMPDU) {
+			if (sta->ampdu[i] != -1 ||
+			    sta->noack[i] == WMI_PEER_TID_CONFIG_NOACK ||
+			    vif->noack[i] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg.aggr_control = 0;
+			} else {
+				arg.aggr_control = vif->ampdu[i];
+				config_apply = true;
+			}
+		}
+
+		if (changed & IEEE80211_TID_CONF_TX_BITRATE) {
+			if (ath10k_mac_validate_rate_mask(ar, sta, vif->rate_code[i],
+						ATH10K_HW_NSS(vif->rate_code[i]))) {
+				arg.rate_ctrl = 0;
+				arg.rcode_flags = 0;
+			}
+
+			if (sta->rate_ctrl[i] >
+			    WMI_TID_CONFIG_RATE_CONTROL_AUTO ||
+			    sta->noack[i] == WMI_PEER_TID_CONFIG_NOACK ||
+			    vif->noack[i] == WMI_PEER_TID_CONFIG_NOACK) {
+				arg.rate_ctrl = 0;
+				arg.rcode_flags = 0;
+			} else {
+				arg.rate_ctrl = vif->rate_ctrl[i];
+				arg.rcode_flags = vif->rate_code[i];
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
@@ -6369,6 +6759,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		arsta->arvif = arvif;
 		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
 		INIT_WORK(&arsta->update_wk, ath10k_sta_rc_update_wk);
+		INIT_WORK(&arsta->tid_config_wk, ath10k_sta_tid_cfg_wk);
 
 		for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 			ath10k_mac_txq_init(sta->txq[i]);
@@ -6376,8 +6767,10 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
-	     new_state == IEEE80211_STA_NOTEXIST))
+	     new_state == IEEE80211_STA_NOTEXIST)) {
 		cancel_work_sync(&arsta->update_wk);
+		cancel_work_sync(&arsta->tid_config_wk);
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -7097,25 +7490,6 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 }
 
 static bool
-ath10k_mac_bitrate_mask_has_single_rate(struct ath10k *ar,
-					enum nl80211_band band,
-					const struct cfg80211_bitrate_mask *mask)
-{
-	int num_rates = 0;
-	int i;
-
-	num_rates += hweight32(mask->control[band].legacy);
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
-		num_rates += hweight8(mask->control[band].ht_mcs[i]);
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++)
-		num_rates += hweight16(mask->control[band].vht_mcs[i]);
-
-	return num_rates == 1;
-}
-
-static bool
 ath10k_mac_bitrate_mask_get_single_nss(struct ath10k *ar,
 				       enum nl80211_band band,
 				       const struct cfg80211_bitrate_mask *mask,
@@ -7164,65 +7538,6 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 	return true;
 }
 
-static int
-ath10k_mac_bitrate_mask_get_single_rate(struct ath10k *ar,
-					enum nl80211_band band,
-					const struct cfg80211_bitrate_mask *mask,
-					u8 *rate, u8 *nss)
-{
-	int rate_idx;
-	int i;
-	u16 bitrate;
-	u8 preamble;
-	u8 hw_rate;
-
-	if (hweight32(mask->control[band].legacy) == 1) {
-		rate_idx = ffs(mask->control[band].legacy) - 1;
-
-		if (ar->phy_capability & WHAL_WLAN_11A_CAPABILITY)
-			rate_idx += ATH10K_MAC_FIRST_OFDM_RATE_IDX;
-
-		hw_rate = ath10k_wmi_legacy_rates[rate_idx].hw_value;
-		bitrate = ath10k_wmi_legacy_rates[rate_idx].bitrate;
-
-		if (ath10k_mac_bitrate_is_cck(bitrate))
-			preamble = WMI_RATE_PREAMBLE_CCK;
-		else
-			preamble = WMI_RATE_PREAMBLE_OFDM;
-
-		*nss = 1;
-		*rate = preamble << 6 |
-			(*nss - 1) << 4 |
-			hw_rate << 0;
-
-		return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++) {
-		if (hweight8(mask->control[band].ht_mcs[i]) == 1) {
-			*nss = i + 1;
-			*rate = WMI_RATE_PREAMBLE_HT << 6 |
-				(*nss - 1) << 4 |
-				(ffs(mask->control[band].ht_mcs[i]) - 1);
-
-			return 0;
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
-		if (hweight16(mask->control[band].vht_mcs[i]) == 1) {
-			*nss = i + 1;
-			*rate = WMI_RATE_PREAMBLE_VHT << 6 |
-				(*nss - 1) << 4 |
-				(ffs(mask->control[band].vht_mcs[i]) - 1);
-
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 static int ath10k_mac_set_fixed_rate_params(struct ath10k_vif *arvif,
 					    u8 rate, u8 nss, u8 sgi, u8 ldpc)
 {
@@ -7991,6 +8306,140 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
+static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct ieee80211_tid_config *tid_config)
+{
+	struct ath10k *ar = hw->priv;
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k_mac_iter_tid_conf_data data = {};
+	struct wmi_per_peer_per_tid_cfg_arg arg = {};
+	int ret, i;
+	u8 changed;
+
+	mutex_lock(&ar->conf_mutex);
+	arg.vdev_id = arvif->vdev_id;
+
+	memset(arvif->tid_conf_changed, 0, sizeof(arvif->tid_conf_changed));
+
+	for (i = 0; i < tid_config->n_tid_conf; i++) {
+		if (tid_config->tid_conf[i].tid >= IEEE80211_TID_MAX)
+			continue;
+
+		ath10k_mac_parse_tid_config(ar, sta, vif,
+					    &tid_config->tid_conf[i],
+					    &arg);
+		changed = tid_config->tid_conf[i].tid_conf_mask;
+		if (sta) {
+			if (!sta->wme) {
+				ret = -ENOTSUPP;
+				goto exit;
+			}
+
+			if (changed & IEEE80211_TID_CONF_RETRY) {
+				if (sta->noack[arg.tid] == WMI_PEER_TID_CONFIG_NOACK ||
+				    vif->noack[arg.tid] == WMI_PEER_TID_CONFIG_NOACK)
+					arg.retry_count = 0;
+			}
+
+			if (changed & IEEE80211_TID_CONF_AMPDU) {
+				if (sta->noack[arg.tid] == WMI_PEER_TID_CONFIG_NOACK ||
+				    vif->noack[arg.tid] == WMI_PEER_TID_CONFIG_NOACK)
+					arg.aggr_control = 0;
+			}
+
+			if (changed & IEEE80211_TID_CONF_TX_BITRATE) {
+				if (sta->noack[arg.tid] == WMI_PEER_TID_CONFIG_NOACK ||
+				    vif->noack[arg.tid] == WMI_PEER_TID_CONFIG_NOACK) {
+					arg.rate_ctrl = 0;
+					arg.rcode_flags = 0;
+				}
+			}
+
+			ether_addr_copy(arg.peer_macaddr.addr, sta->addr);
+			ret = ath10k_wmi_set_per_peer_per_tid_cfg(ar, &arg);
+			if (ret)
+				goto exit;
+
+			/* Store the configured parameters in success case */
+			if (changed & IEEE80211_TID_CONF_NOACK) {
+				if (tid_config->tid_conf[i].noack ==
+						NL80211_TID_CONFIG_DEFAULT) {
+					sta->noack[arg.tid] = -1;
+				} else {
+					sta->noack[arg.tid] = arg.ack_policy;
+				}
+
+				arg.ack_policy = 0;
+				arg.aggr_control = 0;
+				arg.rate_ctrl = 0;
+				arg.rcode_flags = 0;
+			}
+
+			if (changed & IEEE80211_TID_CONF_RETRY) {
+				if (tid_config->tid_conf[i].retry_long == -1) {
+					sta->retry_long[arg.tid] = -1;
+				} else {
+					sta->retry_long[arg.tid] = arg.retry_count;
+				}
+
+				arg.retry_count = 0;
+			}
+
+			if (changed & IEEE80211_TID_CONF_AMPDU) {
+				if (tid_config->tid_conf[i].ampdu ==
+						NL80211_TID_CONFIG_DEFAULT) {
+					sta->ampdu[arg.tid] = -1;
+				} else {
+					sta->ampdu[arg.tid] = arg.aggr_control;
+				}
+
+				arg.aggr_control = 0;
+			}
+
+			if (changed & IEEE80211_TID_CONF_TX_BITRATE) {
+				sta->rate_ctrl[arg.tid] = arg.rate_ctrl;
+				arg.rate_ctrl = 0;
+				arg.rcode_flags = 0;
+			}
+		} else {
+			arvif->tid_conf_changed[arg.tid] |= changed;
+
+			if (changed & IEEE80211_TID_CONF_NOACK) {
+				vif->noack[arg.tid] = arg.ack_policy;
+				vif->ampdu[arg.tid] = arg.aggr_control;
+				vif->rate_ctrl[arg.tid] = arg.rate_ctrl;
+			}
+
+			if (changed & IEEE80211_TID_CONF_RETRY)
+				vif->retry_long[arg.tid] = arg.retry_count;
+
+			if (changed & IEEE80211_TID_CONF_AMPDU)
+				vif->ampdu[arg.tid] = arg.aggr_control;
+
+			if (changed & IEEE80211_TID_CONF_TX_BITRATE) {
+				vif->rate_ctrl[arg.tid] = arg.rate_ctrl;
+				vif->rate_code[arg.tid] = arg.rcode_flags;
+			}
+		}
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
@@ -8033,6 +8482,7 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	.switch_vif_chanctx		= ath10k_mac_op_switch_vif_chanctx,
 	.sta_pre_rcu_remove		= ath10k_mac_op_sta_pre_rcu_remove,
 	.sta_statistics			= ath10k_sta_statistics,
+	.set_tid_config			= ath10k_mac_op_set_tid_config,
 
 	CFG80211_TESTMODE_CMD(ath10k_tm_cmd)
 
@@ -8695,6 +9145,29 @@ int ath10k_mac_register(struct ath10k *ar)
 		wiphy_ext_feature_set(ar->hw->wiphy,
 				      NL80211_EXT_FEATURE_ENABLE_FTM_RESPONDER);
 
+	if (test_bit(WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, ar->wmi.svc_map)) {
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK);
+		ar->hw->wiphy->max_data_retry_count = ATH10K_MAX_RETRY_COUNT;
+		ar->hw->wiphy->flags |= WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT;
+	} else {
+		ar->ops->set_tid_config = NULL;
+		ar->hw->wiphy->flags &= ~WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT;
+	}
 	/*
 	 * on LL hardware queues are managed entirely by the FW
 	 * so we only advertise to mac we can do the queues thing
-- 
1.7.9.5

