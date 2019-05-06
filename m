Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34A731543C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfEFTMr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 15:12:47 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:50915 "EHLO
        9.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEFTMr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 15:12:47 -0400
Received: from player762.ha.ovh.net (unknown [10.109.146.168])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 86D8B50B98
        for <linux-wireless@vger.kernel.org>; Mon,  6 May 2019 21:05:06 +0200 (CEST)
Received: from awhome.eu (p4FF91A34.dip0.t-ipconnect.de [79.249.26.52])
        (Authenticated sender: postmaster@awhome.eu)
        by player762.ha.ovh.net (Postfix) with ESMTPSA id D24AC57959A8;
        Mon,  6 May 2019 19:05:04 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1557169503;
        bh=WmUTWww/r1arv2Axmk4PbiiEtymCF53AnYSy9d45a2I=;
        h=From:To:Cc:Subject:Date;
        b=buuAvjp9CIFhdqNdgB6FYHDICx2g7wAAsgKrF70QlPtxepK2/T4dHbwco6RSdUlzW
         h96Is0ThoPeCk/ObXvzrFBGn/ryiFRf9dvyqfTuQcgwoIjmv/hzKcitgEGP3+z9V7Z
         5RxH0fZICHw9MxxyJHGobsBeXpzcaezgEZGpHLzE=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH 1/2] mac80211: AMPDU handling for Extended Key ID
Date:   Mon,  6 May 2019 21:01:48 +0200
Message-Id: <20190506190149.3624-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9611244555594243271
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrjeekgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE 802.11 - 2016 forbids mixing MPDUs with different keyIDs in one
A-MPDU. Drivers supporting A-MPDUs and Extended Key ID must actively
enforce that requirement due to the available two unicast keyIDs.

Allow driver to signal mac80211 that they will not check the keyID in
MPDUs when aggregating them and that they expect mac80211 to stop Tx
aggregation when rekeying a connection using Extended Key ID.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This is now just the simple and obvious solution for the A-MPDU mixing
problem. Just stopping Tx aggregation may not be very elegant, but for
drivers like iwlwifi - which can't control how many MPDUs can be
aggregated - the sane solution.
Once we have more cards supporting A-MPDU and Extended Key ID it may make
sense to add another mechanism, like the proposed Key ID border signal.
But then maybe not...

The patch is looking bigger than it really is, It's moving some code
around to clean up the logic and replace ieee80211_hw_key_replace() with
ieee80211_pairwise_rekey() which is then of course no longer installing
the keys to the HW.
That way we can have the "special cases" for unicast key crypto handling
in one function, for both HW and SW crypto.
(Which so far are PTK0 rekey and Extended Key ID A-MPDU keyID mixing.)

Not so nice is the use of WLAN_STA_BLOCK_BA. We only have to make sure
no new Tx aggregation sessions can be started but block both. It just
seems to be overkill to add a more granular control here.
WLAN_STA_BLOCK_BA is also used when suspending, so with some bad timing
Extended Key ID or PTK0 rekeys can unlock the lock from suspend.
It just looks pretty harmless, since a suspend will disconnect us anyhow.
I can of course add something like a lock counter, but that again seems
to be overkill for now. (After all this is intended to be the minimal
solution to get the job done:-)

I've of course ran some tests with the patch and can confirm that this
seems to solves the observed MPDU corruptions with mvm cards while not
causing undesired side effects.

I've also uploaded two captures taken on a STA connected to an AP and
uploaded them again to https://www.awhome.eu/index.php/s/AJJXBLsZmzHdxpX
iwlwifi-fixed.pcap.gz has been taken with an older, simpler and
incomplete patch, iwlwifi-fixed-final.pcap was then taken with the patch
provided here.

Note that I did not drop the unused variable "old" YueHaibing provided a
patch for on 29th of April. That is indeed a leftover from a older patch
without any function which somehow crept into the final patch.
I assume you'll apply his patch and prefer that I do not remove it here
also...

 include/net/mac80211.h |   4 ++
 net/mac80211/debugfs.c |   1 +
 net/mac80211/key.c     | 100 +++++++++++++++++++++++------------------
 3 files changed, 61 insertions(+), 44 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72080d9d617e..b7f0b56a09f4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2269,6 +2269,9 @@ struct ieee80211_txq {
  * @IEEE80211_HW_EXT_KEY_ID_NATIVE: Driver and hardware are supporting Extended
  *	Key ID and can handle two unicast keys per station for Rx and Tx.
  *
+ * @IEEE80211_HW_NO_AMPDU_KEYBORDER_SUPPORT: The card/driver can't handle
+ *	active Tx A-MPDU sessions with Extended Key IDs during rekey.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2321,6 +2324,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_EXT_KEY_ID_NATIVE,
+	IEEE80211_HW_NO_AMPDU_KEYBORDER_SUPPORT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 0d462206eef6..7c580010836e 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -274,6 +274,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(EXT_KEY_ID_NATIVE),
+	FLAG(NO_AMPDU_KEYBORDER_SUPPORT),
 #undef FLAG
 };
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 20bf9db7a388..faadfeea7127 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -274,50 +274,61 @@ int ieee80211_set_tx_key(struct ieee80211_key *key)
 
 	old = key_mtx_dereference(local, sta->ptk[sta->ptk_idx]);
 	sta->ptk_idx = key->conf.keyidx;
+
+	if (ieee80211_hw_check(&local->hw, NO_AMPDU_KEYBORDER_SUPPORT))
+		clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 	ieee80211_check_fast_xmit(sta);
 
 	return 0;
 }
 
-static int ieee80211_hw_key_replace(struct ieee80211_key *old_key,
-				    struct ieee80211_key *new_key,
-				    bool pairwise)
+static void ieee80211_pairwise_rekey(struct ieee80211_key *old,
+				     struct ieee80211_key *new)
 {
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_local *local;
-	struct sta_info *sta;
-	int ret;
-
-	/* Aggregation sessions are OK when running on SW crypto.
-	 * A broken remote STA may cause issues not observed with HW
-	 * crypto, though.
-	 */
-	if (!(old_key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
-		return 0;
+	struct ieee80211_local *local = new->local;
+	struct sta_info *sta = new->sta;
+	int i;
 
-	assert_key_lock(old_key->local);
-	sta = old_key->sta;
+	assert_key_lock(local);
 
-	/* Unicast rekey without Extended Key ID needs special handling */
-	if (new_key && sta && pairwise &&
-	    rcu_access_pointer(sta->ptk[sta->ptk_idx]) == old_key) {
-		local = old_key->local;
-		sdata = old_key->sdata;
+	if (new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX) {
+		/* Extended Key ID key install, initial one or rekey */
+
+		if (sta->ptk_idx != INVALID_PTK_KEYIDX &&
+		    ieee80211_hw_check(&local->hw,
+				       NO_AMPDU_KEYBORDER_SUPPORT)) {
+			/* Aggregation Sessions with Extended Key ID must not
+			 * mix MPDUs with different keyIDs within one A-MPDU.
+			 * Tear down any running Tx aggregation and all new
+			 * Rx/Tx aggregation request during rekey if the driver
+			 * asks us to do so. (Blocking Tx only would be
+			 * sufficient but WLAN_STA_BLOCK_BA gets the job done
+			 * for the few ms we need it.)
+			 */
+			set_sta_flag(sta, WLAN_STA_BLOCK_BA);
+			mutex_lock(&sta->ampdu_mlme.mtx);
+			for (i = 0; i <  IEEE80211_NUM_TIDS; i++)
+				___ieee80211_stop_tx_ba_session(sta, i,
+								AGG_STOP_LOCAL_REQUEST);
+			mutex_unlock(&sta->ampdu_mlme.mtx);
+		}
+	} else if (old) {
+		/* Rekey without Extended Key ID.
+		 * Aggregation sessions are OK when running on SW crypto.
+		 * A broken remote STA may cause issues not observed with HW
+		 * crypto, though.
+		 */
+		if (!(old->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+			return;
 
-		/* Stop TX till we are on the new key */
-		old_key->flags |= KEY_FLAG_TAINTED;
+		/* Stop Tx till we are on the new key */
+		old->flags |= KEY_FLAG_TAINTED;
 		ieee80211_clear_fast_xmit(sta);
-
-		/* Aggregation sessions during rekey are complicated due to the
-		 * reorder buffer and retransmits. Side step that by blocking
-		 * aggregation during rekey and tear down running sessions.
-		 */
 		if (ieee80211_hw_check(&local->hw, AMPDU_AGGREGATION)) {
 			set_sta_flag(sta, WLAN_STA_BLOCK_BA);
 			ieee80211_sta_tear_down_BA_sessions(sta,
 							    AGG_STOP_LOCAL_REQUEST);
 		}
-
 		if (!wiphy_ext_feature_isset(local->hw.wiphy,
 					     NL80211_EXT_FEATURE_CAN_REPLACE_PTK0)) {
 			pr_warn_ratelimited("Rekeying PTK for STA %pM but driver can't safely do that.",
@@ -325,18 +336,9 @@ static int ieee80211_hw_key_replace(struct ieee80211_key *old_key,
 			/* Flushing the driver queues *may* help prevent
 			 * the clear text leaks and freezes.
 			 */
-			ieee80211_flush_queues(local, sdata, false);
+			ieee80211_flush_queues(local, old->sdata, false);
 		}
 	}
-
-	ieee80211_key_disable_hw_accel(old_key);
-
-	if (new_key)
-		ret = ieee80211_key_enable_hw_accel(new_key);
-	else
-		ret = 0;
-
-	return ret;
 }
 
 static void __ieee80211_set_default_key(struct ieee80211_sub_if_data *sdata,
@@ -394,7 +396,6 @@ void ieee80211_set_default_mgmt_key(struct ieee80211_sub_if_data *sdata,
 	mutex_unlock(&sdata->local->key_mtx);
 }
 
-
 static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				  struct sta_info *sta,
 				  bool pairwise,
@@ -402,7 +403,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_key *new)
 {
 	int idx;
-	int ret;
+	int ret = 0;
 	bool defunikey, defmultikey, defmgmtkey;
 
 	/* caller must provide at least one old/new */
@@ -414,16 +415,27 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 
 	WARN_ON(new && old && new->conf.keyidx != old->conf.keyidx);
 
+	if (new && sta && pairwise) {
+		/* Unicast rekey needs special handling. With Extended Key ID
+		 * old is still NULL for the first rekey.
+		 */
+		ieee80211_pairwise_rekey(old, new);
+	}
+
 	if (old) {
 		idx = old->conf.keyidx;
-		ret = ieee80211_hw_key_replace(old, new, pairwise);
+
+		if (old->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
+			ieee80211_key_disable_hw_accel(old);
+
+			if (new)
+				ret = ieee80211_key_enable_hw_accel(new);
+		}
 	} else {
 		/* new must be provided in case old is not */
 		idx = new->conf.keyidx;
 		if (!new->local->wowlan)
 			ret = ieee80211_key_enable_hw_accel(new);
-		else
-			ret = 0;
 	}
 
 	if (ret)
-- 
2.21.0

