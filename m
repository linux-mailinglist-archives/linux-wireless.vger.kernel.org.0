Return-Path: <linux-wireless+bounces-453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E88065D6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 04:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2251C21129
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EBBDF57;
	Wed,  6 Dec 2023 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BL9Txwsh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0EB1B9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 19:49:50 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B63YxKR015921;
	Wed, 6 Dec 2023 03:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=EzrO/boPUG4pOEYl4jPoR67XLEtwBngVvECwHVGs4Yk=;
 b=BL9TxwshPVO+wzf5Qah/No8KnsHwtSXmhjVZX276ampVFiXi+K8+Zo9KF2y+IPuEAx4a
 zfuAojr7Y4cFJGqZeS1bhrmIS0eHlnuUHvZLMpgxhsRCB41kseqQSCXQhD1EeNIA+ts4
 +98V1wCa1O0jBIoXTBlphPg3lo2yK1HDd67lVCF6HG6F8ZMdDcl7P4X4dyHa5Ad5dXhc
 Gz5qtW5psDP+crftOQMgYwz5R0N5wkOsHnsV5jyqYGLbtNd/lL3H7/id06eVeP/pZ93S
 cf6NU+xWmgRc9eMxL1JIDfv8eP7T6KXm+hU1P5V68rSFdTbIq5ee9vkwnqvANEtMG8ag wQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd1wgff9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 03:49:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B63nkEd001379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 03:49:46 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 19:49:44 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: Refactor MAC setup channel helper function
Date: Wed, 6 Dec 2023 09:19:19 +0530
Message-ID: <20231206034920.1037449-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: s_Mdv6sNQNUOV0lVx21eMEna8lxLLAqH
X-Proofpoint-ORIG-GUID: s_Mdv6sNQNUOV0lVx21eMEna8lxLLAqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=646 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060030

Currently, the MAC setup helper function is accessing the mac80211 hw
data. In the future, to support single/multi link operation, need to
decouple the mac80211 hw data from this helper function so that it can be
easy to scale these functions to support single/multi link operations. So
remove the mac80211 hw access from the ath12k_mac_setup_channels_rates()
helper function.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a110119ad701..be3ef388e9aa 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7158,9 +7158,9 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
 }
 
 static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
-					   u32 supported_bands)
+					   u32 supported_bands,
+					   struct ieee80211_supported_band *bands[])
 {
-	struct ieee80211_hw *hw = ar->hw;
 	struct ieee80211_supported_band *band;
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
 	void *channels;
@@ -7186,7 +7186,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		band->channels = channels;
 		band->n_bitrates = ath12k_g_rates_size;
 		band->bitrates = ath12k_g_rates;
-		hw->wiphy->bands[NL80211_BAND_2GHZ] = band;
+		bands[NL80211_BAND_2GHZ] = band;
 
 		if (ar->ab->hw_params->single_pdev_only) {
 			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2G_CAP);
@@ -7213,7 +7213,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			hw->wiphy->bands[NL80211_BAND_6GHZ] = band;
+			bands[NL80211_BAND_6GHZ] = band;
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
@@ -7235,7 +7235,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			hw->wiphy->bands[NL80211_BAND_5GHZ] = band;
+			bands[NL80211_BAND_5GHZ] = band;
 
 			if (ar->ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5G_CAP);
@@ -7414,7 +7414,8 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	SET_IEEE80211_DEV(hw, ab->dev);
 
 	ret = ath12k_mac_setup_channels_rates(ar,
-					      cap->supported_bands);
+					      cap->supported_bands,
+					      hw->wiphy->bands);
 	if (ret)
 		goto err;
 
-- 
2.34.1


