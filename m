Return-Path: <linux-wireless+bounces-32404-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBvtM4bxpmk/agAAu9opvQ
	(envelope-from <linux-wireless+bounces-32404-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:34:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D301F18FE
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86D7E3004DE2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A97423A9A;
	Tue,  3 Mar 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xlJC8w59"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692F3DBD68
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548482; cv=none; b=ALJ+QF1vfrd2U00hQVKdMMryabjbM5mD+TERq/s7khg1PMFQMYf25FPQ1+79NsDr6L8ICj0WfSLckgZlweYYeDm1lB86QfQ09kGlB67KoB3tf6F59wPq9jfDcw9dJdx02DuzNao0GEQVKMcYynekawIB0TM8+yiTIRt2LjWDyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548482; c=relaxed/simple;
	bh=DKIj3OQ6K758VM1Gc1lP1rDVh1m89P0HBIMKYiJhZAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIDLCyCs43RwqlEC6LIRlTD+WleoiM0A63TZ6CzquEppG1o2yby60EbucZzXxDjOE1roanie77GFYi9e+BYXIZqQaoA2Y1PlN5XGqZp2RysSHgJU0U3KUdfKfYdaD/EZHyUK0u0yLeWFhvEbhW2FByZC5pjuVKosMgaovzgyZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xlJC8w59; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w/UqyIxc5NK7ppU9mbDkc0T+fRpiWjRxSrDLMjmGeB0=;
	t=1772548480; x=1773758080; b=xlJC8w59lEEkzqQRLzDSDv+Pmdd3OA3+3VUw3YkPZstfbyj
	6FTE2oA4ovpsDQWwMeXWlapYzDdWMN4vgCsJql402kVgjLsXbVQVsMjCEzlSKx+ii+S0jSSLLp7g9
	X8i6Wx0/FUeyScQICpEQZitpPJbcGhIDDLipz4E71cQ5c8KHqRtlO8uOG2Os0yTObDu//PCA3ACFc
	RvaR1uXcyU2RfhSKMYydlZ/kE3UEFZBM95h1ZjhtfzNYG9IgaomvRffMyyQhCKd7lGXbwYov68BbU
	xf5NTQEd9maxd3+b4IHFoTT4R7dzW4L5zLeceBfD/79xu0GGRb+StRUEJ3dzlJug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQpa-00000007A1T-0OdK;
	Tue, 03 Mar 2026 15:34:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 1/8] wifi: cfg80211: allow representing NPCA in chandef
Date: Tue,  3 Mar 2026 15:26:56 +0100
Message-ID: <20260303153435.7599f34f5c69.I85888dab88a6659ba52db4b3318979ca5bcfc0c8@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303143434.273141-10-johannes@sipsolutions.net>
References: <20260303143434.273141-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73D301F18FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32404-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Add the necessary fields to the chandef data structure
to represent NPCA (the NPCA primary channel and NPCA
punctured/disabled subchannels bitmap), and the code
to check these for validity, compatibility, as well as
allowing it to be passed for AP mode for capable
devices.

Compatibility is assumed to only be the case when it's
actually identical, enabling later management of this
in channel contexts in mac80211 for multiple APs, but
requiring userspace to set up the identical chandef on
all AP interfaces that share a channel (and BSS color.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  11 +++-
 include/uapi/linux/nl80211.h |   6 ++
 net/wireless/chan.c          |  59 +++++++++++++++---
 net/wireless/nl80211.c       | 118 ++++++++++++++++++++++++++++++-----
 net/wireless/nl80211.h       |   5 +-
 net/wireless/pmsr.c          |   2 +-
 net/wireless/trace.h         |  16 ++++-
 7 files changed, 188 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8cd870ece351..828d5cc84028 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -844,6 +844,7 @@ struct key_params {
 /**
  * struct cfg80211_chan_def - channel definition
  * @chan: the (control) channel
+ * @npca_chan: the NPCA primary channel
  * @width: channel width
  * @center_freq1: center frequency of first segment
  * @center_freq2: center frequency of second segment
@@ -856,18 +857,22 @@ struct key_params {
  * @punctured: mask of the punctured 20 MHz subchannels, with
  *	bits turned on being disabled (punctured); numbered
  *	from lower to higher frequency (like in the spec)
+ * @npca_punctured: NPCA puncturing bitmap, like @punctured but for
+ *	NPCA transmissions. If NPCA is used (@npca_chan is not %NULL)
+ *	this will be a superset of the @punctured bimap.
  * @s1g_primary_2mhz: Indicates if the control channel pointed to
  *	by 'chan' exists as a 1MHz primary subchannel within an
  *	S1G 2MHz primary channel.
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
+	struct ieee80211_channel *npca_chan;
 	enum nl80211_chan_width width;
 	u32 center_freq1;
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
 	u16 freq1_offset;
-	u16 punctured;
+	u16 punctured, npca_punctured;
 	bool s1g_primary_2mhz;
 };
 
@@ -1014,7 +1019,9 @@ cfg80211_chandef_identical(const struct cfg80211_chan_def *chandef1,
 		chandef1->freq1_offset == chandef2->freq1_offset &&
 		chandef1->center_freq2 == chandef2->center_freq2 &&
 		chandef1->punctured == chandef2->punctured &&
-		chandef1->s1g_primary_2mhz == chandef2->s1g_primary_2mhz);
+		chandef1->s1g_primary_2mhz == chandef2->s1g_primary_2mhz &&
+		chandef1->npca_chan == chandef2->npca_chan &&
+		chandef1->npca_punctured == chandef2->npca_punctured);
 }
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 67d764023988..02377c196082 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3005,6 +3005,9 @@ enum nl80211_commands {
  *	association response etc., since it's abridged in the beacon. Used
  *	for START_AP etc.
  *
+ * @NL80211_ATTR_NPCA_PRIMARY_FREQ: NPCA primary channel (u32)
+ * @NL80211_ATTR_NPCA_PUNCT_BITMAP: NPCA puncturing bitmap (u32)
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3582,6 +3585,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_UHR_OPERATION,
 
+	NL80211_ATTR_NPCA_PRIMARY_FREQ,
+	NL80211_ATTR_NPCA_PUNCT_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e3c18a4392bb..7f6f4cfc3272 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -136,9 +136,10 @@ static const struct cfg80211_per_bw_puncturing_values per_bw_puncturing[] = {
 	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(320)
 };
 
-static bool valid_puncturing_bitmap(const struct cfg80211_chan_def *chandef)
+static bool valid_puncturing_bitmap(const struct cfg80211_chan_def *chandef,
+				    u32 primary_center, u32 punctured)
 {
-	u32 idx, i, start_freq, primary_center = chandef->chan->center_freq;
+	u32 idx, i, start_freq;
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_80:
@@ -154,18 +155,18 @@ static bool valid_puncturing_bitmap(const struct cfg80211_chan_def *chandef)
 		start_freq = chandef->center_freq1 - 160;
 		break;
 	default:
-		return chandef->punctured == 0;
+		return punctured == 0;
 	}
 
-	if (!chandef->punctured)
+	if (!punctured)
 		return true;
 
 	/* check if primary channel is punctured */
-	if (chandef->punctured & (u16)BIT((primary_center - start_freq) / 20))
+	if (punctured & (u16)BIT((primary_center - start_freq) / 20))
 		return false;
 
 	for (i = 0; i < per_bw_puncturing[idx].len; i++) {
-		if (per_bw_puncturing[idx].valid_values[i] == chandef->punctured)
+		if (per_bw_puncturing[idx].valid_values[i] == punctured)
 			return true;
 	}
 
@@ -448,6 +449,40 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	if (!cfg80211_chandef_valid_control_freq(chandef, control_freq))
 		return false;
 
+	if (chandef->npca_chan) {
+		bool pri_upper, npca_upper;
+		u32 cf1;
+
+		switch (chandef->width) {
+		case NL80211_CHAN_WIDTH_80:
+		case NL80211_CHAN_WIDTH_160:
+		case NL80211_CHAN_WIDTH_320:
+			break;
+		default:
+			return false;
+		}
+
+		if (!cfg80211_chandef_valid_control_freq(chandef,
+							 chandef->npca_chan->center_freq))
+			return false;
+
+		cf1 = chandef->center_freq1;
+		pri_upper = chandef->chan->center_freq > cf1;
+		npca_upper = chandef->npca_chan->center_freq > cf1;
+
+		if (pri_upper == npca_upper)
+			return false;
+
+		if (!valid_puncturing_bitmap(chandef,
+					     chandef->npca_chan->center_freq,
+					     chandef->npca_punctured) ||
+		    (chandef->punctured & chandef->npca_punctured) !=
+		    chandef->punctured)
+			return false;
+	} else if (chandef->npca_punctured) {
+		return false;
+	}
+
 	if (!cfg80211_valid_center_freq(chandef->center_freq1, chandef->width))
 		return false;
 
@@ -467,7 +502,8 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	if (!cfg80211_chandef_is_s1g(chandef) && chandef->s1g_primary_2mhz)
 		return false;
 
-	return valid_puncturing_bitmap(chandef);
+	return valid_puncturing_bitmap(chandef, control_freq,
+				       chandef->punctured);
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
 
@@ -554,6 +590,15 @@ _cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 	if (c1->width == c2->width)
 		return NULL;
 
+	/*
+	 * We need NPCA to be compatible for some scenarios such as
+	 * multiple APs, but in this case userspace should configure
+	 * identical chandefs including NPCA, even if perhaps one of
+	 * the AP interfaces doesn't even advertise it.
+	 */
+	if (c1->npca_chan || c2->npca_chan)
+		return NULL;
+
 	/*
 	 * can't be compatible if one of them is 5/10 MHz or S1G
 	 * but they don't have the same width.
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 818696fdc461..7c40cc50973a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -960,6 +960,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
 	[[NL80211_ATTR_UHR_OPERATION] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_operation),
+	[NL80211_ATTR_NPCA_PRIMARY_FREQ] = { .type = NLA_U32 },
+	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =
+		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 };
 
 /* policy for the key attributes */
@@ -3589,7 +3592,8 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 				  struct netlink_ext_ack *extack,
 				  struct nlattr **attrs, bool monitor,
-				  struct cfg80211_chan_def *chandef)
+				  struct cfg80211_chan_def *chandef,
+				  bool permit_npca)
 {
 	u32 control_freq;
 
@@ -3700,6 +3704,34 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		}
 	}
 
+	if (attrs[NL80211_ATTR_NPCA_PRIMARY_FREQ]) {
+		if (!permit_npca) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_ATTR_NPCA_PRIMARY_FREQ],
+					    "NPCA not supported");
+			return -EINVAL;
+		}
+
+		chandef->npca_chan =
+			ieee80211_get_channel(&rdev->wiphy,
+					      nla_get_u32(attrs[NL80211_ATTR_NPCA_PRIMARY_FREQ]));
+		if (!chandef->npca_chan) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    attrs[NL80211_ATTR_NPCA_PRIMARY_FREQ],
+					    "invalid NPCA primary channel");
+			return -EINVAL;
+		}
+
+		chandef->npca_punctured =
+			nla_get_u32_default(attrs[NL80211_ATTR_NPCA_PUNCT_BITMAP],
+					    chandef->punctured);
+	} else if (attrs[NL80211_ATTR_NPCA_PUNCT_BITMAP]) {
+		NL_SET_ERR_MSG_ATTR(extack,
+				    attrs[NL80211_ATTR_NPCA_PUNCT_BITMAP],
+				    "NPCA puncturing only valid with NPCA");
+		return -EINVAL;
+	}
+
 	if (!cfg80211_chandef_valid(chandef)) {
 		NL_SET_ERR_MSG_ATTR(extack, attrs[NL80211_ATTR_WIPHY_FREQ],
 				    "invalid channel definition");
@@ -3727,9 +3759,11 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct netlink_ext_ack *extack,
 			  struct nlattr **attrs,
-			  struct cfg80211_chan_def *chandef)
+			  struct cfg80211_chan_def *chandef,
+			  bool permit_npca)
 {
-	return _nl80211_parse_chandef(rdev, extack, attrs, false, chandef);
+	return _nl80211_parse_chandef(rdev, extack, attrs, false, chandef,
+				      permit_npca);
 }
 
 static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
@@ -3742,6 +3776,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	enum nl80211_iftype iftype = NL80211_IFTYPE_MONITOR;
 	struct wireless_dev *wdev = NULL;
 	int link_id = _link_id;
+	bool permit_npca;
 
 	if (dev)
 		wdev = dev->ieee80211_ptr;
@@ -3756,9 +3791,13 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 		link_id = 0;
 	}
 
+	/* allow parsing it - will check on start_ap or below */
+	permit_npca = iftype == NL80211_IFTYPE_AP ||
+		      iftype == NL80211_IFTYPE_P2P_GO;
+
 	result = _nl80211_parse_chandef(rdev, info->extack, info->attrs,
 					iftype == NL80211_IFTYPE_MONITOR,
-					&chandef);
+					&chandef, permit_npca);
 	if (result)
 		return result;
 
@@ -3777,6 +3816,9 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 				return -EBUSY;
 
 			/* Only allow dynamic channel width changes */
+			cur_chan = wdev->links[link_id].ap.chandef.npca_chan;
+			if (chandef.npca_chan != cur_chan)
+				return -EBUSY;
 			cur_chan = wdev->links[link_id].ap.chandef.chan;
 			if (chandef.chan != cur_chan)
 				return -EBUSY;
@@ -4261,6 +4303,15 @@ int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *ch
 	    nla_put_flag(msg, NL80211_ATTR_S1G_PRIMARY_2MHZ))
 		return -ENOBUFS;
 
+	if (chandef->npca_chan &&
+	    nla_put_u32(msg, NL80211_ATTR_NPCA_PRIMARY_FREQ,
+			chandef->npca_chan->center_freq))
+		return -ENOBUFS;
+	if (chandef->npca_punctured &&
+	    nla_put_u32(msg, NL80211_ATTR_NPCA_PUNCT_BITMAP,
+			chandef->npca_punctured))
+		return -ENOBUFS;
+
 	return 0;
 }
 EXPORT_SYMBOL(nl80211_send_chandef);
@@ -6692,6 +6743,28 @@ nl80211_parse_s1g_short_beacon(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int nl80211_check_npca(struct cfg80211_registered_device *rdev,
+			      const struct cfg80211_chan_def *chandef,
+			      enum nl80211_iftype iftype,
+			      struct netlink_ext_ack *extack)
+{
+	const struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_uhr_cap *uhr_cap;
+
+	if (!chandef->npca_chan)
+		return 0;
+
+	sband = rdev->wiphy.bands[chandef->chan->band];
+	uhr_cap = ieee80211_get_uhr_iftype_cap(sband, iftype);
+
+	if (uhr_cap &&
+	    (uhr_cap->mac.mac_cap[0] & IEEE80211_UHR_MAC_CAP0_NPCA_SUPP))
+		return 0;
+
+	NL_SET_ERR_MSG(extack, "NPCA not supported");
+	return -EINVAL;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -6836,7 +6909,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-					    &params->chandef);
+					    &params->chandef, true);
 		if (err)
 			goto out;
 	} else if (wdev->valid_links) {
@@ -6850,6 +6923,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	err = nl80211_check_npca(rdev, &params->chandef, wdev->iftype,
+				 info->extack);
+	if (err)
+		goto out;
+
 	beacon_check.iftype = wdev->iftype;
 	beacon_check.relax = true;
 	beacon_check.reg_power =
@@ -11331,7 +11409,8 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (dfs_region == NL80211_DFS_UNSET)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err)
 		return err;
 
@@ -11420,7 +11499,8 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err) {
 		GENL_SET_ERR_MSG(info, "Unable to extract chandef info");
 		return err;
@@ -11503,6 +11583,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	bool need_new_beacon = false;
 	bool need_handle_dfs_flag = true;
+	bool permit_npca = false;
 	u32 cs_count;
 
 	if (!rdev->ops->channel_switch ||
@@ -11520,6 +11601,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		 */
 		need_handle_dfs_flag = false;
 
+		permit_npca = true;
+
 		/* useless if AP is not running */
 		if (!wdev->links[link_id].ap.beacon_interval)
 			return -ENOTCONN;
@@ -11606,7 +11689,12 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 
 skip_beacons:
 	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &params.chandef);
+				    &params.chandef, permit_npca);
+	if (err)
+		goto free;
+
+	err = nl80211_check_npca(rdev, &params.chandef, wdev->iftype,
+				 info->extack);
 	if (err)
 		goto free;
 
@@ -12830,7 +12918,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &ibss.chandef);
+				    &ibss.chandef, false);
 	if (err)
 		return err;
 
@@ -13828,7 +13916,8 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	    duration > rdev->wiphy.max_remain_on_channel_duration)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err)
 		return err;
 
@@ -14045,7 +14134,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	chandef.chan = NULL;
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-					    &chandef);
+					    &chandef, false);
 		if (err)
 			return err;
 	}
@@ -14448,7 +14537,7 @@ static int nl80211_join_ocb(struct sk_buff *skb, struct genl_info *info)
 	int err;
 
 	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &setup.chandef);
+				    &setup.chandef, false);
 	if (err)
 		return err;
 
@@ -14524,7 +14613,7 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-					    &setup.chandef);
+					    &setup.chandef, false);
 		if (err)
 			return err;
 	} else {
@@ -17006,7 +17095,8 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
 	    !info->attrs[NL80211_ATTR_OPER_CLASS])
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err)
 		return err;
 
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 048ba92c3e42..bdb065d14054 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions of this file
- * Copyright (C) 2018, 2020-2025 Intel Corporation
+ * Copyright (C) 2018, 2020-2026 Intel Corporation
  */
 #ifndef __NET_WIRELESS_NL80211_H
 #define __NET_WIRELESS_NL80211_H
@@ -25,7 +25,8 @@ static inline u64 wdev_id(struct wireless_dev *wdev)
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct netlink_ext_ack *extack,
 			  struct nlattr **attrs,
-			  struct cfg80211_chan_def *chandef);
+			  struct cfg80211_chan_def *chandef,
+			  bool npca_permitted);
 int nl80211_parse_random_mac(struct nlattr **attrs,
 			     u8 *mac_addr, u8 *mac_addr_mask);
 
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 556f30f5d60a..c2263b0e39d4 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -238,7 +238,7 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 		return err;
 
 	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &out->chandef);
+				    &out->chandef, false);
 	if (err)
 		return err;
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index af23f4fca90a..2aeccb6c59c5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -141,7 +141,9 @@
 		       __field(u32, center_freq1)			\
 		       __field(u32, freq1_offset)			\
 		       __field(u32, center_freq2)			\
-		       __field(u16, punctured)
+		       __field(u16, punctured)				\
+		       __field(u32, npca_pri_freq)			\
+		       __field(u16, npca_punctured)
 #define CHAN_DEF_ASSIGN(chandef)					\
 	do {								\
 		if ((chandef) && (chandef)->chan) {			\
@@ -155,6 +157,11 @@
 			__entry->freq1_offset = (chandef)->freq1_offset;\
 			__entry->center_freq2 = (chandef)->center_freq2;\
 			__entry->punctured = (chandef)->punctured;	\
+			__entry->npca_pri_freq =			\
+				(chandef)->npca_chan ?			\
+				(chandef)->npca_chan->center_freq : 0;	\
+			__entry->npca_punctured =			\
+				(chandef)->npca_punctured;		\
 		} else {						\
 			__entry->band = 0;				\
 			__entry->control_freq = 0;			\
@@ -164,14 +171,17 @@
 			__entry->freq1_offset = 0;			\
 			__entry->center_freq2 = 0;			\
 			__entry->punctured = 0;				\
+			__entry->npca_pri_freq = 0;			\
+			__entry->npca_punctured = 0;			\
 		}							\
 	} while (0)
 #define CHAN_DEF_PR_FMT							\
-	"band: %d, control freq: %u.%03u, width: %d, cf1: %u.%03u, cf2: %u, punct: 0x%x"
+	"band: %d, control freq: %u.%03u, width: %d, cf1: %u.%03u, cf2: %u, punct: 0x%x, npca:%u, npca_punct:0x%x"
 #define CHAN_DEF_PR_ARG __entry->band, __entry->control_freq,		\
 			__entry->freq_offset, __entry->width,		\
 			__entry->center_freq1, __entry->freq1_offset,	\
-			__entry->center_freq2, __entry->punctured
+			__entry->center_freq2, __entry->punctured,	\
+			__entry->npca_pri_freq, __entry->npca_punctured
 
 #define FILS_AAD_ASSIGN(fa)						\
 	do {								\
-- 
2.53.0


