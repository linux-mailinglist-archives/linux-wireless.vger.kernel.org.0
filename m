Return-Path: <linux-wireless+bounces-23276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDC9AC07D5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFBE1B622BF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E1286D7A;
	Thu, 22 May 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="anxY/JWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A72857FD;
	Thu, 22 May 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904093; cv=none; b=dGnYXEeBiC8xGAEvswGtpOLd3OxTdJ4lYIug9evWrleU/JSZlsmkbn4RtdrjdIuuQe75fSCcnpwQa+V8FLxzOcwxTphRtY6cjJSpeipeH6IBgKIsNvtHFq3OFkQxgjnHPQUCyrzm7ZdD3mwXNSqaaK1387jkeyBE8hlLEm7/Rqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904093; c=relaxed/simple;
	bh=hLlSo7up4wq29yK6DKIyVjWF2CzHgDO8iAKI9JNIq90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cD9YGkR0toztNGtTwQmFMxbJ/jGSXPxWU1+VaM6RD4FUdbwoFD6hOMba7hWSWgQrPfnq++fb4vgCrTrzqpjxaH9OuuojFoo7ShsfKsDF472v5FP9/bTYJCgL+yEFs32qQHSEy7P1af5hHom2WgI7nSQsVJjR6/SfApXieuqnR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=anxY/JWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7ILm0024842;
	Thu, 22 May 2025 08:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsx1bWlin0V9Zk1+szxP657H3vZZ7I7XQ8QJxWy5tdc=; b=anxY/JWeQTpU5gjW
	S4IzGuyM3WlZqOQr8gFfmpRe3SS2ytYu+tQE1zT6UY40N4EuZCMWLACf2F8YITSk
	0+KM+JRzmc1Vp8Fzi6PsahXt2H9/ze1rwiqoEjnz0l0DAwB27WynS65AiM3xZF0t
	uVXGcsm3E4jCFoofuEkxUYefqXrn4JDbVuFnCt4jeKOM5tKB62o9bJLT/8I21xp8
	2f+P293Kfs+59W2p/AJtsLcicjD3xL3KHesCgAumX424GQuVPrD+nN+LziuMGw00
	UDCbKjw76EHnUi4lLSJF5gKIIKo7OFm5FubVPMNyLxBkPsst2IahisFPLWy01MCZ
	CpQzKA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4wnyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M8siVZ019689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:54:45 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 01:54:42 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 22 May 2025 16:54:10 +0800
Subject: [PATCH ath-next 1/6] wifi: ath12k: parse and save hardware mode
 info from WMI_SERVICE_READY_EXT_EVENTID event for later use
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250522-ath12k-sbs-dbs-v1-1-54a29e7a3a88@quicinc.com>
References: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
In-Reply-To: <20250522-ath12k-sbs-dbs-v1-0-54a29e7a3a88@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kr38PnTRM-StcIIk0mlx85wHseJiBtJn
X-Proofpoint-ORIG-GUID: Kr38PnTRM-StcIIk0mlx85wHseJiBtJn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OSBTYWx0ZWRfXwUOGHX7xF1PZ
 Ny/WBMC3z5GKUDXJllbSevmGlj9T5lvDw/sjjVm7rr7x6F+ERf9RM7Zp74rNiGpZcdXw5TIUEvP
 ilrmTQpGKKCq6Cz1qgIwNd+Hl50doSY9hfulElxbMElnt2tKf/O0ArxEGetMzPQC8TORszWA2X3
 fEh5jIW78DM3ZKQsGukN3qTOm4yiA4FhCqXiFpF9vwG3KpLLYFfdNQ6uAJDWDFXT3xzrKzf9hJT
 G5KYtmZy60GsB5RkzOCOopjurH5+hcxVK0/qENPX7TuzNuQ1gh4bKP9+Q0/vv+dRZo0G5p45nKY
 v9f1xgpyjtoSZ5shJGwQWy8lvsV/aCdwC1+XR0Jl6RMRUk1WqE/l1zzMz+whEY3sQ14vg62LhzR
 0MY+UdKkQQhPwFwrphvqUqlkDPqyEkSJInHpwDf7t3uu7s6eodpM3cG4kPjFdqw4gxDX0ZwM
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682ee655 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=Mw1lerLwwFHbtWIHj9EA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220089

WLAN hardware might support various hardware modes such as DBS (dual
band simultaneously), SBS (single band simultaneously) and DBS_OR_SBS
etc, see enum wmi_host_hw_mode_config_type. Firmware advertises actual
supported modes in WMI_SERVICE_READY_EXT_EVENTID event. For each mode,
firmware advertises frequency range each hardware MAC can operate on.
In MLO case such information is necessary during vdev activation and
link selection (which is done in following patches), so add a new
structure ath12k_svc_ext_info to ath12k_wmi_base, then parse and save
those information to it for later use.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 69 ++++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h | 31 ++++++++++++++++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..056bee8023a085dbc7c9be8177105b66e29eaeed 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4395,6 +4395,7 @@ static int ath12k_wmi_hw_mode_caps_parse(struct ath12k_base *soc,
 static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 				   u16 len, const void *ptr, void *data)
 {
+	struct ath12k_svc_ext_info *svc_ext_info = &soc->wmi_ab.svc_ext_info;
 	struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext = data;
 	const struct ath12k_wmi_hw_mode_cap_params *hw_mode_caps;
 	enum wmi_host_hw_mode_config_type mode, pref;
@@ -4427,8 +4428,11 @@ static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 		}
 	}
 
-	ath12k_dbg(soc, ATH12K_DBG_WMI, "preferred_hw_mode:%d\n",
-		   soc->wmi_ab.preferred_hw_mode);
+	svc_ext_info->num_hw_modes = svc_rdy_ext->n_hw_mode_caps;
+
+	ath12k_dbg(soc, ATH12K_DBG_WMI, "num hw modes %u preferred_hw_mode %d\n",
+		   svc_ext_info->num_hw_modes, soc->wmi_ab.preferred_hw_mode);
+
 	if (soc->wmi_ab.preferred_hw_mode == WMI_HOST_HW_MODE_MAX)
 		return -EINVAL;
 
@@ -4658,6 +4662,65 @@ static int ath12k_wmi_dma_ring_caps(struct ath12k_base *ab,
 	return ret;
 }
 
+static void
+ath12k_wmi_save_mac_phy_info(struct ath12k_base *ab,
+			     const struct ath12k_wmi_mac_phy_caps_params *mac_phy_cap,
+			     struct ath12k_svc_ext_mac_phy_info *mac_phy_info)
+{
+	mac_phy_info->phy_id = __le32_to_cpu(mac_phy_cap->phy_id);
+	mac_phy_info->supported_bands = __le32_to_cpu(mac_phy_cap->supported_bands);
+	mac_phy_info->hw_freq_range.low_2ghz_freq =
+					__le32_to_cpu(mac_phy_cap->low_2ghz_chan_freq);
+	mac_phy_info->hw_freq_range.high_2ghz_freq =
+					__le32_to_cpu(mac_phy_cap->high_2ghz_chan_freq);
+	mac_phy_info->hw_freq_range.low_5ghz_freq =
+					__le32_to_cpu(mac_phy_cap->low_5ghz_chan_freq);
+	mac_phy_info->hw_freq_range.high_5ghz_freq =
+					__le32_to_cpu(mac_phy_cap->high_5ghz_chan_freq);
+}
+
+static void
+ath12k_wmi_save_all_mac_phy_info(struct ath12k_base *ab,
+				 struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext)
+{
+	struct ath12k_svc_ext_info *svc_ext_info = &ab->wmi_ab.svc_ext_info;
+	const struct ath12k_wmi_mac_phy_caps_params *mac_phy_cap;
+	const struct ath12k_wmi_hw_mode_cap_params *hw_mode_cap;
+	struct ath12k_svc_ext_mac_phy_info *mac_phy_info;
+	u32 hw_mode_id, phy_bit_map;
+	u8 hw_idx;
+
+	mac_phy_info = &svc_ext_info->mac_phy_info[0];
+	mac_phy_cap = svc_rdy_ext->mac_phy_caps;
+
+	for (hw_idx = 0; hw_idx < svc_ext_info->num_hw_modes; hw_idx++) {
+		hw_mode_cap = &svc_rdy_ext->hw_mode_caps[hw_idx];
+		hw_mode_id = __le32_to_cpu(hw_mode_cap->hw_mode_id);
+		phy_bit_map = __le32_to_cpu(hw_mode_cap->phy_id_map);
+
+		while (phy_bit_map) {
+			ath12k_wmi_save_mac_phy_info(ab, mac_phy_cap, mac_phy_info);
+			mac_phy_info->hw_mode_config_type =
+					le32_get_bits(hw_mode_cap->hw_mode_config_type,
+						      WMI_HW_MODE_CAP_CFG_TYPE);
+			ath12k_dbg(ab, ATH12K_DBG_WMI,
+				   "hw_idx %u hw_mode_id %u hw_mode_config_type %u supported_bands %u phy_id %u 2 GHz [%u - %u] 5 GHz [%u - %u]\n",
+				   hw_idx, hw_mode_id,
+				   mac_phy_info->hw_mode_config_type,
+				   mac_phy_info->supported_bands, mac_phy_info->phy_id,
+				   mac_phy_info->hw_freq_range.low_2ghz_freq,
+				   mac_phy_info->hw_freq_range.high_2ghz_freq,
+				   mac_phy_info->hw_freq_range.low_5ghz_freq,
+				   mac_phy_info->hw_freq_range.high_5ghz_freq);
+
+			mac_phy_cap++;
+			mac_phy_info++;
+
+			phy_bit_map >>= 1;
+		}
+	}
+}
+
 static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
 					u16 tag, u16 len,
 					const void *ptr, void *data)
@@ -4706,6 +4769,8 @@ static int ath12k_wmi_svc_rdy_ext_parse(struct ath12k_base *ab,
 				return ret;
 			}
 
+			ath12k_wmi_save_all_mac_phy_info(ab, svc_rdy_ext);
+
 			svc_rdy_ext->mac_phy_done = true;
 		} else if (!svc_rdy_ext->ext_hal_reg_done) {
 			ret = ath12k_wmi_ext_hal_reg_caps(ab, len, ptr, svc_rdy_ext);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ac18f75e04492b62594acb159e3b43b81bd6c392..96c31b7820ec14ec8df2fa0d060da6d257d7a083 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2617,6 +2617,8 @@ struct ath12k_wmi_soc_mac_phy_hw_mode_caps_params {
 	__le32 num_chainmask_tables;
 } __packed;
 
+#define WMI_HW_MODE_CAP_CFG_TYPE	GENMASK(27, 0)
+
 struct ath12k_wmi_hw_mode_cap_params {
 	__le32 tlv_header;
 	__le32 hw_mode_id;
@@ -2666,6 +2668,12 @@ struct ath12k_wmi_mac_phy_caps_params {
 	__le32 he_cap_info_2g_ext;
 	__le32 he_cap_info_5g_ext;
 	__le32 he_cap_info_internal;
+	__le32 wireless_modes;
+	__le32 low_2ghz_chan_freq;
+	__le32 high_2ghz_chan_freq;
+	__le32 low_5ghz_chan_freq;
+	__le32 high_5ghz_chan_freq;
+	__le32 nss_ratio;
 } __packed;
 
 struct ath12k_wmi_hal_reg_caps_ext_params {
@@ -5049,6 +5057,27 @@ struct ath12k_wmi_pdev {
 	u32 rx_decap_mode;
 };
 
+struct ath12k_hw_mode_freq_range_arg {
+	u32 low_2ghz_freq;
+	u32 high_2ghz_freq;
+	u32 low_5ghz_freq;
+	u32 high_5ghz_freq;
+};
+
+struct ath12k_svc_ext_mac_phy_info {
+	enum wmi_host_hw_mode_config_type hw_mode_config_type;
+	u32 phy_id;
+	u32 supported_bands;
+	struct ath12k_hw_mode_freq_range_arg hw_freq_range;
+};
+
+#define ATH12K_MAX_MAC_PHY_CAP	8
+
+struct ath12k_svc_ext_info {
+	u32 num_hw_modes;
+	struct ath12k_svc_ext_mac_phy_info mac_phy_info[ATH12K_MAX_MAC_PHY_CAP];
+};
+
 struct ath12k_wmi_base {
 	struct ath12k_base *ab;
 	struct ath12k_wmi_pdev wmi[MAX_RADIOS];
@@ -5066,6 +5095,8 @@ struct ath12k_wmi_base {
 	enum wmi_host_hw_mode_config_type preferred_hw_mode;
 
 	struct ath12k_wmi_target_cap_arg *targ_cap;
+
+	struct ath12k_svc_ext_info svc_ext_info;
 };
 
 struct wmi_pdev_set_bios_interface_cmd {

-- 
2.25.1


