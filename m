Return-Path: <linux-wireless+bounces-33420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIbjBAjruml0dAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 19:12:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ABF2C10D1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 19:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCD21320D704
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87A32ED54;
	Wed, 18 Mar 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JdJKyAbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8032F742
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773853595; cv=none; b=Alop7a8/xf8s0hcHhMVO8mL8rpnndf+8mR6AVGCZZsg4NP1nlozKuN8HNlRn4FbT+jApePWLi1MWc2AgGy7OAe4ASqQ8BcGEB8Yfi5EIm5It23PFR3HoQtoSl9AslEny5v6k/D5C47hTnFhMAcuL9E1LJmN1MBPg7U5TdXYEeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773853595; c=relaxed/simple;
	bh=gF3gwPfU9Ibyg2Bnl7mOtjAEH7ISwIOubNpAbAg4p5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ei13zAs9UWDmq7CBPV3gPNXCrl1a1ToOPTXOfTOhpItfilk8ehd4/ni9BAy2UDzL3PWPE3crk/XdRCAF7X6dkPsiIqPpqI6w7P/K0S46khNl/q17Csh3vOPz6ZdbLUC79IVY553bM7dmHxW7khDnYKkNL5+3sOzkfUvYKKyA57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JdJKyAbV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/d7Jc1IjKbum5Xm4JaYjzkh7CkRJVynXPZOZGFl9Ff0=; t=1773853594; x=1775063194; 
	b=JdJKyAbVnQ2vMT777fft8hOAC85QhB3CT6HV6c2vi3/5DSUiSmX9BQTDULxW01wZoGpuyC18ACf
	t43K58wbIUebghDVpPEIm6QOB4x/w6EAhL8YFGw1f88lVwR+XFOTUaXVh2Q0en5qr9gYvyJWbGYV5
	A2edT4MIY8FXJw3dzatdpSzTg5hx9ulssnpSz26KW4fbLVVzphnqcXJJ0Mjm6SU7I/FYCxfcyPKm4
	k7swTNVovGH11kZlW7ot/ZndwGz23MsHczRGmzP7mTJ1/U/X8uF/9XjKC5iH4eZCKq2Fbh44nwytR
	WUBF4OOi4kvTSLnCLd4jhfipqLpBmEvfneJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w2uLh-00000004Z9q-39Gy;
	Wed, 18 Mar 2026 18:06:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>
Subject: [PATCH wireless-next] wifi: mac80211: fix STA link removal during link removal
Date: Wed, 18 Mar 2026 18:06:22 +0100
Message-ID: <20260318180622.9240067117e9.I45fb2b7f04d75e48d2f3e9c6650ef9f54a314f5b@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-33420-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 17ABF2C10D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

ieee80211_sta_free_link() only frees the link and doesn't
unhash it, so it can't be used here. Instead this needs
to use ieee80211_sta_remove_link(), which unhashes it. An
argument against it was that it also calls the driver and
that already happened, but calls to the driver removing a
link that's already removed are suppressed, so that's not
actually an issue. Use it to fix the hashtable.

Reported-and-tested-by: Jouni Malinen <j@w1.fi>
Fixes: 84674b03d8bf ("wifi: mac80211: Remove deleted sta links in ieee80211_ml_reconf_work()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f279bdb03aca..0cd8d07bf668 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7119,7 +7119,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 
 		for_each_set_bit(link_id, &removed_links,
 				 IEEE80211_MLD_MAX_NUM_LINKS)
-			ieee80211_sta_free_link(sta, link_id);
+			ieee80211_sta_remove_link(sta, link_id);
 	}
 
 	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
-- 
2.53.0


