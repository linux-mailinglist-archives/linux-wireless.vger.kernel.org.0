Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83878AF8F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjH1MGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjH1MFk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F3120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bNJ5sgOcVVl6AofQ9Xf4ZV8qyBaJEC28NFyIH//tKzM=;
        t=1693224338; x=1694433938; b=kPzZq5G/bwjAIjXZEaF7jD1MWj7jI7wa5MnUPXwutl8h3m8
        uPeR23TcZMBl/XugTujBfGsuK1CCcRGN4AVvxgu/aPghxK7/NHJaXzO0e5ADIY7Z1N9sRmFwmjEl2
        xXpsWnsNGfGdJ5nkK9ocrEeZPSUMslCzGhOqMA7bEj42mVEdS6q5s1XbILM4y3/E72rAPB/pD3OIT
        rDADc1IoYqvH6qH8e6Xz8Rqk7Cp3kWEGzrdC6sjdn7KmCQY/kCwLKpZNlVp8JlmW0VYyZFXp3a0+Y
        Vt8i2K4aCPF4bo90Unf6jdiOeAeRiyqTm2AdnOo/1alKJ7lUB3eOENfq08xV3IDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazv-00Gjgt-1m;
        Mon, 28 Aug 2023 14:05:35 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 19/40] wifi: mac80211: move key tailroom work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:47 +0200
Message-ID: <20230828135928.ff6b94d6c28a.I43825b7fa8edb0c6bc1a33a699e64efe15748668@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This way we hold the wiphy mutex there, as a step towards
removing some of the additional locks we have.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       |  4 ++--
 net/mac80211/key.c         | 11 +++++++----
 net/mac80211/key.h         |  5 +++--
 net/mac80211/main.c        |  3 ++-
 net/mac80211/pm.c          |  3 ++-
 6 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1dc49bbd35bf..c5a414b1fd0a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1041,7 +1041,7 @@ struct ieee80211_sub_if_data {
 	/* count for keys needing tailroom space allocation */
 	int crypto_tx_tailroom_needed_cnt;
 	int crypto_tx_tailroom_pending_dec;
-	struct delayed_work dec_tailroom_needed_wk;
+	struct wiphy_delayed_work dec_tailroom_needed_wk;
 
 	struct net_device *dev;
 	struct ieee80211_local *local;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6dc6cdc1cd37..fbfb9037b523 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2149,8 +2149,8 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	INIT_LIST_HEAD(&sdata->key_list);
 
-	INIT_DELAYED_WORK(&sdata->dec_tailroom_needed_wk,
-			  ieee80211_delayed_tailroom_dec);
+	wiphy_delayed_work_init(&sdata->dec_tailroom_needed_wk,
+				ieee80211_delayed_tailroom_dec);
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		struct ieee80211_supported_band *sband;
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 13050dc9321f..fbd9f9a9001c 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -775,8 +775,9 @@ static void __ieee80211_key_destroy(struct ieee80211_key *key,
 		if (delay_tailroom) {
 			/* see ieee80211_delayed_tailroom_dec */
 			sdata->crypto_tx_tailroom_pending_dec++;
-			schedule_delayed_work(&sdata->dec_tailroom_needed_wk,
-					      HZ/2);
+			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+						 &sdata->dec_tailroom_needed_wk,
+						 HZ / 2);
 		} else {
 			decrease_tailroom_need_count(sdata, 1);
 		}
@@ -1122,7 +1123,8 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_key *key, *tmp;
 	LIST_HEAD(keys);
 
-	cancel_delayed_work_sync(&sdata->dec_tailroom_needed_wk);
+	wiphy_delayed_work_cancel(local->hw.wiphy,
+				  &sdata->dec_tailroom_needed_wk);
 
 	mutex_lock(&local->key_mtx);
 
@@ -1193,7 +1195,8 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 	mutex_unlock(&local->key_mtx);
 }
 
-void ieee80211_delayed_tailroom_dec(struct work_struct *wk)
+void ieee80211_delayed_tailroom_dec(struct wiphy *wiphy,
+				    struct wiphy_work *wk)
 {
 	struct ieee80211_sub_if_data *sdata;
 
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index f3df97df4b72..231a069d2975 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -2,7 +2,7 @@
 /*
  * Copyright 2002-2004, Instant802 Networks, Inc.
  * Copyright 2005, Devicescape Software, Inc.
- * Copyright (C) 2019, 2022 Intel Corporation
+ * Copyright (C) 2019, 2022-2023 Intel Corporation
  */
 
 #ifndef IEEE80211_KEY_H
@@ -174,6 +174,7 @@ int ieee80211_key_switch_links(struct ieee80211_sub_if_data *sdata,
 #define rcu_dereference_check_key_mtx(local, ref) \
 	rcu_dereference_check(ref, lockdep_is_held(&((local)->key_mtx)))
 
-void ieee80211_delayed_tailroom_dec(struct work_struct *wk);
+void ieee80211_delayed_tailroom_dec(struct wiphy *wiphy,
+				    struct wiphy_work *wk);
 
 #endif /* IEEE80211_KEY_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index ba5382efa950..a66cfdca42ef 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -372,7 +372,8 @@ static void ieee80211_restart_work(struct work_struct *work)
 				sdata_unlock(sdata);
 			}
 		}
-		flush_delayed_work(&sdata->dec_tailroom_needed_wk);
+		wiphy_delayed_work_flush(local->hw.wiphy,
+					 &sdata->dec_tailroom_needed_wk);
 	}
 	ieee80211_scan_cancel(local);
 
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index 10eb72b9b994..e52dbf7d14fb 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -161,7 +161,8 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 			break;
 		}
 
-		flush_delayed_work(&sdata->dec_tailroom_needed_wk);
+		wiphy_delayed_work_flush(local->hw.wiphy,
+					 &sdata->dec_tailroom_needed_wk);
 		drv_remove_interface(local, sdata);
 	}
 
-- 
2.41.0

