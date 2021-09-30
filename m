Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C941D875
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbhI3LN1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbhI3LNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13458C06176D
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/UlCXayh1Hgf32IuT8gOVyd036GFW6To1eD1AvwtE/4=;
        t=1633000296; x=1634209896; b=T/M9wIN2ZIObl8whu+WYFZVn+I1UbdQleuivWlAmhdMtd5t
        a3xow1MZoI20FztkHbrvduvd4Rd5PUEZZO0EEwW+EbugbokkYWQpohW8LvexpgMR98vUFxFCaS3sx
        9lQvpQo5NlVhzdFSldt1WowS0Z4m0OYG1NXJf6OIv9Ghh2wqFCQwmKiEIBdnFCfZf8Iy3Kw4jZG24
        qVENt2di4EXazOnJrdNpRmCCIeJXjCtgJCQ1D5Zh0/RD7luH+zoUoBv1dU9xWFgr4HJ8ewogTbxvl
        tGm92LwJzD0baz270DcJflqzUsDM4e9fX5x+clydBLeQpoag4S+IL4wdjwSt3LWg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVtyQ-00Dlti-Fh;
        Thu, 30 Sep 2021 13:11:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] cfg80211: scan: use element finding functions in easy cases
Date:   Thu, 30 Sep 2021 13:11:30 +0200
Message-Id: <20210930131130.f27c8a7ec264.Iadb03c4307e9216e080ce513e8ad4048cd020b25@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
References: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are a few easy cases where we only check for NULL or
have just simple use of the result, this can be done with
the element finding functions instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index adc0d14cfd86..85aa11a45710 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -383,7 +383,7 @@ static bool is_bss(struct cfg80211_bss *a, const u8 *bssid,
 		   const u8 *ssid, size_t ssid_len)
 {
 	const struct cfg80211_bss_ies *ies;
-	const u8 *ssidie;
+	const struct element *ssid_elem;
 
 	if (bssid && !ether_addr_equal(a->bssid, bssid))
 		return false;
@@ -394,12 +394,12 @@ static bool is_bss(struct cfg80211_bss *a, const u8 *bssid,
 	ies = rcu_access_pointer(a->ies);
 	if (!ies)
 		return false;
-	ssidie = cfg80211_find_ie(WLAN_EID_SSID, ies->data, ies->len);
-	if (!ssidie)
+	ssid_elem = cfg80211_find_elem(WLAN_EID_SSID, ies->data, ies->len);
+	if (!ssid_elem)
 		return false;
-	if (ssidie[1] != ssid_len)
+	if (ssid_elem->datalen != ssid_len)
 		return false;
-	return memcmp(ssidie + 2, ssid, ssid_len) == 0;
+	return memcmp(ssid_elem->data, ssid, ssid_len) == 0;
 }
 
 static int
@@ -2075,12 +2075,12 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 
 	if (!non_tx_data)
 		return;
-	if (!cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
+	if (!cfg80211_find_elem(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
 		return;
 	if (!wiphy->support_mbssid)
 		return;
 	if (wiphy->support_only_he_mbssid &&
-	    !cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY, ie, ielen))
+	    !cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ie, ielen))
 		return;
 
 	new_ie = kmalloc(IEEE80211_MAX_DATA_LEN, gfp);
@@ -2447,10 +2447,10 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	res = cfg80211_inform_single_bss_frame_data(wiphy, data, mgmt,
 						    len, gfp);
 	if (!res || !wiphy->support_mbssid ||
-	    !cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
+	    !cfg80211_find_elem(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
 		return res;
 	if (wiphy->support_only_he_mbssid &&
-	    !cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY, ie, ielen))
+	    !cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ie, ielen))
 		return res;
 
 	non_tx_data.tx_bss = res;
-- 
2.31.1

