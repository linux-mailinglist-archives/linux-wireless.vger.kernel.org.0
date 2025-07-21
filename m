Return-Path: <linux-wireless+bounces-25724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99523B0BC99
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8A2189B409
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154B283FDD;
	Mon, 21 Jul 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+Em0NFJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508212836BE
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079502; cv=none; b=hXsyhA6IkI8P+aTDA/3ra8qafL0G6r15bOrAxwwycjWhvP/ARq0KnYj0kw4uaM6U1/w7GHLhT7Vh7x2NfP2o4/VENid+K7XbPFxgJqjMvy8WwrZUnkqHWNNRw+lVz8lOSN79V+UPZKHdNUxrETpzSj/IXTTE+MyDkzhf6AygdRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079502; c=relaxed/simple;
	bh=yi9y4NWk9yGju6Wfze0ZNLJi7KTO7RQoc/KDdgmo+5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSH/EmNaZ4F8O4ce0TdCdC7XNc+JGxzZdgN7jwTaoiXg4qwYSWIFEoN0ZW5bkLgEaln4Az6YMyNFyWKOT6rlhZ6BgQOwpIU3QmR8Zfqg3T8/PRqCvBtfGBBGfHF2+Pm/rXKgHslkXT5zDMtVwoepJNy/xj5flbJIOGapNIPaJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+Em0NFJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753079500; x=1784615500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yi9y4NWk9yGju6Wfze0ZNLJi7KTO7RQoc/KDdgmo+5s=;
  b=A+Em0NFJvgFFwpcyEegGRFiba90o+Xcn1lK0jVDOxOf/3tHex2qQ+Kjq
   harrgb+GNT1zBcTMWfNpE5kob/Edsc3jYdKfpLMeezCphuQZKYoBN+Q5p
   8ZEMdnYqaj2huO2QtP1HVzQerDG4ilTCPez68BniNYrjIFsvPBBi5kDVJ
   iF5og4K7nY3/xMbkKOMictke1hhy6u/ftXEEuRdr+zsmf4hmVw8pmxNvC
   H71/8icSjPFpCOO/z5PBSXBMaSImfUXshuG55AWE05hgGKcgfi3CIaP6J
   vzefxc72qs8OdFClbjw7wg21pY3jTyBUuOG1u9V0iYUMGQHK7XB9/nL4+
   w==;
X-CSE-ConnectionGUID: +YashmoOS56FvcLQ1Ei/ug==
X-CSE-MsgGUID: X8eO+tB/SyuVXOu8SQFqmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65851389"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65851389"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:31:39 -0700
X-CSE-ConnectionGUID: 3LvvZsSKR8SeoU7TWi51/g==
X-CSE-MsgGUID: ImTYbWiNTFu2KiM+OTj2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158061186"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:31:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/1] wifi: mac80211: don't require cipher and keylen in gtk rekey
Date: Mon, 21 Jul 2025 09:31:14 +0300
Message-Id: <20250721092759.8ec6f99f9b70.Ie6594ae2b4b6d5b3d536e642b349046ebfce7a5d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721063114.82225-1-miriam.rachel.korenblit@intel.com>
References: <20250721063114.82225-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

ieee80211_add_gtk_rekey receives a keyconf as an argument, and the
cipher and keylen are taken from there to the new allocated key.
But in rekey, both the cipher and the keylen should be the same as of
the old key, so let ieee80211_add_gtk_rekey find those, so drivers won't
have to fill it in.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c |  7 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 11 +++++--
 drivers/net/wireless/realtek/rtw89/wow.c    |  7 ++--
 include/net/mac80211.h                      |  7 ++--
 net/mac80211/key.c                          | 36 +++++++++++++++++++--
 5 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 26255246a320..ed0a0f76f1c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -762,6 +762,7 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 		.conf.keyidx = key_data->id,
 	};
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+	u8 key[WOWLAN_KEY_MAX_SIZE];
 
 	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
 	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
@@ -803,7 +804,11 @@ iwl_mld_add_mcast_rekey(struct ieee80211_vif *vif,
 	}
 
 	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
-	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
+
+	memcpy(key, key_data->key, sizeof(key_data->key));
+
+	key_config = ieee80211_gtk_rekey_add(vif, key_data->id, key,
+					     sizeof(key), link_id);
 	if (IS_ERR(key_config))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index ef9bab042902..997cdd76b13c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1954,6 +1954,7 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
 			WOWLAN_KEY_MAX_SIZE);
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+	u8 key_data[WOWLAN_KEY_MAX_SIZE];
 
 	conf->cipher = gtk_cipher;
 
@@ -1988,8 +1989,10 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 				 conf->cipher, conf->keyidx);
 		memcpy(conf->key, status->gtk[i].key,
 		       sizeof(status->gtk[i].key));
+		memcpy(key_data, status->gtk[i].key, sizeof(status->gtk[i].key));
 
-		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
+		key = ieee80211_gtk_rekey_add(vif, status->gtk[i].id, key_data,
+					      sizeof(key_data), link_id);
 		if (IS_ERR(key)) {
 			/* FW may send also the old keys */
 			if (PTR_ERR(key) == -EALREADY)
@@ -2021,6 +2024,7 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	struct ieee80211_key_conf *key_config;
 	struct ieee80211_key_seq seq;
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+	u8 key[WOWLAN_KEY_MAX_SIZE];
 	s8 keyidx = key_data->id;
 
 	conf->cipher = cipher;
@@ -2050,7 +2054,10 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(key_data->key));
 	memcpy(conf->key, key_data->key, conf->keylen);
 
-	key_config = ieee80211_gtk_rekey_add(vif, conf, link_id);
+	memcpy(key, key_data->key, sizeof(key_data->key));
+
+	key_config = ieee80211_gtk_rekey_add(vif, keyidx, key, sizeof(key),
+					     link_id);
 	if (IS_ERR(key_config)) {
 		/* FW may send also the old keys */
 		return PTR_ERR(key_config) == -EALREADY;
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 071c7577df52..5bb7c1a42f1d 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -619,9 +619,12 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 	       flex_array_size(rekey_conf, key, cipher_info->len));
 
 	if (ieee80211_vif_is_mld(wow_vif))
-		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, rtwvif_link->link_id);
+		key = ieee80211_gtk_rekey_add(wow_vif, keyidx, gtk,
+					      cipher_info->len,
+					      rtwvif_link->link_id);
 	else
-		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, -1);
+		key = ieee80211_gtk_rekey_add(wow_vif, keyidx, gtk,
+					      cipher_info->len, -1);
 
 	kfree(rekey_conf);
 	if (IS_ERR(key)) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a0cf976a9117..ebcf550eebd7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6035,7 +6035,10 @@ void ieee80211_set_key_rx_seq(struct ieee80211_key_conf *keyconf,
 /**
  * ieee80211_gtk_rekey_add - add a GTK key from rekeying during WoWLAN
  * @vif: the virtual interface to add the key on
- * @keyconf: new key data
+ * @idx: the keyidx of the key
+ * @key: the key data
+ * @key_len: the key data. Might be bigger than the actual key length,
+ *	but not smaller (for the driver convinence)
  * @link_id: the link id of the key or -1 for non-MLO
  *
  * When GTK rekeying was done while the system was suspended, (a) new
@@ -6062,7 +6065,7 @@ void ieee80211_set_key_rx_seq(struct ieee80211_key_conf *keyconf,
  */
 struct ieee80211_key_conf *
 ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
-			struct ieee80211_key_conf *keyconf,
+			u8 idx, u8 *key_data, u8 key_len,
 			int link_id);
 
 /**
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 9d65013ddac7..b14e9cd9713f 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -1356,11 +1356,12 @@ EXPORT_SYMBOL_GPL(ieee80211_set_key_rx_seq);
 
 struct ieee80211_key_conf *
 ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
-			struct ieee80211_key_conf *keyconf,
+			u8 idx, u8 *key_data, u8 key_len,
 			int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_key *prev_key;
 	struct ieee80211_key *key;
 	int err;
 	struct ieee80211_link_data *link_data =
@@ -1376,8 +1377,37 @@ ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
 		return ERR_PTR(-EINVAL);
 
-	key = ieee80211_key_alloc(keyconf->cipher, keyconf->keyidx,
-				  keyconf->keylen, keyconf->key,
+	if (WARN_ON(idx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
+		    NUM_DEFAULT_BEACON_KEYS))
+		return ERR_PTR(-EINVAL);
+
+	prev_key = wiphy_dereference(local->hw.wiphy,
+				     link_data->gtk[idx]);
+	if (!prev_key) {
+		if (idx < NUM_DEFAULT_KEYS) {
+			for (int i = 0; i < NUM_DEFAULT_KEYS; i++) {
+				if (i == idx)
+					continue;
+				prev_key = wiphy_dereference(local->hw.wiphy,
+							     link_data->gtk[i]);
+				if (prev_key)
+					break;
+			}
+		} else {
+			/* For IGTK we have 4 and 5 and for BIGTK - 6 and 7 */
+			prev_key = wiphy_dereference(local->hw.wiphy,
+						     link_data->gtk[idx ^ 1]);
+		}
+	}
+
+	if (WARN_ON(!prev_key))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN_ON(key_len < prev_key->conf.keylen))
+		return ERR_PTR(-EINVAL);
+
+	key = ieee80211_key_alloc(prev_key->conf.cipher, idx,
+				  prev_key->conf.keylen, key_data,
 				  0, NULL);
 	if (IS_ERR(key))
 		return ERR_CAST(key);
-- 
2.34.1


