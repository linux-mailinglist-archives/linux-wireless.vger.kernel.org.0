Return-Path: <linux-wireless+bounces-13972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0B99F3C4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DAA283392
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CC1FAEF6;
	Tue, 15 Oct 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK2am1xp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE991FAEF4
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012464; cv=none; b=gFxPSfRJpp4skB8GjC61nY5hKaKbX9qwdJuHbJyhyjpqN+o+TSMi8JjQvyJSJxCpIMzj5T2vk383JArxBPQqWQwQq2doaXkkFlQ5iZfWQdYyLIaR5rJZh93ChQqoNY4VbNhPHJVm9tk3GhGKp53RqeA398wUM+2Xppz9YESio9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012464; c=relaxed/simple;
	bh=oYdIozVcWnqTHGSGUu7NoEC6/sPKe7T+fQiidBr+j+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYDwZzGM8bxq0Z7vYebQU4KBl2isXfy6El23uDjdKXAVuzpbMCipX6mRKItWnzZ6i8QGT32uafsl8cvJaQx30G6wnWStpONEwh6uprj9lFbP0KW+DcPTSRFmkeb5DOvnktXgQ3I1pEX+isxuTBJtm0y1vTWmyGL0vCrOXV7ZIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK2am1xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CE6C4CED3;
	Tue, 15 Oct 2024 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012464;
	bh=oYdIozVcWnqTHGSGUu7NoEC6/sPKe7T+fQiidBr+j+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tK2am1xpiAxEHIrHeCBpvXyn8vaUdWz/209xgIzsDvKoer1FNc0DPBom3WL7A1Ima
	 RzXt0kvRZAVqKCLl8jQyHoyJmYSoznR29LHSUFBTPpfFolYMVmV5O3Z7MMQJ7Nj9fR
	 r99ZnmtrpsdCqvQ1+0YkIvYBLTzBWwHRE+3P19uANSTj/wvkaBQjWnlFXnvPGWFY5W
	 4L65YCfECyRLqyRUVvFKe2APLz8UiMuusnXc9w92+YAZO4tHBTv2HSQsZRbmHGqsX+
	 B7hj9MYPiVNyON0WWBJaimfr3qIEWmceKtkGfDnF+FG8GOgwlmcKtZr8BCh5//00/w
	 xOWiPHVt9p1EA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/11] wifi: ath12k: prepare vif config caching for MLO
Date: Tue, 15 Oct 2024 20:14:09 +0300
Message-Id: <20241015171416.518022-5-kvalo@kernel.org>
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

Currently vif configuration cache pointers are placed in arvif and caching is
done whenever a link vif configuration is received before driver created vdev
for it (i.e. before channel is assigned), this is possible because current code
only uses default link (ahvif->deflink) which is preallocated.

With MLO changes the ieee80211_vif drv priv is now ahvif and its arvifs (struct
ath12k_link_vif) other than deflink can be allocated dynamically during channel
assignment.  Hence maintain link level cache in ahvif and whenever channel is
assigned for link vif and vdev is created, flush the corresponding link vif
cache from ahvif.

Current code uses cache of ATH12K_DEFAULT_LINK_ID (0) which is the cache of
ahvif->deflink.

Co-developed-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 40 ++++++++++++++------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8f956327f07f..96d12ef94e9c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -272,7 +272,6 @@ struct ath12k_link_vif {
 	u32 punct_bitmap;
 	u8 link_id;
 	struct ath12k_vif *ahvif;
-	struct ath12k_vif_cache *cache;
 	struct ath12k_rekey_data rekey_data;
 };
 
@@ -306,6 +305,7 @@ struct ath12k_vif {
 
 	struct ath12k_link_vif deflink;
 	struct ath12k_link_vif __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct ath12k_vif_cache *cache[IEEE80211_MLD_MAX_NUM_LINKS];
 	/* indicates bitmap of link vif created in FW */
 	u16 links_map;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d888169d57dc..85d084d6fb34 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3464,18 +3464,19 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 	}
 }
 
-static struct ath12k_vif_cache *ath12k_arvif_get_cache(struct ath12k_link_vif *arvif)
+static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,
+							    u8 link_id)
 {
-	if (!arvif->cache)
-		arvif->cache = kzalloc(sizeof(*arvif->cache), GFP_KERNEL);
+	if (!ahvif->cache[link_id])
+		ahvif->cache[link_id] = kzalloc(sizeof(*ahvif->cache[0]), GFP_KERNEL);
 
-	return arvif->cache;
+	return ahvif->cache[link_id];
 }
 
-static void ath12k_arvif_put_cache(struct ath12k_link_vif *arvif)
+static void ath12k_ahvif_put_link_cache(struct ath12k_vif *ahvif, u8 link_id)
 {
-	kfree(arvif->cache);
-	arvif->cache = NULL;
+	kfree(ahvif->cache[link_id]);
+	ahvif->cache[link_id] = NULL;
 }
 
 static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
@@ -3502,14 +3503,13 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (!ar) {
 		/* TODO Once link vif is fetched based on link id from
-		 * info, avoid using the deflink above and cache the link
-		 * configs in ahvif per link.
+		 * info, avoid using ATH12K_DEFAULT_LINK_ID.
 		 */
-		cache = ath12k_arvif_get_cache(arvif);
+		cache = ath12k_ahvif_get_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
 		if (!cache)
 			return;
 
-		arvif->cache->bss_conf_changed |= changed;
+		cache->bss_conf_changed |= changed;
 
 		return;
 	}
@@ -4157,7 +4157,7 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			return -EINVAL;
 		}
 
-		cache = ath12k_arvif_get_cache(arvif);
+		cache = ath12k_ahvif_get_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
 		if (!cache)
 			return -ENOSPC;
 
@@ -5074,7 +5074,7 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
 		/* cache the info and apply after vdev is created */
-		cache = ath12k_arvif_get_cache(arvif);
+		cache = ath12k_ahvif_get_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
 		if (!cache)
 			return -ENOSPC;
 
@@ -6790,10 +6790,11 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	return ret;
 }
 
-static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ath12k_link_vif *arvif)
+static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
-	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(arvif->ahvif);
-	struct ath12k_vif_cache *cache = arvif->cache;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
+	struct ath12k_vif_cache *cache = ahvif->cache[arvif->link_id];
 	struct ath12k_base *ab = ar->ab;
 
 	int ret;
@@ -6824,7 +6825,7 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar,  struct ath12k_link_vi
 			ath12k_warn(ab, "unable to apply set key param to vdev %d ret %d\n",
 				    arvif->vdev_id, ret);
 	}
-	ath12k_arvif_put_cache(arvif);
+	ath12k_ahvif_put_link_cache(ahvif, arvif->link_id);
 }
 
 static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
@@ -7028,7 +7029,7 @@ static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ath12k_link_vif *arv
 	spin_unlock_bh(&ar->data_lock);
 
 	ath12k_peer_cleanup(ar, arvif->vdev_id);
-	ath12k_arvif_put_cache(arvif);
+	ath12k_ahvif_put_link_cache(ahvif, arvif->link_id);
 
 	idr_for_each(&ar->txmgmt_idr,
 		     ath12k_mac_vif_txmgmt_idr_remove, vif);
@@ -7069,7 +7070,8 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 		/* if we cached some config but never received assign chanctx,
 		 * free the allocated cache.
 		 */
-		ath12k_arvif_put_cache(arvif);
+		ath12k_ahvif_put_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
+
 		return;
 	}
 
-- 
2.39.5


