Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040307A75D0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjITIY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjITIYv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 04:24:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B092F3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 01:24:32 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K7QWne032460;
        Wed, 20 Sep 2023 08:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=jOlI+xNkbNED/utdSHWh7CCuYxWrJPPVLO3O1FBy0MA=;
 b=LEDLI9Yc2bgXeTtf8FZxvSOYCSyhT7YxNXKau1h5lJWCC1QvjIXYB+doSWrMNCn2Ck03
 hd3FwDIjwrAAzIOIye3OCED/6szNslSZ1EZpWc8FfBaNaPqlH5WXe8Wa7ed0UnscnsuS
 UrJFWBCFoTl/lIIu2byPfhzvTnJRGfttsKFaizKLFYdP3ixU8GZBLTn5iRBT6sucf8XR
 xCi24mLgcDsd8BH+kxGdqr4BB1xAOJ515ZB/NE39zHNHTGGA6ub9WXzain6CTWZyxhhi
 /tviJk3O+gvrLkAgrk/S21iqLeoiOjThaaNDX1Ca7u8EXw5wP5RXCuCIj/cvdCOqDDmj 7Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7vbkr3ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K8OPTR006587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:25 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 01:24:21 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 09/13] wifi: ath11k: fill parameters for vdev set tpc power WMI command
Date:   Wed, 20 Sep 2023 04:23:45 -0400
Message-ID: <20230920082349.29111-10-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920082349.29111-1-quic_wgong@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xlXXp5NwGvZd1wM7GzlfjP2uv1ZEqQ7J
X-Proofpoint-ORIG-GUID: xlXXp5NwGvZd1wM7GzlfjP2uv1ZEqQ7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare the parameters which is needed for WMI command WMI_VDEV_SET_TPC_POWER_CMDID.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 277 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h |   3 +
 2 files changed, 280 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index bfb900d98347..f05d66913abd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7661,6 +7661,283 @@ static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
 	}
 }
 
+static u16 ath11k_mac_get_6ghz_start_frequency(struct cfg80211_chan_def *chan_def)
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
+	start_freq = ath11k_mac_get_6ghz_start_frequency(&ctx->def);
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
+				max_tx_power[pwr_lvl_idx] = tx_power;
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
+	reg_tpc_info->ap_power_type =
+		ath11k_reg_ap_pwr_convert(vif->bss_conf.power_type);
+}
+
 static void ath11k_mac_parse_tx_pwr_env(struct ath11k *ar,
 					struct ieee80211_vif *vif,
 					struct ieee80211_chanctx_conf *ctx)
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 94c5c61ae2bb..25c18be75f46 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -174,4 +174,7 @@ int ath11k_mac_wait_tx_complete(struct ath11k *ar);
 int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
+void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_chanctx_conf *ctx);
 #endif
-- 
2.40.1

