Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905E8A35A2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfH3LZG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:25:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39462 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbfH3LZE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:25:04 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1a-0001lc-Dd; Fri, 30 Aug 2019 14:25:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:51 +0300
Message-Id: <20190830112451.21655-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-1-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 8/8] mac80211: IBSS: send deauth when expiring inactive STAs
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we expire an inactive station, try to send it a deauth. This
helps if it's actually still around, and just has issues with
beacon distribution (or we do), and it will not also remove us.
Then, if we have shared state, this may not be reset properly,
causing problems; for example, we saw a case where aggregation
sessions weren't removed properly (due to the TX start being
offloaded to firmware and it relying on deauth for stop), causing
a lot of traffic to get lost due to the SN reset after remove/add
of the peer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ibss.c        |  8 ++++++++
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/mlme.c        | 11 ++++++-----
 net/mac80211/util.c        |  5 +++--
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index f00dca056295..0a6ff01c68a9 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1252,6 +1252,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 
 static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta, *tmp;
 	unsigned long exp_time = IEEE80211_IBSS_INACTIVITY_LIMIT;
@@ -1268,10 +1269,17 @@ static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
 		if (time_is_before_jiffies(last_active + exp_time) ||
 		    (time_is_before_jiffies(last_active + exp_rsn) &&
 		     sta->sta_state != IEEE80211_STA_AUTHORIZED)) {
+			u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+
 			sta_dbg(sta->sdata, "expiring inactive %sSTA %pM\n",
 				sta->sta_state != IEEE80211_STA_AUTHORIZED ?
 				"not authorized " : "", sta->sta.addr);
 
+			ieee80211_send_deauth_disassoc(sdata, sta->sta.addr,
+						       ifibss->bssid,
+						       IEEE80211_STYPE_DEAUTH,
+						       WLAN_REASON_DEAUTH_LEAVING,
+						       true, frame_buf);
 			WARN_ON(__sta_info_destroy(sta));
 		}
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 791ce58d0f09..05406e9c05b3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2099,7 +2099,8 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 const u8 *da, const u8 *key, u8 key_len, u8 key_idx,
 			 u32 tx_flags);
 void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
-				    const u8 *bssid, u16 stype, u16 reason,
+				    const u8 *da, const u8 *bssid,
+				    u16 stype, u16 reason,
 				    bool send_frame, u8 *frame_buf);
 
 enum {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 31f0bae28dcc..26a2f49208b6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2278,8 +2278,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		    !ifmgd->have_beacon)
 			drv_mgd_prepare_tx(sdata->local, sdata, 0);
 
-		ieee80211_send_deauth_disassoc(sdata, ifmgd->bssid, stype,
-					       reason, tx, frame_buf);
+		ieee80211_send_deauth_disassoc(sdata, ifmgd->bssid,
+					       ifmgd->bssid, stype, reason,
+					       tx, frame_buf);
 	}
 
 	/* flush out frame - make sure the deauth was actually sent */
@@ -4509,7 +4510,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 		 * cfg80211 won't know and won't actually abort those attempts,
 		 * thus we need to do that ourselves.
 		 */
-		ieee80211_send_deauth_disassoc(sdata, bssid,
+		ieee80211_send_deauth_disassoc(sdata, bssid, bssid,
 					       IEEE80211_STYPE_DEAUTH,
 					       WLAN_REASON_DEAUTH_LEAVING,
 					       false, frame_buf);
@@ -5550,7 +5551,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
 		drv_mgd_prepare_tx(sdata->local, sdata, 0);
-		ieee80211_send_deauth_disassoc(sdata, req->bssid,
+		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
 					       IEEE80211_STYPE_DEAUTH,
 					       req->reason_code, tx,
 					       frame_buf);
@@ -5570,7 +5571,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 			   ieee80211_get_reason_code_string(req->reason_code));
 
 		drv_mgd_prepare_tx(sdata->local, sdata, 0);
-		ieee80211_send_deauth_disassoc(sdata, req->bssid,
+		ieee80211_send_deauth_disassoc(sdata, req->bssid, req->bssid,
 					       IEEE80211_STYPE_DEAUTH,
 					       req->reason_code, tx,
 					       frame_buf);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 92bfedfd3fd2..051a02ddcb85 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1583,7 +1583,8 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
-				    const u8 *bssid, u16 stype, u16 reason,
+				    const u8 *da, const u8 *bssid,
+				    u16 stype, u16 reason,
 				    bool send_frame, u8 *frame_buf)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -1594,7 +1595,7 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT | stype);
 	mgmt->duration = 0; /* initialize only */
 	mgmt->seq_ctrl = 0; /* initialize only */
-	memcpy(mgmt->da, bssid, ETH_ALEN);
+	memcpy(mgmt->da, da, ETH_ALEN);
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(mgmt->bssid, bssid, ETH_ALEN);
 	/* u.deauth.reason_code == u.disassoc.reason_code */
-- 
2.23.0.rc1

