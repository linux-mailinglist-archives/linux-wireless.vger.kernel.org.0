Return-Path: <linux-wireless+bounces-35477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPXzJWqH8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:09:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19529482446
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C77D532524AC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CB39B972;
	Tue, 28 Apr 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GtLIZLvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA6397682
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368445; cv=none; b=NQJeE1caZQ0rqAPgeZZWxsifbPK+1W/x9GoxQfU87ibft8firOBzXAUPduijBZEF02DD0H0aJNOe92ZuGYbiGjORPrOgmsj9y6HCxkDKCy5hYAlsOVuAhbKayq+BFo2vkjYOc5CpU10P498mXMxtiTo/b+nMj9Xukjw91Ezdvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368445; c=relaxed/simple;
	bh=Jxi6qXyvHNi8uwnI1F1JxAA33P9PUDQXb/BkE2qFlDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPOn9fmEa5bTC5IPNfPlzfKcTLElC4tWZiRvX+XW/Jmz/scvMd9LB+DDLdeHlNaw0fDT7GffZ/wxdMkTb26OLVXqp5zR0FB6TgU3pRgus/gwL/nmVbiPY9Qn6Nm3b0/55h6xlVJQS2KK/9f/+3xWC5g8Gqp3cRM75Wu/guldqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GtLIZLvz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lIuGGIQdz0emPQk8WgkP2JxzWx7C8f6DXDuM8itq48E=;
	t=1777368443; x=1778578043; b=GtLIZLvzDrOEY84miXyoSS0KtQ2G5u/uxYnVI9MWDGE/N7a
	kZH/Jhc1DXojK4XpzkvOCyX6nkSEW8pj7h5I2BszasTahIe9XeAqcECg90Yd10LY1UDMsQs1eNY+1
	LXdqNmiCLQ/4mQtNlWCCAMGjcmsA4DxuC664lb/bWjiRQo9xRPKHe2VRRVD/fEvVPWRQFAKHAl1wU
	nxHYheXNQoBPv85B/oCkVuIe+2c/JMqnDGDmDTYLq7Vp8VB3tTxi5OTvG1JTRaJ4cjR1qTVRU55aX
	BHVrH3dvqsYMfldGWK6NDAL9LfgnGQIoiuzCNNQKKdFxZOXOW6WCQ/358jaPp9og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeiv-0000000HLwg-3DnT;
	Tue, 28 Apr 2026 11:27:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 12/14] wifi: cfg80211: separate NPCA validity from chandef validity
Date: Tue, 28 Apr 2026 11:25:40 +0200
Message-ID: <20260428112708.1225df131557.If3a6afadcce05d215b72fd82175f72373a0f6d24@changeid>
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
X-Rspamd-Queue-Id: 19529482446
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
	TAGGED_FROM(0.00)[bounces-35477-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

When considering both NPCA and DBE, it can appear that the
NPCA configuration is invalid, e.g. for an 80 MHz BSS channel
with DBE to 160 MHz:

     | primary channel
     |       NPCA primary channel
     |       |
     V       V
   | p |   | n |   |   |   |   |   |
   | BSS channel   |
   | DBE channel                   |

Now the NPCA primary channel is in the same half as the primary
channel, and the NPCA puncturing bitmap could be completely
invalid as a puncturing bitmap when considering the overall
channel.

Split out the validity checks from cfg80211_chandef_valid() to
a new cfg80211_chandef_npca_valid() function that just checks
the NPCA configuration against the BSS chandef.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 23 ++++++++++++++++
 net/mac80211/mlme.c    |  5 +++-
 net/wireless/chan.c    | 59 +++++++++++++++++++++++++++---------------
 3 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2546567792e2..5176dcb300fa 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -845,6 +845,10 @@ struct key_params {
  * struct cfg80211_chan_def - channel definition
  * @chan: the (control) channel
  * @npca_chan: the NPCA primary channel
+ *	Note that if DBE is in use, this channel may appear to be
+ *	inside the primary half of the chandef. Implementations
+ *	can use the position of this channel to understand how
+ *	NPCA is used.
  * @width: channel width
  * @center_freq1: center frequency of first segment
  * @center_freq2: center frequency of second segment
@@ -860,6 +864,8 @@ struct key_params {
  * @npca_punctured: NPCA puncturing bitmap, like @punctured but for
  *	NPCA transmissions. If NPCA is used (@npca_chan is not %NULL)
  *	this will be a superset of the @punctured bimap.
+ *	Note that if DBE is used, this bitmap is also shifted to be in
+ *	accordance with the overall chandef bandwidth.
  * @s1g_primary_2mhz: Indicates if the control channel pointed to
  *	by 'chan' exists as a 1MHz primary subchannel within an
  *	S1G 2MHz primary channel.
@@ -1150,6 +1156,23 @@ int cfg80211_chandef_primary(const struct cfg80211_chan_def *chandef,
 			     enum nl80211_chan_width primary_chan_width,
 			     u16 *punctured);
 
+/**
+ * cfg80211_chandef_npca_valid - check that NPCA information is valid
+ * @wiphy: the wiphy to check for, for channel pointer lookup
+ * @chandef: the BSS channel chandef to check against
+ * @npca: NPCA information, can be %NULL in which case this
+ *	always returns %true
+ *
+ * Note that DBE must not have been configured into the chandef yet
+ * before checking NPCA, i.e. @chandef must represent the BSS channel.
+ *
+ * Returns: %true if the NPCA channel and puncturing bitmap are valid
+ *	according to the chandef, %false otherwise
+ */
+bool cfg80211_chandef_npca_valid(struct wiphy *wiphy,
+				 const struct cfg80211_chan_def *chandef,
+				 const struct ieee80211_uhr_npca_info *npca);
+
 /**
  * cfg80211_chandef_add_npca - parse and add NPCA information to chandef
  * @wiphy: the wiphy this will be used for, for channel pointer lookup
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0ed3e23c6e60..ccca5219b9e8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -406,7 +406,10 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 
 		npca = ieee80211_uhr_npca_info(uhr_oper);
 
-		if (cfg80211_chandef_add_npca(sdata->local->hw.wiphy,
+		/* DBE is not considered yet, so this works */
+		if (!cfg80211_chandef_npca_valid(sdata->local->hw.wiphy,
+						 &npca_chandef, npca) ||
+		    cfg80211_chandef_add_npca(sdata->local->hw.wiphy,
 					      &npca_chandef, npca)) {
 			sdata_info(sdata,
 				   "AP UHR NPCA settings invalid, disabling UHR\n");
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 70fec444955e..501223d8bb14 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -460,9 +460,6 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		return false;
 
 	if (chandef->npca_chan) {
-		bool pri_upper, npca_upper;
-		u32 cf1;
-
 		switch (chandef->width) {
 		case NL80211_CHAN_WIDTH_80:
 		case NL80211_CHAN_WIDTH_160:
@@ -471,24 +468,6 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		default:
 			return false;
 		}
-
-		if (!cfg80211_chandef_valid_control_freq(chandef,
-							 chandef->npca_chan->center_freq))
-			return false;
-
-		cf1 = chandef->center_freq1;
-		pri_upper = chandef->chan->center_freq > cf1;
-		npca_upper = chandef->npca_chan->center_freq > cf1;
-
-		if (pri_upper == npca_upper)
-			return false;
-
-		if (!valid_puncturing_bitmap(chandef,
-					     chandef->npca_chan->center_freq,
-					     chandef->npca_punctured) ||
-		    (chandef->punctured & chandef->npca_punctured) !=
-		    chandef->punctured)
-			return false;
 	} else if (chandef->npca_punctured) {
 		return false;
 	}
@@ -556,6 +535,44 @@ int cfg80211_chandef_primary(const struct cfg80211_chan_def *c,
 }
 EXPORT_SYMBOL(cfg80211_chandef_primary);
 
+bool cfg80211_chandef_npca_valid(struct wiphy *wiphy,
+				 const struct cfg80211_chan_def *chandef,
+				 const struct ieee80211_uhr_npca_info *npca)
+{
+	struct cfg80211_chan_def tmp = *chandef;
+	bool pri_upper, npca_upper;
+	u32 cf1;
+
+	if (chandef->npca_chan || chandef->npca_punctured)
+		return false;
+
+	if (!npca)
+		return true;
+
+	if (cfg80211_chandef_add_npca(wiphy, &tmp, npca))
+		return false;
+
+	if (!cfg80211_chandef_valid_control_freq(&tmp,
+						 tmp.npca_chan->center_freq))
+		return false;
+
+	cf1 = tmp.center_freq1;
+	pri_upper = tmp.chan->center_freq > cf1;
+	npca_upper = tmp.npca_chan->center_freq > cf1;
+
+	if (pri_upper == npca_upper)
+		return false;
+
+	if (!valid_puncturing_bitmap(&tmp,
+				     tmp.npca_chan->center_freq,
+				     tmp.npca_punctured) ||
+	    (tmp.punctured & tmp.npca_punctured) != tmp.punctured)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(cfg80211_chandef_npca_valid);
+
 int cfg80211_chandef_add_npca(struct wiphy *wiphy,
 			      struct cfg80211_chan_def *chandef,
 			      const struct ieee80211_uhr_npca_info *npca)
-- 
2.53.0


