Return-Path: <linux-wireless+bounces-19692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9BBA4BBA0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4873A66AE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549C1E9907;
	Mon,  3 Mar 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tkrY/nRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327081E570E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996255; cv=none; b=PqtPLuBQMoTdyFbMh7pHZB/RUDZLSboeZFE5LUsFLtclOF/oAXc5eb0i2kCaxClLZTpZ2JOQ/D4cXxFUblsDCtxipFHJ1NHMcQ1J+5Wdfs9T9rZTFEC9p5g/lHeQoQaq3uM52UznmNk1mkYhhEU4FH1lV/+l8OtAhw1Skr/3wTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996255; c=relaxed/simple;
	bh=7mdB7VAWF7g07AXbbnj8SE4C7VPG0+Pa8/7aThheiWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taQFBhFe+bJUSipSeWC3aaIkdcjaCCPiKoyJwRerLf/Vub2B7/g4AuYxTvspxpdRCPcAj1usINS+up2K/oBLbIw3xSszN0W+SJu+zVZBDSFuRcEhupFPlW0xygnRKnzsZRTjb7X6mOTNz1ahhQ+aiahIWewTTKYzwTnSnqce86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tkrY/nRP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vylsf6XTPYxmjFQ47s7w/pvgmxPHotJSyMY9CXjJJsI=; t=1740996254; x=1742205854; 
	b=tkrY/nRPS0LQl15FmGNQOxAsR7UHwrNHX4UBar8AI0iak0LC/MDimk7dj987d+/FqQihyKuFvJT
	r8VBbRXRoOBx+LijUryfvlC15NQsF9en3/vyQLyqgxLQ2CQMn9ESahsRgYogiVLqC+3PvbetyJtR0
	1VMEJEG1dhuZJwUob0lgZ8nbgCQFzwIfYrlzGZWlFhvVF61B8u1cjv0UmeqcY/KywceVX4ElZMBh9
	7itrUfX6NClAnGyVbLX5+GTabZOxO3NE8x9wS2BqgA58Za/m6a0zgUY4KKGgKWFaENBVkfZphskYT
	uOewtxbLXgXJGyM0j93igzQUzAB2KwSKOiMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tp2eh-0000000H5Qu-1Y4d;
	Mon, 03 Mar 2025 11:04:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: nl80211: re-enable multi-link reconfiguration
Date: Mon,  3 Mar 2025 11:04:09 +0100
Message-ID: <20250303110409.3079488e52f2.Ic6ed3d184e5be8ba47c6affa7271daaf824fd823@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With the recent fixes, we can re-enable multi-link
reconfiguration. Also add a CMD() entry to allow
userspace discovery for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Placeholder patch - we still need to send the fixes.
---
 net/wireless/nl80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 27d51aa5cdff..95b570daf0e2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2768,6 +2768,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			CMD(update_ft_ies, UPDATE_FT_IES);
 			if (rdev->wiphy.sar_capa)
 				CMD(set_sar_specs, SET_SAR_SPECS);
+			CMD(assoc_ml_reconf, ASSOC_MLO_RECONF);
 		}
 #undef CMD
 
@@ -16534,7 +16535,7 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	err = -ENOPNOTSUPP;
+	err = cfg80211_assoc_ml_reconf(rdev, dev, links, rem_links);
 
 out:
 	for (link_id = 0; link_id < ARRAY_SIZE(links); link_id++)
-- 
2.48.1


