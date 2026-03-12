Return-Path: <linux-wireless+bounces-33137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL5NAAnysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FE2764E9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 805BC3065008
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCB3FCB24;
	Thu, 12 Mar 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FttCu2Vx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FD3FBEA0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334868; cv=none; b=B0L1DnZUHNIR9qZzlY3fjtXf2ZxkvUSJE2lAb1/54028vT+7kPPANXNh7yOfD/vy1bhTBGevVssWt68a/dWpSsb2xfaAaWI/7I8IfJB5vO1aBoToUT80kMsiQQxjJUsS5PYDH0i44ZO17kEDUZBetlFl1j+g4XvM0EdD02zbiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334868; c=relaxed/simple;
	bh=mi/nNh7zbAOlpgZ51NfdYcrHH2ZIlXOTxw3bthgh4QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzX4wNM0RSN5a/EBkDexpmlUlOyt9hmkwXV2Gw8FRE17asLYkGwk4buB2sheoQikDKMf4+okZHJ0uFaCtoxZVPel7lzoaNTXJA70yWlU4iOTG/M7UQCr30PaKWKFMeQlwLbZ4qPwTgKw5XvXif3HA9hM+IOjD1Nzp5rZN/XOPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FttCu2Vx; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 53AF294008E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id ED60B13C2BA;
	Thu, 12 Mar 2026 10:00:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ED60B13C2BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334860;
	bh=mi/nNh7zbAOlpgZ51NfdYcrHH2ZIlXOTxw3bthgh4QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FttCu2VxdvAZbhbh5puYbfvEW28RFUFRXGK5OMxZzSDVF5LKG4qKWE6VHWrISM7HO
	 cNyk0WpR21jt9TA9BejSpzTxA+8fT0ZhwKrb74zWWPYHalLU1+0FKNai7JlAfW+lxI
	 IjNSifTLhAIf3pYsGi36LmfOJVhJG/mb2oJogxDA=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 09/28] wifi: mac80211: Use warn-on-once in drv_remove_chanctxt
Date: Thu, 12 Mar 2026 10:00:07 -0700
Message-ID: <20260312170026.285494-10-greearb@candelatech.com>
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
X-MDID: 1773334864-mqtMpBckX-QQ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334864;mqtMpBckX-QQ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33137-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: D32FE2764E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

But still log it to dmesg.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/driver-ops.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 51bf3c7822a7..e2283d7dcd1e 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1035,8 +1035,10 @@ static inline void drv_remove_chanctx(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (WARN_ON(!ctx->driver_present))
+	if (WARN_ON_ONCE(!ctx->driver_present)) {
+		pr_err("drv-remove-chanctx, NOT driver_present, not sending request to driver.");
 		return;
+	}
 
 	trace_drv_remove_chanctx(local, ctx);
 	if (local->ops->remove_chanctx)
-- 
2.42.0


