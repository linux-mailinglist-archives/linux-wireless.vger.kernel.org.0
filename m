Return-Path: <linux-wireless+bounces-24786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC0AF6968
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 07:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6471C41C18
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 05:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239442A9B;
	Thu,  3 Jul 2025 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cJdSz2cH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8322AE99
	for <linux-wireless@vger.kernel.org>; Thu,  3 Jul 2025 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519868; cv=none; b=bPVvMMgmmYZe/7jHfczZeNNaDgWkZN90yEqaZqlc/N4xoho+KuF4jclSdFhhOp01EkGzerftNQKCbqjv3qfuuHPjBWPuaTKgv+uNpqkTNlG9hZhpldz4yFWFL7voJuAjzpTn7t80enqGQEATg9FgkvycYsg/D4vWeogX4Ol+Ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519868; c=relaxed/simple;
	bh=m2CZWe0xGYdKblSWlKnXV2MQVV+vfu2C+0xRhbAjTkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDXk5GRNUnvNXNsowijE5kiAvttPZlWm0pIznKJ9xoGI2EAhmMEUlpOHT/zadvNF3FztQDXTfMpfhMH+km25dvc60CrR3r69V4l+saxgfiAhG2O88WSa71FSjcn0Xp5M55fnlxxbTyKKyaWb3h+6GnBYzNs7oPGmMKGbUbn0KoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cJdSz2cH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562JB8Fg006675;
	Thu, 3 Jul 2025 05:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=G8pU89NcMtK4P3YTc20M6N
	frzvL7zf4bl3sq2zlRkSE=; b=cJdSz2cH0sVyQJnuTk6c+vH6omwiQROJQswN3D
	oH2mo+iFG3knnwjdGCev7Ds8EU9VAf7ATvaogpuPUiQ+zdo5SP6KU5vRHfkjbeXW
	VXS4rtEK9i4c0JOIj/ASm1ltDIpbvBpVEKxtkqlBtuYhvujq4nKzHoWALOzsJB2D
	6EHmlmVElJ6v2AgNz7teBeJfq0/ciuC1SRZIJ0G7Dg5EFzhmAT6u1IHGt1EJFCGO
	hqwetywVVTfVyWHwcbYvpSEt7zahx+fPuI7MFabrz8Rjcbpjn2n3I/3CfzhgevUU
	yMy5wwkGSaF3MTDwWFcqIRo71Ei7hAMGd0SwXlArFkNLaO8w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47napw1by1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 05:17:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5635HhPP020744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Jul 2025 05:17:43 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 2 Jul 2025 22:17:41 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Add support to enqueue management frame at MLD level
Date: Thu, 3 Jul 2025 10:47:11 +0530
Message-ID: <20250703051711.2839934-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=dIKmmPZb c=1 sm=1 tr=0 ts=68661277 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=tUOTtS-gRCeqhucjqJ4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0MCBTYWx0ZWRfX7UO/aqzEcnQB
 xnmXzSOZRveOtctXR1ViPC6wlI3iYvK9arkAphU/ifvOfWcqWNMm8iSc7hnq14aFEiBZrDSgTv4
 rk4f6ePWeTRXJenautDV6xuKU1CrSHQhxrziwDSoUdXNl+GTt2pezTHconn6kxdSRbQgYns/7J+
 p9NwMIMND8f5MvVFiXmB1h9dcUFZZNIznIaivbNvgfsdaoEj46j/UP11/9ve0VrQxbnfzkIKNDn
 O0wmmFjHOfbeuzl5o95kBLC0HCqdBvduS3voHHVPRM5311zoiKN5gCT2sXjcFuoGspZFCawJpKi
 XKdqjXDpJEIF5kdESPqNu2aDf4XICRk1W1iB7lxBTF3jbwPfOuHfJGzuXvWPSp4zgBS0M5VI5Wg
 guu6jJPREr4dTroTRx3sNZKHMdYg1sFBg7TRz84EaKv3+J9yqKXWsDoCwddiC8yHMqhCaGdh
X-Proofpoint-GUID: M3gQ9AbwUeYJATUzCsWgQ0y5d0w7-MVW
X-Proofpoint-ORIG-GUID: M3gQ9AbwUeYJATUzCsWgQ0y5d0w7-MVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030040

From: Sriram R <quic_srirrama@quicinc.com>

A multi-link client can use any link for transmissions. It can decide to
put one link in power save mode for longer periods while listening on the
other links as per MLD listen interval. Unicast management frames sent to
that link station might get dropped if that link station is in power save
mode or inactive. In such cases, firmware can take decision on which link
to use.

Allow the firmware to decide on which link management frame should be
sent on, by filling the hardware link with maximum value of u32, so that
the firmware will not have a specific link to transmit data on and so
the management frames will be link agnostic. For QCN devices, all action
frames are marked as link agnostic. For WCN devices, if the device is
configured as an AP, then all frames other than probe response frames,
authentication frames, association response frames, re-association response
frames and ADDBA request frames are marked as link agnostic and if the
device is configured as a station, then all frames other than probe request
frames, authentication frames and ADDBA request frames are marked as link
agnostic.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/hw.c   | 55 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hw.h   |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  |  5 ++-
 drivers/net/wireless/ath/ath12k/peer.c |  2 +-
 drivers/net/wireless/ath/ath12k/peer.h |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 56 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h  | 16 +++++++-
 8 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 96ff9b08a848..25cf2374972f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -116,6 +116,7 @@ static inline u64 ath12k_le32hilo_to_u64(__le32 hi, __le32 lo)
 enum ath12k_skb_flags {
 	ATH12K_SKB_HW_80211_ENCAP = BIT(0),
 	ATH12K_SKB_CIPHER_SET = BIT(1),
+	ATH12K_SKB_MLO_STA = BIT(2),
 };
 
 struct ath12k_skb_cb {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index ec77ad498b33..6791ae1d64e5 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -14,6 +14,7 @@
 #include "hw.h"
 #include "mhi.h"
 #include "dp_rx.h"
+#include "peer.h"
 
 static const guid_t wcn7850_uuid = GUID_INIT(0xf634f534, 0x6147, 0x11ec,
 					     0x90, 0xd6, 0x02, 0x42,
@@ -49,6 +50,12 @@ static bool ath12k_dp_srng_is_comp_ring_qcn9274(int ring_num)
 	return false;
 }
 
+static bool ath12k_is_frame_link_agnostic_qcn9274(struct ath12k_link_vif *arvif,
+						  struct ieee80211_mgmt *mgmt)
+{
+	return ieee80211_is_action(mgmt->frame_control);
+}
+
 static int ath12k_hw_mac_id_to_pdev_id_wcn7850(const struct ath12k_hw_params *hw,
 					       int mac_id)
 {
@@ -74,6 +81,52 @@ static bool ath12k_dp_srng_is_comp_ring_wcn7850(int ring_num)
 	return false;
 }
 
+static bool ath12k_is_addba_resp_action_code(struct ieee80211_mgmt *mgmt)
+{
+	if (!ieee80211_is_action(mgmt->frame_control))
+		return false;
+
+	if (mgmt->u.action.category != WLAN_CATEGORY_BACK)
+		return false;
+
+	if (mgmt->u.action.u.addba_resp.action_code != WLAN_ACTION_ADDBA_RESP)
+		return false;
+
+	return true;
+}
+
+static bool ath12k_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
+						  struct ieee80211_mgmt *mgmt)
+{
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ath12k_hw *ah = ath12k_ar_to_ah(arvif->ar);
+	struct ath12k_base *ab = arvif->ar->ab;
+	__le16 fc = mgmt->frame_control;
+
+	spin_lock_bh(&ab->base_lock);
+	if (!ath12k_peer_find_by_addr(ab, mgmt->da) &&
+	    !ath12k_peer_ml_find(ah, mgmt->da)) {
+		spin_unlock_bh(&ab->base_lock);
+		return false;
+	}
+	spin_unlock_bh(&ab->base_lock);
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		return arvif->is_up &&
+		       (vif->valid_links == vif->active_links) &&
+		       !ieee80211_is_probe_req(fc) &&
+		       !ieee80211_is_auth(fc) &&
+		       !ieee80211_is_deauth(fc) &&
+		       !ath12k_is_addba_resp_action_code(mgmt);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		return !(ieee80211_is_probe_resp(fc) || ieee80211_is_auth(fc) ||
+			 ieee80211_is_assoc_resp(fc) || ieee80211_is_reassoc_resp(fc) ||
+			 ath12k_is_addba_resp_action_code(mgmt));
+
+	return false;
+}
+
 static const struct ath12k_hw_ops qcn9274_ops = {
 	.get_hw_mac_from_pdev_id = ath12k_hw_qcn9274_mac_from_pdev_id,
 	.mac_id_to_pdev_id = ath12k_hw_mac_id_to_pdev_id_qcn9274,
@@ -81,6 +134,7 @@ static const struct ath12k_hw_ops qcn9274_ops = {
 	.rxdma_ring_sel_config = ath12k_dp_rxdma_ring_sel_config_qcn9274,
 	.get_ring_selector = ath12k_hw_get_ring_selector_qcn9274,
 	.dp_srng_is_tx_comp_ring = ath12k_dp_srng_is_comp_ring_qcn9274,
+	.is_frame_link_agnostic = ath12k_is_frame_link_agnostic_qcn9274,
 };
 
 static const struct ath12k_hw_ops wcn7850_ops = {
@@ -90,6 +144,7 @@ static const struct ath12k_hw_ops wcn7850_ops = {
 	.rxdma_ring_sel_config = ath12k_dp_rxdma_ring_sel_config_wcn7850,
 	.get_ring_selector = ath12k_hw_get_ring_selector_wcn7850,
 	.dp_srng_is_tx_comp_ring = ath12k_dp_srng_is_comp_ring_wcn7850,
+	.is_frame_link_agnostic = ath12k_is_frame_link_agnostic_wcn7850,
 };
 
 #define ATH12K_TX_RING_MASK_0 0x1
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 0a75bc5abfa2..9c69dd5a22af 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -246,6 +246,8 @@ struct ath12k_hw_ops {
 	int (*rxdma_ring_sel_config)(struct ath12k_base *ab);
 	u8 (*get_ring_selector)(struct sk_buff *skb);
 	bool (*dp_srng_is_tx_comp_ring)(int ring_num);
+	bool (*is_frame_link_agnostic)(struct ath12k_link_vif *arvif,
+				       struct ieee80211_mgmt *mgmt);
 };
 
 static inline
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6dd4441ce9a0..fc1e309c21db 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8333,7 +8333,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 
 	skb_cb->paddr = paddr;
 
-	ret = ath12k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb);
+	ret = ath12k_wmi_mgmt_send(arvif, buf_id, skb);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to send mgmt frame: %d\n", ret);
 		goto err_unmap_buf;
@@ -8645,6 +8645,9 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 		skb_cb->flags |= ATH12K_SKB_HW_80211_ENCAP;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
+		if (sta && sta->mlo)
+			skb_cb->flags |= ATH12K_SKB_MLO_STA;
+
 		ret = ath12k_mac_mgmt_tx(ar, skb, is_prb_rsp);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to queue management frame %d\n",
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index ec7236bbccc0..eb7aeff01490 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -8,7 +8,7 @@
 #include "peer.h"
 #include "debug.h"
 
-static struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
+struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
 {
 	struct ath12k_ml_peer *ml_peer;
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index f3a5e054d2b5..71f2b22d82db 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -91,5 +91,6 @@ struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash
 int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
+struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr);
 
 #endif /* _PEER_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b34f2c183312..94cd60102d06 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -786,20 +786,46 @@ struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_ab, u32 len)
 	return skb;
 }
 
-int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
+int ath12k_wmi_mgmt_send(struct ath12k_link_vif *arvif, u32 buf_id,
 			 struct sk_buff *frame)
 {
+	struct ath12k *ar = arvif->ar;
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct wmi_mgmt_send_cmd *cmd;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(frame);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)frame->data;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	int cmd_len = sizeof(struct ath12k_wmi_mgmt_send_tx_params);
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)hdr;
+	struct ath12k_wmi_mlo_mgmt_send_params *ml_params;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_skb_cb *skb_cb;
+	u32 buf_len, buf_len_aligned;
+	u32 vdev_id = arvif->vdev_id;
+	bool link_agnostic = false;
 	struct wmi_tlv *frame_tlv;
+	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
-	u32 buf_len;
 	int ret, len;
+	void *ptr;
 
 	buf_len = min_t(int, frame->len, WMI_MGMT_SEND_DOWNLD_LEN);
-
-	len = sizeof(*cmd) + sizeof(*frame_tlv) + roundup(buf_len, 4);
+	buf_len_aligned = roundup(buf_len, sizeof(u32));
+
+	len = sizeof(*cmd) + sizeof(*frame_tlv) + buf_len_aligned;
+
+	if (ieee80211_vif_is_mld(vif)) {
+		skb_cb = ATH12K_SKB_CB(frame);
+		if ((skb_cb->flags & ATH12K_SKB_MLO_STA) &&
+		    ab->hw_params->hw_ops->is_frame_link_agnostic &&
+		    ab->hw_params->hw_ops->is_frame_link_agnostic(arvif, mgmt)) {
+			len += cmd_len + TLV_HDR_SIZE + sizeof(*ml_params);
+			ath12k_generic_dbg(ATH12K_DBG_MGMT,
+					   "Sending Mgmt Frame fc 0x%0x as link agnostic",
+					   mgmt->frame_control);
+			link_agnostic = true;
+		}
+	}
 
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -822,6 +848,28 @@ int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
 
 	memcpy(frame_tlv->value, frame->data, buf_len);
 
+	if (!link_agnostic)
+		goto send;
+
+	ptr = skb->data + sizeof(*cmd) + sizeof(*frame_tlv) + buf_len_aligned;
+
+	tlv = ptr;
+
+	/* Tx params not used currently */
+	tlv->header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_TX_SEND_PARAMS, cmd_len);
+	ptr += cmd_len;
+
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARRAY_STRUCT, sizeof(*ml_params));
+	ptr += TLV_HDR_SIZE;
+
+	ml_params = ptr;
+	ml_params->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_MLO_TX_SEND_PARAMS,
+						       sizeof(*ml_params));
+
+	ml_params->hw_link_id = cpu_to_le32(WMI_MGMT_LINK_AGNOSTIC_ID);
+
+send:
 	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_MGMT_TX_SEND_CMDID);
 	if (ret) {
 		ath12k_warn(ar->ab,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ed9b4324a7b8..3c803df0f974 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4013,6 +4013,7 @@ struct wmi_scan_chan_list_cmd {
 	__le32 pdev_id;
 } __packed;
 
+#define WMI_MGMT_LINK_AGNOSTIC_ID	0xFFFFFFFF
 #define WMI_MGMT_SEND_DOWNLD_LEN	64
 
 #define WMI_TX_PARAMS_DWORD0_POWER		GENMASK(7, 0)
@@ -4039,7 +4040,18 @@ struct wmi_mgmt_send_cmd {
 
 	/* This TLV is followed by struct wmi_mgmt_frame */
 
-	/* Followed by struct wmi_mgmt_send_params */
+	/* Followed by struct ath12k_wmi_mlo_mgmt_send_params */
+} __packed;
+
+struct ath12k_wmi_mlo_mgmt_send_params {
+	__le32 tlv_header;
+	__le32 hw_link_id;
+} __packed;
+
+struct ath12k_wmi_mgmt_send_tx_params {
+	__le32 tlv_header;
+	__le32 tx_param_dword0;
+	__le32 tx_param_dword1;
 } __packed;
 
 struct wmi_sta_powersave_mode_cmd {
@@ -6271,7 +6283,7 @@ void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
 int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len);
-int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
+int ath12k_wmi_mgmt_send(struct ath12k_link_vif *arvif, u32 buf_id,
 			 struct sk_buff *frame);
 int ath12k_wmi_p2p_go_bcn_ie(struct ath12k *ar, u32 vdev_id,
 			     const u8 *p2p_ie);

base-commit: 7c570c82549fb2fc83bc883ce5a277e55e5fc9eb
-- 
2.25.1


