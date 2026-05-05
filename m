Return-Path: <linux-wireless+bounces-35908-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLi/J/vu+WlqFQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35908-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 15:22:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289C4CE5D4
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05880307374E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A931715A;
	Tue,  5 May 2026 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DSZRVzAo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398C3064B2
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987078; cv=none; b=dfh80be+c8jsK05iWoCnKQPcMR5W7s4PcRFHUNwUfb3A6uC8JwBZ17FLsUFFnqYwVFTnIR4xhVAEmUk3rbiv2zYKLT83qvmBLkpeU+2fYm8eIHUKYnROt7srfN2MKvhtkEz+vypsSDJoDdVxq+DNzM8fgCNHQY9ev0Q3RPMtIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987078; c=relaxed/simple;
	bh=fRl4wR5MYfQrt7SZ4Lu9TnSsavrTD0uFqPv5ojWB5SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrUPz6NNJObMM0trDC774rJ7tIVvWe0ZTo2W+QsP316SoCjmQCp/HyxMmqJhuQBHOOq8Nut6zEm3/R6SNsUotzPpxzJGH81VPhPOAMSEcdcMb1lHVdBY/KbjbBTLbteVBr4+5OgasJQJmAay0lbPvTXL2PS3TP54xsr/WHrSQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DSZRVzAo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=msRQjsZfP7KqYw3ECCM0jSkgpMzI3QaWdWPRJVDuTsc=; t=1777987077; x=1779196677; 
	b=DSZRVzAoHi4vEjSzHgKFf64XoUB0UJ+tdhcyzHFcNCofv65uOnirnDcidt0J80XLmSB7/ByS4sW
	8vUEj+2JOmT0T5PdvO6LghLkqybGFYN0JBXzKyMYvr7Uhyt6YhrWB7R7ryKoaplX4J8slhksjQl3/
	3CwbCESPwxCGtSHagEoOnG56QM32nHaCbpqKStpKrqPNqqG0eVHegSFUhucq/4qJRRc5IlrFPTv43
	GPHeTVHEdQwqHPLwe7hDDKTh/XCqsAdJ/oTBTPo2xMv3w8pCkJ+IbRXbblWkX8ILNfgOVUw3VLQ1t
	hXmymeUMXUN3/l0dDkYqlmPcEZkIDDV2658Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wKFes-0000000GEsd-2BOZ;
	Tue, 05 May 2026 15:17:54 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: use safe list iteration in radar detect work
Date: Tue,  5 May 2026 15:15:40 +0200
Message-ID: <20260505151539.236d63a1b736.I35dbb9e96a2d4a480be208770fdd99ba3b817b79@changeid>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0289C4CE5D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35908-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

From: Benjamin Berg <benjamin.berg@intel.com>

The call to ieee80211_dfs_cac_cancel can cause the iterated chanctx to
be freed and removed from the list. Guard against this to avoid a
slab-use-after-free error.

Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected() for MLO")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b093bc203c81..2529b01e2cd5 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3700,11 +3700,11 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, radar_detected_work);
 	struct cfg80211_chan_def chandef;
-	struct ieee80211_chanctx *ctx;
+	struct ieee80211_chanctx *ctx, *tmp;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(ctx, &local->chanctx_list, list) {
+	list_for_each_entry_safe(ctx, tmp, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-- 
2.54.0


