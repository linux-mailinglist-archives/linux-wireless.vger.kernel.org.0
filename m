Return-Path: <linux-wireless+bounces-33127-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMcfGfDxsmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33127-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:03:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1527649F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0A6F305BCB7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2A3FBEBA;
	Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="EQg9Ga9q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84D3976B0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334865; cv=none; b=GDJTEaq1uxklE/ws4+AKGauapHJiXBDeeOCTpcxglw+UdzstBFpBUJvWsQ1hKSOCEZpKuLcA3qXlEl4as0eJnKDMQLk7xxhM1dc81NhmRtiK7jN+9AGSrsMKzC3f74+Jf3MzL1norAS1ymX+ULQcLBCGk92BtXdeHcNQ1J6eRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334865; c=relaxed/simple;
	bh=vwY/GGcAms18Dpnp9HGaFOyKVZsyjFJJqlMhBQq18Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI9n3tCCB/GJE/mSTzNk/h7ApPLHI+iRAtjTLkGKlpyPbRcd6uRV1DhI7p5CRs09VcDHMiX6kZn7/wX05C8yzaUQRGYoD7Rlvv/zIIvXKvda1oOWEZGEGe8A01jHjZuCOKvrHa80tSnhpAa6nxOIOzUJPeQe5nujk4IUbBJPvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=EQg9Ga9q; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EDCAE34006E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 05EAF13C2B6;
	Thu, 12 Mar 2026 10:00:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 05EAF13C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334859;
	bh=vwY/GGcAms18Dpnp9HGaFOyKVZsyjFJJqlMhBQq18Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQg9Ga9q8KaReodFdV6ajqt532CBOwGVYA77erBOJKKvRkH4cienHIGrcQtrXffoo
	 uI4+/GvAHVtcb+90WyZDTf7SjGS44GfJFn2/0/hx7aqWKw+taPrmUsl5880zgHtQrb
	 FjyIGcuwBg3esun+x8sx6Q5pBoI9ZoYic/f38RS8=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 05/28] wifi: mac80211: do not fail taking sta to lower state.
Date: Thu, 12 Mar 2026 10:00:03 -0700
Message-ID: <20260312170026.285494-6-greearb@candelatech.com>
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
X-MDID: 1773334862-D8WXQdRmzEFn
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334862;D8WXQdRmzEFn;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33127-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 01E1527649F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

If sdata-in-driver-check fails, then we assume STA is definitely
not in the driver, and so going to less connected states should not
fail.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/driver-ops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 49753b73aba2..59998d0af3ff 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -143,8 +143,12 @@ int drv_sta_state(struct ieee80211_local *local,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata = get_bss_sdata(sdata);
-	if (!check_sdata_in_driver(sdata))
+	if (!check_sdata_in_driver(sdata)) {
+		/* Going down should not fail in this case. */
+		if (new_state < old_state)
+			return 0;
 		return -EIO;
+	}
 
 	trace_drv_sta_state(local, sdata, &sta->sta, old_state, new_state);
 	if (local->ops->sta_state) {
-- 
2.42.0


