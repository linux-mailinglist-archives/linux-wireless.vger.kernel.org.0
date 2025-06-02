Return-Path: <linux-wireless+bounces-23525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D8ACA907
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 07:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA017A101
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 05:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD9156F4A;
	Mon,  2 Jun 2025 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="iPPDTQql"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D64191F95
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842568; cv=none; b=gGeO8jc8i3QtQ0qrFahL7u95YWthrDNmZaSpF1VBW8/4b6B2B2dngLnjM+gs5xoFLLLlXr4uevZfNjserW8LZ2FvLk5xS/mV+vi/t1qoaGYWSrFdlDhbLo04Orm8LbwHAbHKI81eq8l4v2FP9jW6+JRqhTqgWcaUBssdMlqehXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842568; c=relaxed/simple;
	bh=vy+DtpXtzcDBCG0Y3OvgTd9Yt1tl8Iy0G+K+VxzZ7Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKeRxX2zvap3C3i/T2JmrQ51vzORj2r09jZdh3ju1ErVeQtFyTMUJAxII5H3TTXQIX/5Q3afWJTf3atzeNzaKrDHvCU0gmgLTUIY5/BebzNUoTlSSwqaAB0J0NjcJsYoOaO1lcd00yLUeaLOwzbYln6RULPD+vF9PJfMO3wVmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=iPPDTQql; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c73f82dfso3090264b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Jun 2025 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1748842563; x=1749447363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXGzm3j+JEDtBqIwg2qI6tvn3jqYXfwMCxYybEGHs1E=;
        b=iPPDTQqlhzchlni+22ifgzVKqIRKT6aLa84LXuRiUhkOy1z3/E4yfdUfzB0Bal4NjQ
         v3H2tZN/HwSvTXKMLIH9C0an/k1fDnCJn8u8p9fTSVFNt8AdixHEiICS60RsLgWcRkih
         na4ZWdPfS2Ab6DWw/6/SbgDmL+xJPCQOqGWB44alYSeGT3X3j2OUY9wUP47uHny0oFwC
         u3pmJHL5Talet98R50GGGejqkSboB4Z4vTKdwSVyfFAPKMMOGxPKm853HI0687NWCJZK
         rrWvjvcM4zMWXIN5Vpo/lIrYwjg1d3lYHDY5hNpjSpZPqKIf9NLhfd9gwcvjYgZY5HsO
         4WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748842563; x=1749447363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXGzm3j+JEDtBqIwg2qI6tvn3jqYXfwMCxYybEGHs1E=;
        b=ACExwVlJzFHHmAlbW85hFx5XrZYRa8cZRQrQY5IUSSan8Uz+HTYE5//WPQOdoCtgp2
         M92ZgCtzSYWChQ95BfZOqW8H5L8Yru1f7XmfKuQVlyRSuhkDNQRH0+PloBGfGB0BxgJW
         4qeo4ii0oxr6FNkPe7PRQPvwIDYu5opzNYcJxnhvoQaDDAAly+BgyKHlW3NvBsWhi24j
         YyUY46ZQJ8tOXuHeFDvCLvTlb0m/AW+uzSWkfzyuMppKouO1FD674Z/vK+l4wPbyvkFD
         WKd3je2Tw8Txuqt4OzvBsWjtEJ5GV8H6Uu8XGYIW3v9r6Fv8SeTkgDkxbdArrBhNRuaH
         93NQ==
X-Gm-Message-State: AOJu0YxZBbJMu+RMgAwxzabaxekrj07xJ6kjVRDxbQ/+mze3i18O0SYc
	ODMijESI0Rc3zWxV18+lCuf/X0Wj5fDkySqMunBLzr6G3JljAXlCSwgzGaUhYIG1fa4=
X-Gm-Gg: ASbGncshqNY7J8Hm2JyY/Z0qzyJ3NdCGNZF3SwvhhEQ/QDvLww+OCIafeG4UBhPfRsy
	7jWxTZOhOgvl5b2UgpZp1+r7fT6kwjK2CsCNO/vwTnzO49n+HAksFTfixqLmZLOZt9pDhYgVyNt
	hzi3ErrXDcqbFbBbmByJeNO+iwbuRoB16LgE6fjNNoKSH+v/Vrp0HpM++SqU8wcwty/3CaL62/T
	4R5mPyz37awoGkdmSnzZUwBjHQRG0/S9+sFP3bV3rsulTACChi6fz2z4N92Kx1UKs752aIR10Ja
	ze/yWwaUzbUKkTS4bG8ECgiLgDm/ya5lRsCJxHLZSmbWf18kX87Fp8WSzznQXSZoMocS0D4P8Wj
	m/8MBcWs6rTpglao2y/hLiktE
X-Google-Smtp-Source: AGHT+IGdJmG/aRuukS9wp1j45kdhWIv8rbafMummPQWSOxqhwrvosiR8ISMkHkpaE9jfrdbnkdIMeg==
X-Received: by 2002:a05:6a21:999f:b0:215:e818:9fe3 with SMTP id adf61e73a8af0-21ba11ff2a8mr10602842637.27.1748842562651;
        Sun, 01 Jun 2025 22:36:02 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96799sm7062945b3a.15.2025.06.01.22.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 22:36:02 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: mac80211: correctly parse S1G beacon optional elements
Date: Mon,  2 Jun 2025 15:35:21 +1000
Message-ID: <20250602053521.410650-1-lachlan.hodges@morsemicro.com>
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
fields are distinct from information elements (IEs).

The presence of optional fields is indicated in the frame control field.
To correctly locate the IE offset, the frame control must be parsed to
identify which optional fields are present. Currently, mac80211 parses
S1G beacons based on fixed assumptions about the frame layout, without
inspecting the frame control field. This can result in incorrect offsets
to the "variable" portion of the frame.

This patch adds proper support for parsing S1G beacon frames by using
the field lengths defined in IEEE 802.11-2024, section 9.3.4.3, ensuring
that the IE offset is calculated accurately.

Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/ieee80211.h | 79 ++++++++++++++++++++++++++++++++++-----
 net/mac80211/mlme.c       |  7 +---
 net/mac80211/scan.c       | 10 ++---
 net/wireless/scan.c       | 18 +++------
 4 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 420c7f9aa6ee..6c518989250d 100644
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
+ *  next TBTT field
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
+ *  ANO field
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
+ *  compressed SSID field
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
+ * precede the variable-length information elements (IEs). Whether these
+ * fields are present is indicated by flags in the frame control field.
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
index b84150dbfe8c..7ce85266bcbb 100644
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
+		variable = ext->u.s1g_beacon.variable
+					+ ieee80211_s1g_optional_len(ext->frame_control);
 	}
 
 	baselen = (u8 *) variable - (u8 *) mgmt;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 7b8da40a912d..6234f50a8a43 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -276,6 +276,7 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
+	struct ieee80211_ext *ext;
 	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
 
@@ -285,12 +286,9 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		return;
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_short_beacon.variable);
-		else
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_beacon);
+		ext = (struct ieee80211_ext *)mgmt;
+		min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon.variable)
+				+ ieee80211_s1g_optional_len(ext->frame_control);
 	}
 
 	if (skb->len < min_hdr_len)
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ddd3a97f6609..6e1964f61246 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3250,6 +3250,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	const u8 *ie;
 	size_t ielen;
 	u64 tsf;
+	size_t s1g_optional_len;
 
 	if (WARN_ON(!mgmt))
 		return NULL;
@@ -3263,13 +3264,10 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	trace_cfg80211_inform_bss_frame(wiphy, data, mgmt, len);
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		ext = (void *) mgmt;
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_short_beacon.variable);
-		else
-			min_hdr_len = offsetof(struct ieee80211_ext,
-					       u.s1g_beacon.variable);
+		ext = (struct ieee80211_ext *)mgmt;
+		s1g_optional_len = ieee80211_s1g_optional_len(ext->frame_control);
+		min_hdr_len = offsetof(struct ieee80211_ext, u.s1g_beacon.variable)
+					+ s1g_optional_len;
 	} else {
 		/* same for beacons */
 		min_hdr_len = offsetof(struct ieee80211_mgmt,
@@ -3285,11 +3283,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
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


