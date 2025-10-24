Return-Path: <linux-wireless+bounces-28235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7FC07B32
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66F73BDE16
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED7313557;
	Fri, 24 Oct 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sub6LvYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D826E708
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329782; cv=none; b=VtyF0UUukt8HICvMC4H3Yt3rdYmQmbDsa21xD/KvxwMF9JLJrW3Re1RcFhaJjF8IaliNWvOVw37ePnSkNJFzCy3piOLNdu6erqxmkGKRFd4hNnPKew6jjuoDLmV4kaCHX9hULVM4f7aOT+tj2yNuVN2VQfikb6W5jLtIgoVWi1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329782; c=relaxed/simple;
	bh=2XU0/UywDihOD/vyIi1KxpyoPjNbxINSYoMSnRJh+6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjJu53mQnM2olm7i3eRc6DwR8f90h8rHFmY8Jstbm9TgxOUAWSRpI71BhgcoJlF4g7QSKYj8XCPNHkKj3knAvFmyXFDA7qnP1MwhdrR//NJCE45UMWM8yFR+bBhAK2o7iFq3xlLwQP0WEOFPckYoEt+/ZYKO0npeR1nWnP5XTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sub6LvYR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9I7p028823;
	Fri, 24 Oct 2025 18:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fg91SFGOKSnF7WZlDliD0QSXJw67asu5TuozQDG0kpg=; b=Sub6LvYRdU3zQD+s
	kKh0uyvKLm/oUIOcblfqwxumEHQKcY0bos5/YqhX6s86EVFqWfWf+FlCuifHGEsH
	MfAutRi86mlEXJwmyMghvnBwEeyZ9T9lNKb8g1W/6jPorihX8YdOqtdWy/jz3xpa
	IrKEVffhmCGEJ4yth8Jubu7p4nVk6FBES7DGE0IoVmBD5cA54u7yJDl9j49WlsoB
	wbvKYTj36rU8Z8gCtz81YdBPOmAP40jW+/cdeFLYXETcGwb/WdmZhCW4sCmk1bf/
	gfx6+cT7Cew2N+BSavuEbXqX9v+BuSpsGZnF/OO2cT++WSsi6/Pz/1GhjRw5Sv30
	L2pmcw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8cuw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGGPh022193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:16 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:15 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 7/9] wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
Date: Fri, 24 Oct 2025 23:45:46 +0530
Message-ID: <20251024181548.3255166-8-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX9ys6+z7e8N0e
 moHqwp9NYnDVn+uqNFc5A39FhHw6X/tm6NjLSmncLCIG1m07m4k+cjwAaTnhYv1a5zU5/KA46YE
 YKVCcvI6Cr46DpQLRh9clZw093OFFmpLiAb1hUCke50Y45es+fhLHaCoHjtgoioWIAIzOsJCCwZ
 u+iT/odqscNltbnSeCNXYiASIFUYRdd5g8LhWRDSS5j0hK8zGIF3NFfs3tmOLTkMwivy0tzKQKL
 M4+UIpK7hjAK2zqNy2kApLdaJB4oLOrLDLbj6po8BGjtSp0Dp1GRUihFWl2Q4GTOhf4kHe7ERn4
 6KBh7O4h4bxw67w/mSJ9vvWPp9SprNMTiU7YZ+3J6vhiOMYUOhj2wD0IUVyKHF3GYVqNFrAbw8l
 aYdXUeTV4OC+g5ks+YbVEV9po6sFNg==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fbc271 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=8i08fjtQ7wQP8W3JMM8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CUUhpzU1E6LyBTNUEL40nPpZAYd0cTTU
X-Proofpoint-ORIG-GUID: CUUhpzU1E6LyBTNUEL40nPpZAYd0cTTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Introduce explicit attach/detach of ath12k_dp_link_peer objects to their parent
ath12k_dp_peer to formalize the data path station hierarchy:

    ath12k_dp_peer
       |
       |--> ath12k_dp_link_peer
       |
       |--> ath12k_dp_link_peer
       |
       |--> ath12k_dp_link_peer

ath12k_dp_peer maintains an array of RCU-protected pointers
"link_peers[ATH12K_NUM_MAX_LINKS]" to ath12k_dp_link_peer indexed by its
protocol_link_id, and each ath12k_dp_link_peer holds a back pointer to its
parent ath12k_dp_peer.

Attach is performed after link peer creation, and detach occurs before link peer
deletion. This ensures consistent lifetime management and safe concurrent
access.

ath12k_dp_peer also maintains an array "hw_links[ATH12K_GROUP_MAX_RADIO]" to
store the mapping between hw_link_id and protocol_link_id for each of the
ath12k_dp_link_peer.

RCU locking/unlocking rules:
- Readers must hold rcu_read_lock() and fetch the pointer with
  rcu_dereference(dp_peer->link[link_id]); drop with rcu_read_unlock() when
  done.
- Writers publish with rcu_assign_pointer() and reclaim only after
  synchronize_rcu().

Handle the case of detachment of link peer from ath12k_dp_peer in case of core
reset.

Ensure the following order of locks to be followed for attach and detach:
- Lock dp->dp_lock
   - Lock dp_hw->peer_lock
   - Unlock dp_hw->peer_lock
- Unlock dp->dp_lock

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c      |   1 +
 drivers/net/wireless/ath/ath12k/dp.h      |   1 +
 drivers/net/wireless/ath/ath12k/dp_cmn.h  |   6 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c | 146 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/dp_peer.h |   7 ++
 drivers/net/wireless/ath/ath12k/mac.c     |  21 +++-
 drivers/net/wireless/ath/ath12k/peer.c    |  17 ++-
 7 files changed, 189 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 676af752f069..e682c0cd18ad 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -887,6 +887,7 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 		dp_pdev->hw = ar->ah->hw;
 		dp_pdev->dp = dp;
 		dp_pdev->hw_link_id = ar->hw_link_id;
+		dp_pdev->dp_hw = &ar->ah->dp_hw;
 
 		ret = ath12k_dp_rx_pdev_alloc(ab, i);
 		if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index b90725094111..1ffa3066ade5 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -158,6 +158,7 @@ struct ath12k_pdev_dp {
 	struct ath12k_dp *dp;
 	struct ieee80211_hw *hw;
 	u8 hw_link_id;
+	struct ath12k_dp_hw *dp_hw;
 
 	/* Protects ppdu stats */
 	spinlock_t ppdu_list_lock;
diff --git a/drivers/net/wireless/ath/ath12k/dp_cmn.h b/drivers/net/wireless/ath/ath12k/dp_cmn.h
index 52b7fa2eb138..dd10426bd12d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_cmn.h
+++ b/drivers/net/wireless/ath/ath12k/dp_cmn.h
@@ -86,5 +86,9 @@ void ath12k_dp_cmn_hw_group_unassign(struct ath12k_dp *dp,
 				     struct ath12k_hw_group *ag);
 void ath12k_dp_cmn_hw_group_assign(struct ath12k_dp *dp,
 				   struct ath12k_hw_group *ag);
-
+int ath12k_dp_link_peer_assign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_hw,
+			       u8 vdev_id, struct ieee80211_sta *sta, u8 *addr,
+			       u8 link_id, u32 hw_link_id);
+void ath12k_dp_link_peer_unassign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_hw,
+				  u8 vdev_id, u8 *addr, u32 hw_link_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index a2834d043dd5..fe4748648a84 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -139,7 +139,6 @@ void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
 		   peer->vdev_id, peer->addr, peer_id);
 
-	ath12k_dp_link_peer_rhash_delete(dp, peer);
 	list_del(&peer->list);
 	kfree(peer);
 	wake_up(&ab->peer_mapping_wq);
@@ -153,7 +152,6 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 {
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
-	int ret;
 
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
@@ -167,11 +165,7 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 		peer->ast_hash = ast_hash;
 		peer->hw_peer_id = hw_peer_id;
 		ether_addr_copy(peer->addr, mac_addr);
-		ret = ath12k_dp_link_peer_rhash_add(dp, peer);
-		if (!ret)
-			list_add(&peer->list, &dp->peers);
-		else
-			kfree(peer);
+		list_add(&peer->list, &dp->peers);
 		wake_up(&ab->peer_mapping_wq);
 	}
 
@@ -377,6 +371,23 @@ static struct ath12k_dp_peer *ath12k_dp_peer_create_find(struct ath12k_dp_hw *dp
 	return NULL;
 }
 
+/*
+ * Index of ath12k_dp_peer for MLO client is same as peer id of ath12k_dp_peer,
+ * while for ath12k_dp_link_peer(mlo and non-mlo) and ath12k_dp_peer for
+ * Non-MLO client it is derived as ((DEVICE_ID << 10) | (10 bits of peer id)).
+ *
+ * This is done because ml_peer_id and peer_id_table are at hw granularity,
+ * while link_peer_id is at device granularity, hence in order to avoid
+ * conflict this approach is followed.
+ */
+#define ATH12K_DP_PEER_TABLE_DEVICE_ID_SHIFT        10
+
+u16 ath12k_dp_peer_get_peerid_index(struct ath12k_dp *dp, u16 peer_id)
+{
+	return (peer_id & ATH12K_PEER_ML_ID_VALID) ? peer_id :
+		((dp->device_id << ATH12K_DP_PEER_TABLE_DEVICE_ID_SHIFT) | peer_id);
+}
+
 int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
 			  struct ath12k_dp_peer_create_params *params)
 {
@@ -451,3 +462,124 @@ void ath12k_dp_peer_delete(struct ath12k_dp_hw *dp_hw, u8 *addr,
 	synchronize_rcu();
 	kfree(dp_peer);
 }
+
+int ath12k_dp_link_peer_assign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_hw,
+			       u8 vdev_id, struct ieee80211_sta *sta, u8 *addr,
+			       u8 link_id, u32 hw_link_id)
+{
+	struct ath12k_dp_peer *dp_peer;
+	struct ath12k_dp_link_peer *peer, *temp_peer;
+	u16 peerid_index;
+	int ret = -EINVAL;
+	u8 *dp_peer_mac = !sta ? addr : sta->addr;
+
+	spin_lock_bh(&dp->dp_lock);
+
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, addr);
+	if (!peer) {
+		ath12k_warn(dp, "failed to find dp_link_peer with mac %pM on vdev %u\n",
+			    addr, vdev_id);
+		ret = -ENOENT;
+		goto err_peer;
+	}
+
+	spin_lock_bh(&dp_hw->peer_lock);
+
+	dp_peer = ath12k_dp_peer_find_by_addr_and_sta(dp_hw, dp_peer_mac, sta);
+	if (!dp_peer) {
+		ath12k_warn(dp, "failed to find dp_peer with mac %pM\n", dp_peer_mac);
+		ret = -ENOENT;
+		goto err_dp_peer;
+	}
+
+	/*
+	 * Set peer_id in dp_peer for non-mlo client, peer_id for mlo client is
+	 * set during dp_peer create
+	 */
+	if (!dp_peer->is_mlo)
+		dp_peer->peer_id = peer->peer_id;
+
+	peer->dp_peer = dp_peer;
+	peer->hw_link_id = hw_link_id;
+
+	dp_peer->hw_links[peer->hw_link_id] = link_id;
+
+	peerid_index = ath12k_dp_peer_get_peerid_index(dp, peer->peer_id);
+
+	rcu_assign_pointer(dp_peer->link_peers[peer->link_id], peer);
+
+	rcu_assign_pointer(dp_hw->dp_peers[peerid_index], dp_peer);
+
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	/*
+	 * In case of Split PHY and roaming scenario, pdev idx
+	 * might differ but both the pdev will share same rhash
+	 * table. In that case update the rhash table if link_peer is
+	 * already present
+	 */
+	temp_peer = ath12k_dp_link_peer_find_by_addr(dp, addr);
+	if (temp_peer && temp_peer->hw_link_id != hw_link_id)
+		ath12k_dp_link_peer_rhash_delete(dp, temp_peer);
+
+	ret = ath12k_dp_link_peer_rhash_add(dp, peer);
+	if (ret) {
+		/*
+		 * If new entry addition failed, add back old entry
+		 * If old entry addition also fails, then nothing
+		 * can be done, simply proceed
+		 */
+		if (temp_peer)
+			ath12k_dp_link_peer_rhash_add(dp, temp_peer);
+	}
+
+	spin_unlock_bh(&dp->dp_lock);
+
+	return ret;
+
+err_dp_peer:
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+err_peer:
+	spin_unlock_bh(&dp->dp_lock);
+
+	return ret;
+}
+
+void ath12k_dp_link_peer_unassign(struct ath12k_dp *dp, struct ath12k_dp_hw *dp_hw,
+				  u8 vdev_id, u8 *addr, u32 hw_link_id)
+{
+	struct ath12k_dp_peer *dp_peer;
+	struct ath12k_dp_link_peer *peer, *temp_peer;
+	u16 peerid_index;
+
+	spin_lock_bh(&dp->dp_lock);
+
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, addr);
+	if (!peer || !peer->dp_peer) {
+		spin_unlock_bh(&dp->dp_lock);
+		return;
+	}
+
+	spin_lock_bh(&dp_hw->peer_lock);
+
+	dp_peer = peer->dp_peer;
+	dp_peer->hw_links[peer->hw_link_id] = 0;
+
+	peerid_index = ath12k_dp_peer_get_peerid_index(dp, peer->peer_id);
+
+	rcu_assign_pointer(dp_peer->link_peers[peer->link_id], NULL);
+
+	rcu_assign_pointer(dp_hw->dp_peers[peerid_index], NULL);
+
+	spin_unlock_bh(&dp_hw->peer_lock);
+
+	/* To handle roaming and split phy scenario */
+	temp_peer = ath12k_dp_link_peer_find_by_addr(dp, addr);
+	if (temp_peer && temp_peer->hw_link_id == hw_link_id)
+		ath12k_dp_link_peer_rhash_delete(dp, peer);
+
+	spin_unlock_bh(&dp->dp_lock);
+
+	synchronize_rcu();
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index b4aa4f09337e..36cce6620310 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -26,6 +26,7 @@ struct ppdu_user_delayba {
 struct ath12k_dp_link_peer {
 	struct list_head list;
 	struct ieee80211_sta *sta;
+	struct ath12k_dp_peer *dp_peer;
 	int vdev_id;
 	u8 addr[ETH_ALEN];
 	int peer_id;
@@ -68,6 +69,8 @@ struct ath12k_dp_link_peer {
 
 	/* peer addr based rhashtable list pointer */
 	struct rhash_head rhash_addr;
+
+	u8 hw_link_id;
 };
 
 void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
@@ -81,10 +84,13 @@ struct ath12k_dp_peer {
 	u8 addr[ETH_ALEN];
 	bool is_mlo;
 
+	struct ath12k_dp_link_peer __rcu *link_peers[ATH12K_NUM_MAX_LINKS];
+
 	u16 sec_type;
 	u16 sec_type_grp;
 
 	bool ucast_ra_only;
+	u8 hw_links[ATH12K_GROUP_MAX_RADIO];
 };
 
 struct ath12k_dp_link_peer *
@@ -116,4 +122,5 @@ struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr(struct ath12k_dp_hw *dp_hw, u
 struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr_and_sta(struct ath12k_dp_hw *dp_hw,
 							   u8 *addr,
 							   struct ieee80211_sta *sta);
+u16 ath12k_dp_peer_get_peerid_index(struct ath12k_dp *dp, u16 peer_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 42fbfb13f23f..02168a857e0a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1181,6 +1181,11 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_link_vif *arvif, *tmp_vif;
 	struct ath12k_dp_hw *dp_hw = &ar->ah->dp_hw;
+	struct ath12k_dp_peer *dp_peer = NULL;
+	u16 peerid_index;
+	struct list_head peers;
+
+	INIT_LIST_HEAD(&peers);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -1190,12 +1195,26 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 		if (peer->sta)
 			ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 
+		/* cleanup dp peer */
+		spin_lock_bh(&dp_hw->peer_lock);
+		dp_peer = peer->dp_peer;
+		peerid_index = ath12k_dp_peer_get_peerid_index(dp, peer->peer_id);
+		rcu_assign_pointer(dp_peer->link_peers[peer->link_id], NULL);
+		rcu_assign_pointer(dp_hw->dp_peers[peerid_index], NULL);
+		spin_unlock_bh(&dp_hw->peer_lock);
+
 		ath12k_dp_link_peer_rhash_delete(dp, peer);
 
+		list_move(&peer->list, &peers);
+	}
+	spin_unlock_bh(&dp->dp_lock);
+
+	synchronize_rcu();
+
+	list_for_each_entry_safe(peer, tmp, &peers, list) {
 		list_del(&peer->list);
 		kfree(peer);
 	}
-	spin_unlock_bh(&dp->dp_lock);
 
 	ar->num_peers = 0;
 	ar->num_stations = 0;
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 691314efe23f..8b6fea685a70 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -110,6 +110,10 @@ int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	ath12k_dp_link_peer_unassign(ath12k_ab_to_dp(ar->ab),
+				     &(ath12k_ar_to_ah(ar)->dp_hw), vdev_id,
+				     addr, ar->hw_link_id);
+
 	ret = ath12k_peer_delete_send(ar, vdev_id, addr);
 	if (ret)
 		return ret;
@@ -243,7 +247,13 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	spin_unlock_bh(&dp->dp_lock);
 
-	return 0;
+	ret = ath12k_dp_link_peer_assign(ath12k_ab_to_dp(ar->ab),
+					 &(ath12k_ar_to_ah(ar)->dp_hw),
+					 arvif->vdev_id, sta,
+					 (u8 *)arg->peer_addr, link_id,
+					 ar->hw_link_id);
+
+	return ret;
 }
 
 u16 ath12k_peer_ml_alloc(struct ath12k_hw *ah)
@@ -298,6 +308,11 @@ int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_st
 
 		ath12k_dp_peer_cleanup(ar, arvif->vdev_id, arsta->addr);
 
+		ath12k_dp_link_peer_unassign(ath12k_ab_to_dp(ar->ab),
+					     &(ath12k_ar_to_ah(ar)->dp_hw),
+					     arvif->vdev_id, arsta->addr,
+					     ar->hw_link_id);
+
 		ret = ath12k_peer_delete_send(ar, arvif->vdev_id, arsta->addr);
 		if (ret) {
 			ath12k_warn(ar->ab,
-- 
2.34.1


