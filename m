Return-Path: <linux-wireless+bounces-36568-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNGQHey0Cmpp6AQAu9opvQ
	(envelope-from <linux-wireless+bounces-36568-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:42:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BFA566DC0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6516300877E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F1530567B;
	Mon, 18 May 2026 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="g7p1W7id"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46F22D7A1
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086454; cv=none; b=C2Gkb8gMyqlxFkmQiYSLcStmvxkx8yzUtnR6thSeJNXeVVIP+t5oWAzjucPOJt2Q3iY/tUQvhEi2RMxCzG+sauOY39v4Vi+w7Zf73Dk9TZHRowmuxDsnyaXdriqvmAdXZ0/6e3rG/PNKxbHKRRCp49hd/uDmAneuLSpfe4CQJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086454; c=relaxed/simple;
	bh=YHRq+gi0pffDdIfST7DIUPvZU9ThdMH7EpDObUpfKGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTunaVF6dtKHdcJlAhSKo2AIVBl+iK+r9iuaJ6KY1u8gPLf+ut3Ylz67JSmvtPb0QDDSniIZbPnd2VIDuUfpu+1KKdho1pZBonZRPKSdRQriNXGBD/zdsXfOrZ5g2gb5lvXesKCoiHkE4HS/hhW2+idSQZRPUFssl0Gc0cZn27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=g7p1W7id; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1779086447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdvIk0fZuJ839TqU7mVfww9i4xSZEiHt4UabatdeTQQ=;
	b=g7p1W7idaRLqiE+ZCoaNNYXrmQ1TznsDL1BTGhWobx0dbsr+7CnyToFZJl2wjAJAeV8Wrt
	AKEhTc1Z/yPNNXM3CtaXXEro//yxYw+8Qm5b5PjJwe7S/Is/mk+/rC4GcRZLksmbYco0Ul
	gkiQW4VDCLvAcubODEij+54mBzDqpabnPqPI6HhbQ09rYopPlSb3gBg37MNEXYGgfAFlaj
	aZKEpE5WMpOV9c0KOPyWa5OFZvKEj6UhtJYUf7cTZwVRsNRdeY9G2nFeRcTSg5fNmjWrj5
	/YZxJ6Wvh0MhRjN8mPGaqwF/CvpM7XJ8N4Ac+uJs9W7Q/K0UbX34EwNzc7iHvg==
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
Subject: [PATCH v2 1/1] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Sun, 17 May 2026 23:40:25 -0700
Message-ID: <20260518064025.96792-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260518063853.96384-1-lucid_duck@justthetip.ca>
References: <20260518063853.96384-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 17BFA566DC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,kernel.org,vger.kernel.org,gmail.com,justthetip.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36568-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,justthetip.ca:email,justthetip.ca:mid,justthetip.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 傅继晗 <fjhhz1997@gmail.com>

Commit d594cc6f2c58 ("wifi: mac80211: restore non-chanctx injection
behaviour") restored the monitor injection fallback for drivers using
chanctx emulation but explicitly deferred the harder case of drivers
that transitioned to real chanctx ops. mt76 falls in that category
and still drops every injected frame when monitor coexists with
another interface.

When the monitor has no chanctx of its own and exactly one chanctx is
in flight, fall back to that one. Otherwise refuse: picking
arbitrarily across multiple chanctxs would inject onto an unrelated
channel.

Reran the airgeddon evil-twin flow (hostapd AP + coexisting monitor
VIF on the same phy + aireplay-ng deauth from the monitor) against
this patch on mt7921e PCIe and mt7921u USB, across both 2.4 GHz and
5 GHz, and again on a Kali Linux VM with MT7921U USB-passthrough as
the closest match to the original reporter's setup. None of those
reproduced the hang reported against the earlier attempt at the same
fix (<20251216111909.25076-2-johannes@sipsolutions.net>) or against
v1 on lore in March 2026.

Cc: stable@vger.kernel.org # 6.9+
Reported-by: Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Link: https://github.com/morrownr/USB-WiFi/issues/682
Signed-off-by: 傅继晗 <fjhhz1997@gmail.com>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2402,6 +2402,10 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 		chandef = &chanctx_conf->def;
 	else if (local->emulate_chanctx)
 		chandef = &local->hw.conf.chandef;
+	else if (list_is_singular(&local->chanctx_list))
+		chandef = &list_first_entry(&local->chanctx_list,
+					    struct ieee80211_chanctx,
+					    list)->conf.def;
 	else
 		goto fail_rcu;
 
-- 
2.54.0


