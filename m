Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7AD57335C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiGMJqc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiGMJpd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A09F6830
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jdhcQglGBX/kKsb3TZgWVbsR9yCMB8Mf1eGS4DXYiZM=;
        t=1657705525; x=1658915125; b=H38exBtPdqQJeyKT5vKmwjeqZiFZjOpCIyZL9aYIAfOtFol
        v6UAf9JWAZ3EtavOs4tWQwZCFzkDzRVOxpGeolpT5vfn0kfuVttADPcx92os8J11ceIgZUg9ohgoz
        +x1jBKNS7WucDyCSAUxeuB2kXsyB3ntJcLufgmE61Wc6n0g8P9WqKIuzBRSMtjqzvDCDSdwf/eRjL
        ipP3EhNdlyniSpVuESSRC0TOVsB1vMWxc33jjRejCBEpaqGpBuCS+mpYNaxhfxK63JtlcTpneidyX
        XJ584DbEKU1l29z9tie8bqJT6MOfSYIm5woOL20d9a6o/2z7o9C5qxjh+gb+w4cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvr-00EgvB-T2;
        Wed, 13 Jul 2022 11:45:24 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 54/76] wifi: mac80211: refactor adding custom elements
Date:   Wed, 13 Jul 2022 11:44:40 +0200
Message-Id: <20220713114425.a5f550da0b0a.Icbed923cede8717295b8c651af8a524ebc48dbb6@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Rework the sorting of custom elements into the association
request by moving the elements before HT/VHT/HE to each
their own function. While at it, fix the placement of the
ones that should be between VHT and HE.

This doesn't fix the placement of elements that should be
between HE and EHT yet, a similar change might be needed
in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 212 ++++++++++++++++++++++++++------------------
 1 file changed, 125 insertions(+), 87 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a442de3670b9..36cce750528a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -839,6 +839,120 @@ static void ieee80211_assoc_add_rates(struct sk_buff *skb,
 	}
 }
 
+static size_t ieee80211_add_before_ht_elems(struct sk_buff *skb,
+					    const u8 *elems,
+					    size_t elems_len,
+					    size_t offset)
+{
+	size_t noffset;
+
+	static const u8 before_ht[] = {
+		WLAN_EID_SSID,
+		WLAN_EID_SUPP_RATES,
+		WLAN_EID_EXT_SUPP_RATES,
+		WLAN_EID_PWR_CAPABILITY,
+		WLAN_EID_SUPPORTED_CHANNELS,
+		WLAN_EID_RSN,
+		WLAN_EID_QOS_CAPA,
+		WLAN_EID_RRM_ENABLED_CAPABILITIES,
+		WLAN_EID_MOBILITY_DOMAIN,
+		WLAN_EID_FAST_BSS_TRANSITION,	/* reassoc only */
+		WLAN_EID_RIC_DATA,		/* reassoc only */
+		WLAN_EID_SUPPORTED_REGULATORY_CLASSES,
+	};
+	static const u8 after_ric[] = {
+		WLAN_EID_SUPPORTED_REGULATORY_CLASSES,
+		WLAN_EID_HT_CAPABILITY,
+		WLAN_EID_BSS_COEX_2040,
+		/* luckily this is almost always there */
+		WLAN_EID_EXT_CAPABILITY,
+		WLAN_EID_QOS_TRAFFIC_CAPA,
+		WLAN_EID_TIM_BCAST_REQ,
+		WLAN_EID_INTERWORKING,
+		/* 60 GHz (Multi-band, DMG, MMS) can't happen */
+		WLAN_EID_VHT_CAPABILITY,
+		WLAN_EID_OPMODE_NOTIF,
+	};
+
+	if (!elems_len)
+		return offset;
+
+	noffset = ieee80211_ie_split_ric(elems, elems_len,
+					 before_ht,
+					 ARRAY_SIZE(before_ht),
+					 after_ric,
+					 ARRAY_SIZE(after_ric),
+					 offset);
+	skb_put_data(skb, elems + offset, noffset - offset);
+
+	return noffset;
+}
+
+static size_t ieee80211_add_before_vht_elems(struct sk_buff *skb,
+					     const u8 *elems,
+					     size_t elems_len,
+					     size_t offset)
+{
+	static const u8 before_vht[] = {
+		/*
+		 * no need to list the ones split off before HT
+		 * or generated here
+		 */
+		WLAN_EID_BSS_COEX_2040,
+		WLAN_EID_EXT_CAPABILITY,
+		WLAN_EID_QOS_TRAFFIC_CAPA,
+		WLAN_EID_TIM_BCAST_REQ,
+		WLAN_EID_INTERWORKING,
+		/* 60 GHz (Multi-band, DMG, MMS) can't happen */
+	};
+	size_t noffset;
+
+	if (!elems_len)
+		return offset;
+
+	/* RIC already taken care of in ieee80211_add_before_ht_elems() */
+	noffset = ieee80211_ie_split(elems, elems_len,
+				     before_vht, ARRAY_SIZE(before_vht),
+				     offset);
+	skb_put_data(skb, elems + offset, noffset - offset);
+
+	return noffset;
+}
+
+static size_t ieee80211_add_before_he_elems(struct sk_buff *skb,
+					    const u8 *elems,
+					    size_t elems_len,
+					    size_t offset)
+{
+	static const u8 before_he[] = {
+		/*
+		 * no need to list the ones split off before VHT
+		 * or generated here
+		 */
+		WLAN_EID_OPMODE_NOTIF,
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_FUTURE_CHAN_GUIDANCE,
+		/* 11ai elements */
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_SESSION,
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_PUBLIC_KEY,
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_KEY_CONFIRM,
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_HLP_CONTAINER,
+		WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_IP_ADDR_ASSIGN,
+		/* TODO: add 11ah/11aj/11ak elements */
+	};
+	size_t noffset;
+
+	if (!elems_len)
+		return offset;
+
+	/* RIC already taken care of in ieee80211_add_before_ht_elems() */
+	noffset = ieee80211_ie_split(elems, elems_len,
+				     before_he, ARRAY_SIZE(before_he),
+				     offset);
+	skb_put_data(skb, elems + offset, noffset - offset);
+
+	return noffset;
+}
+
 static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -994,45 +1108,9 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
 
 	/* if present, add any custom IEs that go before HT */
-	if (assoc_data->ie_len) {
-		static const u8 before_ht[] = {
-			WLAN_EID_SSID,
-			WLAN_EID_SUPP_RATES,
-			WLAN_EID_EXT_SUPP_RATES,
-			WLAN_EID_PWR_CAPABILITY,
-			WLAN_EID_SUPPORTED_CHANNELS,
-			WLAN_EID_RSN,
-			WLAN_EID_QOS_CAPA,
-			WLAN_EID_RRM_ENABLED_CAPABILITIES,
-			WLAN_EID_MOBILITY_DOMAIN,
-			WLAN_EID_FAST_BSS_TRANSITION,	/* reassoc only */
-			WLAN_EID_RIC_DATA,		/* reassoc only */
-			WLAN_EID_SUPPORTED_REGULATORY_CLASSES,
-		};
-		static const u8 after_ric[] = {
-			WLAN_EID_SUPPORTED_REGULATORY_CLASSES,
-			WLAN_EID_HT_CAPABILITY,
-			WLAN_EID_BSS_COEX_2040,
-			/* luckily this is almost always there */
-			WLAN_EID_EXT_CAPABILITY,
-			WLAN_EID_QOS_TRAFFIC_CAPA,
-			WLAN_EID_TIM_BCAST_REQ,
-			WLAN_EID_INTERWORKING,
-			/* 60 GHz (Multi-band, DMG, MMS) can't happen */
-			WLAN_EID_VHT_CAPABILITY,
-			WLAN_EID_OPMODE_NOTIF,
-		};
-
-		noffset = ieee80211_ie_split_ric(assoc_data->ie,
-						 assoc_data->ie_len,
-						 before_ht,
-						 ARRAY_SIZE(before_ht),
-						 after_ric,
-						 ARRAY_SIZE(after_ric),
-						 offset);
-		skb_put_data(skb, assoc_data->ie + offset, noffset - offset);
-		offset = noffset;
-	}
+	offset = ieee80211_add_before_ht_elems(skb, assoc_data->ie,
+					       assoc_data->ie_len,
+					       offset);
 
 	if (WARN_ON_ONCE((link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
 			 !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)))
@@ -1044,54 +1122,9 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 				    sband, chan, link->smps_mode);
 
 	/* if present, add any custom IEs that go before VHT */
-	if (assoc_data->ie_len) {
-		static const u8 before_vht[] = {
-			/*
-			 * no need to list the ones split off before HT
-			 * or generated here
-			 */
-			WLAN_EID_BSS_COEX_2040,
-			WLAN_EID_EXT_CAPABILITY,
-			WLAN_EID_QOS_TRAFFIC_CAPA,
-			WLAN_EID_TIM_BCAST_REQ,
-			WLAN_EID_INTERWORKING,
-			/* 60 GHz (Multi-band, DMG, MMS) can't happen */
-		};
-
-		/* RIC already taken above, so no need to handle here anymore */
-		noffset = ieee80211_ie_split(assoc_data->ie, assoc_data->ie_len,
-					     before_vht, ARRAY_SIZE(before_vht),
-					     offset);
-		skb_put_data(skb, assoc_data->ie + offset, noffset - offset);
-		offset = noffset;
-	}
-
-	/* if present, add any custom IEs that go before HE */
-	if (assoc_data->ie_len) {
-		static const u8 before_he[] = {
-			/*
-			 * no need to list the ones split off before VHT
-			 * or generated here
-			 */
-			WLAN_EID_OPMODE_NOTIF,
-			WLAN_EID_EXTENSION, WLAN_EID_EXT_FUTURE_CHAN_GUIDANCE,
-			/* 11ai elements */
-			WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_SESSION,
-			WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_PUBLIC_KEY,
-			WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_KEY_CONFIRM,
-			WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_HLP_CONTAINER,
-			WLAN_EID_EXTENSION, WLAN_EID_EXT_FILS_IP_ADDR_ASSIGN,
-			/* TODO: add 11ah/11aj/11ak elements */
-		};
-
-		/* RIC already taken above, so no need to handle here anymore */
-		noffset = ieee80211_ie_split(assoc_data->ie, assoc_data->ie_len,
-					     before_he, ARRAY_SIZE(before_he),
-					     offset);
-		pos = skb_put(skb, noffset - offset);
-		memcpy(pos, assoc_data->ie + offset, noffset - offset);
-		offset = noffset;
-	}
+	offset = ieee80211_add_before_vht_elems(skb, assoc_data->ie,
+						assoc_data->ie_len,
+						offset);
 
 	if (sband->band != NL80211_BAND_6GHZ &&
 	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
@@ -1108,6 +1141,11 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
 						   IEEE80211_CONN_DISABLE_EHT;
 
+	/* if present, add any custom IEs that go before HE */
+	offset = ieee80211_add_before_he_elems(skb, assoc_data->ie,
+					       assoc_data->ie_len,
+					       offset);
+
 	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
 		ieee80211_add_he_ie(link, skb, sband);
 
-- 
2.36.1

