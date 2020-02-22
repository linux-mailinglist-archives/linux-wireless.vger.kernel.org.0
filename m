Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9E168F1D
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBVN1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:42 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:36803 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbgBVN1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378061; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cPl53wEd6yCKVIWeCDPnkkIzu9leCzZm3wE8M8yaHOo=; b=GevwgBRIOM292Ol574/rJ1tn5tRSUV27dBWHwt/prWi8NxOq/Lufw6dFgwVlTM1cW3oQtLIx
 ktSbdXr/DXVLbfl13GaatNjpxz7Ki4VMlGNlS8+TpSa94vJjFhBFS3qlQMvWKiws7++ooRwg
 CXClLZKPhIpD/LjQnyWSn3ZNnr0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c31.7fd7564681b8-smtp-out-n01;
 Sat, 22 Feb 2020 13:27:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B46B5C43383; Sat, 22 Feb 2020 13:27:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12CEFC4479C;
        Sat, 22 Feb 2020 13:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12CEFC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/7] mac80211: Support BIGTK configuration for Beacon protection
Date:   Sat, 22 Feb 2020 15:25:44 +0200
Message-Id: <20200222132548.20835-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend mac80211 key configuration to support the new BIGTK with key
index values 6 and 7. Support for actually protecting Beacon frames
(adding the MME in AP mode and checking it in STA mode) is covered in
separate commits.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/cfg.c         | 15 +++++++++++++-
 net/mac80211/debugfs_key.c | 31 +++++++++++++++++++++++++++++
 net/mac80211/debugfs_key.h | 10 ++++++++++
 net/mac80211/ieee80211_i.h |  6 +++++-
 net/mac80211/key.c         | 40 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/key.h         |  3 +++
 net/mac80211/sta_info.h    |  4 +++-
 7 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a66eff1ee26a..a762ba6e4c5d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -568,7 +568,8 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 		if (pairwise && key_idx < NUM_DEFAULT_KEYS)
 			key = rcu_dereference(sta->ptk[key_idx]);
 		else if (!pairwise &&
-			 key_idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS)
+			 key_idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
+			 NUM_DEFAULT_BEACON_KEYS)
 			key = rcu_dereference(sta->gtk[key_idx]);
 	} else
 		key = rcu_dereference(sdata->keys[key_idx]);
@@ -680,6 +681,17 @@ static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
 	return 0;
 }
 
+static int ieee80211_config_default_beacon_key(struct wiphy *wiphy,
+					       struct net_device *dev,
+					       u8 key_idx)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	ieee80211_set_default_beacon_key(sdata, key_idx);
+
+	return 0;
+}
+
 void sta_set_rate_info_tx(struct sta_info *sta,
 			  const struct ieee80211_tx_rate *rate,
 			  struct rate_info *rinfo)
@@ -3885,6 +3897,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.get_key = ieee80211_get_key,
 	.set_default_key = ieee80211_config_default_key,
 	.set_default_mgmt_key = ieee80211_config_default_mgmt_key,
+	.set_default_beacon_key = ieee80211_config_default_beacon_key,
 	.start_ap = ieee80211_start_ap,
 	.change_beacon = ieee80211_change_beacon,
 	.stop_ap = ieee80211_stop_ap,
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 7b8735ced2a1..98a713475e0f 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -433,6 +433,37 @@ void ieee80211_debugfs_key_remove_mgmt_default(struct ieee80211_sub_if_data *sda
 	sdata->debugfs.default_mgmt_key = NULL;
 }
 
+void
+ieee80211_debugfs_key_add_beacon_default(struct ieee80211_sub_if_data *sdata)
+{
+	char buf[50];
+	struct ieee80211_key *key;
+
+	if (!sdata->vif.debugfs_dir)
+		return;
+
+	key = key_mtx_dereference(sdata->local,
+				  sdata->default_beacon_key);
+	if (key) {
+		sprintf(buf, "../keys/%d", key->debugfs.cnt);
+		sdata->debugfs.default_beacon_key =
+			debugfs_create_symlink("default_beacon_key",
+					       sdata->vif.debugfs_dir, buf);
+	} else {
+		ieee80211_debugfs_key_remove_beacon_default(sdata);
+	}
+}
+
+void
+ieee80211_debugfs_key_remove_beacon_default(struct ieee80211_sub_if_data *sdata)
+{
+	if (!sdata)
+		return;
+
+	debugfs_remove(sdata->debugfs.default_beacon_key);
+	sdata->debugfs.default_beacon_key = NULL;
+}
+
 void ieee80211_debugfs_key_sta_del(struct ieee80211_key *key,
 				   struct sta_info *sta)
 {
diff --git a/net/mac80211/debugfs_key.h b/net/mac80211/debugfs_key.h
index 1cd7b8bff56c..af7cf495f8d1 100644
--- a/net/mac80211/debugfs_key.h
+++ b/net/mac80211/debugfs_key.h
@@ -10,6 +10,10 @@ void ieee80211_debugfs_key_add_mgmt_default(
 	struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_key_remove_mgmt_default(
 	struct ieee80211_sub_if_data *sdata);
+void ieee80211_debugfs_key_add_beacon_default(
+	struct ieee80211_sub_if_data *sdata);
+void ieee80211_debugfs_key_remove_beacon_default(
+	struct ieee80211_sub_if_data *sdata);
 void ieee80211_debugfs_key_sta_del(struct ieee80211_key *key,
 				   struct sta_info *sta);
 #else
@@ -26,6 +30,12 @@ static inline void ieee80211_debugfs_key_add_mgmt_default(
 static inline void ieee80211_debugfs_key_remove_mgmt_default(
 	struct ieee80211_sub_if_data *sdata)
 {}
+static inline void ieee80211_debugfs_key_add_beacon_default(
+	struct ieee80211_sub_if_data *sdata)
+{}
+static inline void ieee80211_debugfs_key_remove_beacon_default(
+	struct ieee80211_sub_if_data *sdata)
+{}
 static inline void ieee80211_debugfs_key_sta_del(struct ieee80211_key *key,
 						 struct sta_info *sta)
 {}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index da9eaa9ee37e..46f9e8e5b4d7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -901,10 +901,13 @@ struct ieee80211_sub_if_data {
 	/* bit field of ACM bits (BIT(802.1D tag)) */
 	u8 wmm_acm;
 
-	struct ieee80211_key __rcu *keys[NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS];
+	struct ieee80211_key __rcu *keys[NUM_DEFAULT_KEYS +
+					 NUM_DEFAULT_MGMT_KEYS +
+					 NUM_DEFAULT_BEACON_KEYS];
 	struct ieee80211_key __rcu *default_unicast_key;
 	struct ieee80211_key __rcu *default_multicast_key;
 	struct ieee80211_key __rcu *default_mgmt_key;
+	struct ieee80211_key __rcu *default_beacon_key;
 
 	u16 sequence_number;
 	__be16 control_port_protocol;
@@ -978,6 +981,7 @@ struct ieee80211_sub_if_data {
 		struct dentry *default_unicast_key;
 		struct dentry *default_multicast_key;
 		struct dentry *default_mgmt_key;
+		struct dentry *default_beacon_key;
 	} debugfs;
 #endif
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 54934eff4ac1..6354491c5a09 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -407,6 +407,31 @@ void ieee80211_set_default_mgmt_key(struct ieee80211_sub_if_data *sdata,
 	mutex_unlock(&sdata->local->key_mtx);
 }
 
+static void
+__ieee80211_set_default_beacon_key(struct ieee80211_sub_if_data *sdata, int idx)
+{
+	struct ieee80211_key *key = NULL;
+
+	assert_key_lock(sdata->local);
+
+	if (idx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS &&
+	    idx < NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
+	    NUM_DEFAULT_BEACON_KEYS)
+		key = key_mtx_dereference(sdata->local, sdata->keys[idx]);
+
+	rcu_assign_pointer(sdata->default_beacon_key, key);
+
+	ieee80211_debugfs_key_update_default(sdata);
+}
+
+void ieee80211_set_default_beacon_key(struct ieee80211_sub_if_data *sdata,
+				      int idx)
+{
+	mutex_lock(&sdata->local->key_mtx);
+	__ieee80211_set_default_beacon_key(sdata, idx);
+	mutex_unlock(&sdata->local->key_mtx);
+}
+
 static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				  struct sta_info *sta,
 				  bool pairwise,
@@ -415,7 +440,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 {
 	int idx;
 	int ret = 0;
-	bool defunikey, defmultikey, defmgmtkey;
+	bool defunikey, defmultikey, defmgmtkey, defbeaconkey;
 
 	/* caller must provide at least one old/new */
 	if (WARN_ON(!new && !old))
@@ -480,6 +505,9 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		defmgmtkey = old &&
 			old == key_mtx_dereference(sdata->local,
 						sdata->default_mgmt_key);
+		defbeaconkey = old &&
+			old == key_mtx_dereference(sdata->local,
+						   sdata->default_beacon_key);
 
 		if (defunikey && !new)
 			__ieee80211_set_default_key(sdata, -1, true, false);
@@ -487,6 +515,8 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 			__ieee80211_set_default_key(sdata, -1, false, true);
 		if (defmgmtkey && !new)
 			__ieee80211_set_default_mgmt_key(sdata, -1);
+		if (defbeaconkey && !new)
+			__ieee80211_set_default_beacon_key(sdata, -1);
 
 		rcu_assign_pointer(sdata->keys[idx], new);
 		if (defunikey && new)
@@ -498,6 +528,9 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		if (defmgmtkey && new)
 			__ieee80211_set_default_mgmt_key(sdata,
 							 new->conf.keyidx);
+		if (defbeaconkey && new)
+			__ieee80211_set_default_beacon_key(sdata,
+							   new->conf.keyidx);
 	}
 
 	if (old)
@@ -515,7 +548,9 @@ ieee80211_key_alloc(u32 cipher, int idx, size_t key_len,
 	struct ieee80211_key *key;
 	int i, j, err;
 
-	if (WARN_ON(idx < 0 || idx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS))
+	if (WARN_ON(idx < 0 ||
+		    idx >= NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS +
+		    NUM_DEFAULT_BEACON_KEYS))
 		return ERR_PTR(-EINVAL);
 
 	key = kzalloc(sizeof(struct ieee80211_key) + key_len, GFP_KERNEL);
@@ -978,6 +1013,7 @@ static void ieee80211_free_keys_iface(struct ieee80211_sub_if_data *sdata,
 	sdata->crypto_tx_tailroom_pending_dec = 0;
 
 	ieee80211_debugfs_key_remove_mgmt_default(sdata);
+	ieee80211_debugfs_key_remove_beacon_default(sdata);
 
 	list_for_each_entry_safe(key, tmp, &sdata->key_list, list) {
 		ieee80211_key_replace(key->sdata, key->sta,
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index d6d6e89cf7dd..7ad72e9b4991 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -17,6 +17,7 @@
 
 #define NUM_DEFAULT_KEYS 4
 #define NUM_DEFAULT_MGMT_KEYS 2
+#define NUM_DEFAULT_BEACON_KEYS 2
 #define INVALID_PTK_KEYIDX 2 /* Keyidx always pointing to a NULL key for PTK */
 
 struct ieee80211_local;
@@ -153,6 +154,8 @@ void ieee80211_set_default_key(struct ieee80211_sub_if_data *sdata, int idx,
 			       bool uni, bool multi);
 void ieee80211_set_default_mgmt_key(struct ieee80211_sub_if_data *sdata,
 				    int idx);
+void ieee80211_set_default_beacon_key(struct ieee80211_sub_if_data *sdata,
+				      int idx);
 void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 			 bool force_synchronize);
 void ieee80211_free_sta_keys(struct ieee80211_local *local,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index c00e28585f9d..364a35414d05 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -533,7 +533,9 @@ struct sta_info {
 	u8 addr[ETH_ALEN];
 	struct ieee80211_local *local;
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS + NUM_DEFAULT_MGMT_KEYS];
+	struct ieee80211_key __rcu *gtk[NUM_DEFAULT_KEYS +
+					NUM_DEFAULT_MGMT_KEYS +
+					NUM_DEFAULT_BEACON_KEYS];
 	struct ieee80211_key __rcu *ptk[NUM_DEFAULT_KEYS];
 	u8 ptk_idx;
 	struct rate_control_ref *rate_ctrl;
-- 
2.20.1
