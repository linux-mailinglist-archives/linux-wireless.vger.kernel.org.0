Return-Path: <linux-wireless+bounces-13973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05BC99F3C5
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D64283264
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB81F9EDF;
	Tue, 15 Oct 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQaE0W3k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AC1F9EDE
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012466; cv=none; b=Ej2ciWzvYZebq4LSFxqMNOvG0IzuP1Z/Zw2tOKx+Sr9BBDlvvpkUZG9HfYJ/uINZplYCVdtR3pIdFhD23B/H3HMJQw+P1A2+c7C/UGhZdFM3qv39+j7WEyfEeJGzOgrbu9KpiUxWphUFs/xM1Fq5LicGs60q1sQf7ZIR5L29FVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012466; c=relaxed/simple;
	bh=uqUqwPy7xxBGqKDeN9sHyDh1l78ZazaJwZza2SPLuEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ihp/C/jDQX87TKId2x3O5OEh43YzRTHAN/4wKc4jkAw1KdQtxv7pxJUVL9zutLIu8zwTa/9IEMMc1MkHvP5neJuyRNI1XUEgGKl8v2aqDaTzh0OZ/by/uBl+AeIM048WxVM9fE2iFQpmnOs0iHKFXm5DOaJ1c3QEBsDFvzYPFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQaE0W3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56ABC4CECF;
	Tue, 15 Oct 2024 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012465;
	bh=uqUqwPy7xxBGqKDeN9sHyDh1l78ZazaJwZza2SPLuEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQaE0W3kRTEVyIpx7BeFlomBxl6T5vjyLzVJkZ7nc/AGbpdr1CKDjx1tdjXt7Cgxr
	 P1KQeqsf40lM6lSjbzcI19FGUKTr9sDgU3Q4ZnC6njR2jQSAoMicFa5zsia973iYuj
	 Nea7nBerqPechfaaYj1Zu20qgVhEN9+FOpRFH06DrcFnQhT8qJWTM6KFDhDh93Ex5O
	 R+ocv9VflW0iBIswEIDfY6D72TYFrihpiLkUf8p+AIYxbNLLcIC2/bYZ1AyY4uI0wb
	 UTWZYQK1dDVLG9MH+/jUBM5wZUueU7oRDnDT/o3pMoYePGY/pg7M2EDxfXSfBPeE1y
	 7UqxOy7MUKDyQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 05/11] wifi: ath12k: modify ath12k_mac_vif_chan() for MLO
Date: Tue, 15 Oct 2024 20:14:10 +0300
Message-Id: <20241015171416.518022-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

With MLO, multiple links can be affiliated to a vif (struct ieee80211_vif) and
hence ath12k_mac_vif_chan() needs to know the link id to fetch the channel
context among the links. Rename ath12k_mac_vif_chan() to
ath12k_mac_vif_link_chan() and introduce link id argument to fetch the channel
context from the link bss corresponding to the link id.

For non-MLO vif, link 0's (i.e. deflink) channel context will be returned.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 39 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 85d084d6fb34..a0869ed1cb57 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -476,18 +476,25 @@ static u8 ath12k_parse_mpdudensity(u8 mpdudensity)
 	}
 }
 
-static int ath12k_mac_vif_chan(struct ieee80211_vif *vif,
-			       struct cfg80211_chan_def *def)
+static int ath12k_mac_vif_link_chan(struct ieee80211_vif *vif, u8 link_id,
+				    struct cfg80211_chan_def *def)
 {
+	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_chanctx_conf *conf;
 
 	rcu_read_lock();
-	conf = rcu_dereference(vif->bss_conf.chanctx_conf);
+	link_conf = rcu_dereference(vif->link_conf[link_id]);
+
+	if (!link_conf) {
+		rcu_read_unlock();
+		return -ENOLINK;
+	}
+
+	conf = rcu_dereference(link_conf->chanctx_conf);
 	if (!conf) {
 		rcu_read_unlock();
 		return -ENOENT;
 	}
-
 	*def = conf->def;
 	rcu_read_unlock();
 
@@ -721,7 +728,7 @@ static u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_link_vif *arvif)
 	u8 pdev_id = ab->fw_pdev[0].pdev_id;
 	int i;
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return pdev_id;
 
 	band = def.chan->band;
@@ -1780,7 +1787,7 @@ static void ath12k_peer_assoc_h_crypto(struct ath12k *ar,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	bss = cfg80211_get_bss(hw->wiphy, def.chan, info->bssid, NULL, 0,
@@ -1846,7 +1853,7 @@ static void ath12k_peer_assoc_h_rates(struct ath12k *ar,
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	band = def.chan->band;
@@ -1908,7 +1915,7 @@ static void ath12k_peer_assoc_h_ht(struct ath12k *ar,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	if (!ht_cap->ht_supported)
@@ -2071,7 +2078,7 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	if (!vht_cap->vht_supported)
@@ -2320,7 +2327,7 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
 	enum nl80211_band band;
 	u8 ampdu_factor, mpdu_density;
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	band = def.chan->band;
@@ -2624,7 +2631,7 @@ static void ath12k_peer_assoc_h_phymode(struct ath12k *ar,
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	band = def.chan->band;
@@ -3369,7 +3376,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE &&
-	    !ath12k_mac_vif_chan(vif, &def)) {
+	    !ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)) {
 		band = def.chan->band;
 		mcast_rate = vif->bss_conf.mcast_rate[band];
 
@@ -3413,7 +3420,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 
 	if (changed & BSS_CHANGED_BASIC_RATES &&
-	    !ath12k_mac_vif_chan(vif, &def))
+	    !ath12k_mac_vif_link_chan(vif, arvif->link_id, &def))
 		ath12k_recalculate_mgmt_rate(ar, arvif, &def);
 
 	if (changed & BSS_CHANGED_TWT) {
@@ -4260,7 +4267,7 @@ static int ath12k_station_assoc(struct ath12k *ar,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return -EPERM;
 
 	band = def.chan->band;
@@ -4384,7 +4391,7 @@ static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *wk)
 	vif = ath12k_ahvif_to_vif(arvif->ahvif);
 	ar = arvif->ar;
 
-	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
+	if (WARN_ON(ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)))
 		return;
 
 	band = def.chan->band;
@@ -8348,7 +8355,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	arvif = &ahvif->deflink;
 
 	ar = arvif->ar;
-	if (ath12k_mac_vif_chan(vif, &def)) {
+	if (ath12k_mac_vif_link_chan(vif, arvif->link_id, &def)) {
 		ret = -EPERM;
 		goto out;
 	}
-- 
2.39.5


