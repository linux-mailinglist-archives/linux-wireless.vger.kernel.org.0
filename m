Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3222C43B119
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhJZLWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:22:25 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47817 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhJZLWY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635247201; x=1666783201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PoJNNu3sKojCddKdbpx2J4FfYr9Iv03974Kbxw4jIEY=;
  b=DrjxbWKJYwimI6llQJ4SQy1pothPezEDZJOzwt7snuevzWUwkVr2aYQ8
   SZp4Md/yrYj2UtcYT6/BriMe7vQ/Ww3DkfLjzz+iPnBeUQWB0ERFDN+q+
   5pAOUVnQ5DkYPlaRBw3J8W3mSWFv7JjRrojZYuR0iPUbCh5ONfoa9ZsfY
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 04:20:01 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 04:20:01 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 04:19:59 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 09/15] ath11k: add parse of transmit power envelope element
Date:   Tue, 26 Oct 2021 07:19:07 -0400
Message-ID: <20211026111913.7346-10-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026111913.7346-1-quic_wgong@quicinc.com>
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The transmit power envelope element has some fields for power, ath11k
should parse it according to IEEE Std 802.11ax™‐2021.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  38 +++++
 drivers/net/wireless/ath/ath11k/mac.c  | 197 +++++++++++++++++++++++++
 2 files changed, 235 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index dfe62a3490d2..94516d14f89b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -196,6 +196,43 @@ enum ath11k_monitor_flags {
 	ATH11K_FLAG_MONITOR_ENABLED,
 };
 
+/**
+ * struct chan_power_info - TPE containing power info per channel chunk
+ * @chan_cfreq: channel center freq (MHz)
+ * e.g.
+ * channel 37/20 MHz,  it is 6135
+ * channel 37/40 MHz,  it is 6125
+ * channel 37/80 MHz,  it is 6145
+ * channel 37/160 MHz, it is 6185
+ * @tx_power: transmit power (dBm)
+ */
+struct chan_power_info {
+	u16 chan_cfreq;
+	s8 tx_power;
+};
+
+/**
+ * struct reg_tpc_power_info - regulatory TPC power info
+ * @is_psd_power: is PSD power or not
+ * @eirp_power: Maximum EIRP power (dBm), valid only if power is PSD
+ * @power_type_6g: type of power (SP/LPI/VLP)
+ * @num_pwr_levels: number of power levels
+ * @reg_max: Array of maximum TX power (dBm) per PSD value
+ * @ap_constraint_power: AP constraint power (dBm)
+ * @tpe: TPE values processed from TPE IE
+ * @chan_power_info: power info to send to firmware
+ */
+struct ath11k_reg_tpc_power_info {
+	bool is_psd_power;
+	u8 eirp_power;
+	enum wmi_reg_6g_ap_type power_type_6g;
+	u8 num_pwr_levels;
+	u8 reg_max[IEEE80211_MAX_NUM_PWR_LEVEL];
+	u8 ap_constraint_power;
+	s8 tpe[IEEE80211_MAX_NUM_PWR_LEVEL];
+	struct chan_power_info chan_power_info[IEEE80211_MAX_NUM_PWR_LEVEL];
+};
+
 struct ath11k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -244,6 +281,7 @@ struct ath11k_vif {
 	bool rsnie_present;
 	bool wpaie_present;
 	struct ieee80211_chanctx_conf chanctx;
+	struct ath11k_reg_tpc_power_info reg_tpc_info;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 76ccc99e77ae..71991178a830 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5580,6 +5580,201 @@ static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static u8 ath11k_mac_get_tpe_count(u8 txpwr_intrprt, u8 txpwr_cnt)
+{
+	switch (txpwr_intrprt) {
+	/* Refer "Table 9-276-Meaning of Maximum Transmit Power Count subfield
+	 * if the Maximum Transmit Power Interpretation subfield is 0 or 2" of
+	 * "IEEE Std 802.11ax 2021".
+	 */
+	case IEEE80211_TPE_LOCAL_EIRP:
+	case IEEE80211_TPE_REG_CLIENT_EIRP:
+		txpwr_cnt = txpwr_cnt <= 3 ? txpwr_cnt : 3;
+		txpwr_cnt = txpwr_cnt + 1;
+		break;
+	/* Refer "Table 9-277-Meaning of Maximum Transmit Power Count subfield
+	 * if Maximum Transmit Power Interpretation subfield is 1 or 3" of
+	 * "IEEE Std 802.11ax 2021".
+	 */
+	case IEEE80211_TPE_LOCAL_EIRP_PSD:
+	case IEEE80211_TPE_REG_CLIENT_EIRP_PSD:
+		txpwr_cnt = txpwr_cnt <= 4 ? txpwr_cnt : 4;
+		txpwr_cnt = txpwr_cnt ? (BIT(txpwr_cnt - 1)) : 1;
+		break;
+	}
+
+	return txpwr_cnt;
+}
+
+static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
+{
+	u8 num_pwr_levels;
+
+	if (chan_def->chan->flags & IEEE80211_CHAN_PSD) {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			num_pwr_levels = 1;
+			break;
+		case NL80211_CHAN_WIDTH_40:
+			num_pwr_levels = 2;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			num_pwr_levels = 4;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			num_pwr_levels = 8;
+			break;
+		default:
+			return 1;
+		}
+	} else {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			num_pwr_levels = 1;
+			break;
+		case NL80211_CHAN_WIDTH_40:
+			num_pwr_levels = 2;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			num_pwr_levels = 3;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			num_pwr_levels = 4;
+			break;
+		default:
+			return 1;
+		}
+	}
+
+	return num_pwr_levels;
+}
+
+static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
+					struct ieee80211_vif *vif,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct ieee80211_tx_pwr_env *single_tpe;
+	enum wmi_reg_6g_client_type client_type;
+	struct cur_regulatory_info *reg_info;
+	int i;
+	u8 pwr_count, pwr_interpret, pwr_category;
+	u8 psd_index = 0, non_psd_index = 0, local_tpe_count = 0, reg_tpe_count = 0;
+	bool use_local_tpe, non_psd_set = false, psd_set = false;
+
+	reg_info = &ab->reg_info_store[ar->pdev_idx];
+	client_type = reg_info->client_type;
+
+	for (i = 0; i < bss_conf->tx_pwr_env_num; i++) {
+		single_tpe = &bss_conf->tx_pwr_env[i];
+		pwr_category = u8_get_bits(single_tpe->tx_power_info,
+					   IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+
+		if (pwr_category == client_type) {
+			if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP ||
+			    pwr_interpret == IEEE80211_TPE_LOCAL_EIRP_PSD)
+				local_tpe_count++;
+			else if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP ||
+				 pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP_PSD)
+				reg_tpe_count++;
+		}
+	}
+
+	if (!reg_tpe_count && !local_tpe_count) {
+		ath11k_warn(ab,
+			    "no transmit power envelope match client power type %d\n",
+			    client_type);
+		return;
+	} else if (!reg_tpe_count) {
+		use_local_tpe = true;
+	} else {
+		use_local_tpe = false;
+	}
+
+	for (i = 0; i < bss_conf->tx_pwr_env_num; i++) {
+		single_tpe = &bss_conf->tx_pwr_env[i];
+		pwr_category = u8_get_bits(single_tpe->tx_power_info,
+					   IEEE80211_TX_PWR_ENV_INFO_CATEGORY);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+
+		if (pwr_category != client_type)
+			continue;
+
+		/* get local transmit power envelope */
+		if (use_local_tpe) {
+			if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP) {
+				non_psd_index = i;
+				non_psd_set = true;
+			} else if (pwr_interpret == IEEE80211_TPE_LOCAL_EIRP_PSD) {
+				psd_index = i;
+				psd_set = true;
+			}
+		/* get regulatory transmit power envelope */
+		} else {
+			if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP) {
+				non_psd_index = i;
+				non_psd_set = true;
+			} else if (pwr_interpret == IEEE80211_TPE_REG_CLIENT_EIRP_PSD) {
+				psd_index = i;
+				psd_set = true;
+			}
+		}
+	}
+
+	if (non_psd_set && !psd_set) {
+		single_tpe = &bss_conf->tx_pwr_env[non_psd_index];
+		pwr_count = u8_get_bits(single_tpe->tx_power_info,
+					IEEE80211_TX_PWR_ENV_INFO_COUNT);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+		arvif->reg_tpc_info.is_psd_power = false;
+		arvif->reg_tpc_info.eirp_power = 0;
+
+		arvif->reg_tpc_info.num_pwr_levels =
+			ath11k_mac_get_tpe_count(pwr_interpret, pwr_count);
+		for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
+			ath11k_dbg(ab, ATH11K_DBG_MAC,
+				   "non PSD power[%d] : %d\n",
+				   i, single_tpe->tx_power[i]);
+			arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+		}
+	}
+
+	if (psd_set) {
+		single_tpe = &bss_conf->tx_pwr_env[psd_index];
+		pwr_count = u8_get_bits(single_tpe->tx_power_info,
+					IEEE80211_TX_PWR_ENV_INFO_COUNT);
+		pwr_interpret = u8_get_bits(single_tpe->tx_power_info,
+					    IEEE80211_TX_PWR_ENV_INFO_INTERPRET);
+		arvif->reg_tpc_info.is_psd_power = true;
+
+		if (pwr_count == 0) {
+			ath11k_dbg(ab, ATH11K_DBG_MAC,
+				   "TPE PSD power : %d\n", single_tpe->tx_power[0]);
+			arvif->reg_tpc_info.num_pwr_levels =
+				ath11k_mac_get_num_pwr_levels(&ctx->def);
+			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++)
+				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[0] / 2;
+		} else {
+			arvif->reg_tpc_info.num_pwr_levels =
+				ath11k_mac_get_tpe_count(pwr_interpret, pwr_count);
+			for (i = 0; i < arvif->reg_tpc_info.num_pwr_levels; i++) {
+				ath11k_dbg(ab, ATH11K_DBG_MAC,
+					   "TPE PSD power[%d] : %d\n",
+					   i, single_tpe->tx_power[i]);
+				arvif->reg_tpc_info.tpe[i] = single_tpe->tx_power[i] / 2;
+			}
+		}
+	}
+}
+
 static int
 ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -5608,6 +5803,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		if (power_type == IEEE80211_REG_UNSET_AP)
 			power_type = IEEE80211_REG_LPI_AP;
 		ath11k_reg_handle_chan_list(ab, reg_info, power_type);
+
+		ath11k_mac_parse_tx_pwr_env(ar, vif, ctx);
 	}
 
 	/* for QCA6390 bss peer must be created before vdev_start */
-- 
2.31.1

