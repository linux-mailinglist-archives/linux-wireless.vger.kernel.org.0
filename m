Return-Path: <linux-wireless+bounces-3284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7A84C915
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 11:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C0F1F226E8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D51B7EE;
	Wed,  7 Feb 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DyvGAdWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E21B7E3
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303568; cv=none; b=iSrs5TeXXymg3MVaPh2z2XDdK3s93jKKlh+Yzw8Wa3xElfZHWl8eRdXmcKzVadmbH/E/yYHnECUonRW0WZptBbolpDkxpPKR/s9Haiq8eGVCXjzPaQo+5gIBIYuNqx3gNsJMIhKVNwOWBGMMIgTLUTNJe+0YT7Lo2VBBjlvweWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303568; c=relaxed/simple;
	bh=R9tvgDQShFmKNZFYmFfKi5x/0uH3yQJ75zeuuumB4u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcFAtKq8HvieZuDN6WQyOlOA2eU/95Sc/hrRFvfI/y6Dyz/7gF226WX+J2Eo9S2cyBtw+w9YRT60KD2dC5URczN27UuFU9XkC/rRGALJYfjZfim+FRzzSSYsry0r105CEZ9Qr/O0/giadiwM2MoPkN7BFLkt0i3/spCxP94goXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DyvGAdWu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vuehioarIzzvAMhoNza60aWgCWeeRAMsn65lO9qWKp4=; t=1707303566; x=1708513166; 
	b=DyvGAdWuK7YzUNRdN6s4kptPDzhmbbKb53C2O49aSn6p1SwqMAKnDb5u0pXw3jwOvJr+pThuID7
	BRvAXaamjH28TkuaCTeB5eJlzavBJp75XwNkIaiVr9piSKLIdwyJ3Uwo3ob7NkKsFXNrLPVkSntbU
	xpineLhGnZqsE1Rvk+BozPt+pJwosYRuVxe8FDif+Dzssk5L0b12G19FG1/1m/kfqWC+Cx4+gJUlb
	GC239Updw78hnNbvTovbizQq8UtPFFS9WcmSkIv0O3DDM+p4JzmEBkhwrsPOef4KQXg2YLuUoJ39+
	TKS5ntabF2LIQYjEaFg1ABb8ktJ0qBk/ErkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXfeE-0000000FsSv-3UJr;
	Wed, 07 Feb 2024 11:59:23 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] wifi: mac80211: don't use sband->band early
Date: Wed,  7 Feb 2024 11:59:20 +0100
Message-ID: <20240207115920.43cbedffb5c3.I4968e12275a3f95926e3f3ccae81e50f23fe4d4d@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some drivers may (notably mt76 does) not set up sband->band
before registering, and cfg80211 will fill it in later. But
since the HT/HE capability check mac80211 required it to be
initialized already, otherwise failing things.  This really
isn't necessary though since the code is iterating the list
of bands, and has the 'band' variable available.  Fix it to
not require the sband->band to be initialized already.

Fixes: f04d2c247e04 ("wifi: mac80211: disallow drivers with HT wider than HE")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Debugged-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218466
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: add the right tags
---
 net/mac80211/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e05bcc35bc1e..6d38b8dce8a2 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1124,7 +1124,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			supp_he = supp_he || iftd->he_cap.has_he;
 			supp_eht = supp_eht || iftd->eht_cap.has_eht;
 
-			if (sband->band == NL80211_BAND_2GHZ)
+			if (band == NL80211_BAND_2GHZ)
 				he_40_mhz_cap =
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
 			else
-- 
2.43.0


