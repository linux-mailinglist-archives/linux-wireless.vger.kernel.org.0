Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E60552D9D0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbiESQHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiESQHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 12:07:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8F3631F
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kKZ05LBqynETw9PDHPvgD94afUXP8uygPvhyP40qL3I=;
        t=1652976453; x=1654186053; b=xB7S6rit8zCAGCyEGNTLDTX0A20oxrarS2ZjS2JkrKL8sJI
        Z+qonxAIozT5vx6FXd6VZJ7sMUs+CjQA8NN+Uaqun48HncdE/awpZB1A7bS93R/Rgd9LRKaWT7zGG
        qf7htIaXNnUpgFI4Jm8o2M13G5Tt+SArMGb5zgJn6k11mxWQVVAmLndOzhqtvY9bSpZqgWFPlOefq
        pLNl7U8bDc+H0VtRUxCkfY444rNGOlAKh0cvbOKL4OUui9eZNcPXQqT2YGeuLfXyYzPp/KMN27bjE
        04GUtkU4YDyRFA2q+OhbonlxZ3CIe5olRpeBB86/gyof3XmhWXtSD73iT9f3xbVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nrigT-00GPjR-5E;
        Thu, 19 May 2022 18:07:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] mac80211: refactor some key code
Date:   Thu, 19 May 2022 18:07:24 +0200
Message-Id: <20220519180724.6e18b45e6d2f.I3e8b3aca8873a59da7b63e56d4349c652afc815c@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519180724.e46f24800e6e.I2a66a9e9e350746ec891e563788d31898041ebc5@changeid>
References: <20220519180724.e46f24800e6e.I2a66a9e9e350746ec891e563788d31898041ebc5@changeid>
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
 net/mac80211/cfg.c | 70 +++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f3b10cee9299..fe49828ca5d6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -533,34 +533,48 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
+static struct ieee80211_key **
+ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata,
+		     u8 key_idx, bool pairwise, const u8 *mac_addr)
+{
+	struct sta_info *sta;
+
+	if (mac_addr) {
+		sta = sta_info_get_bss(sdata, mac_addr);
+		if (!sta)
+			return NULL;
+
+		if (pairwise && key_idx < NUM_DEFAULT_KEYS)
+			return &sta->ptk[key_idx];
+
+		if (!pairwise &&
+		    key_idx < NUM_DEFAULT_KEYS +
+			      NUM_DEFAULT_MGMT_KEYS +
+			      NUM_DEFAULT_BEACON_KEYS)
+			return &sta->deflink.gtk[key_idx];
+
+		return NULL;
+	}
+
+	if (key_idx < NUM_DEFAULT_KEYS)
+		return &sdata->keys[key_idx];
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
+	struct ieee80211_key *key, **keyptr;
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
-	if (!key) {
+	keyptr = ieee80211_lookup_key(sdata, key_idx, pairwise, mac_addr);
+	if (!keyptr || !(key = key_mtx_dereference(local, *keyptr))) {
 		ret = -ENOENT;
 		goto out_unlock;
 	}
@@ -582,10 +596,9 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 					      struct key_params *params))
 {
 	struct ieee80211_sub_if_data *sdata;
-	struct sta_info *sta = NULL;
 	u8 seq[6] = {0};
 	struct key_params params;
-	struct ieee80211_key *key = NULL;
+	struct ieee80211_key *key, **keyptr;
 	u64 pn64;
 	u32 iv32;
 	u16 iv16;
@@ -596,21 +609,8 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 
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
-	if (!key)
+	keyptr = ieee80211_lookup_key(sdata, key_idx, pairwise, mac_addr);
+	if (!keyptr || !(key = rcu_dereference(*keyptr)))
 		goto out;
 
 	memset(&params, 0, sizeof(params));
-- 
2.36.1

