Return-Path: <linux-wireless+bounces-34042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HBKJxVQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E6341D61
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A16304D1CA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E573D6498;
	Fri, 27 Mar 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ihmGFaNe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D393DB653
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604233; cv=none; b=YmwZGy0ome7wLFb+afHf9isLeqUCkrhWZApUB9J3Y0kH0D2uWYUXENsXClHDjHCR2tgwhmzkJ+NCZPRqtltFzeX9j9jTkHb67u1pV3DIk/5TepnvRpdqgGa/por8BHlsqMUrRE4EVOcPvg0UlJ4A518L4Lsf4vbMu1I1ua+xYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604233; c=relaxed/simple;
	bh=9A8VY2px3wtG2CYT4di/flwQaCqbGYV7HT2pE21GC9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW/00nwIgViM29vY5EO93DgXjlEqVz8znTTCSTYQnhjhP8JdaH+Tl+PyfxCYwSiOt5onUTNwPdkElLARCa2TxCwUsC6YwGzZfrKyS6FcB2oTItVp5/s7U+M71OLT3BTHc8xKww2Y9Zm5Ev05xtVlW2PwXj6ZOZpi8aFRpK8VjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ihmGFaNe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AzPoK0wAuDyunDsWi6dymP7aFrleJ0/WeMb9pY9oYDE=;
	t=1774604232; x=1775813832; b=ihmGFaNe1ZQ+ZVlOKksOjKouZMXnSpTVNlp4e5aaD0oU9xY
	ncMCRR4oiuJ5iubKaXmf9Up4VcqtSh0rXrvRh8B+qlfUSQBOTNRi6JtOu0BGobzGNAJVafl+48qtd
	NA0jlwrk3myMfUsGn+ZcAXbIelIqZXTjOPE0cXAstJiR4z3uESzCg4iTdJPeQX8G1n6eG9NdJqLCN
	M+Dlb+hDTggsta/5kG/bLWSfgHIiee/rmV0PiTG+AsH3hfaBXggOVEa5XBPIRbdt9VI6A5rHwlaSM
	8Lvy8PiWOadbdBeMGmNEzsiO+NWYgmcXazjgl+GqMZiXAiyJrkQ8pWaeJH3ayq0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cm-0000000E83L-1izQ;
	Fri, 27 Mar 2026 10:37:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 04/19] wifi: mac80211: use chandef in TDLS chanctx handling
Date: Fri, 27 Mar 2026 10:31:30 +0100
Message-ID: <20260327103659.572719476e87.Id2381d2b5a9d1ded170501976240d4fca23ee35c@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34042-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 352E6341D61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When getting the station's bandwidth for TDLS chanctx
updates, pass the chandef so that the band can be used
in _ieee80211_sta_cap_rx_bw(), instead of this using
ieee80211_sta_cap_rx_bw() which looks it up from the
link.

This removes the last user of ieee80211_sta_cap_rx_bw().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tdls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 44bba7c3e603..90a122dc274f 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1334,7 +1334,8 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 			enum ieee80211_sta_rx_bandwidth bw;
 
 			bw = ieee80211_chan_width_to_rx_bw(conf->def.width);
-			bw = min(bw, ieee80211_sta_cap_rx_bw(&sta->deflink));
+			bw = min(bw, _ieee80211_sta_cap_rx_bw(&sta->deflink,
+							      &conf->def));
 			if (bw != sta->sta.deflink.bandwidth) {
 				sta->sta.deflink.bandwidth = bw;
 				rate_control_rate_update(local, sband,
-- 
2.53.0


