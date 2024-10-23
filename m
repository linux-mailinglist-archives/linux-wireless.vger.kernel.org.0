Return-Path: <linux-wireless+bounces-14387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B089ACB45
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B528414B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984441B5ED0;
	Wed, 23 Oct 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8tD3z11"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754831C7B6F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690214; cv=none; b=mPHiBe8YVcNoRnHn67oUZabif3KL/SJgkLK+gHGrGLiIGVMO/1fo5F0QxIplqxooqsPuF1fsQeLTjbJU5S15X2/rKhJLeTdM/BzmOcd7wUw2HQB3FSh6d7/NlmdW+273WVj9RBLHwjLUWV2RQEJVtGrsOsvpGDRtSi3b1M0oQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690214; c=relaxed/simple;
	bh=BqfDhi/3OJXmo58YF+6jcdwSeLkPQeXxg4oys2yN8UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOWFakEp4vm17OPKuJ89yBMMKCHf63TpPZrxXBgWE0Hb0Oh8qwEFyjnBE3McjA8JXKW6CgQbwUrSDOm0mGzrPft919pPMIFzIajeHqlIoxX+710uPsDyMUto9io4Ple362JzXCFF8jvDzF3Al5STgZQSICi2L3Tfknf6yCybkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8tD3z11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51BEC4CEC6;
	Wed, 23 Oct 2024 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690214;
	bh=BqfDhi/3OJXmo58YF+6jcdwSeLkPQeXxg4oys2yN8UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8tD3z11ZqjdiGEqW5p9rcAf7EXVSxL8SI7sKX0QyXe7oi54BSfWSMEuu9OE2m7up
	 bMbkjEJiKSyoEs0TLFyPwb7LpCPgPiT+klBePPHMbRkn+a/JZeJ7LbgaAznIpgZ/R5
	 fRX17XxCsqLAJJhRkpi3LZMshu7mQWaI+QdwvKNF2oFUvjJIYiIqPJYE0T69+htBrr
	 86u93pkOUv1dd9y29+//ivRxzJ0gygojynEipeWCzAtinBl951QdwTNUFwmiul6sxJ
	 aUkLtGoV3r7tDLy+GPTCM1uINLBcvPmo00Dk6lPfnsD/+EICvzOKADTpxznvbEJ8xP
	 xDB/tDT08NkIA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 7/8] wifi: ath12k: add helper to find multi-link station
Date: Wed, 23 Oct 2024 16:30:03 +0300
Message-Id: <20241023133004.2253830-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023133004.2253830-1-kvalo@kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Multi-link stations are identified in driver using the multi-link
peer id. Add a helper to find multi-link station using the ML
peer id.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h   |  2 ++
 drivers/net/wireless/ath/ath12k/peer.c | 17 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 2e05fc19410e..66b60f772efb 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1796,6 +1796,8 @@ static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
 }
 
+#define ATH12K_ML_PEER_ID_VALID         BIT(13)
+
 int ath12k_dp_service_srng(struct ath12k_base *ab,
 			   struct ath12k_ext_irq_grp *irq_grp,
 			   int budget);
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 39b371c7433c..c7eb60723d83 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -80,6 +80,20 @@ struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
 	return NULL;
 }
 
+static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
+						     int ml_peer_id)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (ml_peer_id == peer->ml_peer_id)
+			return peer;
+
+	return NULL;
+}
+
 struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 					   int peer_id)
 {
@@ -87,6 +101,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 
 	lockdep_assert_held(&ab->base_lock);
 
+	if (peer_id & ATH12K_ML_PEER_ID_VALID)
+		return ath12k_peer_find_by_ml_id(ab, peer_id);
+
 	list_for_each_entry(peer, &ab->peers, list)
 		if (peer_id == peer->peer_id)
 			return peer;
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index b91bb2106b76..5b718fc5c795 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -47,6 +47,8 @@ struct ath12k_peer {
 
 	/* protected by ab->data_lock */
 	bool dp_setup_done;
+
+	u16 ml_peer_id;
 };
 
 struct ath12k_ml_peer {
-- 
2.39.5


