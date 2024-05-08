Return-Path: <linux-wireless+bounces-7352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4588D8C0345
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15771F226C1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5A12BE90;
	Wed,  8 May 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V2lygCDF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529B1C6AD
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189843; cv=none; b=MDr5srKDBCHAlDXvnzpiIm2oIIibka1w1HT8Kvn8khmQ4Wg/0yc2MReIODuGQX9jiU9XG48DQUMVybkVTh5NxVkuCyUguwXCtU7FSdnFvM74/NGqaWBU/4myapTCrZi3L+LQ/UfWKKHj6VD1c0+A1SOCxE7JO/8gneAGm1iU8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189843; c=relaxed/simple;
	bh=ThtgpiRQ5uAD87e9n25yU9I9zzOThrvqET74F+pTCts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8NqpYnumRlqKslYaRn0VFG87pqbQLdDPO8FUfZ0KwbP0XHBsyrOl3ok/pRLJ/l+USO1sE9OSJSniRKZfGAQduBjEFZHukzkMpNnOqx6nlRKGw5WQqfTLiweKZXiFoQRmnf0JsN1jA1ScPARkXO2rTjAMtA2ZP3cXsnkv1cSI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V2lygCDF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448CXAGi005881;
	Wed, 8 May 2024 17:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=rhapiwCVx2G2KemR/q6R
	dAevnnhJZmh+wiKrxjk+1e8=; b=V2lygCDFGX6I3KoImcVeWyPCXHKTzpeo5h4U
	/FYTIRVKajl1j+H9SzUmekdy2pB1wgKQ6l60eoTCevNZ2L6X0VkPZyNu+R3aHy2q
	ZkYGTQY/ppgnJ43ss47+UdUP9ZnbN5EXfOO8hZuE/vUELHr79Q5fmsNgE4h76Xxs
	q69f2I1fB+vnbLnz9U84ZDwzTGY6/edSYsPyakfiqz1fKNxhFpTCuWYFFMZDaejN
	VBEEqbGA8/5OmAvnyBylFKHxEQCgP/Z3tbXVQnyosd2ddXex47KJ0ke4aUleoxVo
	F1e6r/dhNwn3+5BIcEjSTvYBNTWfHYjqmAeizyjsM3Sh+sOW3Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09gegrgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 17:37:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 448Hb8xK018349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 May 2024 17:37:08 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 May 2024 10:37:08 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V5 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Date: Wed, 8 May 2024 10:36:55 -0700
Message-ID: <20240508173655.22191-7-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: HdlgQXtKpO68Qq95Mgr01Tc_AYPBlltA
X-Proofpoint-ORIG-GUID: HdlgQXtKpO68Qq95Mgr01Tc_AYPBlltA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080128

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
index 0e9b6b7b83d7..ea0a9ccc8e92 100644
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
@@ -8777,7 +8786,8 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
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


