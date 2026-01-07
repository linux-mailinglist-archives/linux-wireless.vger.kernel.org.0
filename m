Return-Path: <linux-wireless+bounces-30464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD4CFE77E
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C101305E865
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6333290B;
	Wed,  7 Jan 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xDduTZSn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCEE32FA30
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795820; cv=none; b=WyLo4kIAWmmuvhwrGHuwO57clqFy1UGn5gxK1XEOjV7jDz8bOXuPyzZSDlRDrnHt2nrX491fB85F9N8ffCYPFrkogSk4vYcfH8mPmJ1TP2lbWml2OSFZGcLh71G8M9Y5xjgUWkzuvci2KCJackXQpllDmxoymSd3hSz96CM9uCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795820; c=relaxed/simple;
	bh=NXmqQn4SoCisagJreYTPLJtqj/ic9atRrUT+UD4Rx94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqhy7q9wTBh7TF+1MOFeh1QozzCseWlCHTZUBR35vXOled5zyvNf+Rd4Y0v8Jmp2XvadFqLbKUGULST54bJ2ICYeZFq0S+xQlXfS8HqWVV4rkwHfFU/IOrGnJADNcNbXFLjwnyA/p5FZSk5H5NCM8IoVIQugVc34fqlbB6ZO3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xDduTZSn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SK0cuojVZuAAt4Kb/MV3IsZRzcGi5SXrpJ9nzSXyZBs=;
	t=1767795819; x=1769005419; b=xDduTZSnn8jMDmdnzwu/BbSRFjwmjRp/lipSSWrUwnWDjlu
	OHDG08Gzmfil33aFkexogaDhXqA3GcgO7i80QteUmyFnb2aaMf5aIhKpU/7YN0Dhm3G3F26V413q5
	G/WrSyBT1nzHpPj3NJxw/si7MaaWPl4+flZEDj9ulq3I9hkZdC/3F2UB/DCktKKD6p0GqoJ1KvOzH
	DbfTzezG+mxwegu3mk3/Y9FV/GgXRNrpzEdhmePzpmAa8ksl5ZbPVD1i0JRLvBZQWCAA/Eb3ga3fc
	DbER/hiF2mLowhVNgSTX3a1TLoI4IZmXtAaqgHQnNU6B9VtOsRpeSnRjK9jCrIXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURl-00000005agF-0hiR;
	Wed, 07 Jan 2026 15:23:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 04/46] wifi: mac80211_hwsim: remove NAN by default
Date: Wed,  7 Jan 2026 15:22:03 +0100
Message-ID: <20260107152324.dd6bb8f4bece.Ie444b9f5aedabc713c6a1279b5b55976cfb4c465@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We're improving NAN support, but NAN datapath support also
means we need to change some other things, e.g. related to
rate control. Remove NAN by default again from hwsim since
it's the much newer feature.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c3babda1660c..e0b1a821be59 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -7162,14 +7162,12 @@ static int __init init_mac80211_hwsim(void)
 		}
 
 		param.p2p_device = support_p2p_device;
-		param.nan_device = true;
 		param.mlo = mlo;
 		param.multi_radio = multi_radio;
 		param.use_chanctx = channels > 1 || mlo || multi_radio;
 		param.iftypes = HWSIM_IFTYPE_SUPPORT_MASK;
 		if (param.p2p_device)
 			param.iftypes |= BIT(NL80211_IFTYPE_P2P_DEVICE);
-		param.iftypes |= BIT(NL80211_IFTYPE_NAN);
 
 		err = mac80211_hwsim_new_radio(NULL, &param);
 		if (err < 0)
-- 
2.52.0


