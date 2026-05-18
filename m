Return-Path: <linux-wireless+bounces-36611-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M2BCpJHC2o7FQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36611-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 19:08:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3701571706
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 19:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647FA30DAECD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A9D380FE0;
	Mon, 18 May 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="HCGvVc/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7C364935
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123738; cv=none; b=qRX9ohfNO7GnPVDm51fJwHP2F1lkTjf931xykKbugJnkG45+h27Nhp2s313esQ/+K5XKSBzvS3NRhY7Thx4G2q3hCS/BTBIVV/aRNXUbjkb7Fdq63VNzprrRE1IEDCm6YjOTExSX637WBSR6Tq9V/zw9em0CHiDugYc3CGIoaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123738; c=relaxed/simple;
	bh=HTVC/uQlc3+FyQxEwauI5xzA8o6CsaZzTi+fW37idnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFujqCmpS+6L+fK/fpx6xPQKjhn93xibmln9PqUCX0RnKu9/vXIlk8aQnMzAflC3XnNbgPhoEpKtmwXeN/n2/hucO0bnpqa9PQAos50kj7cS788wYc78eEGLkbwcFwRW11nkb000AwlfevXa4X8clCXQ4WRWMd5NpqaFOIJczwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=HCGvVc/d; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1779123731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESnfBt7T8rmVjr1iPiYQF7zF6vpA6x++Cs8prC+X9Ng=;
	b=HCGvVc/drxd0YUoh8KQzqiACoSkWjvy7ila2F4/+V32iI+R6K+RZXYKkT2lipsT+n2jf+c
	6wxiQtH7IaAO9ixEEKqQAWXFR1RUFMHCswgjx7lTVvvRUgjOsVcPNW/YKYIZhPbQbpwtdZ
	fZgDekBY+1YSGsAP+DCZ5UPMLY5N/lltjAduXm/xB3qwPlQUEILbEzLak6VMRhXplgu82X
	B6q3QiTPbRcTc5TokP61KQRXL2eNCqDNY0FKylnpkJx1OdKr7WvdbbX9zgVFx+JtIBCCQl
	e23jAKYUnH/2O8M6t32sifwVJr/hpmAvnZYCibh1XqDTUJvp0GqtKtvwn2liCA==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>,
	fjhhz1997@gmail.com,
	Devin Wittmayer <lucid_duck@justthetip.ca>
Subject: [PATCH v3] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Mon, 18 May 2026 10:01:47 -0700
Message-ID: <20260518170147.13885-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260518170147.13885-1-lucid_duck@justthetip.ca>
References: <20260308164510.5927-1-fjhhz1997@gmail.com>
 <20260518170147.13885-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,kernel.org,vger.kernel.org,gmail.com,justthetip.ca];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36611-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,justthetip.ca:mid,justthetip.ca:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email]
X-Rspamd-Queue-Id: C3701571706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 傅继晗 <fjhhz1997@gmail.com>

Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
behaviour") restored the monitor injection fallback for drivers using
chanctx emulation but explicitly deferred the harder case of drivers
that transitioned to real chanctx ops. mt76 falls in that category
and still drops every injected frame when monitor coexists with
another interface.

When the monitor has no chanctx of its own, fall back to the only
chanctx in flight if there is exactly one. Refuse if multiple are
present: picking arbitrarily would inject onto an unrelated channel.

Reran the airgeddon evil-twin flow (hostapd AP + coexisting monitor
VIF on the same phy + aireplay-ng deauth from the monitor) on
mt7921e PCIe and mt7921u USB across 2.4 GHz and 5 GHz, and on a
Kali VM with MT7921U passthrough as the closest match to the
original reporter's setup. None reproduced the hang seen against
the earlier attempt at this fix
(<20251216111909.25076-2-johannes@sipsolutions.net>) or against v1
on lore in March.

Cc: stable@vger.kernel.org # 6.9+
Reported-by: Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
Closes: https://github.com/morrownr/USB-WiFi/issues/682
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Signed-off-by: 傅继晗 <fjhhz1997@gmail.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
v3:
  - Replace list_is_singular() + list_first_entry() with
    list_first_or_null_rcu() and an rcu_access_pointer() check
    that the entry is the only one in the list. The v2 pair
    re-read ->next without RCU between the singularity check
    and the entry fetch, racing list_del_rcu() of the sole entry
    (rculist.h).
  - Tested-by carries from v2: v3 changes the lookup primitive
    only, not the TX path, so the v2 airgeddon evil-twin flow on
    mt7921e/mt7921u/Kali-VM still applies.

v2:
  - First respin under my submitter signoff; preserves fjh1997
    authorship.
  - Verification matrix; airgeddon evil-twin flow on mt7921e/
    mt7921u/Kali-VM does not reproduce the hang reported against
    the v1 attempt at this fix.

 net/mac80211/tx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 933c86ca21c3..6d2c71a13f26 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2407,12 +2407,20 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 				rcu_dereference(tmp_sdata->vif.bss_conf.chanctx_conf);
 	}
 
-	if (chanctx_conf)
+	if (chanctx_conf) {
 		chandef = &chanctx_conf->def;
-	else if (local->emulate_chanctx)
+	} else if (local->emulate_chanctx) {
 		chandef = &local->hw.conf.chandef;
-	else
-		goto fail_rcu;
+	} else {
+		struct ieee80211_chanctx *ctx;
+
+		ctx = list_first_or_null_rcu(&local->chanctx_list,
+					     struct ieee80211_chanctx, list);
+		if (!ctx ||
+		    rcu_access_pointer(ctx->list.next) != &local->chanctx_list)
+			goto fail_rcu;
+		chandef = &ctx->conf.def;
+	}
 
 	/*
 	 * If driver/HW supports IEEE80211_CHAN_CAN_MONITOR we still

