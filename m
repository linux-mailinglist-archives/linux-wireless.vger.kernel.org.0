Return-Path: <linux-wireless+bounces-15730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE99D9C2A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187742825EC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008931DDA18;
	Tue, 26 Nov 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8eEbBlP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3041DDA16
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641112; cv=none; b=aaHnMawLW1Qh0MCz/m/UbjMxicZhi5YehBd+MazGIodqfcCASt/lEao9VT6kTzdfHUdeU1o4aCe1fCSec6YOGDnDlnNC+PB9rTGbeWkbYkCxq0EUfPrHEcu8NeuEd7IsQHClAg1iPS26IVDoNF6XAIKVoEnpxvY8kXCIS309tMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641112; c=relaxed/simple;
	bh=5zCC/YdFWWxBJ7fJkYtfZKtr8YGh1fyzP8LdtP0IzJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQ4/ju4uuZS4tlmmhDPibuWfCy6feNYi0OxnCtybCdCfq0japuMFgLYagT2q5NdzZOnF74AfVUBuz9RL0QdULuFl13Hx1E4p7XUfuLxdAicXq4H/xteVaiwo1xCB2cyp+0Tt4h3cGa6T+oCX9/GSAo7pryftCC74NjuXbnOW3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8eEbBlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DA3C4CECF;
	Tue, 26 Nov 2024 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641112;
	bh=5zCC/YdFWWxBJ7fJkYtfZKtr8YGh1fyzP8LdtP0IzJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8eEbBlPRgzvFSk/Qhh3etKr9/vBUuABFpnoNN69EwNv6JCGDfgC8E3zuSNp2JwCm
	 GcXsOifmnFrSe7xdeW85pohfldfhG+dpA5vg1rK0XqfpWRBtmuO6Z8aG7mEv+fko5p
	 NAHjjDphnrWHh2gVe45nzXMS/3DxSdz5T6E17MJohgYeWVb2cEmm7vLcNWSWpBhN5p
	 hOI0oooMVdTgwpXsxJ2VNq0CV0BBcgBdE5bGqL9Jcam5pvtPp+B0KnfdhKJ3rSemlX
	 oEOP2Svdz2m0cZOe67UhvInYJn66ulciFHwE8zvq5/OFQoXKalRh1YZ9YU0HJoffWw
	 fkcU2f7aa2D0w==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 10/10] wifi: ath12k: ath12k_mac_op_sta_rc_update(): use mac80211 provided link id
Date: Tue, 26 Nov 2024 19:11:39 +0200
Message-Id: <20241126171139.2350704-11-kvalo@kernel.org>
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

From: Kalle Valo <quic_kvalo@quicinc.com>

There's a todo comment to use mac80211 provided link id. As mac80211 now
provides it use it in ath12k and remove the comment.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f6c3128a675a..164c974fb5f4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5696,10 +5696,10 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
-					struct ieee80211_vif *vif,
-					struct ieee80211_link_sta *link_sta,
-					u32 changed)
+static void ath12k_mac_op_link_sta_rc_update(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif,
+					     struct ieee80211_link_sta *link_sta,
+					     u32 changed)
 {
 	struct ieee80211_sta *sta = link_sta->sta;
 	struct ath12k *ar;
@@ -5710,27 +5710,23 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	struct ath12k_link_vif *arvif;
 	struct ath12k_peer *peer;
 	u32 bw, smps;
-	/* TODO: use proper link id once link sta specific rc update support is
-	 * available in mac80211.
-	 */
-	u8 link_id = ATH12K_DEFAULT_LINK_ID;
 
 	rcu_read_lock();
-	arvif = rcu_dereference(ahvif->link[link_id]);
+	arvif = rcu_dereference(ahvif->link[link_sta->link_id]);
 	if (!arvif) {
 		ath12k_hw_warn(ah, "mac sta rc update failed to fetch link vif on link id %u for peer %pM\n",
-			       link_id, sta->addr);
+			       link_sta->link_id, sta->addr);
 		rcu_read_unlock();
 		return;
 	}
 
 	ar = arvif->ar;
 
-	arsta = rcu_dereference(ahsta->link[link_id]);
+	arsta = rcu_dereference(ahsta->link[link_sta->link_id]);
 	if (!arsta) {
 		rcu_read_unlock();
 		ath12k_warn(ar->ab, "mac sta rc update failed to fetch link sta on link id %u for peer %pM\n",
-			    link_id, sta->addr);
+			    link_sta->link_id, sta->addr);
 		return;
 	}
 	spin_lock_bh(&ar->ab->base_lock);
@@ -10165,7 +10161,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.set_rekey_data	                = ath12k_mac_op_set_rekey_data,
 	.sta_state                      = ath12k_mac_op_sta_state,
 	.sta_set_txpwr			= ath12k_mac_op_sta_set_txpwr,
-	.link_sta_rc_update		= ath12k_mac_op_sta_rc_update,
+	.link_sta_rc_update		= ath12k_mac_op_link_sta_rc_update,
 	.conf_tx                        = ath12k_mac_op_conf_tx,
 	.set_antenna			= ath12k_mac_op_set_antenna,
 	.get_antenna			= ath12k_mac_op_get_antenna,
-- 
2.39.5


