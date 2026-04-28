Return-Path: <linux-wireless+bounces-35472-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAeCHo+G8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35472-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:06:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E415848233F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4962A34B7455
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E511C39656E;
	Tue, 28 Apr 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jiu/oDc9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DF38BF9A
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368442; cv=none; b=Knq+Mkp25JL5pKCOS2uj7bvcCAZoNa/Qn0re9UdnSBEWAKckZeJkiTfNTQvhMarvujQ2VSS7stovPmnRFU3AiSr7YRb9U9H+5FTmxs2TEaN0G0EBhGOxILDMlIRegsql7lxO4xuSLGuzEnR7Kd7KPoCanq7SymPfzkucO3IDEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368442; c=relaxed/simple;
	bh=p8FB6NAx4fYIIZB02w89a5PpOnOTiCq6849iif7/dIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKH4+La2b2hR6hTPylvl1szL7BbPzTf9iDbuPH291H2js2WTVv8GIZ6qYee2rRuay2YH6etWVzjgBwv2ciEoOehrY+L1g4Hyk9S5Ep4/Zo4zD+FSFCnElJyRrRDm4Q/2T8X/bUxzxrynthRIOESaY+n5mfbkP9geOclv0GyYPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jiu/oDc9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b0EBTe8lXZpjb8ZQdPuGFVTnN1yclcyN7vm7j05ksw4=;
	t=1777368438; x=1778578038; b=Jiu/oDc9ILs2D/3iabGkG9Ik4tEvL9/7YVJ8OKU41jDSRGf
	8cpkJeG8iQgIvJO+aYlg+cRdtgBZRz3z/60RBhVP9Wf1rN4REm8CRA2+lZlb8/vvTDoNp0IhMBXia
	0jwGNfIw0EIq47Sbid3HMm05t1ZquBPkSVK2KM3pOE32NpOYo2mBbbVwFHrajVtwqy1Jn7dwI9ubB
	mYvgzRx86jfEm9uVN1nrCW7hrsaA6Y9EPx2FIS8eeByXZpjNLw3OodUPUU+BTRNc7e2HOA4Os5TIO
	g/sfL/Oo8TXHcT6qSX9h8MgTOtLcS6NTAsTLOXIrt89avxTyIPwZ+QZnGmcDAYxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeip-0000000HLwg-14rM;
	Tue, 28 Apr 2026 11:27:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/14] wifi: cfg80211: allow representing NPCA in chandef
Date: Tue, 28 Apr 2026 11:25:32 +0200
Message-ID: <20260428112708.46f3872aeb35.I85888dab88a6659ba52db4b3318979ca5bcfc0c8@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428092708.71740-16-johannes@sipsolutions.net>
References: <20260428092708.71740-16-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E415848233F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35472-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 net/wireless/chan.c          |  59 +++++++++++++++--
 net/wireless/nl80211.c       | 120 ++++++++++++++++++++++++++++++-----
 net/wireless/nl80211.h       |   5 +-
 net/wireless/pmsr.c          |   2 +-
 net/wireless/trace.h         |  16 ++++-
 7 files changed, 189 insertions(+), 30 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a40ab36b8edb..9e66490dab4f 100644
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
index 072b383d7d3c..2b6957b61b62 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3142,6 +3142,9 @@ enum nl80211_commands {
  *	association response etc., since it's abridged in the beacon. Used
  *	for START_AP etc.
  *
+ * @NL80211_ATTR_NPCA_PRIMARY_FREQ: NPCA primary channel (u32)
+ * @NL80211_ATTR_NPCA_PUNCT_BITMAP: NPCA puncturing bitmap (u32)
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3735,6 +3738,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME,
 	NL80211_ATTR_NAN_PEER_MAPS,
 
+	NL80211_ATTR_NPCA_PRIMARY_FREQ,
+	NL80211_ATTR_NPCA_PUNCT_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 8b94c0de80ad..fae71f2d13ed 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -138,9 +138,10 @@ static const struct cfg80211_per_bw_puncturing_values per_bw_puncturing[] = {
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
@@ -156,18 +157,18 @@ static bool valid_puncturing_bitmap(const struct cfg80211_chan_def *chandef)
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
 
@@ -458,6 +459,40 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
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
 
@@ -477,7 +512,8 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	if (!cfg80211_chandef_is_s1g(chandef) && chandef->s1g_primary_2mhz)
 		return false;
 
-	return valid_puncturing_bitmap(chandef);
+	return valid_puncturing_bitmap(chandef, control_freq,
+				       chandef->punctured);
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
 
@@ -564,6 +600,15 @@ _cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
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
index cf236307cca9..7cb5f39f783d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1076,6 +1076,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_NAN_MAX_CHAN_SWITCH_TIME] = { .type = NLA_U16 },
 	[NL80211_ATTR_NAN_PEER_MAPS] =
 		NLA_POLICY_NESTED_ARRAY(nl80211_nan_peer_map_policy),
+	[NL80211_ATTR_NPCA_PRIMARY_FREQ] = { .type = NLA_U32 },
+	[NL80211_ATTR_NPCA_PUNCT_BITMAP] =
+		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 };
 
 /* policy for the key attributes */
@@ -3772,7 +3775,8 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 				  struct netlink_ext_ack *extack,
 				  struct nlattr **attrs, bool monitor,
-				  struct cfg80211_chan_def *chandef)
+				  struct cfg80211_chan_def *chandef,
+				  bool permit_npca)
 {
 	u32 control_freq;
 
@@ -3886,6 +3890,34 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
@@ -3913,9 +3945,11 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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
@@ -3928,6 +3962,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	enum nl80211_iftype iftype = NL80211_IFTYPE_MONITOR;
 	struct wireless_dev *wdev = NULL;
 	int link_id = _link_id;
+	bool permit_npca;
 
 	if (dev)
 		wdev = dev->ieee80211_ptr;
@@ -3942,9 +3977,13 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
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
 
@@ -3963,6 +4002,9 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 				return -EBUSY;
 
 			/* Only allow dynamic channel width changes */
+			cur_chan = wdev->links[link_id].ap.chandef.npca_chan;
+			if (chandef.npca_chan != cur_chan)
+				return -EBUSY;
 			cur_chan = wdev->links[link_id].ap.chandef.chan;
 			if (chandef.chan != cur_chan)
 				return -EBUSY;
@@ -4447,6 +4489,15 @@ int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *ch
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
@@ -6949,6 +7000,28 @@ nl80211_parse_s1g_short_beacon(struct cfg80211_registered_device *rdev,
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
@@ -7088,7 +7161,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-					    &params->chandef);
+					    &params->chandef, true);
 		if (err)
 			goto out;
 	} else if (wdev->valid_links) {
@@ -7107,6 +7180,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
+	err = nl80211_check_npca(rdev, &params->chandef, wdev->iftype,
+				 info->extack);
+	if (err)
+		goto out;
+
 	beacon_check.iftype = wdev->iftype;
 	beacon_check.relax = true;
 	beacon_check.reg_power =
@@ -11657,7 +11735,8 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (dfs_region == NL80211_DFS_UNSET)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err)
 		return err;
 
@@ -11746,7 +11825,8 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err) {
 		GENL_SET_ERR_MSG(info, "Unable to extract chandef info");
 		return err;
@@ -11829,6 +11909,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	bool need_new_beacon = false;
 	bool need_handle_dfs_flag = true;
+	bool permit_npca = false;
 	u32 cs_count;
 
 	if (!rdev->ops->channel_switch ||
@@ -11846,6 +11927,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		 */
 		need_handle_dfs_flag = false;
 
+		permit_npca = true;
+
 		/* useless if AP is not running */
 		if (!wdev->links[link_id].ap.beacon_interval)
 			return -ENOTCONN;
@@ -11883,7 +11966,12 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	params.count = cs_count;
 
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
 
@@ -13157,7 +13245,7 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &ibss.chandef);
+				    &ibss.chandef, false);
 	if (err)
 		return err;
 
@@ -14157,7 +14245,8 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	    duration > rdev->wiphy.max_remain_on_channel_duration)
 		return -EINVAL;
 
-	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef);
+	err = nl80211_parse_chandef(rdev, info->extack, info->attrs, &chandef,
+				    false);
 	if (err)
 		return err;
 
@@ -14376,7 +14465,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	chandef.chan = NULL;
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-					    &chandef);
+					    &chandef, false);
 		if (err)
 			return err;
 	}
@@ -14779,7 +14868,7 @@ static int nl80211_join_ocb(struct sk_buff *skb, struct genl_info *info)
 	int err;
 
 	err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-				    &setup.chandef);
+				    &setup.chandef, false);
 	if (err)
 		return err;
 
@@ -14855,7 +14944,7 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info->extack, info->attrs,
-					    &setup.chandef);
+					    &setup.chandef, false);
 		if (err)
 			return err;
 	} else {
@@ -16819,7 +16908,7 @@ static int nl80211_parse_nan_channel(struct cfg80211_registered_device *rdev,
 		return ret;
 
 	ret = nl80211_parse_chandef(rdev, info->extack, channel_parsed,
-				    &chandef);
+				    &chandef, false);
 	if (ret)
 		return ret;
 
@@ -17818,7 +17907,8 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
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
index 4c8ea0583f94..93fee1f1aa76 100644
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
index eb5bedf9c92a..d03e58c63fd4 100644
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


