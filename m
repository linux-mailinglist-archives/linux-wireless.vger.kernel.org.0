Return-Path: <linux-wireless+bounces-34777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGSuBbKI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A1640468E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C5C30CBBC5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0B2749ED;
	Wed, 15 Apr 2026 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K9UHV7Fh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8F3242B1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257124; cv=none; b=OKaC7scSJ0W+3gpzwlGos232UEzhck1nUdM0LMreW6SBjaw3LoduJSz2jFju4Rp+KeWFz9Cp82YZopBLdVMryK52apPXEUnRW+zL/KmNTHC/9wJAleUX7yia5UWOINaQ0MNDnbQXGF2l24/PPdUJ7k2WSxQlP6CJ1udW0DCP7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257124; c=relaxed/simple;
	bh=pbYYQKJ6ZvyjGvRcH7UluHgsF1+oPX3CDhAazpnCmjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r87MEYBHPi+uR5Wzc3bITm+KmTA4SgxiWhbaD4Tfa65TjxuhHBIEuAm+X3CMzXkhr+60GE1OSfgYkLuSWrc9QS5lU+qYzcD6AtpJN4EmCIVEoehFa3e7CTUlUeHCkTsoU3ic5ojPq2DxEu1sJPyedF1T3CytP5JsAKgc4R9LH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K9UHV7Fh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ai+jzrCa37MK7EIrbqir0X5wYYCEbllboanw2m4jFaE=;
	t=1776257122; x=1777466722; b=K9UHV7FhJpGyfMF3qaTevtUM5R663Y9NZ3IQOXn59+zl8oJ
	zLZBPJBY9w4gn606nlCvWx7g7w3AFPimIkqfC93TQe1ebmNM9/kyp7gzErzj1zIXUwC7F5jVH7Rwv
	Hp20urSl1Exiye0fvAogVeYMcjsfNkDBtBxVHVaHsFwM+m5G6iyfgd6pS+rtrwHrOJPXS6gj8bUVm
	4c93QxaZ4mzpnDsrE4Ur6CQ5L52EyZ4LfzqAt4G9EKNML1qX+KoiWjvUazz8EcMy7hHvBkNVQYNnQ
	UUv449YqMc+97atyr8ezlnNF5jstKQ/JV5zAKQjUmbLI7Ys1KWCM+AsgHWWG1Hdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcO-00000006OgW-225m;
	Wed, 15 Apr 2026 14:45:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 05/20] wifi: mac80211: use chandef in TDLS chanctx handling
Date: Wed, 15 Apr 2026 14:42:03 +0200
Message-ID: <20260415144514.cc7c1590e953.Id2381d2b5a9d1ded170501976240d4fca23ee35c@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34777-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 90A1640468E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When getting the station's bandwidth for TDLS chanctx
updates, pass the chandef so that the band can be used
in _ieee80211_sta_cap_rx_bw(), instead of this using
ieee80211_sta_cap_rx_bw() which looks it up from the
link.

This removes the last user of ieee80211_sta_cap_rx_bw().

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
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


