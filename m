Return-Path: <linux-wireless+bounces-34793-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGlNNvaJ32l5VAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34793-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:52:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD6404851
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC9A53038538
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE08275B15;
	Wed, 15 Apr 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rpbcwMvC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A84A07
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257523; cv=none; b=V3Ny1cn9mIiICtPZ/A2BsTwBrvSZ4oNvW4vQLJjm4KE60b0sz6QoEg5FJDG8AG/5/VbYLd6xbglGzT7YABFpc2I7wJCgq3y4kQjCzVxI/QNGVLhT96+Un2cyH5ZbMIN+MTdlN4tE+ePV6f0Ls+zbpAj6YPQZW8Gw7yg65kROU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257523; c=relaxed/simple;
	bh=CQ+NAhNhjKr3/Yd7Y47VSYD7KTdzY4kqGqfSzFIEITI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvlqT1fx1RgXrckEVuJ8mbkPOaRS5sLeMeR4oD7q6WUsCMbsY2hhVJCT4dI185dwSm7jTkYX7p3NJN9ytCj3/HUL+s5PVlzo3Sn3GSdbKcXzo91tWQx2jXRyzeopQSl60OGC2sqwII6ucb2Uw3F3+4fhwQZ8+0vj1kNPyGn0qrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rpbcwMvC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=v1Droy9MgT/YcLGI9P9eF1qT0xec6EfdcVI1ua01weQ=; t=1776257522; x=1777467122; 
	b=rpbcwMvCHiuUWmTf/KPiS+1hkq60yOlyiBGkFpDgWKnuS/QzRJfi+Bb859pa1zae2jvJVHhBat8
	bZu1Mn5B1qHLat++2nJ8Svvezb1LTqtr6pHBcgtEvsZC/c+wuShVkHLeItHwSxO7RGFMUnVtTBrBc
	BSosQFm44+HNq8cHbm+9iTO652n8vV2s4wEI1lADQWfoe8ZgucyXu93rV7K+vj2/7QONGLgniZi0J
	nqGf4EJn0FNq1SCGyhIungg8v7Gxyia1MhCigc84NwgKbnIf5Ho14Txalf53yAs4WBp0MS3AXlY24
	IWwR3bOcF+BjiimkEB+BydIbbLvIQ1rqIiEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzip-00000006PBn-2FgO;
	Wed, 15 Apr 2026 14:51:59 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: clarify an 802.11 VHT spec reference
Date: Wed, 15 Apr 2026 14:51:57 +0200
Message-ID: <20260415145157.c85df460fc98.I350b4c290fb90977f62ed59ac0246afbacee1ebc@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34793-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 40FD6404851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Just saying "Table 9-250" isn't useful, without the version
of the spec. Fix the number according to the latest released
version (-2020) and add the table name.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b093bc203c81..c31c5ce48cbd 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3149,7 +3149,9 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 		ext_nss_bw_supp = 0;
 
 	/*
-	 * Cf. IEEE 802.11 Table 9-250
+	 * Cf. IEEE 802.11-2020 Table 9-272 - Setting of the Supported Channel
+	 * Width Set subfield and Extended NSS BW Support subfield at a STA
+	 * transmitting the VHT Capabilities Information field
 	 *
 	 * We really just consider that because it's inefficient to connect
 	 * at a higher bandwidth than we'll actually be able to use.
-- 
2.53.0


