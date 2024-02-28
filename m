Return-Path: <linux-wireless+bounces-4141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1C86AA56
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E0A1F2252D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EA2D03C;
	Wed, 28 Feb 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="H47lKwjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EA2BD0F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109915; cv=none; b=FqBGP2PVEGbc7CvcrPd9aGcT5oiaaT35rscRXAnrZTVSsVh9VVJgDY/lUUFTEHqF75j7oewyZ8rVnqsKnIjwBkQnpYeNpPPlRIki8s5SfZm1CPQbJjUmitB/oJhXrcvppW5fe51geA9jr3wC7mV2IejT0XfbyunnRGCNMEkm2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109915; c=relaxed/simple;
	bh=1Jn7w4B77+hljyBsi3vMe8zMD9Goh7x7ABNxBeBk2vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iERFAzrANJeH7d5JQfwjDZZFo1dNUATBal2Aepl3kwZ4ZsJVgJGNDJ44NdB9gIlRhpq4VoHx6dhL90TVK/TRwO6iy505YdAe0uURxX9ooOHbDXLG0X3fu1VI5LVDtMW9AGNUiVpMfSbvG0vK5fiIqa5O+qaEcrdIZWsWe53hWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=H47lKwjy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+LYv/4EmfkPh+TBRltIBe9bZG6KhZCGuPilmDqGTxZ8=; t=1709109910; x=1710319510; 
	b=H47lKwjyiHHQiVzlslldTT50bvmF74/DAN6LGMACxzZnEvx1Uq9oSxL6Rvbtp4tt3ntxJsZSyCZ
	f+TqJiObWW98o7GC0bQVGODUjU7erEcttj4glhjag3CnWa3mNFkL5SQuF1TQyLHHNUToRmMnFAntI
	yqo5O4WpiBTMRSkBQlfjeJW6PSaXzoV7L+Lt3NHzD/a7SRfSK3lEQeukatNKhC6kaw5+4E0ToFZwy
	bhKUqiu8shY4UfWbTt1PrqGkI13aP69l8KCQ7k7ZN5wm6hDYX1eHZK3qmdzV4+cJ56G9r2Ma5sm+x
	twQHe/dbQmbcouZkJDPY7C8b1mAbvc3Gvdcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFYm-0000000Bzyl-0fLk;
	Wed, 28 Feb 2024 09:45:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Shaul Triebitz <shaul.triebitz@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: add link id to ieee80211_gtk_rekey_add()
Date: Wed, 28 Feb 2024 09:44:56 +0100
Message-ID: <20240228094500.ce1bfc83a680.I43a6f8ab2804ee07116a37d5b9ec601b843464b1@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

In MLO, we need the link id in the GTK key to be given by
the driver after rekeying in wowlan, so add that.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 12 +++++++-----
 include/net/mac80211.h                      |  4 +++-
 net/mac80211/key.c                          | 16 ++++++++++++----
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6d5ed79b9fff..ca2c6d0b605e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1976,6 +1976,7 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 	} conf = {
 		.conf.cipher = gtk_cipher,
 	};
+	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 
 	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
 	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
@@ -2009,7 +2010,7 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 		memcpy(conf.conf.key, status->gtk[i].key,
 		       sizeof(status->gtk[i].key));
 
-		key = ieee80211_gtk_rekey_add(vif, &conf.conf);
+		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
 		if (IS_ERR(key))
 			return false;
 
@@ -2040,6 +2041,7 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 		.conf.keyidx = key_data->id,
 	};
 	struct ieee80211_key_seq seq;
+	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 
 	if (!key_data->len)
 		return true;
@@ -2065,17 +2067,17 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
 	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
 
-	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf);
+	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
 	if (IS_ERR(key_config))
 		return false;
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
 
 	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-		int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
-		struct iwl_mvm_vif_link_info *mvm_link =
-			mvmvif->link[link_id];
+		struct iwl_mvm_vif_link_info *mvm_link;
 
+		link_id = link_id < 0 ? 0 : link_id;
+		mvm_link = mvmvif->link[link_id];
 		mvm_link->igtk = key_config;
 	}
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 56c6ecb2c10a..34d66d0a24b1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5912,6 +5912,7 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
  * ieee80211_gtk_rekey_add - add a GTK key from rekeying during WoWLAN
  * @vif: the virtual interface to add the key on
  * @keyconf: new key data
+ * @link_id: the link id of the key or -1 for non-MLO
  *
  * When GTK rekeying was done while the system was suspended, (a) new
  * key(s) will be available. These will be needed by mac80211 for proper
@@ -5939,7 +5940,8 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
  */
 struct ieee80211_key_conf *
 ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
-			struct ieee80211_key_conf *keyconf);
+			struct ieee80211_key_conf *keyconf,
+			int link_id);
 
 /**
  * ieee80211_gtk_rekey_notify - notify userspace supplicant of rekeying
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index a2cce62c97b7..eecdd2265eaa 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright 2018-2020, 2022-2023  Intel Corporation
+ * Copyright 2018-2020, 2022-2024  Intel Corporation
  */
 
 #include <crypto/utils.h>
@@ -1372,12 +1372,19 @@ EXPORT_SYMBOL_GPL(ieee80211_remove_key);
 
 struct ieee80211_key_conf *
 ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
-			struct ieee80211_key_conf *keyconf)
+			struct ieee80211_key_conf *keyconf,
+			int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_key *key;
 	int err;
+	struct ieee80211_link_data *link_data =
+		link_id < 0 ? &sdata->deflink :
+		sdata_dereference(sdata->link[link_id], sdata);
+
+	if (WARN_ON(!link_data))
+		return ERR_PTR(-EINVAL);
 
 	if (WARN_ON(!local->wowlan))
 		return ERR_PTR(-EINVAL);
@@ -1394,8 +1401,9 @@ ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 	if (sdata->u.mgd.mfp != IEEE80211_MFP_DISABLED)
 		key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
 
-	/* FIXME: this function needs to get a link ID */
-	err = ieee80211_key_link(key, &sdata->deflink, NULL);
+	key->conf.link_id = link_id;
+
+	err = ieee80211_key_link(key, link_data, NULL);
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.43.2


