Return-Path: <linux-wireless+bounces-13975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32A99F3C8
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33F7B22CC4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A921FAEFD;
	Tue, 15 Oct 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz17dalN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC671FAF0F
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012468; cv=none; b=j+5xepX7FT2XcfttbBgyfo6obJx8IbB0atOQ0mjnEcQSsLFhyP08IeNxoqyTuBpJFjRi5qTqk6Hh1VEQEXBeWNwZYhKI0Uw0uOmicKmp36IAgPULklWpXMLNsfK6alcBifET9m6bzb9IXItY+KSwrJn4pkJ6UkB9UBpYXfDl+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012468; c=relaxed/simple;
	bh=dbbhMSytICfFieTOurg2w+38kelEUYxKPVBIapoUibE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CS54Szc48I/54rvSx6e/xhsfYYQ/020B0pH5hBPFsWnhDFm+j6c4EqT+v6JuJZ+gFuAIRJGlZnRfiJBFdOGiQkS3Vifred8alx3RZU92GvH85861NU6MyxVn/H0RtNhn2fW2iVP9WQ+SeVnsJ+yUDsezpT6eBK+b/dA7lcYjN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz17dalN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C374FC4CECF;
	Tue, 15 Oct 2024 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012468;
	bh=dbbhMSytICfFieTOurg2w+38kelEUYxKPVBIapoUibE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kz17dalNULnwskQ9cMsqf2BbocWL7v0Y1dH5FE3bHi2IfNmjntT/XK+rswqqnsmGf
	 pqXZgoPdyvcyszSPMQE6MDF0zF9DI0K8QybiZCv9/U2TWX+sxNZoOgQLvypA373aF6
	 D1h7eG4Isn3DP3BgkY/fvxX5vrwrlks9wT44P4h7hQ7iZ7K+LUPBtlDQ3vMin+7Q4P
	 9nxgADYVyKGG5+gUl6w7BESXrbBbPdn7n2fdIY4tw+ZkkdlSCQe9cvHli+UELUcZqm
	 wvbfe/R21doyaVapj1OTkNLGL2Pi2SvomPmr7SksaKBXozAjBrMYpqcZKzU8wN5Hy5
	 QgQ1GQsi5fNrQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 08/11] wifi: ath12k: modify ath12k_mac_op_set_key() for MLO
Date: Tue, 15 Oct 2024 20:14:13 +0300
Message-Id: <20241015171416.518022-9-kvalo@kernel.org>
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

Currently ath12k_mac_op_set_key() uses ahvif's deflink to set/cache keys
depending upon the availability of corresponding vdev. But with MLO the
incoming vif could have multiple links affiliated to it, hence use the link id
provided in the key info argument and apply/cache the key to the corresponding
link arvif. When the set key is a pairwise key intended for an ML station then
set the same key on all the affiliated link stations.

Also there could be multiple keys associates to a single link: group keys,
mgmt/beacon protection keys and so on. Current key caching design lacks support
for caching multiple keys for a given link cache. Add support to store a list
of all link keys in the ahvifs link cache as well as update, flush and free the
same whenever required.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 179 ++++++++++++++++++++-----
 2 files changed, 144 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 96d12ef94e9c..1f5252b95858 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -220,8 +220,9 @@ struct ath12k_tx_conf {
 };
 
 struct ath12k_key_conf {
-	bool changed;
 	enum set_key_cmd cmd;
+	struct list_head list;
+	struct ieee80211_sta *sta;
 	struct ieee80211_key_conf *key;
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c8a330eb0d4b..7185cffe7dd4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3519,14 +3519,30 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 static struct ath12k_vif_cache *ath12k_ahvif_get_link_cache(struct ath12k_vif *ahvif,
 							    u8 link_id)
 {
-	if (!ahvif->cache[link_id])
+	if (!ahvif->cache[link_id]) {
 		ahvif->cache[link_id] = kzalloc(sizeof(*ahvif->cache[0]), GFP_KERNEL);
+		if (ahvif->cache[link_id])
+			INIT_LIST_HEAD(&ahvif->cache[link_id]->key_conf.list);
+	}
 
 	return ahvif->cache[link_id];
 }
 
+static void ath12k_ahvif_put_link_key_cache(struct ath12k_vif_cache *cache)
+{
+	struct ath12k_key_conf *key_conf, *tmp;
+
+	if (!cache || list_empty(&cache->key_conf.list))
+		return;
+	list_for_each_entry_safe(key_conf, tmp, &cache->key_conf.list, list) {
+		list_del(&key_conf->list);
+		kfree(key_conf);
+	}
+}
+
 static void ath12k_ahvif_put_link_cache(struct ath12k_vif *ahvif, u8 link_id)
 {
+	ath12k_ahvif_put_link_key_cache(ahvif->cache[link_id]);
 	kfree(ahvif->cache[link_id]);
 	ahvif->cache[link_id] = NULL;
 }
@@ -4170,6 +4186,39 @@ static int ath12k_mac_set_key(struct ath12k *ar, enum set_key_cmd cmd,
 	return 0;
 }
 
+static int ath12k_mac_update_key_cache(struct ath12k_vif_cache *cache,
+				       enum set_key_cmd cmd,
+				       struct ieee80211_sta *sta,
+				       struct ieee80211_key_conf *key)
+{
+	struct ath12k_key_conf *key_conf = NULL, *tmp;
+
+	if (cmd == SET_KEY) {
+		key_conf = kzalloc(sizeof(*key_conf), GFP_KERNEL);
+
+		if (!key_conf)
+			return -ENOMEM;
+
+		key_conf->cmd = cmd;
+		key_conf->sta = sta;
+		key_conf->key = key;
+		list_add_tail(&key_conf->list,
+			      &cache->key_conf.list);
+	}
+	if (list_empty(&cache->key_conf.list))
+		return 0;
+	list_for_each_entry_safe(key_conf, tmp, &cache->key_conf.list, list) {
+		if (key_conf->key == key) {
+			/* DEL key for an old SET key which driver hasn't flushed yet.
+			 */
+			list_del(&key_conf->list);
+			kfree(key_conf);
+			break;
+		}
+	}
+	return 0;
+}
+
 static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				 struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key)
@@ -4179,13 +4228,12 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct ath12k_link_sta *arsta = NULL;
 	struct ath12k_vif_cache *cache;
 	struct ath12k_sta *ahsta;
-	struct ath12k *ar;
+	unsigned long links;
+	u8 link_id;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	arvif = &ahvif->deflink;
-
 	/* BIP needs to be done in software */
 	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
 	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
@@ -4197,36 +4245,63 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (key->keyidx > WMI_MAX_KEY_INDEX)
 		return -ENOSPC;
 
-	ar = ath12k_get_ar_by_vif(hw, vif);
-	if (!ar) {
-		/* ar is expected to be valid when sta ptr is available */
-		if (sta) {
-			WARN_ON_ONCE(1);
-			return -EINVAL;
-		}
-
-		cache = ath12k_ahvif_get_link_cache(ahvif, ATH12K_DEFAULT_LINK_ID);
-		if (!cache)
-			return -ENOSPC;
-
-		cache->key_conf.cmd = cmd;
-		cache->key_conf.key = key;
-		cache->key_conf.changed = true;
-
-		return 0;
-	}
-
 	if (sta) {
 		ahsta = ath12k_sta_to_ahsta(sta);
-		arsta = &ahsta->deflink;
+		/* For an ML STA Pairwise key is same for all associated link Stations,
+		 * hence do set key for all link STAs which are active.
+		 */
+		if (sta->mlo) {
+			links = ahsta->links_map;
+			for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+				arvif = wiphy_dereference(hw->wiphy,
+							  ahvif->link[link_id]);
+				arsta = wiphy_dereference(hw->wiphy,
+							  ahsta->link[link_id]);
+
+				if (WARN_ON(!arvif || !arsta))
+					/* arvif and arsta are expected to be valid when
+					 * STA is present.
+					 */
+					continue;
+
+				ret = ath12k_mac_set_key(arvif->ar, cmd, arvif,
+							 arsta, key);
+				if (ret)
+					break;
+			}
+		} else {
+			arsta = &ahsta->deflink;
+			arvif = arsta->arvif;
+			if (WARN_ON(!arvif)) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, arsta, key);
+		}
+	} else {
+		if (key->link_id >= 0 && key->link_id < IEEE80211_MLD_MAX_NUM_LINKS) {
+			link_id = key->link_id;
+			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		} else {
+			link_id = 0;
+			arvif = &ahvif->deflink;
+		}
+
+		if (!arvif || !arvif->is_created) {
+			cache = ath12k_ahvif_get_link_cache(ahvif, link_id);
+			if (!cache)
+				return -ENOSPC;
+
+			ret = ath12k_mac_update_key_cache(cache, cmd, sta, key);
+
+			return ret;
+		}
+
+		ret = ath12k_mac_set_key(arvif->ar, cmd, arvif, NULL, key);
 	}
 
-	/* Note: Currently only deflink of ahvif and ahsta are used here,
-	 * once MLO support is added the allocated links (i.e ahvif->links[])
-	 * should be use based on link id passed from mac80211 and such link
-	 * access needs to be protected with ah->conf_mutex.
-	 */
-	ret = ath12k_mac_set_key(ar, cmd, arvif, arsta, key);
+out:
 
 	return ret;
 }
@@ -6838,6 +6913,40 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 	return ret;
 }
 
+static void ath12k_mac_vif_flush_key_cache(struct ath12k_link_vif *arvif)
+{
+	struct ath12k_key_conf *key_conf, *tmp;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_hw *ah = ahvif->ah;
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_vif_cache *cache = ahvif->cache[arvif->link_id];
+	int ret;
+
+	lockdep_assert_wiphy(ah->hw->wiphy);
+
+	list_for_each_entry_safe(key_conf, tmp, &cache->key_conf.list, list) {
+		arsta = NULL;
+		if (key_conf->sta) {
+			ahsta = ath12k_sta_to_ahsta(key_conf->sta);
+			arsta = wiphy_dereference(ah->hw->wiphy,
+						  ahsta->link[arvif->link_id]);
+			if (!arsta)
+				goto free_cache;
+		}
+
+		ret = ath12k_mac_set_key(arvif->ar, key_conf->cmd,
+					 arvif, arsta,
+					 key_conf->key);
+		if (ret)
+			ath12k_warn(arvif->ar->ab, "unable to apply set key param to vdev %d ret %d\n",
+				    arvif->vdev_id, ret);
+free_cache:
+		list_del(&key_conf->list);
+		kfree(key_conf);
+	}
+}
+
 static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ath12k_link_vif *arvif)
 {
 	struct ath12k_vif *ahvif = arvif->ahvif;
@@ -6866,13 +6975,9 @@ static void ath12k_mac_vif_cache_flush(struct ath12k *ar, struct ath12k_link_vif
 					    cache->bss_conf_changed);
 	}
 
-	if (cache->key_conf.changed) {
-		ret = ath12k_mac_set_key(ar, cache->key_conf.cmd, arvif, NULL,
-					 cache->key_conf.key);
-		if (ret)
-			ath12k_warn(ab, "unable to apply set key param to vdev %d ret %d\n",
-				    arvif->vdev_id, ret);
-	}
+	if (!list_empty(&cache->key_conf.list))
+		ath12k_mac_vif_flush_key_cache(arvif);
+
 	ath12k_ahvif_put_link_cache(ahvif, arvif->link_id);
 }
 
-- 
2.39.5


