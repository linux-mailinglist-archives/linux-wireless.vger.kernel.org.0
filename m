Return-Path: <linux-wireless+bounces-28232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C340C07B38
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ED1420F5E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4626ED31;
	Fri, 24 Oct 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KgSH3EQ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5E23875D
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329780; cv=none; b=Pv2gABkAQmAEbFctAq866JboC0RgZVoH8m+w5ublTOh/z7GO+2EMmVeqZ2IXEaZINyg5pDHp3OZlhuLp38psx8vVtJFN4PqfOHMGVlUcGcznLjKuD++IprskOwUIslsor1hlhUcGq5WSlPBlbJm8DH/huwBpGfW3jpZ/EGO8Ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329780; c=relaxed/simple;
	bh=MnBRNPSz4pvTPJAsiV84EOYIDLWW0mmKJ9jtxnua0NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzYoo79WbokPTABZRevLxRBt3eX8SxFnoagT4A/2OwpGRglBsu96Q2OqResm0ZcKIiyVnyXrSy/jq5DpC5JGhXsiOwR7ZPPRyAs8gBYKgji/wXc7XT9RK4OYzYZH6QiZIcyrRNAsoJyAlJaUnOBY5GjUcKzD6PR0vv/AwUbwBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KgSH3EQ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9K2u026926;
	Fri, 24 Oct 2025 18:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q9corRmzcdWjNohnTr593BxKbB75iP4tdtZGsfOxVro=; b=KgSH3EQ5AVbBmSbI
	P/EHOMjtEWL+KeVItDb55ANai3y0rbWWCgQYuYH40G7ZifR96mBRLlFUfqW/hbFn
	QQYZZdseG5qKjGT3U+OErbSFnb2d4RPVVTFaWs3cnIyBtp43melHbf5k95JR2xjE
	97TduhHUHPk4ljf087OxTciwGkv6kH9xzmZjhger9FGbfN0Pdt79nY2jI1UvqXxe
	m1TTNe3fQ8JSk4lgqd97UcqFtouFf4HykF0zjpR15U8R4iIAxk9Mv78urdYiyRKz
	neE06kCWEs5xIbytY/a3PT+0AXxLDuIoAB7kqpYdjcCKJB+mHc/kXBuI/KUzUB5q
	9E3JgQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0tvas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGD4F031117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:13 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:12 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 5/9] wifi: ath12k: Add hash table for ath12k_dp_link_peer
Date: Fri, 24 Oct 2025 23:45:44 +0530
Message-ID: <20251024181548.3255166-6-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX0kpYZGy3Pr6C
 9yjK8zjyDKPWKMyLgkw5mFP2dSTsCnsuLLaEBuJ8BNND23vQSRrBGi88ti7bEVj+kqNq05r34ue
 nuSp9xAf2JC05qb2lHkl5CipeER/SlWTbSf8YkBCjIj7iq1l1q1wSj17CMu2oe/SJU5sRc97Nnp
 I2iTphtbtg217w/BIRedG56uBD7QIQjAWD4VJcWesajSBBJL7sqqHXHDsLY0VR7Dqj6bHcRy2v1
 OKt2BiOISI4qBa1P6kZZM2fXip1V+/VM7Br+EXUuXyeIvrS8pZ7vhupNDQMGLjAh2ycILM+dFxw
 13HgYWbxz7k/jN+YsX0cNRE3293N072LDvBmU3VrXCkFIs8V4S54jvR1F/wqUhalZZC2q18aIs1
 DsINxfeFCedkT6/X4XoURxFh88BuAg==
X-Proofpoint-ORIG-GUID: 3fQMt0GngA6syl3ijNCmHCIVNndLRAi5
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fbc26e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=u7CG6Q6x4P9xfC_OhR8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3fQMt0GngA6syl3ijNCmHCIVNndLRAi5
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

There is a linked list of ath12k_dp_link_peer maintained in ath12k_dp. For
link peer search based on mac address, there is iteration over the list wherein
the mac address are compared for each entry in the list. This search operation
is a costly operation considering the time complexity involved.

In order to reduce the complexity, add hash table for ath12k_dp_link_peer in
ath12k_dp where mac address of the link peer is used to derive the hash index.
This hash table is lock protected by spinlock "dp_lock" present in ath12k_dp.

This hash table is currently used for search of link peer using mac address for
any interaction between control path and data path, per packet Rx monitor path
and regular multicast Tx path.

Update API ath12k_dp_link_peer_find_by_addr() to make use of the hash table for
search operation using mac address, while other search APIs still rely on linked
list.

ath11k driver has been taken as reference for implementation of hash table.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c      |  14 ++-
 drivers/net/wireless/ath/ath12k/dp.h      |  10 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c | 138 ++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/dp_peer.h |   9 ++
 drivers/net/wireless/ath/ath12k/mac.c     |   2 +
 5 files changed, 160 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 40057df4cd66..676af752f069 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1122,6 +1122,8 @@ static void ath12k_dp_cleanup(struct ath12k_base *ab)
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int i;
 
+	ath12k_dp_link_peer_rhash_tbl_destroy(dp);
+
 	if (!dp->ab)
 		return;
 
@@ -1487,14 +1489,22 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 	spin_lock_init(&dp->dp_lock);
 	INIT_LIST_HEAD(&dp->peers);
 
+	mutex_init(&dp->link_peer_rhash_tbl_lock);
+
 	dp->reo_cmd_cache_flush_count = 0;
 	dp->idle_link_rbm =
 			ath12k_hal_get_idle_link_rbm(&ab->hal, ab->device_id);
 
+	ret = ath12k_dp_link_peer_rhash_tbl_init(dp);
+	if (ret) {
+		ath12k_warn(ab, "failed to init link_peer rhash table: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup wbm_idle_ring: %d\n", ret);
-		return ret;
+		goto rhash_destroy;
 	}
 
 	srng = &ab->hal.srng_list[dp->wbm_idle_ring.ring_id];
@@ -1575,6 +1585,8 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 fail_link_desc_cleanup:
 	ath12k_dp_link_desc_cleanup(ab, dp->link_desc_banks,
 				    HAL_WBM_IDLE_LINK, &dp->wbm_idle_ring);
+rhash_destroy:
+	ath12k_dp_link_peer_rhash_tbl_destroy(dp);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index fc87b749a040..b90725094111 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -10,6 +10,7 @@
 #include "hw.h"
 #include "dp_htt.h"
 #include "dp_cmn.h"
+#include <linux/rhashtable.h>
 
 #define MAX_RXDMA_PER_PDEV     2
 
@@ -471,13 +472,20 @@ struct ath12k_dp {
 	struct ath12k_hw_group *ag;
 	u8 device_id;
 
-	/* Lock for protection of peers */
+	/* Lock for protection of peers and rhead_peer_addr */
 	spinlock_t dp_lock;
 
 	struct ath12k_dp_arch_ops *ops;
 
 	/* Linked list of struct ath12k_dp_link_peer */
 	struct list_head peers;
+
+	/* For rhash table init and deinit protection */
+	struct mutex link_peer_rhash_tbl_lock;
+
+	/* The rhashtable containing struct ath12k_link_peer keyed by mac addr */
+	struct rhashtable *rhead_peer_addr;
+	struct rhashtable_params rhash_peer_addr_param;
 };
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 0267f68f8573..0cf28791568e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -51,18 +51,10 @@ ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_dp *dp, u8 pdev_idx,
 struct ath12k_dp_link_peer *
 ath12k_dp_link_peer_find_by_addr(struct ath12k_dp *dp, const u8 *addr)
 {
-	struct ath12k_dp_link_peer *peer;
-
 	lockdep_assert_held(&dp->dp_lock);
 
-	list_for_each_entry(peer, &dp->peers, list) {
-		if (!ether_addr_equal(peer->addr, addr))
-			continue;
-
-		return peer;
-	}
-
-	return NULL;
+	return rhashtable_lookup_fast(dp->rhead_peer_addr, addr,
+				      dp->rhash_peer_addr_param);
 }
 EXPORT_SYMBOL(ath12k_dp_link_peer_find_by_addr);
 
@@ -147,6 +139,7 @@ void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
 	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
 		   peer->vdev_id, peer->addr, peer_id);
 
+	ath12k_dp_link_peer_rhash_delete(dp, peer);
 	list_del(&peer->list);
 	kfree(peer);
 	wake_up(&ab->peer_mapping_wq);
@@ -160,6 +153,7 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 {
 	struct ath12k_dp_link_peer *peer;
 	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	int ret;
 
 	spin_lock_bh(&dp->dp_lock);
 	peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
@@ -173,7 +167,11 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_
 		peer->ast_hash = ast_hash;
 		peer->hw_peer_id = hw_peer_id;
 		ether_addr_copy(peer->addr, mac_addr);
-		list_add(&peer->list, &dp->peers);
+		ret = ath12k_dp_link_peer_rhash_add(dp, peer);
+		if (!ret)
+			list_add(&peer->list, &dp->peers);
+		else
+			kfree(peer);
 		wake_up(&ab->peer_mapping_wq);
 	}
 
@@ -209,3 +207,121 @@ struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
 	}
 	return arsta;
 }
+
+static int ath12k_dp_link_peer_rhash_addr_tbl_init(struct ath12k_dp *dp)
+{
+	struct ath12k_base *ab = dp->ab;
+	struct rhashtable_params *param;
+	struct rhashtable *rhash_addr_tbl;
+	int ret;
+
+	lockdep_assert_held(&dp->link_peer_rhash_tbl_lock);
+
+	rhash_addr_tbl = kzalloc(sizeof(*dp->rhead_peer_addr), GFP_KERNEL);
+	if (!rhash_addr_tbl)
+		return -ENOMEM;
+
+	param = &dp->rhash_peer_addr_param;
+
+	param->key_offset = offsetof(struct ath12k_dp_link_peer, addr);
+	param->head_offset = offsetof(struct ath12k_dp_link_peer, rhash_addr);
+	param->key_len = sizeof_field(struct ath12k_dp_link_peer, addr);
+	param->automatic_shrinking = true;
+	param->nelem_hint = ab->num_radios * ath12k_core_get_max_peers_per_radio(ab);
+
+	ret = rhashtable_init(rhash_addr_tbl, param);
+	if (ret) {
+		ath12k_warn(ab, "failed to init peer addr rhash table %d\n", ret);
+		goto err_free;
+	}
+
+	dp->rhead_peer_addr = rhash_addr_tbl;
+
+	return 0;
+
+err_free:
+	kfree(rhash_addr_tbl);
+
+	return ret;
+}
+
+int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
+{
+	int ret;
+
+	mutex_lock(&dp->link_peer_rhash_tbl_lock);
+	ret = ath12k_dp_link_peer_rhash_addr_tbl_init(dp);
+	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
+
+	return ret;
+}
+
+void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
+{
+	mutex_lock(&dp->link_peer_rhash_tbl_lock);
+	rhashtable_destroy(dp->rhead_peer_addr);
+	kfree(dp->rhead_peer_addr);
+	dp->rhead_peer_addr = NULL;
+	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
+}
+
+static int ath12k_dp_link_peer_rhash_insert(struct ath12k_dp *dp,
+					    struct ath12k_dp_link_peer *peer)
+{
+	struct ath12k_dp_link_peer *tmp;
+
+	lockdep_assert_held(&dp->dp_lock);
+
+	tmp = rhashtable_lookup_get_insert_fast(dp->rhead_peer_addr, &peer->rhash_addr,
+						dp->rhash_peer_addr_param);
+	if (!tmp)
+		return 0;
+	else if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	else
+		return -EEXIST;
+}
+
+static int ath12k_dp_link_peer_rhash_remove(struct ath12k_dp *dp,
+					    struct ath12k_dp_link_peer *peer)
+{
+	int ret;
+
+	lockdep_assert_held(&dp->dp_lock);
+
+	ret = rhashtable_remove_fast(dp->rhead_peer_addr, &peer->rhash_addr,
+				     dp->rhash_peer_addr_param);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+int ath12k_dp_link_peer_rhash_add(struct ath12k_dp *dp,
+				  struct ath12k_dp_link_peer *peer)
+{
+	int ret;
+
+	lockdep_assert_held(&dp->dp_lock);
+
+	ret = ath12k_dp_link_peer_rhash_insert(dp, peer);
+	if (ret)
+		ath12k_warn(dp, "failed to add peer %pM with id %d in rhash_addr ret %d\n",
+			    peer->addr, peer->peer_id, ret);
+
+	return ret;
+}
+
+void ath12k_dp_link_peer_rhash_delete(struct ath12k_dp *dp,
+				      struct ath12k_dp_link_peer *peer)
+{
+	/* No failure handling and hence return type is void */
+	int ret;
+
+	lockdep_assert_held(&dp->dp_lock);
+
+	ret = ath12k_dp_link_peer_rhash_remove(dp, peer);
+	if (ret)
+		ath12k_warn(dp, "failed to remove peer %pM with id %d in rhash_addr ret %d\n",
+			    peer->addr, peer->peer_id, ret);
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
index ecc90df05b44..b94a9a5cb311 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.h
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -63,6 +63,9 @@ struct ath12k_dp_link_peer {
 	/* for reference to ath12k_link_sta */
 	u8 link_id;
 	bool ucast_ra_only;
+
+	/* peer addr based rhashtable list pointer */
+	struct rhash_head rhash_addr;
 };
 
 void ath12k_dp_link_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
@@ -83,4 +86,10 @@ ath12k_dp_link_peer_find_by_pdev_and_addr(struct ath12k_dp *dp, u8 pdev_idx,
 					  const u8 *addr);
 struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
 							struct ath12k_dp_link_peer *peer);
+int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp);
+void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp);
+int ath12k_dp_link_peer_rhash_add(struct ath12k_dp *dp,
+				  struct ath12k_dp_link_peer *peer);
+void ath12k_dp_link_peer_rhash_delete(struct ath12k_dp *dp,
+				      struct ath12k_dp_link_peer *peer);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fd6819ec390c..c7eeaf586b83 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1188,6 +1188,8 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 		if (peer->sta)
 			ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 
+		ath12k_dp_link_peer_rhash_delete(dp, peer);
+
 		list_del(&peer->list);
 		kfree(peer);
 	}
-- 
2.34.1


