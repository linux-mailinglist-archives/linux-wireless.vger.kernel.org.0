Return-Path: <linux-wireless+bounces-14552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE39B0A02
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 18:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D34628532B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C0165F17;
	Fri, 25 Oct 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GWpT/RKG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2A1411E0
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873987; cv=none; b=VnJRtEgMEg5/OvcsQVRO3EPh0+7Y+zER45Uz47tEAX/tUwxaara5+6OtS/P0UH78SZdjpoNTbvif33waQgFSJMrvoEhaIO7cRD4ajq5eGohF4O/kvs7wwEhEpDIw2zCG9dklU/yEy37O6R5yqBhsBmS3LejsKuw9EaU550sYfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873987; c=relaxed/simple;
	bh=N1JrOEBzqUZdVWs2vRB8qjhW6lnYQ5JSPXv8JRm/zxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMCtHwqF5RqPNiT/QhJRbdk7oS3A+rzUM/JmchnoirtfrMHUKz3/YPoXcjR64Z0oxSew4xFHB31dwtXx1DZZX4xyuTV0pvrUlXSt1jrCwUVsUTd6QP25nKaP3RxIAcpuqmalRAAQSfNA7/JNqBGRcmHNuHjQ3I7BwtfT0CDpCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GWpT/RKG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729873982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ziFYxBE0vkKRK6ozZVljN+CSKOd2Ewv5Q7QWyOcMr3M=;
	b=GWpT/RKGlfbqyHUeuI1Eze2NyBgDmvJEN9NudvYJ+vzFzt2Rf3P0HZqhA/18J+FlqQV/1I
	/xwZh3Wj/GGi4gyyde59K+6rBtPmzlJwH3MN+tRFUGdbJSTDyDF3MGbAF0fzcilkSssChI
	mUQZxe4DFv0pHTr49vfAi1Gl4bGj9MM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] wifi: trace: Replace BOOL_TO_STR() with str_true_false()
Date: Fri, 25 Oct 2024 18:32:11 +0200
Message-ID: <20241025163210.1395-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
function and remove the macro.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/wireless/trace.h | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 97c21b627791..dced336f04ab 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -218,8 +218,6 @@
 		__entry->plink_state = sinfo->plink_state;	       \
 	} while (0)
 
-#define BOOL_TO_STR(bo) (bo) ? "true" : "false"
-
 #define QOS_MAP_ENTRY __field(u8, num_des)			\
 		      __array(u8, dscp_exception,		\
 			      2 * IEEE80211_QOS_MAP_MAX_EX)	\
@@ -536,7 +534,7 @@ DECLARE_EVENT_CLASS(key_handle,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
 		  "key_index: %u, pairwise: %s, mac addr: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
-		  __entry->key_index, BOOL_TO_STR(__entry->pairwise),
+		  __entry->key_index, str_true_false(__entry->pairwise),
 		  __entry->mac_addr)
 );
 
@@ -579,7 +577,7 @@ TRACE_EVENT(rdev_add_key,
 		  "mac addr: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
 		  __entry->key_index, __entry->mode,
-		  BOOL_TO_STR(__entry->pairwise), __entry->mac_addr)
+		  str_true_false(__entry->pairwise), __entry->mac_addr)
 );
 
 TRACE_EVENT(rdev_set_default_key,
@@ -605,8 +603,8 @@ TRACE_EVENT(rdev_set_default_key,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
 		  "key index: %u, unicast: %s, multicast: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
-		  __entry->key_index, BOOL_TO_STR(__entry->unicast),
-		  BOOL_TO_STR(__entry->multicast))
+		  __entry->key_index, str_true_false(__entry->unicast),
+		  str_true_false(__entry->multicast))
 );
 
 TRACE_EVENT(rdev_set_default_mgmt_key,
@@ -691,7 +689,7 @@ TRACE_EVENT(rdev_start_ap,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->ssid, CHAN_DEF_PR_ARG,
 		  __entry->beacon_interval, __entry->dtim_period,
 		  __entry->hidden_ssid, __entry->wpa_ver,
-		  BOOL_TO_STR(__entry->privacy), __entry->auth_type,
+		  str_true_false(__entry->privacy), __entry->auth_type,
 		  __entry->inactivity_timeout, __entry->link_id)
 );
 
@@ -1406,7 +1404,7 @@ TRACE_EVENT(rdev_assoc,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		  ", previous bssid: %pM, use mfp: %s, flags: 0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
-		  __entry->prev_bssid, BOOL_TO_STR(__entry->use_mfp),
+		  __entry->prev_bssid, str_true_false(__entry->use_mfp),
 		  __entry->flags)
 );
 
@@ -1455,7 +1453,7 @@ TRACE_EVENT(rdev_disassoc,
 		  ", reason: %u, local state change: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
 		  __entry->reason_code,
-		  BOOL_TO_STR(__entry->local_state_change))
+		  str_true_false(__entry->local_state_change))
 );
 
 TRACE_EVENT(rdev_mgmt_tx_cancel_wait,
@@ -1528,7 +1526,7 @@ TRACE_EVENT(rdev_connect,
 		  ", ssid: %s, auth type: %d, privacy: %s, wpa versions: %u, "
 		  "flags: 0x%x, previous bssid: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid, __entry->ssid,
-		  __entry->auth_type, BOOL_TO_STR(__entry->privacy),
+		  __entry->auth_type, str_true_false(__entry->privacy),
 		  __entry->wpa_versions, __entry->flags, __entry->prev_bssid)
 );
 
@@ -1930,7 +1928,7 @@ TRACE_EVENT(rdev_tdls_mgmt,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer,
 		  __entry->link_id, __entry->action_code, __entry->dialog_token,
 		  __entry->status_code, __entry->peer_capability,
-		  BOOL_TO_STR(__entry->initiator),
+		  str_true_false(__entry->initiator),
 		  ((u8 *)__get_dynamic_array(buf))[0])
 );
 
@@ -2139,9 +2137,9 @@ TRACE_EVENT(rdev_mgmt_tx,
 	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", " CHAN_PR_FMT ", offchan: %s,"
 		  " wait: %u, no cck: %s, dont wait for ack: %s",
 		  WIPHY_PR_ARG, WDEV_PR_ARG, CHAN_PR_ARG,
-		  BOOL_TO_STR(__entry->offchan), __entry->wait,
-		  BOOL_TO_STR(__entry->no_cck),
-		  BOOL_TO_STR(__entry->dont_wait_for_ack))
+		  str_true_false(__entry->offchan), __entry->wait,
+		  str_true_false(__entry->no_cck),
+		  str_true_false(__entry->dont_wait_for_ack))
 );
 
 TRACE_EVENT(rdev_tx_control_port,
@@ -2169,7 +2167,7 @@ TRACE_EVENT(rdev_tx_control_port,
 		  " proto: 0x%x, unencrypted: %s, link: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dest,
 		  be16_to_cpu(__entry->proto),
-		  BOOL_TO_STR(__entry->unencrypted),
+		  str_true_false(__entry->unencrypted),
 		  __entry->link_id)
 );
 
@@ -2747,7 +2745,7 @@ TRACE_EVENT(rdev_set_multicast_to_unicast,
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", unicast: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  BOOL_TO_STR(__entry->enabled))
+		  str_true_false(__entry->enabled))
 );
 
 DEFINE_EVENT(wiphy_wdev_evt, rdev_get_txq_stats,
@@ -3060,7 +3058,7 @@ TRACE_EVENT(cfg80211_return_bool,
 	TP_fast_assign(
 		__entry->ret = ret;
 	),
-	TP_printk("returned %s", BOOL_TO_STR(__entry->ret))
+	TP_printk("returned %s", str_true_false(__entry->ret))
 );
 
 DECLARE_EVENT_CLASS(cfg80211_netdev_mac_evt,
@@ -3337,7 +3335,7 @@ TRACE_EVENT(cfg80211_mgmt_tx_status,
 		__entry->ack = ack;
 	),
 	TP_printk(WDEV_PR_FMT", cookie: %llu, ack: %s",
-		  WDEV_PR_ARG, __entry->cookie, BOOL_TO_STR(__entry->ack))
+		  WDEV_PR_ARG, __entry->cookie, str_true_false(__entry->ack))
 );
 
 TRACE_EVENT(cfg80211_control_port_tx_status,
@@ -3354,7 +3352,7 @@ TRACE_EVENT(cfg80211_control_port_tx_status,
 		__entry->ack = ack;
 	),
 	TP_printk(WDEV_PR_FMT", cookie: %llu, ack: %s",
-		  WDEV_PR_ARG, __entry->cookie, BOOL_TO_STR(__entry->ack))
+		  WDEV_PR_ARG, __entry->cookie, str_true_false(__entry->ack))
 );
 
 TRACE_EVENT(cfg80211_rx_control_port,
@@ -3379,7 +3377,7 @@ TRACE_EVENT(cfg80211_rx_control_port,
 	),
 	TP_printk(NETDEV_PR_FMT ", len=%d, %pM, proto: 0x%x, unencrypted: %s, link: %d",
 		  NETDEV_PR_ARG, __entry->len, __entry->from,
-		  __entry->proto, BOOL_TO_STR(__entry->unencrypted),
+		  __entry->proto, str_true_false(__entry->unencrypted),
 		  __entry->link_id)
 );
 
@@ -3575,7 +3573,7 @@ TRACE_EVENT(cfg80211_probe_status,
 	),
 	TP_printk(NETDEV_PR_FMT " addr:%pM, cookie: %llu, acked: %s",
 		  NETDEV_PR_ARG, __entry->addr, __entry->cookie,
-		  BOOL_TO_STR(__entry->acked))
+		  str_true_false(__entry->acked))
 );
 
 TRACE_EVENT(cfg80211_cqm_pktloss_notify,
@@ -3618,7 +3616,7 @@ TRACE_EVENT(cfg80211_pmksa_candidate_notify,
 	),
 	TP_printk(NETDEV_PR_FMT ", index:%d, bssid: %pM, pre auth: %s",
 		  NETDEV_PR_ARG, __entry->index, __entry->bssid,
-		  BOOL_TO_STR(__entry->preauth))
+		  str_true_false(__entry->preauth))
 );
 
 TRACE_EVENT(cfg80211_report_obss_beacon,
@@ -3697,7 +3695,7 @@ TRACE_EVENT(cfg80211_scan_done,
 		}
 	),
 	TP_printk("aborted: %s, scan start (TSF): %llu, tsf_bssid: %pM",
-		  BOOL_TO_STR(__entry->aborted),
+		  str_true_false(__entry->aborted),
 		  (unsigned long long)__entry->scan_start_tsf,
 		  __entry->tsf_bssid)
 );
-- 
2.47.0


