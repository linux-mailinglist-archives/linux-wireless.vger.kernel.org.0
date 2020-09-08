Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A277E261B7D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgIHTD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:03:57 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52706 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731509AbgIHTDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id BFB3A4F9B03;
        Tue,  8 Sep 2020 19:03:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6uCU5Hqq_op4; Tue,  8 Sep 2020 19:03:35 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 12F914F9B05;
        Tue,  8 Sep 2020 19:03:23 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 10/22] cfg80211: convert S1G beacon to scan results
Date:   Tue,  8 Sep 2020 12:03:11 -0700
Message-Id: <20200908190323.15814-11-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The S1G beacon is an extension frame as opposed to
management frame for the regular beacon. This means we may
have to occasionally cast the frame buffer to a different
header type. Luckily this isn't too bad as scan results
mostly only care about the IEs.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h | 32 ++++++++++++++++++++++
 net/wireless/scan.c       | 57 ++++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 53fba39d4ba6..bca4bb443291 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -151,6 +151,9 @@
 
 #define IEEE80211_ANO_NETTYPE_WILD              15
 
+/* bits unique to S1G beacon */
+#define IEEE80211_S1G_BCN_NEXT_TBTT    0x100
+
 /* control extension - for IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTL_EXT */
 #define IEEE80211_CTL_EXT_POLL		0x2000
 #define IEEE80211_CTL_EXT_SPR		0x3000
@@ -553,6 +556,28 @@ static inline bool ieee80211_is_s1g_beacon(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON);
 }
 
+/**
+ * ieee80211_next_tbtt_present - check if IEEE80211_FTYPE_EXT &&
+ * IEEE80211_STYPE_S1G_BEACON && IEEE80211_S1G_BCN_NEXT_TBTT
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee80211_next_tbtt_present(__le16 fc)
+{
+	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) ==
+	       cpu_to_le16(IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON) &&
+	       fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT);
+}
+
+/**
+ * ieee80211_is_s1g_short_beacon - check if next tbtt present bit is set. Only
+ * true for S1G beacons when they're short.
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee80211_is_s1g_short_beacon(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) && ieee80211_next_tbtt_present(fc);
+}
+
 /**
  * ieee80211_is_atim - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ATIM
  * @fc: frame control bytes in little-endian byteorder
@@ -1034,6 +1059,13 @@ struct ieee80211_ext {
 			u8 change_seq;
 			u8 variable[0];
 		} __packed s1g_beacon;
+		struct {
+			u8 sa[ETH_ALEN];
+			__le32 timestamp;
+			u8 change_seq;
+			u8 next_tbtt[3];
+			u8 variable[0];
+		} __packed s1g_short_beacon;
 	} u;
 } __packed __aligned(2);
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 84fc8ab16dd2..b4c85e8f2107 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1807,8 +1807,11 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	struct cfg80211_bss_ies *ies;
 	struct ieee80211_channel *channel;
 	bool signal_valid;
-	size_t ielen = len - offsetof(struct ieee80211_mgmt,
-				      u.probe_resp.variable);
+	struct ieee80211_ext *ext = NULL;
+	u8 *bssid, *variable;
+	u16 capability, beacon_int;
+	size_t ielen, min_hdr_len = offsetof(struct ieee80211_mgmt,
+					     u.probe_resp.variable);
 	int bss_type;
 
 	BUILD_BUG_ON(offsetof(struct ieee80211_mgmt, u.probe_resp.variable) !=
@@ -1826,21 +1829,57 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 		    (data->signal < 0 || data->signal > 100)))
 		return NULL;
 
-	if (WARN_ON(len < offsetof(struct ieee80211_mgmt, u.probe_resp.variable)))
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		ext = (void *) mgmt;
+		min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon);
+		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
+			min_hdr_len = offsetof(struct ieee80211_ext,
+					       u.s1g_short_beacon.variable);
+	}
+
+	if (WARN_ON(len < min_hdr_len))
 		return NULL;
 
-	channel = cfg80211_get_bss_channel(wiphy, mgmt->u.beacon.variable,
+	ielen = len - min_hdr_len;
+	variable = mgmt->u.probe_resp.variable;
+	if (ext) {
+		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
+			variable = ext->u.s1g_short_beacon.variable;
+		else
+			variable = ext->u.s1g_beacon.variable;
+	}
+
+	channel = cfg80211_get_bss_channel(wiphy, variable,
 					   ielen, data->chan, data->scan_width);
 	if (!channel)
 		return NULL;
 
+	if (ext) {
+		struct ieee80211_s1g_bcn_compat_ie *compat;
+		u8 *ie;
+
+		ie = (void *)cfg80211_find_ie(WLAN_EID_S1G_BCN_COMPAT,
+					      variable, ielen);
+		if (!ie)
+			return NULL;
+		compat = (void *)(ie + 2);
+		bssid = ext->u.s1g_beacon.sa;
+		capability = le16_to_cpu(compat->compat_info);
+		beacon_int = le16_to_cpu(compat->beacon_int);
+	} else {
+		bssid = mgmt->bssid;
+		beacon_int = le16_to_cpu(mgmt->u.probe_resp.beacon_int);
+		capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
+	}
+
 	ies = kzalloc(sizeof(*ies) + ielen, gfp);
 	if (!ies)
 		return NULL;
 	ies->len = ielen;
 	ies->tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
-	ies->from_beacon = ieee80211_is_beacon(mgmt->frame_control);
-	memcpy(ies->data, mgmt->u.probe_resp.variable, ielen);
+	ies->from_beacon = ieee80211_is_beacon(mgmt->frame_control) ||
+			   ieee80211_is_s1g_beacon(mgmt->frame_control);
+	memcpy(ies->data, variable, ielen);
 
 	if (ieee80211_is_probe_resp(mgmt->frame_control))
 		rcu_assign_pointer(tmp.pub.proberesp_ies, ies);
@@ -1848,12 +1887,12 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 		rcu_assign_pointer(tmp.pub.beacon_ies, ies);
 	rcu_assign_pointer(tmp.pub.ies, ies);
 
-	memcpy(tmp.pub.bssid, mgmt->bssid, ETH_ALEN);
+	memcpy(tmp.pub.bssid, bssid, ETH_ALEN);
+	tmp.pub.beacon_interval = beacon_int;
+	tmp.pub.capability = capability;
 	tmp.pub.channel = channel;
 	tmp.pub.scan_width = data->scan_width;
 	tmp.pub.signal = data->signal;
-	tmp.pub.beacon_interval = le16_to_cpu(mgmt->u.probe_resp.beacon_int);
-	tmp.pub.capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
 	tmp.ts_boottime = data->boottime_ns;
 	tmp.parent_tsf = data->parent_tsf;
 	tmp.pub.chains = data->chains;
-- 
2.20.1

