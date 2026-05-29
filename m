Return-Path: <linux-wireless+bounces-37100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MlqLBE3GWrzswgAu9opvQ
	(envelope-from <linux-wireless+bounces-37100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:49:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690F5FE2A0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8911B30DAFE1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E873AB262;
	Fri, 29 May 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ip4mwI8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74431AA87
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037110; cv=none; b=p6bG5EUrhLy8mXfEIK4xeXotzClvJm6F1NaJsq+4DQBxoaiXLF5qaLTrCBFb/A8Lv5L0jpnyjpnCBYivIeCm5Ns52KX6ogWaRo8WTnvkpWisx2XVc/tq4rPx2d8nc7KB5o+9rccPyDLLenkz0MzaBOM13Yq1+eqsmJH4ldvSqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037110; c=relaxed/simple;
	bh=Abxjf57gsARxogX6WYncTVaAOporxxv0itMEXJ4uzH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3gaVM3fLuCBjpmOvh0EFHI1oR19EZkn/iP8N3VCHSXOUgAOgJOhp4pmhYA7QYjkx94pzkS7hA+pq5IgJaTVpSeS1kvIBKTXimvpDBy2Wdh0uHfZQDRCspWVe/2XHHKfRXA4sX6Uc6O671w7WRX8alEPaIOcGqJgVZOfxQ8CcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ip4mwI8f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7aiPcUoXWLAvO4OIe6eMmSQ1+FF6qeGxMwhe5eDBaFQ=;
	t=1780037108; x=1781246708; b=Ip4mwI8fzT0ysxnCb6ADHw+E6uewWPEOtmtHoGhESO0lPdK
	9t2CrLE+RKgfHTQBtt6jaJT7yUV0nhkvJyJud2ucI6kiMtz6Qa0TQPuYLNRKffCT7yhohHJhvTG79
	KXcAhY94GYIWrel2mfWQbneW1MjsusQpztwQ124zM88RvuQKOMlGjMUMX27Lk3fVvqRXthXmtOled
	3yhBguXs0rrnG3Udj6WGwx3CQpb4yl1nNYJu3UUEpACmsQTCS9N62NjxOpCNYm269vS897KfnKhZ4
	RtWNN8nG28lfBLAeR45XQL7Nl6C/L8IvMYjizpRpNjHBRl3bNjgWNcWJiXAoJV4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSqxu-00000009XXt-07IS;
	Fri, 29 May 2026 08:45:06 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: remove 5/10 MHz channel support
Date: Fri, 29 May 2026 08:40:27 +0200
Message-ID: <20260529084502.080c5885f0b7.I77cc94485b523c3c006005b9233db13cd4e077b3@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529064502.37422-4-johannes@sipsolutions.net>
References: <20260529064502.37422-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-37100-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 1690F5FE2A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Remove WIPHY_FLAG_SUPPORTS_5_10_MHZ and 5/10 MHz channel
width support. We contemplated this back in early 2023
and didn't do it yet, but nobody stepped up to maintain
it.

It's already _mostly_ dead code since it can really only
be used for AP and maybe IBSS and monitor, but not on a
client since there's no way to scan (and hasn't been in
a very long time, if ever), so the only thing that ever
could really happen with it was run syzbot and trip over
assumptions in the code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath5k/base.c         |  2 --
 drivers/net/wireless/ath/ath9k/init.c         |  1 -
 .../wireless/virtual/mac80211_hwsim_main.c    |  1 -
 include/net/cfg80211.h                        |  2 --
 net/wireless/chan.c                           | 33 ++++---------------
 net/wireless/core.c                           |  4 +--
 net/wireless/nl80211.c                        | 14 ++------
 net/wireless/util.c                           |  3 --
 8 files changed, 11 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 6ca31d4ea437..610a3321b497 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -2600,8 +2600,6 @@ ath5k_init_ah(struct ath5k_hw *ah, const struct ath_bus_ops *bus_ops)
 	/* SW support for IBSS_RSN is provided by mac80211 */
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
-	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_5_10_MHZ;
-
 	/* both antennas can be configured as RX or TX */
 	hw->wiphy->available_antennas_tx = 0x3;
 	hw->wiphy->available_antennas_rx = 0x3;
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index e1a67e8ed09f..2f0c4ef86b7e 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -957,7 +957,6 @@ static void ath9k_set_hw_capab(struct ath_softc *sc, struct ieee80211_hw *hw)
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS;
 	hw->wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_5_10_MHZ;
 	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 6ea082157307..4926122d6648 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5903,7 +5903,6 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			    WIPHY_FLAG_AP_UAPSD |
-			    WIPHY_FLAG_SUPPORTS_5_10_MHZ |
 			    WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	hw->wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR |
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 69dc9a978861..f91a71c7f4db 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5676,7 +5676,6 @@ struct cfg80211_ops {
  *	responds to probe-requests in hardware.
  * @WIPHY_FLAG_OFFCHAN_TX: Device supports direct off-channel TX.
  * @WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL: Device supports remain-on-channel call.
- * @WIPHY_FLAG_SUPPORTS_5_10_MHZ: Device supports 5 MHz and 10 MHz channels.
  * @WIPHY_FLAG_HAS_CHANNEL_SWITCH: Device supports channel switch in
  *	beaconing mode (AP, IBSS, Mesh, ...).
  * @WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK: The device supports bigger kek and kck keys
@@ -5716,7 +5715,6 @@ enum wiphy_flags {
 	WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD	= BIT(19),
 	WIPHY_FLAG_OFFCHAN_TX			= BIT(20),
 	WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL	= BIT(21),
-	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index f0811efb5d0f..7f6af1790736 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -280,12 +280,6 @@ int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
 	case NL80211_CHAN_WIDTH_16:
 		mhz = 16;
 		break;
-	case NL80211_CHAN_WIDTH_5:
-		mhz = 5;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		mhz = 10;
-		break;
 	case NL80211_CHAN_WIDTH_20:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		mhz = 20;
@@ -347,8 +341,6 @@ cfg80211_chandef_valid_control_freq(const struct cfg80211_chan_def *chandef,
 				    u32 control_freq)
 {
 	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_1:
@@ -415,8 +407,6 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		return false;
 
 	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		if (ieee80211_chandef_to_khz(chandef) !=
@@ -803,18 +793,16 @@ _cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 		return NULL;
 
 	/*
-	 * can't be compatible if one of them is 5/10 MHz or S1G
+	 * can't be compatible if one of them is S1G
 	 * but they don't have the same width.
 	 */
-#define NARROW_OR_S1G(width)	((width) == NL80211_CHAN_WIDTH_5 || \
-				 (width) == NL80211_CHAN_WIDTH_10 || \
-				 (width) == NL80211_CHAN_WIDTH_1 || \
-				 (width) == NL80211_CHAN_WIDTH_2 || \
-				 (width) == NL80211_CHAN_WIDTH_4 || \
-				 (width) == NL80211_CHAN_WIDTH_8 || \
-				 (width) == NL80211_CHAN_WIDTH_16)
+#define IS_S1G(width)	((width) == NL80211_CHAN_WIDTH_1 || \
+			 (width) == NL80211_CHAN_WIDTH_2 || \
+			 (width) == NL80211_CHAN_WIDTH_4 || \
+			 (width) == NL80211_CHAN_WIDTH_8 || \
+			 (width) == NL80211_CHAN_WIDTH_16)
 
-	if (NARROW_OR_S1G(c1->width) || NARROW_OR_S1G(c2->width))
+	if (IS_S1G(c1->width) || IS_S1G(c2->width))
 		return NULL;
 
 	/*
@@ -1506,13 +1494,6 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 	control_freq = chandef->chan->center_freq;
 
 	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_5:
-		width = 5;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		prohibited_flags |= IEEE80211_CHAN_NO_10MHZ;
-		width = 10;
-		break;
 	case NL80211_CHAN_WIDTH_20:
 		if (!ht_cap->ht_supported &&
 		    chandef->chan->band != NL80211_BAND_6GHZ)
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 62ab5e4639be..3dcf63b04c41 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -917,9 +917,7 @@ int wiphy_register(struct wiphy *wiphy)
 				  BIT(NL80211_CHAN_WIDTH_80) |
 				  BIT(NL80211_CHAN_WIDTH_80P80) |
 				  BIT(NL80211_CHAN_WIDTH_160) |
-				  BIT(NL80211_CHAN_WIDTH_320) |
-				  BIT(NL80211_CHAN_WIDTH_5) |
-				  BIT(NL80211_CHAN_WIDTH_10))))
+				  BIT(NL80211_CHAN_WIDTH_320))))
 			return -EINVAL;
 	}
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cdb5e9b77143..19244708f5c3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3450,11 +3450,6 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_send_coalesce(msg, rdev))
 			goto nla_put_failure;
 
-		if ((rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_5_10_MHZ) &&
-		    (nla_put_flag(msg, NL80211_ATTR_SUPPORT_5_MHZ) ||
-		     nla_put_flag(msg, NL80211_ATTR_SUPPORT_10_MHZ)))
-			goto nla_put_failure;
-
 		if (rdev->wiphy.max_ap_assoc_sta &&
 		    nla_put_u32(msg, NL80211_ATTR_MAX_AP_ASSOC_STA,
 				rdev->wiphy.max_ap_assoc_sta))
@@ -4085,10 +4080,9 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
-	if ((chandef->width == NL80211_CHAN_WIDTH_5 ||
-	     chandef->width == NL80211_CHAN_WIDTH_10) &&
-	    !(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_5_10_MHZ)) {
-		NL_SET_ERR_MSG(extack, "5/10 MHz not supported");
+	if (chandef->width == NL80211_CHAN_WIDTH_5 ||
+	    chandef->width == NL80211_CHAN_WIDTH_10) {
+		NL_SET_ERR_MSG(extack, "5/10 MHz not supported any more");
 		return -EINVAL;
 	}
 
@@ -13410,8 +13404,6 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	switch (ibss.chandef.width) {
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		break;
 	case NL80211_CHAN_WIDTH_20:
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 8dd7545b9097..24527bf321b2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2304,9 +2304,6 @@ bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 	case NL80211_CHAN_WIDTH_80P80:
 		vht_opclass = 130;
 		break;
-	case NL80211_CHAN_WIDTH_10:
-	case NL80211_CHAN_WIDTH_5:
-		return false; /* unsupported for now */
 	default:
 		vht_opclass = 0;
 		break;
-- 
2.53.0


