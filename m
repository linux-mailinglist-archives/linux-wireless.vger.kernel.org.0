Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26D57333B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiGMJqF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiGMJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6303CF511B
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RLyTVqi3wvcE/lYDQKMSjcKYAywTka8zZF+v+5Q2LDQ=;
        t=1657705521; x=1658915121; b=VwyDFRR8jSfTaA4a83xMHR1+CEDujuNk6pPKBU+3vzM0K+H
        MMKGKdE/doe41RrPdBrN8vmC4Rw/NggM8zJW5EWmLG4CS18Wry42D+DQjr8Ntg/HVpPFexkUV+fGA
        UaGUs9YjNscb231izpMjZ7LPf001wEEIfJFR2QbHYnecwx/cZfbe31Uib0RWkl+62FIROrGyB4qet
        X+F6BIuz8AxToRUfdzCN8FzUvi9mlZTxJ0ImP37UUF+N2tOqCN2nvKkslXY/bKc8fYpICNQTis4Vo
        w13f/lVSTeyXpI19mI+NT/xKvHhrGnVgcf2MHKM5QvBI1uU8PIB3FcEGKXKLBNow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvm-00EgvB-6N;
        Wed, 13 Jul 2022 11:45:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 44/76] wifi: mac80211: refactor elements parsing with parameter struct
Date:   Wed, 13 Jul 2022 11:44:30 +0200
Message-Id: <20220713114425.5729d43a982c.Ibb04bf878234e2650afac6e54ecfff669ea55308@changeid>
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

Refactor the element parsing into a version that has
a parameter struct so we can add more parameters more
easily in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 50 ++++++++++++++++++++++++++++----
 net/mac80211/util.c        | 58 +++++++++++++++++++-------------------
 2 files changed, 74 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a0743c78d171..2cf13ea4c9f7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2138,11 +2138,51 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb_tid(sdata, skb, 7);
 }
 
-struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
-						    bool action,
-						    u64 filter, u32 crc,
-						    const u8 *transmitter_bssid,
-						    const u8 *bss_bssid);
+/**
+ * struct ieee80211_elems_parse_params - element parsing parameters
+ * @start: pointer to the elements
+ * @len: length of the elements
+ * @action: %true if the elements came from an action frame
+ * @filter: bitmap of element IDs to filter out while calculating
+ *	the element CRC
+ * @crc: CRC starting value
+ * @transmitter_bssid: transmitter BSSID to parse the multi-BSSID
+ *	element
+ * @bss_bssid: BSSID of the BSS we want to obtain elements for
+ *	when parsing the multi-BSSID element
+ */
+struct ieee80211_elems_parse_params {
+	const u8 *start;
+	size_t len;
+	bool action;
+	u64 filter;
+	u32 crc;
+	const u8 *transmitter_bssid;
+	const u8 *bss_bssid;
+};
+
+struct ieee802_11_elems *
+ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params);
+
+static inline struct ieee802_11_elems *
+ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
+			   u64 filter, u32 crc,
+			   const u8 *transmitter_bssid,
+			   const u8 *bss_bssid)
+{
+	struct ieee80211_elems_parse_params params = {
+		.start = start,
+		.len = len,
+		.action = action,
+		.filter = filter,
+		.crc = crc,
+		.transmitter_bssid = transmitter_bssid,
+		.bss_bssid = bss_bssid,
+	};
+
+	return ieee802_11_parse_elems_full(&params);
+}
+
 static inline struct ieee802_11_elems *
 ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
 		       const u8 *transmitter_bssid,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 85d08cbe0b51..78fb0c3aa4ad 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1023,19 +1023,19 @@ static void ieee80211_parse_extension_element(u32 *crc,
 }
 
 static u32
-_ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
-			    struct ieee802_11_elems *elems,
-			    u64 filter, u32 crc,
-			    const struct element *check_inherit)
+_ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
+			     struct ieee802_11_elems *elems,
+			     const struct element *check_inherit)
 {
 	const struct element *elem;
-	bool calc_crc = filter != 0;
+	bool calc_crc = params->filter != 0;
 	DECLARE_BITMAP(seen_elems, 256);
+	u32 crc = params->crc;
 	const u8 *ie;
 
 	bitmap_zero(seen_elems, 256);
 
-	for_each_element(elem, start, len) {
+	for_each_element(elem, params->start, params->len) {
 		bool elem_parse_failed;
 		u8 id = elem->id;
 		u8 elen = elem->datalen;
@@ -1098,7 +1098,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			break;
 		}
 
-		if (calc_crc && id < 64 && (filter & (1ULL << id)))
+		if (calc_crc && id < 64 && (params->filter & (1ULL << id)))
 			crc = crc32_be(crc, pos - 2, elen + 2);
 
 		elem_parse_failed = false;
@@ -1279,7 +1279,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			elems->mesh_chansw_params_ie = (void *)pos;
 			break;
 		case WLAN_EID_WIDE_BW_CHANNEL_SWITCH:
-			if (!action ||
+			if (!params->action ||
 			    elen < sizeof(*elems->wide_bw_chansw_ie)) {
 				elem_parse_failed = true;
 				break;
@@ -1287,7 +1287,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			elems->wide_bw_chansw_ie = (void *)pos;
 			break;
 		case WLAN_EID_CHANNEL_SWITCH_WRAPPER:
-			if (action) {
+			if (params->action) {
 				elem_parse_failed = true;
 				break;
 			}
@@ -1414,7 +1414,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			__set_bit(id, seen_elems);
 	}
 
-	if (!for_each_element_completed(elem, start, len))
+	if (!for_each_element_completed(elem, params->start, params->len))
 		elems->parse_error = true;
 
 	return crc;
@@ -1488,11 +1488,8 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 	return found ? profile_len : 0;
 }
 
-struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
-						    bool action, u64 filter,
-						    u32 crc,
-						    const u8 *transmitter_bssid,
-						    const u8 *bss_bssid)
+struct ieee802_11_elems *
+ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
 	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
@@ -1502,15 +1499,16 @@ struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
 	elems = kzalloc(sizeof(*elems), GFP_ATOMIC);
 	if (!elems)
 		return NULL;
-	elems->ie_start = start;
-	elems->total_len = len;
+	elems->ie_start = params->start;
+	elems->total_len = params->len;
 
-	nontransmitted_profile = kmalloc(len, GFP_ATOMIC);
+	nontransmitted_profile = kmalloc(params->len, GFP_ATOMIC);
 	if (nontransmitted_profile) {
 		nontransmitted_profile_len =
-			ieee802_11_find_bssid_profile(start, len, elems,
-						      transmitter_bssid,
-						      bss_bssid,
+			ieee802_11_find_bssid_profile(params->start, params->len,
+						      elems,
+						      params->transmitter_bssid,
+						      params->bss_bssid,
 						      nontransmitted_profile);
 		non_inherit =
 			cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
@@ -1518,14 +1516,18 @@ struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
 					       nontransmitted_profile_len);
 	}
 
-	crc = _ieee802_11_parse_elems_crc(start, len, action, elems, filter,
-					  crc, non_inherit);
+	elems->crc = _ieee802_11_parse_elems_full(params, elems, non_inherit);
 
 	/* Override with nontransmitted profile, if found */
-	if (nontransmitted_profile_len)
-		_ieee802_11_parse_elems_crc(nontransmitted_profile,
-					    nontransmitted_profile_len,
-					    action, elems, 0, 0, NULL);
+	if (nontransmitted_profile_len) {
+		struct ieee80211_elems_parse_params sub = {
+			.start = nontransmitted_profile,
+			.len = nontransmitted_profile_len,
+			.action = params->action,
+		};
+
+		_ieee802_11_parse_elems_full(&sub, elems, NULL);
+	}
 
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
@@ -1547,8 +1549,6 @@ struct ieee802_11_elems *ieee802_11_parse_elems_crc(const u8 *start, size_t len,
 
 	kfree(nontransmitted_profile);
 
-	elems->crc = crc;
-
 	return elems;
 }
 
-- 
2.36.1

