Return-Path: <linux-wireless+bounces-13110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E618A98421D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7040EB291F0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42F158DD4;
	Tue, 24 Sep 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0i0rKTH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779715CD52
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169922; cv=none; b=QI+8XN9FhVfGK0NK038HgVzrS35gh8AGiShhjuvoTeR5mdOnI8L1IMKuj2NHAllHbqDJhZDUQFpo7L83NBILF5OV4vlycw82Vu/05ktRBDdFLikDWJepkabxiVhGtI4dMiFtqscjP2Dtg+Q3jsazbzmEk9FrIaKF+u7H6Z4RKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169922; c=relaxed/simple;
	bh=dlIhVrzY9Yuau9rbq4b336G8u4Sr6LjE43vNW1Ohbg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzxJvde7ugil6p/pse4kJiaepYgZAbBocigGGBYjUB6jsrA07altqp7Kpq1bE29zUmB3PHCsTvAPGrBI0NrijeSTAwQTMG79P6IhqY/u+3eUzDdWJ0GftZgbVrAEe3JAg7h5u9al1agkKrer5Pz7ythOMkwlUkz+RJBBYFTtiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0i0rKTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1EC4CEC5;
	Tue, 24 Sep 2024 09:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169922;
	bh=dlIhVrzY9Yuau9rbq4b336G8u4Sr6LjE43vNW1Ohbg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0i0rKTH+AOB9hH0WMvxeAQKuL89UhtGbjKFtH6R4YEjc0XUQ8jbbm7daFnlOVAzd
	 0ap2cCOSwCFFwDcwn39SHjddvIWiIecoQs7FeF9wxXFbBfBS2iM5INz/eUzPtU0TWi
	 g3/3tVMN2ggrODbQoSSwoB38+Rw3gv9pVfYqjDOOGQipbYw0nXomcDtgToSas0MHFj
	 S6P2u9KjF5Ty56u3Pmn9lW1OqgvuTDIdlc9GRDY5RGso00Kxp9v/wYzMw1AsMjm5qJ
	 oCbid3pCh+16otqJR9tS8qlh0LIsYD9md1EwhEbWnD1rB9v2k/iuVlFCzBq6S8tt/4
	 +Af8/FnFmODHA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v3 4/6] wifi: ath12k: cleanup unneeded labels
Date: Tue, 24 Sep 2024 12:25:13 +0300
Message-Id: <20240924092515.1049885-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924092515.1049885-1-kvalo@kernel.org>
References: <20240924092515.1049885-1-kvalo@kernel.org>
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
index 5d27e43929d8..47e8354bb436 100644
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
@@ -4714,10 +4713,9 @@ static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set tx power for station ret: %d\n",
 			    ret);
-		goto out;
+		return ret;
 	}
 
-out:
 	return ret;
 }
 
@@ -6470,7 +6468,7 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
 	if (ret) {
 		ath12k_warn(ab, "failed to create WMI vdev %d: %d\n",
 			    arvif->vdev_id, ret);
-		goto err;
+		return ret;
 	}
 
 	ar->num_created_vdevs++;
@@ -6587,13 +6585,13 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
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


