Return-Path: <linux-wireless+bounces-27453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22901B82FCE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF63E1C20A19
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC2274B4D;
	Thu, 18 Sep 2025 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="IQhwJ2El"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6828137D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172776; cv=none; b=LwHsdhOHoCQ8u2HHpd7xkWCKjakKYIs13wnzYAdc+9eVbtWt9sySyXQbS01xL+gDWZeI4+QpWLlH6ejgsS6o2lruDKxY/eKAZxoZLi59qELdWBPub9Gd7fAPpjj9O2hSZkmXNPSFjoEmRWp1acSU3SYJyGIsxLfkWqIZKtaibhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172776; c=relaxed/simple;
	bh=/hCMRRCxmbyty6V0nWmlF0gh8V7pgABEP6fbb3nbBHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsWw2x/cGqxbaPOu6kxw4hX3jdaWU8OFOO5W1dybH1lfiYflwJ2D4OnO6Goa8Ue1Ef46VO+s6a+jIh9SFqvuz8fPBY3Ug4hWgbQtRoxUGThSLYb6R9H5XCcA8Ij0400fOxxSr6u2W9n6jovRidZj+OaBqqdW6rOG1mT046T8xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=IQhwJ2El; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2677a4d4ce3so6019635ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1758172773; x=1758777573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMskaZV5oDbSD0Kxm6oXdUXA2sF0uXKL9ixxv7hi8vY=;
        b=IQhwJ2EldiHAFBXV/OHstZFUC2M4RbJZMB5YBvHKwLC15j2k8cJm7TJLwI+Fkx+/Bf
         qP/GsNY5Fl4q+NvgRfivaeXbMuYoCrNsjCiTdzjQaLEZ76uo/Y08eTMihrxryk8ZfLjJ
         tg7U60iP3bjHspWl8rimTSB0b/VB37YqXM5la3GkNWZXZn1RCAqLdwTbB+pKnjRZsNKY
         GabhTwbfOTFYSjqGhR5M/+atdbghA3oMO00F5OXxcDSJHpvaQXrX8hng3bPpC0/qbaIA
         9CU35S2tRuP5KjBYe6369z/QZxETO+3sHGoWgLIqNf++4T0ETVtNVEDLSODuFBqs/6dI
         YeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172773; x=1758777573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMskaZV5oDbSD0Kxm6oXdUXA2sF0uXKL9ixxv7hi8vY=;
        b=lx9ulB7qv3b2pwfXUfMmMyAaSFwDIfE7iYgKNCZ4IQquVBhd9uTRp3OUtDoGNyHn7C
         E+l5FmyshsmW3lU5zCdBiczExJXhnvGH3RHqWytOqvQGuS0GpOraU5k50k61qh/RavbD
         qg6Wkypae90uh9KHSdMxA2pSjM8pF75R/oWCKzr4ToCq1oCYsRO7CSI91HJOZ0Q+py36
         of+HE4dovTRB86N33uvYQmlXglBDypJApweMsCDytYROmRoX0Fa+bs7ZPZIpqSh2B9aH
         3eBM84Jg6fR1bEklGz9zXB0mtesSKpBCGeCgbWRJV+FjHVaSdKEolgFLwJq7KuPgBkKE
         GSHw==
X-Gm-Message-State: AOJu0YwPEn0YKb4r0cn1iEHkQsgecW6hT8UwuxU+dhHuba3I9pCiWyQp
	8qyppH4p0Oy0Yms3Yula5VWXKv5OiQa4JwvAR7z4B6rOpi1rYbTtH6bqU2UrSHXci/k=
X-Gm-Gg: ASbGnctLlmolSlG/TUCCk0HNqZbq39K7tWY9fPnVs9AvXSsMHV8ixHpKiwrWTEsF8VI
	S5Xuw3zBZeNTqQNWggyEwWO6C70Xm6ON5zoIY9fhEN/4yVoGk+cN1iGGkoYyA+Y/CmVh0G+19W5
	LIarIU5/KbLhJ+9BwfSCfHvIxPH/IpoAgFPoexYf8upWFSBISZ+thjZdjLWzSKVhJhvZPl2+NEi
	5ev8S0fXXciRnO7+SWQT9fyjTSQadJbgYL1gifwFsCXcYwihvRTpE1h6ZaaZACD5kdlvErX2OgC
	/nPHio+gMftIIx1drHkOigqVtagy4UYPdYQ8Sj8GgvUk8JVr1h/9NQlCSs6Ut/1Uvt7WnLqnzSo
	e3CFlp6TjlcxFwD7Gd3ztZbRBn6BgPUfuRi9xvWzwIQQ7fjaGx8+ew4bJnlDAzkA7wLC8SRNlEb
	1V46Rg+6HfcOU1mairexLWWfP+ujnFqF6hwv7+GhONiOIZJdN9D/MgGkWd
X-Google-Smtp-Source: AGHT+IFsfzK0adiCZ4ophiP8SKkhYvCsLAGcT92YBziAoGYzA7Uo075WkdKD/9O1BC19Zi1BDGYtNQ==
X-Received: by 2002:a17:903:230a:b0:24c:cc16:6c16 with SMTP id d9443c01a7336-26812181956mr69296855ad.19.1758172772658;
        Wed, 17 Sep 2025 22:19:32 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035cd39sm12624465ad.146.2025.09.17.22.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:19:32 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Andrew Pope <andrew.pope@morsemicro.com>
Subject: [PATCH wireless-next v2 1/3] wifi: cfg80211: correctly implement and validate S1G chandef
Date: Thu, 18 Sep 2025 15:19:11 +1000
Message-ID: <20250918051913.500781-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
References: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
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

To rectify this, remove the use of IEEE80211_CHAN_1/2/4.. flags that were
previously used to indicate the control channel width, however it should be
implied that the control channels are 1MHz in the case of S1G. Additionally,
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

v1 -> v2:

1. Dont remove existing IEEE80211_CHAN_1/2/4... flags. Same for
   NL80211_FREQUENCY_ATTR_1/2/4...
2. Don't declare local variables in the switch statement to prevent clang
   compiler warning
3. Move some variables declarations into smaller scope in
   cfg80211_s1g_usable()
4. Move braces to end of line when using for_each_s1g_subchan
5. Ensure non-s1g interfaces don't set s1g_primary_2mhz flag within
   cfg80211_chandef_valid()

---
 include/net/cfg80211.h       |  95 ++++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h |  14 +++++
 net/wireless/chan.c          | 103 ++++++++++++++++++++++++-----------
 net/wireless/nl80211.c       |  38 ++++++++-----
 net/wireless/reg.c           |  76 ++++++++------------------
 5 files changed, 225 insertions(+), 101 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..d25a4ee5dc6e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -129,6 +129,13 @@ struct wiphy;
  *	with very low power (VLP), even if otherwise set to NO_IR.
  * @IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY: Allow activity on a 20 MHz channel,
  *	even if otherwise set to NO_IR.
+ * @IEEE80211_CHAN_S1G_NO_PRIMARY: Prevents the channel for use as an S1G
+ *	primary channel. Does not prevent the wider operating channel
+ *	described by the chandef from being used. In order for a 2MHz primary
+ *	to be used, both 1MHz subchannels shall not contain this flag.
+ * @IEEE80211_CHAN_NO_4MHZ: 4 MHz bandwidth is not permitted on this channel.
+ * @IEEE80211_CHAN_NO_8MHZ: 8 MHz bandwidth is not permitted on this channel.
+ * @IEEE80211_CHAN_NO_16MHZ: 16 MHz bandwidth is not permitted on this channel.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED			= BIT(0),
@@ -158,6 +165,10 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_CAN_MONITOR		= BIT(24),
 	IEEE80211_CHAN_ALLOW_6GHZ_VLP_AP	= BIT(25),
 	IEEE80211_CHAN_ALLOW_20MHZ_ACTIVITY     = BIT(26),
+	IEEE80211_CHAN_S1G_NO_PRIMARY		= BIT(27),
+	IEEE80211_CHAN_NO_4MHZ			= BIT(28),
+	IEEE80211_CHAN_NO_8MHZ			= BIT(29),
+	IEEE80211_CHAN_NO_16MHZ			= BIT(30),
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -821,6 +832,9 @@ struct key_params {
  * @punctured: mask of the punctured 20 MHz subchannels, with
  *	bits turned on being disabled (punctured); numbered
  *	from lower to higher frequency (like in the spec)
+ * @s1g_primary_2mhz: Indicates if the control channel pointed to
+ *	by 'chan' exists as a 1MHz primary subchannel within an
+ *	S1G 2MHz primary channel.
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -830,6 +844,7 @@ struct cfg80211_chan_def {
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
 	u16 punctured;
+	bool s1g_primary_2mhz;
 };
 
 /*
@@ -990,6 +1005,18 @@ cfg80211_chandef_is_edmg(const struct cfg80211_chan_def *chandef)
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
@@ -10052,4 +10079,72 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
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
index aed0b4c5d5e8..7f84772dab0e 100644
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
 
@@ -4396,6 +4401,12 @@ enum nl80211_wmm_rule {
  *	very low power (VLP) AP, despite being NO_IR.
  * @NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY: This channel can be active in
  *	20 MHz bandwidth, despite being NO_IR.
+ * @NL80211_FREQUENCY_ATTR_NO_4MHZ: 4 MHz operation is not allowed on this
+ *	channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_NO_8MHZ: 8 MHz operation is not allowed on this
+ *	channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_NO_16MHZ: 16 MHz operation is not allowed on this
+ *	channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4441,6 +4452,9 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_CAN_MONITOR,
 	NL80211_FREQUENCY_ATTR_ALLOW_6GHZ_VLP_AP,
 	NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY,
+	NL80211_FREQUENCY_ATTR_NO_4MHZ,
+	NL80211_FREQUENCY_ATTR_NO_8MHZ,
+	NL80211_FREQUENCY_ATTR_NO_16MHZ,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 193734b7f9dc..68221b1ab45e 100644
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
+	u32 control_freq, control_freq_khz, start_khz, end_khz;
 
 	if (!chandef->chan)
 		return false;
@@ -363,27 +367,16 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
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
-
-		if (oper_width < 0 || control_width < 0)
+		if (!cfg80211_chandef_is_s1g(chandef))
 			return false;
 		if (chandef->center_freq2)
 			return false;
 
-		if (control_freq + MHZ_TO_KHZ(control_width) / 2 >
-		    oper_freq + MHZ_TO_KHZ(oper_width) / 2)
-			return false;
+		control_freq_khz = ieee80211_channel_to_khz(chandef->chan);
+		start_khz = cfg80211_s1g_get_start_freq_khz(chandef);
+		end_khz = cfg80211_s1g_get_end_freq_khz(chandef);
 
-		if (control_freq - MHZ_TO_KHZ(control_width) / 2 <
-		    oper_freq - MHZ_TO_KHZ(oper_width) / 2)
+		if (control_freq_khz < start_khz || control_freq_khz > end_khz)
 			return false;
 		break;
 	case NL80211_CHAN_WIDTH_80P80:
@@ -461,6 +454,9 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	    !cfg80211_edmg_chandef_valid(chandef))
 		return false;
 
+	if (!cfg80211_chandef_is_s1g(chandef) && chandef->s1g_primary_2mhz)
+		return false;
+
 	return valid_puncturing_bitmap(chandef);
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
@@ -725,6 +721,10 @@ static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 {
 	struct ieee80211_channel *c;
 
+	/* DFS is not required for S1G */
+	if (cfg80211_chandef_is_s1g(chandef))
+		return 0;
+
 	for_each_subchan(chandef, freq, cf) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
@@ -1130,6 +1130,55 @@ static bool cfg80211_edmg_usable(struct wiphy *wiphy, u8 edmg_channels,
 	return true;
 }
 
+static bool cfg80211_s1g_usable(struct wiphy *wiphy,
+				const struct cfg80211_chan_def *chandef)
+{
+	u32 freq_khz;
+	const struct ieee80211_channel *chan;
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
+	for_each_s1g_subchan(chandef, freq_khz) {
+		chan = ieee80211_get_channel_khz(wiphy, freq_khz);
+		if (!chan || (chan->flags & prohibited_flags))
+			return false;
+	}
+
+	if (chandef->s1g_primary_2mhz) {
+		u32 sib_khz;
+		const struct ieee80211_channel *sibling;
+
+		sibling = cfg80211_s1g_get_primary_sibling(wiphy, chandef);
+		if (!sibling)
+			return false;
+
+		if (sibling->flags & IEEE80211_CHAN_S1G_NO_PRIMARY)
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
@@ -1154,6 +1203,9 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 	ext_nss_cap = __le16_to_cpu(vht_cap->vht_mcs.tx_highest) &
 			IEEE80211_VHT_EXT_NSS_BW_CAPABLE;
 
+	if (cfg80211_chandef_is_s1g(chandef))
+		return cfg80211_s1g_usable(wiphy, chandef);
+
 	if (edmg_cap->channels &&
 	    !cfg80211_edmg_usable(wiphy,
 				  chandef->edmg.channels,
@@ -1165,21 +1217,6 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
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
index 99e2aadc65f7..6a09f8456ae5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -880,6 +880,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_S1G_SHORT_BEACON] =
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
+	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -1268,6 +1269,15 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		    nla_put_flag(msg,
 				 NL80211_FREQUENCY_ATTR_ALLOW_20MHZ_ACTIVITY))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_4MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_4MHZ))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_8MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_8MHZ))
+			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_16MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_16MHZ))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
@@ -3449,6 +3459,7 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	chandef->center_freq1 = KHZ_TO_MHZ(control_freq);
 	chandef->freq1_offset = control_freq % 1000;
 	chandef->center_freq2 = 0;
+	chandef->s1g_primary_2mhz = false;
 
 	if (!chandef->chan) {
 		NL_SET_ERR_MSG_ATTR(extack, attrs[NL80211_ATTR_WIPHY_FREQ],
@@ -3492,27 +3503,21 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
@@ -10362,8 +10367,9 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				goto out_free;
 			}
 
-			/* ignore disabled channels */
+			/* Ignore disabled / no primary channels */
 			if (chan->flags & IEEE80211_CHAN_DISABLED ||
+			    chan->flags & IEEE80211_CHAN_S1G_NO_PRIMARY ||
 			    !cfg80211_wdev_channel_allowed(wdev, chan))
 				continue;
 
@@ -10385,6 +10391,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 				chan = &wiphy->bands[band]->channels[j];
 
 				if (chan->flags & IEEE80211_CHAN_DISABLED ||
+				    chan->flags &
+					    IEEE80211_CHAN_S1G_NO_PRIMARY ||
 				    !cfg80211_wdev_channel_allowed(wdev, chan))
 					continue;
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 3b0ac3437f81..73cab51f6379 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1707,6 +1707,16 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
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
 	if (!cfg80211_does_bw_fit_range(freq_range,
 					center_freq_khz,
@@ -1717,59 +1727,19 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
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
 
-- 
2.43.0


