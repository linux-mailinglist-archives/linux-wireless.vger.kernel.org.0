Return-Path: <linux-wireless+bounces-15727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E99D9C26
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EBC1652B6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48FF1DD520;
	Tue, 26 Nov 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZm/8ZnZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F01DD0E1
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641109; cv=none; b=Ler9Tjxsqq8M29dOMj//gq5WeW/jQWiO4sAKteFk6/+MaEs60N641Jwg24kNUg0454tpZ+vjpThoZQ77A3c53UxVUBePrsb9I3Ow3/FxTRDKrwwWAwVoxHBGjtgiIRgetojLtUrfakzLc/6iAyf3LL3jB4z2eb4cdeeda0cGrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641109; c=relaxed/simple;
	bh=HyoLG6QjgE87YFN4fnogXsE9Gq2KZL1WR9gKzmiN5mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwKP+5qb2s3GRbZlnlP9A7ZXGFie0fJYYhN6D7HYMe63ewRLzt/bXHmZhTIVWUFIaBL72WQilREqPJjpi2OYLsWa5l7WXLHRFUAdhncrsU2Ucct96PPexiOobqQQxM2gzvKXbXOYwOsqgVtImqVE/6Fr3ZFobSvDdpNcR5ZI5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZm/8ZnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19530C4CED0;
	Tue, 26 Nov 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641109;
	bh=HyoLG6QjgE87YFN4fnogXsE9Gq2KZL1WR9gKzmiN5mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZm/8ZnZizPZmAYxNJtZcZCd1QKxSEWOQ3q4ASvauw+QLdogo3DoYcaFmQdHmMSbw
	 uBIAA/ZTj52N6tekOREMVugKgm+YkdVbPoQksB66sUyZc+CJeLGEJLkeAwpyo4lKpJ
	 4uhCXc++KmQczUouz72TPEYtMt1jwDmiJptFVOWyKXOzIYBhBkFDwLO8oHW85voIDL
	 0sMnC1Yj8rAns0q0+CuXLFeybtwKYVnnchiqPk2G4senEhCrBJ7h5Mi+1bikb9HO4N
	 TEO5mYr/Tolk/StvAna+EbzR6UYNS/d0jDXuo5bJtfP53rOTfmeChy9XTj2jEdOLOA
	 ND8rYNNuUIRVw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 07/10] wifi: ath12k: ath12k_bss_assoc(): MLO support
Date: Tue, 26 Nov 2024 19:11:36 +0200
Message-Id: <20241126171139.2350704-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126171139.2350704-1-kvalo@kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

Currently, the ath12k_bss_assoc() function handles only deflink station
connections. To support multi-link station connections, make the necessary
changes to retrieve the required information from the link-level members.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 85cfbe1e4b9f..364e9c6adc73 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3133,7 +3133,9 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_up_params params = {};
-	struct ath12k_wmi_peer_assoc_arg peer_arg;
+	struct ath12k_wmi_peer_assoc_arg peer_arg = {};
+	struct ieee80211_link_sta *link_sta;
+	u8 link_id = bss_conf->link_id;
 	struct ath12k_link_sta *arsta;
 	struct ieee80211_sta *ap_sta;
 	struct ath12k_sta *ahsta;
@@ -3143,27 +3145,38 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %i assoc bssid %pM aid %d\n",
-		   arvif->vdev_id, arvif->bssid, ahvif->aid);
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac vdev %i link id %u assoc bssid %pM aid %d\n",
+		   arvif->vdev_id, link_id, arvif->bssid, ahvif->aid);
 
 	rcu_read_lock();
 
-	ap_sta = ieee80211_find_sta(vif, bss_conf->bssid);
+	/* During ML connection, cfg.ap_addr has the MLD address. For
+	 * non-ML connection, it has the BSSID.
+	 */
+	ap_sta = ieee80211_find_sta(vif, vif->cfg.ap_addr);
 	if (!ap_sta) {
 		ath12k_warn(ar->ab, "failed to find station entry for bss %pM vdev %i\n",
-			    bss_conf->bssid, arvif->vdev_id);
+			    vif->cfg.ap_addr, arvif->vdev_id);
 		rcu_read_unlock();
 		return;
 	}
 
 	ahsta = ath12k_sta_to_ahsta(ap_sta);
-	arsta = &ahsta->deflink;
 
+	arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+				  ahsta->link[link_id]);
 	if (WARN_ON(!arsta)) {
 		rcu_read_unlock();
 		return;
 	}
 
+	link_sta = ath12k_mac_get_link_sta(arsta);
+	if (WARN_ON(!link_sta)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	ath12k_peer_assoc_prepare(ar, arvif, arsta, &peer_arg, false);
 
 	rcu_read_unlock();
@@ -3182,8 +3195,7 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	}
 
 	ret = ath12k_setup_peer_smps(ar, arvif, bss_conf->bssid,
-				     &ap_sta->deflink.ht_cap,
-				     &ap_sta->deflink.he_6ghz_capa);
+				     &link_sta->ht_cap, &link_sta->he_6ghz_capa);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
-- 
2.39.5


