Return-Path: <linux-wireless+bounces-25349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC51B0357D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC483B5E59
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 05:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908721FA15E;
	Mon, 14 Jul 2025 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ogstTroC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C918D
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470070; cv=none; b=B6eiArWRoGAB14Edzf1rl/8QZrs6LvRIotwW/YtjdXVb8u9sDSdHTrMgqRNRbbJ1o4GY6gki68XZUnePlCuDEsjsr3bONzPqDO9ERZdtMY1++NpigbDiESjlwOi8IPAx1WTbQNt0yct1j5akWAHtqg28WDWJHqgxn/mck2hGlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470070; c=relaxed/simple;
	bh=D0uJnKEbCXuU9qyIiqVS4WdzXsgBtGmDLDldBUG6qOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW133myKOJPeSVquspgjVmYu5rU1fPRY7FUFAaNGtBgD8U7ILhXRDlTht6oksphQa0SJHCloj6AeNru3uRtAw2F99gTNN1mXL1bA/jr4HzzkL/75PxOXikZ8PxbP5a+1Gz8hvUyIqiNDG7f6lJ16h3zh01/8eW54tArbqoipmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ogstTroC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so4052542a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 22:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1752470068; x=1753074868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXnLsTWmE0Sr6Lz5LGjugeolPj/8AEA8kS5P55ltkls=;
        b=ogstTroCdcVGjOeKz6LCkmvFTN3QCheIwLMKlpOj6GmhZ6jcKhhdLCw7TFQxR4cOJT
         A1CMLPv+Nw53OLKkApj2BWUw34nHs9APrQbwoNQOGRsQ88EthX1xh2PvUQhM2gEgogWe
         1PC9U6b3nUQB+NY+ZUVL/9/EE3YVwnGCUHSIoMFH3Mj2n501qeroQCgJHWUtBbpYZYsL
         5qPBYRqthEx5ZyUVc8UoOzWdwe9N0S9shE/qG4uw+VSA2Mr2x5zd14BbCZqIujYgSYxX
         SPwKIzvcxhMvrMSb6CCHP5o2YxZYKp1OMde2NCp+v2WXVwxrAh1P4i4r9UC74NaCSwy8
         TZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752470068; x=1753074868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXnLsTWmE0Sr6Lz5LGjugeolPj/8AEA8kS5P55ltkls=;
        b=njpDkKksSAM8+Xk3cK9HH47e59rnVwiGhCXBDYlzcPi4UdmEKH2t3Z5AFosVMYXgYG
         ENPiFzCot51cC+NC29X7FcnRQI+8rexFjUwEAfOmY1cpWBX1E3YnphNVRtgNv4LRONSw
         N5Vhi++cqZ/+ArJWjoGPUfqi/n3BRAgW4l/iHfrKqF/uKtJCCVP8+tJxY90MD5JMBxTP
         Q+YkCyioQQrvZTEFunZytWvia+B4knU8yAJsgrDQ2QUgjkfVf9fO2crfbWepSta8WrQx
         JRr9JBykKOQ50bRGt28U5Jyql/YmPmzzTX4KewBN9owewwPfetxjqlCgtmL2gIdrn5Hn
         0D5w==
X-Gm-Message-State: AOJu0YwEICrL2C8eT5gYYB2zD3SEmyZb9nLvgekWnZvGOJm5IktRyHc5
	+YpkLOGhQ4dU41Sa6V0/P/OsZ8HuKov7K+GvcHlNMyvcS6PtZATQyD4XsEJ2AyXuYmoJ0M1XzAE
	K5CQ0N2o=
X-Gm-Gg: ASbGnctVAgeIYg3xoZIa4hp38Qk9n0KpBvBzVOn2Amnv9Fn6LL4OVrMnTvEUqNoKmiV
	m78tfJYUnwh1H/hwGxF/XlfzBg1wCW/460tcrZowu/qDQaBEmq9EbrbwibDZlB4L2q7SJVUwPq0
	lLeaBdgLG9odIeWc/5d0KxPyrw9cvozU99mqy6hwcYD1xSNA16HU5A3gXcPeHdq4gy7BShD40gm
	6a3sNoNx0Ke77IQFyPoDv572f6jG1Kc+BHtu2s/WwPPrM3NB3nY1N1RygciSXLEDMluhNzlWq6T
	0FzYYgvl7KadhxY8X9h+JZRvxxwvOu8Y+ULDprjoB8IpccP7yRMOBrSaVsgk4TezjFcq5XjoZdh
	GoYQl4wmYRC9leS0hIjqEAy+Mcs5X4mKQFOIzXQ1pO9NyP4dA7fcTDWb0xG6tNgKnB2B/eQY=
X-Google-Smtp-Source: AGHT+IF9JDySm2fvGuKO2iB11DBLipIZy6CFQINlizl5NQnYXQKwiKsxta6evgDiAQBrX2DjqPYBqw==
X-Received: by 2002:a17:90b:2b50:b0:30e:6a9d:d78b with SMTP id 98e67ed59e1d1-31c4d4d0740mr15513579a91.12.1752470067423;
        Sun, 13 Jul 2025 22:14:27 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb61291sm9881930a91.34.2025.07.13.22.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:14:27 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC 1/5] wifi: cfg80211: support configuring an S1G short beaconing BSS
Date: Mon, 14 Jul 2025 15:13:59 +1000
Message-ID: <20250714051403.597090-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
References: <20250714051403.597090-1-lachlan.hodges@morsemicro.com>
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

When an S1G BSS is configured with short beaconing enabled, the
BSS uses the TSBTT (Target Short Beacon Transmission Time) as the
base unit for the DTIM period and the beacon interval as per
IEEE80211-2024 11.1.2.1:

"In an S1G BSS, the S1G AP shall generate S1G Beacon frames
every dot11BeaconPeriod TUs; and if dot11ShortBeaconInterval is
true, it shall additionally generate S1G Beacon frames every
dot11ShortBeaconPeriod TUs"

Note: As the kernel uses the notion of beacon interval rather then
beacon period, we do the same with short beaconing - where
dot11ShortBeaconPeriod is known as the short beacon interval.

and per IEEE80211-2024 Annex C.3 MIB detail:

dot11ShortBeaconPeriod:

This attribute specifies the time period that a STA uses for
scheduling S1G Beacon transmissions in a TSBTT that is not a TBTT.

dot11ShortBeaconDTIMPeriod:

This attribute specifies the number of short beacon intervals that
elapse between transmission of S1G Beacon frames containing a TIM
element whose DTIM Count field is 0.

Expose 2 additional attributes alongside the short beacon frame data,
short_interval which is the time in TUs between each TSBTT and the
short_dtim_period which is the number of TSBTTs between each DTIM
beacon. Additionally, validate the elements present in the short
beacon as per IEEE80211-2024 9.3.4.3 Table 9-76 which describes
the elements permitted within a short beacon. Introduce these new
attributes as an optional netlink attribute to allow an S1G BSS
to be configured for short beaconing.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/ieee80211.h    |   4 +
 include/net/cfg80211.h       |  32 ++++++
 include/uapi/linux/nl80211.h |  32 ++++++
 net/wireless/nl80211.c       | 208 +++++++++++++++++++++++++++++++++++
 4 files changed, 276 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e5a2096e022e..16e76cbf6bd6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3823,14 +3823,18 @@ enum ieee80211_eid {
 
 	WLAN_EID_REDUCED_NEIGHBOR_REPORT = 201,
 
+	WLAN_EID_RPS = 208,
+	WLAN_EID_PAGE_SLICE = 209,
 	WLAN_EID_AID_REQUEST = 210,
 	WLAN_EID_AID_RESPONSE = 211,
 	WLAN_EID_S1G_BCN_COMPAT = 213,
 	WLAN_EID_S1G_SHORT_BCN_INTERVAL = 214,
 	WLAN_EID_S1G_TWT = 216,
 	WLAN_EID_S1G_CAPABILITIES = 217,
+	WLAN_EID_SST = 220,
 	WLAN_EID_VENDOR_SPECIFIC = 221,
 	WLAN_EID_QOS_PARAMETER = 222,
+	WLAN_EID_S1G_RELAY = 224,
 	WLAN_EID_S1G_OPERATION = 232,
 	WLAN_EID_CAG_NUMBER = 237,
 	WLAN_EID_AP_CSN = 239,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6ec9a8865b8b..c7c9a297753b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1423,6 +1423,34 @@ struct cfg80211_unsol_bcast_probe_resp {
 	const u8 *tmpl;
 };
 
+/**
+ * struct cfg80211_s1g_short_beacon - S1G short beacon data.
+ *
+ * @update: Set to true if the beacon head/tail has been updated. In this
+ *	case the BSS has already been configured to be short beaconing.
+ * @short_head: Short beacon head.
+ * @short_tail: Short beacon tail.
+ * @short_head_len: Short beacon head len.
+ * @short_tail_len: Short beacon tail len.
+ * @short_interval: Time in TU between each TSBTT (Target Short Beacon
+ *	Transmission Time). When short beaconing is enabled for an S1G
+ *	BSS, this value will be used to determine beacon transmission
+ *	times for both long and short beacons.
+ * @short_dtim_period: Specifies the number of TSBTTs that elapse between
+ *	transmission of S1G beacon frames containing a TIM element whose
+ *	DTIM count field is 0. When short beaconing is enabled for an S1G
+ *	BSS, this value is used to initialise the current DTIM count.
+ */
+struct cfg80211_s1g_short_beacon {
+	bool update;
+	const u8 *short_head;
+	const u8 *short_tail;
+	size_t short_head_len;
+	size_t short_tail_len;
+	u32 short_interval;
+	u8 short_dtim_period;
+};
+
 /**
  * struct cfg80211_ap_settings - AP configuration
  *
@@ -1463,6 +1491,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
+ * @s1g_short_beacon: S1G short beacon data
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1496,6 +1525,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
+	struct cfg80211_s1g_short_beacon s1g_short_beacon;
 };
 
 
@@ -1507,11 +1537,13 @@ struct cfg80211_ap_settings {
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
index 39460334dafb..ccfc5ab1a42f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2915,6 +2915,10 @@ enum nl80211_commands {
  *	applicable to that specific radio only. If the radio id is greater
  *	thank the number of radios, error denoting invalid value is returned.
  *
+ * @NL80211_ATTR_S1G_SHORT_BEACON: Optional parameter to configure an S1G BSS
+ *	with short beaconing support. It is a nested attribute, see
+ *	@enum nl80211_s1g_short_beacon_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3474,6 +3478,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_WIPHY_RADIO_INDEX,
 
+	NL80211_ATTR_S1G_SHORT_BEACON,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8148,4 +8154,30 @@ enum nl80211_wiphy_radio_freq_range {
 	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_s1g_short_beacon_attrs - S1G short beacon data
+ *
+ * @__NL80211_S1G_SHORT_BEACON_ATTR_INVALID: Invalid
+ *
+ * @NL80211_S1G_SHORT_BEACON_HEAD: Short beacon head (binary).
+ * @NL80211_S1G_SHORT_BEACON_TAIL: Short beacon tail (binary).
+ * @NL80211_S1G_SHORT_BEACON_INTERVAL: Time in TUs between each short
+ *	beacon transmission (u32).
+ * @NL80211_S1G_SHORT_BEACON_DTIM_PERIOD: DTIM period for a short
+ *	beaconing BSS (u8).
+ */
+enum nl80211_s1g_short_beacon_attrs {
+	__NL80211_S1G_SHORT_BEACON_ATTR_INVALID,
+
+	NL80211_S1G_SHORT_BEACON_HEAD,
+	NL80211_S1G_SHORT_BEACON_TAIL,
+	NL80211_S1G_SHORT_BEACON_INTERVAL,
+	NL80211_S1G_SHORT_BEACON_DTIM_PERIOD,
+
+	/* keep last */
+	__NL80211_S1G_SHORT_BEACON_ATTR_LAST,
+	NL80211_S1G_SHORT_BEACON_ATTR_MAX =
+		__NL80211_S1G_SHORT_BEACON_ATTR_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4e6c0a4e2a82..519f8fe9f686 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -258,6 +258,10 @@ static int validate_beacon_head(const struct nlattr *attr,
 	data += fixedlen;
 	len -= fixedlen;
 
+	if (s1g_bcn &&
+	    ieee80211_is_s1g_short_beacon(ext->frame_control, data, len))
+		goto err;
+
 	for_each_element(elem, data, len) {
 		/* nothing */
 	}
@@ -288,6 +292,92 @@ static int validate_ie_attr(const struct nlattr *attr,
 	return -EINVAL;
 }
 
+/*
+ * Short beacons contain a limited set of allowed elements as per
+ * IEEE80211-2024 9.3.4.3 Table 9-76. The TIM element is allowed,
+ * but as it is inserted by mac80211, we do not check for it.
+ */
+static int is_valid_s1g_short_elem(const struct element *elem)
+{
+	switch (elem->id) {
+	case WLAN_EID_FMS_DESCRIPTOR:
+	case WLAN_EID_RPS:
+	case WLAN_EID_SST:
+	case WLAN_EID_S1G_RELAY:
+	case WLAN_EID_PAGE_SLICE:
+	case WLAN_EID_VENDOR_SPECIFIC:
+	case WLAN_EID_MMIE:
+	case WLAN_EID_MIC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int validate_s1g_short_beacon_head(const struct nlattr *attr,
+					  struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+	const struct element *elem;
+	unsigned int fixedlen, hdrlen;
+	const struct ieee80211_ext *ext = (void *)data;
+
+	if (len < offsetofend(typeof(*ext), frame_control))
+		goto err;
+
+	if (!ieee80211_is_s1g_beacon(ext->frame_control))
+		goto err;
+
+	fixedlen = offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+		   ieee80211_s1g_optional_len(ext->frame_control);
+	hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
+
+	if (len < fixedlen)
+		goto err;
+
+	if (ieee80211_hdrlen(ext->frame_control) != hdrlen)
+		goto err;
+
+	data += fixedlen;
+	len -= fixedlen;
+
+	if (!ieee80211_is_s1g_short_beacon(ext->frame_control, data, len))
+		goto err;
+
+	for_each_element(elem, data, len) {
+		if (!is_valid_s1g_short_elem(elem))
+			goto err;
+	}
+
+	if (for_each_element_completed(elem, data, len))
+		return 0;
+
+err:
+	NL_SET_ERR_MSG_ATTR(extack, attr, "malformed short beacon head");
+	return -EINVAL;
+}
+
+static int validate_s1g_short_beacon_ie_attr(const struct nlattr *attr,
+					     struct netlink_ext_ack *extack)
+{
+	const u8 *data = nla_data(attr);
+	unsigned int len = nla_len(attr);
+	const struct element *elem;
+
+	for_each_element(elem, data, len) {
+		if (!is_valid_s1g_short_elem(elem))
+			goto err;
+	}
+
+	if (for_each_element_completed(elem, data, len))
+		return 0;
+
+err:
+	NL_SET_ERR_MSG_ATTR(extack, attr, "malformed short beacon elements");
+	return -EINVAL;
+}
+
 static int validate_he_capa(const struct nlattr *attr,
 			    struct netlink_ext_ack *extack)
 {
@@ -482,6 +572,20 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
+static const struct nla_policy
+nl80211_s1g_short_beacon[NL80211_S1G_SHORT_BEACON_ATTR_MAX + 1] = {
+	[NL80211_S1G_SHORT_BEACON_HEAD] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+				       validate_s1g_short_beacon_head,
+				       IEEE80211_MAX_DATA_LEN),
+	[NL80211_S1G_SHORT_BEACON_TAIL] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+				       validate_s1g_short_beacon_ie_attr,
+				       IEEE80211_MAX_DATA_LEN),
+	[NL80211_S1G_SHORT_BEACON_INTERVAL] = { .type = NLA_U32 },
+	[NL80211_S1G_SHORT_BEACON_DTIM_PERIOD] = { .type = NLA_U8 },
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -858,6 +962,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
 	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
+	[NL80211_ATTR_S1G_SHORT_BEACON] =
+		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 };
 
 /* policy for the key attributes */
@@ -6202,6 +6308,73 @@ static int nl80211_validate_ap_phy_operation(struct cfg80211_ap_settings *params
 	return 0;
 }
 
+static int nl80211_validate_s1g_short_conf(struct cfg80211_ap_settings *params)
+{
+	struct cfg80211_s1g_short_beacon *sb = &params->s1g_short_beacon;
+	u64 beacon_int = params->beacon_interval;
+	u32 short_int = sb->short_interval;
+
+	/*
+	 * As per IEEE80211 11.1.3.10.2, beacon_interval = n * short_interval
+	 * where n is a positive integer. Meaning a BSS can be configured such
+	 * that both the short beacon interval and long beacon interval are
+	 * equivalent. This effectively means we aren't short beaconing. In
+	 * this case, since the short beacon data is irellevent its probably a
+	 * misconfiguration and we should reject it.
+	 */
+	if (sb->short_interval >= params->beacon_interval)
+		return -EINVAL;
+
+	if (do_div(beacon_int, short_int))
+		return -EINVAL;
+
+	return 0;
+}
+
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
+	if (!tb[NL80211_S1G_SHORT_BEACON_HEAD])
+		return -EINVAL;
+
+	sb->update = false;
+	sb->short_head = nla_data(tb[NL80211_S1G_SHORT_BEACON_HEAD]);
+	sb->short_head_len = nla_len(tb[NL80211_S1G_SHORT_BEACON_HEAD]);
+	sb->short_tail_len = 0;
+
+	if (tb[NL80211_S1G_SHORT_BEACON_TAIL]) {
+		sb->short_tail = nla_data(tb[NL80211_S1G_SHORT_BEACON_TAIL]);
+		sb->short_tail_len = nla_len(tb[NL80211_S1G_SHORT_BEACON_TAIL]);
+	}
+
+	if (!tb[NL80211_S1G_SHORT_BEACON_INTERVAL] ||
+	    !tb[NL80211_S1G_SHORT_BEACON_DTIM_PERIOD]) {
+		sb->update = true;
+		return 0;
+	}
+
+	sb->short_interval =
+		nla_get_u32(tb[NL80211_S1G_SHORT_BEACON_INTERVAL]);
+	sb->short_dtim_period =
+		nla_get_u8(tb[NL80211_S1G_SHORT_BEACON_DTIM_PERIOD]);
+
+	return 0;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6442,6 +6615,28 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_S1G_SHORT_BEACON]) {
+		err = nl80211_parse_s1g_short_beacon(
+			rdev, info->attrs[NL80211_ATTR_S1G_SHORT_BEACON],
+			&params->s1g_short_beacon);
+		if (err)
+			goto out;
+
+		/*
+		 * If we have only received the parameters to perform a
+		 * short beacon update, return an error to usermode as
+		 * the BSS has not yet been configured for short beaconing.
+		 */
+		if (params->s1g_short_beacon.update) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = nl80211_validate_s1g_short_conf(params);
+		if (err)
+			goto out;
+	}
+
 	err = nl80211_calculate_ap_params(params);
 	if (err)
 		goto out;
@@ -6550,6 +6745,19 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	attr = info->attrs[NL80211_ATTR_S1G_SHORT_BEACON];
+	if (attr) {
+		err = nl80211_parse_s1g_short_beacon(rdev, attr,
+						     &params->s1g_short_beacon);
+		if (err)
+			goto out;
+
+		if (!params->s1g_short_beacon.update) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
 	err = rdev_change_beacon(rdev, dev, params);
 
 out:
-- 
2.43.0


