Return-Path: <linux-wireless+bounces-21234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C0A7F382
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529B41892CF3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 04:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08950182D0;
	Tue,  8 Apr 2025 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h7hi1uJt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B2202F92
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086113; cv=none; b=CpcJmtRZ5uqkeKiLgCzzBLz7/EKv2DI7W40WW5tUggEABP+3VvNCHaLoY1gM3hImZm60ojHhPv7IRXOguHU8NNlDXBwPE070w7ldm967rMnPMmaUKqd2qZTrNT4XK8DKTqF4yGfdY9u1mkLTjfhMXzyHbYglYiAVClMs9mYMHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086113; c=relaxed/simple;
	bh=FhujJOSa9jvMCqLJCWnkUsgP6TMmArNgB+BxgM1ZuJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqGVkRdPTZzbjEgW7TXAaC8Bq92CNjkSZrEIoXD4kMw7bgZVN2MdyLBShamam5BvLWL9IbXg5l0/J+GUZJ6W6YR8Y4tFX88ENkmxgyjG72DqbyAwnDrJDa33yZIhKbt8tZFqcftP2obRtF1yrAHxJq4ldHq0unmIWwDccQio2QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h7hi1uJt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GMXf020165;
	Tue, 8 Apr 2025 04:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbOZXkX8krhqvTh0vVmdGOuSk8+xXSo+njxrlfO20yY=; b=h7hi1uJtWMmIGcLb
	lL8bOW4LYufLA2Rny2zLaCHgFvhTpWyrCzqY27YsKezSrGBBuwOBxWtS+blt8SQD
	UjBkDflMLcsDeTLNFVkfzxpPyji8yhsV4xTfwmYcdTpXG4JGVVgKhd9Mpz6NBgs6
	l8mOgCu4QOz9kuIpJjkMMXekf7XRdDz5i/qznj3iiSJcicvdxyaaU0vnGYUDUIO9
	Q+17KZhgNZtzByqw2CHEGiJ6O+aDBAGWvEnyxUaaSVtdS9CkG1WO0evOIsatsh7Z
	rU75QzgcL52E2kddyk0yBGE51SYfStdbELY9Fw1cIzo7LHUhoNQlIKA2bCYEcnzx
	TmGCvw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2pf67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:21:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5384LnbS002411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 04:21:49 GMT
Received: from hu-rajson-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Apr 2025 21:21:47 -0700
From: Rajat Soni <quic_rajson@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH ath-next 2/3] wifi: ath12k: Fix frequency range in driver
Date: Tue, 8 Apr 2025 09:51:27 +0530
Message-ID: <20250408042128.720263-3-quic_rajson@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408042128.720263-1-quic_rajson@quicinc.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ll3FnGozyUsezp3tktnakArNieg_BH4K
X-Proofpoint-GUID: ll3FnGozyUsezp3tktnakArNieg_BH4K
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f4a45d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=tbqBjApZr0fsov_IfRYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080029

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

During the initial WMI exchange, the firmware updates the
hardware-supported start and end frequencies in the
ath12k_wmi_hal_reg_capabilities_ext_arg structure. These frequencies,
being hardware-supported, may not always align with the current
regulatory operating frequencies. When operating as multiple grouped
hardwares under a single wiphy, the driver advertises these values
directly to the upper layer in the per-radio frequency range,
which can be misleading.

Sample output snippet from iw phyX info command -

[..]
Supported wiphy radios:
          * Idx 0:
                  Frequency Range: 2312 MHz - 2732 MHz
		 [..]

          * Idx 1:
                  Frequency Range: 5150 MHz - 5330 MHz
		 [..]
[..]

The frequency range displayed above is incorrect because the driver
directly advertises the hardware-supported values to the upper layer.

The driver is aware of the current operating regulatory rules, and
hence it can use this information to determine the final operating
start and end frequencies.

To resolve this issue, add support to store the start and end
frequencies received during the regulatory update event.
Then, intersect these with the hardware-supported start and
end frequencies, and finally, advertise the intersected values to the
upper layer.

Sample output snippet from iw phyX info command after the fix -

[..]
Supported wiphy radios:
          * Idx 0:
                  Frequency Range: 2402 MHz - 2472 MHz
		 [..]

          * Idx 1:
                  Frequency Range: 5170 MHz - 5330 MHz
		 [..]
[..]

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  9 ++++++
 drivers/net/wireless/ath/ath12k/mac.c  | 39 ++++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.c  | 13 +++++++++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e8d2a0c859f6..8099a5f54e83 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -880,6 +880,11 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+struct ath12k_reg_freq {
+	u32 start_freq;
+	u32 end_freq;
+};
+
 struct ath12k_mlo_memory {
 	struct target_mem_chunk chunk[ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
 	int mlo_mem_size;
@@ -1122,6 +1127,10 @@ struct ath12k_base {
 	enum ath12k_firmware_mode fw_mode;
 	struct ath12k_ftm_event_obj ftm_event_obj;
 
+	struct ath12k_reg_freq reg_freq_2ghz;
+	struct ath12k_reg_freq reg_freq_5ghz;
+	struct ath12k_reg_freq reg_freq_6ghz;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 449aca719ad3..8c971a58fb6f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10859,16 +10859,17 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 {
 	struct ieee80211_supported_band *band;
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
+	struct ath12k_base *ab = ar->ab;
+	u32 phy_id, freq_low, freq_high;
 	struct ath12k_hw *ah = ar->ah;
 	void *channels;
-	u32 phy_id;
 
 	BUILD_BUG_ON((ARRAY_SIZE(ath12k_2ghz_channels) +
 		      ARRAY_SIZE(ath12k_5ghz_channels) +
 		      ARRAY_SIZE(ath12k_6ghz_channels)) !=
 		     ATH12K_NUM_CHANS);
 
-	reg_cap = &ar->ab->hal_reg_cap[ar->pdev_idx];
+	reg_cap = &ab->hal_reg_cap[ar->pdev_idx];
 
 	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
 		channels = kmemdup(ath12k_2ghz_channels,
@@ -10885,16 +10886,21 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		band->bitrates = ath12k_g_rates;
 		bands[NL80211_BAND_2GHZ] = band;
 
-		if (ar->ab->hw_params->single_pdev_only) {
+		if (ab->hw_params->single_pdev_only) {
 			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2GHZ_CAP);
-			reg_cap = &ar->ab->hal_reg_cap[phy_id];
+			reg_cap = &ab->hal_reg_cap[phy_id];
 		}
+
+		freq_low = max(reg_cap->low_2ghz_chan,
+			       ab->reg_freq_2ghz.start_freq);
+		freq_high = min(reg_cap->high_2ghz_chan,
+				ab->reg_freq_2ghz.end_freq);
+
 		ath12k_mac_update_ch_list(ar, band,
 					  reg_cap->low_2ghz_chan,
 					  reg_cap->high_2ghz_chan);
 
-		ath12k_mac_update_freq_range(ar, reg_cap->low_2ghz_chan,
-					     reg_cap->high_2ghz_chan);
+		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
@@ -10914,12 +10920,17 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
 			bands[NL80211_BAND_6GHZ] = band;
+
+			freq_low = max(reg_cap->low_5ghz_chan,
+				       ab->reg_freq_6ghz.start_freq);
+			freq_high = min(reg_cap->high_5ghz_chan,
+					ab->reg_freq_6ghz.end_freq);
+
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
 
-			ath12k_mac_update_freq_range(ar, reg_cap->low_5ghz_chan,
-						     reg_cap->high_5ghz_chan);
+			ath12k_mac_update_freq_range(ar, freq_low, freq_high);
 			ah->use_6ghz_regd = true;
 		}
 
@@ -10941,17 +10952,21 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->bitrates = ath12k_a_rates;
 			bands[NL80211_BAND_5GHZ] = band;
 
-			if (ar->ab->hw_params->single_pdev_only) {
+			if (ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
-				reg_cap = &ar->ab->hal_reg_cap[phy_id];
+				reg_cap = &ab->hal_reg_cap[phy_id];
 			}
 
+			freq_low = max(reg_cap->low_5ghz_chan,
+				       ab->reg_freq_5ghz.start_freq);
+			freq_high = min(reg_cap->high_5ghz_chan,
+					ab->reg_freq_5ghz.end_freq);
+
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
 
-			ath12k_mac_update_freq_range(ar, reg_cap->low_5ghz_chan,
-						     reg_cap->high_5ghz_chan);
+			ath12k_mac_update_freq_range(ar, freq_low, freq_high);
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 893650f76fb2..e1007b878f91 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -651,6 +651,16 @@ ath12k_reg_update_weather_radar_band(struct ath12k_base *ab,
 	*rule_idx = i;
 }
 
+static void ath12k_reg_update_freq_range(struct ath12k_reg_freq *reg_freq,
+					 struct ath12k_reg_rule *reg_rule)
+{
+	if (reg_freq->start_freq > reg_rule->start_freq)
+		reg_freq->start_freq = reg_rule->start_freq;
+
+	if (reg_freq->end_freq < reg_rule->end_freq)
+		reg_freq->end_freq = reg_rule->end_freq;
+}
+
 struct ieee80211_regdomain *
 ath12k_reg_build_regd(struct ath12k_base *ab,
 		      struct ath12k_reg_info *reg_info, bool intersect)
@@ -704,6 +714,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			max_bw = min_t(u16, reg_rule->max_bw,
 				       reg_info->max_bw_2g);
 			flags = 0;
+			ath12k_reg_update_freq_range(&ab->reg_freq_2ghz, reg_rule);
 		} else if (reg_info->num_5g_reg_rules &&
 			   (j < reg_info->num_5g_reg_rules)) {
 			reg_rule = reg_info->reg_rules_5g_ptr + j++;
@@ -717,6 +728,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
+			ath12k_reg_update_freq_range(&ab->reg_freq_5ghz, reg_rule);
 		} else if (reg_info->is_ext_reg_event &&
 			   reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP] &&
 			(k < reg_info->num_6g_reg_rules_ap[WMI_REG_INDOOR_AP])) {
@@ -724,6 +736,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 			max_bw = min_t(u16, reg_rule->max_bw,
 				       reg_info->max_bw_6g_ap[WMI_REG_INDOOR_AP]);
 			flags = NL80211_RRF_AUTO_BW;
+			ath12k_reg_update_freq_range(&ab->reg_freq_6ghz, reg_rule);
 		} else {
 			break;
 		}
-- 
2.34.1


