Return-Path: <linux-wireless+bounces-33009-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKZlHdr1sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33009-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA426B286
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CB7F30A29B4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B03A3809;
	Wed, 11 Mar 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FxyZwAAf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCF3A1696
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270468; cv=none; b=p40kR1Vm8Y4iFMA/iuiHbXJoUOZ3dFx9NJtItblG9agaXXfTb2hzxxC4SC1C4ocog7HNnbCzMfPkwv9zY/L4f+1UAZnbN/oQ/4V8buNWwMCYaNd73LFlZBWiLl2fnFyufQYfSLSGqnBCQxNKIJbN68/EgwmW/ci5Mo+Aaek2oJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270468; c=relaxed/simple;
	bh=pcsIn6yyZH/7ML7oL/syusA/MfrUX8pHbDLisXHB4HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORsDsPKGtSDuvZvdsy6S1h1u8l2Epju1fAUB7hGgsHlbR+Tv1pnloMyZpP9ox9CE30B7y6jZT7nQVDTnPQXwwPnwENWaSAkWQKw2uXWxP3qgxPvcjtvJsNduDA3AGpTkGLNu6oFfxvhfOdONjwTOSTmp20wJ1gGVZuxrznSTEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FxyZwAAf; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BE4DD9C0059
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:40 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 884DD13C2B7;
	Wed, 11 Mar 2026 16:07:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 884DD13C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270457;
	bh=pcsIn6yyZH/7ML7oL/syusA/MfrUX8pHbDLisXHB4HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxyZwAAf1h56VgasQ9hVqk9hbm7R3qfVSQ8iz4PHZYsz0xh3IzYlLUDpC+kVRT71h
	 G0364dFhxgMQWbQy3UokVh+ZpiFBmMFkvfg89X4eN+oGlAZ7i+PljdNED2yt1PzNK/
	 nmKs7v1lWfHh60lnevatNzcJ1RVz8PAUQnVxAWg4=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 06/28] wifi: mac80211: Mark sta as uploaded if single transition succeeds.
Date: Wed, 11 Mar 2026 16:07:08 -0700
Message-ID: <20260311230730.163348-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
References: <20260311230730.163348-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270461-V7lLUNRNFiAI
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270461;V7lLUNRNFiAI;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33009-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15BA426B286
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

The hope is that this would allow cleanup code to run properly in
case this fails halfway through.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/sta_info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4259e9c13ed7..ad211c714dbb 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -836,18 +836,18 @@ static int sta_info_insert_drv_state(struct ieee80211_local *local,
 		err = drv_sta_state(local, sdata, sta, state, state + 1);
 		if (err)
 			break;
-	}
-
-	if (!err) {
 		/*
 		 * Drivers using legacy sta_add/sta_remove callbacks only
 		 * get uploaded set to true after sta_add is called.
+		 * We are at least somewhat added now.
 		 */
 		if (!local->ops->sta_add)
 			sta->uploaded = true;
-		return 0;
 	}
 
+	if (!err)
+		return 0;
+
 	if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		sdata_info(sdata,
 			   "failed to move IBSS STA %pM to state %d (%d) - keeping it anyway\n",
-- 
2.42.0


