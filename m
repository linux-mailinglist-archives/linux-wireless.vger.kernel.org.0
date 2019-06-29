Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A483D5AD33
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfF2T4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 15:56:01 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:33879 "EHLO
        13.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfF2T4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 15:56:01 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 15:56:00 EDT
Received: from player729.ha.ovh.net (unknown [10.109.143.109])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id A4C1B213340
        for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2019 21:50:45 +0200 (CEST)
Received: from awhome.eu (p579AA414.dip0.t-ipconnect.de [87.154.164.20])
        (Authenticated sender: postmaster@awhome.eu)
        by player729.ha.ovh.net (Postfix) with ESMTPSA id 3602C78ADB09;
        Sat, 29 Jun 2019 19:50:44 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1561837843;
        bh=ziWnwpILiJlRxSvGgU/6vn6690GPMtDZFkHwdseyII4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FBGKIKzhORZMhGurqkqxsvc9MoO4xIXizgSorl3yWHnjKukUKUnnO0knEaVSfWm1b
         So+/cyOwWOH5CxAY05yzsOlElJsZwLccX2Z6TfsKGM/vgJAJ8fnP4wkurxk/10dhPH
         O7e4P1uzWhtNWOndRlUTcHYczrf5XkR0mfOmcVaE=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH 3/4] mac80211: AMPDU handling for rekeys with Extended Key ID
Date:   Sat, 29 Jun 2019 21:50:14 +0200
Message-Id: <20190629195015.19680-3-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190629195015.19680-1-alexander@wetzel-home.de>
References: <20190629195015.19680-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13913026626545261767
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddvgddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extended Key ID allows A-MPDU sessions while rekeying as long as each
A-MPDU aggregates only MPDUs with one keyid together.

Drivers able to segregate MPDUs accordingly can tell mac80211 to not
stop A-MPDU sessions when rekeying by setting the new flag
IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 include/net/mac80211.h |  5 +++++
 net/mac80211/debugfs.c |  1 +
 net/mac80211/key.c     | 14 ++++++++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 544dad54b11f..1d6bb67ecb47 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2268,6 +2268,10 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID: Hardware supports multi BSSID
  *	only for HE APs. Applies if @IEEE80211_HW_SUPPORTS_MULTI_BSSID is set.
  *
+ * @IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT: The card and driver is only
+ *	aggregating MPDUs with the same keyid, allowing mac80211 to keep Tx
+ *	A-MPDU sessions active while rekeying with Extended Key ID.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2319,6 +2323,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_TX_STATUS_NO_AMPDU_LEN,
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
+	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 47435f57e086..568b3b276931 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -271,6 +271,7 @@ static const char *hw_flag_names[] = {
 	FLAG(TX_STATUS_NO_AMPDU_LEN),
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
+	FLAG(AMPDU_KEYBORDER_SUPPORT),
 #undef FLAG
 };
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 92c3affb0eb0..7dfee848abac 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -270,7 +270,8 @@ int ieee80211_set_tx_key(struct ieee80211_key *key)
 
 	sta->ptk_idx = key->conf.keyidx;
 
-	clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
+	if (!ieee80211_hw_check(&local->hw, AMPDU_KEYBORDER_SUPPORT))
+		clear_sta_flag(sta, WLAN_STA_BLOCK_BA);
 	ieee80211_check_fast_xmit(sta);
 
 	return 0;
@@ -288,15 +289,16 @@ static void ieee80211_pairwise_rekey(struct ieee80211_key *old,
 	if (new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX) {
 		/* Extended Key ID key install, initial one or rekey */
 
-		if (sta->ptk_idx != INVALID_PTK_KEYIDX) {
+		if (sta->ptk_idx != INVALID_PTK_KEYIDX &&
+		    !ieee80211_hw_check(&local->hw, AMPDU_KEYBORDER_SUPPORT)) {
 			/* Aggregation Sessions with Extended Key ID must not
 			 * mix MPDUs with different keyIDs within one A-MPDU.
 			 * Tear down running Tx aggregation sessions and block
 			 * new Rx/Tx aggregation requests during rekey to
-			 * ensure there are no A-MPDUs for the driver to
-			 * aggregate. (Blocking Tx only would be sufficient but
-			 * WLAN_STA_BLOCK_BA gets the job done for the few ms
-			 * we need it.)
+			 * ensure there are no A-MPDUs when the driver is not
+			 * supporting A-MPDU key borders. (Blocking Tx only
+			 * would be sufficient but WLAN_STA_BLOCK_BA gets the
+			 * job done for the few ms we need it.)
 			 */
 			set_sta_flag(sta, WLAN_STA_BLOCK_BA);
 			mutex_lock(&sta->ampdu_mlme.mtx);
-- 
2.22.0

