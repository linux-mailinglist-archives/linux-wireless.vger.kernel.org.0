Return-Path: <linux-wireless+bounces-3283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086F84C90D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 11:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536C81C210D4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B01772D;
	Wed,  7 Feb 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n1f95JX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4131817582
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303469; cv=none; b=LVbOasNgobXXnK6sofdKEZLuiLLIZc55ReBJ7/3viSeXavNaYZyHWLGDhf6BbujS3NaVP1a1B/Ruz1FBtDDpcmHA85ymTaG5MEVLe7uAWzYn11GFc0LC1tj2+tLjnU8GRvab9vrSRdKgp8jmBunSBeK6V+9L8Szu5hn1Vigh464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303469; c=relaxed/simple;
	bh=gnQef2GfgeajkURF05xx51kQPZzG7/t9nbLcRIcUc4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1gJ1zRuMaWvxw63uqnv/3ZJsmQRU3Yq35HorVv8slEweOvnYPEnxwrjoHrMTKIsAJqC7I/flkhPQyJ9qM/iKtCfVSQUmeRI84xDxw6pDTuayG6/soLUoDGxXkY+hMNEGKGYNQnMniD06U7T3nKPjTsxO6X3UB2zfRTc33KQQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n1f95JX1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=sQ9KBukDEXxdA8FL6Z8rE16NKKBTeBv6n+A+xSuVKXs=; t=1707303467; x=1708513067; 
	b=n1f95JX1+TUA93/N+PL207ckwRSFFIARFiJQTKinlatZGNJ3AgzMUkfmgRrMjPyEZdtazMVkmw+
	OisvuP5WMUhwI9kwi07lnv7U3nxZHreCK+5NuBcRYyJUyiTAf9OK359FKTqABnYBYoslT0aqWW54l
	kSyjeTEsqDNaqUFu5w2irY6L4LY20KJP8mApJDSgFzIv87H+QVsqF1tTpDw6g5ktMd/1jqZWMR6aF
	7b2althdf8OlzhsFos3IxvbGYpaStInzILLs1rHr2RuvIf87SM1ACwTJr2GXg5mqw0Sv+9vs0TnXK
	JRt368G33oPwDWiour8C0/3gW3v+y2xd1rqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXfcd-0000000FsQS-2TKT;
	Wed, 07 Feb 2024 11:57:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: don't use sband->band early
Date: Wed,  7 Feb 2024 11:57:37 +0100
Message-ID: <20240207115739.7ce0dfde367b.I4968e12275a3f95926e3f3ccae81e50f23fe4d4d@changeid>
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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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


