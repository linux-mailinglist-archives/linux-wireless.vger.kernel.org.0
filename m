Return-Path: <linux-wireless+bounces-27146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C47B4A490
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BF717F470
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0E24678D;
	Tue,  9 Sep 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="QS4aRwqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A02405E3
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405294; cv=none; b=Zgj+ghNq5IZgwkhxJMKTBfO+pAVUg7LUA7U2sqrqXu21nERqUcYb7FDSNDUzhGyVSgVwqULJx2mZc51kDwdmwC2qAhGdVMTEqM5WqIFqiI/G/G+nU32baJABux44b5g7UfEkjDml89CT3MWIH6woWKAAtWuAFPsQL1askE3aSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405294; c=relaxed/simple;
	bh=SAZLOAm84geT5B8qG+GvGhmsY3V5ZXHJsmAifHv4OKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQsiRmL6U2p1b64gE0Iu4M60nS4VoIZ+8dCXPwn21zsrbimdiLwUz9VGEtkjrX3brhSA6agPzD8IxWpF3zTr6kJorcAWhgqJg1HkmxPvC0D3W7+3hXo279LkL8M16X0OjTc5Vmksm8nxU0XlD8cmX9g/qOFlnXb4bMuhE7KsBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=QS4aRwqm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806df50so46079665ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757405291; x=1758010091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsbEsZl84yWe7WqyKOA7tNoUARglhtPTWSewOZYTkgA=;
        b=QS4aRwqm9k3kq/57Jkc1fuI9gmuJMEwtuItEK9/b+gutfmM9WZcOllRethA2mv1z9p
         X6KmJJjVbsqbCNwyk+RlaUIQ/WxEMxhK5+sM66/3QgKAl6LH7wzDhQvStMkX449DpZUI
         KIhmIb9QJ5++CRrw0POzqH3FRmnj4R17vHl4BTKyNFhOOgIqzSPDWPlX9kXI4m3KFfoO
         eV/olXblVRy1//4kAY01bJ7H6MvGmKFm5wpXc1i6eQp59Nj3FS8GCdCWH5AIZawKPwJ+
         ZKs/3qlVIjVbyjn+49iCyujxV4+N38S6sleyIKmIbOzTlx24oL9CK8LFjANaQxx3M4/C
         HokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405291; x=1758010091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsbEsZl84yWe7WqyKOA7tNoUARglhtPTWSewOZYTkgA=;
        b=b+1UUO2Gb8g2YFaSkoOpQByoci7Rnkq/LYGatA7z2UQtFT0VZLeySSiboR/pYDQB5y
         xHt0FwpUmOVWeA0ClbhEIZDFafM0GG/Zc73Aqe41QGi0WvEQl3vlGXcRSVyurxX6oJgh
         +hJqKZYFjCCDU7sfLySNJLS2H/KpXz3NmkXBAy/FOR/NULqZx2+vll8LL8sPG9tIztem
         SSQ4cPgjeN6iovJo98VLOdIYth9xAvf1PYWd7cW1122k0BH32g3baXVwjTsc0clLlLnK
         ma1kS/XnC7reoRSSg5nvukht4pR55MD7t494XccZF/rdvnRXWiTvtitB59X0Yy+8WYr/
         RSeA==
X-Gm-Message-State: AOJu0Yw0KQLkVoCpGouYJAhKeHCnIz2GFDz4bQT7Gxv79+wnTibhhePn
	biBqXsU08SOI0UQkcmKG+XGeg/94elP1r2znXenmOckst0gd6ecBjKm1efsz/NutoO0=
X-Gm-Gg: ASbGncvO40jt8ax2sT4tUH++mQCg23pxT+4FUzTNU9lK9bq59YJYSbD5pr4faiUBe9+
	uQ6MV6kNskKOnWDJWPtNZYlX+mrL1m848xrgmShiuCfnrA1nKtQimhjz4jdmh8nwENJBqpu6W5H
	OEN9mtmCRKhdhYNL/ZmvoTBT1NhGTXWHH+ZxU902xG8MHfQNU9XSlUAq5w05K1LG/77DnfoU198
	rHiMG71WG2/omMFSeoSyZHcXTjvlhfygXGJm1rqxGcp2FAzkWJjAA7esrTGsW7S98oNqjO7XsJh
	DAume9NFyTtVy84uJWMKMGMSPw+YPc7dIH2M8UulRDE624b/Eiee1WTy0ABdVICVfGvBALdkPew
	/j/OKXGJq9bl60gVXDB4FkpgasgpseMEE0TmJmzTjYqZ7M6nr6k6FNJSabBhIFyq6ZtNeURKyby
	HrjnqmuKOC4el/Kkb+16HyNufOz+g=
X-Google-Smtp-Source: AGHT+IEGcxOlrZdKPhPbQCP7E0clAMKa1P1I8eYaC/+A3W9hC2pttKg3u/l0AQiUDnedStYY46eJ6g==
X-Received: by 2002:a17:903:350c:b0:246:648f:80a3 with SMTP id d9443c01a7336-251751e9e3cmr127393065ad.50.1757405290916;
        Tue, 09 Sep 2025 01:08:10 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm148882995ad.89.2025.09.09.01.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:08:10 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Andrew Pope <andrew.pope@morsemicro.com>
Subject: [RFC wireless-next 1/3] wifi: cfg80211: correctly implement and validate S1G chandef
Date: Tue,  9 Sep 2025 18:07:48 +1000
Message-ID: <20250909080758.1004956-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the S1G channelisation implementation differs from that of
VHT, which is the PHY that S1G is based on. The major difference between
the clock rate is 1/10th of VHT. However how their channelisation is
represented within cfg80211 and mac80211 vastly differ.

To rectify this, remove the IEEE80211_CHAN_1/2/4.. flags that were previously
used to indicate the control channel width, however it should be implied
that the control channels are 1MHz in the case of S1G. Additionally,
introduce the invert - being IEEE80211_CHAN_NO_4/8/16MHz - that imply
the control channel may not be used for a certain bandwidth. With these
new flags, we can perform regulatory and chandef validation just as we would
for VHT.

To deal with the notion that S1G PHYs may contain a 2MHz primary channel,
introduce a new variable, s1g_primary_2mhz, which indicates whether we are
operating on a 2MHz primary channel. In this case, the chandef::chan points to
the 1MHz primary channel pointed to by the primary channel location. Alongside
this, introduce some new helper routines that can extract the sibling 1MHz
channel. The sibling being the alternate 1MHz primary subchannel within the
2MHz primary channel that is not pointed to by chandef::chan.

Furthermore, due to unique restrictions imposed on S1G PHYs, introduce
a new flag, IEEE80211_CHAN_S1G_NO_PRIMARY, which states that the 1MHz channel
cannot be used as a primary channel. This is assumed to be set by vendors
as it is hardware and regdom specific, When we validate a 2MHz primary channel,
we need to ensure both 1MHz subchannels do not contain this flag. If one or
both of the 1MHz subchannels contain this flag then the 2MHz primary is not
permitted for use as a primary channel.

Properly integrate S1G channel validation such that it is implemented
according with other PHY types such as VHT. Additionally, implement a new
S1G-specific regulatory flag to allow cfg80211 to understand specific
vendor requirements for S1G PHYs.

Signed-off-by: Arien Judge <arien.judge@morsemicro.com>
Signed-off-by: Andrew Pope <andrew.pope@morsemicro.com>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/cfg80211.h       | 108 +++++++++++++++++++++++++++++++----
 include/uapi/linux/nl80211.h |  23 ++++----
 net/wireless/chan.c          | 102 ++++++++++++++++++++++-----------
 net/wireless/nl80211.c       |  47 +++++++--------
 net/wireless/reg.c           |  82 ++++++++------------------
 net/wireless/util.c          |  22 +------
 6 files changed, 223 insertions(+), 161 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..1dccfaa11e26 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -101,15 +101,11 @@ struct wiphy;
  * @IEEE80211_CHAN_NO_10MHZ: 10 MHz bandwidth is not permitted
  *	on this channel.
  * @IEEE80211_CHAN_NO_HE: HE operation is not permitted on this channel.
- * @IEEE80211_CHAN_1MHZ: 1 MHz bandwidth is permitted
+ * @IEEE80211_CHAN_NO_4MHZ: 4 MHz bandwidth is not permitted
  *	on this channel.
- * @IEEE80211_CHAN_2MHZ: 2 MHz bandwidth is permitted
+ * @IEEE80211_CHAN_NO_8MHZ: 8 MHz bandwidth is not permitted
  *	on this channel.
- * @IEEE80211_CHAN_4MHZ: 4 MHz bandwidth is permitted
- *	on this channel.
- * @IEEE80211_CHAN_8MHZ: 8 MHz bandwidth is permitted
- *	on this channel.
- * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
+ * @IEEE80211_CHAN_NO_16MHZ: 16 MHz bandwidth is permitted
  *	on this channel.
  * @IEEE80211_CHAN_NO_320MHZ: If the driver supports 320 MHz on the band,
  *	this flag indicates that a 320 MHz channel cannot use this
@@ -129,6 +125,10 @@ struct wiphy;
  *	with very low power (VLP), even if otherwise set to NO_IR.
  * @IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY: Allow activity on a 20 MHz channel,
  *	even if otherwise set to NO_IR.
+ * @IEEE80211_CHAN_S1G_NO_PRIMARY: Prevents the channel for use as an S1G
+ *	primary channel. Does not prevent the wider operating channel
+ *	described by the chandef from being used. In order for a 2MHz primary
+ *	to be used, both 1MHz subchannels shall not contain this flag.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -145,11 +145,9 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_20MHZ			= BIT(11),
 	IEEE80211_CHAN_NO_10MHZ			= BIT(12),
 	IEEE80211_CHAN_NO_HE			= BIT(13),
-	IEEE80211_CHAN_1MHZ			= BIT(14),
-	IEEE80211_CHAN_2MHZ			= BIT(15),
-	IEEE80211_CHAN_4MHZ			= BIT(16),
-	IEEE80211_CHAN_8MHZ			= BIT(17),
-	IEEE80211_CHAN_16MHZ			= BIT(18),
+	IEEE80211_CHAN_NO_4MHZ			= BIT(16),
+	IEEE80211_CHAN_NO_8MHZ			= BIT(17),
+	IEEE80211_CHAN_NO_16MHZ			= BIT(18),
 	IEEE80211_CHAN_NO_320MHZ		= BIT(19),
 	IEEE80211_CHAN_NO_EHT			= BIT(20),
 	IEEE80211_CHAN_DFS_CONCURRENT		= BIT(21),
@@ -158,6 +156,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_CAN_MONITOR		= BIT(24),
 	IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP	= BIT(25),
 	IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY     = BIT(26),
+	IEEE80211_CHAN_S1G_NO_PRIMARY		= BIT(27),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -821,6 +820,9 @@ struct key_params {
  * @punctured: mask of the punctured 20 MHz subchannels, with
  *	bits turned on being disabled (punctured); numbered
  *	from lower to higher frequency (like in the spec)
+ * @s1g_primary_2mhz: Indicates if the control channel pointed to
+ *	by 'chan' exists as a 1MHz primary subchannel within an
+ *	S1G 2MHz primary channel.
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -830,6 +832,7 @@ struct cfg80211_chan_def {
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
 	u16 punctured;
+	bool s1g_primary_2mhz;
 };
 
 /*
@@ -990,6 +993,18 @@ cfg80211_chandef_is_edmg(const struct cfg80211_chan_def *chandef)
 	return chandef->edmg.channels || chandef->edmg.bw_config;
 }
 
+/**
+ * cfg80211_chandef_is_s1g - check if chandef represents an S1G channel
+ * @chandef: the channel definition
+ *
+ * Return: %true if S1G.
+ */
+static inline bool
+cfg80211_chandef_is_s1g(const struct cfg80211_chan_def *chandef)
+{
+	return chandef->chan->band == NL80211_BAND_S1GHZ;
+}
+
 /**
  * cfg80211_chandef_compatible - check if two channel definitions are compatible
  * @chandef1: first channel definition
@@ -10052,4 +10067,73 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
 				   void *data);
 #endif
 
+/**
+ * cfg80211_s1g_get_start_freq_khz - get S1G chandef start frequency
+ * @chandef: the chandef to use
+ *
+ * Return: the chandefs starting frequency in KHz
+ */
+static inline u32
+cfg80211_s1g_get_start_freq_khz(const struct cfg80211_chan_def *chandef)
+{
+	u32 bw_mhz = cfg80211_chandef_get_width(chandef);
+	u32 center_khz =
+		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
+	return center_khz - bw_mhz * 500 + 500;
+}
+
+/**
+ * cfg80211_s1g_get_end_freq_khz - get S1G chandef end frequency
+ * @chandef: the chandef to use
+ *
+ * Return: the chandefs ending frequency in KHz
+ */
+static inline u32
+cfg80211_s1g_get_end_freq_khz(const struct cfg80211_chan_def *chandef)
+{
+	u32 bw_mhz = cfg80211_chandef_get_width(chandef);
+	u32 center_khz =
+		MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
+	return center_khz + bw_mhz * 500 - 500;
+}
+
+
+/**
+ * cfg80211_s1g_get_primary_sibling - retrieve the sibling 1MHz subchannel
+ *	for an S1G chandef using a 2MHz primary channel.
+ * @wiphy: wiphy the channel belongs to
+ * @chandef: the chandef to use
+ *
+ * When chandef::s1g_primary_2mhz is set to true, we are operating on a 2MHz
+ * primary channel. The 1MHz subchannel designated by the primary channel
+ * location exists within chandef::chan, whilst the 'sibling' is denoted as
+ * being the other 1MHz subchannel that make up the 2MHz primary channel.
+ *
+ * Returns: the sibling 1MHz &struct ieee80211_channel, or %NULL on failure.
+ */
+static inline struct ieee80211_channel *
+cfg80211_s1g_get_primary_sibling(struct wiphy *wiphy,
+				 const struct cfg80211_chan_def *chandef)
+{
+	int width_mhz = cfg80211_chandef_get_width(chandef);
+	u32 pri_1mhz_khz, sibling_1mhz_khz, op_low_1mhz_khz, pri_index;
+
+	if (!chandef->s1g_primary_2mhz || width_mhz < 2)
+		return NULL;
+
+	pri_1mhz_khz = ieee80211_channel_to_khz(chandef->chan);
+	op_low_1mhz_khz = cfg80211_s1g_get_start_freq_khz(chandef);
+
+	/*
+	 * Compute the index of the primary 1 MHz subchannel within the
+	 * operating channel, relative to the lowest 1 MHz center frequency.
+	 * Flip the least significant bit to select the even/odd sibling,
+	 * then translate that index back into a channel frequency.
+	 */
+	pri_index = (pri_1mhz_khz - op_low_1mhz_khz) / 1000;
+	sibling_1mhz_khz = op_low_1mhz_khz + ((pri_index ^ 1) * 1000);
+
+	return ieee80211_get_channel_khz(wiphy, sibling_1mhz_khz);
+}
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index aed0b4c5d5e8..5a4c0968d18b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2936,6 +2936,10 @@ enum nl80211_commands {
  *	indicate that it wants strict checking on the BSS parameters to be
  *	modified.
  *
+ * @NL80211_ATTR_S1G_PRIMARY_2MHZ: flag attribute indicating that the S1G
+ *	primary channel is 2 MHz wide, and the control channel designates
+ *	the 1 MHz primary subchannel within that 2 MHz primary.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3498,6 +3502,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_LONG_BEACON_PERIOD,
 	NL80211_ATTR_S1G_SHORT_BEACON,
 	NL80211_ATTR_BSS_PARAM,
+	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -4365,15 +4370,11 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
  *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_OFFSET: frequency offset in KHz
- * @NL80211_FREQUENCY_ATTR_1MHZ: 1 MHz operation is allowed
- *	on this channel in current regulatory domain.
- * @NL80211_FREQUENCY_ATTR_2MHZ: 2 MHz operation is allowed
- *	on this channel in current regulatory domain.
- * @NL80211_FREQUENCY_ATTR_4MHZ: 4 MHz operation is allowed
+ * @NL80211_FREQUENCY_ATTR_NO_4MHZ: 4 MHz operation is not allowed
  *	on this channel in current regulatory domain.
- * @NL80211_FREQUENCY_ATTR_8MHZ: 8 MHz operation is allowed
+ * @NL80211_FREQUENCY_ATTR_NO_8MHZ: 8 MHz operation is not allowed
  *	on this channel in current regulatory domain.
- * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
+ * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this channel
  *	as the primary or any of the secondary channels isn't possible
@@ -4427,11 +4428,9 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_WMM,
 	NL80211_FREQUENCY_ATTR_NO_HE,
 	NL80211_FREQUENCY_ATTR_OFFSET,
-	NL80211_FREQUENCY_ATTR_1MHZ,
-	NL80211_FREQUENCY_ATTR_2MHZ,
-	NL80211_FREQUENCY_ATTR_4MHZ,
-	NL80211_FREQUENCY_ATTR_8MHZ,
-	NL80211_FREQUENCY_ATTR_16MHZ,
+	NL80211_FREQUENCY_ATTR_NO_4MHZ,
+	NL80211_FREQUENCY_ATTR_NO_8MHZ,
+	NL80211_FREQUENCY_ATTR_NO_16MHZ,
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 	NL80211_FREQUENCY_ATTR_NO_EHT,
 	NL80211_FREQUENCY_ATTR_PSD,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 193734b7f9dc..afab9bfdd1ca 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -100,6 +100,11 @@ static u32 cfg80211_get_end_freq(const struct cfg80211_chan_def *chandef,
 	       punctured = 0) : (punctured >>= 1)))			\
 		if (!(punctured & 1))
 
+#define for_each_s1g_subchan(chandef, freq_khz)                   \
+	for (freq_khz = cfg80211_s1g_get_start_freq_khz(chandef); \
+	     freq_khz <= cfg80211_s1g_get_end_freq_khz(chandef);  \
+	     freq_khz += MHZ_TO_KHZ(1))
+
 struct cfg80211_per_bw_puncturing_values {
 	u8 len;
 	const u16 *valid_values;
@@ -336,8 +341,7 @@ static bool cfg80211_valid_center_freq(u32 center,
 
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
-	u32 control_freq, oper_freq;
-	int oper_width, control_width;
+	u32 control_freq;
 
 	if (!chandef->chan)
 		return false;
@@ -363,27 +367,18 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	case NL80211_CHAN_WIDTH_4:
 	case NL80211_CHAN_WIDTH_8:
 	case NL80211_CHAN_WIDTH_16:
-		if (chandef->chan->band != NL80211_BAND_S1GHZ)
-			return false;
-
-		control_freq = ieee80211_channel_to_khz(chandef->chan);
-		oper_freq = ieee80211_chandef_to_khz(chandef);
-		control_width = nl80211_chan_width_to_mhz(
-					ieee80211_s1g_channel_width(
-								chandef->chan));
-		oper_width = cfg80211_chandef_get_width(chandef);
+		u32 control_khz, start_khz, end_khz;
 
-		if (oper_width < 0 || control_width < 0)
+		if (!cfg80211_chandef_is_s1g(chandef))
 			return false;
 		if (chandef->center_freq2)
 			return false;
 
-		if (control_freq + MHZ_TO_KHZ(control_width) / 2 >
-		    oper_freq + MHZ_TO_KHZ(oper_width) / 2)
-			return false;
+		control_khz = ieee80211_channel_to_khz(chandef->chan);
+		start_khz = cfg80211_s1g_get_start_freq_khz(chandef);
+		end_khz = cfg80211_s1g_get_end_freq_khz(chandef);
 
-		if (control_freq - MHZ_TO_KHZ(control_width) / 2 <
-		    oper_freq - MHZ_TO_KHZ(oper_width) / 2)
+		if (control_khz < start_khz || control_khz > end_khz)
 			return false;
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
@@ -725,6 +720,10 @@ static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 {
 	struct ieee80211_channel *c;
 
+	/* DFS is not required for S1G */
+	if (cfg80211_chandef_is_s1g(chandef))
+		return 0;
+
 	for_each_subchan(chandef, freq, cf) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
@@ -1130,6 +1129,57 @@ static bool cfg80211_edmg_usable(struct wiphy *wiphy, u8 edmg_channels,
 	return true;
 }
 
+static bool cfg80211_s1g_usable(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef)
+{
+	u32 freq_khz, sib_khz;
+	const struct ieee80211_channel *chan;
+	const struct ieee80211_channel *sibling;
+	u32 pri_khz = ieee80211_channel_to_khz(chandef->chan);
+	u32 end_khz = cfg80211_s1g_get_end_freq_khz(chandef);
+	u32 start_khz = cfg80211_s1g_get_start_freq_khz(chandef);
+	int width_mhz = cfg80211_chandef_get_width(chandef);
+	u32 prohibited_flags = IEEE80211_CHAN_DISABLED;
+
+	if (width_mhz >= 16)
+		prohibited_flags |= IEEE80211_CHAN_NO_16MHZ;
+	if (width_mhz >= 8)
+		prohibited_flags |= IEEE80211_CHAN_NO_8MHZ;
+	if (width_mhz >= 4)
+		prohibited_flags |= IEEE80211_CHAN_NO_4MHZ;
+
+	if (chandef->chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY)
+		return false;
+
+	if (pri_khz < start_khz || pri_khz > end_khz)
+		return false;
+
+	for_each_s1g_subchan(chandef, freq_khz)
+	{
+		chan = ieee80211_get_channel_khz(wiphy, freq_khz);
+		if (!chan || (chan->flags & prohibited_flags))
+			return false;
+	}
+
+	if (chandef->s1g_primary_2mhz) {
+		sibling = cfg80211_s1g_get_primary_sibling(wiphy, chandef);
+		if (!sibling)
+			return false;
+
+		if (sibling->flags & IEEE80211_CHAN_S1G_NO_PRIMARY)
+			return false;
+
+		if (sibling->flags & prohibited_flags)
+			return false;
+
+		sib_khz = ieee80211_channel_to_khz(sibling);
+		if (sib_khz < start_khz || sib_khz > end_khz)
+			return false;
+	}
+
+	return true;
+}
+
 bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 			      const struct cfg80211_chan_def *chandef,
 			      u32 prohibited_flags,
@@ -1154,6 +1204,9 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 	ext_nss_cap = __le16_to_cpu(vht_cap->vht_mcs.tx_highest) &
 			IEEE80211_VHT_EXT_NSS_BW_CAPABLE;
 
+	if (cfg80211_chandef_is_s1g(chandef))
+		return cfg80211_s1g_usable(wiphy, chandef);
+
 	if (edmg_cap->channels &&
 	    !cfg80211_edmg_usable(wiphy,
 				  chandef->edmg.channels,
@@ -1165,21 +1218,6 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 	control_freq = chandef->chan->center_freq;
 
 	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_1:
-		width = 1;
-		break;
-	case NL80211_CHAN_WIDTH_2:
-		width = 2;
-		break;
-	case NL80211_CHAN_WIDTH_4:
-		width = 4;
-		break;
-	case NL80211_CHAN_WIDTH_8:
-		width = 8;
-		break;
-	case NL80211_CHAN_WIDTH_16:
-		width = 16;
-		break;
 	case NL80211_CHAN_WIDTH_5:
 		width = 5;
 		break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 99e2aadc65f7..c57b402fceed 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -880,6 +880,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_S1G_SHORT_BEACON] =
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
+	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -1228,20 +1229,14 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_HE) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_HE))
 			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_1MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_1MHZ))
+		if ((chan->flags & IEEE80211_CHAN_NO_4MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_4MHZ))
 			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_2MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_2MHZ))
+		if ((chan->flags & IEEE80211_CHAN_NO_8MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_8MHZ))
 			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_4MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_4MHZ))
-			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_8MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_8MHZ))
-			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_16MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_16MHZ))
+		if ((chan->flags & IEEE80211_CHAN_NO_16MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_16MHZ))
 			goto nla_put_failure;
 		if ((chan->flags & IEEE80211_CHAN_NO_320MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_320MHZ))
@@ -3449,6 +3444,7 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	chandef->center_freq1 = KHZ_TO_MHZ(control_freq);
 	chandef->freq1_offset = control_freq % 1000;
 	chandef->center_freq2 = 0;
+	chandef->s1g_primary_2mhz = false;
 
 	if (!chandef->chan) {
 		NL_SET_ERR_MSG_ATTR(extack, attrs[NL80211_ATTR_WIPHY_FREQ],
@@ -3492,27 +3488,21 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 		}
 	} else if (attrs[NL80211_ATTR_CHANNEL_WIDTH]) {
-		chandef->width =
-			nla_get_u32(attrs[NL80211_ATTR_CHANNEL_WIDTH]);
-		if (chandef->chan->band == NL80211_BAND_S1GHZ) {
-			/* User input error for channel width doesn't match channel  */
-			if (chandef->width != ieee80211_s1g_channel_width(chandef->chan)) {
-				NL_SET_ERR_MSG_ATTR(extack,
-						    attrs[NL80211_ATTR_CHANNEL_WIDTH],
-						    "bad channel width");
-				return -EINVAL;
-			}
-		}
+		chandef->width = nla_get_u32(attrs[NL80211_ATTR_CHANNEL_WIDTH]);
 		if (attrs[NL80211_ATTR_CENTER_FREQ1]) {
 			chandef->center_freq1 =
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ1]);
-			chandef->freq1_offset =
-				nla_get_u32_default(attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET],
-						    0);
+			chandef->freq1_offset = nla_get_u32_default(
+				attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET], 0);
 		}
+
 		if (attrs[NL80211_ATTR_CENTER_FREQ2])
 			chandef->center_freq2 =
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ2]);
+
+		if (attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ])
+			chandef->s1g_primary_2mhz = nla_get_flag(
+				attrs[NL80211_ATTR_S1G_PRIMARY_2MHZ]);
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
@@ -10362,8 +10352,9 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				goto out_free;
 			}
 
-			/* ignore disabled channels */
+			/* Ignore disabled / no primary channels */
 			if (chan->flags & IEEE80211_CHAN_DISABLED ||
+			    chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY ||
 			    !cfg80211_wdev_channel_allowed(wdev, chan))
 				continue;
 
@@ -10385,6 +10376,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				chan = &wiphy->bands[band]->channels[j];
 
 				if (chan->flags & IEEE80211_CHAN_DISABLED ||
+				    chan->flags &
+					    IEEE80211_CHAN_S1G_NO_PRIMARY ||
 				    !cfg80211_wdev_channel_allowed(wdev, chan))
 					continue;
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 3b0ac3437f81..aa8be575181b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1707,69 +1707,37 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 	if (reg_rule->flags & NL80211_RRF_AUTO_BW)
 		max_bandwidth_khz = reg_get_max_bandwidth(regd, reg_rule);
 
+	if (is_s1g) {
+		if (max_bandwidth_khz < MHZ_TO_KHZ(16))
+			bw_flags |= IEEE80211_CHAN_NO_16MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(8))
+			bw_flags |= IEEE80211_CHAN_NO_8MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(4))
+			bw_flags |= IEEE80211_CHAN_NO_4MHZ;
+		return bw_flags;
+	}
+
 	/* If we get a reg_rule we can assume that at least 5Mhz fit */
-	if (!cfg80211_does_bw_fit_range(freq_range,
-					center_freq_khz,
+	if (!cfg80211_does_bw_fit_range(freq_range, center_freq_khz,
 					MHZ_TO_KHZ(10)))
 		bw_flags |= IEEE80211_CHAN_NO_10MHZ;
-	if (!cfg80211_does_bw_fit_range(freq_range,
-					center_freq_khz,
+	if (!cfg80211_does_bw_fit_range(freq_range, center_freq_khz,
 					MHZ_TO_KHZ(20)))
 		bw_flags |= IEEE80211_CHAN_NO_20MHZ;
 
-	if (is_s1g) {
-		/* S1G is strict about non overlapping channels. We can
-		 * calculate which bandwidth is allowed per channel by finding
-		 * the largest bandwidth which cleanly divides the freq_range.
-		 */
-		int edge_offset;
-		int ch_bw = max_bandwidth_khz;
-
-		while (ch_bw) {
-			edge_offset = (center_freq_khz - ch_bw / 2) -
-				      freq_range->start_freq_khz;
-			if (edge_offset % ch_bw == 0) {
-				switch (KHZ_TO_MHZ(ch_bw)) {
-				case 1:
-					bw_flags |= IEEE80211_CHAN_1MHZ;
-					break;
-				case 2:
-					bw_flags |= IEEE80211_CHAN_2MHZ;
-					break;
-				case 4:
-					bw_flags |= IEEE80211_CHAN_4MHZ;
-					break;
-				case 8:
-					bw_flags |= IEEE80211_CHAN_8MHZ;
-					break;
-				case 16:
-					bw_flags |= IEEE80211_CHAN_16MHZ;
-					break;
-				default:
-					/* If we got here, no bandwidths fit on
-					 * this frequency, ie. band edge.
-					 */
-					bw_flags |= IEEE80211_CHAN_DISABLED;
-					break;
-				}
-				break;
-			}
-			ch_bw /= 2;
-		}
-	} else {
-		if (max_bandwidth_khz < MHZ_TO_KHZ(10))
-			bw_flags |= IEEE80211_CHAN_NO_10MHZ;
-		if (max_bandwidth_khz < MHZ_TO_KHZ(20))
-			bw_flags |= IEEE80211_CHAN_NO_20MHZ;
-		if (max_bandwidth_khz < MHZ_TO_KHZ(40))
-			bw_flags |= IEEE80211_CHAN_NO_HT40;
-		if (max_bandwidth_khz < MHZ_TO_KHZ(80))
-			bw_flags |= IEEE80211_CHAN_NO_80MHZ;
-		if (max_bandwidth_khz < MHZ_TO_KHZ(160))
-			bw_flags |= IEEE80211_CHAN_NO_160MHZ;
-		if (max_bandwidth_khz < MHZ_TO_KHZ(320))
-			bw_flags |= IEEE80211_CHAN_NO_320MHZ;
-	}
+	if (max_bandwidth_khz < MHZ_TO_KHZ(10))
+		bw_flags |= IEEE80211_CHAN_NO_10MHZ;
+	if (max_bandwidth_khz < MHZ_TO_KHZ(20))
+		bw_flags |= IEEE80211_CHAN_NO_20MHZ;
+	if (max_bandwidth_khz < MHZ_TO_KHZ(40))
+		bw_flags |= IEEE80211_CHAN_NO_HT40;
+	if (max_bandwidth_khz < MHZ_TO_KHZ(80))
+		bw_flags |= IEEE80211_CHAN_NO_80MHZ;
+	if (max_bandwidth_khz < MHZ_TO_KHZ(160))
+		bw_flags |= IEEE80211_CHAN_NO_160MHZ;
+	if (max_bandwidth_khz < MHZ_TO_KHZ(320))
+		bw_flags |= IEEE80211_CHAN_NO_320MHZ;
+
 	return bw_flags;
 }
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index d12d49134c88..2087d9d8afaf 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -109,27 +109,7 @@ EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
 enum nl80211_chan_width
 ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
 {
-	if (WARN_ON(!chan || chan->band != NL80211_BAND_S1GHZ))
-		return NL80211_CHAN_WIDTH_20_NOHT;
-
-	/*S1G defines a single allowed channel width per channel.
-	 * Extract that width here.
-	 */
-	if (chan->flags & IEEE80211_CHAN_1MHZ)
-		return NL80211_CHAN_WIDTH_1;
-	else if (chan->flags & IEEE80211_CHAN_2MHZ)
-		return NL80211_CHAN_WIDTH_2;
-	else if (chan->flags & IEEE80211_CHAN_4MHZ)
-		return NL80211_CHAN_WIDTH_4;
-	else if (chan->flags & IEEE80211_CHAN_8MHZ)
-		return NL80211_CHAN_WIDTH_8;
-	else if (chan->flags & IEEE80211_CHAN_16MHZ)
-		return NL80211_CHAN_WIDTH_16;
-
-	pr_err("unknown channel width for channel at %dKHz?\n",
-	       ieee80211_channel_to_khz(chan));
-
-	return NL80211_CHAN_WIDTH_1;
+	return NL80211_CHAN_WIDTH_20_NOHT;
 }
 EXPORT_SYMBOL(ieee80211_s1g_channel_width);
 
-- 
2.43.0


