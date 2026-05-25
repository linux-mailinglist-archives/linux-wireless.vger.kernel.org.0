Return-Path: <linux-wireless+bounces-36876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKiLOVIvFGqrKgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:15:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F595C9D2D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3A53025486
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7937D134;
	Mon, 25 May 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+VTTbfs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB137D128
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707415; cv=none; b=jPEbh8Nd46aj3tB7nkhUEkrsl1FBOxBEGaaStcrtT8RChlHEG0wOaRNZBaGd9J3WjUP5BdES4R/lMcvUojDHT//6RR+rWCIPrwHiQ2oEO5rQPBVVbGwSGKegUlsUpkeDcYJdqZiqPyUa93CBvR9A/Vbd5McakEU8AYrFPMpd350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707415; c=relaxed/simple;
	bh=pRi02VfDnH7pQf0OhiwK1ZxdZhlKrUxXltc0cdE7PoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkIZO4QVHqN8FYtdQPQPyy971sivw3I8zo2Xm5kKO/IzDjznEi12r3JBPT37yQzfBaIRYGEYn7KKmprvM3yPtgyq/lhvBdIyoehvpa9RFtSpK9AC9Gj/5j/Fl0QO0swdA+sdOw/sdBBQn+h39iKenL7/UfIqSGq8FB41cXOD7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b+VTTbfs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P4v8Cd168750;
	Mon, 25 May 2026 11:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s+GY6B3Hwtq
	i9CocteH/0dbQqQinQ1EJYs2dP89UP88=; b=b+VTTbfsM1MJymIeCQkDPrfDN+I
	KFYA5i2lz+QzpuTq/oJUVx6F2sKKtVPjRwfbLkh+b9VZ6kb1DTOd/Ry1Q2fTD5R8
	k0GPcdzJ6bfG93KRlWaTg+Q/hpDEzJZ5+er+8KL4adeV7XNn8p89t4SyEq41DRma
	VitzMpAjJCPw2+zZI42Hn6CLb8mg/ozQKJcno/dfOV1btf2QuGQYh3XgF5+uVqon
	v5+ByeoYEb5VFkjseNSyZt26PSLNPmCKB7qsKpNoj68zjsi5cZZsMmzPIh/58v+o
	ifI+c3HcG0KNmt4OzlolyfygGbukO/f2KzjuaL3VmbcV3WuHG0wF5sLoo+A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0wjwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PBA8q2026284;
	Mon, 25 May 2026 11:10:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajfc3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:08 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64PBA8Ag026279;
	Mon, 25 May 2026 11:10:08 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-tamizhr-blr.qualcomm.com [10.190.110.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64PBA8Us026278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 11:10:08 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 380741)
	id 7345D420D7; Mon, 25 May 2026 16:40:07 +0530 (+0530)
From: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Subject: [PATCH ath-next 3/6] wifi: ath12k: Add 4-address mode support for eth offload
Date: Mon, 25 May 2026 16:39:39 +0530
Message-Id: <20260525110942.2890212-4-tamizh.raja@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
References: <20260525110942.2890212-1-tamizh.raja@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: Wo-TVG2Zt8yBE2p_41idYXxMvVaVl1GJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDExMyBTYWx0ZWRfX8gGc5f37sN0y
 Whx4mz7QGwQXrg3A2ajH26KaFtODRb3Hu7+5f5yXvzsKGx9KKZEKY2uzUesEYTslYFV1w5+6znZ
 r2W+Y2yt+xmBwGF0UfNLwDiPaXLudFayeIHU+Wa6lR9E0/urhnhHwM05FJ5BUQutNKNg0asGA/Z
 cCtt8JI6wadzyagYMz38JS5bUqfXaEUXVuz9hZ95yhl7/P7+0CK9MRuR5k2mMhEVOBhRa9E1XEu
 OoqDgXhnLyaFjx9hrnYhHkbmcjBafpsvtlLRB2WnIgZgI4jIjLV37Z4i9KdXgqvWdqUdOE6eLsJ
 TDmVAO9WE8kbvNE9U7aPgIFeCVaRN+hVOED3HzlbkNcSoo2CSHnq92nIe9njQAnwvvcMNhImUvl
 3Yd/Sk0oUouXvYOWlwXXfor6ZtDvYQJQepZBz5VttQr53fXTjCngOaIho0FytqBkcU1krIph/r4
 5/PIT/DAZwDGRy1Iy9Q==
X-Proofpoint-GUID: Wo-TVG2Zt8yBE2p_41idYXxMvVaVl1GJ
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a142e13 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=jW-c0ixZFP-l8cafVsUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250113
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36876-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 67F595C9D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently driver does not enable the hardware/firmware support for handling
4-address multicast frames in the Tx/Rx path when 8023_ENCAP_OFFLOAD is
enabled. Add the required support to ensure correct processing of multicast
traffic in 4-address mode.

Enable this functionality by setting the WMI_VDEV_PARAM_AP_ENABLE_NAWDS
vdev parameter when the 8023_ENCAP_OFFLOAD feature is active. Override
peer metadata values for 4-address multicast packet transmission by using
the station's ast_hash and ast_idx instead of vdev-level metadata,
and set HAL_TCL_DATA_CMD_INFO4_IDX_LOOKUP_OVERRIDE to indicate this
override.

Suppress firmware peer-map events for 4-address frames by setting the
WMI_RSRC_CFG_FLAGS2_FW_AST_INDICATION_DISABLE flag during WMI
initialization. This prevents inconsistencies in the host's peer list.

Add the IEEE80211_OFFLOAD_ENCAP_4ADDR VIF offload flag to notify mac80211
that 4-address Ethernet encapsulation offload is supported.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |  3 ++
 drivers/net/wireless/ath/ath12k/mac.c         | 28 ++++++++++++---
 drivers/net/wireless/ath/ath12k/peer.c        |  2 ++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 35 +++++++++++++++----
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |  4 ++-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c         |  3 +-
 drivers/net/wireless/ath/ath12k/wmi.h         |  9 +++++
 8 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 70ad9742c21d..fc5127b5c1a3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -355,6 +355,7 @@ struct ath12k_link_vif {
 	struct wiphy_work bcn_tx_work;
 
 	bool set_wds_vdev_param;
+	bool nawds_enabled;
 };
 
 struct ath12k_vif {
@@ -495,6 +496,8 @@ struct ath12k_link_sta {
 	u8 addr[ETH_ALEN];
 
 	u16 tcl_metadata;
+	u16 ast_hash;
+	u16 ast_idx;
 
 	/* the following are protected by ar->data_lock */
 	u32 changed; /* IEEE80211_RC_* */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0105a1fc7929..2f437ecae84d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6572,6 +6572,7 @@ static int ath12k_mac_sta_set_4addr(struct wiphy *wiphy, struct ath12k_sta *ahst
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_link_vif *arvif;
 	struct ath12k_link_sta *arsta;
+	struct ath12k_vif *ahvif;
 	struct ath12k_dp *dp;
 	unsigned long links;
 	struct ath12k *ar;
@@ -6585,10 +6586,11 @@ static int ath12k_mac_sta_set_4addr(struct wiphy *wiphy, struct ath12k_sta *ahst
 			continue;
 
 		arvif = arsta->arvif;
+		ahvif = arvif->ahvif;
 		ar = arvif->ar;
 
 		if (arvif->set_wds_vdev_param)
-			goto skip_use_4addr;
+			goto skip_nawds;
 
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 			   "setting USE_4ADDR for peer %pM\n", arsta->addr);
@@ -6603,7 +6605,21 @@ static int ath12k_mac_sta_set_4addr(struct wiphy *wiphy, struct ath12k_sta *ahst
 			return ret;
 		}
 
-skip_use_4addr:
+		if (ahvif->dp_vif.tx_encap_type != ATH12K_HW_TXRX_ETHERNET)
+			goto skip_nawds;
+
+		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+						    WMI_VDEV_PARAM_AP_ENABLE_NAWDS,
+						    WDS_EXT_ENABLE);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set vdev %d nawds parameter: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+
+		arvif->nawds_enabled = true;
+
+skip_nawds:
 		dp = ath12k_ab_to_dp(ar->ab);
 		spin_lock_bh(&dp->dp_lock);
 		peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
@@ -10094,12 +10110,14 @@ static void ath12k_mac_update_vif_offload(struct ath12k_link_vif *arvif)
 		vif->offload_flags &= ~(IEEE80211_OFFLOAD_ENCAP_ENABLED |
 					IEEE80211_OFFLOAD_DECAP_ENABLED);
 
-	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_ETHERNET;
-	else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags))
+		vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+	} else if (test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_RAW;
-	else
+	} else {
 		ahvif->dp_vif.tx_encap_type = ATH12K_HW_TXRX_NATIVE_WIFI;
+	}
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, ahvif->dp_vif.tx_encap_type);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 42488b465540..f7f0f613b393 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -224,6 +224,8 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 						       HTT_TCL_META_DATA_PEER_ID) |
 				       u16_encode_bits(0,
 						       HTT_TCL_META_DATA_VALID_HTT);
+		arsta->ast_hash = peer->ast_hash;
+		arsta->ast_idx = peer->hw_peer_id;
 		peer->link_id = arsta->link_id;
 
 		/* Fill ML info into created peer */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 5f298133dee9..d2749de44553 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -57,6 +57,8 @@ static int ath12k_wifi7_dp_prepare_htt_metadata(struct sk_buff *skb)
 	return 0;
 }
 
+#define ATH12K_AST_HASH_MASK	0xF
+
 /* TODO: Remove the export once this file is built with wifi7 ko */
 int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *arvif,
 		       struct ath12k_link_sta *arsta, struct sk_buff *skb,
@@ -78,6 +80,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	struct ath12k_dp_vif *dp_vif = &ahvif->dp_vif;
 	struct ath12k_dp_link_vif *dp_link_vif;
 	struct dp_tx_ring *tx_ring;
+	struct ethhdr *eth = NULL;
 	u8 pool_id;
 	u8 hal_ring_id;
 	int ret;
@@ -96,6 +99,9 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	    !ieee80211_is_data(hdr->frame_control))
 		return -EOPNOTSUPP;
 
+	if (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP)
+		eth = (struct ethhdr *)skb->data;
+
 	pool_id = skb_get_queue_mapping(skb) & (ATH12K_HW_MAX_QUEUES - 1);
 
 	/* Let the default ring selection be based on current processor
@@ -124,9 +130,16 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 
 	ti.bank_id = dp_link_vif->bank_id;
 	ti.meta_data_flags = dp_link_vif->tcl_metadata;
+	ti.bss_ast_hash = dp_link_vif->ast_hash;
+	ti.bss_ast_idx = dp_link_vif->ast_idx;
 
-	if (ieee80211_has_a4(hdr->frame_control) &&
-	    is_multicast_ether_addr(hdr->addr3) && arsta) {
+	if (eth && is_multicast_ether_addr(eth->h_dest) && arsta) {
+		ti.meta_data_flags = arsta->tcl_metadata;
+		ti.bss_ast_hash = arsta->ast_hash & ATH12K_AST_HASH_MASK;
+		ti.bss_ast_idx = arsta->ast_idx;
+		ti.lookup_override = true;
+	} else if (!eth && ieee80211_has_a4(hdr->frame_control) &&
+		   is_multicast_ether_addr(hdr->addr3) && arsta) {
 		ti.meta_data_flags = arsta->tcl_metadata;
 		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
 	}
@@ -146,7 +159,7 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		msdu_ext_desc = true;
 	}
 
-	if (gsn_valid) {
+	if (gsn_valid && !ti.lookup_override) {
 		/* Reset and Initialize meta_data_flags with Global Sequence
 		 * Number (GSN) info.
 		 */
@@ -154,6 +167,14 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
 					HTT_TCL_META_DATA_TYPE) |
 			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
+
+		/*
+		 * Since NAWDS enabled for this vdev firmware expects
+		 * this flag to be set for sending 3-address multicast frame.
+		 */
+		ti.meta_data_flags |=
+			u32_encode_bits(arvif->nawds_enabled,
+					HTT_TCL_META_DATA_GLOBAL_SEQ_HOST_INSPECTED);
 	}
 
 	ti.encap_type = ath12k_dp_tx_get_encap_type(ab, skb);
@@ -164,11 +185,13 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 	ti.lmac_id = dp_link_vif->lmac_id;
 
 	ti.vdev_id = dp_link_vif->vdev_id;
-	if (gsn_valid)
+
+	if (gsn_valid && !ti.lookup_override)
 		ti.vdev_id += HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
+	else if (arvif->nawds_enabled && is_mcast && !ti.lookup_override)
+		ti.meta_data_flags |=
+			u32_encode_bits(1, HTT_TCL_META_DATA_HOST_INSPECTED_MISSION);
 
-	ti.bss_ast_hash = dp_link_vif->ast_hash;
-	ti.bss_ast_idx = dp_link_vif->ast_idx;
 	ti.dscp_tid_tbl_idx = 0;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index 02d3cadf03fe..eeabe9db776e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -59,7 +59,9 @@ void ath12k_wifi7_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
 		le32_encode_bits(ti->lmac_id, HAL_TCL_DATA_CMD_INFO3_PMAC_ID) |
 		le32_encode_bits(ti->vdev_id, HAL_TCL_DATA_CMD_INFO3_VDEV_ID);
 
-	tcl_cmd->info4 = le32_encode_bits(ti->bss_ast_idx,
+	tcl_cmd->info4 = le32_encode_bits(ti->lookup_override,
+					  HAL_TCL_DATA_CMD_INFO4_IDX_LOOKUP_OVERRIDE) |
+			 le32_encode_bits(ti->bss_ast_idx,
 					  HAL_TCL_DATA_CMD_INFO4_SEARCH_INDEX) |
 			 le32_encode_bits(ti->bss_ast_hash,
 					  HAL_TCL_DATA_CMD_INFO4_CACHE_SET_NUM);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
index 9d2b1552c2f5..c548a0fbf1bb 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
@@ -34,6 +34,7 @@ struct hal_tx_info {
 	u8 dscp_tid_tbl_idx;
 	bool enable_mesh;
 	int bank_id;
+	bool lookup_override;
 };
 
 /* TODO: Check if the actual desc macros can be used instead */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 25e61cc7e5ac..eaed1c4ddd55 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4192,7 +4192,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_base *ab,
 			cpu_to_le32(1 << WMI_RSRC_CFG_HOST_SVC_FLAG_REO_QREF_SUPPORT_BIT);
 	wmi_cfg->ema_max_vap_cnt = cpu_to_le32(tg_cfg->ema_max_vap_cnt);
 	wmi_cfg->ema_max_profile_period = cpu_to_le32(tg_cfg->ema_max_profile_period);
-	wmi_cfg->flags2 |= cpu_to_le32(WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET);
+	wmi_cfg->flags2 |= cpu_to_le32(WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET |
+				       WMI_RSRC_CFG_FLAGS2_FW_AST_INDICATION_DISABLE);
 }
 
 static int ath12k_init_cmd_send(struct ath12k_wmi_pdev *wmi,
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index a827b3c99f8f..13d82f706d79 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2334,6 +2334,14 @@ enum wmi_preamble {
 	WMI_VDEV_PREAMBLE_SHORT = 2,
 };
 
+/*
+ * This will be used to set for  WMI_VDEV_PARAM_AP_ENABLE_NAWDS
+ * whenever 4addr station connects in wds offload case.
+ * This is for enabling multicast to unicast conversion support in
+ * firmware
+ */
+#define WDS_EXT_ENABLE 1
+
 enum wmi_peer_4addr_allow_frame {
 	WMI_PEER_4ADDR_ALLOW_DATA_FRAME = 1,
 	WMI_PEER_4ADDR_ALLOW_EAPOL_DATA_FRAME = 2,
@@ -2559,6 +2567,7 @@ struct wmi_init_cmd {
 #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
 #define WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET      BIT(9)
+#define WMI_RSRC_CFG_FLAGS2_FW_AST_INDICATION_DISABLE	BIT(18)
 #define WMI_RSRC_CFG_FLAG1_ACK_RSSI	BIT(18)
 
 struct ath12k_wmi_resource_config_params {
-- 
2.34.1


