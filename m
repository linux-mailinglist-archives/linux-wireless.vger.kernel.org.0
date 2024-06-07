Return-Path: <linux-wireless+bounces-8710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630EF9009FA
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A94B1C232FF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F64E19D082;
	Fri,  7 Jun 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Wqe3c2g1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8819A281
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776358; cv=none; b=bpvn6UW1OAFyIMrH5wIbpDVncGc3yh2rLWcwOP+2ifpMsbQQJ1rQRQwGQV1FHoPjBJAR1bmCM665OyAMWIKBKCU3kkFOfp73cVTnSJ/8Yge2J2Zlelbl+E8jdor2qXylCRhthAUpOBG8i1AGaZbNkvUN2+2uPbxnCR1MgOtI58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776358; c=relaxed/simple;
	bh=RHU8qnJC80jNUM9B+RITE/GYg+4v/pLE3Ii6FICAN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWJS13WfH+Ji69kj9xao1gbPkmB+SodQUhtyI/3A8tUNAmHbVhLaRsDSb4Xuv+mMf8MTOHCD4tg1lj2gPf7G2aUxLpgjoc5iSOFulaKxLW6rEmxAlNMyeBapgp8OWu0y5nF84biU39oI+i/W49KSMK8MVouEiscrjzqDafAuPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Wqe3c2g1; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CkbbcFqS/zBNT4pXAWuysmEjXLb2gQzOWrkt1GgO1Zo=; b=Wqe3c2g1TgFK/EnLN4Tjyv6mOl
	HMCkH7E1fsoJENicCgzVgOAv2WUEMhV76nX4BI801vuDbGbpKE5QTAp+mYA1QA+3iQDi5x/iwKnoU
	PWaqduKLQU6s7eVska2j4TIAiMS4d4ANuJwxVYSEDlDF7J/oyj8TnlJmvniPfrsALBPM=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFc6A-008xPc-0V;
	Fri, 07 Jun 2024 18:05:50 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v4 2/9] wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
Date: Fri,  7 Jun 2024 18:05:41 +0200
Message-ID: <0db3c76249ee1001c8ae4333cd51ec4030c27b55.1717776325.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
References: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
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
 include/net/cfg80211.h       | 38 ++++++++++++++++++-
 include/uapi/linux/nl80211.h | 51 ++++++++++++++++++++++++-
 net/wireless/nl80211.c       | 79 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 168 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5da9bb0ac6a4..8a9ef59413d8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5403,6 +5403,38 @@ struct wiphy_iftype_akm_suites {
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
@@ -5621,6 +5653,9 @@ struct wiphy_iftype_akm_suites {
  *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
  *	supports enabling HW timestamping for all peers (i.e. no need to
  *	specify a mac address).
+ *
+ * @radio: radios belonging to this wiphy
+ * @n_radio: number of radios
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5771,6 +5806,9 @@ struct wiphy {
 
 	u16 hw_timestamp_max_peers;
 
+	const struct wiphy_radio *radio;
+	int n_radio;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f917bc6c9b6f..3d54eb2e21e7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2856,6 +2856,9 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_WIPHY_RADIOS: Nested attribute describing physical radios
+ *	belonging to this wiphy. See &enum nl80211_wiphy_radio_attrs.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3401,6 +3404,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_WIPHY_RADIOS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7999,4 +8004,50 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
+ *
+ * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency ranges
+ *	supported by this radio.
+ * @NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATIONS: Nested attribute listing
+ *	the supported interface combinations for this radio. In each nested item,
+ *	it contains attributes defined in &enum nl80211_if_combination_attrs.
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
+ * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
+ */
+enum nl80211_wiphy_radio_attrs {
+	__NL80211_WIPHY_RADIO_ATTR_INVALID,
+
+	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES,
+	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATIONS,
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
index 7b0ba0fff082..999b907380fe 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2399,6 +2399,79 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
+{
+	const struct wiphy_radio *r = &wiphy->radio[idx];
+	struct nlattr *radio, *freqs, *freq, *nl_combis;
+	int i;
+
+	radio = nla_nest_start(msg, idx);
+	if (!radio)
+		return -ENOBUFS;
+
+	freqs = nla_nest_start_noflag(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES);
+	if (!freqs)
+		goto nla_put_failure;
+
+	for (i = 0; i < r->n_freq_range; i++) {
+		const struct wiphy_radio_freq_range *range = &r->freq_range[i];
+		int ret;
+
+		freq = nla_nest_start(msg, i);
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
+	nla_nest_end(msg, freqs);
+
+	nl_combis = nla_nest_start_noflag(msg,
+					  NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATIONS);
+	if (!nl_combis)
+		goto nla_put_failure;
+
+	for (i = 0; i < r->n_iface_combinations; i++)
+		if (nl80211_put_ifcomb_data(msg, true, i + 1,
+					    &r->iface_combinations[i]))
+			goto nla_put_failure;
+
+	nla_nest_end(msg, nl_combis);
+	nla_nest_end(msg, radio);
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
@@ -3008,6 +3081,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
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

