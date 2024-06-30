Return-Path: <linux-wireless+bounces-9713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64591D06C
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841E1281D64
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D12C6BD;
	Sun, 30 Jun 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="HM613tvY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2E3C0D
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733868; cv=none; b=opmkhcZQAu/eliSfejBqq228KdVyKwGsjadIeFl34G/iwYBvYd2St4iN/iTFkyBD/ICIDrmyHnK/h4U1cUkLidBWRzQrHMPOzDeRRwDkKNReE138P2eno7QVoMOofdeWAjsr/wt0xQQMrp8aSb6s9xSa7IeFzj12PvyrRd+1ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733868; c=relaxed/simple;
	bh=QZFoIaW3fOntzuj292xNFthjx3rY5PHo5jVM/y07gJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWS0aA7YbEapoWnHMkqHyuXPycueSxwjo/kjth3/CRSmDWNu3KlbbmDbSa9qCUNKt8sc6wj324xt+AeqDyn9QRnys4ktAF673Z13mxEIRcFjnj69+exWCv1kw/Gt94gMm+TVHcKo4pq59kw9sVRzlIHGic2dIOgGJmjLV5hMV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=HM613tvY; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e0U4PPfoDcUjFWeCiCaWzwKPEfyud+0mZ1WIwTGjPKw=; b=HM613tvYPRJmj/k7wamJT2zIv8
	n1UfcOZGd7pjz5qrKqblZZQzjLIf5vnRgI/N2coefT60HMDEk1Kr+E3gtPSb4B5/uMA8qXmIqcoAh
	sTxU5IOXkuwHX8gHzyHZN53J6SvxHir122Ujy6xWfZ+BaNLNqvdufa4BQ5UV1gJiVQfU=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sNpKo-000sh7-31;
	Sun, 30 Jun 2024 09:50:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v2 02/10] wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
Date: Sun, 30 Jun 2024 09:50:45 +0200
Message-ID: <52f91e3121547ec50a9ea1fa1b7f395a96da52df.1719733819.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
References: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
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
 include/net/cfg80211.h       |  38 ++++++++++++-
 include/uapi/linux/nl80211.h |  63 ++++++++++++++++++++-
 net/wireless/nl80211.c       | 112 ++++++++++++++++++++++++++++++++----
 3 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6f992aff74ae..dd5595089106 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5406,6 +5406,38 @@ struct wiphy_iftype_akm_suites {
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
@@ -5624,6 +5656,9 @@ struct wiphy_iftype_akm_suites {
  *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
  *	supports enabling HW timestamping for all peers (i.e. no need to
  *	specify a mac address).
+ *
+ * @radio: radios belonging to this wiphy
+ * @n_radio: number of radios
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5774,6 +5809,9 @@ struct wiphy {
 
 	u16 hw_timestamp_max_peers;
 
+	int n_radio;
+	const struct wiphy_radio *radio __counted_by(n_radio);
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 6ae3997061b6..c9dbfe8f5f69 100644
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
@@ -8005,4 +8020,52 @@ enum nl80211_ap_settings_flags {
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
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_START: Frequency range start
+ * @NL80211_WIPHY_RADIO_FREQ_ATTR_END: Frequency range end
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
index deacd5f3f256..194690ec164a 100644
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
@@ -2408,6 +2417,79 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
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
+		int ret;
+
+		freq = nla_nest_start(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE);
+		ret = nla_put_u32(msg, NL80211_WIPHY_RADIO_FREQ_ATTR_START,
+				  range->start_freq) ||
+		      nla_put_u32(msg, NL80211_WIPHY_RADIO_FREQ_ATTR_END,
+				  range->end_freq);
+		nla_nest_end(msg, freq);
+
+		if (ret)
+			goto nla_put_failure;
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
@@ -2703,7 +2785,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 
 		if (nl80211_put_iface_combinations(&rdev->wiphy, msg,
-						   state->split))
+						   NL80211_ATTR_INTERFACE_COMBINATIONS,
+						   rdev->wiphy.n_radio ? 0 : -1,
+						   state->split, 0))
 			goto nla_put_failure;
 
 		state->split_start++;
@@ -3017,6 +3101,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
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

