Return-Path: <linux-wireless+bounces-10102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00892B23F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D9F1F21802
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5E153578;
	Tue,  9 Jul 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="rgw/RYAh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4C143752
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514325; cv=none; b=RwAv3MC/lLVFpzSgYjAPB8N4w7YYFsFk8zOXTA3ZkutnHZX3PmFP3h5mpHdlZgCZM3+iN5dJ2qrs2drgVmaU1mFZGoLrq++lfAyD9ZNhOy37M279bCyNMOjgMsdEwWVddc9/lVmjk8djdUmNaoGC7tPfqTdkzQETa1+F1qw9xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514325; c=relaxed/simple;
	bh=GONkUTb4p0/sCI4mm6Nh8FY/gnQBngVh5tQuhPKlDIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8YbpU+0OtmDJhLtolcOSCvtSVC3tt3cHqZ7Ld7zxAoNqBgrqmiEJTZYoyt0dSI6LUQeTxkwjSQqxzlFWRAgxrusU1dhd5szETYpNEiZKx/DQGW37boWxMoa/rGOzdFcMUImsYMWcFuq4CrMYQp1Ik5Ydi/yq63O/P+KGzqeWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=rgw/RYAh; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rgXtAVij848Qw3gMF4uPtcbDP8WupjAUKFLmG7Dzq5I=; b=rgw/RYAhOxmoicX2bs5FtYVzm5
	RSfJ7Wvt5CXqedtr+eZINviMaMO+k2doBSP7N/aV/vfMUeCkQgNyV5bzDDs7TYPpXhZyqziLcLtV5
	U5wkmm1CH/E428YRraWgTfk4ezfANJ2mp22thtAOmdnGcMTKLryxf8k05GIuSbw3oCxU=;
Received: from p54ae937c.dip0.t-ipconnect.de ([84.174.147.124] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sR6My-004Ln4-0e;
	Tue, 09 Jul 2024 10:38:40 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v5 02/10] wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
Date: Tue,  9 Jul 2024 10:38:30 +0200
Message-ID: <18a88f9ce82b1c9f7c12f1672430eaf2bb0be295.1720514221.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.8f108602e7f90e91332f131cc9fa115a669a2bf4.1720514221.git-series.nbd@nbd.name>
References: <cover.8f108602e7f90e91332f131cc9fa115a669a2bf4.1720514221.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prerequisite for MLO support in cfg80211/mac80211 is that all the links
participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
expectation, some drivers may need to group multiple discrete hardware each
acting as a link in MLO under single wiphy.

With this change, supported frequencies and interface combinations of each
individual radio are reported to user space. This allows user space to figure
out the limitations of what combination of channels can be used concurrently.

Even for non-MLO devices, this improves support for devices capable of
running on multiple channels at the same time.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       |  42 ++++++++++++-
 include/uapi/linux/nl80211.h |  65 +++++++++++++++++++++-
 net/wireless/nl80211.c       | 113 ++++++++++++++++++++++++++++++++----
 3 files changed, 208 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6f992aff74ae..a00cf80e61dc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5046,7 +5046,9 @@ struct ieee80211_iface_limit {
  * struct ieee80211_iface_combination - possible interface combination
  *
  * With this structure the driver can describe which interface
- * combinations it supports concurrently.
+ * combinations it supports concurrently. When set in a struct wiphy_radio,
+ * the combinations refer to combinations of interfaces currently active on
+ * that radio.
  *
  * Examples:
  *
@@ -5406,6 +5408,38 @@ struct wiphy_iftype_akm_suites {
 	int n_akm_suites;
 };
 
+/**
+ * struct wiphy_radio_freq_range - wiphy frequency range
+ * @start_freq:  start range edge frequency (kHz)
+ * @end_freq:    end range edge frequency (kHz)
+ */
+struct wiphy_radio_freq_range {
+	u32 start_freq;
+	u32 end_freq;
+};
+
+
+/**
+ * struct wiphy_radio - physical radio of a wiphy
+ * This structure describes a physical radio belonging to a wiphy.
+ * It is used to describe concurrent-channel capabilities. Only one channel
+ * can be active on the radio described by struct wiphy_radio.
+ *
+ * @freq_range: frequency range that the radio can operate on.
+ * @n_freq_range: number of elements in @freq_range
+ *
+ * @iface_combinations: Valid interface combinations array, should not
+ *	list single interface types.
+ * @n_iface_combinations: number of entries in @iface_combinations array.
+ */
+struct wiphy_radio {
+	const struct wiphy_radio_freq_range *freq_range;
+	int n_freq_range;
+
+	const struct ieee80211_iface_combination *iface_combinations;
+	int n_iface_combinations;
+};
+
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
 
 /**
@@ -5624,6 +5658,9 @@ struct wiphy_iftype_akm_suites {
  *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
  *	supports enabling HW timestamping for all peers (i.e. no need to
  *	specify a mac address).
+ *
+ * @radio: radios belonging to this wiphy
+ * @n_radio: number of radios
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5774,6 +5811,9 @@ struct wiphy {
 
 	u16 hw_timestamp_max_peers;
 
+	int n_radio;
+	const struct wiphy_radio *radio;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6ae3997061b6..f97f5adc8d51 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2052,6 +2052,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_INTERFACE_COMBINATIONS: Nested attribute listing the supported
  *	interface combinations. In each nested item, it contains attributes
  *	defined in &enum nl80211_if_combination_attrs.
+ *	If the wiphy uses multiple radios (@NL80211_ATTR_WIPHY_RADIOS is set),
+ *	this attribute contains the interface combinations of the first radio.
+ *	See @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS for the global wiphy
+ *	combinations for the sum of all radios.
  * @NL80211_ATTR_SOFTWARE_IFTYPES: Nested attribute (just like
  *	%NL80211_ATTR_SUPPORTED_IFTYPES) containing the interface types that
  *	are managed in software: interfaces of these types aren't subject to
@@ -2856,6 +2860,14 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_WIPHY_RADIOS: Nested attribute describing physical radios
+ *	belonging to this wiphy. See &enum nl80211_wiphy_radio_attrs.
+ *
+ * @NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS: Nested attribute listing the
+ *	supported interface combinations for all radios combined. In each
+ *	nested item, it contains attributes defined in
+ *	&enum nl80211_if_combination_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3413,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_WIPHY_RADIOS,
+	NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8005,4 +8020,54 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
+ *
+ * @NL80211_WIPHY_RADIO_ATTR_INDEX: Index of this radio (u32)
+ * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE: Frequency range supported by this
+ *	radio. Attribute may be present multiple times.
+ * @NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION: Supported interface
+ *	combination for this radio. Attribute may be present multiple times
+ *	and contains attributes defined in &enum nl80211_if_combination_attrs.
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
+ * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
+ */
+enum nl80211_wiphy_radio_attrs {
+	__NL80211_WIPHY_RADIO_ATTR_INVALID,
+
+	NL80211_WIPHY_RADIO_ATTR_INDEX,
+	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
+	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
+
+	/* keep last */
+	__NL80211_WIPHY_RADIO_ATTR_LAST,
+	NL80211_WIPHY_RADIO_ATTR_MAX = __NL80211_WIPHY_RADIO_ATTR_LAST - 1,
+};
+
+/**
+ * enum nl80211_wiphy_radio_freq_range - wiphy radio frequency range
+ *
+ * @__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID: Invalid
+ *
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start (u32).
+ *	The unit is kHz.
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end (u32).
+ *	The unit is kHz.
+ *
+ * @__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST: Internal
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_MAX: Highest attribute
+ */
+enum nl80211_wiphy_radio_freq_range {
+	__NL80211_WIPHY_RADIO_FREQ_ATTR_INVALID,
+
+	NL80211_WIPHY_RADIO_FREQ_ATTR_START,
+	NL80211_WIPHY_RADIO_FREQ_ATTR_END,
+
+	__NL80211_WIPHY_RADIO_FREQ_ATTR_LAST,
+	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index deacd5f3f256..7397a372c78e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1632,16 +1632,18 @@ static int nl80211_put_iftypes(struct sk_buff *msg, u32 attr, u16 ifmodes)
 }
 
 static int nl80211_put_ifcomb_data(struct sk_buff *msg, bool large, int idx,
-				   const struct ieee80211_iface_combination *c)
+				   const struct ieee80211_iface_combination *c,
+				   u16 nested)
 {
 	struct nlattr *nl_combi, *nl_limits;
 	int i;
 
-	nl_combi = nla_nest_start_noflag(msg, idx);
+	nl_combi = nla_nest_start_noflag(msg, idx | nested);
 	if (!nl_combi)
 		goto nla_put_failure;
 
-	nl_limits = nla_nest_start_noflag(msg, NL80211_IFACE_COMB_LIMITS);
+	nl_limits = nla_nest_start_noflag(msg, NL80211_IFACE_COMB_LIMITS |
+					       nested);
 	if (!nl_limits)
 		goto nla_put_failure;
 
@@ -1689,19 +1691,26 @@ static int nl80211_put_ifcomb_data(struct sk_buff *msg, bool large, int idx,
 
 static int nl80211_put_iface_combinations(struct wiphy *wiphy,
 					  struct sk_buff *msg,
-					  bool large)
+					  int attr, int radio,
+					  bool large, u16 nested)
 {
+	const struct ieee80211_iface_combination *c;
 	struct nlattr *nl_combis;
-	int i;
+	int i, n;
 
-	nl_combis = nla_nest_start_noflag(msg,
-					  NL80211_ATTR_INTERFACE_COMBINATIONS);
+	nl_combis = nla_nest_start_noflag(msg, attr | nested);
 	if (!nl_combis)
 		goto nla_put_failure;
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++)
-		if (nl80211_put_ifcomb_data(msg, large, i + 1,
-					    &wiphy->iface_combinations[i]))
+	if (radio >= 0) {
+		c = wiphy->radio[0].iface_combinations;
+		n = wiphy->radio[0].n_iface_combinations;
+	} else {
+		c = wiphy->iface_combinations;
+		n = wiphy->n_iface_combinations;
+	}
+	for (i = 0; i < n; i++)
+		if (nl80211_put_ifcomb_data(msg, large, i + 1, &c[i], nested))
 			goto nla_put_failure;
 
 	nla_nest_end(msg, nl_combis);
@@ -2408,6 +2417,80 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
+{
+	const struct wiphy_radio *r = &wiphy->radio[idx];
+	struct nlattr *radio, *freq;
+	int i;
+
+	radio = nla_nest_start(msg, idx);
+	if (!radio)
+		return -ENOBUFS;
+
+	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
+		goto nla_put_failure;
+
+	for (i = 0; i < r->n_freq_range; i++) {
+		const struct wiphy_radio_freq_range *range = &r->freq_range[i];
+
+		freq = nla_nest_start(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE);
+		if (!freq)
+			goto nla_put_failure;
+
+		if (nla_put_u32(msg, NL80211_WIPHY_RADIO_FREQ_ATTR_START,
+				range->start_freq) ||
+		    nla_put_u32(msg, NL80211_WIPHY_RADIO_FREQ_ATTR_END,
+				range->end_freq))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, freq);
+	}
+
+	for (i = 0; i < r->n_iface_combinations; i++)
+		if (nl80211_put_ifcomb_data(msg, true,
+					    NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
+					    &r->iface_combinations[i],
+					    NLA_F_NESTED))
+			goto nla_put_failure;
+
+	nla_nest_end(msg, radio);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+
+static int nl80211_put_radios(struct wiphy *wiphy, struct sk_buff *msg)
+{
+	struct nlattr *radios;
+	int i;
+
+	if (!wiphy->n_radio)
+		return 0;
+
+	radios = nla_nest_start(msg, NL80211_ATTR_WIPHY_RADIOS);
+	if (!radios)
+		return -ENOBUFS;
+
+	for (i = 0; i < wiphy->n_radio; i++)
+		if (nl80211_put_radio(wiphy, msg, i))
+			goto fail;
+
+	nla_nest_end(msg, radios);
+
+	if (nl80211_put_iface_combinations(wiphy, msg,
+					   NL80211_ATTR_WIPHY_INTERFACE_COMBINATIONS,
+					   -1, true, NLA_F_NESTED))
+		return -ENOBUFS;
+
+	return 0;
+
+fail:
+	nla_nest_cancel(msg, radios);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2703,7 +2786,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 
 		if (nl80211_put_iface_combinations(&rdev->wiphy, msg,
-						   state->split))
+						   NL80211_ATTR_INTERFACE_COMBINATIONS,
+						   rdev->wiphy.n_radio ? 0 : -1,
+						   state->split, 0))
 			goto nla_put_failure;
 
 		state->split_start++;
@@ -3017,6 +3102,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				rdev->wiphy.hw_timestamp_max_peers))
 			goto nla_put_failure;
 
+		state->split_start++;
+		break;
+	case 17:
+		if (nl80211_put_radios(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
git-series 0.9.1

