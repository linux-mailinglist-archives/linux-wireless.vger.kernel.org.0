Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87314F57D7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfKHTm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:27 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46180 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbfKHTm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:27 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0814D13C341;
        Fri,  8 Nov 2019 11:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0814D13C341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242146;
        bh=nMvOiyU6DVG4vf3tcRO2C0Qbh2qxXH2+8qH6tp443h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noqZem4JUmVWxLt9cyL+pt4F9Cj5Axa/OrfeqqrLXWByyhE/PIrD0cwHXR0KgnPb0
         M5BsFAIkHPRMZ6tG7nouDnLd0ozMakAO00Ty5ZI5S1m2uK7Bw8lG348OSNlFw/xLw7
         0U27b0sf1Vs4/2Lz8AcKMEp5ywXOyCP+ORhm2kHM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 05/10] mac80211: Improve connection-loss probing.
Date:   Fri,  8 Nov 2019 11:42:06 -0800
Message-Id: <20191108194210.23618-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This makes the mlme code probe multiple times spread out across
the time-out period instead of lots of probes all at once.

It also makes the ap-probe and the nullfunc probe logic
act similarly, which allows us to remove some code.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debug.h       |  3 ++
 net/mac80211/ieee80211_i.h |  1 -
 net/mac80211/mlme.c        | 64 +++++++++++++++-----------------------
 3 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/net/mac80211/debug.h b/net/mac80211/debug.h
index d90a8f9cc3fd..6182608cd20f 100644
--- a/net/mac80211/debug.h
+++ b/net/mac80211/debug.h
@@ -194,6 +194,9 @@ do {									\
 	_sdata_dbg(MAC80211_MLME_DEBUG,					\
 		   sdata, fmt, ##__VA_ARGS__)
 
+#define mlme_wrn(sdata, fmt, ...)					\
+	_sdata_err(sdata, fmt, ##__VA_ARGS__)
+
 #define mlme_dbg_ratelimited(sdata, fmt, ...)				\
 	_sdata_dbg(MAC80211_MLME_DEBUG && net_ratelimit(),		\
 		   sdata, fmt, ##__VA_ARGS__)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5594ab80d9c1..46bc9d3df591 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -444,7 +444,6 @@ struct ieee80211_if_managed {
 	unsigned long beacon_timeout;
 	unsigned long probe_timeout;
 	int probe_send_count;
-	bool nullfunc_failed;
 	bool connection_loss;
 
 	struct cfg80211_bss *associated;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 54dd8849d1cc..6a458aac331d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2464,8 +2464,6 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 	    sdata->u.mgd.probe_send_count > 0) {
 		if (ack)
 			ieee80211_sta_reset_conn_monitor(sdata);
-		else
-			sdata->u.mgd.nullfunc_failed = true;
 		ieee80211_queue_work(&sdata->local->hw, &sdata->work);
 		return;
 	}
@@ -2495,6 +2493,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	u8 *dst = ifmgd->associated->bssid;
 	u8 unicast_limit = max(1, max_probe_tries - 3);
 	struct sta_info *sta;
+	u32 max_tries;
 
 	/*
 	 * Try sending broadcast probe requests for the last three
@@ -2522,7 +2521,7 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	}
 
 	if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
-		ifmgd->nullfunc_failed = false;
+		max_tries = max_nullfunc_tries;
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 			ifmgd->probe_send_count--;
 		else
@@ -2530,6 +2529,8 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 	} else {
 		int ssid_len;
 
+		max_tries = max_probe_tries;
+
 		rcu_read_lock();
 		ssid = ieee80211_bss_get_ie(ifmgd->associated, WLAN_EID_SSID);
 		if (WARN_ON_ONCE(ssid == NULL))
@@ -2543,7 +2544,8 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		rcu_read_unlock();
 	}
 
-	ifmgd->probe_timeout = jiffies + msecs_to_jiffies(probe_wait_ms);
+	ifmgd->probe_timeout = jiffies +
+		msecs_to_jiffies(probe_wait_ms / max_tries);
 	run_again(sdata, ifmgd->probe_timeout);
 }
 
@@ -4388,54 +4390,38 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 	    ifmgd->associated) {
 		u8 bssid[ETH_ALEN];
 		int max_tries;
+		bool ack_status = ieee80211_hw_check(&local->hw,
+						     REPORTS_TX_ACK_STATUS);
 
 		memcpy(bssid, ifmgd->associated->bssid, ETH_ALEN);
 
-		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
+		if (ack_status)
 			max_tries = max_nullfunc_tries;
 		else
 			max_tries = max_probe_tries;
 
 		/* ACK received for nullfunc probing frame */
-		if (!ifmgd->probe_send_count)
+		if (!ifmgd->probe_send_count) {
+			/* probe_send_count of zero means probe succeeded */
 			ieee80211_reset_ap_probe(sdata);
-		else if (ifmgd->nullfunc_failed) {
-			if (ifmgd->probe_send_count < max_tries) {
-				mlme_dbg(sdata,
-					 "No ack for nullfunc frame to AP %pM, try %d/%i\n",
-					 bssid, ifmgd->probe_send_count,
-					 max_tries);
-				ieee80211_mgd_probe_ap_send(sdata);
-			} else {
-				mlme_dbg(sdata,
-					 "No ack for nullfunc frame to AP %pM, disconnecting.\n",
-					 bssid);
-				ieee80211_sta_connection_lost(sdata, bssid,
-					WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-					false);
-			}
-		} else if (time_is_after_jiffies(ifmgd->probe_timeout))
+		} else if (time_is_after_jiffies(ifmgd->probe_timeout)) {
+			/* probe_timeout is after current jiffies
+			 * Not time to (re)probe yet
+			 */
 			run_again(sdata, ifmgd->probe_timeout);
-		else if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
-			mlme_dbg(sdata,
-				 "Failed to send nullfunc to AP %pM after %dms, disconnecting\n",
-				 bssid, probe_wait_ms);
-			ieee80211_sta_connection_lost(sdata, bssid,
-				WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY, false);
 		} else if (ifmgd->probe_send_count < max_tries) {
-			mlme_dbg(sdata,
-				 "No probe response from AP %pM after %dms, try %d/%i\n",
-				 bssid, probe_wait_ms,
-				 ifmgd->probe_send_count, max_tries);
+			mlme_dbg(sdata, "No %s AP %pM, try %d/%i\n",
+				 ack_status ? "ack for nullfunc frame to" :
+				 "probe response from",
+				 bssid, ifmgd->probe_send_count, max_tries);
 			ieee80211_mgd_probe_ap_send(sdata);
 		} else {
-			/*
-			 * We actually lost the connection ... or did we?
-			 * Let's make sure!
-			 */
-			mlme_dbg(sdata,
-				 "No probe response from AP %pM after %dms, disconnecting.\n",
-				 bssid, probe_wait_ms);
+			mlme_wrn(sdata,
+				 "No %s AP %pM after %dms, tried %d/%i, disconnecting.\n",
+				 ack_status ? "ack for nullfunc frame to" :
+				 "probe response from",
+				  bssid, probe_wait_ms, ifmgd->probe_send_count,
+				  max_tries);
 
 			ieee80211_sta_connection_lost(sdata, bssid,
 				WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY, false);
-- 
2.20.1

