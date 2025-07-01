Return-Path: <linux-wireless+bounces-24694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B635AEEBC8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6770C1BC502C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908E1C5F35;
	Tue,  1 Jul 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mTYMx0zX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522519047A
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331869; cv=none; b=mhn6Fu8Znf0Uv/1QCj2Az9Gn310bBKbG0hA4GRYIkVIf9Sv2rvrrbpB1yt1klBgd2clkPvZ7IsZ7KZ6IFr0L7vUeato0Ihw+ruJLncCfKEEa3cdk7myRczIDSRd+tpIds3gDYQ4SY0AlZTh/FFiEVEj2Ep9vDT3uIZJYtHGqIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331869; c=relaxed/simple;
	bh=XxlXwgW2xfrJQp7qgC13lEVIi0L9q2Kukk/h3rmV2QE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqAM59Zydw3jLl2hKdYHhR5ogDvclSmQMFfgNx5HaSoZHF7YM1IzNgPh5w/0IAbgbQHffLmbA1fPaA0GoWZnQ45xPT+Y+fqoXnpAqWOeMUvi6dG7SwqkklaJA+1kL4xraQeNiT55gtAucK3lGkhVs5wdSS6iyj7pYWRq/CYBm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mTYMx0zX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UG3KWG025098;
	Tue, 1 Jul 2025 01:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYhakEx2zowFy5pLFMo6DRsA5DvL2ztWhBm15uMJZ6o=; b=mTYMx0zX5Mcppop+
	lIY4oCF9Y6k8wp5Hfsn/Yg3EGxCawixObWddEfgKKbhVmsp7PI7CtgtAUN4eTWRp
	2ZNghpy+dF3di79Km5AOluaMSgybNMtgd0AALEwi+yx6bMyzo/g52gSo78B4bc6K
	/0hRojUw2gqwmQAAFP+AGNc1B/8bgCbKKLhcH+kYIGdEp0L9v9cDN19H5Ki2orXS
	MKlMOYpxteb0DHXdLCDZEI0F2uQL79h4otlaM1M9Tv4Ez5SOwIrsMrFwAS1S67i9
	3bz7S4peeYzRfD1pV1B5b45wqaeiYQCCKlIejrXQBURY5oeK3FeZ0KDDdgmL0myo
	DHqtsg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j801xgma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 01:04:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56114Mfd012851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 01:04:22 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 18:04:22 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
Subject: [PATCH ath-next V15 2/9] wifi: ath12k: push EHT MU-MIMO params to hardware
Date: Mon, 30 Jun 2025 18:04:01 -0700
Message-ID: <20250701010408.1257201-3-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C4lxOms2ufpbnavROp88qL9ruPz5t-BJ
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68633417 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=uoU_VXRAPQDrZd00miQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: C4lxOms2ufpbnavROp88qL9ruPz5t-BJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAwMyBTYWx0ZWRfX1P1gt6ggas9r
 LCp56qOrITArxZA2MLca8NzGudqhnZmVlQROicYetdDF8gHcbz9u9ut80CzivN5Pmd0HgLx++Hn
 YJS2LAFEu/LcIgCuq/k3MheRFJvJMJsa+JhEoU3fDUoXVJLJWNrlVzXH11JmwRYVRcYiITZ1l76
 kL4yRssreZmK0rIfRy0J1ALvV+q5LLiN/INmdou/dOO8UmKf0epLGdY6xP4h5NAJJRLzFMHGkQj
 95GDGJhSnWtk57/yeCIzvVrOAmub6PqYFfoTo6J7UeCmbCInvgS2zpccTn9h42xTimcnxcTAJwR
 Xpd3VzvGD45toOSiTrPpS9dV6ITYB2vmdbM+H1RdJGWqm05eucTCFGqaTGk2G2+yVcuXUGekt1E
 dfzpIRz0LgmXuHVagkwZ28dwW6al6LRtl5L3KjcSvpoEGrMeCYHMkwjSUpbIAOyQICT8BffB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010003

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
index c81cecb01c06..811b44c703b4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3279,6 +3279,58 @@ static int ath12k_mac_vif_recalc_sta_he_txbf(struct ath12k *ar,
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
@@ -4018,6 +4070,12 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
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
index 07cba3997e75..0964ca03069a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1178,6 +1178,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_BSS_COLOR,
 	WMI_VDEV_PARAM_SET_HEMU_MODE,
 	WMI_VDEV_PARAM_HEOPS_0_31 = 0x8003,
+	WMI_VDEV_PARAM_SET_EHT_MU_MODE = 0x8005,
 };
 
 enum wmi_tlv_peer_flags {
@@ -3153,6 +3154,26 @@ struct ath12k_wmi_rx_reorder_queue_remove_arg {
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
2.43.0


