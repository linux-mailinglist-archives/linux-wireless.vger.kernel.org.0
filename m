Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704A21E6A87
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406487AbgE1TWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406480AbgE1TWo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:22:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87EC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:22:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeO6z-0053zp-L1; Thu, 28 May 2020 21:22:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Nathan Errera <nathan.errera@intel.com>
Subject: [PATCH] cfg80211: support bigger kek/kck key length
Date:   Thu, 28 May 2020 21:22:38 +0200
Message-Id: <20200528212237.5eb58b00a5d1.I61b09d77c4f382e8d58a05dcca78096e99a6bc15@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

With some newer AKMs, the KCK and KEK are bigger, so allow that
if the driver advertises support for it. In addition, add a new
attribute for the AKM so we can use it for offloaded rekeying.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
[reword commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       | 12 +++++++++---
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/nl80211.c       | 23 +++++++++++++++++++----
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c09d782618bb..7ce14e68378a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2961,12 +2961,17 @@ struct cfg80211_wowlan_wakeup {
 
 /**
  * struct cfg80211_gtk_rekey_data - rekey data
- * @kek: key encryption key (NL80211_KEK_LEN bytes)
- * @kck: key confirmation key (NL80211_KCK_LEN bytes)
+ * @kek: key encryption key (@kek_len bytes)
+ * @kck: key confirmation key (@kck_len bytes)
  * @replay_ctr: replay counter (NL80211_REPLAY_CTR_LEN bytes)
+ * @kek_len: length of kek
+ * @kck_len length of kck
+ * @akm: akm (oui, id)
  */
 struct cfg80211_gtk_rekey_data {
 	const u8 *kek, *kck, *replay_ctr;
+	u32 akm;
+	u8 kek_len, kck_len;
 };
 
 /**
@@ -4193,9 +4198,10 @@ struct cfg80211_ops {
  *	beaconing mode (AP, IBSS, Mesh, ...).
  * @WIPHY_FLAG_HAS_STATIC_WEP: The device supports static WEP key installation
  *	before connection.
+ * @WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK: The device supports bigger kek and kck keys
  */
 enum wiphy_flags {
-	/* use hole at 0 */
+	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
 	/* use hole at 1 */
 	WIPHY_FLAG_SPLIT_SCAN_6GHZ		= BIT(2),
 	WIPHY_FLAG_NETNS_OK			= BIT(3),
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 65de604afad0..13b4d3c2c19d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5396,6 +5396,8 @@ enum plink_actions {
 
 #define NL80211_KCK_LEN			16
 #define NL80211_KEK_LEN			16
+#define NL80211_KCK_EXT_LEN		24
+#define NL80211_KEK_EXT_LEN		32
 #define NL80211_REPLAY_CTR_LEN		8
 
 /**
@@ -5404,6 +5406,7 @@ enum plink_actions {
  * @NL80211_REKEY_DATA_KEK: key encryption key (binary)
  * @NL80211_REKEY_DATA_KCK: key confirmation key (binary)
  * @NL80211_REKEY_DATA_REPLAY_CTR: replay counter (binary)
+ * @NL80211_REKEY_DATA_AKM: AKM data (OUI, suite type)
  * @NUM_NL80211_REKEY_DATA: number of rekey attributes (internal)
  * @MAX_NL80211_REKEY_DATA: highest rekey attribute (internal)
  */
@@ -5412,6 +5415,7 @@ enum nl80211_rekey_data {
 	NL80211_REKEY_DATA_KEK,
 	NL80211_REKEY_DATA_KCK,
 	NL80211_REKEY_DATA_REPLAY_CTR,
+	NL80211_REKEY_DATA_AKM,
 
 	/* keep last */
 	NUM_NL80211_REKEY_DATA,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4be9ac52421d..be4f1b8668e1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -730,9 +730,16 @@ nl80211_coalesce_policy[NUM_NL80211_ATTR_COALESCE_RULE] = {
 /* policy for GTK rekey offload attributes */
 static const struct nla_policy
 nl80211_rekey_policy[NUM_NL80211_REKEY_DATA] = {
-	[NL80211_REKEY_DATA_KEK] = NLA_POLICY_EXACT_LEN_WARN(NL80211_KEK_LEN),
-	[NL80211_REKEY_DATA_KCK] = NLA_POLICY_EXACT_LEN_WARN(NL80211_KCK_LEN),
+	[NL80211_REKEY_DATA_KEK] = {
+		.type = NLA_BINARY,
+		.len = NL80211_KEK_EXT_LEN
+	},
+	[NL80211_REKEY_DATA_KCK] = {
+		.type = NLA_BINARY,
+		.len = NL80211_KCK_EXT_LEN
+	},
 	[NL80211_REKEY_DATA_REPLAY_CTR] = NLA_POLICY_EXACT_LEN_WARN(NL80211_REPLAY_CTR_LEN),
+	[NL80211_REKEY_DATA_AKM] = { .type = NLA_U32 },
 };
 
 static const struct nla_policy
@@ -12347,14 +12354,22 @@ static int nl80211_set_rekey_data(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	if (nla_len(tb[NL80211_REKEY_DATA_REPLAY_CTR]) != NL80211_REPLAY_CTR_LEN)
 		return -ERANGE;
-	if (nla_len(tb[NL80211_REKEY_DATA_KEK]) != NL80211_KEK_LEN)
+	if (nla_len(tb[NL80211_REKEY_DATA_KEK]) != NL80211_KEK_LEN &&
+	    !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK &&
+	      nla_len(tb[NL80211_REKEY_DATA_KEK]) == NL80211_KEK_EXT_LEN))
 		return -ERANGE;
-	if (nla_len(tb[NL80211_REKEY_DATA_KCK]) != NL80211_KCK_LEN)
+	if (nla_len(tb[NL80211_REKEY_DATA_KCK]) != NL80211_KCK_LEN &&
+	    !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK &&
+	      nla_len(tb[NL80211_REKEY_DATA_KEK]) == NL80211_KCK_EXT_LEN))
 		return -ERANGE;
 
 	rekey_data.kek = nla_data(tb[NL80211_REKEY_DATA_KEK]);
 	rekey_data.kck = nla_data(tb[NL80211_REKEY_DATA_KCK]);
 	rekey_data.replay_ctr = nla_data(tb[NL80211_REKEY_DATA_REPLAY_CTR]);
+	rekey_data.kek_len = nla_len(tb[NL80211_REKEY_DATA_KEK]);
+	rekey_data.kck_len = nla_len(tb[NL80211_REKEY_DATA_KCK]);
+	if (tb[NL80211_REKEY_DATA_AKM])
+		rekey_data.akm = nla_get_u32(tb[NL80211_REKEY_DATA_AKM]);
 
 	wdev_lock(wdev);
 	if (!wdev->current_bss) {
-- 
2.26.2

