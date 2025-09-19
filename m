Return-Path: <linux-wireless+bounces-27515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2113B88E3B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240C45A2490
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04390306B3E;
	Fri, 19 Sep 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eIFC5Dax"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB4C307AE5
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277411; cv=none; b=aVGz+SA2cwpYEVD0W3cWByVUP2TpB/R9pRZj7wqjELpgpjW09pkqj1cIAgWKyDUIBZN5wgxQpMZdp8JGUMeE+uPxWDwAymAJtEOwyzmdSISQOuB+VErs3gcm5hrKSUY3Mxyt7WPjf96S11z8ek/8gowHF9hexhs2dwqH76Z66fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277411; c=relaxed/simple;
	bh=GRrYLU0ohRN0XLpK6Kvx9ImkKLFMFU5OHh0Q+d08cWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2/s8cv3veyi5XgOIICPtM8HRRqtkV5MgmGuBuBl9m9ohRQbdOmaeC/Y6itqXvCVPZC0KLpEfQAeMBuSnP/IiUam10Ml80lFVHuNYqAD6hR2GNOK20F5G1F4e3vCRiXPv6X08eLI9bOEjMy5yb41T9QwVZTkmsb1KM2vBOIvu9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eIFC5Dax; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QlbhadHcs/yoCv9yNTvGoPylZoluUDBPSsgIpibX214=; t=1758277410; x=1759487010; 
	b=eIFC5DaxV9sRZL01QPWqod1JrqhG98ygUypzPtITXze2J6A6f4ufz6gdq3zLxrVwkSDWXNBAIOL
	VaMxK44SUT1M/Lei6srm04Ss0ze5CeDOq3RbJvla/Xa1vaa5jhQhPzf8FJ0heiTW5tqmfoGhh0j45
	shvb8WAW/A0A1gtW+hk4ZHjgy9EFBhx4/v2eR6lWc8vZJ01CGoH7EUt2+U4v8FZFZeA1Xg9I+3ebR
	ldSpom3wmr90nMcyjYKU5WNYtWyJ+/04QY4RBpqG047Zx3tKNaBWn6eU89OgB4Z9UEp0pEKydLYZA
	eWgap+DodxaE8feWB9mn+5hGhxGc2489xeBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzYH1-0000000Fh6a-1zVO;
	Fri, 19 Sep 2025 12:23:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: remove IEEE80211_CHAN_{1,2,4,8,16}MHZ flags
Date: Fri, 19 Sep 2025 12:23:25 +0200
Message-ID: <20250919122325.f0abcf092b9b.I04478fde87a79c7909f1cc4249430deaf71e8bd0@changeid>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These were used by S1G for older chandef representation, but
are no longer needed. Clean them up, even if we can't drop
them from the userspace API entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 16 +---------------
 net/wireless/nl80211.c | 15 ---------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1c041ce7a03b..781624f5913a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -101,16 +101,6 @@ struct wiphy;
  * @IEEE80211_CHAN_NO_10MHZ: 10 MHz bandwidth is not permitted
  *	on this channel.
  * @IEEE80211_CHAN_NO_HE: HE operation is not permitted on this channel.
- * @IEEE80211_CHAN_1MHZ: 1 MHz bandwidth is permitted
- *	on this channel.
- * @IEEE80211_CHAN_2MHZ: 2 MHz bandwidth is permitted
- *	on this channel.
- * @IEEE80211_CHAN_4MHZ: 4 MHz bandwidth is permitted
- *	on this channel.
- * @IEEE80211_CHAN_8MHZ: 8 MHz bandwidth is permitted
- *	on this channel.
- * @IEEE80211_CHAN_16MHZ: 16 MHz bandwidth is permitted
- *	on this channel.
  * @IEEE80211_CHAN_NO_320MHZ: If the driver supports 320 MHz on the band,
  *	this flag indicates that a 320 MHz channel cannot use this
  *	channel as the control or any of the secondary channels.
@@ -152,11 +142,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_NO_20MHZ			= BIT(11),
 	IEEE80211_CHAN_NO_10MHZ			= BIT(12),
 	IEEE80211_CHAN_NO_HE			= BIT(13),
-	IEEE80211_CHAN_1MHZ			= BIT(14),
-	IEEE80211_CHAN_2MHZ			= BIT(15),
-	IEEE80211_CHAN_4MHZ			= BIT(16),
-	IEEE80211_CHAN_8MHZ			= BIT(17),
-	IEEE80211_CHAN_16MHZ			= BIT(18),
+	/* can use free bits here */
 	IEEE80211_CHAN_NO_320MHZ		= BIT(19),
 	IEEE80211_CHAN_NO_EHT			= BIT(20),
 	IEEE80211_CHAN_DFS_CONCURRENT		= BIT(21),
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de34a1d14073..346dfd2bd987 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1280,21 +1280,6 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_HE) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_HE))
 			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_1MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_1MHZ))
-			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_2MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_2MHZ))
-			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_4MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_4MHZ))
-			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_8MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_8MHZ))
-			goto nla_put_failure;
-		if ((chan->flags & IEEE80211_CHAN_16MHZ) &&
-		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_16MHZ))
-			goto nla_put_failure;
 		if ((chan->flags & IEEE80211_CHAN_NO_320MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_320MHZ))
 			goto nla_put_failure;
-- 
2.51.0


