Return-Path: <linux-wireless+bounces-15556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC159D504C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24163B29AAA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86AA19DF66;
	Thu, 21 Nov 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITWNqTa4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427019E97E
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204691; cv=none; b=m55rDs4iN9HLO69ER4fqBwCN3/stUWQG58dKGy9EzhwySWwCP/3ljTmEjKhc1EZ3R8zDn6eqPxnPGVzkeMH0VjknbP1xPaipUb6SO7NLwxMGCzDFDqhDA33THhsnHb9h7ihJUlX9sSPJbM9qzk/sm2H5KcHzy0d9cX9VPbH9X8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204691; c=relaxed/simple;
	bh=lz8DWRHr4euA7PgzUILmcwJvqCJm9ItkxlefHbmzVjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/yw35mezxDLOBSY/Riw2lHdOyHG6xoH6RuhPhAs3n3N3XxBgRtmZrSuog9hl6x0Ktx1UMwLpuTPad4q9ryE4d8NzW4+m8CfvPghAyaTLJXNMNJ8r4U2p4urcSAp/aGkw9NN2ImCtSO3/vDAVGXhA3mr65oQ8TPHQBMj8YiM5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITWNqTa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A0EC4CECD;
	Thu, 21 Nov 2024 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204691;
	bh=lz8DWRHr4euA7PgzUILmcwJvqCJm9ItkxlefHbmzVjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITWNqTa4XoJJ5VvCUkGcKsECIYMwHoc5iSjA3TBLrVZiQwlpGwnaFDGkBuq2ff5Gs
	 72jDyptXpvBf3xnbk4R+Ix/38NH/ZPimwPu5KZ3azvkh6CNFJ0P3CebohGLDBor0RQ
	 iqsSeHst4Uz2fB36aifQJwj3uTniBlsCCmXwWOoOqcpOA1clKdlX3Ni/fitLI6CPRO
	 p8kPTmrnsQHUt2Kvz949WsBVoKtOHG5FA989Biz/DVoWVG9+Mg/fGJtsiDxZ5wo2y2
	 s1f7LXpLoiTH6XIe28lsEtfstvOigTdrbYsjqTPEXBw9cxkkAvE+IdxY6o+FvmFGxa
	 MAGBBaOYOdsPA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/8] wifi: ath12k: add primary link for data path operations
Date: Thu, 21 Nov 2024 17:58:01 +0200
Message-Id: <20241121155806.1862733-4-kvalo@kernel.org>
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

From: Sriram R <quic_srirrama@quicinc.com>

In case of Multi-link operation, data path peer setup and tid setup should be
done only for primary link of multi-link station. Add changes to introduce
primary link is peer. Currently, association link will be considered as primary
link.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |  5 +++++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/peer.c  | 23 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h  |  8 ++++++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index c99e9ceb1a6e..23326e2dfe8d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -41,6 +41,11 @@ void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 		return;
 	}
 
+	if (!peer->primary_link) {
+		spin_unlock_bh(&ab->base_lock);
+		return;
+	}
+
 	ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 	crypto_free_shash(peer->tfm_mmic);
 	peer->dp_setup_done = false;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9ae579e50557..048edb79e993 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -940,6 +940,11 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return -ENOENT;
 	}
 
+	if (!peer->primary_link) {
+		spin_unlock_bh(&ab->base_lock);
+		return 0;
+	}
+
 	if (ab->hw_params->reoq_lut_support && !dp->reoq_lut.vaddr) {
 		spin_unlock_bh(&ab->base_lock);
 		ath12k_warn(ab, "reo qref table is not setup\n");
@@ -2781,6 +2786,11 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 		return -ENOENT;
 	}
 
+	if (!peer->primary_link) {
+		spin_unlock_bh(&ab->base_lock);
+		return 0;
+	}
+
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->rx_tid[i];
 		rx_tid->ab = ab;
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index ffbc1265ccc1..25905498e8fb 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -313,7 +313,11 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ath12k_wmi_peer_create_arg *arg)
 {
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
+	struct ath12k_link_sta *arsta;
+	u8 link_id = arvif->link_id;
 	struct ath12k_peer *peer;
+	struct ath12k_sta *ahsta;
+	u16 ml_peer_id;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -379,6 +383,25 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		arvif->ast_idx = peer->hw_peer_id;
 	}
 
+	if (sta) {
+		ahsta = ath12k_sta_to_ahsta(sta);
+		arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+					  ahsta->link[link_id]);
+
+		/* Fill ML info into created peer */
+		if (sta->mlo) {
+			ml_peer_id = ahsta->ml_peer_id;
+			peer->ml_id = ml_peer_id | ATH12K_PEER_ML_ID_VALID;
+			ether_addr_copy(peer->ml_addr, sta->addr);
+
+			/* the assoc link is considered primary for now */
+			peer->primary_link = arsta->is_assoc_link;
+		} else {
+			peer->ml_id = ATH12K_MLO_PEER_ID_INVALID;
+			peer->primary_link = true;
+		}
+	}
+
 	peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
 	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index e398d5a3fdc8..a39e943bd66b 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -51,6 +51,14 @@ struct ath12k_peer {
 	bool dp_setup_done;
 
 	u16 ml_id;
+
+	/* any other ML info common for all partners can be added
+	 * here and would be same for all partner peers.
+	 */
+	u8 ml_addr[ETH_ALEN];
+
+	/* To ensure only certain work related to dp is done once */
+	bool primary_link;
 };
 
 struct ath12k_ml_peer {
-- 
2.39.5


