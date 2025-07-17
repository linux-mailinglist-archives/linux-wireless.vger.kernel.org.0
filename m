Return-Path: <linux-wireless+bounces-25585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6719B0872E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62FD16CF6B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D8252906;
	Thu, 17 Jul 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="RgCzoc2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3B2566DF
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738147; cv=none; b=TX/WxiDpBKs5PQWbNJrsDXiu//2Mam7PJRzt6yVDPYc+N/Qs6iQT4OvWiv4QDpujMqHLwQ9W6NrWsXGiAFstxya1W+h7vnXdBrCJlfg18oZpsfphI/Xq6p0RwasqHHOTDEc1p5TQ9GeAGTbSs6jpiTHsMqloUzADQCssUsuI6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738147; c=relaxed/simple;
	bh=uHhboM3K2mLWjFR8EPzjOUHBB2JnihYTYJ9In9jR1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIokX3sG2kYEiF+Swd9PvQoD92HVuAOaPxaceEaqTI4HfBqCfImIYlY7YW+jyo58I5th6YbGlxRcoTZjKVLvdNoejyG5I7nj1lb8jm1pKM98ee/WStnPIKdr52Ou/01utR1AMfSiD1biLXP89g2xw7+0QCL7kAgEOPuic5IO4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=RgCzoc2x; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c7a52e97so562637b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752738145; x=1753342945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLr0lHyfOsZSZaQxxIuENNA0KwSZ3SpFqO61LbTKRFs=;
        b=RgCzoc2xC4WwzdqRDlkEMZm9xDaSokGKOe8Ppw898lnuTvbvTGzshwmf+1hSxNSGGs
         Ea+NuA1Neb9nMFfwcBKgwhBsVkicKY/xMsZ3wJjhP/Vk6ZPmmdiw0IyyVpBHAd6X/KJB
         Jl7C+L1yFC7sHVNaHbsUPBCMBlHMfUaTL7ZTAbyhVYl2Kg5JqxmJynAL+05h44wT+Etf
         9evret9HHKhsnwQZged2ejGQD42OrG/K/VDpn0+NwhiGyGAmGqw5cNMnp9S5Oan+43PB
         VWCF4ce12ODCGswO+JKX436t7LScgmpUB/qH3PUlVfiufkDDdi4PQkTrr+HuGRdkC8Yl
         tTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738145; x=1753342945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLr0lHyfOsZSZaQxxIuENNA0KwSZ3SpFqO61LbTKRFs=;
        b=UvPC5F4QJoIHOdjTNdsU8pWWnOcOOXAjC+NZA4NpOof9Uftu8BVsBYBWb9Vg3nIPFx
         ej483LUBxPuipQH2tRqmGnP+sl6rSdw4m66nnUZ4xIdziqCM+zMc23LwmLBccQu1IAcO
         LVtt501XJkUj6hNmkrNnu//wMtf5LJAQqDqDmE+pRwDOLN+Uu+2BKcnuMvcAJsBG9OFX
         7HDcHGbfgVKKYuewcm7PQBvfr91ZU6RiH+0lXroIPBRPfhG2xkFk/7emTVc/3Jv2CX+4
         IPN4cp1Ss0vJJ1d78o/8Uox0p6CHCQIIxeE6LFJZiAdOLwVl5RsibWDX3ptzqB8/fzQi
         zaNQ==
X-Gm-Message-State: AOJu0YynxbVxV9s1df9kIeUY59Qx8z6MZOEl7RRWZK/IdYIX8r9r30zL
	2BIpYCQ9fxNF+BHDNNRsCj15j8I4ZoVVJmcCbNVYj1rDi6SyILVMyNmgiQ1XaRClfWffX+FqAGg
	z7EnhI9U=
X-Gm-Gg: ASbGncunGKMKs8+JD+uWthafGzmelOEtLsyFRR7/mmUGT+bny4SicH/mB/WWk43Q97X
	vE0pb4P/msKYnC7nv079csiiJxcyfoxo1ryG4Yv5XwViujbLnlzfR7SFAHDVOTHveuYywsmhKKe
	7SwyvedbJEg8gQXpdRtQiLHSUaoFu0dF5O4Ds37ieqYV8e3TjE66427qTTkFwLVrGLilsb+LQJ/
	Lnno3FExhxC/7ABSBGI+rOdWS5o+WipVMyE8rb1yFkMak27X9GvHFq5kS6YUXVxq0I51E6/kTBf
	1RKhX3F9oQPoOTfJT/0EX0LkgybnPOsVEtYjo2VnjJTsecoivzcSblENpkTA/yX5uPWPkuAac7/
	bqH5LPxIg/ptKm6u5IzuaavZWDWKBIsBbhNNFAcjHmam9sTXHthJgJzHXPhNTwdmAywVyEK8=
X-Google-Smtp-Source: AGHT+IEVV1BQDHswMuAp8amPUoTSfvJMQA/ssQpnmvjv529xbgeBnlBH/Ir4Iw/qf/JvgWcAYbbCpw==
X-Received: by 2002:a05:6a00:a8e:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-756ea3ca5aamr9023993b3a.19.1752738144803;
        Thu, 17 Jul 2025 00:42:24 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e063b3sm16072550b3a.54.2025.07.17.00.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:42:24 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [wireless-next v3 1/4] wifi: cfg80211: support configuring an S1G short beaconing BSS
Date: Thu, 17 Jul 2025 17:42:02 +1000
Message-ID: <20250717074205.312577-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
References: <20250717074205.312577-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G short beacons are an optional frame type used in an S1G BSS
that contain a limited set of elements. While they are optional,
they are a fundamental part of S1G that enables significant
power saving.

Expose 2 additional netlink attributes,
NL80211_ATTR_S1G_LONG_BEACON_PERIOD which denotes the number of beacon
intervals between each long beacon and NL80211_ATTR_S1G_SHORT_BEACON
which is a nested attribute containing the short beacon tail and
head. We split them as the long beacon period cannot be updated,
and is only used when initialisng the interface, whereas the short
beacon data can be used to both initialise and update the templates.
This follows how things such as the beacon interval and DTIM period
currently operate.

During the initialisation path, we ensure we have the long beacon
period if the short beacon data is being passed down, whereas
the update path will simply update the template if its sent down.

The short beacon data is validated using the same routines for regular
beacons as they support correctly parsing the short beacon format
while ensuring the frame is well-formed.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v2 -> v3:

- No change (clarified functionality with regards to dynamic update
  in v2)
---
 include/net/cfg80211.h       | 23 ++++++++++++
 include/uapi/linux/nl80211.h | 39 +++++++++++++++++++
 net/wireless/nl80211.c       | 72 ++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6ec9a8865b8b..a7da04e13290 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1423,6 +1423,23 @@ struct cfg80211_unsol_bcast_probe_resp {
 	const u8 *tmpl;
 };
 
+/**
+ * struct cfg80211_s1g_short_beacon - S1G short beacon data.
+ *
+ * @update: Set to true if the feature configuration should be updated.
+ * @short_head: Short beacon head.
+ * @short_tail: Short beacon tail.
+ * @short_head_len: Short beacon head len.
+ * @short_tail_len: Short beacon tail len.
+ */
+struct cfg80211_s1g_short_beacon {
+	bool update;
+	const u8 *short_head;
+	const u8 *short_tail;
+	size_t short_head_len;
+	size_t short_tail_len;
+};
+
 /**
  * struct cfg80211_ap_settings - AP configuration
  *
@@ -1463,6 +1480,8 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
+ * @s1g_long_beacon_period: S1G long beacon period
+ * @s1g_short_beacon: S1G short beacon data
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1496,6 +1515,8 @@ struct cfg80211_ap_settings {
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
+	u8 s1g_long_beacon_period;
+	struct cfg80211_s1g_short_beacon s1g_short_beacon;
 };
 
 
@@ -1507,11 +1528,13 @@ struct cfg80211_ap_settings {
  * @beacon: beacon data
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @s1g_short_beacon: S1G short beacon data
  */
 struct cfg80211_ap_update {
 	struct cfg80211_beacon_data beacon;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	struct cfg80211_s1g_short_beacon s1g_short_beacon;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 39460334dafb..d1a14f2892d9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2915,6 +2915,19 @@ enum nl80211_commands {
  *	applicable to that specific radio only. If the radio id is greater
  *	thank the number of radios, error denoting invalid value is returned.
  *
+ * @NL80211_ATTR_S1G_LONG_BEACON_PERIOD: (u8) Integer attribute that represents
+ *	the number of beacon intervals between each long beacon transmission
+ *	for an S1G BSS with short beaconing enabled. This is a required
+ *	attribute for initialising an S1G short beaconing BSS. When updating
+ *	the short beacon data, this is not required. It has a minimum value of
+ *	2 (i.e 2 beacon intervals).
+ *
+ * @NL80211_ATTR_S1G_SHORT_BEACON: Nested attribute containing the short beacon
+ *	head and tail used to set or update the short beacon templates. When
+ *	bringing up a new interface, %NL80211_ATTR_S1G_LONG_BEACON_PERIOD is
+ *	required alongside this attribute. Refer to
+ *	@enum nl80211_s1g_short_beacon_attrs for the attribute definitions.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3474,6 +3487,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_WIPHY_RADIO_INDEX,
 
+	NL80211_ATTR_S1G_LONG_BEACON_PERIOD,
+	NL80211_ATTR_S1G_SHORT_BEACON,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8148,4 +8164,27 @@ enum nl80211_wiphy_radio_freq_range {
 	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_s1g_short_beacon_attrs - S1G short beacon data
+ *
+ * @__NL80211_S1G_SHORT_BEACON_ATTR_INVALID: Invalid
+ *
+ * @NL80211_S1G_SHORT_BEACON_ATTR_HEAD: Short beacon head (binary).
+ * @NL80211_S1G_SHORT_BEACON_ATTR_TAIL: Short beacon tail (binary).
+ *
+ * @__NL80211_S1G_SHORT_BEACON_ATTR_LAST: Internal
+ * @NL80211_S1G_SHORT_BEACON_ATTR_MAX: Highest attribute
+ */
+enum nl80211_s1g_short_beacon_attrs {
+	__NL80211_S1G_SHORT_BEACON_ATTR_INVALID,
+
+	NL80211_S1G_SHORT_BEACON_ATTR_HEAD,
+	NL80211_S1G_SHORT_BEACON_ATTR_TAIL,
+
+	/* keep last */
+	__NL80211_S1G_SHORT_BEACON_ATTR_LAST,
+	NL80211_S1G_SHORT_BEACON_ATTR_MAX =
+		__NL80211_S1G_SHORT_BEACON_ATTR_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4e6c0a4e2a82..47c35b741124 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -482,6 +482,16 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
+static const struct nla_policy
+nl80211_s1g_short_beacon[NL80211_S1G_SHORT_BEACON_ATTR_MAX + 1] = {
+	[NL80211_S1G_SHORT_BEACON_ATTR_HEAD] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head,
+				       IEEE80211_MAX_DATA_LEN),
+	[NL80211_S1G_SHORT_BEACON_ATTR_TAIL] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
+				       IEEE80211_MAX_DATA_LEN),
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -858,6 +868,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
 	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
+	[NL80211_ATTR_S1G_LONG_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U8, 2),
+	[NL80211_ATTR_S1G_SHORT_BEACON] =
+		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 };
 
 /* policy for the key attributes */
@@ -6202,6 +6215,41 @@ static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params
 	return 0;
 }
 
+static int
+nl80211_parse_s1g_short_beacon(struct cfg80211_registered_device *rdev,
+			       struct nlattr *attrs,
+			       struct cfg80211_s1g_short_beacon *sb)
+{
+	struct nlattr *tb[NL80211_S1G_SHORT_BEACON_ATTR_MAX + 1];
+	int ret;
+
+	if (!rdev->wiphy.bands[NL80211_BAND_S1GHZ])
+		return -EINVAL;
+
+	ret = nla_parse_nested(tb, NL80211_S1G_SHORT_BEACON_ATTR_MAX, attrs,
+			       NULL, NULL);
+	if (ret)
+		return ret;
+
+	/* Short beacon tail is optional (i.e might only include the TIM) */
+	if (!tb[NL80211_S1G_SHORT_BEACON_ATTR_HEAD])
+		return -EINVAL;
+
+	sb->short_head = nla_data(tb[NL80211_S1G_SHORT_BEACON_ATTR_HEAD]);
+	sb->short_head_len = nla_len(tb[NL80211_S1G_SHORT_BEACON_ATTR_HEAD]);
+	sb->short_tail_len = 0;
+
+	if (tb[NL80211_S1G_SHORT_BEACON_ATTR_TAIL]) {
+		sb->short_tail =
+			nla_data(tb[NL80211_S1G_SHORT_BEACON_ATTR_TAIL]);
+		sb->short_tail_len =
+			nla_len(tb[NL80211_S1G_SHORT_BEACON_ATTR_TAIL]);
+	}
+
+	sb->update = true;
+	return 0;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6442,6 +6490,22 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_S1G_SHORT_BEACON]) {
+		if (!info->attrs[NL80211_ATTR_S1G_LONG_BEACON_PERIOD]) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		params->s1g_long_beacon_period = nla_get_u8(
+			info->attrs[NL80211_ATTR_S1G_LONG_BEACON_PERIOD]);
+
+		err = nl80211_parse_s1g_short_beacon(
+			rdev, info->attrs[NL80211_ATTR_S1G_SHORT_BEACON],
+			&params->s1g_short_beacon);
+		if (err)
+			goto out;
+	}
+
 	err = nl80211_calculate_ap_params(params);
 	if (err)
 		goto out;
@@ -6550,6 +6614,14 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	attr = info->attrs[NL80211_ATTR_S1G_SHORT_BEACON];
+	if (attr) {
+		err = nl80211_parse_s1g_short_beacon(rdev, attr,
+						     &params->s1g_short_beacon);
+		if (err)
+			goto out;
+	}
+
 	err = rdev_change_beacon(rdev, dev, params);
 
 out:
-- 
2.43.0


