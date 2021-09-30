Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884EF41D87E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbhI3LPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350366AbhI3LNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F2C06176C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5KkeL26VT0S9cIYwFIUoGIBOxYTBLMyOHJzGdWiDRRQ=;
        t=1633000296; x=1634209896; b=gJQDqvgZs3lHDqpBG+N0sasf6P4psfpKV7a5U5Q/toxbL8F
        UWcGFuckCDawN7QCZPwaNNA65tbyvQ4yZM54ZQgrVdEzFWFwEMlp1JpNvawo6nTDBHSNsYNlxQ3BF
        Tl1XhvC7YZ8q4rDS3Gt4aPd5NO0grRrQElZNEE0+ssm7KDMEq1uEY0TX8f+kTEXi52s/FjfBr8y/k
        ciyLgdzY1T+XY2kiTUi9fzYxbWx6aD/0dIQOrGKgNxYhqGlX0VkS9GxbfFLevJ+ejxNgmpTbHpxPI
        04H/KUzZXNYX7X8Enp8e35sBQKH75Di+utWzpecyBd+ttOGZRH57hbn9JA4GWJQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVtyQ-00Dlti-Uy;
        Thu, 30 Sep 2021 13:11:35 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] cfg80211: use ieee80211_bss_get_elem() instead of _get_ie()
Date:   Thu, 30 Sep 2021 13:11:32 +0200
Message-Id: <20210930131130.e94709f341c3.I4ddb7fcb40efca27987deda7f9a144a5702ebfae@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
References: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use the structured helper for finding an element instead of
the unstructured ieee80211_bss_get_ie().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c  | 12 +++++++-----
 net/wireless/scan.c     | 21 ++++++++++-----------
 net/wireless/sme.c      | 22 ++++++++++------------
 net/wireless/wext-sme.c | 12 ++++++------
 4 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e72efe146d58..dc8227697c33 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3664,14 +3664,16 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_ADHOC: {
-		const u8 *ssid_ie;
+		const struct element *ssid_elem;
+
 		if (!wdev->current_bss)
 			break;
 		rcu_read_lock();
-		ssid_ie = ieee80211_bss_get_ie(&wdev->current_bss->pub,
-					       WLAN_EID_SSID);
-		if (ssid_ie &&
-		    nla_put(msg, NL80211_ATTR_SSID, ssid_ie[1], ssid_ie + 2))
+		ssid_elem = ieee80211_bss_get_elem(&wdev->current_bss->pub,
+						   WLAN_EID_SSID);
+		if (ssid_elem &&
+		    nla_put(msg, NL80211_ATTR_SSID, ssid_elem->datalen,
+			    ssid_elem->data))
 			goto nla_put_failure_rcu_locked;
 		rcu_read_unlock();
 		break;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 85aa11a45710..34551ea2adfc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -406,22 +406,20 @@ static int
 cfg80211_add_nontrans_list(struct cfg80211_bss *trans_bss,
 			   struct cfg80211_bss *nontrans_bss)
 {
-	const u8 *ssid;
-	size_t ssid_len;
+	const struct element *ssid_elem;
 	struct cfg80211_bss *bss = NULL;
 
 	rcu_read_lock();
-	ssid = ieee80211_bss_get_ie(nontrans_bss, WLAN_EID_SSID);
-	if (!ssid) {
+	ssid_elem = ieee80211_bss_get_elem(nontrans_bss, WLAN_EID_SSID);
+	if (!ssid_elem) {
 		rcu_read_unlock();
 		return -EINVAL;
 	}
-	ssid_len = ssid[1];
-	ssid = ssid + 2;
 
 	/* check if nontrans_bss is in the list */
 	list_for_each_entry(bss, &trans_bss->nontrans_list, nontrans_list) {
-		if (is_bss(bss, nontrans_bss->bssid, ssid, ssid_len)) {
+		if (is_bss(bss, nontrans_bss->bssid, ssid_elem->data,
+			   ssid_elem->datalen)) {
 			rcu_read_unlock();
 			return 0;
 		}
@@ -2223,7 +2221,8 @@ cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
 				   struct ieee80211_mgmt *mgmt, size_t len)
 {
 	u8 *ie, *new_ie, *pos;
-	const u8 *nontrans_ssid, *trans_ssid, *mbssid;
+	const struct element *nontrans_ssid;
+	const u8 *trans_ssid, *mbssid;
 	size_t ielen = len - offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
 	size_t new_ie_len;
@@ -2250,11 +2249,11 @@ cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
 		return;
 	new_ie_len -= mbssid[1];
 
-	nontrans_ssid = ieee80211_bss_get_ie(nontrans_bss, WLAN_EID_SSID);
+	nontrans_ssid = ieee80211_bss_get_elem(nontrans_bss, WLAN_EID_SSID);
 	if (!nontrans_ssid)
 		return;
 
-	new_ie_len += nontrans_ssid[1];
+	new_ie_len += nontrans_ssid->datalen;
 
 	/* generate new ie for nontrans BSS
 	 * 1. replace SSID with nontrans BSS' SSID
@@ -2271,7 +2270,7 @@ cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
 	pos = new_ie;
 
 	/* copy the nontransmitted SSID */
-	cpy_len = nontrans_ssid[1] + 2;
+	cpy_len = nontrans_ssid->datalen + 2;
 	memcpy(pos, nontrans_ssid, cpy_len);
 	pos += cpy_len;
 	/* copy the IEs between SSID and MBSSID */
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 08a70b4f090c..ff4d48fcbfb2 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -680,7 +680,9 @@ void __cfg80211_connect_result(struct net_device *dev,
 			       bool wextev)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	const u8 *country_ie;
+	const struct element *country_elem;
+	const u8 *country_data;
+	u8 country_datalen;
 #ifdef CONFIG_CFG80211_WEXT
 	union iwreq_data wrqu;
 #endif
@@ -762,26 +764,22 @@ void __cfg80211_connect_result(struct net_device *dev,
 		cfg80211_upload_connect_keys(wdev);
 
 	rcu_read_lock();
-	country_ie = ieee80211_bss_get_ie(cr->bss, WLAN_EID_COUNTRY);
-	if (!country_ie) {
+	country_elem = ieee80211_bss_get_elem(cr->bss, WLAN_EID_COUNTRY);
+	if (!country_elem) {
 		rcu_read_unlock();
 		return;
 	}
 
-	country_ie = kmemdup(country_ie, 2 + country_ie[1], GFP_ATOMIC);
+	country_datalen = country_elem->datalen;
+	country_data = kmemdup(country_elem->data, country_datalen, GFP_ATOMIC);
 	rcu_read_unlock();
 
-	if (!country_ie)
+	if (!country_data)
 		return;
 
-	/*
-	 * ieee80211_bss_get_ie() ensures we can access:
-	 * - country_ie + 2, the start of the country ie data, and
-	 * - and country_ie[1] which is the IE length
-	 */
 	regulatory_hint_country_ie(wdev->wiphy, cr->bss->channel->band,
-				   country_ie + 2, country_ie[1]);
-	kfree(country_ie);
+				   country_data, country_datalen);
+	kfree(country_data);
 }
 
 /* Consumes bss object one way or another */
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 193a18a53142..cd09a9042261 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -212,18 +212,18 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
 
 	wdev_lock(wdev);
 	if (wdev->current_bss) {
-		const u8 *ie;
+		const struct element *ssid_elem;
 
 		rcu_read_lock();
-		ie = ieee80211_bss_get_ie(&wdev->current_bss->pub,
-					  WLAN_EID_SSID);
-		if (ie) {
+		ssid_elem = ieee80211_bss_get_elem(&wdev->current_bss->pub,
+						   WLAN_EID_SSID);
+		if (ssid_elem) {
 			data->flags = 1;
-			data->length = ie[1];
+			data->length = ssid_elem->datalen;
 			if (data->length > IW_ESSID_MAX_SIZE)
 				ret = -EINVAL;
 			else
-				memcpy(ssid, ie + 2, data->length);
+				memcpy(ssid, ssid_elem->data, data->length);
 		}
 		rcu_read_unlock();
 	} else if (wdev->wext.connect.ssid && wdev->wext.connect.ssid_len) {
-- 
2.31.1

