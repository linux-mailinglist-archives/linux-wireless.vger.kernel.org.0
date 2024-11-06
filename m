Return-Path: <linux-wireless+bounces-14995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA59BF011
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F89285687
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD08202620;
	Wed,  6 Nov 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu0p514b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089132022FA
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730903184; cv=none; b=WaOGDhsi79IIdwYPCJVuG9ugZ4kYZBlqlqCdYV/wEQ0IJhQnxJEN6/oz1YUhAHO0Stms8h6lp4zbLIVvEBaGojclfaQGibzvS8VReERjTfBPZZvmFQNXslERD5yogMG8bmkX8ef5PjnVewv9e7ktgb8E5lzOMOT7AOz69PFf3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730903184; c=relaxed/simple;
	bh=qTaHc4R/d27pvXoPhMmjbH7pRWXHmJ2NJHBK9CVZHXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIGjzqnojGeyF77N06bgvk8b/LcctmCCXHlgGps1BkX2vhLy2bQV5xdsMb/aEPp7gWmJ0E3pSRJuo2WmJCsO1SdbsHM0mkQYSpV/K2QD3w4QBOBNIayqWwTGmMla0cxNnGBCni8iw0XwOmDJiYplVZnJkx9KW11MRNr0bmyRwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu0p514b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F29C4CECC;
	Wed,  6 Nov 2024 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730903183;
	bh=qTaHc4R/d27pvXoPhMmjbH7pRWXHmJ2NJHBK9CVZHXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu0p514bQYMQgz0NW8nFhhgBZmWs2lKlDkpdPKSSLY3XPY7C+3LLy7beeZoMUJG2N
	 6Ff3QqVVXEki+5wsHvXsL0blMvU5G9bcrWA3OY/DK2cH/szOhTC7w+NMLziSqI6+h8
	 FiMPpFgps3guufUHO4ZULkREAdfA8tPve/EaA/yjP4D5SbCo5ofV10jLfGyrYKIsUy
	 ro85ZFNQV4hxnPX4WISAzwCZB6TpHAvhFinNgSla3Og0nNNYP4uo/0YJHY58GQ30FZ
	 sikd5CoqIM3HCTytbDc4RBFRe0AaE4ZSv7FiT85tQd53e9Pp5b20/BNwXZpyTIQipN
	 mb3Wd9g50QryQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/8] wifi: ath12k: add primary link for data path operations
Date: Wed,  6 Nov 2024 16:26:12 +0200
Message-Id: <20241106142617.660901-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106142617.660901-1-kvalo@kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
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
index 50e0d3d90bf6..b6d6a2983d09 100644
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


