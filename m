Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5BA35A0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3LZE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:25:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39450 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727876AbfH3LZC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:25:02 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1Y-0001lc-UC; Fri, 30 Aug 2019 14:25:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:49 +0300
Message-Id: <20190830112451.21655-7-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-1-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 6/8] mac80211: clear crypto tx tailroom counter upon keys enable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lior Cohen <lior2.cohen@intel.com>

In case we got a fw restart while roaming from encrypted AP to
non-encrypted one, we might end up with hitting a warning on the pending
counter crypto_tx_tailroom_pending_dec having a non-zero value.

The following comment taken from net/mac80211/key.c explains the rational
for the delayed tailroom needed:

	/*
	* The reason for the delayed tailroom needed decrementing is to
	* make roaming faster: during roaming, all keys are first deleted
	* and then new keys are installed. The first new key causes the
	* crypto_tx_tailroom_needed_cnt to go from 0 to 1, which invokes
	* the cost of synchronize_net() (which can be slow). Avoid this
	* by deferring the crypto_tx_tailroom_needed_cnt decrementing on
	* key removal for a while, so if we roam the value is larger than
	* zero and no 0->1 transition happens.
	*
	* The cost is that if the AP switching was from an AP with keys
	* to one without, we still allocate tailroom while it would no
	* longer be needed. However, in the typical (fast) roaming case
	* within an ESS this usually won't happen.
	*/

The next flow lead to the warning eventually reported as a bug:
1. Disconnect from encrypted AP
2. Set crypto_tx_tailroom_pending_dec = 1 for the key
3. Schedule work
4. Reconnect to non-encrypted AP
5. Add a new key, setting the tailroom counter = 1
6. Got FW restart while pending counter is set ---> hit the warning

While on it, the ieee80211_reset_crypto_tx_tailroom() func was merged into
its single caller ieee80211_reenable_keys (previously called
ieee80211_enable_keys). Also, we reset the crypto_tx_tailroom_pending_dec
and remove the counters warning as we just reset both.

Signed-off-by: Lior Cohen <lior2.cohen@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/key.c  | 40 ++++++++++++----------------------------
 net/mac80211/key.h  |  4 ++--
 net/mac80211/util.c |  6 +-----
 3 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 1be3686562ee..93ea03b86b80 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -843,46 +843,30 @@ void ieee80211_key_free(struct ieee80211_key *key, bool delay_tailroom)
 	ieee80211_key_destroy(key, delay_tailroom);
 }
 
-void ieee80211_enable_keys(struct ieee80211_sub_if_data *sdata)
+void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_key *key;
 	struct ieee80211_sub_if_data *vlan;
 
 	ASSERT_RTNL();
 
-	if (WARN_ON(!ieee80211_sdata_running(sdata)))
-		return;
-
-	mutex_lock(&sdata->local->key_mtx);
-
-	WARN_ON_ONCE(sdata->crypto_tx_tailroom_needed_cnt ||
-		     sdata->crypto_tx_tailroom_pending_dec);
-
-	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
-			WARN_ON_ONCE(vlan->crypto_tx_tailroom_needed_cnt ||
-				     vlan->crypto_tx_tailroom_pending_dec);
-	}
-
-	list_for_each_entry(key, &sdata->key_list, list) {
-		increment_tailroom_need_count(sdata);
-		ieee80211_key_enable_hw_accel(key);
-	}
-
-	mutex_unlock(&sdata->local->key_mtx);
-}
-
-void ieee80211_reset_crypto_tx_tailroom(struct ieee80211_sub_if_data *sdata)
-{
-	struct ieee80211_sub_if_data *vlan;
-
 	mutex_lock(&sdata->local->key_mtx);
 
 	sdata->crypto_tx_tailroom_needed_cnt = 0;
+	sdata->crypto_tx_tailroom_pending_dec = 0;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
+		list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 			vlan->crypto_tx_tailroom_needed_cnt = 0;
+			vlan->crypto_tx_tailroom_pending_dec = 0;
+		}
+	}
+
+	if (ieee80211_sdata_running(sdata)) {
+		list_for_each_entry(key, &sdata->key_list, list) {
+			increment_tailroom_need_count(sdata);
+			ieee80211_key_enable_hw_accel(key);
+		}
 	}
 
 	mutex_unlock(&sdata->local->key_mtx);
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index b8b9cd743bf4..d6d6e89cf7dd 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -2,6 +2,7 @@
 /*
  * Copyright 2002-2004, Instant802 Networks, Inc.
  * Copyright 2005, Devicescape Software, Inc.
+ * Copyright (C) 2019 Intel Corporation
  */
 
 #ifndef IEEE80211_KEY_H
@@ -156,8 +157,7 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 			 bool force_synchronize);
 void ieee80211_free_sta_keys(struct ieee80211_local *local,
 			     struct sta_info *sta);
-void ieee80211_enable_keys(struct ieee80211_sub_if_data *sdata);
-void ieee80211_reset_crypto_tx_tailroom(struct ieee80211_sub_if_data *sdata);
+void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata);
 
 #define key_mtx_dereference(local, ref) \
 	rcu_dereference_protected(ref, lockdep_is_held(&((local)->key_mtx)))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 286c7ee35e63..92bfedfd3fd2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2420,11 +2420,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 	/* add back keys */
 	list_for_each_entry(sdata, &local->interfaces, list)
-		ieee80211_reset_crypto_tx_tailroom(sdata);
-
-	list_for_each_entry(sdata, &local->interfaces, list)
-		if (ieee80211_sdata_running(sdata))
-			ieee80211_enable_keys(sdata);
+		ieee80211_reenable_keys(sdata);
 
 	/* Reconfigure sched scan if it was interrupted by FW restart */
 	mutex_lock(&local->mtx);
-- 
2.23.0.rc1

