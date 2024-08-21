Return-Path: <linux-wireless+bounces-11749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFF895A184
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E841C227E1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2D14AD38;
	Wed, 21 Aug 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUUTpGO3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64D13BAFA
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254653; cv=none; b=tFKY4Lr4EIaCj2gp4VqV0b+XYUiN7Ul1bYIpzYmtTk/dCeUIG/hNRSzmbA9/ZKEeXaU8tn0tpvq9GSgXm7pBUQ4Xu58X62IWAfHfRhvkt6eJNrwDi/Jnh6bk+/Nng2pkgOZFLDN8B3sDJAJ63e/OwqIeTRYYsLDKS1ZgvZ/ecKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254653; c=relaxed/simple;
	bh=ZW9dPyWMG1cmVlTQ++lm7oUNqXWUy6HqWXeKCAZrp0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Er9z/rgK9H9NL6Al38inMRdFgPEDqjlXxCUN3DdvY/IB5wvU+pTYzGkmP2JdnhdAyN5BPy2AKPpFRXXU2gaYwMKIh0sY7tDThXOjsXb1eO1bIjzXMjaQwITQ8eXLSEKQdGfBT/sCQaRP3PWPrSDTCQ04kobN4eHkrUD2/jSuuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUUTpGO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B83C4AF09;
	Wed, 21 Aug 2024 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724254653;
	bh=ZW9dPyWMG1cmVlTQ++lm7oUNqXWUy6HqWXeKCAZrp0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUUTpGO31evVjp35X9JL282GG4TqEke9eMy8jbyMtK/SEneg1jiN8UOpXIsoNFyO1
	 x4voocrGIbt+8aQPvYoYJHXCKjm4NXUnQxzHemP43J3Kt8Ikv1hOOwbCRAksqGAOM/
	 C/jiqGNM7sJh+jckMp+GBd/4uvEUt1ItQ8rdpLLnqwIzoGPk/FzKb3S/jgwQnnJZID
	 19DWKT74n1fP5AosIwjxFwF2FO3i+s5zYKL9Uwh0q7+SzgPmLhVEdGUO9FDw48tO/w
	 B1TENO0U/0Z0M1dS5ndCezhHR2GN5SS1iJRo8PSOUJT2qwRxvGazkR7YdFbieCqxLy
	 FpUuytUwEj95Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC 2/4] wifi: ath12k: cleanup unneeded labels
Date: Wed, 21 Aug 2024 18:37:26 +0300
Message-Id: <20240821153728.2121600-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821153728.2121600-1-kvalo@kernel.org>
References: <20240821153728.2121600-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

After removing the conf_mutex in the previous patch there are no unnecessary
labels in mac.c. Sparse also warns one instance of it:

drivers/net/wireless/ath/ath12k/mac.c:6635:1: warning: statement expected after label

Remove the labels and instead use directly return.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 61 ++++++++++-----------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7bb181092ead..a9d37a59a8c2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1279,24 +1279,23 @@ static int ath12k_mac_config(struct ath12k *ar, u32 changed)
 		ar->monitor_conf_enabled = conf->flags & IEEE80211_CONF_MONITOR;
 		if (ar->monitor_conf_enabled) {
 			if (ar->monitor_vdev_created)
-				goto exit;
+				return ret;
 			ret = ath12k_mac_monitor_vdev_create(ar);
 			if (ret)
-				goto exit;
+				return ret;
 			ret = ath12k_mac_monitor_start(ar);
 			if (ret)
 				goto err_mon_del;
 		} else {
 			if (!ar->monitor_vdev_created)
-				goto exit;
+				return ret;
 			ret = ath12k_mac_monitor_stop(ar);
 			if (ret)
-				goto exit;
+				return ret;
 			ath12k_mac_monitor_vdev_delete(ar);
 		}
 	}
 
-exit:
 	return ret;
 
 err_mon_del:
@@ -4716,10 +4715,9 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set tx power for station ret: %d\n",
 			    ret);
-		goto out;
+		return ret;
 	}
 
-out:
 	return ret;
 }
 
@@ -6472,7 +6470,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	if (ret) {
 		ath12k_warn(ab, "failed to create WMI vdev %d: %d\n",
 			    arvif->vdev_id, ret);
-		goto err;
+		return ret;
 	}
 
 	ar->num_created_vdevs++;
@@ -6589,13 +6587,13 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
 				    arvif->vdev_id, vif->addr);
-			goto err;
+			return ret;
 		}
 
 		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
 						       vif->addr);
 		if (ret)
-			goto err;
+			return ret;
 
 		ar->num_peers--;
 	}
@@ -7547,7 +7545,7 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	 * switch_vif_chanctx().
 	 */
 	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
-		goto unlock;
+		return;
 
 	if (changed & IEEE80211_CHANCTX_CHANGE_WIDTH ||
 	    changed & IEEE80211_CHANCTX_CHANGE_RADAR ||
@@ -7555,8 +7553,6 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 		ath12k_mac_update_active_vif_chan(ar, ctx);
 
 	/* TODO: Recalc radar detection */
-
-unlock:
 }
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
@@ -7629,21 +7625,18 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    !ath12k_peer_exist_by_vdev_id(ab, arvif->vdev_id)) {
 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
-	if (WARN_ON(arvif->is_started)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (WARN_ON(arvif->is_started))
+		return -EBUSY;
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_start(ar);
 		if (ret)
-			goto out;
+			return ret;
 		arvif->is_started = true;
-		goto out;
+		return ret;
 	}
 
 	ret = ath12k_mac_vdev_start(arvif, ctx);
@@ -7651,7 +7644,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
 			    ctx->def.chan->center_freq, ret);
-		goto out;
+		return ret;
 	}
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
@@ -7661,7 +7654,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	/* TODO: Setup ps and cts/rts protection */
 
-out:
 	return ret;
 }
 
@@ -8129,10 +8121,8 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	ldpc = !!(ar->ht_cap_info & WMI_HT_CAP_LDPC);
 
 	sgi = mask->control[band].gi;
-	if (sgi == NL80211_TXRATE_FORCE_LGI) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (sgi == NL80211_TXRATE_FORCE_LGI)
+		return -EINVAL;
 
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing at least one of used basic rates along with them.
@@ -8148,7 +8138,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to get single legacy rate for vdev %i: %d\n",
 				    arvif->vdev_id, ret);
-			goto out;
+			return ret;
 		}
 		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_disable_peer_fixed_rate,
@@ -8193,8 +8183,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			 */
 			ath12k_warn(ar->ab,
 				    "Setting more than one MCS Value in bitrate mask not supported\n");
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		ieee80211_iterate_stations_atomic(hw,
@@ -8213,7 +8202,6 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 	}
 
-out:
 	return ret;
 }
 
@@ -8373,7 +8361,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 	if (ar->rx_channel == survey->channel)
 		survey->filled |= SURVEY_INFO_IN_USE;
 
-exit:
 	return 0;
 }
 
@@ -8525,7 +8512,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	if (ret)
-		goto exit;
+		return ret;
 
 	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
 
@@ -8534,10 +8521,8 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	arg.num_chan = 1;
 	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
 				GFP_KERNEL);
-	if (!arg.chan_list) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!arg.chan_list)
+		return -ENOMEM;
 
 	arg.vdev_id = arvif->vdev_id;
 	arg.scan_id = ATH12K_SCAN_ID;
@@ -8575,7 +8560,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 free_chan_list:
 	kfree(arg.chan_list);
-exit:
+
 	return ret;
 }
 
-- 
2.39.2


