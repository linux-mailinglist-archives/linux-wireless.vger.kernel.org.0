Return-Path: <linux-wireless+bounces-28234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E714C07B35
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C51042146C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7630BB89;
	Fri, 24 Oct 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MFOGkyT7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697CC2E0
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329782; cv=none; b=Nxap5J/ydvN0ltiEYZZ1KtoaZ0IE0IwvVWsjtCS/6jYdQ8P/vBW7wyhru7J4cgRFdNkh/HIn+WGBdUHP3VZOLXuiqjK6d49AqsA7JK6j9h7BbfGHuqjW7zzNoQYSCTHUZjKRzW1Ubnau3MLDjqJHjzqidsvxVease4JsD5maIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329782; c=relaxed/simple;
	bh=RNOk9yaVPVsBVjP9VtUNMz9p1gtLZEV3j9fbycfkVAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4vq+E8lrmmLf5RbMBnDsjHHeMlic6MU8zWZGCCntPSyP08rBB2x3KjdR0x6zsf7FqPFP4nL4/cz6f2WklyhIfT2ohod17PYYKpkyI6LFs18cxpOK4bK/+xoGF9cZjB3v0qgqgEURvA8VUdmaBETj5qDCx2pmuuGAkPOeEzn+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MFOGkyT7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9EwR026817;
	Fri, 24 Oct 2025 18:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bj6G487PV1JmXA7e7+ZSkRrM/aEIs+2dBwzYcmDPqqU=; b=MFOGkyT7OOBVTgsb
	poyLDTMj3zEHRD54RSarAHbYbJi4KGC0cq+U27K7u5GD0Znu2ZKRcz5cYTFSGN7G
	Q/KzTnKmND569xxitdPahwj8cl/SFYbHTxs5mdtQy+fZfEG9+fevUE+Y7nYYixWa
	s2xa5n0obHueyuxvcu+h4BEgHE61hcInoDcNrlBOnAeh5VA347Th+f632TCghchV
	8ZOOFpCVo9asjpO+3SM0nvQ4Y9tpeC3G9k/EjML6+w9C9BaOvyhnP95qMrYo99UK
	rFwiksYmsMEMGB6iCSWvP4mH8rOFAEi9nPFoAK8VNxI3HI0jEOPZvOQK8VU2MA/i
	fzgwww==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0tvap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGBFk000357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:12 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:10 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 4/9] wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to ath12k_dp
Date: Fri, 24 Oct 2025 23:45:43 +0530
Message-ID: <20251024181548.3255166-5-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX2qDURyCxK3j3
 2Knv4bxh+qNlTQWcmeOB99cEX0Sw/r7sJgNL0sLimMBbENBnMOU0JoFIaxRpbvU6Xd1sw4Zv9Kl
 eCZbtmfsL7PK/9Bv6puRRKSXEA4jfSQf42jSp3xwsVoZqJeFkwi3L17OfkYhqdwHBNIqSO9Spfa
 FbqLQURATbDiqdgTb9s9vH/2jMEi9kRDSNQkKM02v74DHqhyifQgrCp6VZi8QQ2HtdZR/SyqJNO
 owUWJ7v8/YGzZ8LoTtCs3NrYqJeMoxpQbZAYAmk3IP8II8rJT2oRS9Z1eTyl0EaCHwlgR90Q4hh
 A7ZH+09Ey4y3N29xKRvEXi6sms1sUzAcWtExak+Z7FXZlwrIonrZhORAurcckcAmMe3eH6SGem4
 365uOrB2M1ht3k2EEvry+wu147x02g==
X-Proofpoint-ORIG-GUID: BVEfcgFAzeQA73M9VvloYKJRxS4sMBTi
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fbc26d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=5RRWBY4WAAAA:8 a=HXxVsBnLH2Yj74q6RHQA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=drtMOSl5Q_Tsf-UZi3mY:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-GUID: BVEfcgFAzeQA73M9VvloYKJRxS4sMBTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

ath12k_base maintains a linked list of ath12k_dp_link_peer. This linked list is
used for all kind of peer search operations.

With the modularization of device and peer objects for ath12k next-generation
driver, ath12k_dp_link_peer and ath12k_dp are exclusively meant for datapath
related operations.

Hence move ath12k_dp_link_peer linked list from ath12k_base to ath12k_dp. This
linked list is to be lock protected by newly introduced spinlock "dp_lock"
defined in ath12k_dp as this list can be concurrently accessed in different
contexts for insert, delete and search operations.

With the above changes, update following APIs to make use of lock "dp->dp_lock"
instead of lock "ab->base_lock" and also update API signatures to pass ath12k_dp
pointer instead of ath12k_base pointer as the function argument.

  ath12k_dp_link_peer_find_by_vdev_and_addr()
  ath12k_dp_link_peer_find_by_id()
  ath12k_dp_link_peer_find_by_ast()
  ath12k_dp_link_peer_find_by_pdev__and_addr()
  ath12k_dp_link_peer_find_by_ml_id()
  ath12k_dp_link_peer_find_by_addr()
  ath12k_dp_rx_h_find_link_peer()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c        |  1 -
 drivers/net/wireless/ath/ath12k/core.h        |  1 -
 drivers/net/wireless/ath/ath12k/dp.c          | 23 +++--
 drivers/net/wireless/ath/ath12k/dp.h          |  6 ++
 drivers/net/wireless/ath/ath12k/dp_htt.c      | 26 ++---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 17 ++--
 drivers/net/wireless/ath/ath12k/dp_peer.c     | 64 ++++++------
 drivers/net/wireless/ath/ath12k/dp_peer.h     | 12 +--
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 86 ++++++++--------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c         | 99 +++++++++++--------
 drivers/net/wireless/ath/ath12k/peer.c        | 31 +++---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 20 ++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 25 ++---
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  3 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  9 +-
 16 files changed, 234 insertions(+), 193 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c5aebe66d190..2e093029c782 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2250,7 +2250,6 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	spin_lock_init(&ab->base_lock);
 	init_completion(&ab->reset_complete);
 
-	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
 	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
 	INIT_WORK(&ab->restart_work, ath12k_core_restart);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8b5a0a99cd31..eb406fc9ab71 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1085,7 +1085,6 @@ struct ath12k_base {
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
 	unsigned long long free_vdev_stats_id_map;
-	struct list_head peers;
 	wait_queue_head_t peer_mapping_wq;
 	u8 mac_addr[ETH_ALEN];
 	bool wmi_ready;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 945e4965a437..40057df4cd66 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -24,27 +24,28 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	/* TODO: Any other peer specific DP cleanup */
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, addr);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, addr);
 	if (!peer) {
 		ath12k_warn(ab, "failed to lookup peer %pM on vdev %d\n",
 			    addr, vdev_id);
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return;
 	}
 
 	if (!peer->primary_link) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return;
 	}
 
 	ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 	crypto_free_shash(peer->tfm_mmic);
 	peer->dp_setup_done = false;
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 }
 
 int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
@@ -53,6 +54,7 @@ int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 	struct ath12k_dp_link_peer *peer;
 	u32 reo_dest;
 	int ret = 0, tid;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	/* NOTE: reo_dest ring id starts from 1 unlike mac_id which starts from 0 */
 	reo_dest = ar->dp.mac_id + 1;
@@ -87,19 +89,19 @@ int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 	return 0;
 
 peer_clean:
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, addr);
 	if (!peer) {
 		ath12k_warn(ab, "failed to find the peer to del rx tid\n");
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return -ENOENT;
 	}
 
 	for (tid--; tid >= 0; tid--)
 		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, tid);
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	return ret;
 }
@@ -1482,6 +1484,9 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 	INIT_LIST_HEAD(&dp->reo_cmd_cache_flush_list);
 	spin_lock_init(&dp->reo_cmd_lock);
 
+	spin_lock_init(&dp->dp_lock);
+	INIT_LIST_HEAD(&dp->peers);
+
 	dp->reo_cmd_cache_flush_count = 0;
 	dp->idle_link_rbm =
 			ath12k_hal_get_idle_link_rbm(&ab->hal, ab->device_id);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 5cedc6603e74..fc87b749a040 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -471,7 +471,13 @@ struct ath12k_dp {
 	struct ath12k_hw_group *ag;
 	u8 device_id;
 
+	/* Lock for protection of peers */
+	spinlock_t dp_lock;
+
 	struct ath12k_dp_arch_ops *ops;
+
+	/* Linked list of struct ath12k_dp_link_peer */
+	struct list_head peers;
 };
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index cae5a90c1c65..f3dca108c614 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -272,18 +272,18 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	rcu_read_lock();
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_id(ab, usr_stats->peer_id);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_id(dp, usr_stats->peer_id);
 
 	if (!peer || !peer->sta) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 		return;
 	}
 
 	arsta = ath12k_dp_link_peer_to_link_sta(ab, peer);
 	if (!arsta) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 		return;
 	}
@@ -357,7 +357,7 @@ ath12k_update_per_peer_tx_stats(struct ath12k_pdev_dp *dp_pdev,
 			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 	rcu_read_unlock();
 }
 
@@ -507,17 +507,17 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 	    ppdu_info->delay_ba) {
 		for (i = 0; i < ppdu_info->ppdu_stats.common.num_users; i++) {
 			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
-			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
+			spin_lock_bh(&dp->dp_lock);
+			peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
 			if (!peer) {
-				spin_unlock_bh(&ab->base_lock);
+				spin_unlock_bh(&dp->dp_lock);
 				continue;
 			}
 
 			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
 			if (usr_stats->delay_ba)
 				ath12k_copy_to_delay_stats(peer, usr_stats);
-			spin_unlock_bh(&ab->base_lock);
+			spin_unlock_bh(&dp->dp_lock);
 		}
 	}
 
@@ -526,17 +526,17 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON))) {
 		for (i = 0; i < ppdu_info->bar_num_users; i++) {
 			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
-			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
+			spin_lock_bh(&dp->dp_lock);
+			peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
 			if (!peer) {
-				spin_unlock_bh(&ab->base_lock);
+				spin_unlock_bh(&dp->dp_lock);
 				continue;
 			}
 
 			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
 			if (peer->delayba_flag)
 				ath12k_copy_to_bar(peer, usr_stats);
-			spin_unlock_bh(&ab->base_lock);
+			spin_unlock_bh(&dp->dp_lock);
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 9da9fc403315..f65ac12d7f2b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2287,9 +2287,9 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_wifi7_dp_extract_rx_desc_data(ab, &rx_info, rx_desc, rx_desc);
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 	rx_info.addr2_present = false;
-	peer = ath12k_dp_rx_h_find_link_peer(ab, msdu, &rx_info);
+	peer = ath12k_dp_rx_h_find_link_peer(dp, msdu, &rx_info);
 	if (peer && peer->sta) {
 		pubsta = peer->sta;
 		if (pubsta->valid_links) {
@@ -2298,7 +2298,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 		}
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
 		   "rx skb %p len %u peer %pM %u %s %s%s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
@@ -3639,11 +3639,12 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
 	struct ath12k_dp_link_peer *peer;
 	u32 num_msdu;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	if (user_stats->ast_index == 0 || user_stats->ast_index == 0xFFFF)
 		return;
 
-	peer = ath12k_dp_link_peer_find_by_ast(ab, user_stats->ast_index);
+	peer = ath12k_dp_link_peer_find_by_ast(dp, user_stats->ast_index);
 
 	if (!peer) {
 		ath12k_warn(ab, "peer ast idx %d can't be found\n",
@@ -3884,8 +3885,8 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 			goto free_skb;
 
 		rcu_read_lock();
-		spin_lock_bh(&ab->base_lock);
-		peer = ath12k_dp_link_peer_find_by_id(ab, ppdu_info->peer_id);
+		spin_lock_bh(&dp->dp_lock);
+		peer = ath12k_dp_link_peer_find_by_id(dp, ppdu_info->peer_id);
 		if (!peer || !peer->sta) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "failed to find the peer with monitor peer_id %d\n",
@@ -3898,7 +3899,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 			if (!arsta) {
 				ath12k_warn(ab, "link sta not found on peer %pM id %d\n",
 					    peer->addr, peer->peer_id);
-				spin_unlock_bh(&ab->base_lock);
+				spin_unlock_bh(&dp->dp_lock);
 				rcu_read_unlock();
 				dev_kfree_skb_any(skb);
 				continue;
@@ -3912,7 +3913,7 @@ int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
 		}
 
 next_skb:
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 free_skb:
 		dev_kfree_skb_any(skb);
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 843369a00d3e..0267f68f8573 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -9,14 +9,14 @@
 #include "debug.h"
 
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_base *ab,
+ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_dp *dp,
 					  int vdev_id, const u8 *addr)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
-	list_for_each_entry(peer, &ab->peers, list) {
+	list_for_each_entry(peer, &dp->peers, list) {
 		if (peer->vdev_id != vdev_id)
 			continue;
 		if (!ether_addr_equal(peer->addr, addr))
@@ -29,14 +29,14 @@ ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_base *ab,
 }
 
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_base *ab, u8 pdev_idx,
+ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_dp *dp, u8 pdev_idx,
 					  const u8 *addr)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
-	list_for_each_entry(peer, &ab->peers, list) {
+	list_for_each_entry(peer, &dp->peers, list) {
 		if (peer->pdev_idx != pdev_idx)
 			continue;
 		if (!ether_addr_equal(peer->addr, addr))
@@ -49,13 +49,13 @@ ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_base *ab, u8 pdev_idx,
 }
 
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_addr(struct ath12k_base *ab, const u8 *addr)
+ath12k_dp_link_peer_find_by_addr(struct ath12k_dp *dp, const u8 *addr)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
-	list_for_each_entry(peer, &ab->peers, list) {
+	list_for_each_entry(peer, &dp->peers, list) {
 		if (!ether_addr_equal(peer->addr, addr))
 			continue;
 
@@ -67,13 +67,13 @@ ath12k_dp_link_peer_find_by_addr(struct ath12k_base *ab, const u8 *addr)
 EXPORT_SYMBOL(ath12k_dp_link_peer_find_by_addr);
 
 static struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_ml_id(struct ath12k_base *ab, int ml_peer_id)
+ath12k_dp_link_peer_find_by_ml_id(struct ath12k_dp *dp, int ml_peer_id)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
-	list_for_each_entry(peer, &ab->peers, list)
+	list_for_each_entry(peer, &dp->peers, list)
 		if (ml_peer_id == peer->ml_id)
 			return peer;
 
@@ -81,49 +81,49 @@ ath12k_dp_link_peer_find_by_ml_id(struct ath12k_base *ab, int ml_peer_id)
 }
 
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_id(struct ath12k_base *ab, int peer_id)
+ath12k_dp_link_peer_find_by_id(struct ath12k_dp *dp, int peer_id)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
 	if (peer_id == HAL_INVALID_PEERID)
 		return NULL;
 
 	if (peer_id & ATH12K_PEER_ML_ID_VALID)
-		return ath12k_dp_link_peer_find_by_ml_id(ab, peer_id);
+		return ath12k_dp_link_peer_find_by_ml_id(dp, peer_id);
 
-	list_for_each_entry(peer, &ab->peers, list)
+	list_for_each_entry(peer, &dp->peers, list)
 		if (peer_id == peer->peer_id)
 			return peer;
 
 	return NULL;
 }
 
-bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id)
+bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_dp *dp, int vdev_id)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	list_for_each_entry(peer, &ab->peers, list) {
+	list_for_each_entry(peer, &dp->peers, list) {
 		if (vdev_id == peer->vdev_id) {
-			spin_unlock_bh(&ab->base_lock);
+			spin_unlock_bh(&dp->dp_lock);
 			return true;
 		}
 	}
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 	return false;
 }
 
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_ast(struct ath12k_base *ab, int ast_hash)
+ath12k_dp_link_peer_find_by_ast(struct ath12k_dp *dp, int ast_hash)
 {
 	struct ath12k_dp_link_peer *peer;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
-	list_for_each_entry(peer, &ab->peers, list)
+	list_for_each_entry(peer, &dp->peers, list)
 		if (ast_hash == peer->ast_hash)
 			return peer;
 
@@ -133,10 +133,11 @@ ath12k_dp_link_peer_find_by_ast(struct ath12k_base *ab, int ast_hash)
 void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 {
 	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
 	if (!peer) {
 		ath12k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
 			    peer_id);
@@ -151,16 +152,17 @@ void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 	wake_up(&ab->peer_mapping_wq);
 
 exit:
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 }
 
 void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
 				   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
 {
 	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, mac_addr);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
 	if (!peer) {
 		peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
 		if (!peer)
@@ -171,7 +173,7 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 		peer->ast_hash = ast_hash;
 		peer->hw_peer_id = hw_peer_id;
 		ether_addr_copy(peer->addr, mac_addr);
-		list_add(&peer->list, &ab->peers);
+		list_add(&peer->list, &dp->peers);
 		wake_up(&ab->peer_mapping_wq);
 	}
 
@@ -179,7 +181,7 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 		   vdev_id, mac_addr, peer_id);
 
 exit:
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 }
 
 struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index aec73d8e35ce..ecc90df05b44 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -69,17 +69,17 @@ void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
 void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
 				   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_base *ab,
+ath12k_dp_link_peer_find_by_vdev_and_addr(struct ath12k_dp *dp,
 					  int vdev_id, const u8 *addr);
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_addr(struct ath12k_base *ab, const u8 *addr);
+ath12k_dp_link_peer_find_by_addr(struct ath12k_dp *dp, const u8 *addr);
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_id(struct ath12k_base *ab, int peer_id);
-bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
+ath12k_dp_link_peer_find_by_id(struct ath12k_dp *dp, int peer_id);
+bool ath12k_dp_link_peer_exist_by_vdev_id(struct ath12k_dp *dp, int vdev_id);
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
+ath12k_dp_link_peer_find_by_ast(struct ath12k_dp *dp, int ast_hash);
 struct ath12k_dp_link_peer *
-ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_base *ab, u8 pdev_idx,
+ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_dp *dp, u8 pdev_idx,
 					  const u8 *addr);
 struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
 							struct ath12k_dp_link_peer *peer);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index f6d800c1ebf9..08dc0345a2b2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -450,9 +450,10 @@ void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 				bool rel_link_desc)
 {
 	struct ath12k_buffer_addr *buf_addr_info;
-	struct ath12k_base *ab = rx_tid->ab;
+	struct ath12k_dp *dp = rx_tid->dp;
+	struct ath12k_base *ab = dp->ab;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
 	if (rx_tid->dst_ring_desc) {
 		if (rel_link_desc) {
@@ -475,8 +476,10 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer
 {
 	struct ath12k_dp_rx_tid *rx_tid;
 	int i;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
-	lockdep_assert_held(&ar->ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->rx_tid[i];
@@ -484,9 +487,9 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer
 		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, i);
 		ath12k_dp_rx_frags_cleanup(rx_tid, true);
 
-		spin_unlock_bh(&ar->ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		timer_delete_sync(&rx_tid->frag_timer);
-		spin_lock_bh(&ar->ab->base_lock);
+		spin_lock_bh(&dp->dp_lock);
 	}
 }
 
@@ -502,24 +505,24 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	dma_addr_t paddr_aligned;
 	int ret;
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, peer_mac);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, peer_mac);
 	if (!peer) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to find the peer to set up rx tid\n");
 		return -ENOENT;
 	}
 
 	if (ab->hw_params->dp_primary_link_only &&
 	    !peer->primary_link) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return 0;
 	}
 
 	if (ab->hw_params->reoq_lut_support &&
 	    (!dp->reoq_lut.vaddr || !dp->ml_reoq_lut.vaddr)) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "reo qref table is not setup\n");
 		return -EINVAL;
 	}
@@ -527,7 +530,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	if (peer->peer_id > DP_MAX_PEER_ID || tid > IEEE80211_NUM_TIDS) {
 		ath12k_warn(ab, "peer id of peer %d or tid %d doesn't allow reoq setup\n",
 			    peer->peer_id, tid);
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return -EINVAL;
 	}
 
@@ -536,7 +539,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	if (rx_tid->active) {
 		ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, rx_tid,
 							  ba_win_sz, ssn, true);
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		if (ret) {
 			ath12k_warn(ab, "failed to update reo for rx tid %d\n", tid);
 			return ret;
@@ -565,7 +568,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	ahsta = ath12k_sta_to_ahsta(peer->sta);
 	ret = ath12k_wifi7_dp_rx_assign_reoq(ab, ahsta, rx_tid, ssn, pn_type);
 	if (ret) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to assign reoq buf for rx tid %u\n", tid);
 		return ret;
 	}
@@ -582,9 +585,9 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 			ath12k_wifi7_peer_rx_tid_qref_setup(ab, peer->peer_id, tid,
 							    paddr_aligned);
 
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 	} else {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac,
 							     paddr_aligned, tid, 1,
 							     ba_win_sz);
@@ -626,6 +629,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 			    u8 link_id)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(params->sta);
 	struct ath12k_link_sta *arsta;
@@ -642,11 +646,11 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 
 	vdev_id = arsta->arvif->vdev_id;
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, arsta->addr);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, arsta->addr);
 	if (!peer) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to find the peer to stop rx aggregation\n");
 		return -ENOENT;
 	}
@@ -654,12 +658,12 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 	active = peer->rx_tid[params->tid].active;
 
 	if (!active) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return 0;
 	}
 
 	ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 	if (ret) {
 		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
 			    params->tid, ret);
@@ -676,6 +680,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 {
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
@@ -689,12 +694,12 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 	if (!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return 0;
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 peer_addr);
 	if (!peer) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to find the peer %pM to configure pn replay detection\n",
 			    peer_addr);
 		return -ENOENT;
@@ -717,7 +722,7 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 		}
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	return ret;
 }
@@ -1038,22 +1043,22 @@ void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu
 }
 
 struct ath12k_dp_link_peer *
-ath12k_dp_rx_h_find_link_peer(struct ath12k_base *ab, struct sk_buff *msdu,
+ath12k_dp_rx_h_find_link_peer(struct ath12k_dp *dp, struct sk_buff *msdu,
 			      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ath12k_dp_link_peer *peer = NULL;
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 
 	if (rxcb->peer_id)
-		peer = ath12k_dp_link_peer_find_by_id(ab, rxcb->peer_id);
+		peer = ath12k_dp_link_peer_find_by_id(dp, rxcb->peer_id);
 
 	if (peer)
 		return peer;
 
 	if (rx_info->addr2_present)
-		peer = ath12k_dp_link_peer_find_by_addr(ab, rx_info->addr2);
+		peer = ath12k_dp_link_peer_find_by_addr(dp, rx_info->addr2);
 
 	return peer;
 }
@@ -1203,8 +1208,8 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol = rxcb->is_eapol;
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_rx_h_find_link_peer(ab, msdu, rx_info);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_rx_h_find_link_peer(dp, msdu, rx_info);
 
 	pubsta = peer ? peer->sta : NULL;
 
@@ -1213,7 +1218,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 		status->link_id = peer->link_id;
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	ath12k_dbg(ab, ATH12K_DBG_DATA,
 		   "rx skb %p len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s%s%s%s rate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
@@ -1311,14 +1316,14 @@ static void ath12k_dp_rx_frag_timer(struct timer_list *timer)
 	struct ath12k_dp_rx_tid *rx_tid = timer_container_of(rx_tid, timer,
 							     frag_timer);
 
-	spin_lock_bh(&rx_tid->ab->base_lock);
+	spin_lock_bh(&rx_tid->dp->dp_lock);
 	if (rx_tid->last_frag_no &&
 	    rx_tid->rx_frag_bitmap == GENMASK(rx_tid->last_frag_no, 0)) {
-		spin_unlock_bh(&rx_tid->ab->base_lock);
+		spin_unlock_bh(&rx_tid->dp->dp_lock);
 		return;
 	}
 	ath12k_dp_rx_frags_cleanup(rx_tid, true);
-	spin_unlock_bh(&rx_tid->ab->base_lock);
+	spin_unlock_bh(&rx_tid->dp->dp_lock);
 }
 
 int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id)
@@ -1328,37 +1333,38 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp_rx_tid *rx_tid;
 	int i;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	tfm = crypto_alloc_shash("michael_mic", 0, 0);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, vdev_id, peer_mac);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, peer_mac);
 	if (!peer) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		crypto_free_shash(tfm);
 		ath12k_warn(ab, "failed to find the peer to set up fragment info\n");
 		return -ENOENT;
 	}
 
 	if (!peer->primary_link) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		crypto_free_shash(tfm);
 		return 0;
 	}
 
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->rx_tid[i];
-		rx_tid->ab = ab;
+		rx_tid->dp = dp;
 		timer_setup(&rx_tid->frag_timer, ath12k_dp_rx_frag_timer, 0);
 		skb_queue_head_init(&rx_tid->rx_frags);
 	}
 
 	peer->tfm_mmic = tfm;
 	peer->dp_setup_done = true;
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index b45097855620..9b0334515c6e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -28,7 +28,7 @@ struct ath12k_dp_rx_tid {
 
 	/* Timer info related to fragments */
 	struct timer_list frag_timer;
-	struct ath12k_base *ab;
+	struct ath12k_dp *dp;
 };
 
 struct ath12k_dp_rx_reo_cache_flush_elem {
@@ -230,7 +230,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 			struct hal_rx_desc *desc);
 struct ath12k_dp_link_peer *
-ath12k_dp_rx_h_find_link_peer(struct ath12k_base *ab, struct sk_buff *msdu,
+ath12k_dp_rx_h_find_link_peer(struct ath12k_dp *dp, struct sk_buff *msdu,
 			      struct hal_rx_desc_data *rx_info);
 u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5e6e176bf6a9..fd6819ec390c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1178,11 +1178,12 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 {
 	struct ath12k_dp_link_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	spin_lock_bh(&ab->base_lock);
-	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
+	spin_lock_bh(&dp->dp_lock);
+	list_for_each_entry_safe(peer, tmp, &dp->peers, list) {
 		/* Skip Rx TID cleanup for self peer */
 		if (peer->sta)
 			ath12k_dp_rx_peer_tid_cleanup(ar, peer);
@@ -1190,7 +1191,7 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 		list_del(&peer->list);
 		kfree(peer);
 	}
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	ar->num_peers = 0;
 	ar->num_stations = 0;
@@ -3647,6 +3648,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	bool is_auth = false;
 	u32 hemode = 0;
 	int ret;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ar->ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -3758,14 +3760,14 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
 		   arvif->vdev_id, bss_conf->bssid, vif->cfg.aid);
 
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 arvif->bssid);
 	if (peer && peer->is_authorized)
 		is_auth = true;
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	/* Authorize BSS Peer */
 	if (is_auth) {
@@ -5475,15 +5477,18 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 	int ret;
 	int i;
 	u32 flags = 0;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id, addr);
-	spin_unlock_bh(&ab->base_lock);
-
-	if (!peer)
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id, addr);
+	if (!peer) {
+		spin_unlock_bh(&dp->dp_lock);
 		return -ENOENT;
+	}
+
+	spin_unlock_bh(&dp->dp_lock);
 
 	for (i = 0; i < ARRAY_SIZE(peer->keys); i++) {
 		if (!peer->keys[i])
@@ -5499,9 +5504,9 @@ static int ath12k_clear_peer_keys(struct ath12k_link_vif *arvif,
 			ath12k_warn(ab, "failed to remove peer key %d: %d\n",
 				    i, ret);
 
-		spin_lock_bh(&ab->base_lock);
+		spin_lock_bh(&dp->dp_lock);
 		peer->keys[i] = NULL;
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 	}
 
 	return first_errno;
@@ -5519,6 +5524,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	const u8 *peer_addr;
 	int ret;
 	u32 flags = 0;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -5538,12 +5544,12 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	/* the peer should not disappear in mid-way (unless FW goes awry) since
 	 * we already hold wiphy lock. we just make sure its there now.
 	 */
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id,
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 peer_addr);
-	spin_unlock_bh(&ab->base_lock);
-
 	if (!peer) {
+		spin_unlock_bh(&dp->dp_lock);
+
 		if (cmd == SET_KEY) {
 			ath12k_warn(ab, "cannot install key for non-existent peer %pM\n",
 				    peer_addr);
@@ -5556,6 +5562,8 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		return 0;
 	}
 
+	spin_unlock_bh(&dp->dp_lock);
+
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
 		flags = WMI_KEY_PAIRWISE;
 	else
@@ -5573,8 +5581,8 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		return ret;
 	}
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ab, arvif->vdev_id,
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 peer_addr);
 	if (peer && cmd == SET_KEY) {
 		peer->keys[key->keyidx] = key;
@@ -5615,7 +5623,7 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 		}
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	return 0;
 }
@@ -6283,14 +6291,15 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ar->ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	ath12k_mac_dec_num_stations(arvif, arsta);
 
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 arsta->addr);
 	if (peer && peer->sta == sta) {
 		ath12k_warn(ar->ab, "Found peer entry %pM n vdev %i after it was supposedly removed\n",
@@ -6301,7 +6310,7 @@ static void ath12k_mac_station_post_remove(struct ath12k *ar,
 		ar->num_peers--;
 	}
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	kfree(arsta->rx_stats);
 	arsta->rx_stats = NULL;
@@ -6313,17 +6322,18 @@ static int ath12k_mac_station_unauthorize(struct ath12k *ar,
 {
 	struct ath12k_dp_link_peer *peer;
 	int ret;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ar->ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 arsta->addr);
 	if (peer)
 		peer->is_authorized = false;
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	/* Driver must clear the keys during the state change from
 	 * IEEE80211_STA_AUTHORIZED to IEEE80211_STA_ASSOC, since after
@@ -6348,17 +6358,18 @@ static int ath12k_mac_station_authorize(struct ath12k *ar,
 	struct ath12k_dp_link_peer *peer;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	int ret;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ar->ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 arsta->addr);
 	if (peer)
 		peer->is_authorized = true;
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
 		ret = ath12k_wmi_set_peer_param(ar, arsta->addr,
@@ -7264,6 +7275,7 @@ void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 	struct ath12k_link_vif *arvif;
 	struct ath12k_dp_link_peer *peer;
 	u32 bw, smps;
+	struct ath12k_dp *dp;
 
 	rcu_read_lock();
 	arvif = rcu_dereference(ahvif->link[link_sta->link_id]);
@@ -7275,6 +7287,7 @@ void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 	}
 
 	ar = arvif->ar;
+	dp = ath12k_ab_to_dp(ar->ab);
 
 	arsta = rcu_dereference(ahsta->link[link_sta->link_id]);
 	if (!arsta) {
@@ -7283,19 +7296,19 @@ void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
 			    link_sta->link_id, sta->addr);
 		return;
 	}
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arvif->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arvif->vdev_id,
 							 arsta->addr);
 	if (!peer) {
-		spin_unlock_bh(&ar->ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		rcu_read_unlock();
 		ath12k_warn(ar->ab, "mac sta rc update failed to find peer %pM on vdev %i\n",
 			    arsta->addr, arvif->vdev_id);
 		return;
 	}
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	if (arsta->link_id >= IEEE80211_MLD_MAX_NUM_LINKS) {
 		rcu_read_unlock();
@@ -8923,6 +8936,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	u16 mcbc_gsn;
 	u8 link_id;
 	int ret;
+	struct ath12k_dp *tmp_dp;
 
 	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ieee80211_free_txskb(hw, skb);
@@ -9048,11 +9062,12 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			if (unlikely(!ahvif->dp_vif.key_cipher))
 				goto skip_peer_find;
 
-			spin_lock_bh(&tmp_ar->ab->base_lock);
-			peer = ath12k_dp_link_peer_find_by_addr(tmp_ar->ab,
+			tmp_dp = ath12k_ab_to_dp(tmp_ar->ab);
+			spin_lock_bh(&tmp_dp->dp_lock);
+			peer = ath12k_dp_link_peer_find_by_addr(tmp_dp,
 								tmp_arvif->bssid);
 			if (!peer) {
-				spin_unlock_bh(&tmp_ar->ab->base_lock);
+				spin_unlock_bh(&tmp_dp->dp_lock);
 				ath12k_warn(tmp_ar->ab,
 					    "failed to find peer for vdev_id 0x%X addr %pM link_map 0x%X\n",
 					    tmp_arvif->vdev_id, tmp_arvif->bssid,
@@ -9071,7 +9086,7 @@ void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 					hdr->frame_control |=
 						cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 			}
-			spin_unlock_bh(&tmp_ar->ab->base_lock);
+			spin_unlock_bh(&tmp_dp->dp_lock);
 
 skip_peer_find:
 			ret = ath12k_wifi7_dp_tx(tmp_dp_pdev, tmp_arvif,
@@ -11651,7 +11666,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ab->hw_params->vdev_start_delay &&
 	    ahvif->vdev_type != WMI_VDEV_TYPE_AP &&
 	    ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
-	    !ath12k_dp_link_peer_exist_by_vdev_id(ab, arvif->vdev_id)) {
+	    !ath12k_dp_link_peer_exist_by_vdev_id(ath12k_ab_to_dp(ab), arvif->vdev_id)) {
 		ret = 0;
 		goto out;
 	}
@@ -12371,6 +12386,8 @@ ath12k_mac_validate_fixed_rate_settings(struct ath12k *ar, enum nl80211_band ban
 	struct ath12k_dp_link_peer *peer, *tmp;
 	u8 vht_nss, he_nss;
 	int ret = true;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	vht_mcs_mask = mask->control[band].vht_mcs;
 	he_mcs_mask = mask->control[band].he_mcs;
@@ -12388,8 +12405,8 @@ ath12k_mac_validate_fixed_rate_settings(struct ath12k *ar, enum nl80211_band ban
 	he_nss =  ath12k_mac_max_he_nss(he_mcs_mask);
 
 	rcu_read_lock();
-	spin_lock_bh(&ar->ab->base_lock);
-	list_for_each_entry_safe(peer, tmp, &ar->ab->peers, list) {
+	spin_lock_bh(&dp->dp_lock);
+	list_for_each_entry_safe(peer, tmp, &dp->peers, list) {
 		if (peer->sta) {
 			link_sta = rcu_dereference(peer->sta->link[link_id]);
 			if (!link_sta) {
@@ -12410,7 +12427,7 @@ ath12k_mac_validate_fixed_rate_settings(struct ath12k *ar, enum nl80211_band ban
 		}
 	}
 exit:
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 28801d87e6ed..68eebaa24ed9 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -29,15 +29,16 @@ static int ath12k_wait_for_dp_link_peer_common(struct ath12k_base *ab, int vdev_
 					       const u8 *addr, bool expect_mapped)
 {
 	int ret;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	ret = wait_event_timeout(ab->peer_mapping_wq, ({
 				bool mapped;
 
-				spin_lock_bh(&ab->base_lock);
-				mapped = !!ath12k_dp_link_peer_find_by_vdev_and_addr(ab,
+				spin_lock_bh(&dp->dp_lock);
+				mapped = !!ath12k_dp_link_peer_find_by_vdev_and_addr(dp,
 										vdev_id,
 										addr);
-				spin_unlock_bh(&ab->base_lock);
+				spin_unlock_bh(&dp->dp_lock);
 
 				(mapped == expect_mapped ||
 				 test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags));
@@ -53,11 +54,12 @@ void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
 {
 	struct ath12k_dp_link_peer *peer, *tmp;
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	spin_lock_bh(&ab->base_lock);
-	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
+	spin_lock_bh(&dp->dp_lock);
+	list_for_each_entry_safe(peer, tmp, &dp->peers, list) {
 		if (peer->vdev_id != vdev_id)
 			continue;
 
@@ -69,7 +71,7 @@ void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
 		ar->num_peers--;
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 }
 
 static int ath12k_wait_for_peer_deleted(struct ath12k *ar, int vdev_id, const u8 *addr)
@@ -156,6 +158,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	struct ath12k_sta *ahsta;
 	u16 ml_peer_id;
 	int ret;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ar->ab);
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -167,14 +170,14 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		return -ENOBUFS;
 	}
 
-	spin_lock_bh(&ar->ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_pdev_and_addr(ar->ab, ar->pdev_idx,
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_pdev_and_addr(dp, ar->pdev_idx,
 							 arg->peer_addr);
 	if (peer) {
-		spin_unlock_bh(&ar->ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return -EINVAL;
 	}
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	ret = ath12k_wmi_send_peer_create_cmd(ar, arg);
 	if (ret) {
@@ -189,12 +192,12 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	if (ret)
 		return ret;
 
-	spin_lock_bh(&ar->ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(ar->ab, arg->vdev_id,
+	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, arg->vdev_id,
 							 arg->peer_addr);
 	if (!peer) {
-		spin_unlock_bh(&ar->ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
 			    arg->peer_addr, arg->vdev_id);
 
@@ -255,7 +258,7 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	ar->num_peers++;
 
-	spin_unlock_bh(&ar->ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 4180db504c31..da745566aca3 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -37,6 +37,7 @@ void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u1
 	qref->info1 = u32_encode_bits(upper_32_bits(paddr),
 				      BUFFER_ADDR_INFO1_ADDR) |
 		      u32_encode_bits(tid, DP_REO_QREF_NUM);
+
 	ath12k_hal_reo_shared_qaddr_cache_clear(ab);
 }
 
@@ -316,7 +317,6 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 				      struct hal_rx_desc_data *rx_info)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
-	struct ath12k_base *ab = dp->ab;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_encrypt_type enctype;
 	bool is_decrypted = false;
@@ -332,8 +332,8 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	if (rxcb->is_mcbc)
 		rxcb->peer_id = rx_info->peer_id;
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_rx_h_find_link_peer(ab, msdu, rx_info);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_rx_h_find_link_peer(dp, msdu, rx_info);
 	if (peer) {
 		/* resetting mcbc bit because mcbc packets are unicast
 		 * packets only for AP as STA sends unicast packets.
@@ -347,7 +347,7 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	} else {
 		enctype = HAL_ENCRYPT_TYPE_OPEN;
 	}
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	if (enctype != HAL_ENCRYPT_TYPE_OPEN && !err_bitmap)
 		is_decrypted = rx_info->is_decrypted;
@@ -1133,8 +1133,8 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	if (WARN_ON_ONCE(!frag_no && !more_frags))
 		return -EINVAL;
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
 	if (!peer) {
 		ath12k_warn(ab, "failed to find the peer to de-fragment received fragment peer_id %d\n",
 			    peer_id);
@@ -1193,11 +1193,11 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 		goto out_unlock;
 	}
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 	timer_delete_sync(&rx_tid->frag_timer);
-	spin_lock_bh(&ab->base_lock);
+	spin_lock_bh(&dp->dp_lock);
 
-	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
+	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
 	if (!peer)
 		goto err_frags_cleanup;
 
@@ -1221,7 +1221,7 @@ static int ath12k_wifi7_dp_rx_frag_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	dev_kfree_skb_any(defrag_skb);
 	ath12k_dp_rx_frags_cleanup(rx_tid, true);
 out_unlock:
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index 3d06987cfc0e..77de02858677 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -396,6 +396,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	s32 noise_floor;
 	struct ieee80211_tx_status status = {};
 	struct ath12k_dp_link_peer *peer;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -448,18 +449,18 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		}
 	}
 	rcu_read_lock();
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_id(ab, peer_id);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_id(dp, peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DATA,
 			   "dp_tx: failed to find the peer with peer_id %d\n", peer_id);
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ieee80211_free_txskb(ath12k_ar_to_hw(ar), msdu);
 		goto exit;
 	} else {
 		status.sta = peer->sta;
 	}
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	status.info = info;
 	status.skb = msdu;
@@ -527,12 +528,12 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 	u8 rate_idx = 0;
 	int ret;
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_id(ab, ts->peer_id);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_id(dp, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 			   "failed to find the peer by id %u\n", ts->peer_id);
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return;
 	}
 	sta = peer->sta;
@@ -546,7 +547,7 @@ static void ath12k_wifi7_dp_tx_update_txcompl(struct ath12k_pdev_dp *dp_pdev,
 		txrate.nss = arsta->last_txrate.nss;
 	else
 		txrate.nss = arsta->peer_nss;
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	switch (ts->pkt_type) {
 	case HAL_TX_RATE_STATS_PKT_TYPE_11A:
@@ -746,20 +747,20 @@ static void ath12k_wifi7_dp_tx_complete_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ath12k_wifi7_dp_tx_update_txcompl(dp_pdev, ts);
 
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_dp_link_peer_find_by_id(ab, ts->peer_id);
+	spin_lock_bh(&dp->dp_lock);
+	peer = ath12k_dp_link_peer_find_by_id(dp, ts->peer_id);
 	if (!peer || !peer->sta) {
 		ath12k_err(ab,
 			   "dp_tx: failed to find the peer with peer_id %d\n",
 			   ts->peer_id);
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		ieee80211_free_txskb(ath12k_pdev_dp_to_hw(dp_pdev), msdu);
 		goto exit;
 	}
 	ahsta = ath12k_sta_to_ahsta(peer->sta);
 	arsta = &ahsta->deflink;
 
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	status.sta = peer->sta;
 	status.info = info;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 0f1bdd5425dc..2767d6865d70 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -956,8 +956,9 @@ void ath12k_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab)
 {
 	u32 val;
 	struct ath12k_hal *hal = &ab->hal;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 
-	lockdep_assert_held(&ab->base_lock);
+	lockdep_assert_held(&dp->dp_lock);
 	val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_REO_REG +
 				HAL_REO1_QDESC_ADDR(hal));
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index a3ea42fc0933..80f499b5df35 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -116,15 +116,16 @@ ath12k_wifi7_is_frame_link_agnostic_wcn7850(struct ath12k_link_vif *arvif,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ath12k_hw *ah = ath12k_ar_to_ah(arvif->ar);
 	struct ath12k_base *ab = arvif->ar->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	__le16 fc = mgmt->frame_control;
 
-	spin_lock_bh(&ab->base_lock);
-	if (!ath12k_dp_link_peer_find_by_addr(ab, mgmt->da) &&
+	spin_lock_bh(&dp->dp_lock);
+	if (!ath12k_dp_link_peer_find_by_addr(dp, mgmt->da) &&
 	    !ath12k_peer_ml_find(ah, mgmt->da)) {
-		spin_unlock_bh(&ab->base_lock);
+		spin_unlock_bh(&dp->dp_lock);
 		return false;
 	}
-	spin_unlock_bh(&ab->base_lock);
+	spin_unlock_bh(&dp->dp_lock);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		return arvif->is_up &&
-- 
2.34.1


