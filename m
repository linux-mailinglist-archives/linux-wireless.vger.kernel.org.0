Return-Path: <linux-wireless+bounces-2700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0F8412DF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CDF1F23E45
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733E1EB42;
	Mon, 29 Jan 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xuDqSJIo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53D14290
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554665; cv=none; b=Rp3bDlqK/6fWo8IeWTdtYoShQSMzvv2mezTaV6D0JEcVH1kmvVxtCD47el9UJ1zymnnBt1G8SFmYsKaTWuaEzVo3YPSpLY1iYEqoWzjLepQHa1D0fr0E+qCk90GFotw1I/dhx2zZGyvQugbTUvEZOOI9pIcvsWSrfPbnse7M3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554665; c=relaxed/simple;
	bh=DuVn6icmyaNGAY/SpH1aC4Q8u60vITDSBOAosNz2SDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6esCq1LPvW5nAjMHglfw5FUBEEoRNdkjOWjxgehoA1zIiEzxqLUeMOeX/5mRjsZ9BCiI4aKVVQbJg+GshTomfOfoR+6O24+fxZANV8TcYDVnmXkuATs+2VCRs4Vy//kh105B1aZc8ZeYZo8CApNVKz8gAV06OFuW0G9nBzJbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xuDqSJIo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MDSRaMInCBwKiJoTFJH8IeP1W5JLlt1JUEsA2J8nx5s=; t=1706554664; x=1707764264; 
	b=xuDqSJIoIaeNEJ4P3nkT90Tzx5mibp2rFKptLWQERjnuycZ0DxJtgIiTto/mzP9xdKupXiQnxHW
	p2DcSpmWxd6g8gUGskAYNw+VIFVhHGNrbLISdbluhED9pbqj80MsrkVh+Z4GJYq2hZtQ43hETs9Sc
	5ASjc8iraD+3AqCgLhVGv6UEPpIzzoUCB4jKQZKQb4yphgzKw9dmgOpbKjxefxD5es6CysQfUTuVl
	3LhOsGaFTHmBBrAoOIP6SUmnPQRmRuuPNkbZSCSB3bAYcuN5dLSyyATFFjupp87lzlcFlKFWvB1Ye
	KPc2MfZV6pSue1u38b63y+pQnhe32G6CrHtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWpB-00000004zr5-0ufK;
	Mon, 29 Jan 2024 19:57:41 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: clean up FILS discovery change flags handling
Date: Mon, 29 Jan 2024 19:57:39 +0100
Message-ID: <20240129195739.e340a7d5e7c6.I1dfcca32d43dce903494a2c474844491682671b4@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It doesn't make sense to return BSS change flags in an int, as
they're a bigger type. For this particular function it still
works OK, but clean it up to avoid future errors (or copying
this code in a broken way.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e006d59087e7..8f647e28e354 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -952,7 +952,8 @@ ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
 static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 					struct cfg80211_fils_discovery *params,
 					struct ieee80211_link_data *link,
-					struct ieee80211_bss_conf *link_conf)
+					struct ieee80211_bss_conf *link_conf,
+					u64 *changed)
 {
 	struct fils_discovery_data *new, *old = NULL;
 	struct ieee80211_fils_discovery *fd;
@@ -979,7 +980,8 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
 	}
 
-	return BSS_CHANGED_FILS_DISCOVERY;
+	*changed |= BSS_CHANGED_FILS_DISCOVERY;
+	return 0;
 }
 
 static int
@@ -1441,10 +1443,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		goto error;
 
 	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery,
-					   link, link_conf);
+					   link, link_conf, &changed);
 	if (err < 0)
 		goto error;
-	changed |= err;
 
 	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
 						   &params->unsol_bcast_probe_resp,
@@ -1516,10 +1517,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 		return err;
 
 	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery,
-					   link, link_conf);
+					   link, link_conf, &changed);
 	if (err < 0)
 		return err;
-	changed |= err;
 
 	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
 						   &params->unsol_bcast_probe_resp,
-- 
2.43.0


