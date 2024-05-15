Return-Path: <linux-wireless+bounces-7682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE838C65CA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465AB1F24ABF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE66EB5B;
	Wed, 15 May 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fi5qQQa+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC046D1B9
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772863; cv=none; b=OvAchDZHxjMhiF1Dp7KcxLI6nvqJPAeXlaZ5ljRb0eKEvFlxUCh5z+yYchi+idXL9LDpdXtGsiTpOQo2aFO3S5MLwTYoAdCWI72paEVvIVMylX2vsfc5RVhVHtGay5g3Tn0mNhOFHiz2ih7Zjkh+gPG2qBF9fuFqia+EjZD94E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772863; c=relaxed/simple;
	bh=NNae1xFyNrQKxs1BchZjjOAmPsAKlMlez7WxglOU9xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEPIkhSp4+liRus7GMiZf7B/4GX9XxqV3/OegB6Y20fkemVFosULiQPHot7fahZC5P+XP49af5St5ypOcDlqxcFqWf9222I2Thfuhtf0jZZC0YlT4FmRktbTTqUIqumPyOXQJ7rv3bQgRqB5M4s82FA5XSlfeNTTX1F5ctaVMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fi5qQQa+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Ky26idQRhunGw7aElTq0VpoXitSVxuHab5pSmfrr8PU=; t=1715772861; x=1716982461; 
	b=Fi5qQQa+aMl5F2xKBBjJwwe+1lrS6QznL8uULFL16GwNz32FoqdKMSAWfCVH5YjPk0F0/eWT58q
	zCs3V11CaLx73V4jWwPqs/QaxgY5g3LJcmd7YJ8qN7yS18+ZTFE8Zmfu5/Zk6yrnbb6uFmKOcDrT7
	w8BnJRSBAKUIyCFGZqtLfdjxqWf28cuMjvVmvMPtBTbp/lYvHyiUh6pNrGBwcILdRzkq3vtEud7zg
	Q7vLEbvzT9RzHtqs97y1W/asFZ9LQWS19ZAEj4LeV0zjmm8KoE5K+fv3T9iXujKh+uBsiB2MKQ2cs
	izNFVJETwj5zSSY+TF0tDyoAJkREanQh9qMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7Ctg-00000006Mj3-3jIS;
	Wed, 15 May 2024 13:34:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: apply mcast rate only if interface is up
Date: Wed, 15 May 2024 13:34:10 +0200
Message-ID: <20240515133410.d6cffe5756cc.I47b624a317e62bdb4609ff7fa79403c0c444d32d@changeid>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the interface isn't enabled, don't apply multicast
rate changes immediately.

Reported-by: syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b08e5d7687e3..99abbb9e8477 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2958,8 +2958,9 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-					  BSS_CHANGED_MCAST_RATE);
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
-- 
2.45.0


