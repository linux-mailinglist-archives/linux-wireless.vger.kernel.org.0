Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7447ED7D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352101AbhLXIxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 03:53:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62138 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352066AbhLXIxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 03:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640335990; x=1671871990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/zHq1EY2iMmcjmq+GbeQi8kMJW9IUf3x2S9FWsPPRmQ=;
  b=e7MZBlntrbRCCc8Qp9IbwM+NZlndqRr5DW6iGDaARS8+fHzESrWRxarb
   2ThR5WoDyqnofMRiEox8VwY5Ff0EuSjpzQPurEQwiCW5k9g09+0cKOUvc
   G0c765owDJtcCyWyJ1AIkKlF8IP9ivgZ9cen7PhNiMUT7+PbNRjpJenTw
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Dec 2021 00:53:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:53:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:09 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:08 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 11/15] ath11k: fill parameters for vdev_set_tpc_power wmi command
Date:   Fri, 24 Dec 2021 03:52:32 -0500
Message-ID: <20211224085236.9064-12-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211224085236.9064-1-quic_wgong@quicinc.com>
References: <20211224085236.9064-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare the parameters which is needed for wmi cmd vdev_set_tpc_power.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 280 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h |   3 +
 2 files changed, 283 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6eb707473ed3..e1bdfe466bc7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7047,6 +7047,286 @@ static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
 	}
 }
 
+static u16 ath11k_mac_get_6g_start_frequency(struct cfg80211_chan_def *chan_def)
+{
+	u16 diff_seq;
+
+	/* It is to get the lowest channel number's center frequency of the chan.
+	 * For example,
+	 * bandwidth=40 MHz, center frequency is 5965, lowest channel is 1
+	 * with center frequency 5955, its diff is 5965 - 5955 = 10.
+	 * bandwidth=80 MHz, center frequency is 5985, lowest channel is 1
+	 * with center frequency 5955, its diff is 5985 - 5955 = 30.
+	 * bandwidth=160 MHz, center frequency is 6025, lowest channel is 1
+	 * with center frequency 5955, its diff is 6025 - 5955 = 70.
+	 */
+	switch (chan_def->width) {
+	case NL80211_CHAN_WIDTH_160:
+		diff_seq = 70;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+	case NL80211_CHAN_WIDTH_80P80:
+		diff_seq = 30;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		diff_seq = 10;
+		break;
+	default:
+		diff_seq = 0;
+	}
+
+	return chan_def->center_freq1 - diff_seq;
+}
+
+static u16 ath11k_mac_get_seg_freq(struct cfg80211_chan_def *chan_def,
+				   u16 start_seq, u8 seq)
+{
+	u16 seg_seq;
+
+	/* It is to get the center frequency of the specific bandwidth.
+	 * start_seq means the lowest channel number's center frequency.
+	 * seq 0/1/2/3 means 20 MHz/40 MHz/80 MHz/160 MHz&80P80.
+	 * For example,
+	 * lowest channel is 1, its center frequency 5955,
+	 * center frequency is 5955 when bandwidth=20 MHz, its diff is 5955 - 5955 = 0.
+	 * lowest channel is 1, its center frequency 5955,
+	 * center frequency is 5965 when bandwidth=40 MHz, its diff is 5965 - 5955 = 10.
+	 * lowest channel is 1, its center frequency 5955,
+	 * center frequency is 5985 when bandwidth=80 MHz, its diff is 5985 - 5955 = 30.
+	 * lowest channel is 1, its center frequency 5955,
+	 * center frequency is 6025 when bandwidth=160 MHz, its diff is 6025 - 5955 = 70.
+	 */
+	if (chan_def->width == NL80211_CHAN_WIDTH_80P80 && seq == 3)
+		return chan_def->center_freq2;
+
+	seg_seq = 10 * (BIT(seq) - 1);
+	return seg_seq + start_seq;
+}
+
+static void ath11k_mac_get_psd_channel(struct ath11k *ar,
+				       u16 step_freq,
+				       u16 *start_freq,
+				       u16 *center_freq,
+				       u8 i,
+				       struct ieee80211_channel **temp_chan,
+				       s8 *tx_power)
+{
+	/* It is to get the the center frequency for each 20 MHz.
+	 * For example, if the chan is 160 MHz and center frequency is 6025,
+	 * then it include 8 channels, they are 1/5/9/13/17/21/25/29,
+	 * channel number 1's center frequency is 5955, it is parameter start_freq.
+	 * parameter i is the step of the 8 channels. i is 0~7 for the 8 channels.
+	 * the channel 1/5/9/13/17/21/25/29 maps i=0/1/2/3/4/5/6/7,
+	 * and maps its center frequency is 5955/5975/5995/6015/6035/6055/6075/6095,
+	 * the gap is 20 for each channel, parameter step_freq means the gap.
+	 * after get the center frequency of each channel, it is easy to find the
+	 * struct ieee80211_channel of it and get the max_reg_power.
+	 */
+	*center_freq = *start_freq + i * step_freq;
+	*temp_chan = ieee80211_get_channel(ar->hw->wiphy, *center_freq);
+	*tx_power = (*temp_chan)->max_reg_power;
+}
+
+static void ath11k_mac_get_eirp_power(struct ath11k *ar,
+				      u16 *start_freq,
+				      u16 *center_freq,
+				      u8 i,
+				      struct ieee80211_channel **temp_chan,
+				      struct cfg80211_chan_def *def,
+				      s8 *tx_power)
+{
+	/* It is to get the the center frequency for 20 MHz/40 MHz/80 MHz/
+	 * 160 MHz&80P80 bandwidth, and then plus 10 to the center frequency,
+	 * it is the center frequency of a channel number.
+	 * For example, when configured channel number is 1.
+	 * center frequency is 5965 when bandwidth=40 MHz, after plus 10, it is 5975,
+	 * then it is channel number 5.
+	 * center frequency is 5985 when bandwidth=80 MHz, after plus 10, it is 5995,
+	 * then it is channel number 9.
+	 * center frequency is 6025 when bandwidth=160 MHz, after plus 10, it is 6035,
+	 * then it is channel number 17.
+	 * after get the center frequency of each channel, it is easy to find the
+	 * struct ieee80211_channel of it and get the max_reg_power.
+	 */
+	*center_freq = ath11k_mac_get_seg_freq(def, *start_freq, i);
+
+	/* For the 20 MHz, its center frequency is same with same channel */
+	if (i != 0)
+		*center_freq += 10;
+
+	*temp_chan = ieee80211_get_channel(ar->hw->wiphy, *center_freq);
+	*tx_power = (*temp_chan)->max_reg_power;
+}
+
+void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_chanctx_conf *ctx)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct ath11k_reg_tpc_power_info *reg_tpc_info = &arvif->reg_tpc_info;
+	struct ieee80211_channel *chan, *temp_chan;
+	u8 pwr_lvl_idx, num_pwr_levels, pwr_reduction;
+	bool is_psd_power = false, is_tpe_present = false;
+	s8 max_tx_power[IEEE80211_MAX_NUM_PWR_LEVEL],
+		psd_power, tx_power, eirp_power;
+	u16 oper_freq, start_freq, center_freq;
+
+	chan = ctx->def.chan;
+	oper_freq = ctx->def.chan->center_freq;
+	start_freq = ath11k_mac_get_6g_start_frequency(&ctx->def);
+	pwr_reduction = bss_conf->pwr_reduction;
+
+	if (arvif->reg_tpc_info.num_pwr_levels) {
+		is_tpe_present = true;
+		num_pwr_levels = arvif->reg_tpc_info.num_pwr_levels;
+	} else {
+		num_pwr_levels = ath11k_mac_get_num_pwr_levels(&ctx->def);
+	}
+
+	for (pwr_lvl_idx = 0; pwr_lvl_idx < num_pwr_levels; pwr_lvl_idx++) {
+		/* STA received TPE IE*/
+		if (is_tpe_present) {
+			/* local power is PSD power*/
+			if (chan->flags & IEEE80211_CHAN_PSD) {
+				/* Connecting AP is psd power */
+				if (reg_tpc_info->is_psd_power) {
+					is_psd_power = true;
+					ath11k_mac_get_psd_channel(ar, 20,
+								   &start_freq,
+								   &center_freq,
+								   pwr_lvl_idx,
+								   &temp_chan,
+								   &tx_power);
+					psd_power = temp_chan->psd;
+					eirp_power = tx_power;
+					max_tx_power[pwr_lvl_idx] =
+						min_t(s8,
+						      psd_power,
+						      reg_tpc_info->tpe[pwr_lvl_idx]);
+				/* Connecting AP is not psd power */
+				} else {
+					ath11k_mac_get_eirp_power(ar,
+								  &start_freq,
+								  &center_freq,
+								  pwr_lvl_idx,
+								  &temp_chan,
+								  &ctx->def,
+								  &tx_power);
+					psd_power = temp_chan->psd;
+					/* convert psd power to EIRP power based
+					 * on channel width
+					 */
+					tx_power =
+						min_t(s8, tx_power,
+						      psd_power + 13 + pwr_lvl_idx * 3);
+					max_tx_power[pwr_lvl_idx] =
+						min_t(s8,
+						      tx_power,
+						      reg_tpc_info->tpe[pwr_lvl_idx]);
+				}
+			/* local power is not PSD power */
+			} else {
+				/* Connecting AP is psd power */
+				if (reg_tpc_info->is_psd_power) {
+					is_psd_power = true;
+					ath11k_mac_get_psd_channel(ar, 20,
+								   &start_freq,
+								   &center_freq,
+								   pwr_lvl_idx,
+								   &temp_chan,
+								   &tx_power);
+					eirp_power = tx_power;
+					max_tx_power[pwr_lvl_idx] =
+						reg_tpc_info->tpe[pwr_lvl_idx];
+				/* Connecting AP is not psd power */
+				} else {
+					ath11k_mac_get_eirp_power(ar,
+								  &start_freq,
+								  &center_freq,
+								  pwr_lvl_idx,
+								  &temp_chan,
+								  &ctx->def,
+								  &tx_power);
+					max_tx_power[pwr_lvl_idx] =
+						min_t(s8,
+						      tx_power,
+						      reg_tpc_info->tpe[pwr_lvl_idx]);
+				}
+			}
+		/* STA not received TPE IE */
+		} else {
+			/* local power is PSD power*/
+			if (chan->flags & IEEE80211_CHAN_PSD) {
+				is_psd_power = true;
+				ath11k_mac_get_psd_channel(ar, 20,
+							   &start_freq,
+							   &center_freq,
+							   pwr_lvl_idx,
+							   &temp_chan,
+							   &tx_power);
+				psd_power = temp_chan->psd;
+				eirp_power = tx_power;
+				max_tx_power[pwr_lvl_idx] = psd_power;
+			} else {
+				ath11k_mac_get_eirp_power(ar,
+							  &start_freq,
+							  &center_freq,
+							  pwr_lvl_idx,
+							  &temp_chan,
+							  &ctx->def,
+							  &tx_power);
+				max_tx_power[pwr_lvl_idx] =
+					min_t(s8,
+					      tx_power,
+					      reg_tpc_info->tpe[pwr_lvl_idx]);
+			}
+		}
+
+		if (is_psd_power) {
+			/* If AP local power constraint is present */
+			if (pwr_reduction)
+				eirp_power = eirp_power - pwr_reduction;
+
+			/* If firmware updated max tx power is non zero, then take
+			 * the min of firmware updated ap tx power
+			 * and max power derived from above mentioned parameters.
+			 */
+			ath11k_dbg(ab, ATH11K_DBG_MAC,
+				   "eirp power : %d firmware report power : %d\n",
+				   eirp_power, ar->max_allowed_tx_power);
+			if (ar->max_allowed_tx_power)
+				eirp_power = min_t(s8,
+						   eirp_power,
+						   ar->max_allowed_tx_power);
+		} else {
+			/* If AP local power constraint is present */
+			if (pwr_reduction)
+				max_tx_power[pwr_lvl_idx] =
+					max_tx_power[pwr_lvl_idx] - pwr_reduction;
+			/* If firmware updated max tx power is non zero, then take
+			 * the min of firmware updated ap tx power
+			 * and max power derived from above mentioned parameters.
+			 */
+			if (ar->max_allowed_tx_power)
+				max_tx_power[pwr_lvl_idx] =
+					min_t(s8,
+					      max_tx_power[pwr_lvl_idx],
+					      ar->max_allowed_tx_power);
+		}
+		reg_tpc_info->chan_power_info[pwr_lvl_idx].chan_cfreq = center_freq;
+		reg_tpc_info->chan_power_info[pwr_lvl_idx].tx_power =
+			max_tx_power[pwr_lvl_idx];
+	}
+
+	reg_tpc_info->num_pwr_levels = num_pwr_levels;
+	reg_tpc_info->is_psd_power = is_psd_power;
+	reg_tpc_info->eirp_power = eirp_power;
+	reg_tpc_info->power_type_6g =
+		ath11k_ieee80211_ap_pwr_type_convert(vif->bss_conf.power_type);
+}
+
 static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 					struct ieee80211_vif *vif,
 					struct ieee80211_chanctx_conf *ctx)
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index eb8273ffc2a7..13c0ef667777 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -172,4 +172,7 @@ enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
 void ath11k_mac_handle_beacon(struct ath11k *ar, struct sk_buff *skb);
 void ath11k_mac_handle_beacon_miss(struct ath11k *ar, u32 vdev_id);
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif);
+void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_chanctx_conf *ctx);
 #endif
-- 
2.31.1

