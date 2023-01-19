Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D298673AA5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjASNqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 08:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjASNp6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 08:45:58 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E217D679
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 05:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=9pidkYOR6eZGlHtAUkDroEu6qntQmTVnXMCQjlSMT44=; t=1674135956; x=1675345556; 
        b=W4edYlhyUEsWJ6+npmWduq7jH1sniEvKhaaV8HjrPDjxsKsT4zyacfZPwK3j7WV5lp2MzgB+yKG
        wwZ9zvlPrGbJkxXViDjP0gNKCz9R71ltsSmPYp4H/lAnAL1D32SxmBj604Ml51EJMxXaTjM5avQqL
        z2R3vm0M4znsFfJHTQgI9PMG+fMzgNS3jw5SNluF1/CzQWXFh0OE4JLtMXeSyg455ce+bLk593aSG
        jt+X0UewvnW/VIHADg6NFlBlhfpWOqCgtrnUAQZy/mpsMtofLqd6Sy3HTIklUAFZ1hCGGLpxlBE4F
        tOPBTw2p/A9Sjz3zKttMjow0WqSyzxgU63zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIVEj-006Wpz-1O;
        Thu, 19 Jan 2023 14:45:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: trace: remove MAC_PR_{FMT,ARG}
Date:   Thu, 19 Jan 2023 14:45:47 +0100
Message-Id: <20230119144546.af50c5c842f4.I999a6736866cd23668c32d9856ae0bca2cb9f875@changeid>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

With %pM, this really is no longer needed, and actually
longer to spell out. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/trace.h | 244 +++++++++++++++++++++----------------------
 1 file changed, 120 insertions(+), 124 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47..9660fd94cd92 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -19,8 +19,6 @@
 	else							     \
 		eth_zero_addr(__entry->entry_mac);		     \
 	} while (0)
-#define MAC_PR_FMT "%pM"
-#define MAC_PR_ARG(entry_mac) (__entry->entry_mac)
 
 #define MAXNAME		32
 #define WIPHY_ENTRY	__array(char, wiphy_name, 32)
@@ -454,10 +452,10 @@ DECLARE_EVENT_CLASS(key_handle,
 		__entry->pairwise = pairwise;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
-		  "key_index: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
+		  "key_index: %u, pairwise: %s, mac addr: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
 		  __entry->key_index, BOOL_TO_STR(__entry->pairwise),
-		  MAC_PR_ARG(mac_addr))
+		  __entry->mac_addr)
 );
 
 DEFINE_EVENT(key_handle, rdev_get_key,
@@ -496,10 +494,10 @@ TRACE_EVENT(rdev_add_key,
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
 		  "key_index: %u, mode: %u, pairwise: %s, "
-		  "mac addr: " MAC_PR_FMT,
+		  "mac addr: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
 		  __entry->key_index, __entry->mode,
-		  BOOL_TO_STR(__entry->pairwise), MAC_PR_ARG(mac_addr))
+		  BOOL_TO_STR(__entry->pairwise), __entry->mac_addr)
 );
 
 TRACE_EVENT(rdev_set_default_key,
@@ -813,11 +811,11 @@ DECLARE_EVENT_CLASS(station_add_change,
 		__entry->opmode_notif_used =
 			params->link_sta_params.opmode_notif_used;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
 		  ", station flags mask: %u, station flags set: %u, "
 		  "station modify mask: %u, listen interval: %d, aid: %u, "
 		  "plink action: %u, plink state: %u, uapsd queues: %u, vlan:%s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(sta_mac),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
 		  __entry->sta_flags_mask, __entry->sta_flags_set,
 		  __entry->sta_modify_mask, __entry->listen_interval,
 		  __entry->aid, __entry->plink_action, __entry->plink_state,
@@ -849,8 +847,8 @@ DECLARE_EVENT_CLASS(wiphy_netdev_mac_evt,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(sta_mac, mac);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mac: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(sta_mac))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", mac: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac)
 );
 
 DECLARE_EVENT_CLASS(station_del,
@@ -871,9 +869,9 @@ DECLARE_EVENT_CLASS(station_del,
 		__entry->subtype = params->subtype;
 		__entry->reason_code = params->reason_code;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
 		  ", subtype: %u, reason_code: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(sta_mac),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
 		  __entry->subtype, __entry->reason_code)
 );
 
@@ -909,8 +907,8 @@ TRACE_EVENT(rdev_dump_station,
 		MAC_ASSIGN(sta_mac, mac);
 		__entry->idx = _idx;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT ", idx: %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(sta_mac),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM, idx: %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
 		  __entry->idx)
 );
 
@@ -947,9 +945,9 @@ DECLARE_EVENT_CLASS(mpath_evt,
 		MAC_ASSIGN(dst, dst);
 		MAC_ASSIGN(next_hop, next_hop);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", destination: " MAC_PR_FMT ", next hop: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dst),
-		  MAC_PR_ARG(next_hop))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", destination: %pM, next hop: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dst,
+		  __entry->next_hop)
 );
 
 DEFINE_EVENT(mpath_evt, rdev_add_mpath,
@@ -988,10 +986,9 @@ TRACE_EVENT(rdev_dump_mpath,
 		MAC_ASSIGN(next_hop, next_hop);
 		__entry->idx = _idx;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", index: %d, destination: "
-		  MAC_PR_FMT ", next hop: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->idx, MAC_PR_ARG(dst),
-		  MAC_PR_ARG(next_hop))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", index: %d, destination: %pM, next hop: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->idx, __entry->dst,
+		  __entry->next_hop)
 );
 
 TRACE_EVENT(rdev_get_mpp,
@@ -1010,9 +1007,9 @@ TRACE_EVENT(rdev_get_mpp,
 		MAC_ASSIGN(dst, dst);
 		MAC_ASSIGN(mpp, mpp);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", destination: " MAC_PR_FMT
-		  ", mpp: " MAC_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  MAC_PR_ARG(dst), MAC_PR_ARG(mpp))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", destination: %pM"
+		  ", mpp: %pM", WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  __entry->dst, __entry->mpp)
 );
 
 TRACE_EVENT(rdev_dump_mpp,
@@ -1033,10 +1030,9 @@ TRACE_EVENT(rdev_dump_mpp,
 		MAC_ASSIGN(mpp, mpp);
 		__entry->idx = _idx;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", index: %d, destination: "
-		  MAC_PR_FMT ", mpp: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->idx, MAC_PR_ARG(dst),
-		  MAC_PR_ARG(mpp))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", index: %d, destination: %pM, mpp: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->idx, __entry->dst,
+		  __entry->mpp)
 );
 
 TRACE_EVENT(rdev_return_int_mpath_info,
@@ -1243,9 +1239,9 @@ TRACE_EVENT(rdev_auth,
 			eth_zero_addr(__entry->bssid);
 		__entry->auth_type = req->auth_type;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", auth type: %d, bssid: " MAC_PR_FMT,
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", auth type: %d, bssid: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->auth_type,
-		  MAC_PR_ARG(bssid))
+		  __entry->bssid)
 );
 
 TRACE_EVENT(rdev_assoc,
@@ -1294,10 +1290,10 @@ TRACE_EVENT(rdev_assoc,
 			memcpy(__get_dynamic_array(fils_nonces),
 			       req->fils_nonces, 2 * FILS_NONCE_LEN);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT
-		  ", previous bssid: " MAC_PR_FMT ", use mfp: %s, flags: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(bssid),
-		  MAC_PR_ARG(prev_bssid), BOOL_TO_STR(__entry->use_mfp),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
+		  ", previous bssid: %pM, use mfp: %s, flags: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
+		  __entry->prev_bssid, BOOL_TO_STR(__entry->use_mfp),
 		  __entry->flags)
 );
 
@@ -1317,8 +1313,8 @@ TRACE_EVENT(rdev_deauth,
 		MAC_ASSIGN(bssid, req->bssid);
 		__entry->reason_code = req->reason_code;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT ", reason: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(bssid),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM, reason: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
 		  __entry->reason_code)
 );
 
@@ -1340,9 +1336,9 @@ TRACE_EVENT(rdev_disassoc,
 		__entry->reason_code = req->reason_code;
 		__entry->local_state_change = req->local_state_change;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		  ", reason: %u, local state change: %s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(bssid),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
 		  __entry->reason_code,
 		  BOOL_TO_STR(__entry->local_state_change))
 );
@@ -1413,12 +1409,12 @@ TRACE_EVENT(rdev_connect,
 		__entry->flags = sme->flags;
 		MAC_ASSIGN(prev_bssid, sme->prev_bssid);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		  ", ssid: %s, auth type: %d, privacy: %s, wpa versions: %u, "
-		  "flags: %u, previous bssid: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(bssid), __entry->ssid,
+		  "flags: %u, previous bssid: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid, __entry->ssid,
 		  __entry->auth_type, BOOL_TO_STR(__entry->privacy),
-		  __entry->wpa_versions, __entry->flags, MAC_PR_ARG(prev_bssid))
+		  __entry->wpa_versions, __entry->flags, __entry->prev_bssid)
 );
 
 TRACE_EVENT(rdev_update_connect_params,
@@ -1542,8 +1538,8 @@ TRACE_EVENT(rdev_join_ibss,
 		memset(__entry->ssid, 0, IEEE80211_MAX_SSID_LEN + 1);
 		memcpy(__entry->ssid, params->ssid, params->ssid_len);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT ", ssid: %s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(bssid), __entry->ssid)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM, ssid: %s",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid, __entry->ssid)
 );
 
 TRACE_EVENT(rdev_join_ocb,
@@ -1664,9 +1660,9 @@ TRACE_EVENT(rdev_set_bitrate_mask,
 		__entry->link_id = link_id;
 		MAC_ASSIGN(peer, peer);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, peer: " MAC_PR_FMT,
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, peer: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
-		  MAC_PR_ARG(peer))
+		  __entry->peer)
 );
 
 TRACE_EVENT(rdev_update_mgmt_frame_registrations,
@@ -1810,10 +1806,10 @@ TRACE_EVENT(rdev_tdls_mgmt,
 		__entry->initiator = initiator;
 		memcpy(__get_dynamic_array(buf), buf, len);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ", action_code: %u, "
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM, action_code: %u, "
 		  "dialog_token: %u, status_code: %u, peer_capability: %u "
 		  "initiator: %s buf: %#.2x ",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer,
 		  __entry->action_code, __entry->dialog_token,
 		  __entry->status_code, __entry->peer_capability,
 		  BOOL_TO_STR(__entry->initiator),
@@ -1893,8 +1889,8 @@ TRACE_EVENT(rdev_tdls_oper,
 		MAC_ASSIGN(peer, peer);
 		__entry->oper = oper;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ", oper: %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->oper)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM, oper: %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer, __entry->oper)
 );
 
 DECLARE_EVENT_CLASS(rdev_pmksa,
@@ -1911,8 +1907,8 @@ DECLARE_EVENT_CLASS(rdev_pmksa,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(bssid, pmksa->bssid);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(bssid))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid)
 );
 
 TRACE_EVENT(rdev_probe_client,
@@ -1929,8 +1925,8 @@ TRACE_EVENT(rdev_probe_client,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(peer, peer);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer)
 );
 
 DEFINE_EVENT(rdev_pmksa, rdev_set_pmksa,
@@ -2051,9 +2047,9 @@ TRACE_EVENT(rdev_tx_control_port,
 		__entry->unencrypted = unencrypted;
 		__entry->link_id = link_id;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ","
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM,"
 		  " proto: 0x%x, unencrypted: %s, link: %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dest,
 		  be16_to_cpu(__entry->proto),
 		  BOOL_TO_STR(__entry->unencrypted),
 		  __entry->link_id)
@@ -2392,8 +2388,8 @@ TRACE_EVENT(rdev_add_tx_ts,
 		__entry->user_prio = user_prio;
 		__entry->admitted_time = admitted_time;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ", TSID %d, UP %d, time %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM, TSID %d, UP %d, time %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer,
 		  __entry->tsid, __entry->user_prio, __entry->admitted_time)
 );
 
@@ -2413,8 +2409,8 @@ TRACE_EVENT(rdev_del_tx_ts,
 		MAC_ASSIGN(peer, peer);
 		__entry->tsid = tsid;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ", TSID %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->tsid)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM, TSID %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer, __entry->tsid)
 );
 
 TRACE_EVENT(rdev_tdls_channel_switch,
@@ -2435,9 +2431,9 @@ TRACE_EVENT(rdev_tdls_channel_switch,
 		MAC_ASSIGN(addr, addr);
 		CHAN_DEF_ASSIGN(chandef);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM"
 		  " oper class %d, " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(addr),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->addr,
 		  __entry->oper_class, CHAN_DEF_PR_ARG)
 );
 
@@ -2455,8 +2451,8 @@ TRACE_EVENT(rdev_tdls_cancel_channel_switch,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(addr, addr);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(addr))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->addr)
 );
 
 TRACE_EVENT(rdev_set_pmk,
@@ -2488,9 +2484,9 @@ TRACE_EVENT(rdev_set_pmk,
 		       pmk_conf->pmk_r0_name ? WLAN_PMK_NAME_LEN : 0);
 	),
 
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM"
 		  "pmk_len=%u, pmk: %s pmk_r0_name: %s", WIPHY_PR_ARG,
-		  NETDEV_PR_ARG, MAC_PR_ARG(aa), __entry->pmk_len,
+		  NETDEV_PR_ARG, __entry->aa, __entry->pmk_len,
 		  __print_array(__get_dynamic_array(pmk),
 				__get_dynamic_array_len(pmk), 1),
 		  __entry->pmk_r0_name_len ?
@@ -2515,8 +2511,8 @@ TRACE_EVENT(rdev_del_pmk,
 		MAC_ASSIGN(aa, aa);
 	),
 
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(aa))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->aa)
 );
 
 TRACE_EVENT(rdev_external_auth,
@@ -2537,7 +2533,7 @@ TRACE_EVENT(rdev_external_auth,
 				  params->ssid.ssid_len);
 			   __entry->status = params->status;
 	    ),
-	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: " MAC_PR_FMT
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		      ", ssid: %s, status: %u", WIPHY_PR_ARG, NETDEV_PR_ARG,
 		      __entry->bssid, __entry->ssid, __entry->status)
 );
@@ -2720,8 +2716,8 @@ TRACE_EVENT(rdev_update_owe_info,
 			   __entry->status = owe_info->status;
 			   memcpy(__get_dynamic_array(ie),
 				  owe_info->ie, owe_info->ie_len);),
-	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT
-		  " status %d", WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer),
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: %pM"
+		  " status %d", WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer,
 		  __entry->status)
 );
 
@@ -2739,8 +2735,8 @@ TRACE_EVENT(rdev_probe_mesh_link,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(dest, dest);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dest)
 );
 
 TRACE_EVENT(rdev_set_tid_config,
@@ -2757,8 +2753,8 @@ TRACE_EVENT(rdev_set_tid_config,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(peer, tid_conf->peer);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer)
 );
 
 TRACE_EVENT(rdev_reset_tid_config,
@@ -2777,8 +2773,8 @@ TRACE_EVENT(rdev_reset_tid_config,
 		MAC_ASSIGN(peer, peer);
 		__entry->tids = tids;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", tids: 0x%x",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->tids)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: %pM, tids: 0x%x",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer, __entry->tids)
 );
 
 TRACE_EVENT(rdev_set_sar_specs,
@@ -2881,8 +2877,8 @@ DECLARE_EVENT_CLASS(cfg80211_netdev_mac_evt,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(macaddr, macaddr);
 	),
-	TP_printk(NETDEV_PR_FMT ", mac: " MAC_PR_FMT,
-		  NETDEV_PR_ARG, MAC_PR_ARG(macaddr))
+	TP_printk(NETDEV_PR_FMT ", mac: %pM",
+		  NETDEV_PR_ARG, __entry->macaddr)
 );
 
 DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_notify_new_peer_candidate,
@@ -2920,8 +2916,8 @@ TRACE_EVENT(cfg80211_send_rx_assoc,
 		MAC_ASSIGN(ap_addr,
 			   data->ap_mld_addr ?: data->links[0].bss->bssid);
 	),
-	TP_printk(NETDEV_PR_FMT ", " MAC_PR_FMT,
-		  NETDEV_PR_ARG, MAC_PR_ARG(ap_addr))
+	TP_printk(NETDEV_PR_FMT ", %pM",
+		  NETDEV_PR_ARG, __entry->ap_addr)
 );
 
 DECLARE_EVENT_CLASS(netdev_frame_event,
@@ -2981,8 +2977,8 @@ DECLARE_EVENT_CLASS(netdev_mac_evt,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(mac, mac)
 	),
-	TP_printk(NETDEV_PR_FMT ", mac: " MAC_PR_FMT,
-		  NETDEV_PR_ARG, MAC_PR_ARG(mac))
+	TP_printk(NETDEV_PR_FMT ", mac: %pM",
+		  NETDEV_PR_ARG, __entry->mac)
 );
 
 DEFINE_EVENT(netdev_mac_evt, cfg80211_send_auth_timeout,
@@ -3004,8 +3000,8 @@ TRACE_EVENT(cfg80211_send_assoc_failure,
 		MAC_ASSIGN(ap_addr, data->ap_mld_addr ?: data->bss[0]->bssid);
 		__entry->timeout = data->timeout;
 	),
-	TP_printk(NETDEV_PR_FMT ", mac: " MAC_PR_FMT ", timeout: %d",
-		  NETDEV_PR_ARG, MAC_PR_ARG(ap_addr), __entry->timeout)
+	TP_printk(NETDEV_PR_FMT ", mac: %pM, timeout: %d",
+		  NETDEV_PR_ARG, __entry->ap_addr, __entry->timeout)
 );
 
 TRACE_EVENT(cfg80211_michael_mic_failure,
@@ -3027,8 +3023,8 @@ TRACE_EVENT(cfg80211_michael_mic_failure,
 		if (tsc)
 			memcpy(__entry->tsc, tsc, 6);
 	),
-	TP_printk(NETDEV_PR_FMT ", " MAC_PR_FMT ", key type: %d, key id: %d, tsc: %pm",
-		  NETDEV_PR_ARG, MAC_PR_ARG(addr), __entry->key_type,
+	TP_printk(NETDEV_PR_FMT ", %pM, key type: %d, key id: %d, tsc: %pm",
+		  NETDEV_PR_ARG, __entry->addr, __entry->key_type,
 		  __entry->key_id, __entry->tsc)
 );
 
@@ -3104,8 +3100,8 @@ TRACE_EVENT(cfg80211_new_sta,
 		MAC_ASSIGN(mac_addr, mac_addr);
 		SINFO_ASSIGN;
 	),
-	TP_printk(NETDEV_PR_FMT ", " MAC_PR_FMT,
-		  NETDEV_PR_ARG, MAC_PR_ARG(mac_addr))
+	TP_printk(NETDEV_PR_FMT ", %pM",
+		  NETDEV_PR_ARG, __entry->mac_addr)
 );
 
 DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_del_sta,
@@ -3182,8 +3178,8 @@ TRACE_EVENT(cfg80211_rx_control_port,
 		__entry->proto = be16_to_cpu(skb->protocol);
 		__entry->unencrypted = unencrypted;
 	),
-	TP_printk(NETDEV_PR_FMT ", len=%d, " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
-		  NETDEV_PR_ARG, __entry->len, MAC_PR_ARG(from),
+	TP_printk(NETDEV_PR_FMT ", len=%d, %pM, proto: 0x%x, unencrypted: %s",
+		  NETDEV_PR_ARG, __entry->len, __entry->from,
 		  __entry->proto, BOOL_TO_STR(__entry->unencrypted))
 );
 
@@ -3324,7 +3320,7 @@ DECLARE_EVENT_CLASS(cfg80211_rx_evt,
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(addr, addr);
 	),
-	TP_printk(NETDEV_PR_FMT ", " MAC_PR_FMT, NETDEV_PR_ARG, MAC_PR_ARG(addr))
+	TP_printk(NETDEV_PR_FMT ", %pM", NETDEV_PR_ARG, __entry->addr)
 );
 
 DEFINE_EVENT(cfg80211_rx_evt, cfg80211_rx_spurious_frame,
@@ -3351,8 +3347,8 @@ TRACE_EVENT(cfg80211_ibss_joined,
 		MAC_ASSIGN(bssid, bssid);
 		CHAN_ASSIGN(channel);
 	),
-	TP_printk(NETDEV_PR_FMT ", bssid: " MAC_PR_FMT ", " CHAN_PR_FMT,
-		  NETDEV_PR_ARG, MAC_PR_ARG(bssid), CHAN_PR_ARG)
+	TP_printk(NETDEV_PR_FMT ", bssid: %pM, " CHAN_PR_FMT,
+		  NETDEV_PR_ARG, __entry->bssid, CHAN_PR_ARG)
 );
 
 TRACE_EVENT(cfg80211_probe_status,
@@ -3371,8 +3367,8 @@ TRACE_EVENT(cfg80211_probe_status,
 		__entry->cookie = cookie;
 		__entry->acked = acked;
 	),
-	TP_printk(NETDEV_PR_FMT " addr:" MAC_PR_FMT ", cookie: %llu, acked: %s",
-		  NETDEV_PR_ARG, MAC_PR_ARG(addr), __entry->cookie,
+	TP_printk(NETDEV_PR_FMT " addr:%pM, cookie: %llu, acked: %s",
+		  NETDEV_PR_ARG, __entry->addr, __entry->cookie,
 		  BOOL_TO_STR(__entry->acked))
 );
 
@@ -3389,8 +3385,8 @@ TRACE_EVENT(cfg80211_cqm_pktloss_notify,
 		MAC_ASSIGN(peer, peer);
 		__entry->num_packets = num_packets;
 	),
-	TP_printk(NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", num of lost packets: %u",
-		  NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->num_packets)
+	TP_printk(NETDEV_PR_FMT ", peer: %pM, num of lost packets: %u",
+		  NETDEV_PR_ARG, __entry->peer, __entry->num_packets)
 );
 
 DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_gtk_rekey_notify,
@@ -3414,8 +3410,8 @@ TRACE_EVENT(cfg80211_pmksa_candidate_notify,
 		MAC_ASSIGN(bssid, bssid);
 		__entry->preauth = preauth;
 	),
-	TP_printk(NETDEV_PR_FMT ", index:%d, bssid: " MAC_PR_FMT ", pre auth: %s",
-		  NETDEV_PR_ARG, __entry->index, MAC_PR_ARG(bssid),
+	TP_printk(NETDEV_PR_FMT ", index:%d, bssid: %pM, pre auth: %s",
+		  NETDEV_PR_ARG, __entry->index, __entry->bssid,
 		  BOOL_TO_STR(__entry->preauth))
 );
 
@@ -3455,8 +3451,8 @@ TRACE_EVENT(cfg80211_tdls_oper_request,
 		__entry->oper = oper;
 		__entry->reason_code = reason_code;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT ", oper: %d, reason_code %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer), __entry->oper,
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: %pM, oper: %d, reason_code %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer, __entry->oper,
 		  __entry->reason_code)
 	);
 
@@ -3494,10 +3490,10 @@ TRACE_EVENT(cfg80211_scan_done,
 			MAC_ASSIGN(tsf_bssid, info->tsf_bssid);
 		}
 	),
-	TP_printk("aborted: %s, scan start (TSF): %llu, tsf_bssid: " MAC_PR_FMT,
+	TP_printk("aborted: %s, scan start (TSF): %llu, tsf_bssid: %pM",
 		  BOOL_TO_STR(__entry->aborted),
 		  (unsigned long long)__entry->scan_start_tsf,
-		  MAC_PR_ARG(tsf_bssid))
+		  __entry->tsf_bssid)
 );
 
 DECLARE_EVENT_CLASS(wiphy_id_evt,
@@ -3546,9 +3542,9 @@ TRACE_EVENT(cfg80211_get_bss,
 		__entry->bss_type = bss_type;
 		__entry->privacy = privacy;
 	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_PR_FMT ", " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " CHAN_PR_FMT ", %pM"
 		  ", buf: %#.2x, bss_type: %d, privacy: %d",
-		  WIPHY_PR_ARG, CHAN_PR_ARG, MAC_PR_ARG(bssid),
+		  WIPHY_PR_ARG, CHAN_PR_ARG, __entry->bssid,
 		  ((u8 *)__get_dynamic_array(ssid))[0], __entry->bss_type,
 		  __entry->privacy)
 );
@@ -3579,11 +3575,11 @@ TRACE_EVENT(cfg80211_inform_bss_frame,
 		MAC_ASSIGN(parent_bssid, data->parent_bssid);
 	),
 	TP_printk(WIPHY_PR_FMT ", " CHAN_PR_FMT
-		  "(scan_width: %d) signal: %d, tsb:%llu, detect_tsf:%llu, tsf_bssid: "
-		  MAC_PR_FMT, WIPHY_PR_ARG, CHAN_PR_ARG, __entry->scan_width,
+		  "(scan_width: %d) signal: %d, tsb:%llu, detect_tsf:%llu, tsf_bssid: %pM",
+		  WIPHY_PR_ARG, CHAN_PR_ARG, __entry->scan_width,
 		  __entry->signal, (unsigned long long)__entry->ts_boottime,
 		  (unsigned long long)__entry->parent_tsf,
-		  MAC_PR_ARG(parent_bssid))
+		  __entry->parent_bssid)
 );
 
 DECLARE_EVENT_CLASS(cfg80211_bss_evt,
@@ -3597,7 +3593,7 @@ DECLARE_EVENT_CLASS(cfg80211_bss_evt,
 		MAC_ASSIGN(bssid, pub->bssid);
 		CHAN_ASSIGN(pub->channel);
 	),
-	TP_printk(MAC_PR_FMT ", " CHAN_PR_FMT, MAC_PR_ARG(bssid), CHAN_PR_ARG)
+	TP_printk("%pM, " CHAN_PR_FMT, __entry->bssid, CHAN_PR_ARG)
 );
 
 DEFINE_EVENT(cfg80211_bss_evt, cfg80211_return_bss,
@@ -3689,8 +3685,8 @@ TRACE_EVENT(cfg80211_ft_event,
 			memcpy(__get_dynamic_array(ric_ies), ft_event->ric_ies,
 			       ft_event->ric_ies_len);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", target_ap: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(target_ap))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", target_ap: %pM",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->target_ap)
 );
 
 TRACE_EVENT(cfg80211_stop_iface,
@@ -3724,10 +3720,10 @@ TRACE_EVENT(cfg80211_pmsr_report,
 		__entry->cookie = cookie;
 		MAC_ASSIGN(addr, addr);
 	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", cookie:%lld, " MAC_PR_FMT,
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", cookie:%lld, %pM",
 		  WIPHY_PR_ARG, WDEV_PR_ARG,
 		  (unsigned long long)__entry->cookie,
-		  MAC_PR_ARG(addr))
+		  __entry->addr)
 );
 
 TRACE_EVENT(cfg80211_pmsr_complete,
@@ -3761,8 +3757,8 @@ TRACE_EVENT(cfg80211_update_owe_info_event,
 			   MAC_ASSIGN(peer, owe_info->peer);
 			   memcpy(__get_dynamic_array(ie), owe_info->ie,
 				  owe_info->ie_len);),
-	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
-		      WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: %pM",
+		      WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer)
 );
 
 TRACE_EVENT(cfg80211_bss_color_notify,
@@ -3800,8 +3796,8 @@ TRACE_EVENT(cfg80211_assoc_comeback,
 		MAC_ASSIGN(ap_addr, ap_addr);
 		__entry->timeout = timeout;
 	),
-	TP_printk(WDEV_PR_FMT ", " MAC_PR_FMT ", timeout: %u TUs",
-		  WDEV_PR_ARG, MAC_PR_ARG(ap_addr), __entry->timeout)
+	TP_printk(WDEV_PR_FMT ", %pM, timeout: %u TUs",
+		  WDEV_PR_ARG, __entry->ap_addr, __entry->timeout)
 );
 
 DECLARE_EVENT_CLASS(link_station_add_mod,
@@ -3859,10 +3855,10 @@ DECLARE_EVENT_CLASS(link_station_add_mod,
 			memcpy(__get_dynamic_array(eht_capa), params->eht_capa,
 			       params->eht_capa_len);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
-		  ", link mac: " MAC_PR_FMT ", link id: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(mld_mac),
-		  MAC_PR_ARG(link_mac), __entry->link_id)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
+		  ", link mac: %pM, link id: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->mld_mac,
+		  __entry->link_mac, __entry->link_id)
 );
 
 DEFINE_EVENT(link_station_add_mod, rdev_add_link_station,
@@ -3895,9 +3891,9 @@ TRACE_EVENT(rdev_del_link_station,
 			memcpy(__entry->mld_mac, params->mld_mac, 6);
 		__entry->link_id = params->link_id;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: " MAC_PR_FMT
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
 		  ", link id: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(mld_mac),
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->mld_mac,
 		  __entry->link_id)
 );
 
-- 
2.39.0

