Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF339273A3C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgIVFha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:30 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34022 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728901AbgIVFha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id C54DE4F9DFB;
        Tue, 22 Sep 2020 05:37:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0hjFqCZIcubI; Tue, 22 Sep 2020 05:37:26 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id BBBA64F9DFC;
        Tue, 22 Sep 2020 05:37:18 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 07/17] mac80211: convert S1G beacon to scan results
Date:   Mon, 21 Sep 2020 19:28:08 -0700
Message-Id: <20200922022818.15855-8-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit finds the correct offset for Information
Elements in S1G beacon frames so they can be reported in
scan results.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---

v4:
 - remove bss->s1g (Johannes)
 - use sizeof() when checking IE lengths and don't parse
   short beacon element (yet) (Johannes)
---
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/rx.c          |  3 ++-
 net/mac80211/scan.c        | 17 +++++++++++++----
 net/mac80211/util.c        | 22 ++++++++++++++++++++++
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 27b73891aa4c..32b9631a458e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1536,6 +1536,9 @@ struct ieee802_11_elems {
 	u8 dtim_count;
 	u8 dtim_period;
 	const struct ieee80211_addba_ext_ie *addba_ext_ie;
+	const struct ieee80211_s1g_cap *s1g_capab;
+	const struct ieee80211_s1g_oper_ie *s1g_oper;
+	const struct ieee80211_s1g_bcn_compat_ie *s1g_bcn_compat;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index b04d6e01a346..7cc423bd38bb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4577,7 +4577,8 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	ieee80211_verify_alignment(&rx);
 
 	if (unlikely(ieee80211_is_probe_resp(hdr->frame_control) ||
-		     ieee80211_is_beacon(hdr->frame_control)))
+		     ieee80211_is_beacon(hdr->frame_control) ||
+		     ieee80211_is_s1g_beacon(hdr->frame_control)))
 		ieee80211_scan_rx(local, skb);
 
 	if (ieee80211_is_data(fc)) {
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index d2d6ff37a77b..d5fa627c5acc 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -146,7 +146,8 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 			  struct ieee80211_mgmt *mgmt, size_t len,
 			  struct ieee80211_channel *channel)
 {
-	bool beacon = ieee80211_is_beacon(mgmt->frame_control);
+	bool beacon = ieee80211_is_beacon(mgmt->frame_control) ||
+		      ieee80211_is_s1g_beacon(mgmt->frame_control);
 	struct cfg80211_bss *cbss, *non_tx_cbss;
 	struct ieee80211_bss *bss, *non_tx_bss;
 	struct cfg80211_inform_bss bss_meta = {
@@ -195,6 +196,11 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 		elements = mgmt->u.probe_resp.variable;
 		baselen = offsetof(struct ieee80211_mgmt,
 				   u.probe_resp.variable);
+	} else if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		struct ieee80211_ext *ext = (void *) mgmt;
+
+		baselen = offsetof(struct ieee80211_ext, u.s1g_beacon.variable);
+		elements = ext->u.s1g_beacon.variable;
 	} else {
 		baselen = offsetof(struct ieee80211_mgmt, u.beacon.variable);
 		elements = mgmt->u.beacon.variable;
@@ -246,9 +252,12 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
 
-	if (skb->len < 24 ||
-	    (!ieee80211_is_probe_resp(mgmt->frame_control) &&
-	     !ieee80211_is_beacon(mgmt->frame_control)))
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		if (skb->len < 15)
+			return;
+	} else if (skb->len < 24 ||
+		 (!ieee80211_is_probe_resp(mgmt->frame_control) &&
+		  !ieee80211_is_beacon(mgmt->frame_control)))
 		return;
 
 	sdata1 = rcu_dereference(local->scan_sdata);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27b2f1ceca69..ba2810a6fae8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1003,6 +1003,10 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 		case WLAN_EID_LINK_ID:
 		case WLAN_EID_BSS_MAX_IDLE_PERIOD:
 		case WLAN_EID_RSNX:
+		case WLAN_EID_S1G_BCN_COMPAT:
+		case WLAN_EID_S1G_CAPABILITIES:
+		case WLAN_EID_S1G_OPERATION:
+		case WLAN_EID_S1G_SHORT_BCN_INTERVAL:
 		/*
 		 * not listing WLAN_EID_CHANNEL_SWITCH_WRAPPER -- it seems possible
 		 * that if the content gets bigger it might be needed more than once
@@ -1288,6 +1292,24 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 								&crc : NULL,
 							  elem, elems);
 			break;
+		case WLAN_EID_S1G_CAPABILITIES:
+			if (elen == sizeof(*elems->s1g_capab))
+				elems->s1g_capab = (void *)pos;
+			else
+				elem_parse_failed = true;
+			break;
+		case WLAN_EID_S1G_OPERATION:
+			if (elen == sizeof(*elems->s1g_oper))
+				elems->s1g_oper = (void *)pos;
+			else
+				elem_parse_failed = true;
+			break;
+		case WLAN_EID_S1G_BCN_COMPAT:
+			if (elen == sizeof(*elems->s1g_bcn_compat))
+				elems->s1g_bcn_compat = (void *)pos;
+			else
+				elem_parse_failed = true;
+			break;
 		default:
 			break;
 		}
-- 
2.20.1

