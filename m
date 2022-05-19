Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCA752DF49
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiESV1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 17:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiESV13 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 17:27:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7D6D951
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=J9IFcK/PNqCsfzuOGNUl1T8KtHb9+V9XP9Wx2bkSThs=;
        t=1652995647; x=1654205247; b=TqRxoOIWrgwdu8oUHoI/CuTgW+hH9utsT1k4hRGZ4VYz7Zr
        oxxzreFx68jq/YfJ3ODwbM+j6PvdAR1wJkXiJDobYJXbifPChjVawlGVTW0PEGq6jnM1moQw6WB86
        VWMiilG8KWTVm9wae9V1iyhn4yZeHBoullxuEzish1+hsaARxhw688/G4HvuoiRJsyrBgR4eoT7F4
        ZvWY/hlhSNwqSv3Vg26CAMCzFsuBMEs5oq/8Av8rau2pjIWS3Kr9f79Rk6zAbG58gaz5mjhrKlMhD
        Vy2d6R0mRK7zwmMS3nl+l47687Q1AoxNh69IMGZLYLGx/RWjUI4BzBOeugDBQbaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nrng5-00GZd0-Al;
        Thu, 19 May 2022 23:27:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/3] mac80211: refactor some key code
Date:   Thu, 19 May 2022 23:27:22 +0200
Message-Id: <20220519232721.6febb5d5b82b.I3e8b3aca8873a59da7b63e56d4349c652afc815c@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid>
References: <20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's some pretty close code here, with the exception
of RCU dereference vs. protected dereference. Refactor
this to just return a pointer and then do the deref in
the caller later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 70 ++++++++++++++++++++++++----------------------
 net/mac80211/key.h |  2 ++
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f3b10cee9299..5975889a338f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -533,33 +533,51 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
+static struct ieee80211_key *
+ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata,
+		     u8 key_idx, bool pairwise, const u8 *mac_addr)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
+
+	if (mac_addr) {
+		sta = sta_info_get_bss(sdata, mac_addr);
+		if (!sta)
+			return NULL;
+
+		if (pairwise && key_idx < NUM_DEFAULT_KEYS)
+			return rcu_dereference_check_key_mtx(local,
+							     sta->ptk[key_idx]);
+
+		if (!pairwise &&
+		    key_idx < NUM_DEFAULT_KEYS +
+			      NUM_DEFAULT_MGMT_KEYS +
+			      NUM_DEFAULT_BEACON_KEYS)
+			return rcu_dereference_check_key_mtx(local,
+							     sta->deflink.gtk[key_idx]);
+
+		return NULL;
+	}
+
+	if (key_idx < NUM_DEFAULT_KEYS)
+		return rcu_dereference_check_key_mtx(local,
+						     sdata->keys[key_idx]);
+
+	return NULL;
+}
+
 static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 			     u8 key_idx, bool pairwise, const u8 *mac_addr)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	struct sta_info *sta;
-	struct ieee80211_key *key = NULL;
+	struct ieee80211_key *key;
 	int ret;
 
 	mutex_lock(&local->sta_mtx);
 	mutex_lock(&local->key_mtx);
 
-	if (mac_addr) {
-		ret = -ENOENT;
-
-		sta = sta_info_get_bss(sdata, mac_addr);
-		if (!sta)
-			goto out_unlock;
-
-		if (pairwise)
-			key = key_mtx_dereference(local, sta->ptk[key_idx]);
-		else
-			key = key_mtx_dereference(local,
-						  sta->deflink.gtk[key_idx]);
-	} else
-		key = key_mtx_dereference(local, sdata->keys[key_idx]);
-
+	key = ieee80211_lookup_key(sdata, key_idx, pairwise, mac_addr);
 	if (!key) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -582,10 +600,9 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 					      struct key_params *params))
 {
 	struct ieee80211_sub_if_data *sdata;
-	struct sta_info *sta = NULL;
 	u8 seq[6] = {0};
 	struct key_params params;
-	struct ieee80211_key *key = NULL;
+	struct ieee80211_key *key;
 	u64 pn64;
 	u32 iv32;
 	u16 iv16;
@@ -596,20 +613,7 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 
 	rcu_read_lock();
 
-	if (mac_addr) {
-		sta = sta_info_get_bss(sdata, mac_addr);
-		if (!sta)
-			goto out;
-
-		if (pairwise && key_idx < NUM_DEFAULT_KEYS)
-			key = rcu_dereference(sta->ptk[key_idx]);
-		else if (!pairwise &&
-			 key_idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
-			 NUM_DEFAULT_BEACON_KEYS)
-			key = rcu_dereference(sta->deflink.gtk[key_idx]);
-	} else
-		key = rcu_dereference(sdata->keys[key_idx]);
-
+	key = ieee80211_lookup_key(sdata, key_idx, pairwise, mac_addr);
 	if (!key)
 		goto out;
 
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index b3fb41c0c77f..e994dcea1ce3 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -163,6 +163,8 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata);
 
 #define key_mtx_dereference(local, ref) \
 	rcu_dereference_protected(ref, lockdep_is_held(&((local)->key_mtx)))
+#define rcu_dereference_check_key_mtx(local, ref) \
+	rcu_dereference_check(ref, lockdep_is_held(&((local)->key_mtx)))
 
 void ieee80211_delayed_tailroom_dec(struct work_struct *wk);
 
-- 
2.36.1

