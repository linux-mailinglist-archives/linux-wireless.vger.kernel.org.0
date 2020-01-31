Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FF14EBBC
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgAaLbR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:31:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55954 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728325AbgAaLbR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:31:17 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUW3-0002LX-A8; Fri, 31 Jan 2020 13:31:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:31:11 +0200
Message-Id: <20200131113111.893106-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-12-luca@coelho.fi>
References: <20200131111300.891737-12-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v2] mac80211: remove supported channels element in 6 GHz if ECSA support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We should not include the supported channels element if we have
(advertise) support for extended channel switching. To avoid any
interop issues because we always added it in the past, obey this
restriction only in the (new) 6 GHz band.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

In v2:
   * Replaced the commit message as we had agreed (and I'd forgetten)

 net/mac80211/mlme.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 152577cc2213..bb20a5d8a172 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -671,6 +671,13 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
 	u32 rates = 0;
+	struct element *ext_capa = NULL;
+
+	/* we know it's writable, cast away the const */
+	if (assoc_data->ie_len)
+		ext_capa = (void *)cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
+						      assoc_data->ie,
+						      assoc_data->ie_len);
 
 	sdata_assert_lock(sdata);
 
@@ -821,7 +828,15 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		*pos++ = ieee80211_chandef_max_power(&chanctx_conf->def);
 	}
 
-	if (capab & WLAN_CAPABILITY_SPECTRUM_MGMT) {
+	/*
+	 * Per spec, we shouldn't include the list of channels if we advertise
+	 * support for extended channel switching, but we've always done that;
+	 * (for now?) apply this restriction only on the (new) 6 GHz band.
+	 */
+	if (capab & WLAN_CAPABILITY_SPECTRUM_MGMT &&
+	    (sband->band != NL80211_BAND_6GHZ ||
+	     !ext_capa || ext_capa->datalen < 1 ||
+	     !(ext_capa->data[0] & WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING))) {
 		/* TODO: get this in reg domain format */
 		pos = skb_put(skb, 2 * sband->n_channels + 2);
 		*pos++ = WLAN_EID_SUPPORTED_CHANNELS;
@@ -835,18 +850,9 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	/* Set MBSSID support for HE AP if needed */
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
-	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) && assoc_data->ie_len) {
-		struct element *elem;
-
-		/* we know it's writable, cast away the const */
-		elem = (void *)cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
-						  assoc_data->ie,
-						  assoc_data->ie_len);
-
-		/* We can probably assume both always true */
-		if (elem && elem->datalen >= 3)
-			elem->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
-	}
+	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) && assoc_data->ie_len &&
+	    ext_capa && ext_capa->datalen >= 3)
+		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
 	/* if present, add any custom IEs that go before HT */
 	if (assoc_data->ie_len) {
-- 
2.24.1

