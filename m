Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1641D877
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbhI3LN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350353AbhI3LNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 07:13:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A03C06176A
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=yTdM2B7TrxybEUeNZPWeEbY9ri1D7F4Q36RMTPpcOow=; t=1633000295; x=1634209895; 
        b=Ackf8BWYv5NLlkGoAxscaLeEUvToXAxPtmiFdePiZvjkTBW4VTGL4b2sUfS+QflBIZQsd2hoeP4
        X1fYOfzI64uHG3BSxgNfFrUKA9hiWZ4pxUcDl7t1/PmChLCSvrhxsx80S86tjBtyo0z/v1fMgIIob
        iZGcXKnGwkaXtyKmoShFa71PuaKo2lMWJy1PPQszvhFgTtsDNtc2uSUsd6EaHXsHkqkFEnpN88MNO
        70hkus+jCysJTfmmEmPIrnYYQdFN9TXzoR3F1sg3OoCNlngzuA4FspVVG4ytF/DxD9zUgEZFfevav
        VvQnpzLtsaYBZETxPeqBe8WJHUvxpLp975cA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVtyP-00Dlti-W4;
        Thu, 30 Sep 2021 13:11:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] mac80211: fils: use cfg80211_find_ext_elem()
Date:   Thu, 30 Sep 2021 13:11:28 +0200
Message-Id: <20210930131130.17ecf37f0605.I853c2f9c2117a713deca9b8deb3552796d98ffac@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Replace the use of cfg80211_find_ext_ie() with the more
structured cfg80211_find_ext_elem().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/fils_aead.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index a13ae148937e..e1d4cfd99128 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -219,7 +219,8 @@ int fils_encrypt_assoc_req(struct sk_buff *skb,
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	u8 *capab, *ies, *encr;
-	const u8 *addr[5 + 1], *session;
+	const u8 *addr[5 + 1];
+	const struct element *session;
 	size_t len[5 + 1];
 	size_t crypt_len;
 
@@ -231,12 +232,12 @@ int fils_encrypt_assoc_req(struct sk_buff *skb,
 		ies = mgmt->u.assoc_req.variable;
 	}
 
-	session = cfg80211_find_ext_ie(WLAN_EID_EXT_FILS_SESSION,
-				       ies, skb->data + skb->len - ies);
-	if (!session || session[1] != 1 + 8)
+	session = cfg80211_find_ext_elem(WLAN_EID_EXT_FILS_SESSION,
+					 ies, skb->data + skb->len - ies);
+	if (!session || session->datalen != 1 + 8)
 		return -EINVAL;
 	/* encrypt after FILS Session element */
-	encr = (u8 *)session + 2 + 1 + 8;
+	encr = (u8 *)session->data + 1 + 8;
 
 	/* AES-SIV AAD vectors */
 
@@ -270,7 +271,8 @@ int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_mgmt *mgmt = (void *)frame;
 	u8 *capab, *ies, *encr;
-	const u8 *addr[5 + 1], *session;
+	const u8 *addr[5 + 1];
+	const struct element *session;
 	size_t len[5 + 1];
 	int res;
 	size_t crypt_len;
@@ -280,16 +282,16 @@ int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 
 	capab = (u8 *)&mgmt->u.assoc_resp.capab_info;
 	ies = mgmt->u.assoc_resp.variable;
-	session = cfg80211_find_ext_ie(WLAN_EID_EXT_FILS_SESSION,
-				       ies, frame + *frame_len - ies);
-	if (!session || session[1] != 1 + 8) {
+	session = cfg80211_find_ext_elem(WLAN_EID_EXT_FILS_SESSION,
+					 ies, frame + *frame_len - ies);
+	if (!session || session->datalen != 1 + 8) {
 		mlme_dbg(sdata,
 			 "No (valid) FILS Session element in (Re)Association Response frame from %pM",
 			 mgmt->sa);
 		return -EINVAL;
 	}
 	/* decrypt after FILS Session element */
-	encr = (u8 *)session + 2 + 1 + 8;
+	encr = (u8 *)session->data + 1 + 8;
 
 	/* AES-SIV AAD vectors */
 
-- 
2.31.1

