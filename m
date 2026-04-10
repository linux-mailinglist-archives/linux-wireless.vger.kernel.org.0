Return-Path: <linux-wireless+bounces-34634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI9fOb9J2WmkoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:04:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA53DBC52
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9110301F6B9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3058345CA3;
	Fri, 10 Apr 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="YAAxZLiN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC0342535
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847843; cv=none; b=rKUXZg0nSax33sjnnwVWVZfiNL1kTEOGQC+yfvwSwbYOu+NDiGkEMaahLiw8F8PzGUSyED6Hk2vk5Wd1LL1uRVGodZ+uhZFzlAvoR7miILI9Z/TSUca0HSQvRSy2buS9IcGnyX4/WIyBxlfji6wYzNLokgrLMokN2SGqHI/8x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847843; c=relaxed/simple;
	bh=PaMpwg7Wti3eTQwd8p9EuuPqs9HZqUvfTDQ+uzJf7MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8Kcjg+u7mzt+Z2AK/AH7ZjdSyEdWXmEx0r4L65YOCNAYAq4EkiSsFdGjne+c+tsG8Jz0f/oXVDp7fyZSemLFeggF256qCMgGClrOs3WYUZP+aFseZtTS3byCMFXvD6YjFR3ykPr5Hz0rcoKvOny7ay73mE6aT/bqrPqj/BAtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=YAAxZLiN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488c2690057so23471355e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847840; x=1776452640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43sIH45olHvl8Tty3waVmcPQgIqJ21kq7oBlnHhMIYk=;
        b=YAAxZLiNA7UHBEF2vZbrD2UQhvxUFXUqD5CpJcPBiFKVFM4BhgneOf9Dv1LATSW7ky
         /J40Kso6bau9ro6Wk6xXeDejLIdiC3Yn5kW3ZQBbzHdGXEDFDrTDvj3pMnwSoEv73fFC
         UYrp+D/UTz37II2185GZjBr4rSM2pGTQxJWCokTBsYDObJsU12luLrrPifdUNtq4Af8/
         mBisv0GXjwBcme+dTuAsFwyPtnxZzzw8ECUvYv9mFfHvWnaDp3dsW5jw3ZigAFkyl0cw
         LMA3GeNwHPmeSfji9UsvghCxAsCpTbBdNhX/06WuJWRd9SLClDPRNh2XRNsWGBddlgtN
         rKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847840; x=1776452640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43sIH45olHvl8Tty3waVmcPQgIqJ21kq7oBlnHhMIYk=;
        b=WZfxdmB2FE8Q1DpSDKTnFRYQbrn/4iS33WdqnA0DmbQxSUMonoYEUG6xjY2aG2mmdl
         dcO7WxjoN53fnPXSyWB504IBIUL8gTgypn2RPYEs+AaCMaoZJmmuHHKywcri4RaaVhEt
         mEXFzF6jGvcwzkb924xlN7Hu2UocuF34/U/bLYv8zI1AGX++N9uZBZ/MMbaZxPQJYit7
         pcRypLulXcd1zzoRRB44Z0pgZ+KLj1r7wRf6ewPdWIOIVa7lE4xcu99Sfn3AJEixM1Wn
         FmX2eZ0LYoxKToYNrJ9Y1mLTdNLBwHHcP/l/7XH/UTaGKBYsCpw3sSlrHbM8G9kOldlz
         yrWg==
X-Gm-Message-State: AOJu0Yws+66Bro0EOgAhfHG1mgKj5F5lZckOZTWyps0XeiBieSkP8IrI
	WRFmor5FwOESUoGL780Pw2IS35ZydQlRClh7hBx8yak65dJth/il9+PMVe6ucHDtiec=
X-Gm-Gg: AeBDies7YFFsisFlZ7lO0uFJ3p34AQWFsxwkaa+ONPwXqx6ACvWTxGGjHP1YXw8yw6s
	UoEN3SX8tpae6d+BgYQ8BhhUFjrf3CyCYONg15sasO1KOOaJP7XF1rD2uMKQHWDuvq6mh9SZbEI
	q0thZtlgRV6c46uI836PdkSnqN/FOCnByyKZ749jEenOfKZ5kmK4rjM1qN5PGZI7glo6nKHIrBr
	QIU/+Drj6BH4+DdJH4wEUy6jeLjCTnV/18fWajoXYZjIcGrhqgJccgYPbfZLoWrB/E2l2wxN19Z
	rzYamO+jnyxrQipIt54mqdLNipVQ3/WXESKZ37WU/IevoL9PdAdyWjyzhzInkolaCBVBsxVLcdv
	iK0EVDqBWZ3EfMajxSiiGYTfPNh2LjpVmvRrpsfJzxZikW/g8fBjwiXkpvDeNudTSavrQvpRrhH
	WH2mVn3Q74662f94GajHJduWQkHv48qB8p1NJWo1Ta43eBHYtSsigDu0j2BNT2dYELXm0wtGH+o
	XsEwUPefN15
X-Received: by 2002:a05:600c:c173:b0:485:39d1:b4dd with SMTP id 5b1f17b1804b1-488d684b024mr58593965e9.10.1775847840385;
        Fri, 10 Apr 2026 12:04:00 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:04:00 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 3/7] wifi: make HE capa size check not read reserved bits
Date: Fri, 10 Apr 2026 21:03:50 +0200
Message-ID: <20260410190354.394742-4-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34634-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAAA53DBC52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ieee80211_he_mcs_nss_size() reads the value of reserved bits to deduce
the current band used assuming the reserved bits are set to 0.

However, Mediatek's chipsets MT7927 and MT7925 with Windows driver 5.4.0.3044
(and earlier versions) set the bits in Supported Channel Width Set subfield
of the HE PHY Capabilities Information field, regardless of the current band.
This causes the kernel to miscalculate mcs_nss_size to 3 bytes, resulting in
a incorrect rx/tx nss map, so the sta is believed to have 0 NSS for 160/320.

Pass the band to ieee80211_he_mcs_nss_size() to only read non reserved
bits in the Supported Channel Width Set subfield.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 include/linux/ieee80211-he.h | 21 ++++++++++++---------
 net/mac80211/he.c            |  9 ++++++---
 net/mac80211/mlme.c          |  2 +-
 net/mac80211/util.c          |  4 ++--
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/ieee80211-he.h b/include/linux/ieee80211-he.h
index a08c446fbb04..7b2f160a15b5 100644
--- a/include/linux/ieee80211-he.h
+++ b/include/linux/ieee80211-he.h
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/if_ether.h>
+#include <linux/nl80211.h>
 
 #define IEEE80211_TWT_CONTROL_NDP			BIT(0)
 #define IEEE80211_TWT_CONTROL_RESP_MODE			BIT(1)
@@ -452,17 +453,19 @@ enum ieee80211_he_highest_mcs_supported_subfield_enc {
 
 /* Calculate 802.11ax HE capabilities IE Tx/Rx HE MCS NSS Support Field size */
 static inline u8
-ieee80211_he_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap)
+ieee80211_he_mcs_nss_size(const struct ieee80211_he_cap_elem *he_cap, enum nl80211_band band)
 {
 	u8 count = 4;
 
-	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
-		count += 4;
+	if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
+		if (he_cap->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
+			count += 4;
 
-	if (he_cap->phy_cap_info[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-		count += 4;
+		if (he_cap->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			count += 4;
+	}
 
 	return count;
 }
@@ -506,7 +509,7 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 	return n;
 }
 
-static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
+static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len, enum nl80211_band band)
 {
 	const struct ieee80211_he_cap_elem *he_cap_ie_elem = (const void *)data;
 	u8 needed = sizeof(*he_cap_ie_elem);
@@ -514,7 +517,7 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 	if (len < needed)
 		return false;
 
-	needed += ieee80211_he_mcs_nss_size(he_cap_ie_elem);
+	needed += ieee80211_he_mcs_nss_size(he_cap_ie_elem, band);
 	if (len < needed)
 		return false;
 
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 93e0342cff4f..4f3bafceb243 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -8,6 +8,7 @@
 
 #include "ieee80211_i.h"
 #include "rate.h"
+#include <linux/nl80211.h>
 
 static void
 ieee80211_update_from_he_6ghz_capa(const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
@@ -112,7 +113,8 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				   const struct ieee80211_sta_he_cap *own_he_cap_ptr,
 				   const u8 *he_cap_ie, u8 he_cap_len,
 				   const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
-				   struct link_sta_info *link_sta)
+				   struct link_sta_info *link_sta,
+				   enum nl80211_band band)
 {
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
 	struct ieee80211_sta_he_cap own_he_cap;
@@ -130,7 +132,7 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 	own_he_cap = *own_he_cap_ptr;
 
 	/* Make sure size is OK */
-	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap_ie_elem);
+	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap_ie_elem, band);
 	he_ppe_size =
 		ieee80211_he_ppe_size(he_cap_ie[sizeof(he_cap->he_cap_elem) +
 						mcs_nss_size],
@@ -215,7 +217,8 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 					   he_cap_len,
 					   (sband->band == NL80211_BAND_6GHZ) ?
 						he_6ghz_capa : NULL,
-					   link_sta);
+					   link_sta,
+					   sband->band);
 }
 
 void
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7fc5616cb244..4c1e5259837e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5933,7 +5933,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 
 	/* skip one byte ext_tag_id */
 	he_cap = (void *)(he_cap_elem->data + 1);
-	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
+	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap, cbss->channel->band);
 
 	/* invalid HE IE */
 	if (he_cap_elem->datalen < 1 + mcs_nss_size + sizeof(*he_cap))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8e0c7ec95827..e2e44f3f4670 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2491,7 +2491,7 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata)
 	if (!he_cap)
 		return 0;
 
-	n = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
+	n = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem, sband->band);
 	return 2 + 1 +
 	       sizeof(he_cap->he_cap_elem) + n +
 	       ieee80211_he_ppe_size(he_cap->ppe_thres[0],
@@ -2568,7 +2568,7 @@ int ieee80211_put_he_cap(struct sk_buff *skb,
 	/* modify on stack first to calculate 'n' and 'ie_len' correctly */
 	ieee80211_get_adjusted_he_cap(conn, he_cap, &elem);
 
-	n = ieee80211_he_mcs_nss_size(&elem);
+	n = ieee80211_he_mcs_nss_size(&elem, sband->band);
 	ie_len = 2 + 1 +
 		 sizeof(he_cap->he_cap_elem) + n +
 		 ieee80211_he_ppe_size(he_cap->ppe_thres[0],
-- 
2.43.0


