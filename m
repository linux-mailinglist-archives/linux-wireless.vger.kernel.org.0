Return-Path: <linux-wireless+bounces-2636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2924383FEB9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DEB23798
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2834E1DD;
	Mon, 29 Jan 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SKMVKTAb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483284D112
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511477; cv=none; b=Rq/QuQIkpKPs3htNRHzLIfAkkOQ3sCDoOUx7mpVjqPu58eOMsZn33Ha5bWl/Z6fVi7ek3MDdabUkFGZ+vCKCr+l3bUXuK4EHmz4BssbZ4knVcz1TsCO+gdN+93eEuhh5jcU8WrnhehYxNSUZxJwwTnn3h8Unc7+Lvn6e6WGpsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511477; c=relaxed/simple;
	bh=GrqdCKchXqbaFsVkEXjfCuOKbAr0qTJTRxD3zN2v68E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEOwMd1MoDsTt1rSCeZymPiX6D6U7A2R3OBoMWcvb8J3PC3/Om5W9u1xrv3J8XZLTwvj3M9kx2ADxoeF6O2fsvA05FcqksyuzZjm/91PxlgREvnxZY6eTtrT9pXDmqSjJG36FNZY52EY4Sl6sUjv+En52VOnh4X9wcVCk6wOwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SKMVKTAb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T3VFGp032499;
	Mon, 29 Jan 2024 06:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fpgZvJJ3UhK+6M5+KnAIKLD9Bzn4RZG+3OKQBYn0IhM=; b=SK
	MVKTAbwjCsLE52aE3ylor9RMNGZ11zOD2Y0fLxhbPH5NF3VechTOKbBpY0QN8wws
	ZArqAo5GVbdcOWIsC5FV8gLqInRtWOk1alo9MkaOocy/CMVPPJIeMn7JMbYVl1LV
	EYLqMqOj5hWaQM7n5++Gi2DRBYTQ4QPtyAI2LAwlNAFPRh4ITVwy3X95zVmpwC65
	b+KV1CrIxlHqnxyirK/YvvYYe6Y6BS+WQac2keoTkeop+kGP82s8zLoydTlohY1x
	0G+WmcZv2kgT3FTvGyIVwuro5U4HfPNMdidBGGAwCsm/GGVdnbJ4bvnMoSc0HvMC
	2edq05Mm7yPepNPa9W6A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx275gf6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6voM1008765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:50 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:49 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 02/13] wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID
Date: Mon, 29 Jan 2024 12:27:13 +0530
Message-ID: <20240129065724.2310207-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aV2fiIAi25raEk3Wonmw5PRQJHmw9GCO
X-Proofpoint-GUID: aV2fiIAi25raEk3Wonmw5PRQJHmw9GCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 mlxlogscore=863 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Currently while fetching for pdev id from WMI_SERVICE_READY_EXT_EVENTID
we consider 32 bit pdev_id in ath12k_wmi_caps_ext_params structure. But
Firmware sends lower 16 bit for pdev id along with higher 16 bit for
hw_link_id. Due to this wrong pdev id is fetched. This wrong pdev id
when used for WMI commands leads to Firmware crash.

Hence fetch the correct pdev id considering only the lower 16 bits.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c |  9 +++---
 drivers/net/wireless/ath/ath12k/wmi.h | 44 ++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 5f1cce16589f..487ca82bd17d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -493,13 +493,13 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 
 	mac_caps = wmi_mac_phy_caps + phy_idx;
 
-	pdev->pdev_id = le32_to_cpu(mac_caps->pdev_id);
+	pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	pdev_cap->supported_bands |= le32_to_cpu(mac_caps->supported_bands);
 	pdev_cap->ampdu_density = le32_to_cpu(mac_caps->ampdu_density);
 
 	fw_pdev = &ab->fw_pdev[ab->fw_pdev_count];
 	fw_pdev->supported_bands = le32_to_cpu(mac_caps->supported_bands);
-	fw_pdev->pdev_id = le32_to_cpu(mac_caps->pdev_id);
+	fw_pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	fw_pdev->phy_id = le32_to_cpu(mac_caps->phy_id);
 	ab->fw_pdev_count++;
 
@@ -4215,7 +4215,7 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 		for (i = 0; i < ab->fw_pdev_count; i++) {
 			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
 
-			if (fw_pdev->pdev_id == le32_to_cpu(caps->pdev_id) &&
+			if (fw_pdev->pdev_id == ath12k_wmi_caps_ext_get_pdev_id(caps) &&
 			    fw_pdev->phy_id == le32_to_cpu(caps->phy_id)) {
 				bands = fw_pdev->supported_bands;
 				break;
@@ -4272,7 +4272,8 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 			return 0;
 	} else {
 		for (i = 0; i < ab->num_radios; i++) {
-			if (ab->pdevs[i].pdev_id == le32_to_cpu(caps->pdev_id))
+			if (ab->pdevs[i].pdev_id ==
+			    ath12k_wmi_caps_ext_get_pdev_id(caps))
 				break;
 		}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index d8481c710021..06b931222321 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2542,9 +2542,17 @@ struct ath12k_wmi_hw_mode_cap_params {
 
 #define WMI_MAX_HECAP_PHY_SIZE                 (3)
 
+/* pdev_id is present in lower 16 bits of pdev_and_hw_link_ids in
+ * ath12k_wmi_mac_phy_caps_params & ath12k_wmi_caps_ext_params.
+ *
+ * hw_link_id is present in higher 16 bits of pdev_and_hw_link_ids.
+ */
+#define WMI_CAPS_PARAMS_PDEV_ID		GENMASK(15, 0)
+#define WMI_CAPS_PARAMS_HW_LINK_ID	GENMASK(31, 16)
+
 struct ath12k_wmi_mac_phy_caps_params {
 	__le32 hw_mode_id;
-	__le32 pdev_id;
+	__le32 pdev_and_hw_link_ids;
 	__le32 phy_id;
 	__le32 supported_flags;
 	__le32 supported_bands;
@@ -2636,13 +2644,7 @@ struct wmi_service_ready_ext2_event {
 
 struct ath12k_wmi_caps_ext_params {
 	__le32 hw_mode_id;
-	union {
-		struct {
-			__le16 pdev_id;
-			__le16 hw_link_id;
-		} __packed ath12k_wmi_pdev_to_link_map;
-		__le32 pdev_id;
-	};
+	__le32 pdev_and_hw_link_ids;
 	__le32 phy_id;
 	__le32 wireless_modes_ext;
 	__le32 eht_cap_mac_info_2ghz[WMI_MAX_EHTCAP_MAC_SIZE];
@@ -4921,4 +4923,30 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
 
+static inline u32
+ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids, WMI_CAPS_PARAMS_PDEV_ID);
+}
+
+static inline u32
+ath12k_wmi_caps_ext_get_hw_link_id(const struct ath12k_wmi_caps_ext_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids, WMI_CAPS_PARAMS_HW_LINK_ID);
+}
+
+static inline u32
+ath12k_wmi_mac_phy_get_pdev_id(const struct ath12k_wmi_mac_phy_caps_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids,
+			     WMI_CAPS_PARAMS_PDEV_ID);
+}
+
+static inline u32
+ath12k_wmi_mac_phy_get_hw_link_id(const struct ath12k_wmi_mac_phy_caps_params *param)
+{
+	return le32_get_bits(param->pdev_and_hw_link_ids,
+			     WMI_CAPS_PARAMS_HW_LINK_ID);
+}
+
 #endif
-- 
2.34.1


