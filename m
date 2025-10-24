Return-Path: <linux-wireless+bounces-28233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA00C07AE3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B48874F8653
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF8270553;
	Fri, 24 Oct 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lY4Zpp99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0883262FCB
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329781; cv=none; b=QV0jXuUbSxWggg3WhUwbbxtNhM89AmT+ycn7f5swa6887W6M+dGhMOZoIzX3UA9HJTPprZht03X9CBo728ubtnthzysOrtZA1PljJfUtVdLGpbU/jB61kKTxefKMmKkx2Tu3ttYV7KXhht8JQcCbR1n5T/8pfwHj7wGGvSN4rGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329781; c=relaxed/simple;
	bh=uVq8y1w6zSojtdO/wSwZT42wN4ybsUaGwvPF5WNTlfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVws2VfJBqkq5rIwo+ig4okgNE/hXaS4/Q4H4pdt6KtdjFyfqkM9VkBveD8RUHM/DxFnrxJqLHxPE8RD7Xs1A2XNOXrqLDLqS81PmppIhq3trZiwkbvXo+py2dZCERDKD5V/uf4Rhc2Z+BrQfnuUf8l1OXCAexi/E9CtTjn1ABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lY4Zpp99; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9eeZ010767;
	Fri, 24 Oct 2025 18:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i4+fH7s/B9XD6LhO6P6Fg4AStFEGr1cOkH3h1SdRvPI=; b=lY4Zpp99uK9T7yFG
	Y/mgtFYRQvW8HaeyPlyHKqBmZryuNdtPrbbK8oNp+E9ulB62ptX+94kAfFaIRzgW
	6Hg4pNmQl7pyAQd9CpTlyxeHu/DhJJFy7RgWqif5GuIdQXdWb8CiMAEbuBHXiBGR
	A1tMkUOhjTCbT7AUvWBOq9j9c7XcjAcSSed6Is40bqZgq9c5g5S8uJyQG4gRGe1t
	Ie2f9bH/bAXlstUcH5wGNRNAMWz4RUcIbMXIDr3AG5Xv0qz4fmkZgvZSqfMXok4c
	qJXz/vr/yGk+DwqkqbCRJNPf8n7kNjFgXInKJFnz4k1VyZPcVIqZ3RTyNlCmzwgz
	MaPPDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jcsvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGEgG010155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:14 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:13 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 6/9] wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete
Date: Fri, 24 Oct 2025 23:45:45 +0530
Message-ID: <20251024181548.3255166-7-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXwBjzOqAB+G6e
 GzRLi002Sp48kc/s3RHmPEUAOtUBbYESxXwt8LzLZgKqOJLy+UTgG/ucchlb5wYyoTjiq62K0hO
 q2w0lSCjeOdV22xn9aAJmxD984G7zp7GrENl/f4SANhwoddGdmfsskItXxOJG99uNZjXBKbLnl4
 g2rWkONTgyaI5N6dHSuzR3ysKPLxNsKuZ1zv2sAG7YTblfrS4HE98gbsSSRt559kpE82+tFXsLN
 J0klsgJdoujwyuzbeitMCBr0eJjY9s5qHhFYTHpbbX5F3MqObTNQFn3PFwJ+n2wtbaWozzANEOk
 uZ02yG9ENqBxRjprsPGu8erNd+L2zlBAemC0+6+JX3KE6kTFSMPrqOGCPjio96w0+5VHG2vrhDM
 4jkRgJtLTXojnWFItJbCDx1Qi+fyuQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fbc26f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=O8UYDQwHC_lqwV6is5UA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ID3qmkZ5JQRj681pounp1owQ0MVgYbIG
X-Proofpoint-ORIG-GUID: ID3qmkZ5JQRj681pounp1owQ0MVgYbIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Define the structure of ath12k_dp_peer and also define APIs for creation and
deletion of ath12k_dp_peer based on STA state, as the ath12k_dp_peer is intended
to be used in the subsequent set of patches.

Maintain ath12k_dp_peer in a linked list in ath12k_dp_hw (which is a datapath
component of ath12k_hw) and protect this list using spinlock "peer_lock".

Store peer id based table (array of RCU pointers) of ath12k_dp_peer in
ath12k_dp_hw. Use this peer id table to refer in the per packet Tx and Rx paths
as it provides faster access to ath12k_dp_peer in comparison to linked list
iterative search using peer id or mac address.

Add support to handle deletion of ath12k_dp_peer in case of core reset.

This patch is adding and deleting ath12k_dp_peer created for MLO STA to the
above mentioned RCU pointer table. Addition and deletion of ath12k_dp_peer for
non-MLO STA to RCU pointer table is handled in the subsequent following patch.

Structure ath12k_ml_peer is created and deleted for MLO peers at the time
of connect and disconnect and there is no other use case of it. With the
above design in place for ath12k_dp_peer, ath12k_ml_peer becomes redundant.
Hence, remove the structure ath12k_ml_peer and the list "ml_peers" present
in ath12k_hw maintaining linked list of ath12k_ml_peer.

APIs removed:
 - ath12k_peer_ml_find()
 - ath12k_peer_ml_create()
 - ath12k_peer_ml_delete()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c     |   1 +
 drivers/net/wireless/ath/ath12k/core.h     |   3 +-
 drivers/net/wireless/ath/ath12k/dp_cmn.h   |  22 ++++
 drivers/net/wireless/ath/ath12k/dp_peer.c  | 126 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_peer.h  |  24 ++++
 drivers/net/wireless/ath/ath12k/mac.c      | 115 +++++++++++++++++--
 drivers/net/wireless/ath/ath12k/mac.h      |   1 +
 drivers/net/wireless/ath/ath12k/peer.c     |  81 +------------
 drivers/net/wireless/ath/ath12k/peer.h     |   9 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c |  14 ++-
 10 files changed, 291 insertions(+), 105 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 2e093029c782..3bba9c9a1a9b 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1576,6 +1576,7 @@ static void ath12k_core_post_reconfigure_recovery(struct ath12k_base *ab)
 				ath12k_core_halt(ar);
 			}
 
+			ath12k_mac_dp_peer_cleanup(ah);
 			break;
 		case ATH12K_HW_STATE_OFF:
 			ath12k_warn(ab,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index eb406fc9ab71..6dc4498749c3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -836,8 +836,7 @@ struct ath12k_hw {
 
 	DECLARE_BITMAP(free_ml_peer_id_map, ATH12K_MAX_MLO_PEERS);
 
-	/* protected by wiphy_lock() */
-	struct list_head ml_peers;
+	struct ath12k_dp_hw dp_hw;
 
 	/* Keep last */
 	struct ath12k radio[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
index 243fb5a68016..52b7fa2eb138 100644
--- a/drivers/net/wireless/ath/ath12k/dp_cmn.h
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -10,6 +10,21 @@
 
 struct ath12k_hw_group;
 
+/*
+ * ML Peer IDs start from 8192, assuming max SLO clients count 1536,
+ * then max peer id shall be 9728, therefore rounding the peer table size
+ * to the nearest next power of 2 i.e 16384.
+ */
+#define MAX_DP_PEER_LIST_SIZE  16384
+
+struct ath12k_dp_hw {
+	struct ath12k_dp_peer __rcu *dp_peers[MAX_DP_PEER_LIST_SIZE];
+
+	/* Lock for protection of dp_peer_list and peers */
+	spinlock_t peer_lock;
+	struct list_head dp_peers_list;
+};
+
 struct ath12k_dp_hw_group {
 	struct ath12k_dp *dp[ATH12K_MAX_DEVICES];
 };
@@ -52,6 +67,13 @@ struct ath12k_per_peer_tx_stats {
 	bool is_ampdu;
 };
 
+struct ath12k_dp_peer_create_params {
+	struct ieee80211_sta *sta;
+	bool is_mlo;
+	u16 peer_id;
+	bool ucast_ra_only;
+};
+
 static inline struct ath12k_dp_link_vif *
 ath12k_dp_vif_to_dp_link_vif(struct ath12k_dp_vif *dp_vif, u8 link_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 0cf28791568e..a2834d043dd5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -325,3 +325,129 @@ void ath12k_dp_link_peer_rhash_delete(struct ath12k_dp *dp,
 		ath12k_warn(dp, "failed to remove peer %pM with id %d in rhash_addr ret %d\n",
 			    peer->addr, peer->peer_id, ret);
 }
+
+struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr(struct ath12k_dp_hw *dp_hw, u8 *addr)
+{
+	struct ath12k_dp_peer *peer;
+
+	lockdep_assert_held(&dp_hw->peer_lock);
+
+	list_for_each_entry(peer, &dp_hw->dp_peers_list, list) {
+		if (ether_addr_equal(peer->addr, addr))
+			return peer;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ath12k_dp_peer_find_by_addr);
+
+struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr_and_sta(struct ath12k_dp_hw *dp_hw,
+							   u8 *addr,
+							   struct ieee80211_sta *sta)
+{
+	struct ath12k_dp_peer *dp_peer;
+
+	lockdep_assert_held(&dp_hw->peer_lock);
+
+	list_for_each_entry(dp_peer, &dp_hw->dp_peers_list, list) {
+		if (ether_addr_equal(dp_peer->addr, addr) && (dp_peer->sta == sta))
+			return dp_peer;
+	}
+
+	return NULL;
+}
+
+static struct ath12k_dp_peer *ath12k_dp_peer_create_find(struct ath12k_dp_hw *dp_hw,
+							 u8 *addr,
+							 struct ieee80211_sta *sta,
+							 bool mlo_peer)
+{
+	struct ath12k_dp_peer *dp_peer;
+
+	lockdep_assert_held(&dp_hw->peer_lock);
+
+	list_for_each_entry(dp_peer, &dp_hw->dp_peers_list, list) {
+		if (ether_addr_equal(dp_peer->addr, addr)) {
+			if (!sta || mlo_peer || dp_peer->is_mlo ||
+			    dp_peer->sta == sta)
+				return dp_peer;
+		}
+	}
+
+	return NULL;
+}
+
+int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
+			  struct ath12k_dp_peer_create_params *params)
+{
+	struct ath12k_dp_peer *dp_peer;
+
+	spin_lock_bh(&dp_hw->peer_lock);
+	dp_peer = ath12k_dp_peer_create_find(dp_hw, addr, params->sta, params->is_mlo);
+	if (dp_peer) {
+		spin_unlock_bh(&dp_hw->peer_lock);
+		return -EEXIST;
+	}
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	dp_peer = kzalloc(sizeof(*dp_peer), GFP_ATOMIC);
+	if (!dp_peer)
+		return -ENOMEM;
+
+	ether_addr_copy(dp_peer->addr, addr);
+	dp_peer->sta = params->sta;
+	dp_peer->is_mlo = params->is_mlo;
+
+	/*
+	 * For MLO client, the host assigns the ML peer ID, so set peer_id in dp_peer
+	 * For non-MLO client, host gets link peer ID from firmware and will be
+	 * assigned at the time of link peer creation
+	 */
+	dp_peer->peer_id = params->is_mlo ? params->peer_id : ATH12K_DP_PEER_ID_INVALID;
+	dp_peer->ucast_ra_only = params->ucast_ra_only;
+
+	dp_peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
+	dp_peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
+
+	spin_lock_bh(&dp_hw->peer_lock);
+
+	list_add(&dp_peer->list, &dp_hw->dp_peers_list);
+
+	/*
+	 * For MLO client, the peer_id for ath12k_dp_peer is allocated by host
+	 * and that peer_id is known at this point, and hence this ath12k_dp_peer
+	 * can be added to the RCU table using the peer_id.
+	 * For non-MLO client, this addition to RCU table shall be done at the
+	 * time of assignment of ath12k_dp_link_peer to ath12k_dp_peer.
+	 */
+	if (dp_peer->is_mlo)
+		rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], dp_peer);
+
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	return 0;
+}
+
+void ath12k_dp_peer_delete(struct ath12k_dp_hw *dp_hw, u8 *addr,
+			   struct ieee80211_sta *sta)
+{
+	struct ath12k_dp_peer *dp_peer;
+
+	spin_lock_bh(&dp_hw->peer_lock);
+
+	dp_peer = ath12k_dp_peer_find_by_addr_and_sta(dp_hw, addr, sta);
+	if (!dp_peer) {
+		spin_unlock_bh(&dp_hw->peer_lock);
+		return;
+	}
+
+	if (dp_peer->is_mlo)
+		rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
+
+	list_del(&dp_peer->list);
+
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	synchronize_rcu();
+	kfree(dp_peer);
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index b94a9a5cb311..b4aa4f09337e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -9,6 +9,8 @@
 
 #include "dp_rx.h"
 
+#define ATH12K_DP_PEER_ID_INVALID              0x3FFF
+
 struct ppdu_user_delayba {
 	u16 sw_peer_id;
 	u32 info0;
@@ -71,6 +73,20 @@ struct ath12k_dp_link_peer {
 void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
 void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
 				   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
+
+struct ath12k_dp_peer {
+	struct list_head list;
+	struct ieee80211_sta *sta;
+	int peer_id;
+	u8 addr[ETH_ALEN];
+	bool is_mlo;
+
+	u16 sec_type;
+	u16 sec_type_grp;
+
+	bool ucast_ra_only;
+};
+
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_dp *dp,
 					  int vdev_id, const u8 *addr);
@@ -92,4 +108,12 @@ int ath12k_dp_link_peer_rhash_add(struct ath12k_dp *dp,
 				  struct ath12k_dp_link_peer *peer);
 void ath12k_dp_link_peer_rhash_delete(struct ath12k_dp *dp,
 				      struct ath12k_dp_link_peer *peer);
+int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
+			  struct ath12k_dp_peer_create_params *params);
+void ath12k_dp_peer_delete(struct ath12k_dp_hw *dp_hw, u8 *addr,
+			   struct ieee80211_sta *sta);
+struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr(struct ath12k_dp_hw *dp_hw, u8 *addr);
+struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr_and_sta(struct ath12k_dp_hw *dp_hw,
+							   u8 *addr,
+							   struct ieee80211_sta *sta);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c7eeaf586b83..42fbfb13f23f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1179,6 +1179,8 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 	struct ath12k_dp_link_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_link_vif *arvif, *tmp_vif;
+	struct ath12k_dp_hw *dp_hw = &ar->ah->dp_hw;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -1201,6 +1203,42 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 	/* Cleanup rhash table maintained for arsta by iterating over sta */
 	ieee80211_iterate_stations_mtx(ar->ah->hw, ath12k_mac_link_sta_rhash_cleanup,
 				       ar);
+
+	/* Delete all the self dp_peers on asserted radio */
+	list_for_each_entry_safe_reverse(arvif, tmp_vif, &ar->arvifs, list) {
+		if (arvif->ahvif->vdev_type == WMI_VDEV_TYPE_AP) {
+			ath12k_dp_peer_delete(dp_hw, arvif->bssid, NULL);
+			arvif->num_stations = 0;
+		}
+	}
+}
+
+void ath12k_mac_dp_peer_cleanup(struct ath12k_hw *ah)
+{
+	struct list_head peers;
+	struct ath12k_dp_peer *dp_peer, *tmp;
+	struct ath12k_dp_hw *dp_hw = &ah->dp_hw;
+
+	INIT_LIST_HEAD(&peers);
+
+	spin_lock_bh(&dp_hw->peer_lock);
+	list_for_each_entry_safe(dp_peer, tmp, &dp_hw->dp_peers_list, list) {
+		if (dp_peer->is_mlo) {
+			rcu_assign_pointer(dp_hw->dp_peers[dp_peer->peer_id], NULL);
+			clear_bit(dp_peer->peer_id, ah->free_ml_peer_id_map);
+		}
+
+		list_move(&dp_peer->list, &peers);
+	}
+
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	synchronize_rcu();
+
+	list_for_each_entry_safe(dp_peer, tmp, &peers, list) {
+		list_del(&dp_peer->list);
+		kfree(dp_peer);
+	}
 }
 
 static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
@@ -3969,6 +4007,8 @@ static void ath12k_mac_remove_link_interface(struct ieee80211_hw *hw,
 		if (ret)
 			ath12k_warn(ar->ab, "failed to submit AP self-peer removal on vdev %d link id %d: %d",
 				    arvif->vdev_id, arvif->link_id, ret);
+
+		ath12k_dp_peer_delete(&ah->dp_hw, arvif->bssid, NULL);
 	}
 	ath12k_mac_vdev_delete(ar, arvif);
 }
@@ -6625,7 +6665,10 @@ static void ath12k_mac_ml_station_remove(struct ath12k_vif *ahvif,
 		ath12k_mac_free_unassign_link_sta(ah, ahsta, link_id);
 	}
 
-	ath12k_peer_ml_delete(ah, sta);
+	if (sta->mlo) {
+		clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
+		ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
+	}
 }
 
 static int ath12k_mac_handle_link_sta_state(struct ieee80211_hw *hw,
@@ -7064,7 +7107,8 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	u16 selected_links = 0;
 	u8 link_id = 0, i;
 	struct ath12k *ar;
-	int ret;
+	int ret = -EINVAL;
+	struct ath12k_dp_peer_create_params dp_params = {};
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -7087,12 +7131,28 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		/* ML sta */
 		if (sta->mlo && !ahsta->links_map &&
 		    (hweight16(sta->valid_links) == 1)) {
-			ret = ath12k_peer_ml_create(ah, sta);
-			if (ret) {
-				ath12k_hw_warn(ah, "unable to create ML peer for sta %pM",
+			ahsta->ml_peer_id = ath12k_peer_ml_alloc(ah);
+			if (ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID) {
+				ath12k_hw_warn(ah, "unable to allocate ML peer id for sta %pM",
 					       sta->addr);
 				goto exit;
 			}
+
+			dp_params.is_mlo = true;
+			dp_params.peer_id = ahsta->ml_peer_id | ATH12K_PEER_ML_ID_VALID;
+		}
+
+		dp_params.sta = sta;
+
+		if (vif->type == NL80211_IFTYPE_AP)
+			dp_params.ucast_ra_only = true;
+
+		ret = ath12k_dp_peer_create(&ah->dp_hw, sta->addr, &dp_params);
+		if (ret) {
+			ath12k_hw_warn(ah, "unable to create ath12k_dp_peer for sta %pM, ret: %d",
+				       sta->addr, ret);
+
+			goto ml_peer_id_clear;
 		}
 
 		ret = ath12k_mac_assign_link_sta(ah, ahsta, arsta, ahvif,
@@ -7100,7 +7160,7 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_hw_warn(ah, "unable assign link %d for sta %pM",
 				       link_id, sta->addr);
-			goto exit;
+			goto peer_delete;
 		}
 
 		/* above arsta will get memset, hence do this after assign
@@ -7170,7 +7230,12 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_hw_warn(ah, "unable to move link sta %d of sta %pM from state %d to %d",
 				       link_id, arsta->addr, old_state, new_state);
-			goto exit;
+
+			if (old_state == IEEE80211_STA_NOTEXIST &&
+			    new_state == IEEE80211_STA_NONE)
+				goto peer_delete;
+			else
+				goto exit;
 		}
 	}
 
@@ -7198,11 +7263,23 @@ int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	 * handler below
 	 */
 	if (old_state == IEEE80211_STA_NONE &&
-	    new_state == IEEE80211_STA_NOTEXIST && sta->mlo)
-		ath12k_mac_ml_station_remove(ahvif, ahsta);
+	    new_state == IEEE80211_STA_NOTEXIST) {
+		if (sta->mlo)
+			ath12k_mac_ml_station_remove(ahvif, ahsta);
+
+		ath12k_dp_peer_delete(&ah->dp_hw, sta->addr, sta);
+	}
 
 	ret = 0;
+	goto exit;
 
+peer_delete:
+	ath12k_dp_peer_delete(&ah->dp_hw, sta->addr, sta);
+ml_peer_id_clear:
+	if (sta->mlo) {
+		clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
+		ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
+	}
 exit:
 	/* update the state if everything went well */
 	if (!ret)
@@ -9827,6 +9904,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	int ret, vdev_id;
 	u8 link_id;
 	struct ath12k_dp_link_vif *dp_link_vif = NULL;
+	struct ath12k_dp_peer_create_params params = {};
 
 	lockdep_assert_wiphy(hw->wiphy);
 
@@ -9910,6 +9988,15 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 
 	switch (ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_AP:
+		params.ucast_ra_only = true;
+
+		ret = ath12k_dp_peer_create(&ah->dp_hw, arvif->bssid, &params);
+		if (ret) {
+			ath12k_warn(ab, "failed to vdev %d create dp_peer for AP: %d\n",
+				    arvif->vdev_id, ret);
+			goto err_vdev_del;
+		}
+
 		peer_param.vdev_id = arvif->vdev_id;
 		peer_param.peer_addr = arvif->bssid;
 		peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
@@ -9917,7 +10004,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		if (ret) {
 			ath12k_warn(ab, "failed to vdev %d create peer for AP: %d\n",
 				    arvif->vdev_id, ret);
-			goto err_vdev_del;
+			goto err_dp_peer_del;
 		}
 
 		ret = ath12k_mac_set_kickout(arvif);
@@ -10022,6 +10109,10 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		ar->num_peers--;
 	}
 
+err_dp_peer_del:
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_AP)
+		ath12k_dp_peer_delete(&ah->dp_hw, arvif->bssid, NULL);
+
 err_vdev_del:
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ar->monitor_vdev_id = -1;
@@ -14349,7 +14440,9 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
 	ah->num_radio = num_pdev_map;
 
 	mutex_init(&ah->hw_mutex);
-	INIT_LIST_HEAD(&ah->ml_peers);
+
+	spin_lock_init(&ah->dp_hw.peer_lock);
+	INIT_LIST_HEAD(&ah->dp_hw.dp_peers_list);
 
 	for (i = 0; i < num_pdev_map; i++) {
 		ab = pdev_map[i].ab;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 107ce6da2f64..f785a81860ce 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -157,6 +157,7 @@ struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
 
 void ath12k_mac_drain_tx(struct ath12k *ar);
 void ath12k_mac_peer_cleanup_all(struct ath12k *ar);
+void ath12k_mac_dp_peer_cleanup(struct ath12k_hw *ah);
 int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 enum rate_info_bw ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw);
 enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 68eebaa24ed9..691314efe23f 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -8,23 +8,6 @@
 #include "peer.h"
 #include "debug.h"
 
-struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
-{
-	struct ath12k_ml_peer *ml_peer;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	list_for_each_entry(ml_peer, &ah->ml_peers, list) {
-		if (!ether_addr_equal(ml_peer->addr, addr))
-			continue;
-
-		return ml_peer;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(ath12k_peer_ml_find);
-
 static int ath12k_wait_for_dp_link_peer_common(struct ath12k_base *ab, int vdev_id,
 					       const u8 *addr, bool expect_mapped)
 {
@@ -263,7 +246,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	return 0;
 }
 
-static u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
+u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
 {
 	u16 ml_peer_id;
 
@@ -283,68 +266,6 @@ static u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
 	return ml_peer_id;
 }
 
-int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta)
-{
-	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
-	struct ath12k_ml_peer *ml_peer;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	if (!sta->mlo)
-		return -EINVAL;
-
-	ml_peer = ath12k_peer_ml_find(ah, sta->addr);
-	if (ml_peer) {
-		ath12k_hw_warn(ah, "ML peer %d exists already, unable to add new entry for %pM",
-			       ml_peer->id, sta->addr);
-		return -EEXIST;
-	}
-
-	ml_peer = kzalloc(sizeof(*ml_peer), GFP_ATOMIC);
-	if (!ml_peer)
-		return -ENOMEM;
-
-	ahsta->ml_peer_id = ath12k_peer_ml_alloc(ah);
-
-	if (ahsta->ml_peer_id == ATH12K_MLO_PEER_ID_INVALID) {
-		ath12k_hw_warn(ah, "unable to allocate ML peer id for sta %pM",
-			       sta->addr);
-		kfree(ml_peer);
-		return -ENOMEM;
-	}
-
-	ether_addr_copy(ml_peer->addr, sta->addr);
-	ml_peer->id = ahsta->ml_peer_id;
-	list_add(&ml_peer->list, &ah->ml_peers);
-
-	return 0;
-}
-
-int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta)
-{
-	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(sta);
-	struct ath12k_ml_peer *ml_peer;
-
-	lockdep_assert_wiphy(ah->hw->wiphy);
-
-	if (!sta->mlo)
-		return -EINVAL;
-
-	clear_bit(ahsta->ml_peer_id, ah->free_ml_peer_id_map);
-	ahsta->ml_peer_id = ATH12K_MLO_PEER_ID_INVALID;
-
-	ml_peer = ath12k_peer_ml_find(ah, sta->addr);
-	if (!ml_peer) {
-		ath12k_hw_warn(ah, "ML peer for %pM not found", sta->addr);
-		return -EINVAL;
-	}
-
-	list_del(&ml_peer->list);
-	kfree(ml_peer);
-
-	return 0;
-}
-
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta)
 {
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(ahsta);
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index cf8a463d4c37..49d89796bc46 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -9,12 +9,6 @@
 
 #include "dp_peer.h"
 
-struct ath12k_ml_peer {
-	struct list_head list;
-	u8 addr[ETH_ALEN];
-	u16 id;
-};
-
 void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id);
 int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr);
 int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
@@ -22,8 +16,6 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ath12k_wmi_peer_create_arg *arg);
 int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
 				     const u8 *addr);
-int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
-int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
 struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah,
 					   const u8 *addr);
@@ -33,4 +25,5 @@ void ath12k_link_sta_rhash_delete(struct ath12k_base *ab, struct ath12k_link_sta
 int ath12k_link_sta_rhash_add(struct ath12k_base *ab, struct ath12k_link_sta *arsta);
 struct ath12k_link_sta *ath12k_link_sta_find_by_addr(struct ath12k_base *ab,
 						     const u8 *addr);
+u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah);
 #endif /* _PEER_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 80f499b5df35..946771b96fb5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -117,13 +117,19 @@ ath12k_wifi7_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
 	struct ath12k_hw *ah = ath12k_ar_to_ah(arvif->ar);
 	struct ath12k_base *ab = arvif->ar->ab;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_dp_peer *peer;
 	__le16 fc = mgmt->frame_control;
 
 	spin_lock_bh(&dp->dp_lock);
-	if (!ath12k_dp_link_peer_find_by_addr(dp, mgmt->da) &&
-	    !ath12k_peer_ml_find(ah, mgmt->da)) {
-		spin_unlock_bh(&dp->dp_lock);
-		return false;
+	if (!ath12k_dp_link_peer_find_by_addr(dp, mgmt->da)) {
+		spin_lock_bh(&ah->dp_hw.peer_lock);
+		peer = ath12k_dp_peer_find_by_addr(&ah->dp_hw, mgmt->da);
+		if (!peer || (peer && !peer->is_mlo)) {
+			spin_unlock_bh(&ah->dp_hw.peer_lock);
+			spin_unlock_bh(&dp->dp_lock);
+			return false;
+		}
+		spin_unlock_bh(&ah->dp_hw.peer_lock);
 	}
 	spin_unlock_bh(&dp->dp_lock);
 
-- 
2.34.1


