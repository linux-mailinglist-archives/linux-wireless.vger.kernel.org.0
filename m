Return-Path: <linux-wireless+bounces-15558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09B9D503C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38C81F232C2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950619FA93;
	Thu, 21 Nov 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNDkdjm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351CB19F11E
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204694; cv=none; b=O+2e0NELmngdbdcQXqUl5wYXn624z4ZRSpeQjyrx06TPhv8Gh5Iwutj/77OhfVHlupv76fPkukEoeD9D1nRXyE1u9dFb1NvazxjlPWPnzwz+Yaha+QVvZiDvky/QxOQLcabcZ70wLKMZ4FSXJTY+VSn7nr2y04yWdODU4ARlDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204694; c=relaxed/simple;
	bh=YBHUZ421odpWi0aVXgDV5WLSpvfLYQdPAjzx0CzCx/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4yy/Lh9LVwWNncRcasuD6VUbY25/JsxkTDNxKN1BmngSthDsvlwqELLwUqHReDfAI2k9rNitvbixrz5LB0VH6YGE2/knjOTX1Gb73cDBR3gPN3PCLH8tV8GOw5cHUupHOZlLr2m7OJrb1QhqR6oPWbd1P4xUdB3a1fmFPV0Zxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNDkdjm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24956C4CECC;
	Thu, 21 Nov 2024 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204693;
	bh=YBHUZ421odpWi0aVXgDV5WLSpvfLYQdPAjzx0CzCx/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNDkdjm9X/vj60aZnfelNu5BbrO3U+P5ITrmU4RzxXJ2bY/tF8tzGjibQJexX8oIh
	 CPcsZfOp36yoDpWEm/dv3JmCIBMUn9dwT0t4g8IQd4/emJdgEG3B/coIdbRtI3ZR3d
	 y7q0B+WrkApNO0XC4K20qYEwwniMJ/vGDu8NPKaWrJz7RKEseuHV06/vWBkKNkN89A
	 FfEOyRbwzY7MiRCgFSRr/F/HSiToE0IgSzt8S1p8qgzHnWLPFIO7WupejJWdfO0amm
	 /4CpYijARGgl0imtsxBSho1OZn2+BBhpbS9s0AcmK4KM+iPq9f6AfCbe7ykHkh2UmO
	 60Trv+BteCTSw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 5/8] wifi: ath12k: add reo queue lookup table for ML peers
Date: Thu, 21 Nov 2024 17:58:03 +0200
Message-Id: <20241121155806.1862733-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121155806.1862733-1-kvalo@kernel.org>
References: <20241121155806.1862733-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently reoqueue tid setup uses lookup table (LUT) during peer association,
but for ML peer there will be multiple link peers (belonging to different
underlying firmware) affiliated to each other. Hence the reo queue should be
setup only on one of the links which is the primary link.

Add changes to create separate ML reo queue lookup table for ML peers and use
the same while setting up rx tid for ML peer's primary link. For ML peers use
ml_peer_id instead of peer_id to setup/lookup the reo queue entry in the LUT.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 39 +++++++++++++++-----
 drivers/net/wireless/ath/ath12k/dp.h    |  1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 48 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/peer.c  |  2 ++
 drivers/net/wireless/ath/ath12k/peer.h  |  2 +-
 5 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 23326e2dfe8d..328be2c635d6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1265,15 +1265,23 @@ static void ath12k_dp_reoq_lut_cleanup(struct ath12k_base *ab)
 	if (!ab->hw_params->reoq_lut_support)
 		return;
 
-	if (!dp->reoq_lut.vaddr)
-		return;
+	if (dp->reoq_lut.vaddr) {
+		ath12k_hif_write32(ab,
+				   HAL_SEQ_WCSS_UMAC_REO_REG +
+				   HAL_REO1_QDESC_LUT_BASE0(ab), 0);
+		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
+				  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
+		dp->reoq_lut.vaddr = NULL;
+	}
 
-	dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
-			  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
-	dp->reoq_lut.vaddr = NULL;
-
-	ath12k_hif_write32(ab,
-			   HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab), 0);
+	if (dp->ml_reoq_lut.vaddr) {
+		ath12k_hif_write32(ab,
+				   HAL_SEQ_WCSS_UMAC_REO_REG +
+				   HAL_REO1_QDESC_LUT_BASE1(ab), 0);
+		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
+				  dp->ml_reoq_lut.vaddr, dp->ml_reoq_lut.paddr);
+		dp->ml_reoq_lut.vaddr = NULL;
+	}
 }
 
 void ath12k_dp_free(struct ath12k_base *ab)
@@ -1599,8 +1607,23 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 		return -ENOMEM;
 	}
 
+	dp->ml_reoq_lut.vaddr = dma_alloc_coherent(ab->dev,
+						   DP_REOQ_LUT_SIZE,
+						   &dp->ml_reoq_lut.paddr,
+						   GFP_KERNEL | __GFP_ZERO);
+	if (!dp->ml_reoq_lut.vaddr) {
+		ath12k_warn(ab, "failed to allocate memory for ML reoq table");
+		dma_free_coherent(ab->dev, DP_REOQ_LUT_SIZE,
+				  dp->reoq_lut.vaddr, dp->reoq_lut.paddr);
+		dp->reoq_lut.vaddr = NULL;
+		return -ENOMEM;
+	}
+
 	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE0(ab),
 			   dp->reoq_lut.paddr);
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_REO_REG + HAL_REO1_QDESC_LUT_BASE1(ab),
+			   dp->ml_reoq_lut.paddr >> 8);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 2e05fc19410e..a120b7a8477d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -368,6 +368,7 @@ struct ath12k_dp {
 	struct dp_rxdma_mon_ring rxdma_mon_buf_ring;
 	struct dp_rxdma_mon_ring tx_mon_buf_ring;
 	struct ath12k_reo_q_addr_lut reoq_lut;
+	struct ath12k_reo_q_addr_lut ml_reoq_lut;
 };
 
 /* HTT definitions */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 048edb79e993..1b1297c105ae 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -740,15 +740,22 @@ static void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u
 {
 	struct ath12k_reo_queue_ref *qref;
 	struct ath12k_dp *dp = &ab->dp;
+	bool ml_peer = false;
 
 	if (!ab->hw_params->reoq_lut_support)
 		return;
 
-	/* TODO: based on ML peer or not, select the LUT. below assumes non
-	 * ML peer
-	 */
-	qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
-			(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
+	if (peer_id & ATH12K_PEER_ML_ID_VALID) {
+		peer_id &= ~ATH12K_PEER_ML_ID_VALID;
+		ml_peer = true;
+	}
+
+	if (ml_peer)
+		qref = (struct ath12k_reo_queue_ref *)dp->ml_reoq_lut.vaddr +
+				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
+	else
+		qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
+				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
 
 	qref->info0 = u32_encode_bits(lower_32_bits(paddr),
 				      BUFFER_ADDR_INFO0_ADDR);
@@ -761,15 +768,22 @@ static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u
 {
 	struct ath12k_reo_queue_ref *qref;
 	struct ath12k_dp *dp = &ab->dp;
+	bool ml_peer = false;
 
 	if (!ab->hw_params->reoq_lut_support)
 		return;
 
-	/* TODO: based on ML peer or not, select the LUT. below assumes non
-	 * ML peer
-	 */
-	qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
-			(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
+	if (peer_id & ATH12K_PEER_ML_ID_VALID) {
+		peer_id &= ~ATH12K_PEER_ML_ID_VALID;
+		ml_peer = true;
+	}
+
+	if (ml_peer)
+		qref = (struct ath12k_reo_queue_ref *)dp->ml_reoq_lut.vaddr +
+				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
+	else
+		qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
+				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
 
 	qref->info0 = u32_encode_bits(0, BUFFER_ADDR_INFO0_ADDR);
 	qref->info1 = u32_encode_bits(0, BUFFER_ADDR_INFO1_ADDR) |
@@ -802,7 +816,10 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 		rx_tid->vaddr = NULL;
 	}
 
-	ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
+	if (peer->mlo)
+		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
+	else
+		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
 
 	rx_tid->active = false;
 }
@@ -945,7 +962,8 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return 0;
 	}
 
-	if (ab->hw_params->reoq_lut_support && !dp->reoq_lut.vaddr) {
+	if (ab->hw_params->reoq_lut_support &&
+	    (!dp->reoq_lut.vaddr || !dp->ml_reoq_lut.vaddr)) {
 		spin_unlock_bh(&ab->base_lock);
 		ath12k_warn(ab, "reo qref table is not setup\n");
 		return -EINVAL;
@@ -1026,7 +1044,11 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		/* Update the REO queue LUT at the corresponding peer id
 		 * and tid with qaddr.
 		 */
-		ath12k_peer_rx_tid_qref_setup(ab, peer->peer_id, tid, paddr);
+		if (peer->mlo)
+			ath12k_peer_rx_tid_qref_setup(ab, peer->ml_id, tid, paddr);
+		else
+			ath12k_peer_rx_tid_qref_setup(ab, peer->peer_id, tid, paddr);
+
 		spin_unlock_bh(&ab->base_lock);
 	} else {
 		spin_unlock_bh(&ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 25905498e8fb..5763c5a40cfc 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -396,9 +396,11 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 			/* the assoc link is considered primary for now */
 			peer->primary_link = arsta->is_assoc_link;
+			peer->mlo = true;
 		} else {
 			peer->ml_id = ATH12K_MLO_PEER_ID_INVALID;
 			peer->primary_link = true;
+			peer->mlo = false;
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index a39e943bd66b..7e6231cb2b52 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -46,7 +46,7 @@ struct ath12k_peer {
 	struct ppdu_user_delayba ppdu_stats_delayba;
 	bool delayba_flag;
 	bool is_authorized;
-
+	bool mlo;
 	/* protected by ab->data_lock */
 	bool dp_setup_done;
 
-- 
2.39.5


