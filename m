Return-Path: <linux-wireless+bounces-21735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D221A93C35
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED12189A9C1
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6F21D59B;
	Fri, 18 Apr 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="elyiEmb5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF821C9F1
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998530; cv=none; b=pGGFXhBI+CZtQ8wRk7fWJ2C60q3pbGUZVLiMmWhY6TI2SpvgqWMNvTz/eUl6+i6z3CbeUnNWDc41qnim3qb2d4AUOd3xG26j8ynfJsaw/+wa4xoyQBNU6dX0z6pIZ+T3DlhM3aoGiEmww6LjLRZg3VbcNNvQyQH1a4gSutvG+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998530; c=relaxed/simple;
	bh=XD2azIsehobEjiDLoTL3WqnTtj41+xWT7cVzAgxmxDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My2Au0fZVOLhCjQl/y23DKk2GCDPqELX+AWps0Q0rk6pzOScA+LcVtexwJfwqUyPbJcmXrzYT6iQ/4+X19BGfxxGauABP9Xt0YltbH9Nvs4sGBU2rgH3rrEgG87aOw1FxCFDvsi4rtP20Au1Qy4nRipDHat6CUwQCIpD1dMmFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=elyiEmb5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IFH9NU001246;
	Fri, 18 Apr 2025 17:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	enOXKCRiQ/RAPEus2Wh7QwXRqngl4SRp7MBKy62XLEg=; b=elyiEmb5QeFv4TnA
	GSvZP0r6ZjpP41BvfkCUUeGYVCzM4CvV1Uy+jPvQDRy4M6al3yGTQhmo/XTfaERN
	GONGDhT2reC7m/+U3l0bA8rZdwzXa1Vm/htIUUESBrEOCyGCQxfF6bwIuyUtEjPp
	dWvmbupSCvpFYmh76rHD1GjoV1mQ/QVrUk2d5Ib6uSzj7CUw+gXbw9fgwpCPbQjb
	WZ0xf0n3n3m9N8i3dOQ3wdtTqFZJ2SM8NwCoMZsAyMq2aOUZUGAWBsGIDwB0Hf95
	UyaJK160rTUi7OkFgK6B5Tu3LKg2H7cz8mcR13uy861ZGJrs/R1zqeWT0p+72h4g
	Yf1QpQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvjjuud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53IHmhDJ025065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 17:48:43 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 18 Apr 2025 10:48:42 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH V13 2/9] wifi: ath12k: push EHT MU-MIMO params to hardware
Date: Fri, 18 Apr 2025 10:48:11 -0700
Message-ID: <20250418174818.3336510-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=6802907c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=uoU_VXRAPQDrZd00miQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: l3s9DlGKtcV8bBL22iUuTqc9EBocUBvi
X-Proofpoint-ORIG-GUID: l3s9DlGKtcV8bBL22iUuTqc9EBocUBvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180133

Currently, only the EHT IE in management frames is updated with
respect to MU-MIMO configurations, but this change is not
reflected in the hardware. Add support to propagate MU-MIMO
configurations to the hardware as well for AP mode. Similar
support for STA mode will be added in future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 58 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 21 ++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8d7c210bc160..8ef52ba86056 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3234,6 +3234,58 @@ static int ath12k_mac_vif_recalc_sta_he_txbf(struct ath12k *ar,
 	return 0;
 }
 
+static int ath12k_mac_set_eht_txbf_conf(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k *ar = arvif->ar;
+	u32 param = WMI_VDEV_PARAM_SET_EHT_MU_MODE;
+	u32 value = 0;
+	int ret;
+	struct ieee80211_bss_conf *link_conf;
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab, "unable to access bss link conf in eht txbf conf\n");
+		return -ENOENT;
+	}
+
+	if (!link_conf->eht_support)
+		return 0;
+
+	if (link_conf->eht_su_beamformer) {
+		value |= u32_encode_bits(EHT_SU_BFER_ENABLE, EHT_MODE_SU_TX_BFER);
+		if (link_conf->eht_mu_beamformer &&
+		    ahvif->vdev_type == WMI_VDEV_TYPE_AP)
+			value |= u32_encode_bits(EHT_MU_BFER_ENABLE,
+						 EHT_MODE_MU_TX_BFER) |
+				 u32_encode_bits(EHT_DL_MUOFDMA_ENABLE,
+						 EHT_MODE_DL_OFDMA_MUMIMO) |
+				 u32_encode_bits(EHT_UL_MUOFDMA_ENABLE,
+						 EHT_MODE_UL_OFDMA_MUMIMO);
+	}
+
+	if (ahvif->vif->type != NL80211_IFTYPE_MESH_POINT) {
+		value |= u32_encode_bits(EHT_DL_MUOFDMA_ENABLE, EHT_MODE_DL_OFDMA) |
+			 u32_encode_bits(EHT_UL_MUOFDMA_ENABLE, EHT_MODE_UL_OFDMA);
+
+		if (link_conf->eht_80mhz_full_bw_ul_mumimo)
+			value |= u32_encode_bits(EHT_UL_MUMIMO_ENABLE, EHT_MODE_MUMIMO);
+
+		if (link_conf->eht_su_beamformee)
+			value |= u32_encode_bits(EHT_SU_BFEE_ENABLE,
+						 EHT_MODE_SU_TX_BFEE);
+	}
+
+	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, param, value);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set vdev %d EHT MU mode: %d\n",
+			    arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static u32 ath12k_mac_ieee80211_sta_bw_to_wmi(struct ath12k *ar,
 					      struct ieee80211_link_sta *link_sta)
 {
@@ -3962,6 +4014,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 				ath12k_warn(ar->ab,
 					    "failed to set HE TXBF config for vdev: %d\n",
 					    arvif->vdev_id);
+
+			ret = ath12k_mac_set_eht_txbf_conf(arvif);
+			if (ret)
+				ath12k_warn(ar->ab,
+					    "failed to set EHT TXBF config for vdev: %d\n",
+					    arvif->vdev_id);
 		}
 		ath12k_control_beaconing(arvif, info);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 804992bb055c..c661bfa79ea0 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1159,6 +1159,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_BSS_COLOR,
 	WMI_VDEV_PARAM_SET_HEMU_MODE,
 	WMI_VDEV_PARAM_HEOPS_0_31 = 0x8003,
+	WMI_VDEV_PARAM_SET_EHT_MU_MODE = 0x8005,
 };
 
 enum wmi_tlv_peer_flags {
@@ -3113,6 +3114,26 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
 #define HE_MU_BFER_ENABLE	1
 #define HE_SU_BFER_ENABLE	1
 
+#define EHT_MODE_SU_TX_BFEE		BIT(0)
+#define EHT_MODE_SU_TX_BFER		BIT(1)
+#define EHT_MODE_MU_TX_BFEE		BIT(2)
+#define EHT_MODE_MU_TX_BFER		BIT(3)
+#define EHT_MODE_DL_OFDMA		BIT(4)
+#define EHT_MODE_UL_OFDMA		BIT(5)
+#define EHT_MODE_MUMIMO			BIT(6)
+#define EHT_MODE_DL_OFDMA_TXBF		BIT(7)
+#define EHT_MODE_DL_OFDMA_MUMIMO	BIT(8)
+#define EHT_MODE_UL_OFDMA_MUMIMO	BIT(9)
+
+#define EHT_DL_MUOFDMA_ENABLE    1
+#define EHT_UL_MUOFDMA_ENABLE    1
+#define EHT_DL_MUMIMO_ENABLE     1
+#define EHT_UL_MUMIMO_ENABLE     1
+#define EHT_MU_BFEE_ENABLE       1
+#define EHT_SU_BFEE_ENABLE       1
+#define EHT_MU_BFER_ENABLE       1
+#define EHT_SU_BFER_ENABLE       1
+
 #define HE_VHT_SOUNDING_MODE_ENABLE		1
 #define HE_SU_MU_SOUNDING_MODE_ENABLE		1
 #define HE_TRIG_NONTRIG_SOUNDING_MODE_ENABLE	1
-- 
2.34.1


