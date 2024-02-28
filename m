Return-Path: <linux-wireless+bounces-4146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EAE86AA67
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569CE1F247D4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE12D622;
	Wed, 28 Feb 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HWvUwiAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5662D05C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110150; cv=none; b=Xbw98WM/3fbf8KpqgYG4Afj6U0/Enlb/dD1CJFrsLXLwQ0lsL9+ThewRJKxu9464qLv7XiYT5qjLyAJroYhAtD7v+0QzabPChj0IPw5ByxZFffdsvyfEgtKXbTq/WREL92Ekr8CxvgKGFZDQ1RdjkrM28W0BrB76qn+jxuzl5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110150; c=relaxed/simple;
	bh=Xsnnez6zvL++vwTf44cbUFTOtmrSWuGSTWfS/o7S7tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHbSoRhSJUWj8bzJjx3IQaGZeEj7U7f6dPV6/nk5JPf1Hon5tL/TdopiRQTVnpI5clJ6MFlwP2H/yt+/4nbJhp8/dMmaCkqIAWrtr18+AUJl7wMCo+o+VHuqMVW/E4yHvHjy3eHrucdR9jBGpEp8x+y/XVeTf/rwx2yObhNGtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HWvUwiAe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fn/+YyW+0dDZ2Tyij3BZ+Ds0KcAJWYAvLwT1/MyHQP0=;
	t=1709110148; x=1710319748; b=HWvUwiAeLAK/i6bBA6vKuuoTfPZhm6MhN5yleGw7hi1rYsr
	iM19BbORwW6uy0IhAc4T1POHO0D/jDfd4bVlHDESC/y+4Rc96uukRfcG6aooUCeP4skN5l4FCr5Wo
	hO5qm6Y11GPIxFzPqsjlU2R996ij+3NfmlY5uBFz599yWYidagUoFsjEFScP2/8dLbNPqmApPVtt2
	SlQtLkDw0MOP55XAhBHNbkXs0g3c90+9cyz25LUfeDD8Jo6uZ7RhvpdxhgMIpDQrIagq2RwO8lkbh
	ipaNX0HEgUCWzEN4abE5vEXXbsEDTW/ZoJbDHq3T8xW0Sb/1v8VpyW/ph+ajn+xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFcf-0000000C0BC-3sMy;
	Wed, 28 Feb 2024 09:49:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/8] wifi: mac80211: remove unnecessary ML element type check
Date: Wed, 28 Feb 2024 09:48:10 +0100
Message-ID: <20240228094901.ad1d4a09a6eb.Ib96fa75b1a6db21dd4182dcfa11fe9aff78fa3ed@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084901.18661-10-johannes@sipsolutions.net>
References: <20240228084901.18661-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

At this point, since it's taken from elems->ml_basic which
is stored only if it's of type basic, we don't really need
to check again if it's basic.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/parse.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 233c761823d3..ae0f14bd952a 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -723,10 +723,6 @@ static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 	if (!ml || !ml_len)
 		return;
 
-	if (le16_get_bits(ml->control, IEEE80211_ML_CONTROL_TYPE) !=
-	    IEEE80211_ML_CONTROL_TYPE_BASIC)
-		return;
-
 	for_each_mle_subelement(sub, (u8 *)ml, ml_len) {
 		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
 		ssize_t sta_prof_len;
-- 
2.43.2


