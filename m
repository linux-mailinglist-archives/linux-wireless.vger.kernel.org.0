Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43742193F95
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZNRu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:17:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44402 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbgCZNRu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:17:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGn-00044K-7D; Thu, 26 Mar 2020 15:10:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:42 +0200
Message-Id: <iwlwifi.20200326150855.6865c7f28a14.I9fb1d911b064262d33e33dfba730cdeef83926ca@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326130943.623208-1-luca@coelho.fi>
References: <20200326130943.623208-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 11/12] mac80211: drop data frames without key on encrypted links
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we know that we have an encrypted link (based on having had
a key configured for TX in the past) then drop all data frames
in the key selection handler if there's no key anymore.

This fixes an issue with mac80211 internal TXQs - there we can
buffer frames for an encrypted link, but then if the key is no
longer there when they're dequeued, the frames are sent without
encryption. This happens if a station is disconnected while the
frames are still on the TXQ.

Detecting that a link should be encrypted based on a first key
having been configured for TX is fine as there are no use cases
for a connection going from with encryption to no encryption.
With extended key IDs, however, there is a case of having a key
configured for only decryption, so we can't just trigger this
behaviour on a key being configured.

Cc: stable@vger.kernel.org
Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/debugfs_sta.c |  3 ++-
 net/mac80211/key.c         | 20 ++++++++++++--------
 net/mac80211/sta_info.h    |  1 +
 net/mac80211/tx.c          | 12 +++++++++---
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 266d63819415..829dcad69c2c 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -5,7 +5,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2016 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 
 #include <linux/debugfs.h>
@@ -78,6 +78,7 @@ static const char * const sta_flag_names[] = {
 	FLAG(MPSP_OWNER),
 	FLAG(MPSP_RECIPIENT),
 	FLAG(PS_DELIVER),
+	FLAG(USES_ENCRYPTION),
 #undef FLAG
 };
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 6354491c5a09..8f403c1bb908 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright 2018-2019  Intel Corporation
+ * Copyright 2018-2020  Intel Corporation
  */
 
 #include <linux/if_ether.h>
@@ -277,22 +277,29 @@ static void ieee80211_key_disable_hw_accel(struct ieee80211_key *key)
 			  sta ? sta->sta.addr : bcast_addr, ret);
 }
 
-int ieee80211_set_tx_key(struct ieee80211_key *key)
+static int _ieee80211_set_tx_key(struct ieee80211_key *key, bool force)
 {
 	struct sta_info *sta = key->sta;
 	struct ieee80211_local *local = key->local;
 
 	assert_key_lock(local);
 
+	set_sta_flag(sta, WLAN_STA_USES_ENCRYPTION);
+
 	sta->ptk_idx = key->conf.keyidx;
 
-	if (!ieee80211_hw_check(&local->hw, AMPDU_KEYBORDER_SUPPORT))
+	if (force || !ieee80211_hw_check(&local->hw, AMPDU_KEYBORDER_SUPPORT))
 		clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 	ieee80211_check_fast_xmit(sta);
 
 	return 0;
 }
 
+int ieee80211_set_tx_key(struct ieee80211_key *key)
+{
+	return _ieee80211_set_tx_key(key, false);
+}
+
 static void ieee80211_pairwise_rekey(struct ieee80211_key *old,
 				     struct ieee80211_key *new)
 {
@@ -481,11 +488,8 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		if (pairwise) {
 			rcu_assign_pointer(sta->ptk[idx], new);
 			if (new &&
-			    !(new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX)) {
-				sta->ptk_idx = idx;
-				clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
-				ieee80211_check_fast_xmit(sta);
-			}
+			    !(new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX))
+				_ieee80211_set_tx_key(new, true);
 		} else {
 			rcu_assign_pointer(sta->gtk[idx], new);
 		}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 78ab18eee1ec..a5de3aa6ea42 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -99,6 +99,7 @@ enum ieee80211_sta_info_flags {
 	WLAN_STA_MPSP_OWNER,
 	WLAN_STA_MPSP_RECIPIENT,
 	WLAN_STA_PS_DELIVER,
+	WLAN_STA_USES_ENCRYPTION,
 
 	NUM_WLAN_STA_FLAGS,
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 49d35936cc9d..637c22a4256f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -590,10 +590,13 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
 
-	if (unlikely(info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT))
+	if (unlikely(info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)) {
 		tx->key = NULL;
-	else if (tx->sta &&
-		 (key = rcu_dereference(tx->sta->ptk[tx->sta->ptk_idx])))
+		return TX_CONTINUE;
+	}
+
+	if (tx->sta &&
+	    (key = rcu_dereference(tx->sta->ptk[tx->sta->ptk_idx])))
 		tx->key = key;
 	else if (ieee80211_is_group_privacy_action(tx->skb) &&
 		(key = rcu_dereference(tx->sdata->default_multicast_key)))
@@ -654,6 +657,9 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 		if (!skip_hw && tx->key &&
 		    tx->key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
 			info->control.hw_key = &tx->key->conf;
+	} else if (!ieee80211_is_mgmt(hdr->frame_control) && tx->sta &&
+		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
+		return TX_DROP;
 	}
 
 	return TX_CONTINUE;
-- 
2.25.1

