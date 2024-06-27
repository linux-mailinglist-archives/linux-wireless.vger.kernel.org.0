Return-Path: <linux-wireless+bounces-9648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA491A1CA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F252B2097E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C02770F9;
	Thu, 27 Jun 2024 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UjU4XB7a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496378C60
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477788; cv=none; b=pcybigsldcqfaik6KaZzEJvM89qw7kcCQiL2Cz5oOcnHp4NTutlLRjrG3pqpzvFCZ/Kdpk2TX7TOd56ZpcYakpGGUWkGXEWEHGET4XoWcca7JXGzV9CAMbPqRLOeDwuANAUE5iumzbR2GQlTOLhnuZy/KT8ZS6+7RA4d0MZ3pbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477788; c=relaxed/simple;
	bh=ucHI87Qksv7Ee0nGrBvFplpzoL+ZXp+e3+ftXbh+u2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EV4Kviw85B3n9UO5w5bxGxWnTrH3/X7cUOhJR5Bpien+mHV0cbPjR6M77u2WljafEo/wE/dGMkBQm23vL/npRtNxOaW5hAk2jEOmwdXA9PHtUf4D2P/SJCnpOlWVAUg1iRIOz9jVtz0VbqtlFOwSgOEwTHbnv76PRzZHR5EYQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UjU4XB7a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=WC44t3MGlr2xZRSqA24butDyIDcoravkgEwTSfKVXcI=; t=1719477786; x=1720687386; 
	b=UjU4XB7aszH0prJSJWclAfR1P+XA8svgT22ikkyh5PKdtSi2X386SDvYYU7rl8IpFux+XKPvI8w
	FUY9rp2UfnrVwW3YRePOIz6UAAiCWhUMo3PhIPOrypkIgxgb3T1p8yTJ1BflNRa6A+UaVzSxA5gAL
	Sqq2hrlH3yJ8iewp6Wzr4FdzzAGO9punopPMzgSJfib/yv//gAHOGH2WsE7y9ja98qT6VZLJ2fwq5
	dJkPrQ2/jDBkD1NJG0ilX16RPTnGO1L/xMwl6EgSQSOpwwZSRZep+HZopOL+paYX41QLlduUTV46T
	50GM+J6luCl4RZeecLLPKZ8tEVF4b2Eo79XA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMkib-00000006aJP-0Wnx;
	Thu, 27 Jun 2024 10:43:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless] wifi: mac80211: fix BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
Date: Thu, 27 Jun 2024 10:42:56 +0200
Message-ID: <20240627104257.06174d291db2.Iba0d642916eb78a61f8ab2cc5ca9280783d9c1db@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Fix the definition of BSS_CHANGED_UNSOL_BCAST_PROBE_RESP so that
not all higher bits get set, 1<<31 is a signed variable, so when
we do

  u64 changed = BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;

we get sign expansion, so the value is 0xffff'ffff'8000'0000 and
that's clearly not desired. Use BIT_ULL() to make it unsigned as
well as the right type for the change flags.

Fixes: 178e9d6adc43 ("wifi: mac80211: fix unsolicited broadcast probe config")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index cafc664ee531..45ad37adbe32 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -395,7 +395,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_HE_OBSS_PD		= 1<<28,
 	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
-	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
+	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = BIT_ULL(31),
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 
-- 
2.45.2


