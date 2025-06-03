Return-Path: <linux-wireless+bounces-23540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B7ACBF9C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 07:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D5C3A1D07
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 05:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247813B293;
	Tue,  3 Jun 2025 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="lPjOzJXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9912E1CD
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928964; cv=none; b=pTiajlctofMUhk81sE7BF90BehN3ILhOKC1UazOI0Q9nb4J5Fxe3alfvo9BfhQP0H17G19a1yKsr6xkBUTz1qZ950R6UL3uL7hO8RNj5D4u6+n1/oJZtEIpdepQ3b6KeMcW6F9+kHnurj12BO5F3+A23HbBCogSTtJLQOqscdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928964; c=relaxed/simple;
	bh=LYeWfKKqjLW77Us4qulyZDSL1TLK/WcVhz9gbb7xrds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K72o9HCqgqnV8npx+qlAduzD+sE1ef3okSPxrRloEDM4wDgFnXJwvKZnBnXSN812h5LyLls4IX4Hts4Ur8ZHl44+nimHIkyqBq8QLCYpp0iiMuptnMIhx0a/wGH1H45eSPGvvY5LMB7YWTszRHZoKCzKRZCIiTz78dL4F81n8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=lPjOzJXj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso5115767a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1748928961; x=1749533761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaHgFpw7Ly84RzMFtRH51T4lQLe6O07CLCBd+F2izN8=;
        b=lPjOzJXjU/L+D0aih+MVI6vgjRJxMrV03Q5cR72GwCvYZCHbzj7kWiN5UegNpwvKPR
         qDyr6zzVgBG3alGge2PKDOLI2pwKiuvDqmD3rY9Tp4XSdFLJkN/MTGEAHYW+XhUTYBRY
         bhmtZfVXhoHTnL1Az+mle1IHH2ot8oOZxwZq0rmuk7+qRlqU+bEW0xe27qpd/5qzXXiv
         qmFmu4RL8nRULtNMzjgepvmg6FLbjQaRBwT3EW7moZ9gX8GAk7936DJiCfsGUx45Qba7
         j6z1TpwfcrqjGfzEYmWCWEWnV2aSE3plDitt9FOcFZTWXc37Xf677DdQg1HEioWiHpSk
         WKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748928961; x=1749533761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaHgFpw7Ly84RzMFtRH51T4lQLe6O07CLCBd+F2izN8=;
        b=J9il/5YLkzyPLRCHPegKafIYjP3dFrpFnbQej0nR1HntHJFOFdJtdnFcvr9vQuDam3
         fFrOS7db2BdRzoN5mr5ZlHzMmNuKWS/k1WOMTzbJtsYk6icHcnFtqpM1AhUpbwwyGVzL
         S5BbJD3PI3hQVFaWjumkS0YbQNP9cmBEDX47sLphy4bYqeyaPHCwwFphzk3IiOPCLOZj
         FOWJ9vlIZq2EmriBSXjMBv6MYJP72UptyEMSR4ymoS9u+hhUFVq4Ikvhk90v3TnP3Bfa
         EVf08hhC0e6JfYI3iZCkXwLXku7TiEldhA5U5llQ9I4eCbvCBrjhd2YPUbh3cEj/vkVv
         cvIQ==
X-Gm-Message-State: AOJu0Yx7PGV0ZI9zmt93IJ+Dhf/tUg+5nYm7OqvcX+IcP7G+r4Xa4ePs
	w+wBMm6sgG2nQdE3ZohC/bpk7H4XsGwqR0/fjREmubInkxNvrhvwFRfegRx0zSRd3N/6vXDu1M3
	ltz1kvcs=
X-Gm-Gg: ASbGncs/vp99dqz99XmfD17aR1vDQRIuVz5mKte0TjKTh5a4NrqSAw+HMEkIXbvdohz
	XyqWSkOxqRMle4CGJJIJbrcK9i0SYleZZ3cplrRCTnH99Vx5wxsLXT/Dx+8Pa9rle2JEWTNpNVQ
	sKdeNMo5104nB9q6hhezORo3NNo/uVm374g9TpY8s5gO+gPdXeWeIHB/C3+sruioUEx7BTmWyAy
	wK2fuqgPml3cx+5FYXiNRU5H+Ex17W35JkpAiCqntxquo4tjBMsb40JKwir8dK8zTSJTOv0ebJz
	B+d48DX9BV/VVond8GX9hbS2AtC+2USf/X6nf28XuXQ7PDtwr9Wp3CaXuPtJk6sd9rXkR+XE0Cp
	LelC3R0i3nQliblwz/QWW7Laj
X-Google-Smtp-Source: AGHT+IEpnMF5XzRVveqSGZ+60rrt5SxcIPIATjmxzLyAVOibTWzHTjCtW4JlN/FP9mXB/aahs9wnRg==
X-Received: by 2002:a17:90b:3c07:b0:312:959:dc4d with SMTP id 98e67ed59e1d1-31250344834mr22902871a91.7.1748928961442;
        Mon, 02 Jun 2025 22:36:01 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf44cbsm79796175ad.167.2025.06.02.22.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:36:01 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless,v2] wifi: mac80211/cfg80211: correctly parse S1G beacon optional elements
Date: Tue,  3 Jun 2025 15:35:38 +1000
Message-ID: <20250603053538.468562-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G beacons are not traditional beacons but a type of extension frame.
Extension frames contain the frame control and duration fields, followed
by zero or more optional fields before the frame body. These optional
fields are distinct from the variable length elements.

The presence of optional fields is indicated in the frame control field.
To correctly locate the elements offset, the frame control must be parsed
to identify which optional fields are present. Currently, mac80211 parses
S1G beacons based on fixed assumptions about the frame layout, without
inspecting the frame control field. This can result in incorrect offsets
to the "variable" portion of the frame.

This patch adds proper support for parsing S1G beacon frames by using
the field lengths defined in IEEE 802.11-2024, section 9.3.4.3, ensuring
that the elements offset is calculated accurately.

Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Fixes: cd418ba63f0c ("mac80211: convert S1G beacon to scan results")

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v1 -> v2:
 - Cleaned up code style + comment style
 - Removed unnecessary cast
 - Used the term elements rather then information elements / IEs
 - Referenced both mac80211 and cfg80211 patches that this patch fixes
---
 include/linux/ieee80211.h | 79 ++++++++++++++++++++++++++++++++++-----
 net/mac80211/mlme.c       |  7 +---
 net/mac80211/scan.c       | 11 +++---
 net/wireless/scan.c       | 18 ++++-----
 4 files changed, 83 insertions(+), 32 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 420c7f9aa6ee..d3e8518fdc02 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -111,6 +111,8 @@
 
 /* bits unique to S1G beacon */
 #define IEEE80211_S1G_BCN_NEXT_TBTT	0x100
+#define IEEE80211_S1G_BCN_CSSID     0x200
+#define IEEE80211_S1G_BCN_ANO       0x400
 
 /* see 802.11ah-2016 9.9 NDP CMAC frames */
 #define IEEE80211_S1G_1MHZ_NDP_BITS	25
@@ -153,9 +155,6 @@
 
 #define IEEE80211_ANO_NETTYPE_WILD              15
 
-/* bits unique to S1G beacon */
-#define IEEE80211_S1G_BCN_NEXT_TBTT    0x100
-
 /* control extension - for IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTL_EXT */
 #define IEEE80211_CTL_EXT_POLL		0x2000
 #define IEEE80211_CTL_EXT_SPR		0x3000
@@ -627,6 +626,42 @@ static inline bool ieee80211_is_s1g_beacon(__le16 fc)
 	       cpu_to_le16(IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON);
 }
 
+/**
+ * ieee80211_s1g_has_next_tbtt - check if IEEE80211_S1G_BCN_NEXT_TBTT
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame contains the variable-length
+ *	next TBTT field
+ */
+static inline bool ieee80211_s1g_has_next_tbtt(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT));
+}
+
+/**
+ * ieee80211_s1g_has_ano - check if IEEE80211_S1G_BCN_ANO
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame contains the variable-length
+ *	ANO field
+ */
+static inline bool ieee80211_s1g_has_ano(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_ANO));
+}
+
+/**
+ * ieee80211_s1g_has_cssid - check if IEEE80211_S1G_BCN_CSSID
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame contains the variable-length
+ *	compressed SSID field
+ */
+static inline bool ieee80211_s1g_has_cssid(__le16 fc)
+{
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_CSSID));
+}
+
 /**
  * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
  * @fc: frame control bytes in little-endian byteorder
@@ -1245,16 +1280,40 @@ struct ieee80211_ext {
 			u8 change_seq;
 			u8 variable[0];
 		} __packed s1g_beacon;
-		struct {
-			u8 sa[ETH_ALEN];
-			__le32 timestamp;
-			u8 change_seq;
-			u8 next_tbtt[3];
-			u8 variable[0];
-		} __packed s1g_short_beacon;
 	} u;
 } __packed __aligned(2);
 
+/**
+ * ieee80211_s1g_optional_len - determine length of optional S1G beacon fields
+ * @fc: frame control bytes in little-endian byteorder
+ * Return: total length in bytes of the optional fixed-length fields
+ *
+ * S1G beacons may contain up to three optional fixed-length fields that
+ * precede the variable-length elements. Whether these fields are present
+ * is indicated by flags in the frame control field.
+ *
+ * From IEEE 802.11-2024 section 9.3.4.3:
+ *  - Next TBTT field may be 0 or 3 bytes
+ *  - Short SSID field may be 0 or 4 bytes
+ *  - Access Network Options (ANO) field may be 0 or 1 byte
+ */
+static inline size_t
+ieee80211_s1g_optional_len(__le16 fc)
+{
+	size_t len = 0;
+
+	if (ieee80211_s1g_has_next_tbtt(fc))
+		len += 3;
+
+	if (ieee80211_s1g_has_cssid(fc))
+		len += 4;
+
+	if (ieee80211_s1g_has_ano(fc))
+		len += 1;
+
+	return len;
+}
+
 #define IEEE80211_TWT_CONTROL_NDP			BIT(0)
 #define IEEE80211_TWT_CONTROL_RESP_MODE			BIT(1)
 #define IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST	BIT(3)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b84150dbfe8c..948909a242d6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7220,11 +7220,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	bssid = ieee80211_get_bssid(hdr, len, sdata->vif.type);
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		struct ieee80211_ext *ext = (void *) mgmt;
-
-		if (ieee80211_is_s1g_short_beacon(ext->frame_control))
-			variable = ext->u.s1g_short_beacon.variable;
-		else
-			variable = ext->u.s1g_beacon.variable;
+		variable = ext->u.s1g_beacon.variable +
+			   ieee80211_s1g_optional_len(ext->frame_control);
 	}
 
 	baselen = (u8 *) variable - (u8 *) mgmt;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 7b8da40a912d..cd8385ecafd9 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -276,6 +276,7 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
+	struct ieee80211_ext *ext;
 	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
 
@@ -285,12 +286,10 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		return;
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_short_beacon.variable);
-		else
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_beacon);
+		ext = (struct ieee80211_ext *)mgmt;
+		min_hdr_len =
+			offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+			ieee80211_s1g_optional_len(ext->frame_control);
 	}
 
 	if (skb->len < min_hdr_len)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ddd3a97f6609..e8a4fe44ec2d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3250,6 +3250,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	const u8 *ie;
 	size_t ielen;
 	u64 tsf;
+	size_t s1g_optional_len;
 
 	if (WARN_ON(!mgmt))
 		return NULL;
@@ -3264,12 +3265,11 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		ext = (void *) mgmt;
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_short_beacon.variable);
-		else
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_beacon.variable);
+		s1g_optional_len =
+			ieee80211_s1g_optional_len(ext->frame_control);
+		min_hdr_len =
+			offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+			s1g_optional_len;
 	} else {
 		/* same for beacons */
 		min_hdr_len = offsetof(struct ieee80211_mgmt,
@@ -3285,11 +3285,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		const struct ieee80211_s1g_bcn_compat_ie *compat;
 		const struct element *elem;
 
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			ie = ext->u.s1g_short_beacon.variable;
-		else
-			ie = ext->u.s1g_beacon.variable;
-
+		ie = ext->u.s1g_beacon.variable + s1g_optional_len;
 		elem = cfg80211_find_elem(WLAN_EID_S1G_BCN_COMPAT, ie, ielen);
 		if (!elem)
 			return NULL;
-- 
2.43.0


