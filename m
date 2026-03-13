Return-Path: <linux-wireless+bounces-33208-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPf2Mrf9s2mWewAAu9opvQ
	(envelope-from <linux-wireless+bounces-33208-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:06:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C9282AD5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 13:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA7730C1C0C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FD7386C3F;
	Fri, 13 Mar 2026 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QVc+QKx0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E831E85D
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403272; cv=none; b=nSJE+JLQdy54aImgKEMyw6Bn920OCBU816Fkt8bkwvflE0jmyLeo0HfYGhTBnGsqbUT4hB4dFck6uK7wTtD3/qCcGTiUTa2cL3PQ0lEYhBcTusyA5Gs3aBByo2EGmmiyqeevGvPYAggt8K6kggSx8ETlajUxrYeDG4zN8rZY42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403272; c=relaxed/simple;
	bh=V9tQTiVwjzWb6JToGRcBI0Ifj65Kh1tSMxDjOQiyNfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MctqSe7jbYsvzboSpSRq//89u5E8PSErSLWmbXk2I705LOuq6ytZqKcOPfkgiqk2+stwTwKKh1zJNDowWo1zQjEpJAJSP+5366q3J/Rfu8kQatfZrEWKg6bhZLkm7NOHiLP0YuxXckU7UNjDt/LrS2BNfiK3rA/M1x6foCRGL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QVc+QKx0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hQ7cPXJBrmIZUtMRdhudDRUtiixItFvJkFRfV4AAmn0=; t=1773403271; x=1774612871; 
	b=QVc+QKx0AciXkOYd5dZHBupk5mOL+pu+SNVxXtQQ+0ZYBDffaZvd4zKnwbnTY+J8lNXV/SMsqzW
	r2AIIKHJyp5MgTv0rRgesOc2rVmGW8d8wgbR2ha9i67txoJ8oMTduccd44WWnL0iBFGOlud8MWUd7
	xp7KSlxemxPjX6G1UI++LDspR4QApBxtlJnb5RdWwndL8AunRG5PZYoRNh26jk1klnJgVJB3n8ryG
	0NK++4MPm7JJ3n+NT8JJkuIzC2VKJdefC5+vexCp+XBMj4X0sZM3nT26LmZOfwFXzUyut+G4mn+DM
	xpn2vHoNM0brAtLZSqpUca0PBh6ba7x/GykQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w11CX-0000000Guud-2Kye;
	Fri, 13 Mar 2026 13:01:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: nl80211: reject S1G/60G with HT chantype
Date: Fri, 13 Mar 2026 13:01:06 +0100
Message-ID: <20260313130107.ac21cf12df96.Ie69789f94e68d22b4f4a3e58cf05c91ec00b7b3b@changeid>
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
	TAGGED_FROM(0.00)[bounces-33208-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 2C8C9282AD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This configuration doesn't make sense, neither S1G nor
60G have 20 or 40 MHz channel width. Reject it to not
run into the new cfg80211_chandef_create() warning.

Fixes: 92d77e06e73c ("wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based bands")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3e867930e253..d2ef13ab1a20 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3634,6 +3634,9 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		case NL80211_CHAN_HT20:
 		case NL80211_CHAN_HT40PLUS:
 		case NL80211_CHAN_HT40MINUS:
+			if (chandef->chan->band == NL80211_BAND_60GHZ ||
+			    chandef->chan->band == NL80211_BAND_S1GHZ)
+				return -EINVAL;
 			cfg80211_chandef_create(chandef, chandef->chan,
 						chantype);
 			/* user input for center_freq is incorrect */
-- 
2.53.0


