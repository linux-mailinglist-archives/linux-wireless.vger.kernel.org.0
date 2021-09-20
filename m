Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7984115D7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhITNdE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhITNc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 09:32:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF8C061764
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5RNo67mlcRNdSP+uxwthlNQwSowdQz+u4TREEuVyCPY=;
        t=1632144689; x=1633354289; b=Kc4vnDhC7BjxUogZZ5jIoVbA321Yo80UcpyMF/bK35dMfIg
        Xb6MSmGHhho3calIdENaamu/P55X69ofrjCrxXFrX3KLHYQySZyeWr28jtsoRh8nJ5GBfe+oHWzTJ
        lqycXX6RUVDDJFd9ZzDtRyRFyZPNFqD57P8JM/r3Y5yVoU49mZyRX8chRMGTbeHzEQR0BFQkklRXW
        7gW79+DArOVjRA3RfL9a0vQND2lvbjNmjBn8CKEi7LJ2juGamPkn6D4KMnz6tXzy+vk45gOkoq82y
        ORIURsaMVipp3f59DlTHGlyEnzKQNitSnD9vB0w4zvVCLJjYDB4Goo7Ynh7NlbIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSJOJ-009S8n-7r;
        Mon, 20 Sep 2021 15:31:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/6] mac80211: move CRC into struct ieee802_11_elems
Date:   Mon, 20 Sep 2021 15:31:21 +0200
Message-Id: <20210920153122.374490e6d0e0.If0d4ba75ee38998dc3eeae25058aa748efcb2fc9@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920153122.e733e4d412bf.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
References: <20210920153122.e733e4d412bf.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We're currently returning this value, but to prepare for
returning the allocated structure, move it into there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  9 +++++----
 net/mac80211/mlme.c        |  9 +++++----
 net/mac80211/util.c        | 10 +++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d74031bb4ae6..6a129a08bc9b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1507,6 +1507,7 @@ struct ieee80211_csa_ie {
 struct ieee802_11_elems {
 	const u8 *ie_start;
 	size_t total_len;
+	u32 crc;
 
 	/* pointers to IEs */
 	const struct ieee80211_tdls_lnkie *lnk_id;
@@ -2193,10 +2194,10 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb_tid(sdata, skb, 7);
 }
 
-u32 ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
-			       struct ieee802_11_elems *elems,
-			       u64 filter, u32 crc, u8 *transmitter_bssid,
-			       u8 *bss_bssid);
+void ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
+				struct ieee802_11_elems *elems,
+				u64 filter, u32 crc, u8 *transmitter_bssid,
+				u8 *bss_bssid);
 static inline void ieee802_11_parse_elems(const u8 *start, size_t len,
 					  bool action,
 					  struct ieee802_11_elems *elems,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c0ea3b1aa9e1..39b3ed89e0da 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4070,10 +4070,11 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
 		ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
-	ncrc = ieee802_11_parse_elems_crc(variable,
-					  len - baselen, false, &elems,
-					  care_about_ies, ncrc,
-					  mgmt->bssid, bssid);
+	ieee802_11_parse_elems_crc(variable,
+				   len - baselen, false, &elems,
+				   care_about_ies, ncrc,
+				   mgmt->bssid, bssid);
+	ncrc = elems.crc;
 
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
 	    ieee80211_check_tim(elems.tim, elems.tim_len, bss_conf->aid)) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 49cb96d25169..43ccad8b24c7 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1461,10 +1461,10 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 	return found ? profile_len : 0;
 }
 
-u32 ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
-			       struct ieee802_11_elems *elems,
-			       u64 filter, u32 crc, u8 *transmitter_bssid,
-			       u8 *bss_bssid)
+void ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
+				struct ieee802_11_elems *elems,
+				u64 filter, u32 crc, u8 *transmitter_bssid,
+				u8 *bss_bssid)
 {
 	const struct element *non_inherit = NULL;
 	u8 *nontransmitted_profile;
@@ -1516,7 +1516,7 @@ u32 ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 
 	kfree(nontransmitted_profile);
 
-	return crc;
+	elems->crc = crc;
 }
 
 void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
-- 
2.31.1

