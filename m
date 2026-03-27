Return-Path: <linux-wireless+bounces-34066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB33Do55xmnwKgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:35:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F892344425
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13353047530
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1022301;
	Fri, 27 Mar 2026 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlfYnuGV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595213C918
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614613; cv=none; b=KhMvzTt7hrr1e1t7GvOo5g/ZnAbPAU8YNmYNJAkrWJKt8qGue2rnDNyaGn3aAwjE5S/Ed+Hos31U6mjioNtycSaXVRQPktqeSOMSXiuC+b++K35WCwYtvfWp7xiin7dB7gPVZhvDYwKMJAhwFb6hppc/+ET2JDYcgCmtMj2xuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614613; c=relaxed/simple;
	bh=i/3kdVJVAfSV04QzJDFfmhiJONWZj2rQa3Q7sVnDl4E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l522iNgy+vkISK9z2JiBk6KOdZEXUrgx2TnVC20Nk7Y9jgEW+WC7nGSD/aVErt3LgsR6AWzh/Cst8KFfDMejY2plVh4MWEJ3Q764m26MPd/ebDkJjWYhkTtWWGsFZqZTHuk5RbRAxBS+z20ld5nCCHjkQLk31T+w15EkrVfYQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlfYnuGV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-486fcc05b20so14054995e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774614609; x=1775219409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kzs6brRuokL8MFn6Q0aOgw6+CROkqpQkMmoZ8t0dyos=;
        b=BlfYnuGV7aFpjiRNu7OtUo8v2GQ8i6mlnANsNVb5m26l5s5BfrAp2dQ07jog0tFzUi
         bvYbVlPPSJD75JKUVzYTNwHn3FCGNwooULk825Xgbyb9HSzkUPkZ/mShBr1xhHPrW0sY
         dUolzNsgkxCzRao0oNPZlmT5FjDWGw/gTZ8M8tCtrKVGXB84q1hDHmlTTl4GjLjL7+Gq
         EA1nJCEJMELjDwEcl6//9AFHu7SkUKIAMUl2Dcg+X9avRk0tdHSGN68F5eZZ6fkxmJuM
         0Hyk3XpdJCWFfNT/PZ5oeIfZ0BPJIlyq2mEJmDiVf9bmRtvOpUhENp4Teqr1ErFiLPbz
         CdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774614609; x=1775219409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kzs6brRuokL8MFn6Q0aOgw6+CROkqpQkMmoZ8t0dyos=;
        b=MWEtpoFQHlMOutJ01E+3uCvM0EBQNMexOoWwaA9mZNlJSHPj6TWBEAggZxsrn1eVl0
         PrdId8pgoE21UkkhZ3U5Yay9ic2W1g5vmfdH1Y0/f9+8h2b0Xm7YQAFTo0Kh7QEnHUrO
         iK+FgXhWCjt+CxzpRR5/q8aRiMzIq/Yt1ar2M7Ra5wFGAuZ8CEzbdIFZoKRTA+4ymOo3
         kFfhlL2w7VN/+kBjb9MuTkPIkJThSwztKoWoZrHCkxuy+YxTxo0YXKQDIamKwC46E9px
         j2TEKA9fZtBUOrxEcIwJCX2RIiAY0xedKM1+fpfeG4NWRYBSKUqSRbVEXIOLI7qXlEpu
         TheA==
X-Gm-Message-State: AOJu0Ywx8JC2Wq3RKUtJb+gR7j/58u3gAjlZR0uWiez7OPMtHV500Q4K
	aAZpG7TP2w619OG9+yQcN60Q1k0ikI5zPCoAstdzMyv8ljlQdjlIlveMM+W6om67hnESzIuSFbI
	F9S8/fXA0lVegNA==
X-Received: from wmon22.prod.google.com ([2002:a05:600c:4656:b0:485:29bb:91fc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4a5:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-487280a2507mr34925675e9.30.1774614608985;
 Fri, 27 Mar 2026 05:30:08 -0700 (PDT)
Date: Fri, 27 Mar 2026 12:30:07 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE54xmkC/x2MWwqAIBAArxL73YKpFXSV6MN0tYUoUehBdPekz
 xmYeSBTYsowVA8kOjjzvhVo6grsYrZAyK4wSCE7oWSPfK4UjL0x+IieL3Rtq0gpLWbtoWQxUdH /cpze9wOkvrzfYgAAAA==
X-Change-Id: 20260327-iwlegacy-gfp-fix-d553e3340b4f
X-Mailer: b4 0.14.3
Message-ID: <20260327-iwlegacy-gfp-fix-v1-1-b83e4db0bd66@google.com>
Subject: [PATCH] iwlegacy: 3945-mac: Fix GFP flags in allocation loop
From: Brendan Jackman <jackmanb@google.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34066-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:email]
X-Rspamd-Queue-Id: 6F892344425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Do not latch these flags, they should be re-evaluated for each
iteration of the loop.

Concretely, rxq->free_count is incremented during the loop so the
__GFP_NOWARN decision may be stale. There may be other reasons to
require the re-evaluation too.

Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://lore.kernel.org/all/20260327115739.GB16800@wp.pl/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Transparency note: I am 100% taking Stanislaw's word for this. The bug
being fixed here hasn't been reproduced and I don't have a way to test
this patch at all. It does seem to make sense to me though and, well,
Stanislaw is the mantainer :)
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index c148654aa9533..e8ae6687c08ec 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -979,9 +979,10 @@ il3945_rx_allocate(struct il_priv *il, gfp_t priority)
 	struct page *page;
 	dma_addr_t page_dma;
 	unsigned long flags;
-	gfp_t gfp_mask = priority;
 
 	while (1) {
+		gfp_t gfp_mask = priority;
+
 		spin_lock_irqsave(&rxq->lock, flags);
 		if (list_empty(&rxq->rx_used)) {
 			spin_unlock_irqrestore(&rxq->lock, flags);

---
base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
change-id: 20260327-iwlegacy-gfp-fix-d553e3340b4f

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


