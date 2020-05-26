Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABF71E1D5A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgEZIbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIbn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 04:31:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D66C03E97E
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 01:31:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdUzs-003JrR-77; Tue, 26 May 2020 10:31:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@cs.kuleuven.be>,
        Mathy Vanhoef <vanhoefm@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: allow SA-QUERY processing in userspace
Date:   Tue, 26 May 2020 10:31:33 +0200
Message-Id: <20200526103131.1f9cf7e5b6db.Iae5b42b09ad2b1cbcbe13492002c43f0d1d51dfc@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As discussed with Mathy almost two years ago in
http://lore.kernel.org/r/20180806224857.14853-1-Mathy.Vanhoef@cs.kuleuven.be
we should let userspace process SA-QUERY frames if it
wants to, so that it can handle OCV (operating channel
validation) which mac80211 doesn't know how to.

Evidently I had been expecting Mathy to (re)send such a
patch, but he never did, perhaps expecting me to do it
after our discussion.

In any case, this came up now with OCV getting more
attention, so move the code around as discussed there
to let userspace handle it, and do it properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 49 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index eaf8931e4627..e7e1c4b5dfe0 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3353,19 +3353,6 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			}
 		}
 		break;
-	case WLAN_CATEGORY_SA_QUERY:
-		if (len < (IEEE80211_MIN_ACTION_SIZE +
-			   sizeof(mgmt->u.action.u.sa_query)))
-			break;
-
-		switch (mgmt->u.action.u.sa_query.action) {
-		case WLAN_ACTION_SA_QUERY_REQUEST:
-			if (sdata->vif.type != NL80211_IFTYPE_STATION)
-				break;
-			ieee80211_process_sa_query_req(sdata, mgmt, len);
-			goto handled;
-		}
-		break;
 	case WLAN_CATEGORY_SELF_PROTECTED:
 		if (len < (IEEE80211_MIN_ACTION_SIZE +
 			   sizeof(mgmt->u.action.u.self_prot.action_code)))
@@ -3454,6 +3441,41 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
+static ieee80211_rx_result debug_noinline
+ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
+{
+	struct ieee80211_sub_if_data *sdata = rx->sdata;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *) rx->skb->data;
+	int len = rx->skb->len;
+
+	if (!ieee80211_is_action(mgmt->frame_control))
+		return RX_CONTINUE;
+
+	switch (mgmt->u.action.category) {
+	case WLAN_CATEGORY_SA_QUERY:
+		if (len < (IEEE80211_MIN_ACTION_SIZE +
+			   sizeof(mgmt->u.action.u.sa_query)))
+			break;
+
+		switch (mgmt->u.action.u.sa_query.action) {
+		case WLAN_ACTION_SA_QUERY_REQUEST:
+			if (sdata->vif.type != NL80211_IFTYPE_STATION)
+				break;
+			ieee80211_process_sa_query_req(sdata, mgmt, len);
+			goto handled;
+		}
+		break;
+	}
+
+	return RX_CONTINUE;
+
+ handled:
+	if (rx->sta)
+		rx->sta->rx_stats.packets++;
+	dev_kfree_skb(rx->skb);
+	return RX_QUEUED;
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 {
@@ -3734,6 +3756,7 @@ static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
 		CALL_RXH(ieee80211_rx_h_mgmt_check);
 		CALL_RXH(ieee80211_rx_h_action);
 		CALL_RXH(ieee80211_rx_h_userspace_mgmt);
+		CALL_RXH(ieee80211_rx_h_action_post_userspace);
 		CALL_RXH(ieee80211_rx_h_action_return);
 		CALL_RXH(ieee80211_rx_h_mgmt);
 
-- 
2.26.2

