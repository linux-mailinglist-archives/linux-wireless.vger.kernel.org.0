Return-Path: <linux-wireless+bounces-6898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF28B2CF9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1068C285B3F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 22:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28D156675;
	Thu, 25 Apr 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FfKSADMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F6155A5B
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083561; cv=none; b=tHoUiqZtBvyyhCcYNLTsDjbeTvWiTPLBNwFNjHdqkpXylvSSb1HF2d/Z9s3Dar6z+tMzdoG/XXvscIVaje9VlNTc7CE5NmMu+gDyULvadxyI1gJvRMUjTLnxSHUbP93EYeEuU1NAvx9d4LEuQDxNXlxhptRUbBvVAxkj6YZW3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083561; c=relaxed/simple;
	bh=H7+sZ+XD7V4SLl4Id+0tFvNfdSKvCECmmon0cfdwj0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODpbKEeRo+XmqDIHx+57LdlKRcSjxaNC+o9kyCNgPa3ChEaunrv3KHRazuprrviWQl1XvemrBw6E9Rb01a/XivMA4lrDnHE5YROqSBpgNFCa2tbURXVRf9ewSVp0IYHWByny3IF/sb8hQnB84I18kk2mxpKkT/9OuuYwuplRbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FfKSADMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PLsoe9010950;
	Thu, 25 Apr 2024 22:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=gYA48yP0pYr24HlnDPgA
	VXVimmyJ5zDsBA3shvrTdIU=; b=FfKSADMoLiw8PBLtnlQGxnUewOXnR4CL90+I
	6/mSHTfpQU9hnjWCd9K1hD3z69jB7KlFttRncJZ5/mX7wQ2iN+a6Kk51pVgN3GPL
	c6dBO5rvpj6w/YxHIuKuLImkRL79c/aej3jZ4wHv3NjEmXUjFEH8eN+uBLCMhAaA
	2xVjrc3x6bslUCZcRjKcY+z9dfgxQ3xr8qSuyF/VeXt+vhU4+F6+wZdXhZ/gFxnN
	gk28/KZuiuvDQgAGasRcEDw8yFt2l6iUwyVs3xge6doXf1oDHVBsNZX1DKUFd4Oy
	ZeBf9iiWGoG/RWrRN6Sq1O9bsHRA0Yk6vvloll9jIn8YhbJQYg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenpbsaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PMJEAR011698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 22:19:14 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 15:19:14 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V4 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Date: Thu, 25 Apr 2024 15:19:02 -0700
Message-ID: <20240425221902.11553-7-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
References: <20240425221902.11553-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GyP6NTJiGWdd5VgK9nTmcBc5Tiv2eNgc
X-Proofpoint-ORIG-GUID: GyP6NTJiGWdd5VgK9nTmcBc5Tiv2eNgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250163

Parse SMPS configuration from IEs and configure. Without this,
SMPS is not enabled for 6 GHz band. This is disabled for
WCN7850 as hardware does not support it.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  3 +++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 drivers/net/wireless/ath/ath12k/mac.c | 26 ++++++++++++++++++--------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index f4c827015821..a53643931c0f 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -926,6 +926,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_sta_ps = false,
 
 		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = true,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1001,6 +1002,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_sta_ps = true,
 
 		.acpi_guid = &wcn7850_uuid,
+		.supports_dynamic_smps_6ghz = false,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1071,6 +1073,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_sta_ps = false,
 
 		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 3f450ee93f34..e040c3925074 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -215,6 +215,7 @@ struct ath12k_hw_params {
 	bool supports_sta_ps;
 
 	const guid_t *acpi_guid;
+	bool supports_dynamic_smps_6ghz;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d4bae41a32d4..b81475eb0e9e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2087,12 +2087,17 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 }
 
 static int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
+				     const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
 				     int *smps)
 {
-	if (!ht_cap->ht_supported)
+	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
 		return -EOPNOTSUPP;
 
-	*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
+	if (ht_cap->ht_supported)
+		*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
+	else
+		*smps = le16_get_bits(he_6ghz_capa->capa,
+				      IEEE80211_HE_6GHZ_CAP_SM_PS);
 
 	if (*smps >= ARRAY_SIZE(ath12k_smps_map))
 		return -EINVAL;
@@ -2103,10 +2108,11 @@ static int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
 static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 				     struct ath12k_wmi_peer_assoc_arg *arg)
 {
+	const struct ieee80211_he_6ghz_capa *he_6ghz_capa = &sta->deflink.he_6ghz_capa;
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
 	int smps;
 
-	if (ath12k_get_smps_from_capa(ht_cap, &smps))
+	if (ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps))
 		return;
 
 	switch (smps) {
@@ -2580,11 +2586,12 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
 
 static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
 				  const u8 *addr,
-				  const struct ieee80211_sta_ht_cap *ht_cap)
+				  const struct ieee80211_sta_ht_cap *ht_cap,
+				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa)
 {
 	int smps, ret = 0;
 
-	ret = ath12k_get_smps_from_capa(ht_cap, &smps);
+	ret = ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps);
 	if (ret < 0)
 		return ret;
 
@@ -2637,7 +2644,8 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	}
 
 	ret = ath12k_setup_peer_smps(ar, arvif, bss_conf->bssid,
-				     &ap_sta->deflink.ht_cap);
+				     &ap_sta->deflink.ht_cap,
+				     &ap_sta->deflink.he_6ghz_capa);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -3944,7 +3952,8 @@ static int ath12k_station_assoc(struct ath12k *ar,
 		return 0;
 
 	ret = ath12k_setup_peer_smps(ar, arvif, sta->addr,
-				     &sta->deflink.ht_cap);
+				     &sta->deflink.ht_cap,
+				     &sta->deflink.he_6ghz_capa);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -8766,7 +8775,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 * for each band for a dual band capable radio. It will be tricky to
 	 * handle it when the ht capability different for each band.
 	 */
-	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
+	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS ||
+	    (ar->supports_6ghz && ab->hw_params->supports_dynamic_smps_6ghz))
 		wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
 
 	wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
-- 
2.17.1


