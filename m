Return-Path: <linux-wireless+bounces-28237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF7BC07AE9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11055359910
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B21346E7D;
	Fri, 24 Oct 2025 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f83B+bKS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209A32F76D
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329785; cv=none; b=rdsrUTgIbtU5d4tKi3DxX/06XEarYNCkrq18tCKGQ6EI63flk1CmyJXGuxdk1gM/ZjocmIs1NYdZaeCQtUEe38lXs5snCRlSWqazQM5aconScnqJ/zi70BRgLUow9erjfttiZrFwIRQD5lJU0hUEsTXUJPWJosXFj9rt2OWWQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329785; c=relaxed/simple;
	bh=z/l/sdvOt3sHv9D9fBMCeNtl1yX025pz5LVwUW6WycM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLARacr1+GQrIHUP+uRWd7jyJEDrBsvoq/m85wD+nVf1YBgGWmkLniOrNiE8g5jB3lONSCU8P94jGKUGmGHSWPdt5Lhc6xK46/5d4MYtum/OuJLiRPb4EmngjEzK3aBqBXM3qswLspBwsnOhRV9n8fSR4xrY00RYYISIvh1Y0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f83B+bKS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9Fsi020557;
	Fri, 24 Oct 2025 18:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	16TjB1g7GuXuEKOiJ3ZVzel3MB21lTtwQQCwfaKEMmU=; b=f83B+bKSWg5Dc8W6
	RhJTAKcewWGdN/zTN/eNUwQl5BGe68jiwbpkwqrkf5DnLaT2WtGCrA6SdBG/2A3o
	z/iGYMT5NlxH/4NQcE8rLNiDDTn4jHuJF77WzDcEvHssd65OAVD0jqyeZkKWqCT3
	cT3Dmazxzk0ZLk+iHuih65+jiBVUx0JQ1CoDnZmpe8bVHlpl8lGohrEdeHufjDF6
	h7Ii31fR50lQO3Hm4Py/mpHQC9XnTHLKFuU8N1g7M3C+g9YgZRBZjKeKXuoGR+MT
	UO9f5+U2O6SGqT72gBE51Dek3PHufNcNyI5QqU1KyWasBKaT77VbuCOHadpZsUbW
	Dy32dw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pw4f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGHcK022216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:17 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:16 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 8/9] wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
Date: Fri, 24 Oct 2025 23:45:47 +0530
Message-ID: <20251024181548.3255166-9-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX55hNt+iYic9R
 mzKx/Eb8hVVW9KmzsADmuvPt3ynEKh6w2RiOOz/t6J5O0O3zCGPjINjxNcOvTK9hxAQJoHvifAe
 1QaCvd8wb3KiXu4iQBsTfKxpcD3re3hM3pnZhAaBnQR2eeK/l94RfWXVoWKsviiqEbRSrCptl2H
 1gf+DUqzPe70r3OXKKdS5xk4jbflvKmglgh4zavAYJE0oUY0Z2W3YeI3LpVoeJcidUu3699d90V
 96u/ldbTFuQz7W4WttZ4KDMdtRJ09tPHGUUXAYU3Xm17PIzY3/4eqX0yhq5fD3jJJARSivhP23s
 7bCUH1S9cbhQG1b9w2Jid44MIFJgmdWezW/pNa2RyowRWBEzcHy253B2l471j80DYX4hQ677ANN
 G7uuWZgqLRgJED/rPSdYuvMrmFSxrw==
X-Proofpoint-GUID: -cWwaepJO8fTLeniFPuLJgU8LmB8EDz_
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fbc272 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=5RRWBY4WAAAA:8 a=Iynds2et8tsAOCIoaCgA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=drtMOSl5Q_Tsf-UZi3mY:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-ORIG-GUID: -cWwaepJO8fTLeniFPuLJgU8LmB8EDz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Move link agnostic data path parameters (keys, rx_tid, reorder buffers, MIC
context etc) from ath12k_sta and ath12k_dp_link_peer into ath12k_dp_peer. These
parameters are shared across MLO links and should be managed at the peer level.
Configure them only when the link peer is primary to avoid redundancy and ensure
consistent setup.

Switch per-packet Tx/Rx paths and monitor paths to look up ath12k_dp_peer and
ath12k_dp_link_peer via peer_id.

Helper APIs added:
 - ath12k_dp_peer_find_by_peerid()
 - ath12k_dp_link_peer_find_by_peerid()

Ensure RCU read lock is held when using these helpers APIs.

With the above API ath12k_dp_link_peer_find_by_peerid() being used to find
ath12k_dp_link_peer, existing API ath12k_dp_link_peer_find_by_id() is required
only at the time of unmap event from firmware since it fetches the
ath12k_dp_link_peer from linked list.

In order to restrict the usage of API ath12k_dp_link_peer_find_by_id(), make it
static and also rename it to ath12k_dp_link_peer_search_by_id().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |  8 ---
 drivers/net/wireless/ath/ath12k/dp.c          |  6 +-
 drivers/net/wireless/ath/ath12k/dp_htt.c      | 22 ++-----
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 13 +++--
 drivers/net/wireless/ath/ath12k/dp_peer.c     | 45 +++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_peer.h     | 45 +++++++-------
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 58 +++++++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  9 ++-
 drivers/net/wireless/ath/ath12k/mac.c         | 54 +++++++++--------
 drivers/net/wireless/ath/ath12k/peer.c        |  6 --
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 30 +++++-----
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 23 +++-----
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  2 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  1 +
 15 files changed, 175 insertions(+), 149 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6dc4498749c3..bc1d94963251 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -566,12 +566,6 @@ struct ath12k_link_sta {
 	struct rhash_head rhash_addr;
 };
 
-struct ath12k_reoq_buf {
-	void *vaddr;
-	dma_addr_t paddr_aligned;
-	u32 size;
-};
-
 struct ath12k_sta {
 	struct ath12k_vif *ahvif;
 	enum hal_pn_type pn_type;
@@ -584,8 +578,6 @@ struct ath12k_sta {
 	u8 num_peer;
 
 	enum ieee80211_sta_state state;
-
-	struct ath12k_reoq_buf reoq_bufs[IEEE80211_NUM_TIDS + 1];
 };
 
 #define ATH12K_HALF_20MHZ_BW	10
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index e682c0cd18ad..ff914c0e125f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -30,7 +30,7 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, addr);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		ath12k_warn(ab, "failed to lookup peer %pM on vdev %d\n",
 			    addr, vdev_id);
 		spin_unlock_bh(&dp->dp_lock);
@@ -43,8 +43,8 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 	}
 
 	ath12k_dp_rx_peer_tid_cleanup(ar, peer);
-	crypto_free_shash(peer->tfm_mmic);
-	peer->dp_setup_done = false;
+	crypto_free_shash(peer->dp_peer->tfm_mmic);
+	peer->dp_peer->dp_setup_done = false;
 	spin_unlock_bh(&dp->dp_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index f3dca108c614..db5ac36adf3d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -272,18 +272,15 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	rcu_read_lock();
-	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_link_peer_find_by_id(dp, usr_stats->peer_id);
+	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, usr_stats->peer_id);
 
 	if (!peer || !peer->sta) {
-		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 		return;
 	}
 
 	arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
 	if (!arsta) {
-		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 		return;
 	}
@@ -357,7 +354,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
 	}
 
-	spin_unlock_bh(&dp->dp_lock);
 	rcu_read_unlock();
 }
 
@@ -507,17 +503,13 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 	    ppdu_info->delay_ba) {
 		for (i = 0; i < ppdu_info->ppdu_stats.common.num_users; i++) {
 			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
-			spin_lock_bh(&dp->dp_lock);
-			peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
-			if (!peer) {
-				spin_unlock_bh(&dp->dp_lock);
+			peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, peer_id);
+			if (!peer)
 				continue;
-			}
 
 			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
 			if (usr_stats->delay_ba)
 				ath12k_copy_to_delay_stats(peer, usr_stats);
-			spin_unlock_bh(&dp->dp_lock);
 		}
 	}
 
@@ -526,17 +518,13 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON))) {
 		for (i = 0; i < ppdu_info->bar_num_users; i++) {
 			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
-			spin_lock_bh(&dp->dp_lock);
-			peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
-			if (!peer) {
-				spin_unlock_bh(&dp->dp_lock);
+			peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, peer_id);
+			if (!peer)
 				continue;
-			}
 
 			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
 			if (peer->delayba_flag)
 				ath12k_copy_to_bar(peer, usr_stats);
-			spin_unlock_bh(&dp->dp_lock);
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index f65ac12d7f2b..b9ccb5462e9d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2275,6 +2275,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
+	u8 addr[ETH_ALEN] = {};
 
 	status->link_valid = 0;
 
@@ -2287,11 +2288,13 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_wifi7_dp_extract_rx_desc_data(ab, &rx_info, rx_desc, rx_desc);
 
+	rcu_read_lock();
 	spin_lock_bh(&dp->dp_lock);
 	rx_info.addr2_present = false;
-	peer = ath12k_dp_rx_h_find_link_peer(dp, msdu, &rx_info);
+	peer = ath12k_dp_rx_h_find_link_peer(dp_pdev, msdu, &rx_info);
 	if (peer && peer->sta) {
 		pubsta = peer->sta;
+		memcpy(addr, peer->addr, ETH_ALEN);
 		if (pubsta->valid_links) {
 			status->link_valid = 1;
 			status->link_id = peer->link_id;
@@ -2299,12 +2302,13 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	spin_unlock_bh(&dp->dp_lock);
+	rcu_read_unlock();
 
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
 		   "rx skb %p len %u peer %pM %u %s %s%s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
-		   peer ? peer->addr : NULL,
+		   addr,
 		   rxcb->tid,
 		   (is_mcbc) ? "mcast" : "ucast",
 		   (status->encoding == RX_ENC_LEGACY) ? "legacy" : "",
@@ -3885,8 +3889,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 			goto free_skb;
 
 		rcu_read_lock();
-		spin_lock_bh(&dp->dp_lock);
-		peer = ath12k_dp_link_peer_find_by_id(dp, ppdu_info->peer_id);
+		peer = ath12k_dp_link_peer_find_by_peerid(pdev_dp, ppdu_info->peer_id);
 		if (!peer || !peer->sta) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "failed to find the peer with monitor peer_id %d\n",
@@ -3899,7 +3902,6 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 			if (!arsta) {
 				ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
 					    peer->addr, peer->peer_id);
-				spin_unlock_bh(&dp->dp_lock);
 				rcu_read_unlock();
 				dev_kfree_skb_any(skb);
 				continue;
@@ -3913,7 +3915,6 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 		}
 
 next_skb:
-		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 free_skb:
 		dev_kfree_skb_any(skb);
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index fe4748648a84..61478e66d9af 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -72,8 +72,8 @@ ath12k_dp_link_peer_find_by_ml_id(struct ath12k_dp *dp, int ml_peer_id)
 	return NULL;
 }
 
-struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_id(struct ath12k_dp *dp, int peer_id)
+static struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_search_by_id(struct ath12k_dp *dp, int peer_id)
 {
 	struct ath12k_dp_link_peer *peer;
 
@@ -129,7 +129,7 @@ void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 
 	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
+	peer = ath12k_dp_link_peer_search_by_id(dp, peer_id);
 	if (!peer) {
 		ath12k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
 			    peer_id);
@@ -388,6 +388,44 @@ u16 ath12k_dp_peer_get_peerid_index(struct ath12k_dp *dp, u16 peer_id)
 		((dp->device_id << ATH12K_DP_PEER_TABLE_DEVICE_ID_SHIFT) | peer_id);
 }
 
+struct ath12k_dp_peer *ath12k_dp_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev,
+						     u16 peer_id)
+{
+	u16 index;
+	struct ath12k_dp *dp = dp_pdev->dp;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "ath12k dp peer find by peerid index called without rcu lock");
+
+	if (!peer_id || peer_id >= ATH12K_DP_PEER_ID_INVALID)
+		return NULL;
+
+	index = ath12k_dp_peer_get_peerid_index(dp, peer_id);
+
+	return rcu_dereference(dp_pdev->dp_hw->dp_peers[index]);
+}
+
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev, u16 peer_id)
+{
+	struct ath12k_dp_peer *dp_peer = NULL;
+	u8 link_id;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "ath12k dp link peer find by peerid index called without rcu lock");
+
+	if (dp_pdev->hw_link_id >= ATH12K_GROUP_MAX_RADIO)
+		return NULL;
+
+	dp_peer = ath12k_dp_peer_find_by_peerid(dp_pdev, peer_id);
+	if (!dp_peer)
+		return NULL;
+
+	link_id = dp_peer->hw_links[dp_pdev->hw_link_id];
+
+	return rcu_dereference(dp_peer->link_peers[link_id]);
+}
+
 int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
 			  struct ath12k_dp_peer_create_params *params)
 {
@@ -419,6 +457,7 @@ int ath12k_dp_peer_create(struct ath12k_dp_hw *dp_hw, u8 *addr,
 
 	dp_peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
 	dp_peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
+	dp_peer->ucast_ra_only = params->ucast_ra_only;
 
 	spin_lock_bh(&dp_hw->peer_lock);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index 36cce6620310..f7c995e8c4e3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -34,24 +34,11 @@ struct ath12k_dp_link_peer {
 	u8 pdev_idx;
 	u16 hw_peer_id;
 
-	/* protected by ab->data_lock */
-	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
-	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
-
-	/* Info used in MMIC verification of
-	 * RX fragments
-	 */
-	struct crypto_shash *tfm_mmic;
-	u8 mcast_keyidx;
-	u8 ucast_keyidx;
-	u16 sec_type;
-	u16 sec_type_grp;
 	struct ppdu_user_delayba ppdu_stats_delayba;
 	bool delayba_flag;
 	bool is_authorized;
 	bool mlo;
 	/* protected by ab->data_lock */
-	bool dp_setup_done;
 
 	u16 ml_id;
 
@@ -65,12 +52,12 @@ struct ath12k_dp_link_peer {
 
 	/* for reference to ath12k_link_sta */
 	u8 link_id;
-	bool ucast_ra_only;
 
 	/* peer addr based rhashtable list pointer */
 	struct rhash_head rhash_addr;
 
 	u8 hw_link_id;
+	u32 rx_tid_active_bitmask;
 };
 
 void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
@@ -79,18 +66,28 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 
 struct ath12k_dp_peer {
 	struct list_head list;
-	struct ieee80211_sta *sta;
-	int peer_id;
-	u8 addr[ETH_ALEN];
 	bool is_mlo;
+	bool dp_setup_done;
 
-	struct ath12k_dp_link_peer __rcu *link_peers[ATH12K_NUM_MAX_LINKS];
-
-	u16 sec_type;
-	u16 sec_type_grp;
+	u8 ucast_keyidx;
+	u8 addr[ETH_ALEN];
 
+	u8 mcast_keyidx;
 	bool ucast_ra_only;
+	int peer_id;
+	struct ieee80211_sta *sta;
+
 	u8 hw_links[ATH12K_GROUP_MAX_RADIO];
+
+	u16 sec_type_grp;
+	u16 sec_type;
+
+	/* Info used in MMIC verification of * RX fragments */
+	struct crypto_shash *tfm_mmic;
+	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
+	struct ath12k_dp_link_peer __rcu *link_peers[ATH12K_NUM_MAX_LINKS];
+	struct ath12k_reoq_buf reoq_bufs[IEEE80211_NUM_TIDS + 1];
+	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
 };
 
 struct ath12k_dp_link_peer *
@@ -98,8 +95,6 @@ ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_dp *dp,
 					  int vdev_id, const u8 *addr);
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_addr(struct ath12k_dp *dp, const u8 *addr);
-struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_id(struct ath12k_dp *dp, int peer_id);
 bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_dp *dp, int vdev_id);
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_ast(struct ath12k_dp *dp, int ast_hash);
@@ -123,4 +118,8 @@ struct ath12k_dp_peer *ath12k_dp_peer_find_by_addr_and_sta(struct ath12k_dp_hw *
 							   u8 *addr,
 							   struct ieee80211_sta *sta);
 u16 ath12k_dp_peer_get_peerid_index(struct ath12k_dp *dp, u16 peer_id);
+struct ath12k_dp_peer *ath12k_dp_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev,
+						     u16 peer_id);
+struct ath12k_dp_link_peer *
+ath12k_dp_link_peer_find_by_peerid(struct ath12k_pdev_dp *dp_pdev, u16 peer_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 08dc0345a2b2..12ad62b0ff5d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -481,8 +481,11 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer
 
 	lockdep_assert_held(&dp->dp_lock);
 
+	if (!peer->primary_link)
+		return;
+
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
-		rx_tid = &peer->rx_tid[i];
+		rx_tid = &peer->dp_peer->rx_tid[i];
 
 		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, i);
 		ath12k_dp_rx_frags_cleanup(rx_tid, true);
@@ -500,7 +503,6 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_dp_link_peer *peer;
-	struct ath12k_sta *ahsta;
 	struct ath12k_dp_rx_tid *rx_tid;
 	dma_addr_t paddr_aligned;
 	int ret;
@@ -508,7 +510,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	spin_lock_bh(&dp->dp_lock);
 
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, peer_mac);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to find the peer to set up rx tid\n");
 		return -ENOENT;
@@ -534,9 +536,9 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return -EINVAL;
 	}
 
-	rx_tid = &peer->rx_tid[tid];
+	rx_tid = &peer->dp_peer->rx_tid[tid];
 	/* Update the tid queue if it is already setup */
-	if (rx_tid->active) {
+	if (peer->rx_tid_active_bitmask & (1 << tid)) {
 		ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, rx_tid,
 							  ba_win_sz, ssn, true);
 		spin_unlock_bh(&dp->dp_lock);
@@ -565,14 +567,15 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 
 	rx_tid->ba_win_sz = ba_win_sz;
 
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	ret = ath12k_wifi7_dp_rx_assign_reoq(ab, ahsta, rx_tid, ssn, pn_type);
+	ret = ath12k_wifi7_dp_rx_assign_reoq(ab, peer->dp_peer, rx_tid, ssn, pn_type);
 	if (ret) {
 		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to assign reoq buf for rx tid %u\n", tid);
 		return ret;
 	}
 
+	peer->rx_tid_active_bitmask |= (1 << tid);
+
 	paddr_aligned = rx_tid->qbuf.paddr_aligned;
 	if (ab->hw_params->reoq_lut_support) {
 		/* Update the REO queue LUT at the corresponding peer id
@@ -649,20 +652,26 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 	spin_lock_bh(&dp->dp_lock);
 
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, arsta->addr);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to find the peer to stop rx aggregation\n");
 		return -ENOENT;
 	}
 
-	active = peer->rx_tid[params->tid].active;
+	if (ab->hw_params->dp_primary_link_only &&
+	    !peer->primary_link) {
+		spin_unlock_bh(&dp->dp_lock);
+		return 0;
+	}
 
+	active = peer->rx_tid_active_bitmask & (1 << params->tid);
 	if (!active) {
 		spin_unlock_bh(&dp->dp_lock);
 		return 0;
 	}
 
-	ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
+	ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, peer->dp_peer->rx_tid,
+						  1, 0, false);
 	spin_unlock_bh(&dp->dp_lock);
 	if (ret) {
 		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
@@ -698,7 +707,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 peer_addr);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to find the peer %pM to configure pn replay detection\n",
 			    peer_addr);
@@ -706,10 +715,11 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 	}
 
 	for (tid = 0; tid <= IEEE80211_NUM_TIDS; tid++) {
-		rx_tid = &peer->rx_tid[tid];
-		if (!rx_tid->active)
+		if (!(peer->rx_tid_active_bitmask & (1 << tid)))
 			continue;
 
+		rx_tid = &peer->dp_peer->rx_tid[tid];
+
 		ath12k_wifi7_dp_setup_pn_check_reo_cmd(&cmd, rx_tid, key->cipher,
 						       key_cmd);
 		ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
@@ -1043,16 +1053,17 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 }
 
 struct ath12k_dp_link_peer *
-ath12k_dp_rx_h_find_link_peer(struct ath12k_dp *dp, struct sk_buff *msdu,
+ath12k_dp_rx_h_find_link_peer(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ath12k_dp_link_peer *peer = NULL;
+	struct ath12k_dp *dp = dp_pdev->dp;
 
 	lockdep_assert_held(&dp->dp_lock);
 
 	if (rxcb->peer_id)
-		peer = ath12k_dp_link_peer_find_by_id(dp, rxcb->peer_id);
+		peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, rxcb->peer_id);
 
 	if (peer)
 		return peer;
@@ -1201,25 +1212,22 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	struct ath12k_base *ab = dp->ab;
 	struct ieee80211_rx_status *rx_status;
 	struct ieee80211_sta *pubsta;
-	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status *status = rx_info->rx_status;
 	u8 decap = rx_info->decap_type;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol = rxcb->is_eapol;
 
-	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_rx_h_find_link_peer(dp, msdu, rx_info);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rx_info->peer_id);
 
 	pubsta = peer ? peer->sta : NULL;
 
 	if (pubsta && pubsta->valid_links) {
 		status->link_valid = 1;
-		status->link_id = peer->link_id;
+		status->link_id = peer->hw_links[rxcb->hw_link_id];
 	}
 
-	spin_unlock_bh(&dp->dp_lock);
-
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
 		   "rx skb %p len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
@@ -1342,7 +1350,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	spin_lock_bh(&dp->dp_lock);
 
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, peer_mac);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
 		crypto_free_shash(tfm);
 		ath12k_warn(ab, "failed to find the peer to set up fragment info\n");
@@ -1356,14 +1364,14 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	}
 
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
-		rx_tid = &peer->rx_tid[i];
+		rx_tid = &peer->dp_peer->rx_tid[i];
 		rx_tid->dp = dp;
 		timer_setup(&rx_tid->frag_timer, ath12k_dp_rx_frag_timer, 0);
 		skb_queue_head_init(&rx_tid->rx_frags);
 	}
 
-	peer->tfm_mmic = tfm;
-	peer->dp_setup_done = true;
+	peer->dp_peer->tfm_mmic = tfm;
+	peer->dp_peer->dp_setup_done = true;
 	spin_unlock_bh(&dp->dp_lock);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 9b0334515c6e..1ad798fe1cb8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -12,10 +12,15 @@
 
 #define DP_MAX_NWIFI_HDR_LEN	30
 
+struct ath12k_reoq_buf {
+	void *vaddr;
+	dma_addr_t paddr_aligned;
+	u32 size;
+};
+
 struct ath12k_dp_rx_tid {
 	u8 tid;
 	u32 ba_win_sz;
-	bool active;
 	struct ath12k_reoq_buf qbuf;
 
 	/* Info related to rx fragments */
@@ -230,7 +235,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc);
 struct ath12k_dp_link_peer *
-ath12k_dp_rx_h_find_link_peer(struct ath12k_dp *dp, struct sk_buff *msdu,
+ath12k_dp_rx_h_find_link_peer(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			      struct hal_rx_desc_data *rx_info);
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 02168a857e0a..f55c207c4962 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1192,7 +1192,7 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 	spin_lock_bh(&dp->dp_lock);
 	list_for_each_entry_safe(peer, tmp, &dp->peers, list) {
 		/* Skip Rx TID cleanup for self peer */
-		if (peer->sta)
+		if (peer->sta && peer->dp_peer)
 			ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 
 		/* cleanup dp peer */
@@ -5536,27 +5536,37 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 	struct ath12k_dp_link_peer *peer;
 	int first_errno = 0;
 	int ret;
-	int i;
+	int i, len;
 	u32 flags = 0;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1] = {};
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id, addr);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
 		return -ENOENT;
 	}
 
+	len = ARRAY_SIZE(peer->dp_peer->keys);
+	for (i = 0; i < len; i++) {
+		if (!peer->dp_peer->keys[i])
+			continue;
+
+		keys[i] = peer->dp_peer->keys[i];
+		peer->dp_peer->keys[i] = NULL;
+	}
+
 	spin_unlock_bh(&dp->dp_lock);
 
-	for (i = 0; i < ARRAY_SIZE(peer->keys); i++) {
-		if (!peer->keys[i])
+	for (i = 0; i < len; i++) {
+		if (!keys[i])
 			continue;
 
 		/* key flags are not required to delete the key */
-		ret = ath12k_install_key(arvif, peer->keys[i],
+		ret = ath12k_install_key(arvif, keys[i],
 					 DISABLE_KEY, addr, flags);
 		if (ret < 0 && first_errno == 0)
 			first_errno = ret;
@@ -5564,10 +5574,6 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 		if (ret < 0)
 			ath12k_warn(ab, "failed to remove peer key %d: %d\n",
 				    i, ret);
-
-		spin_lock_bh(&dp->dp_lock);
-		peer->keys[i] = NULL;
-		spin_unlock_bh(&dp->dp_lock);
 	}
 
 	return first_errno;
@@ -5608,7 +5614,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 peer_addr);
-	if (!peer) {
+	if (!peer || !peer->dp_peer) {
 		spin_unlock_bh(&dp->dp_lock);
 
 		if (cmd == SET_KEY) {
@@ -5645,21 +5651,23 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 peer_addr);
-	if (peer && cmd == SET_KEY) {
-		peer->keys[key->keyidx] = key;
+	if (peer && peer->dp_peer && cmd == SET_KEY) {
+		peer->dp_peer->keys[key->keyidx] = key;
 		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
-			peer->ucast_keyidx = key->keyidx;
-			peer->sec_type = ath12k_dp_tx_get_encrypt_type(key->cipher);
+			peer->dp_peer->ucast_keyidx = key->keyidx;
+			peer->dp_peer->sec_type =
+					ath12k_dp_tx_get_encrypt_type(key->cipher);
 		} else {
-			peer->mcast_keyidx = key->keyidx;
-			peer->sec_type_grp = ath12k_dp_tx_get_encrypt_type(key->cipher);
+			peer->dp_peer->mcast_keyidx = key->keyidx;
+			peer->dp_peer->sec_type_grp =
+					ath12k_dp_tx_get_encrypt_type(key->cipher);
 		}
-	} else if (peer && cmd == DISABLE_KEY) {
-		peer->keys[key->keyidx] = NULL;
+	} else if (peer && peer->dp_peer && cmd == DISABLE_KEY) {
+		peer->dp_peer->keys[key->keyidx] = NULL;
 		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
-			peer->ucast_keyidx = 0;
+			peer->dp_peer->ucast_keyidx = 0;
 		else
-			peer->mcast_keyidx = 0;
+			peer->dp_peer->mcast_keyidx = 0;
 	} else if (!peer)
 		/* impossible unless FW goes crazy */
 		ath12k_warn(ab, "peer %pM disappeared!\n", peer_addr);
@@ -9164,7 +9172,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			spin_lock_bh(&tmp_dp->dp_lock);
 			peer = ath12k_dp_link_peer_find_by_addr(tmp_dp,
 								tmp_arvif->bssid);
-			if (!peer) {
+			if (!peer || !peer->dp_peer) {
 				spin_unlock_bh(&tmp_dp->dp_lock);
 				ath12k_warn(tmp_ar->ab,
 					    "failed to find peer for vdev_id 0x%X addr %pM link_map 0x%X\n",
@@ -9174,7 +9182,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 				continue;
 			}
 
-			key = peer->keys[peer->mcast_keyidx];
+			key = peer->dp_peer->keys[peer->dp_peer->mcast_keyidx];
 			if (key) {
 				skb_cb->cipher = key->cipher;
 				skb_cb->flags |= ATH12K_SKB_CIPHER_SET;
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 8b6fea685a70..812247decab4 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -214,9 +214,6 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		dp_link_vif->ast_idx = peer->hw_peer_id;
 	}
 
-	if (vif->type == NL80211_IFTYPE_AP)
-		peer->ucast_ra_only = true;
-
 	if (sta) {
 		ahsta = ath12k_sta_to_ahsta(sta);
 		arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
@@ -240,9 +237,6 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		}
 	}
 
-	peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
-	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
-
 	ar->num_peers++;
 
 	spin_unlock_bh(&dp->dp_lock);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index da745566aca3..87875486fb4a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -72,10 +72,10 @@ void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
 					struct ath12k_dp_link_peer *peer, u8 tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
-	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
+	struct ath12k_dp_rx_tid *rx_tid = &peer->dp_peer->rx_tid[tid];
 	int ret;
 
-	if (!rx_tid->active)
+	if (!(peer->rx_tid_active_bitmask & (1 << tid)))
 		return;
 
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
@@ -99,7 +99,7 @@ void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
 	else
 		ath12k_wifi7_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
 
-	rx_tid->active = false;
+	peer->rx_tid_active_bitmask &= ~(1 << tid);
 }
 
 int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
@@ -253,7 +253,7 @@ void ath12k_wifi7_dp_reo_cache_flush(struct ath12k_base *ab,
 	}
 }
 
-int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
+int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_dp_peer *dp_peer,
 				   struct ath12k_dp_rx_tid *rx_tid,
 				   u16 ssn, enum hal_pn_type pn_type)
 {
@@ -265,7 +265,7 @@ int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ah
 	u32 hw_desc_sz;
 	int ret;
 
-	buf = &ahsta->reoq_bufs[tid];
+	buf = &dp_peer->reoq_bufs[tid];
 	if (!buf->vaddr) {
 		/* TODO: Optimize the memory allocation for qos tid based on
 		 * the actual BA window size in REO tid update path.
@@ -299,7 +299,6 @@ int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ah
 	}
 
 	rx_tid->qbuf = *buf;
-	rx_tid->active = true;
 
 	return 0;
 }
@@ -316,12 +315,11 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 				      struct hal_rx_desc *rx_desc,
 				      struct hal_rx_desc_data *rx_info)
 {
-	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
 	struct ieee80211_hdr *hdr;
-	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp_peer *peer;
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u32 err_bitmap = rx_info->err_bitmap;
 
@@ -332,8 +330,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	if (rxcb->is_mcbc)
 		rxcb->peer_id = rx_info->peer_id;
 
-	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_rx_h_find_link_peer(dp, msdu, rx_info);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rxcb->peer_id);
 	if (peer) {
 		/* resetting mcbc bit because mcbc packets are unicast
 		 * packets only for AP as STA sends unicast packets.
@@ -347,7 +344,6 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	} else {
 		enctype = HAL_ENCRYPT_TYPE_OPEN;
 	}
-	spin_unlock_bh(&dp->dp_lock);
 
 	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
 		is_decrypted = rx_info->is_decrypted;
@@ -964,7 +960,7 @@ static int ath12k_wifi7_dp_rx_h_defrag_reo_reinject(struct ath12k_dp *dp,
 }
 
 static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
-						struct ath12k_dp_link_peer *peer,
+						struct ath12k_dp_peer *peer,
 						enum hal_encrypt_type enctype,
 						struct sk_buff *msdu,
 						struct hal_rx_desc_data *rx_info)
@@ -1033,7 +1029,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 }
 
 static int ath12k_wifi7_dp_rx_h_defrag(struct ath12k_pdev_dp *dp_pdev,
-				       struct ath12k_dp_link_peer *peer,
+				       struct ath12k_dp_peer *peer,
 				       struct ath12k_dp_rx_tid *rx_tid,
 				       struct sk_buff **defrag_skb,
 				       enum hal_encrypt_type enctype,
@@ -1107,7 +1103,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	struct sk_buff *defrag_skb = NULL;
 	u32 peer_id = rx_info->peer_id;
@@ -1134,7 +1130,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 		return -EINVAL;
 
 	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, peer_id);
 	if (!peer) {
 		ath12k_warn(ab, "failed to find the peer to de-fragment received fragment peer_id %d\n",
 			    peer_id);
@@ -1197,7 +1193,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	timer_delete_sync(&rx_tid->frag_timer);
 	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, peer_id);
 	if (!peer)
 		goto err_frags_cleanup;
 
@@ -1831,6 +1827,8 @@ int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 		rxcb->is_last_msdu = err_info.last_msdu;
 		rxcb->is_continuation = err_info.continuation;
 		rxcb->rx_desc = msdu_data;
+		rxcb->peer_id = ath12k_dp_rx_get_peer_id(ab, dp->peer_metadata_ver,
+							 err_info.peer_metadata);
 
 		if (err_info.continuation) {
 			__skb_queue_tail(&scatter_msdu_list, msdu);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index f75588519cff..ba319ff506f2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -25,7 +25,7 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
 					    struct ath12k_dp_rx_tid *rx_tid,
 					    u32 cipher, enum set_key_cmd key_cmd);
-int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
+int ath12k_wifi7_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_dp_peer *dp_peer,
 				   struct ath12k_dp_rx_tid *rx_tid,
 				   u16 ssn, enum hal_pn_type pn_type);
 int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 77de02858677..950614a217a0 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -396,12 +396,13 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
 	struct ath12k_dp_link_peer *peer;
-	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct ath12k_pdev_dp *dp_pdev;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
 
 	ar = skb_cb->ar;
+	dp_pdev = &ar->dp;
 	ab->device_stats.tx_completed[tx_ring->tcl_data_ring_id]++;
 
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
@@ -449,18 +450,15 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		}
 	}
 	rcu_read_lock();
-	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
+	peer = ath12k_dp_link_peer_find_by_peerid(dp_pdev, peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DATA,
 			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
-		spin_unlock_bh(&dp->dp_lock);
 		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
 		goto exit;
 	} else {
 		status.sta = peer->sta;
 	}
-	spin_unlock_bh(&dp->dp_lock);
 
 	status.info = info;
 	status.skb = msdu;
@@ -519,7 +517,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
-	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp_peer *peer;
 	struct ieee80211_sta *sta;
 	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
@@ -528,12 +526,10 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 	u8 rate_idx = 0;
 	int ret;
 
-	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_link_peer_find_by_id(dp, ts->peer_id);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 			   "failed to find the peer by id %u\n", ts->peer_id);
-		spin_unlock_bh(&dp->dp_lock);
 		return;
 	}
 	sta = peer->sta;
@@ -547,7 +543,6 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		txrate.nss = arsta->last_txrate.nss;
 	else
 		txrate.nss = arsta->peer_nss;
-	spin_unlock_bh(&dp->dp_lock);
 
 	switch (ts->pkt_type) {
 	case HAL_TX_RATE_STATS_PKT_TYPE_11A:
@@ -650,7 +645,7 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
 	struct ieee80211_rate_status status_rate = {};
-	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp_peer *peer;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_sta *ahsta;
 	struct rate_info rate;
@@ -747,21 +742,17 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_wifi7_dp_tx_update_txcompl(dp_pdev, ts);
 
-	spin_lock_bh(&dp->dp_lock);
-	peer = ath12k_dp_link_peer_find_by_id(dp, ts->peer_id);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_err(ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			   ts->peer_id);
-		spin_unlock_bh(&dp->dp_lock);
 		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	}
 	ahsta = ath12k_sta_to_ahsta(peer->sta);
 	arsta = &ahsta->deflink;
 
-	spin_unlock_bh(&dp->dp_lock);
-
 	status.sta = peer->sta;
 	status.info = info;
 	status.skb = msdu;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 2767d6865d70..09a41e110e08 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -439,6 +439,8 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 				      HAL_WBM_RELEASE_INFO0_RXDMA_ERROR_CODE);
 	}
 
+	rel_info->peer_metadata = wbm_desc->info2;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index c4fa2bee97b5..23da5b871983 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -21,6 +21,7 @@ struct hal_rx_wbm_rel_info {
 	bool continuation;
 	void *rx_desc;
 	bool hw_cc_done;
+	__le32 peer_metadata;
 };
 
 #define HAL_RX_MPDU_INFO_PN_GET_BYTE1(__val) \
-- 
2.34.1


