Return-Path: <linux-wireless+bounces-902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD38168FC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 09:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F72A1C22456
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8A125B6;
	Mon, 18 Dec 2023 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TG7O4xZI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC863125A1
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI5VHrD030502;
	Mon, 18 Dec 2023 08:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iwHJ9nzwU+SsmcG/UHuUbtmNXfHtH2hlhQt6CdF/2ds=; b=TG
	7O4xZICM4Mdf4nLOSfrLBd/lbBwXcLTifjH9v5fhTi0PttbKBE7A8EvE8MzsxVyp
	EstkSbArDdukKgoevpe73zi0xbyk8j/2ZiWj4uHfoMAqchv90daMpN9dSbU7zpNH
	ONFbLkfuUaVbbRSUP5hmKQkOy7GVk+S1XsXpK9iO0hxokGL+n+446n81ARukufq7
	sgBKEILSkqDM5B4r6fGVv7iMSMSUNrWcHD6JV9nsIoaTGHF9WJXqd/PKDTPkuS2Q
	iiJf5+QZ8TL0im4M5T4tQp0xtXYysfSR1wSHsq7R56dv71+LBbrpt74J3R94IyA/
	wCagfZru32oH45Q0Fl0Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xvutxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI8x7T1022761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:07 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 00:59:05 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v10 09/12] wifi: ath11k: fill parameters for vdev set tpc power WMI command
Date: Mon, 18 Dec 2023 16:58:41 +0800
Message-ID: <20231218085844.2658-10-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218085844.2658-1-quic_bqiang@quicinc.com>
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F3bD8BpZ0IxR-SCplKTFv7UUzraMWR_0
X-Proofpoint-ORIG-GUID: F3bD8BpZ0IxR-SCplKTFv7UUzraMWR_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180064

From: Wen Gong <quic_wgong@quicinc.com>

Prepare the parameters which are needed for WMI command WMI_VDEV_SET_TPC_POWER_CMDID.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v10:
 1. add idle_ps check when calculating EIRP.
v9:
 no change.
v8:
 no change.
v7:
 1. s/is/are/
 2. remove oper_freq since not used.
 3. remove repeated word: 'the'.

 drivers/net/wireless/ath/ath11k/mac.c | 284 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h |   3 +
 2 files changed, 287 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 95c774b21ffb..9048dec5cda5 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7667,6 +7667,290 @@ static u8 ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
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
+	/* It is to get the center frequency for each 20 MHz.
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
+	/* It is to get the center frequency for 20 MHz/40 MHz/80 MHz/
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
+	u16 start_freq, center_freq;
+
+	chan = ctx->def.chan;
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
+			/* Firmware reports lower max_allowed_tx_power during vdev
+			 * start response. In case of 6 GHz, firmware is not aware
+			 * of EIRP power unless driver sets EIRP power through WMI
+			 * TPC command. So radio which does not support idle power
+			 * save can set maximum calculated EIRP power directly to
+			 * firmware through TPC command without min comparison with
+			 * vdev start response's max_allowed_tx_power.
+			 */
+			if (ar->max_allowed_tx_power && ab->hw_params.idle_ps)
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
+			if (ar->max_allowed_tx_power && ab->hw_params.idle_ps)
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
index 0dfdeed5177b..eb1f1f4fe7e1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -176,4 +176,7 @@ int ath11k_mac_wait_tx_complete(struct ath11k *ar);
 int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
+void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_chanctx_conf *ctx);
 #endif
-- 
2.25.1


