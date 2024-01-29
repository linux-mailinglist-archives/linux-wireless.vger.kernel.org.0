Return-Path: <linux-wireless+bounces-2689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B638412A8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A79D1F21207
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28C15A4A5;
	Mon, 29 Jan 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ddIcnx8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F814A82
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553686; cv=none; b=my0PcquogI/a4gKN9O0Dp69CUI3gBjM2LnSVrEfIgK+eTYWtx4qVPck1S+EXKjXDl8WciaMZO3j6rfZLkJ+KqRXs3mAm3vOhgSAqTbUNvm0XsWI8hARka4NSbqmeXppkSaUYOeA4sRQqB3f2lgVHnNzdF1dlastxQpL2BUy+UvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553686; c=relaxed/simple;
	bh=4KItb5zXboJ/qQGUUbD9vjVMCX0ihnjzhWewMN6lD/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdOX9XCBYyoMb97ieMdLo/pIH1G0KjDJBwnXsUBg7cGSQ6thSbxNXfskjRuYeBLSyfCm8lkutGZZUgoVl4YnFT1dacv6wTiMeqb/wO/gaDVdSpzLun4cZMVPix8JiuWRzhTDKKJHl8x/mQo31h2sykinud9/jiXVgN69ahsEPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ddIcnx8G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7VPX9NwJpTHKYHRItXywbNP0KCjhWXjk9SYC7FdSOU0=;
	t=1706553684; x=1707763284; b=ddIcnx8GPfF6SO8RWiSEe40OGu0Yym2tJKDpH5NIMMtlpL8
	KCXy7byhOzYYM1O7IJAkjBMFXC6rpJGVqbtDtZEgSEUFsMnJfmsFQWx61vD/W1nZc1AQDaVhz+wd8
	5VEdC8X2RZkYW8YtIk04nkOuTlsNPzuXc2/clpQlOVpqo6slOu+4L7caysfAroGUIXL8zI/jfOHIt
	KgjjfjgCn/MGBvGvhkTKbjQeKL4TlCmHoYXpACvitkUJ+rVK+4tyY6G1A9bQ+kMHTC5+Zdz3DxCwU
	iW56l7D+XRodea8WRWrcctYGXbuIQECHyjQEnxN7xRZ4xYDvh1TkQeYvx9985EQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZM-00000004z9N-3bXD;
	Mon, 29 Jan 2024 19:41:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: wireless: declare different S1G chandefs incompatible
Date: Mon, 29 Jan 2024 19:34:46 +0100
Message-ID: <20240129194108.b28fb0644a8c.I9297ada5cf1baf00dbbdf8fcffd1806883489fc9@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It doesn't look like we can get into this code, but make it
more robust and declare two S1G chandefs to be incompatible
unless they're identical.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 71f1bd456d88..159b8aac451e 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -465,13 +465,18 @@ cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 		return NULL;
 
 	/*
-	 * can't be compatible if one of them is 5 or 10 MHz,
+	 * can't be compatible if one of them is 5/10 MHz or S1G
 	 * but they don't have the same width.
 	 */
-	if (c1->width == NL80211_CHAN_WIDTH_5 ||
-	    c1->width == NL80211_CHAN_WIDTH_10 ||
-	    c2->width == NL80211_CHAN_WIDTH_5 ||
-	    c2->width == NL80211_CHAN_WIDTH_10)
+#define NARROW_OR_S1G(width)	((width) == NL80211_CHAN_WIDTH_5 || \
+				 (width) == NL80211_CHAN_WIDTH_10 || \
+				 (width) == NL80211_CHAN_WIDTH_1 || \
+				 (width) == NL80211_CHAN_WIDTH_2 || \
+				 (width) == NL80211_CHAN_WIDTH_4 || \
+				 (width) == NL80211_CHAN_WIDTH_8 || \
+				 (width) == NL80211_CHAN_WIDTH_16)
+
+	if (NARROW_OR_S1G(c1->width) || NARROW_OR_S1G(c2->width))
 		return NULL;
 
 	if (c1->width == NL80211_CHAN_WIDTH_20_NOHT ||
-- 
2.43.0


