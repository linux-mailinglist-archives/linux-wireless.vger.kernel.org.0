Return-Path: <linux-wireless+bounces-6790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE38B146D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F8B1C22899
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F9143895;
	Wed, 24 Apr 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JNioBBA+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEB142906
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990021; cv=none; b=EK7ghp/lmusMuT+MeStq/3DyELG9R8ZYvnsH8mZi7sCGchrTBhvO8XRZd5VAx7VpMbWLmfTBJtrVGKPdYR0LotmbWZ/0Gg0wi6d/NDIbCzQoseoEcgl0wN0Zw4yz2Qkd1z+CsSStVSeuFs3xyZTRbQX+fSx9a8LbYDuttDbRdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990021; c=relaxed/simple;
	bh=oQig/eD8QPL55HukoOxG+DBaSbCGXiiQ8SABE2H4C4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyO3zi7x6c/1VEWXdVfGeLZGsnOp/oDP5pO2yAC0Z+YmRuCds0GXmseOeVAfHERQwKTCa0n9pkW9D+sRB1FXZr4avDrfv7Ov+kGCaCbrBJXA/rR9V70QpOOAqfz6shPOqpTJgiqvX9pS/jzkOVB7boM95ajpIkVv8uczJy4WnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JNioBBA+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OImfla019543;
	Wed, 24 Apr 2024 20:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=3B3aPt2FXSfCvhFuFohM
	EfZrXfp0i/qjmzYlwVIDU50=; b=JNioBBA+Iinn08+YgeX9ggUdQAxR2klEUZTM
	21QPMHSBR0VXMiSEVfVXfGScoMRtucltFGjRGhOQkCj4Dp5BUhq7AXsseMBDXegT
	wRhnfABxXfTuSzzk3ujt+WhiUXs1LZkAHbLYgwsVGVHs7TlY9EEFhbOkASVycmvp
	mrLxLqrKr++wbuT94hT65aUn0yn1DmaKfJgyrQsYl2dIl5xIhSPbJGlahPDsJ5Vd
	CmHkmwgrqdFBGnGE3bNcGSM2xOp2xiwXhU3WgvEm+JjKoJ5BIYHjhDQocEAaOU4r
	0Y+lFxKtlyubLUdH9cB6OV+BIJZHDYWSA+gbtDSyZp6eRsKiGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gt1v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OKKBN2004271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:20:11 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 13:20:10 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v3 03/10] wifi: ath12k: push EHT MU-MIMO params from hostapd to hardware
Date: Wed, 24 Apr 2024 13:19:52 -0700
Message-ID: <20240424201959.935-4-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424201959.935-1-quic_pradeepc@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QPF6FsZ8PjSoQbnUsTJQlz3YcnFfy7EQ
X-Proofpoint-ORIG-GUID: QPF6FsZ8PjSoQbnUsTJQlz3YcnFfy7EQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240101

Currently, only the EHT IE in management frames is updated with
respect to MU-MIMO configurations, but this change is not
reflected in the hardware. Add support to propagate MU-MIMO
configurations to the hardware as well for AP mode. Similar
support for STA mode will be added in future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 50 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 21 +++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2bcc0e12a54f..d7844709fbf8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2630,6 +2630,50 @@ static int ath12k_mac_vif_recalc_sta_he_txbf(struct ath12k *ar,
 	return 0;
 }
 
+static int ath12k_mac_set_eht_txbf_conf(struct ath12k_vif *arvif)
+{
+	u32 param = WMI_VDEV_PARAM_SET_EHT_MU_MODE;
+	struct ath12k *ar = arvif->ar;
+	u32 value = 0;
+	int ret;
+
+	if (!arvif->vif->bss_conf.eht_support)
+		return 0;
+
+	if (arvif->vif->bss_conf.eht_su_beamformer) {
+		value |= u32_encode_bits(EHT_SU_BFER_ENABLE, EHT_MODE_SU_TX_BFER);
+		if (arvif->vif->bss_conf.eht_mu_beamformer &&
+		    arvif->vdev_type == WMI_VDEV_TYPE_AP)
+			value |= u32_encode_bits(EHT_MU_BFER_ENABLE,
+						 EHT_MODE_MU_TX_BFER) |
+				 u32_encode_bits(EHT_DL_MUOFDMA_ENABLE,
+						 EHT_MODE_DL_OFDMA_MUMIMO) |
+				 u32_encode_bits(EHT_UL_MUOFDMA_ENABLE,
+						 EHT_MODE_UL_OFDMA_MUMIMO);
+	}
+
+	if (arvif->vif->type != NL80211_IFTYPE_MESH_POINT) {
+		value |= u32_encode_bits(EHT_DL_MUOFDMA_ENABLE, EHT_MODE_DL_OFDMA) |
+			 u32_encode_bits(EHT_UL_MUOFDMA_ENABLE, EHT_MODE_UL_OFDMA);
+
+		if (arvif->vif->bss_conf.eht_80mhz_full_bw_ul_mumimo)
+			value |= u32_encode_bits(EHT_UL_MUMIMO_ENABLE, EHT_MODE_MUMIMO);
+
+		if (arvif->vif->bss_conf.eht_su_beamformee)
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
 static void ath12k_bss_assoc(struct ath12k *ar,
 			     struct ath12k_vif *arvif,
 			     struct ieee80211_bss_conf *bss_conf)
@@ -3014,6 +3058,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
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
index 03aab0531aa4..161e0ab5efe8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1138,6 +1138,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_BSS_COLOR,
 	WMI_VDEV_PARAM_SET_HEMU_MODE,
 	WMI_VDEV_PARAM_HEOPS_0_31 = 0x8003,
+	WMI_VDEV_PARAM_SET_EHT_MU_MODE = 0x8005,
 };
 
 enum wmi_tlv_peer_flags {
@@ -2985,6 +2986,26 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
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
2.17.1


