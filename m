Return-Path: <linux-wireless+bounces-7956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E48CC19B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8132834B1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A981848;
	Wed, 22 May 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="dAohR2vH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7217C9
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382383; cv=none; b=nWuW/KCPJ/MqWp1GdRtRQFnvOemtYxEKUab/HLUY+PKk8g9F0frCa6Lyvr/70OxjaY3I4IDKUjUPEbqK3LW9wJC137AEQ7rpzFS2B4Ho/Zm4C/9MFM782RQRZbqPqMgR+6iUGRQF/3i3lW3HB9RxH+GqKpr43mzBhxNcqAScrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382383; c=relaxed/simple;
	bh=9bC+ZVUIyw6S6r7PAgy1ZOsY9hUSoc1FEyn+uqBMqTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2sXEGZv5pWc60M8V5HgHpwnXu0bdHhDFZQCw08mnwSIW2KdL7fFiMYn/FrHUbOYTmze7IU1rFo95RgnEwENZjdVwFfcuUt9jqphsZWQUCgvTFpTEPntEL9n1zcCC6J1NEo3teQ6pj1ckM8ECdhus+JiiM80gsgpgnHwb5hdiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=dAohR2vH; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=T8lk7VCRaHLtxn3EEiv3MT1T9FFpisd6QK9uAFiInZw=; b=dAohR2vHhdQnCjq2Rdpfrj8+9q
	iTjQTUk6mqbgP9lMHJ3J3KP+R2xPR7tlRbs+wQ2bXToU6DnAUQQBMdo/2JROR+5uDaW2BkKpD0gsC
	TkxiVxkboXbANAzSourryMPvDLuULZ5yEW8mb0HP80+D+z4HOmNgk5u8+unPoAevByJU=;
Received: from p4ff13644.dip0.t-ipconnect.de ([79.241.54.68] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s9l6c-003Yia-0b;
	Wed, 22 May 2024 14:30:06 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 1/2] cfg80211: add support for advertising multiple radios belonging to a wiphy
Date: Wed, 22 May 2024 14:30:04 +0200
Message-ID: <20240522123005.41026-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
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
With this change, the bands and supported frequencies of each individual
radio are reported to user space. This allows user space to figure out the
limitations of what combination of channels can be used concurrently.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 34 ++++++++++++++++
 include/uapi/linux/nl80211.h | 48 +++++++++++++++++++++++
 net/wireless/nl80211.c       | 75 ++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f2ca495ac9f8..58d8375ffa11 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5407,6 +5407,34 @@ struct wiphy_iftype_akm_suites {
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
+ * struct wiphy_radio - This structure describes a physical radio belonging
+ * to a wiphy. It is used to describe concurrent-channel capabilities of the
+ * phy. Only one channel can be active on the radio described by struct
+ * wiphy_radio.
+ *
+ * @band_mask: Mask of enum nl80211_band describing the bands that the radio
+ *	can operate on.
+ * @num_freq_range: number of elements in @freq_range
+ * @freq_range: frequency range that the radio can operate on (optional)
+ */
+struct wiphy_radio {
+	u16 band_mask;
+	u16 n_freq_range;
+	const struct wiphy_radio_freq_range *freq_range;
+};
+
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
 
 /**
@@ -5625,6 +5653,9 @@ struct wiphy_iftype_akm_suites {
  *	A value of %CFG80211_HW_TIMESTAMP_ALL_PEERS indicates the driver
  *	supports enabling HW timestamping for all peers (i.e. no need to
  *	specify a mac address).
+ *
+ * @radio: radios belonging to this wiphy
+ * @n_radio: number of radios
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5775,6 +5806,9 @@ struct wiphy {
 
 	u16 hw_timestamp_max_peers;
 
+	const struct wiphy_radio *radio;
+	int n_radio;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f917bc6c9b6f..dfb01d673094 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3401,6 +3401,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_RADIOS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7999,4 +8001,50 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_wiphy_radio_attrs - wiphy radio attributes
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_INVALID: Invalid
+ *
+ * @NL80211_WIPHY_RADIO_ATTR_BAND_MASK: Bitmask of bands supported by this
+ *	radio.
+ *
+ * @NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES: Nested array of frequency ranges
+ *	supported by this radio.
+ *
+ * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
+ * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
+ */
+enum nl80211_wiphy_radio_attrs {
+	__NL80211_WIPHY_RADIO_ATTR_INVALID,
+
+	NL80211_WIPHY_RADIO_ATTR_BAND_MASK,
+	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES,
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
index 3c0bca4238d3..c07abdf104ec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2392,6 +2392,78 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
+{
+	const struct wiphy_radio *r = &wiphy->radio[idx];
+	struct nlattr *radio, *freqs, *freq;
+	int i;
+
+	radio = nla_nest_start(msg, idx);
+	if (!radio)
+		return -ENOBUFS;
+
+	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_BAND_MASK, r->band_mask))
+		goto fail;
+
+	if (!r->n_freq_range)
+		goto out;
+
+	freqs = nla_nest_start(msg, NL80211_WIPHY_RADIO_ATTR_FREQ_RANGES);
+	if (!freqs)
+		goto fail;
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
+			goto fail_freq;
+	}
+
+	nla_nest_end(msg, freqs);
+
+out:
+	nla_nest_end(msg, radio);
+	return 0;
+
+fail_freq:
+	nla_nest_cancel(msg, freqs);
+fail:
+	nla_nest_cancel(msg, radio);
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
+	radios = nla_nest_start(msg, NL80211_ATTR_RADIOS);
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
@@ -3001,6 +3073,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				rdev->wiphy.hw_timestamp_max_peers))
 			goto nla_put_failure;
 
+		if (nl80211_put_radios(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.44.0


