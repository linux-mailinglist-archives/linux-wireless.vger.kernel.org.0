Return-Path: <linux-wireless+bounces-27664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1EBA2702
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 07:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F2B56011F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B345276022;
	Fri, 26 Sep 2025 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kAojXhM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D62777E0
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864167; cv=none; b=StuOFjw+bAxWUlbZFoev9gi9qAliB0umBmcNyjL8x36DTu/LLxC0nWbBE+1ZYGFSKm/GbeMhXts7ZfuODz8RE4efx+BDJPhKiwm6G4JnpXbaX5wbYbC7k3wdqpmS3+k9xPnMLgZHO5V9vrluCxO6H5OlbgTu521DxnFrAkHM+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864167; c=relaxed/simple;
	bh=o/vM4Z5CDQlhJLMUG5GGZrE7+E94d+Sel+a03P8bqnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnvJuduPE6cCbs6sMItSl4EL6vL1D41A3zhWbbQVGh0j71XUyXNjx/7GukQircK4L5STK+GPsQsDFxzc3KL44C/u/AJr3sG0bPFDgX+KBvYm5GFd43PS57H/HCQ5MyWL1ILM5dodFT2rTtZHvNdbiQbMfwPQFPJniAVwBvrXnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kAojXhM4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPq7s014483;
	Fri, 26 Sep 2025 05:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K8495FQz72mugnYV4MtaKn5F2LUlYdzRZnaKpBlZ90A=; b=kAojXhM4VK4spiLQ
	g8bpPDrg2gmTU8LI9nfFaeGMbF6XHcFihe00h0RAyB/9Hle2AQnOunLX4mnLuxL6
	8Qj/8demaRLNRkTVUIncvJ3QfQSAhCnCr/YQdJZhH2oVkCwchzMYsy8BAdmlX6tI
	sgzvfoEsDuZ2Ytu5QBm9/rqfFf/KG+mpiy9+rVw/QuC7e9VWMozqYG+HoGhR0dLQ
	bqlxfMjKsaVDk8VRhL2X7sZzYkq6LOXFLTQCfFXjJnSU6k+BRFkkyK0RatVS6TeS
	k7Zt2S+Cshx8A5/YW92D4VW/TnOtJBJL2cxX9UWmwnnHtKd8duScXrXKfLAmgA+f
	Bt+AKw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rhher-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 05:22:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58Q5MgpD027733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 05:22:42 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 22:22:41 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v2 6/6] wifi: ath12k: Refactor ath12k_vif structure
Date: Fri, 26 Sep 2025 10:52:18 +0530
Message-ID: <20250926052218.893876-7-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926052218.893876-1-quic_rdeuri@quicinc.com>
References: <20250926052218.893876-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d62323 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=ZDpImH4GM0z4ldPMZowA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qMHKDQbTYn9r9LWcIlqyY6RvTgXTHdrM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX1mQUyohUO3E0
 H+5bfCybzDxkpgNCHUqmMs/wD6Tnu21fMXDB7wPSz0IC4UXcBjRVo+ery44XZQFbqsNAGY8/IFr
 J0CC1icK4NC9OIble0xWcXrtHqYU7b7lA6zR5331t1EUYQ31ELwhX19iuWJTkXFjFDfQlwYFw6H
 om9pYf8OiCZFulNNEkOjEXkUkoahMYYcjCaEF/a7tEVK3IlFiL0/DvKHAMReW4wcrJcguaRvCb2
 9za1wwtDs0ENCU+jwEb8871D64zlrucpuOWXlWoIgPdIUupF8Z9HRSx4jRp0FObp63eEv0fQE9D
 6vjjZOIMFFzmjIOnftKfZZZs0iZytGv4tJPWWhPXC76CYXhEXBsVuuwSfbKkmzRZgIbRKsQavqS
 GTmX7gl+m6REL+hCsLcL1Boku//Mmg==
X-Proofpoint-GUID: qMHKDQbTYn9r9LWcIlqyY6RvTgXTHdrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Move the Data Path (DP)-specific fields from ath12k_vif into a new
structure ath12k_dp_vif, embedded within ath12k_vif. This new structure
contains an array of per-link DP fields represented by ath12k_dp_link_vif.

Since dp_link_vif is small and frequently accessed from ahvif during Tx,
it is stored as an array of structs rather than an array of pointers to
avoid additional indirections and improve cache efficiency. However,
this design comes with a trade-off: because the array is not pointer-based,
it increases memory usage.

Per packet data path makes use of ath12k_dp_vif and ath12k_dp_link_vif.
Add pdev_idx and lmac_id in ath12k_dp_link_vif to avoid accessing ar in
dp tx.

Diagrammatic view of the new structure is below:

+--------------------------------+
| struct ath12k_vif              |
|                                |
|  +--------------------------+  |
|  | struct ath12k_dp_vif     |  |
|  |                          |  |
|  |  +--------------------+  |  |
|  |  | ath12k_dp_link_vif |  |  |
|  |  +--------------------+  |  |
|  |                          |  |
|  |  +--------------------+  |  |
|  |  | ath12k_dp_link_vif |  |  |
|  |  +--------------------+  |  |
|  |                          |  |
|  |  +--------------------+  |  |
|  |  | ath12k_dp_link_vif |  |  |
|  |  +--------------------+  |  |
|  |                          |  |
|  +--------------------------+  |
|                                |
+--------------------------------+

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/cmn_defs.h    |  6 ++
 drivers/net/wireless/ath/ath12k/core.h        | 13 +----
 drivers/net/wireless/ath/ath12k/dp.c          | 57 ++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_cmn.h      | 26 +++++++++
 drivers/net/wireless/ath/ath12k/mac.c         | 29 +++++++---
 drivers/net/wireless/ath/ath12k/mac.h         |  3 -
 drivers/net/wireless/ath/ath12k/peer.c        |  8 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 25 ++++----
 8 files changed, 111 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/cmn_defs.h b/drivers/net/wireless/ath/ath12k/cmn_defs.h
index e1f1f50341ff..1a531357271b 100644
--- a/drivers/net/wireless/ath/ath12k/cmn_defs.h
+++ b/drivers/net/wireless/ath/ath12k/cmn_defs.h
@@ -6,8 +6,14 @@
 #ifndef ATH12K_CMN_DEFS_H
 #define ATH12K_CMN_DEFS_H
 
+#include <net/mac80211.h>
+
 #define MAX_RADIOS 2
 #define ATH12K_MAX_DEVICES 3
 #define ATH12K_GROUP_MAX_RADIO (ATH12K_MAX_DEVICES * MAX_RADIOS)
 
+#define ATH12K_SCAN_MAX_LINKS	ATH12K_GROUP_MAX_RADIO
+/* Define 1 scan link for each radio for parallel scan purposes */
+#define ATH12K_NUM_MAX_LINKS (IEEE80211_MLD_MAX_NUM_LINKS + ATH12K_SCAN_MAX_LINKS)
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6a36dfdf5b17..7b0f9a4b9008 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -35,6 +35,7 @@
 #include "debugfs_htt_stats.h"
 #include "coredump.h"
 #include "cmn_defs.h"
+#include "dp_cmn.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -309,16 +310,9 @@ struct ath12k_link_vif {
 	u32 vdev_id;
 	u32 beacon_interval;
 	u32 dtim_period;
-	u16 ast_hash;
-	u16 ast_idx;
-	u16 tcl_metadata;
-	u8 hal_addr_search_flags;
-	u8 search_type;
 
 	struct ath12k *ar;
 
-	int bank_id;
-	u8 vdev_id_check_en;
 	bool beacon_prot;
 
 	struct wmi_wmm_params_all_arg wmm_params;
@@ -357,6 +351,8 @@ struct ath12k_link_vif {
 };
 
 struct ath12k_vif {
+	struct ath12k_dp_vif dp_vif;
+
 	enum wmi_vdev_type vdev_type;
 	enum wmi_vdev_subtype vdev_subtype;
 	struct ieee80211_vif *vif;
@@ -380,10 +376,7 @@ struct ath12k_vif {
 	} u;
 
 	u32 aid;
-	u32 key_cipher;
-	u8 tx_encap_type;
 	bool ps;
-	atomic_t mcbc_gsn;
 
 	struct ath12k_link_vif deflink;
 	struct ath12k_link_vif __rcu *link[ATH12K_NUM_MAX_LINKS];
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 39d6bd41b4ef..92cfc8a483ff 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -338,18 +338,23 @@ u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
 				      struct ath12k_link_vif *arvif)
 {
 	u32 bank_config = 0;
+	u8 link_id = arvif->link_id;
 	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_dp_vif *dp_vif = &ahvif->dp_vif;
+	struct ath12k_dp_link_vif *dp_link_vif;
+
+	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(dp_vif, link_id);
 
 	/* Only valid for raw frames with HW crypto enabled.
 	 * With SW crypto, mac80211 sets key per packet
 	 */
-	if (ahvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
+	if (dp_vif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
 	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
 		bank_config |=
-			u32_encode_bits(ath12k_dp_tx_get_encrypt_type(ahvif->key_cipher),
+			u32_encode_bits(ath12k_dp_tx_get_encrypt_type(dp_vif->key_cipher),
 					HAL_TX_BANK_CONFIG_ENCRYPT_TYPE);
 
-	bank_config |= u32_encode_bits(ahvif->tx_encap_type,
+	bank_config |= u32_encode_bits(dp_vif->tx_encap_type,
 					HAL_TX_BANK_CONFIG_ENCAP_TYPE);
 	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_SRC_BUFFER_SWAP) |
 			u32_encode_bits(0, HAL_TX_BANK_CONFIG_LINK_META_SWAP) |
@@ -361,15 +366,16 @@ u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
 	else
 		bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
 
-	bank_config |= u32_encode_bits(arvif->hal_addr_search_flags & HAL_TX_ADDRX_EN,
-					HAL_TX_BANK_CONFIG_ADDRX_EN) |
-			u32_encode_bits(!!(arvif->hal_addr_search_flags &
+	bank_config |= u32_encode_bits(dp_link_vif->hal_addr_search_flags &
+				       HAL_TX_ADDRX_EN,
+				       HAL_TX_BANK_CONFIG_ADDRX_EN) |
+			u32_encode_bits(!!(dp_link_vif->hal_addr_search_flags &
 					HAL_TX_ADDRY_EN),
 					HAL_TX_BANK_CONFIG_ADDRY_EN);
 
 	bank_config |= u32_encode_bits(ieee80211_vif_is_mesh(ahvif->vif) ? 3 : 0,
 					HAL_TX_BANK_CONFIG_MESH_EN) |
-			u32_encode_bits(arvif->vdev_id_check_en,
+			u32_encode_bits(dp_link_vif->vdev_id_check_en,
 					HAL_TX_BANK_CONFIG_VDEV_ID_CHECK_EN);
 
 	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID);
@@ -938,15 +944,19 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 
 static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
 {
+	u8 link_id = arvif->link_id;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_dp_link_vif *dp_link_vif = &ahvif->dp_vif.dp_link_vif[link_id];
+
 	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_STA:
-		arvif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
-		arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
+		dp_link_vif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
+		dp_link_vif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
 		break;
 	case WMI_VDEV_TYPE_AP:
 	case WMI_VDEV_TYPE_IBSS:
-		arvif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
-		arvif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
+		dp_link_vif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
+		dp_link_vif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
 		break;
 	case WMI_VDEV_TYPE_MONITOR:
 	default:
@@ -957,22 +967,29 @@ static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	u8 link_id = arvif->link_id;
+	int bank_id;
+	struct ath12k_dp_link_vif *dp_link_vif;
+
+	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(&ahvif->dp_vif, link_id);
 
-	arvif->tcl_metadata |= u32_encode_bits(1, HTT_TCL_META_DATA_TYPE) |
-			       u32_encode_bits(arvif->vdev_id,
-					       HTT_TCL_META_DATA_VDEV_ID) |
-			       u32_encode_bits(ar->pdev->pdev_id,
-					       HTT_TCL_META_DATA_PDEV_ID);
+	dp_link_vif->tcl_metadata |= u32_encode_bits(1, HTT_TCL_META_DATA_TYPE) |
+				     u32_encode_bits(arvif->vdev_id,
+						     HTT_TCL_META_DATA_VDEV_ID) |
+				     u32_encode_bits(ar->pdev->pdev_id,
+						     HTT_TCL_META_DATA_PDEV_ID);
 
 	/* set HTT extension valid bit to 0 by default */
-	arvif->tcl_metadata &= ~HTT_TCL_META_DATA_VALID_HTT;
+	dp_link_vif->tcl_metadata &= ~HTT_TCL_META_DATA_VALID_HTT;
 
 	ath12k_dp_update_vdev_search(arvif);
-	arvif->vdev_id_check_en = true;
-	arvif->bank_id = ath12k_dp_tx_get_bank_profile(ab, arvif, ath12k_ab_to_dp(ab));
+	dp_link_vif->vdev_id_check_en = true;
+	bank_id = ath12k_dp_tx_get_bank_profile(ab, arvif, ath12k_ab_to_dp(ab));
+	dp_link_vif->bank_id = bank_id;
 
 	/* TODO: error path for bank id failure */
-	if (arvif->bank_id == DP_INVALID_BANK_ID) {
+	if (bank_id == DP_INVALID_BANK_ID) {
 		ath12k_err(ar->ab, "Failed to initialize DP TX Banks");
 		return;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
index 70c92f6d33d6..3dc61d1a4162 100644
--- a/drivers/net/wireless/ath/ath12k/dp_cmn.h
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -14,6 +14,32 @@ struct ath12k_dp_hw_group {
 	struct ath12k_dp *dp[ATH12K_MAX_DEVICES];
 };
 
+struct ath12k_dp_link_vif {
+	u32 vdev_id;
+	u8 search_type;
+	u8 hal_addr_search_flags;
+	u8 pdev_idx;
+	u8 lmac_id;
+	u16 ast_idx;
+	u16 ast_hash;
+	u16 tcl_metadata;
+	u8 vdev_id_check_en;
+	int bank_id;
+};
+
+struct ath12k_dp_vif {
+	u8 tx_encap_type;
+	u32 key_cipher;
+	atomic_t mcbc_gsn;
+	struct ath12k_dp_link_vif dp_link_vif[ATH12K_NUM_MAX_LINKS];
+};
+
+static inline struct ath12k_dp_link_vif *
+ath12k_dp_vif_to_dp_link_vif(struct ath12k_dp_vif *dp_vif, u8 link_id)
+{
+	return &dp_vif->dp_link_vif[link_id];
+}
+
 void ath12k_dp_cmn_device_deinit(struct ath12k_dp *dp);
 int ath12k_dp_cmn_device_init(struct ath12k_dp *dp);
 void ath12k_dp_cmn_hw_group_unassign(struct ath12k_dp *dp,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0f93fbeafa8c..1f585fb50021 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5392,7 +5392,7 @@ static int ath12k_install_key(struct ath12k_link_vif *arvif,
 		return -ETIMEDOUT;
 
 	if (ether_addr_equal(arg.macaddr, arvif->bssid))
-		ahvif->key_cipher = arg.ieee80211_key_cipher;
+		ahvif->dp_vif.key_cipher = arg.ieee80211_key_cipher;
 
 	if (ar->install_key_status) {
 		ret = -EINVAL;
@@ -8922,7 +8922,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			return;
 		}
 	} else {
-		mcbc_gsn = atomic_inc_return(&ahvif->mcbc_gsn) & 0xfff;
+		mcbc_gsn = atomic_inc_return(&ahvif->dp_vif.mcbc_gsn) & 0xfff;
 
 		links_map = ahvif->links_map;
 		for_each_set_bit(link_id, &links_map,
@@ -8946,9 +8946,10 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 			skb_cb = ATH12K_SKB_CB(msdu_copied);
 			skb_cb->link_id = link_id;
+			skb_cb->vif = vif;
 
 			/* For open mode, skip peer find logic */
-			if (unlikely(!ahvif->key_cipher))
+			if (unlikely(!ahvif->dp_vif.key_cipher))
 				goto skip_peer_find;
 
 			spin_lock_bh(&tmp_ar->ab->base_lock);
@@ -9487,14 +9488,14 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 					IEEE80211_OFFLOAD_DECAP_ENABLED);
 
 	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
-		ahvif->tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
+		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
 	else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
-		ahvif->tx_encap_type = ATH12K_HW_TXRX_RAW;
+		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_RAW;
 	else
-		ahvif->tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
+		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, ahvif->tx_encap_type);
+					    param_id, ahvif->dp_vif.tx_encap_type);
 	if (ret) {
 		ath12k_warn(ab, "failed to set vdev %d tx encap mode: %d\n",
 			    arvif->vdev_id, ret);
@@ -9709,6 +9710,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	int i;
 	int ret, vdev_id;
 	u8 link_id;
+	struct ath12k_dp_link_vif *dp_link_vif = NULL;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -9784,6 +9786,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		goto err_vdev_del;
 	}
 
+	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(&ahvif->dp_vif, arvif->link_id);
+
+	dp_link_vif->vdev_id = arvif->vdev_id;
+	dp_link_vif->lmac_id = ar->lmac_id;
+	dp_link_vif->pdev_idx = ar->pdev_idx;
+
 	switch (ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
 		peer_param.vdev_id = arvif->vdev_id;
@@ -10177,6 +10185,7 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ath12k_dp_link_vif *dp_link_vif;
 	struct ath12k_base *ab = ar->ab;
 	unsigned long time_left;
 	int ret;
@@ -10223,7 +10232,9 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 		     ath12k_mac_vif_txmgmt_idr_remove, vif);
 
 	ath12k_mac_vif_unref(ath12k_ab_to_dp(ab), vif);
-	ath12k_dp_tx_put_bank_profile(ath12k_ab_to_dp(ab), arvif->bank_id);
+
+	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(&ahvif->dp_vif, arvif->link_id);
+	ath12k_dp_tx_put_bank_profile(ath12k_ab_to_dp(ab), dp_link_vif->bank_id);
 
 	/* Recalc txpower for remaining vdev */
 	ath12k_mac_txpower_recalc(ar);
@@ -12524,7 +12535,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 			ahvif = arvif->ahvif;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "reconfig cipher %d up %d vdev type %d\n",
-				   ahvif->key_cipher,
+				   ahvif->dp_vif.key_cipher,
 				   arvif->is_up,
 				   ahvif->vdev_type);
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index ea6934e8d17c..107ce6da2f64 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -54,9 +54,6 @@ struct ath12k_generic_iter {
  * for driver usage purpose.
  */
 #define ATH12K_FIRST_SCAN_LINK	IEEE80211_MLD_MAX_NUM_LINKS
-#define ATH12K_SCAN_MAX_LINKS	ATH12K_GROUP_MAX_RADIO
-/* Define 1 scan link for each radio for parallel scan purposes */
-#define ATH12K_NUM_MAX_LINKS (IEEE80211_MLD_MAX_NUM_LINKS + ATH12K_SCAN_MAX_LINKS)
 #define ATH12K_SCAN_LINKS_MASK	GENMASK(ATH12K_NUM_MAX_LINKS, IEEE80211_MLD_MAX_NUM_LINKS)
 
 #define ATH12K_NUM_MAX_ACTIVE_LINKS_PER_DEVICE	2
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index af95324f2708..3a981840a6fd 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -318,12 +318,14 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ath12k_wmi_peer_create_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ath12k_link_sta *arsta;
 	u8 link_id = arvif->link_id;
 	struct ath12k_peer *peer;
 	struct ath12k_sta *ahsta;
 	u16 ml_peer_id;
 	int ret;
+	struct ath12k_dp_link_vif *dp_link_vif = &ahvif->dp_vif.dp_link_vif[link_id];
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -384,8 +386,8 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	peer->sta = sta;
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
-		arvif->ast_hash = peer->ast_hash;
-		arvif->ast_idx = peer->hw_peer_id;
+		dp_link_vif->ast_hash = peer->ast_hash;
+		dp_link_vif->ast_idx = peer->hw_peer_id;
 	}
 
 	if (vif->type == NL80211_IFTYPE_AP)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 6a5d6f525951..b94b14bda39b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -70,6 +70,8 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_dp_vif *dp_vif = &ahvif->dp_vif;
+	struct ath12k_dp_link_vif *dp_link_vif;
 	struct dp_tx_ring *tx_ring;
 	u8 pool_id;
 	u8 hal_ring_id;
@@ -113,10 +115,12 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	if (!tx_desc)
 		return -ENOMEM;
 
-	ti.bank_id = arvif->bank_id;
-	ti.meta_data_flags = arvif->tcl_metadata;
+	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(&ahvif->dp_vif, arvif->link_id);
 
-	if (ahvif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
+	ti.bank_id = dp_link_vif->bank_id;
+	ti.meta_data_flags = dp_link_vif->tcl_metadata;
+
+	if (dp_vif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
 	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags)) {
 		if (skb_cb->flags & ATH12K_SKB_CIPHER_SET) {
 			ti.encrypt_type =
@@ -142,18 +146,18 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	}
 
 	ti.encap_type = ath12k_dp_tx_get_encap_type(ab, skb);
-	ti.addr_search_flags = arvif->hal_addr_search_flags;
-	ti.search_type = arvif->search_type;
+	ti.addr_search_flags = dp_link_vif->hal_addr_search_flags;
+	ti.search_type = dp_link_vif->search_type;
 	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
 	ti.pkt_offset = 0;
-	ti.lmac_id = ar->lmac_id;
+	ti.lmac_id = dp_link_vif->lmac_id;
 
-	ti.vdev_id = arvif->vdev_id;
+	ti.vdev_id = dp_link_vif->vdev_id;
 	if (gsn_valid)
 		ti.vdev_id += HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
 
-	ti.bss_ast_hash = arvif->ast_hash;
-	ti.bss_ast_idx = arvif->ast_idx;
+	ti.bss_ast_hash = dp_link_vif->ast_hash;
+	ti.bss_ast_idx = dp_link_vif->ast_idx;
 	ti.dscp_tid_tbl_idx = 0;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
@@ -251,11 +255,10 @@ int ath12k_wifi7_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	}
 
 	tx_desc->skb = skb;
-	tx_desc->mac_id = ar->pdev_idx;
+	tx_desc->mac_id = dp_link_vif->pdev_idx;
 	ti.desc_id = tx_desc->desc_id;
 	ti.data_len = skb->len;
 	skb_cb->paddr = ti.paddr;
-	skb_cb->vif = ahvif->vif;
 	skb_cb->ar = ar;
 
 	if (msdu_ext_desc) {
-- 
2.34.1


