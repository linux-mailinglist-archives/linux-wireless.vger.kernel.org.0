Return-Path: <linux-wireless+bounces-33125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAgxGuvxsmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:03:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F217B276498
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9259D3056520
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C633FB7FA;
	Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="hlX92GFU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB035396B85
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334865; cv=none; b=eH4bOk03+2/UhUZqSuDVrgJ656tnU0DJ+OMqhG6mOMASnE1QiNArZ4m6TEWS7sd9q2hSAUebF6p2EQqoGDBSwKHTDtI2A8AnbXJCFhySSpsV075iFgrFm3sAm7etAamSwHMWw0u7FyU8mp8r0eX6lq/+ZBcLfJpDmI2TtIdqW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334865; c=relaxed/simple;
	bh=pcsIn6yyZH/7ML7oL/syusA/MfrUX8pHbDLisXHB4HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTcW0Z/BHqGRjSYnKIC6E+jmnOYQKS1uLNLCnF6dsCizbS9CuLhEG7Fe8KOjEFu5UsNLsKYU7tRaX9BXPswVmtvs3IR9de5VJIFm2esD4/Mo1fUGF+hB5fK9RCgJCUgYRPO7ctoTP7Nlrucu9Aw3mshg2ev+/hnUoLc9ZP7iL5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=hlX92GFU; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 11C3580075
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 3D14D13C2B7;
	Thu, 12 Mar 2026 10:00:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3D14D13C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334859;
	bh=pcsIn6yyZH/7ML7oL/syusA/MfrUX8pHbDLisXHB4HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlX92GFUYi/LudARAA3bPNy9V8HrULX4OQlM4DLyuPMunNZWCAj/2cePUH1DKC8ml
	 91t9gLdZ1jOPyVFMnxMxUeXo5wZY2qk3qmGR1UvfoFUpC4AMZ4eOHlhaBPuG/Eb7r1
	 lyBa5DWwAgvgyNtnnvST7XmFvRl50mS5lCT5SGXI=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 06/28] wifi: mac80211: Mark sta as uploaded if single transition succeeds.
Date: Thu, 12 Mar 2026 10:00:04 -0700
Message-ID: <20260312170026.285494-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260312170026.285494-1-greearb@candelatech.com>
References: <20260312170026.285494-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334862-jlLiu8N9XtQQ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334862;jlLiu8N9XtQQ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33125-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: F217B276498
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


