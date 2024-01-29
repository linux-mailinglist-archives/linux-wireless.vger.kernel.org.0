Return-Path: <linux-wireless+bounces-2680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D384129F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C332851D2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA0158D89;
	Mon, 29 Jan 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RwZDwYjJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C429CFB
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553679; cv=none; b=lCErtlKrHWfjrYdAW55XLP8GajbTULw3N/6N69Mr4IRHUygxl/i2rpiDEr06dYSQYrG0gLpm3ijjQVFxUGYqyDWxnBtlvTrgztf6UEAQi7UcrH0uhGSrSXuHaUv6sDCb8hZ7QOYd5A04/M9pdyZF5khx2lCL9tYaeASLrrxdSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553679; c=relaxed/simple;
	bh=bIgjeMKkRXzcOatNWMnbO4pLkRUm/6b9lAecwESv0PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T12RZjtvhfJD1YoCqaHjG9DcBrLgg0RMdIbvCME/FXeVe1Io9CWOg9qwAiDeS5zyig38rRaymE/613lcxLY/WgyT8Ock0SFxtnSvjKo3H532uSsgBDb64gyVDE9r6kUWJuFhYORNyUrC5/XzXxkeCy1dPsuAM923Bx0zTy29r+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RwZDwYjJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i1RKIOQW/1ZozizGoI6M3Ft63fMzquz/J0Z74AWdSpw=;
	t=1706553677; x=1707763277; b=RwZDwYjJ0QHPrK0irmk7NjtcJzDfelMTjtPzGqBhctjbQLc
	Q1TMMxQ3u7v+Wb2nu7BcBsjanIInFm2n4ID0GOHwFuaatI+ydpBbjEPCqn/7JbLzV5AK4/kwNrN1X
	O5tSUQHUq6DZZKnRxfSNdYJElShYiF7Y+kHAEKS5KjZh4LfNO39on6NYUHS1IPRHwsw6Wc7fl3r8U
	HkpcUiQx3IHpwZDluj3IZXwO12rcGKezIn+cgYE7QXgcphGmNzHyuk5PMr1V5BJfl9/OU/7Ve2jdX
	iw/ZLE0JdlYiwD+hdHzGvrWBX10tJAdalb5vNMhHhc5CI+VNlEPFWttixjvs0lGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZH-00000004z9N-1NN2;
	Mon, 29 Jan 2024 19:41:15 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 05/15] wifi: mac80211: chan: chandef is non-NULL for reserved
Date: Mon, 29 Jan 2024 19:34:39 +0100
Message-ID: <20240129194108.bad8ec1e76c8.I12287452f42c54baf75821e75491cf6d021af20a@changeid>
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

The last caller of this with a NULL argument was related to
the non-chanctx code, so we can now remove this odd logic.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index cf6297ffaef3..6b82c79cf7a6 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -90,11 +90,11 @@ ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (WARN_ON(!compat))
+		return NULL;
+
 	list_for_each_entry(link, &ctx->reserved_links,
 			    reserved_chanctx_list) {
-		if (!compat)
-			compat = &link->reserved_chandef;
-
 		compat = cfg80211_chandef_compatible(&link->reserved_chandef,
 						     compat);
 		if (!compat)
-- 
2.43.0


