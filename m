Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891035AD57
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF2U0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 16:26:50 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:50104 "EHLO
        17.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF2U0u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 16:26:50 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 16:26:48 EDT
Received: from player696.ha.ovh.net (unknown [10.108.42.73])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id F31B1124513
        for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2019 21:50:42 +0200 (CEST)
Received: from awhome.eu (p579AA414.dip0.t-ipconnect.de [87.154.164.20])
        (Authenticated sender: postmaster@awhome.eu)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 897D27786D7B;
        Sat, 29 Jun 2019 19:50:41 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1561837840;
        bh=0hooap22niWqXm5dtFBu6mVP9DPpvYALdmBeud+L4ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TQj1iP46Eb5pAjFixL4I6oj+Gb29QfhqvD29suwa2JO7w4nx2IeVDcz6v1/0OPMZp
         jjAJlA6iS2Xt9t/Swm4oDufdo+vyOghJtXjnsKTcG14t7scVdk5MVMNOZewvzb4nMP
         ExLFbEBn4D6lV0v+5BpLRPnnxU5yyfiA2eI1pDsw=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH 2/4] mac80211: Simplify Extended Key ID API
Date:   Sat, 29 Jun 2019 21:50:13 +0200
Message-Id: <20190629195015.19680-2-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190629195015.19680-1-alexander@wetzel-home.de>
References: <20190629195015.19680-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13912182200271248583
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddvgddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1) Drop IEEE80211_HW_EXT_KEY_ID_NATIVE and let drivers directly set
   the NL80211_EXT_FEATURE_EXT_KEY_ID flag.

2) Drop IEEE80211_HW_NO_AMPDU_KEYBORDER_SUPPORT and simply assume all
   drivers are unable to handle A-MPDU key borders.

The new Extended Key ID API now requires all mac80211 drivers to set
NL80211_EXT_FEATURE_EXT_KEY_ID when they implement set_key() and can
handle Extended Key ID. For drivers not providing set_key() mac80211
itself enables Extended Key ID support, using the internal SW crypto
services.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
Deciding to not merge the COMPAT Extended Key ID support also
invalidated the reasoning to have IEEE80211_HW_EXT_KEY_ID_NATIVE in the
first place. We can simple drop the flag and ask drivers to directly
set NL80211_EXT_FEATURE_EXT_KEY_ID with the current code.

IEEE80211_HW_NO_AMPDU_KEYBORDER_SUPPORT was intended to tell mac80211
that the driver is not checking the keyid when aggregating frames and is
only compatible with the IEEE 802.11 - 2016 standard when there are no
aggregation sessions running during rekey. But reverting the logic makes
more sense, the only driver able to set it for the foreseeable future is
hwsim. And for hwsim it's irrelevant if we stop A-MPDU or not, the
driver is never really aggregating frames.

Now it probably makes sense to not yet implement AMPDU_KEYBORDER_SUPPORT
and wait to see if we really have a need for that. So this patch stops
A-MPDU sessions every time when we rekey with Extended Key ID and is not
providing a API to the driver to prevent that.

But the next patch in the series is implementing the feature, allowing
you to merge it and have the API available today or simply skip it.

 include/net/mac80211.h |  8 --------
 net/mac80211/debugfs.c |  2 --
 net/mac80211/key.c     | 18 ++++++++----------
 net/mac80211/main.c    | 18 ++++++------------
 4 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da013f7c0..544dad54b11f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2268,12 +2268,6 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID: Hardware supports multi BSSID
  *	only for HE APs. Applies if @IEEE80211_HW_SUPPORTS_MULTI_BSSID is set.
  *
- * @IEEE80211_HW_EXT_KEY_ID_NATIVE: Driver and hardware are supporting Extended
- *	Key ID and can handle two unicast keys per station for Rx and Tx.
- *
- * @IEEE80211_HW_NO_AMPDU_KEYBORDER_SUPPORT: The card/driver can't handle
- *	active Tx A-MPDU sessions with Extended Key IDs during rekey.
- *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2325,8 +2319,6 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_TX_STATUS_NO_AMPDU_LEN,
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
-	IEEE80211_HW_EXT_KEY_ID_NATIVE,
-	IEEE80211_HW_NO_AMPDU_KEYBORDER_SUPPORT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2e7f75938c51..47435f57e086 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -271,8 +271,6 @@ static const char *hw_flag_names[] = {
 	FLAG(TX_STATUS_NO_AMPDU_LEN),
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
-	FLAG(EXT_KEY_ID_NATIVE),
-	FLAG(NO_AMPDU_KEYBORDER_SUPPORT),
 #undef FLAG
 };
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index dd60f6428049..92c3affb0eb0 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -270,8 +270,7 @@ int ieee80211_set_tx_key(struct ieee80211_key *key)
 
 	sta->ptk_idx = key->conf.keyidx;
 
-	if (ieee80211_hw_check(&local->hw, NO_AMPDU_KEYBORDER_SUPPORT))
-		clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
+	clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 	ieee80211_check_fast_xmit(sta);
 
 	return 0;
@@ -289,16 +288,15 @@ static void ieee80211_pairwise_rekey(struct ieee80211_key *old,
 	if (new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX) {
 		/* Extended Key ID key install, initial one or rekey */
 
-		if (sta->ptk_idx != INVALID_PTK_KEYIDX &&
-		    ieee80211_hw_check(&local->hw,
-				       NO_AMPDU_KEYBORDER_SUPPORT)) {
+		if (sta->ptk_idx != INVALID_PTK_KEYIDX) {
 			/* Aggregation Sessions with Extended Key ID must not
 			 * mix MPDUs with different keyIDs within one A-MPDU.
-			 * Tear down any running Tx aggregation and all new
-			 * Rx/Tx aggregation request during rekey if the driver
-			 * asks us to do so. (Blocking Tx only would be
-			 * sufficient but WLAN_STA_BLOCK_BA gets the job done
-			 * for the few ms we need it.)
+			 * Tear down running Tx aggregation sessions and block
+			 * new Rx/Tx aggregation requests during rekey to
+			 * ensure there are no A-MPDUs for the driver to
+			 * aggregate. (Blocking Tx only would be sufficient but
+			 * WLAN_STA_BLOCK_BA gets the job done for the few ms
+			 * we need it.)
 			 */
 			set_sta_flag(sta, WLAN_STA_BLOCK_BA);
 			mutex_lock(&sta->ampdu_mlme.mtx);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 85e416248753..3b8eb5d2ec7e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1048,21 +1048,15 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		}
 	}
 
-	/* Enable Extended Key IDs when driver allowed it, or when it
-	 * supports neither HW crypto nor A-MPDUs
+	/* Mac80211 and therefore all drivers using SW crypto only
+	 * are able to handle PTK rekeys and Extended Key ID.
 	 */
-	if ((!local->ops->set_key &&
-	     !ieee80211_hw_check(hw, AMPDU_AGGREGATION)) ||
-	    ieee80211_hw_check(&local->hw, EXT_KEY_ID_NATIVE))
-		wiphy_ext_feature_set(local->hw.wiphy,
-				      NL80211_EXT_FEATURE_EXT_KEY_ID);
-
-	/* Mac80211 and therefore all cards only using SW crypto are able to
-	 * handle PTK rekeys correctly
-	 */
-	if (!local->ops->set_key)
+	if (!local->ops->set_key) {
 		wiphy_ext_feature_set(local->hw.wiphy,
 				      NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+		wiphy_ext_feature_set(local->hw.wiphy,
+				      NL80211_EXT_FEATURE_EXT_KEY_ID);
+	}
 
 	/*
 	 * Calculate scan IE length -- we need this to alloc
-- 
2.22.0

