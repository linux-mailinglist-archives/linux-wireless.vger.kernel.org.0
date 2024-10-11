Return-Path: <linux-wireless+bounces-13897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CAA99AA65
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC691C23699
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134871BDA9F;
	Fri, 11 Oct 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl3n2Uty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35FE5228
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668007; cv=none; b=c4D4kN1AsSGE/7cr/ov8nBAKlTWqQ0w+eC8Adc/ANv3EVZFxrV4L0brUXyf0LSM9Bpex5QalLhiYR9woj9Vpe9OVDBzDK7oIgOsRI3d7SCL7EHnVzyOALwOubyC4THaIDeRLV1K5kL4dpcgcu6ZZHpYx5hYU2+t8HnuPkNBtq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668007; c=relaxed/simple;
	bh=VAU7YA/w68NZSQl51W4+MT+/LOFKh4WFwBtuFGI3a9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fw/BivmVnXYEsqFCG1ljJjUQ8ghDQSQkHFD+YMGQa+jeSMHBzgSGecxsQX2/lcLR3zy7FbbFevCEalVh9bk/culxRnZ1ky6VE24c4y8xeeY4k9tTahy8z5Ftq75JVTRMirWv13eoCWvbxvIWryvxe0ZEfy1aeuyRHwcL0DHrIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl3n2Uty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0511C4CEC3;
	Fri, 11 Oct 2024 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668006;
	bh=VAU7YA/w68NZSQl51W4+MT+/LOFKh4WFwBtuFGI3a9k=;
	h=From:To:Cc:Subject:Date:From;
	b=Dl3n2UtyEk/VO4b2mgwoQE/8GepO3hoTOXbPRrc3k6lP5AhK5D16W3Z3aQcYgwPBD
	 /7yFedoO+5X44XXI7/S9JbDkJemb+yHmyhjEpcoNvIHBMHlJy6SmIR/PYsod3cZUBI
	 NFjNVqfZO7unY8fqTBVRp/N9V2aJcc3WqaZOo3aaP9rkJVCPR68RuBkI0n3vk+UCEh
	 dp6OPLg6J/8BvHgZJf1QeE/yc/YB5dsN0x9P2FHG59SHRoYnemXn6cCS7Gt4t8N4g+
	 2TdK17p9Szh8Cd8GaREShTgbLBBjiXQJuQAi+0rXqs58+WhYTzK4He7TY23kGCgjHW
	 okTrT2hNZlMfA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: add missing lockdep_assert_wiphy() for ath12k_mac_op_ functions
Date: Fri, 11 Oct 2024 20:33:23 +0300
Message-Id: <20241011173323.924473-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Use lockdep_assert_wiphy() to document the ath12k_mac_op_ functions which are
called under wiphy_lock(). And make sure that the functions which already have
that is in the beginning of the function.

No functional changes.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 61 +++++++++++++++++----------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d4b438e4b7bf..d3c37b895b69 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1312,6 +1312,8 @@ static int ath12k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	struct ath12k *ar;
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_ah_to_ar(ah, 0);
 
 	ret = ath12k_mac_config(ar, changed);
@@ -3435,6 +3437,8 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k_vif_cache *cache;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_vif(hw, vif);
 
 	/* if the vdev is not created on a certain radio,
@@ -3449,8 +3453,6 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		return;
 	}
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	ath12k_mac_bss_info_changed(ar, arvif, info, changed);
 }
 
@@ -3809,13 +3811,13 @@ static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct ath12k *ar;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (!arvif->is_created)
 		return;
 
 	ar = arvif->ar;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	ath12k_scan_abort(ar);
 
 	cancel_delayed_work_sync(&ar->scan.timeout);
@@ -4569,14 +4571,14 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	int ret = 0;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
 		WARN_ON_ONCE(1);
 		return -EINVAL;
 	}
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
@@ -4691,6 +4693,8 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	int ret;
 	s16 txpwr;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (sta->deflink.txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
 		txpwr = 0;
 	} else {
@@ -4704,8 +4708,6 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	ret = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
 					WMI_PEER_USE_FIXED_PWR, txpwr);
 	if (ret) {
@@ -6030,6 +6032,8 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	struct ath12k *ar;
 	int ret, i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ath12k_drain_tx(ah);
 
 	guard(mutex)(&ah->hw_mutex);
@@ -6169,6 +6173,8 @@ static void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 	struct ath12k *ar;
 	int i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ath12k_drain_tx(ah);
 
 	mutex_lock(&ah->hw_mutex);
@@ -6391,6 +6397,8 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 {
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ath12k_mac_update_vif_offload(arvif);
 }
 
@@ -6935,10 +6943,10 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 
-	ar = ath12k_ah_to_ar(ah, 0);
-
 	lockdep_assert_wiphy(hw->wiphy);
 
+	ar = ath12k_ah_to_ar(ah, 0);
+
 	*total_flags &= SUPPORTED_FILTERS;
 	ath12k_mac_configure_filter(ar, *total_flags);
 }
@@ -7020,14 +7028,14 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret = -EINVAL;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar)
 		return -EINVAL;
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	ret = ath12k_mac_ampdu_action(arvif, params);
 	if (ret)
 		ath12k_warn(ar->ab, "pdev idx %d unable to perform ampdu action %d ret %d\n",
@@ -7042,6 +7050,8 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_ctx(hw, ctx);
 	if (!ar)
 		return -EINVAL;
@@ -7052,8 +7062,6 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx add freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	spin_lock_bh(&ar->data_lock);
 	/* TODO: In case of multiple channel context, populate rx_channel from
 	 * Rx PPDU desc information.
@@ -7070,6 +7078,8 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_ctx(hw, ctx);
 	if (!ar)
 		return;
@@ -7080,8 +7090,6 @@ static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx remove freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	spin_lock_bh(&ar->data_lock);
 	/* TODO: In case of there is one more channel context left, populate
 	 * rx_channel with the channel of that remaining channel context.
@@ -7524,14 +7532,14 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_ctx(hw, ctx);
 	if (!ar)
 		return;
 
 	ab = ar->ab;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx change freq %u width %d ptr %p changed %x\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx, changed);
@@ -7661,6 +7669,8 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	/* The vif is expected to be attached to an ar's VDEV.
 	 * We leave the vif/vdev in this function as is
 	 * and not delete the vdev symmetric to assign_vif_chanctx()
@@ -7674,8 +7684,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	ar = arvif->ar;
 	ab = ar->ab;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "mac chanctx unassign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
@@ -7713,12 +7721,12 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct ath12k *ar;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
 	if (!ar)
 		return -EINVAL;
 
-	lockdep_assert_wiphy(hw->wiphy);
-
 	/* Switching channels across radio is not allowed */
 	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx))
 		return -EINVAL;
@@ -7764,6 +7772,8 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	struct ath12k *ar;
 	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret = 0, i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	/* Currently we set the rts threshold value to all the vifs across
 	 * all radios of the single wiphy.
 	 * TODO Once support for vif specific RTS threshold in mac80211 is
@@ -7793,6 +7803,9 @@ static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	 * supported. This effectively prevents mac80211 from doing frame
 	 * fragmentation in software.
 	 */
+
+	lockdep_assert_wiphy(hw->wiphy);
+
 	return -EOPNOTSUPP;
 }
 
@@ -7837,6 +7850,8 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 	struct ath12k *ar;
 	int i;
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	if (drop)
 		return;
 
@@ -8364,6 +8379,8 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
 
+	lockdep_assert_wiphy(hw->wiphy);
+
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 

base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
-- 
2.39.5


