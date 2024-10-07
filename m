Return-Path: <linux-wireless+bounces-13616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFDD993446
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D894281608
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706911DCB24;
	Mon,  7 Oct 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RanM/Va0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB591DCB27
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320379; cv=none; b=AbGiZzr4FIGMqq69ZDZCqR4hltUwhANLoI258gk7caFaf+qpsOKefP6EnrE0hpaK/k4dDPr9NP5UMHEWsOtqzyerJUI7WAP7j7DqtGJejLvnNfYJ82x5tjRQLybokV/rgaN4WnojnRMpJpZKNG0MrdT/5CIpRasj/8wNassp0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320379; c=relaxed/simple;
	bh=EIdf9CULXaGGLNYPAeSY+A7yi4BPc7G21mEe+F9XkD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/UNKowNuXwgHqBJPv1Stne3655kVyTPI6fhcSBo5VVFtppYjp1JHFDtRDXYzmu/WjxzWWOiyoxG7rPLJzGeBFV+tzDSCK4oQ4VM08BvQkw894LbTaBW5gEJYKiXzMRoRBnph+3aqnjmivJrPVRCoZyVH6gaPE1Dk72x55yZ1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RanM/Va0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEE4C4CEC7;
	Mon,  7 Oct 2024 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320379;
	bh=EIdf9CULXaGGLNYPAeSY+A7yi4BPc7G21mEe+F9XkD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RanM/Va0R5ex2LZbrKZfKJMVjhef7D470P/x7U9IpNe9pbXWJ/FMghyexHcTxQTTf
	 X/JWaLgSgAC4rHE7PpdHz6L9mUA8Xwg9Mx0IdHvRHtGFrcEViaYOdftVd+Z1PsVdas
	 Va5i8dTnSnHepq7mDVCRYuzRaAKpQbqSSEsffM+ULfaxe7Gs6UgfjxW8jzOcuMhV8K
	 x8ImCMb71BXz784V2xCC6pGr/KkU0+jH4wNovfgIXIcxENu0sTtqpBx8JnaFOwJID6
	 KTi2MrFaPFZKnbdTjwXzH2soBlJWk8iRXHjauBgXDYrbLoOdgMT2kyNNuNwjAATszy
	 2B8buObRtqZuw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 4/6] wifi: ath12k: cleanup unneeded labels
Date: Mon,  7 Oct 2024 19:59:30 +0300
Message-Id: <20241007165932.78081-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007165932.78081-1-kvalo@kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

After removing the conf_mutex in the previous patch there are now unnecessary
labels in mac.c. Remove those and instead use directly return.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 56 +++++++++++----------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 98894b4bf7e8..1d1e91b124ca 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1282,24 +1282,23 @@ static int ath12k_mac_config(struct ath12k *ar, u32 changed)
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
@@ -4717,10 +4716,9 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
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
@@ -7625,21 +7623,18 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
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
@@ -7647,7 +7642,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
 			    arvif->vdev_id, vif->addr,
 			    ctx->def.chan->center_freq, ret);
-		goto out;
+		return ret;
 	}
 
 	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
@@ -7657,7 +7652,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	/* TODO: Setup ps and cts/rts protection */
 
-out:
 	return ret;
 }
 
@@ -8125,10 +8119,8 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
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
@@ -8144,7 +8136,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to get single legacy rate for vdev %i: %d\n",
 				    arvif->vdev_id, ret);
-			goto out;
+			return ret;
 		}
 		ieee80211_iterate_stations_mtx(hw,
 					       ath12k_mac_disable_peer_fixed_rate,
@@ -8189,8 +8181,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			 */
 			ath12k_warn(ar->ab,
 				    "Setting more than one MCS Value in bitrate mask not supported\n");
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		ieee80211_iterate_stations_mtx(hw,
@@ -8209,7 +8200,6 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 	}
 
-out:
 	return ret;
 }
 
@@ -8520,7 +8510,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	spin_unlock_bh(&ar->data_lock);
 
 	if (ret)
-		goto exit;
+		return ret;
 
 	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
 
@@ -8529,10 +8519,8 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
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
@@ -8570,7 +8558,7 @@ static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 free_chan_list:
 	kfree(arg.chan_list);
-exit:
+
 	return ret;
 }
 
-- 
2.39.5


