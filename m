Return-Path: <linux-wireless+bounces-21707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CCAA93047
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF47B4C20
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7A26B0B3;
	Fri, 18 Apr 2025 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H2ccEqwW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27366268698;
	Fri, 18 Apr 2025 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944991; cv=none; b=iRfIZv5/CWb05a6mcau+VK7B1+fuO8Luyd2LBQj7jocSS05c1ivmewAbVdWWKnpi+VxmODd2h4pPk8taTlxoZAY76RUtxm0calQCiydfh97mb2RVXBd3M/KFhOoIZ4KaCNfCh9ISNK6pqzjbWHVvUk0CFKZgLXpGxV58BtpWDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944991; c=relaxed/simple;
	bh=a6hRQ8XHJa6tBmS6Nmc7+M9ZhAfiFQtbUn97UM/XsCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g63Up2nWDoGsxwAJ87bMtGA6hjsOgYFjbExTaKoBgRpA2Z9uF5jpFl1i4ARQIvg/noxLQ4VsNiNK8YRb64JCV4M8rLxTs2TsFS4Gofj32hsQ/k40TDb1AqJAR5K/E0lLM3bLLMrTYHaIVptnM0bdIskNg2M3jIw3BrxFDTKWPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H2ccEqwW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2hpUN014254;
	Fri, 18 Apr 2025 02:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9YXYtShrqrcQgUu8dmDlWm08qMzbbLare4ePpNAkBO4=; b=H2ccEqwWgbQR7yTn
	fkV/j4QZSbHIjzzQv4SsIShUgL51iqrkWDIPzdGznRr4+p+BBfSeUyodSkOlwFg1
	029+QdiOzQbgUv6o6nhluzlzUB1Qt29rkPr/7GrQdXaj7z3d2UEvsany+rn2oscS
	vhpKBL+6/W4hJiEmkXoZzHSrNdpplaPq7xvCHgVy50kRKB6z7upNMhZFi0a+PifI
	ApKaX8YV52U5OJRXqPJeXh2lvPLsd93OoCZ8tCjQeUu5GGJRm4GfI+PrI5bLJfxv
	HbIM+8CbOwfFm61kKJqLngQy/lZpxd9yz6MBjC2LzfreppgsS93gGALRsDq384Du
	tHwncg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1gppq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2uJpL002928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:19 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:17 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:46 +0800
Subject: [PATCH ath-next 13/15] wifi: ath12k: fill parameters for vdev set
 TPC power WMI command
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-13-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=6801bf54 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=XGvdKcLd2eyZ0GuCeGsA:9 a=GOlFskYdUPbH8J6l:21
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: KFHON5MEzqE9a-Kz94crmMG4mVoeB8By
X-Proofpoint-ORIG-GUID: KFHON5MEzqE9a-Kz94crmMG4mVoeB8By
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

Prepare the parameters which are needed for WMI command
WMI_VDEV_SET_TPC_POWER_CMDID. This helper will be used in a following
patch.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 319 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.h |   3 +
 2 files changed, 322 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c2f3aa3ce60a32b288590bd81cdcdabe6fab547e..54495a88c6ee0ba15e58964428d4c5851f3d7404 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9742,6 +9742,325 @@ static int ath12k_start_vdev_delay(struct ath12k *ar,
 	return 0;
 }
 
+static u8 ath12k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
+{
+	if (chan_def->chan->flags & IEEE80211_CHAN_PSD) {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			return 1;
+		case NL80211_CHAN_WIDTH_40:
+			return 2;
+		case NL80211_CHAN_WIDTH_80:
+			return 4;
+		case NL80211_CHAN_WIDTH_160:
+			return 8;
+		case NL80211_CHAN_WIDTH_320:
+			return 16;
+		default:
+			return 1;
+		}
+	} else {
+		switch (chan_def->width) {
+		case NL80211_CHAN_WIDTH_20:
+			return 1;
+		case NL80211_CHAN_WIDTH_40:
+			return 2;
+		case NL80211_CHAN_WIDTH_80:
+			return 3;
+		case NL80211_CHAN_WIDTH_160:
+			return 4;
+		case NL80211_CHAN_WIDTH_320:
+			return 5;
+		default:
+			return 1;
+		}
+	}
+}
+
+static u16 ath12k_mac_get_6ghz_start_frequency(struct cfg80211_chan_def *chan_def)
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
+	 * bandwidth=320 MHz, center frequency is 6105, lowest channel is 1
+	 * with center frequency 5955, its diff is 6105 - 5955 = 70.
+	 */
+	switch (chan_def->width) {
+	case NL80211_CHAN_WIDTH_320:
+		diff_seq = 150;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		diff_seq = 70;
+		break;
+	case NL80211_CHAN_WIDTH_80:
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
+static u16 ath12k_mac_get_seg_freq(struct cfg80211_chan_def *chan_def,
+				   u16 start_seq, u8 seq)
+{
+	u16 seg_seq;
+
+	/* It is to get the center frequency of the specific bandwidth.
+	 * start_seq means the lowest channel number's center frequency.
+	 * seq 0/1/2/3 means 20 MHz/40 MHz/80 MHz/160 MHz.
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
+	seg_seq = 10 * (BIT(seq) - 1);
+	return seg_seq + start_seq;
+}
+
+static void ath12k_mac_get_psd_channel(struct ath12k *ar,
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
+	*temp_chan = ieee80211_get_channel(ar->ah->hw->wiphy, *center_freq);
+	*tx_power = (*temp_chan)->max_reg_power;
+}
+
+static void ath12k_mac_get_eirp_power(struct ath12k *ar,
+				      u16 *start_freq,
+				      u16 *center_freq,
+				      u8 i,
+				      struct ieee80211_channel **temp_chan,
+				      struct cfg80211_chan_def *def,
+				      s8 *tx_power)
+{
+	/* It is to get the center frequency for 20 MHz/40 MHz/80 MHz/
+	 * 160 MHz bandwidth, and then plus 10 to the center frequency,
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
+	*center_freq = ath12k_mac_get_seg_freq(def, *start_freq, i);
+
+	/* For the 20 MHz, its center frequency is same with same channel */
+	if (i != 0)
+		*center_freq += 10;
+
+	*temp_chan = ieee80211_get_channel(ar->ah->hw->wiphy, *center_freq);
+	*tx_power = (*temp_chan)->max_reg_power;
+}
+
+void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
+				  struct ath12k_link_vif *arvif,
+				  struct ieee80211_chanctx_conf *ctx)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_reg_tpc_power_info *reg_tpc_info = &arvif->reg_tpc_info;
+	struct ieee80211_bss_conf *bss_conf = ath12k_mac_get_link_bss_conf(arvif);
+	struct ieee80211_channel *chan, *temp_chan;
+	u8 pwr_lvl_idx, num_pwr_levels, pwr_reduction;
+	bool is_psd_power = false, is_tpe_present = false;
+	s8 max_tx_power[ATH12K_NUM_PWR_LEVELS],
+		psd_power, tx_power, eirp_power;
+	u16 start_freq, center_freq;
+
+	chan = ctx->def.chan;
+	start_freq = ath12k_mac_get_6ghz_start_frequency(&ctx->def);
+	pwr_reduction = bss_conf->pwr_reduction;
+
+	if (arvif->reg_tpc_info.num_pwr_levels) {
+		is_tpe_present = true;
+		num_pwr_levels = arvif->reg_tpc_info.num_pwr_levels;
+	} else {
+		num_pwr_levels = ath12k_mac_get_num_pwr_levels(&ctx->def);
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
+					ath12k_mac_get_psd_channel(ar, 20,
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
+					ath12k_mac_get_eirp_power(ar,
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
+					ath12k_mac_get_psd_channel(ar, 20,
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
+					ath12k_mac_get_eirp_power(ar,
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
+				ath12k_mac_get_psd_channel(ar, 20,
+							   &start_freq,
+							   &center_freq,
+							   pwr_lvl_idx,
+							   &temp_chan,
+							   &tx_power);
+				psd_power = temp_chan->psd;
+				eirp_power = tx_power;
+				max_tx_power[pwr_lvl_idx] = psd_power;
+			} else {
+				ath12k_mac_get_eirp_power(ar,
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
+			ath12k_dbg(ab, ATH12K_DBG_MAC,
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
+			if (ar->max_allowed_tx_power && ab->hw_params->idle_ps)
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
+			if (ar->max_allowed_tx_power && ab->hw_params->idle_ps)
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
+		ath12k_reg_ap_pwr_convert(bss_conf->power_type);
+}
+
 static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
 					struct ath12k_link_vif *arvif)
 {
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index d167b969406b071e95d5d2812288657f22d9092e..e6e74b45bfa426c92dcc7dafaeb032a8a1520b6e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -168,4 +168,7 @@ struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 int ath12k_mac_get_fw_stats(struct ath12k *ar, struct ath12k_fw_stats_req_params *param);
 void ath12k_mac_update_freq_range(struct ath12k *ar,
 				  u32 freq_low, u32 freq_high);
+void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
+				  struct ath12k_link_vif *arvif,
+				  struct ieee80211_chanctx_conf *ctx);
 #endif

-- 
2.34.1


