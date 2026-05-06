Return-Path: <linux-wireless+bounces-36027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFZGBv9A+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:24:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873674DAE91
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769153080F0C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0954779A1;
	Wed,  6 May 2026 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="i/WHkyIk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A37472792
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073594; cv=none; b=iySUa1CmBlhM3r76YpCmwg+gxRCsbUtOiSQD+2wgsrH/E831+iYIfBsiWBgPrp35jhoTOtkXK/KAEoxieQNE+TnVkKO06e7J/9NAQKWkIY2ZQF3Yoh11K3gNYWwvzqSZU5KgUXLlCpvXQwgyzw3mKcVIqeJId/rCifJrK2cCWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073594; c=relaxed/simple;
	bh=YhHNqsg/tURdQNxFzMuH4ytP1oeHS4uyt0QZrhHvzJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cptwkWsp+hI9wbffChmTjVzFAr1ku3i4q+7PpMhVFVGV8gUsMEQMdwopsN4JrLNsLkvFyl0jfyoOGT9iQyX0MEoeVstR4VLCoJQnSeXxMNDxOjkKvuMJvCARx7xOWoeSjo4zMhUEBV1WeKt6I0ZJQb+DI6bfa7uuOX6koItUE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=i/WHkyIk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-835399c11e0so1690610b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778073590; x=1778678390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ssi6CVzQIVVUnPNmT1gr/sI4bY2x5eM4QCor84gRb8=;
        b=i/WHkyIkfQ2l73zLQpboTi000Maiotrt56zG+k00Aq+SILqfxNIKB08EiKV8F+VS8t
         U3PMsUSHH0AyFqT2fD8fJgVreJqGBaqyUabgRyBNi5d1ATDD3tAreGtXg3UEpQuHqZGP
         OM2aJbm48YlsCwPGulGbQplgHUy3J/QHYWERYRnHodETlafnyqusGcpD6uXB3WqguOix
         fwa4jwDiT7tvWRmVc4wlorZBR8rEHc2VwoFfKWWLPBNrhc/qNlPtm2N/mg2VBYUnVM4f
         gEQ1XW4xvwOb51513GlHpbZGOlc1OspAocMyT7tSaN+pj8nfEgPmzMu4w1EDBElCmz2f
         jEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073590; x=1778678390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ssi6CVzQIVVUnPNmT1gr/sI4bY2x5eM4QCor84gRb8=;
        b=iAlVJatWBACzPCjYg5iY4rRwGpU3XMpeGny0OX7zqLKxWgLErDr3V9h5aIGMF5g8V1
         14FSzj5HlU07diEuTs2+yYp3+lKgVqRy9gaVk5LaARD+uJAFmU/XgDyQ7sLauT6oahcF
         8rjAcEUt9+rxZpBRv0iL7jF/VpaXm1BVnYXnuY394pw3Klf8aIm2Ke2vbOCGfPaW5dhY
         95dOIW5XGtARp/tbtkKbXszOxRslI8Y2J5OnsY8oFD8+UqZ9FGaAe4vVFsPOsDcq5tWH
         f8mCpWpViozdR3Qe9LeZ178XLcp4dSDmefEWGxQHzjPZcccdz5bthNHYz7gTWBiVME+/
         ob+g==
X-Gm-Message-State: AOJu0Yz6ig+/2wiKtz0klQASkwNNR+xEUglsBflYpNmgQVdoDGI+n1yj
	Zlq5BckyU+Vi0UTTXgP9N194A7SqsxcmlkQhb5eVTxMcnPbKWAZGkh0Q82OowEso6qg=
X-Gm-Gg: AeBDiev7LENCOi6HbgPuqpEQuxQereOC4C0jymP8dBZYeVcU2tLj/CECDnKzAK4ShiP
	xMXYLBPWCxkLJUdTsp3tdSsOTQtx/zaK1nCiqPbGXSvIjceJLyraKI/0gJOlH/ttmPWU2AP/k+O
	WsI6HRbL21v3pGU5Sdh1B3F6/fDmUl5UGBfG1n8j+atxeQrGPCa0zXo8XB4katgxDdgitSXH8BO
	KYkQr0xhD678tmZHcyGcyxPZXAjwR64WsLzsO0k4lvG8xAk8/M2PsIJsrmD8Smc4lw1YRIFDQ5y
	LMaEOdFSNq4PWUmWdwvtOz2Dics9YHVa2SMrKgrsZEZx+t/wOGQSudsLQGImaDBU+9ioEXnIx3d
	ChDGWDy1QljyFTTbuBHTp8TjrlN0GuWFTqQmWh6msX9Yc5Yl7LouORRoDoTjqJNXZxNVmvTX2hD
	UKApZmhyEoLbQPQsbYZYFI+XJqfZdzz9NP13KAujY1731WKD5cFNhaEahK7Xo7M0vnEbX3M1drY
	DGsdya0KYfXNHqZ
X-Received: by 2002:a05:6a00:4655:b0:82f:21ee:270e with SMTP id d2e1a72fcca58-83a5dc60001mr3133227b3a.42.1778073590090;
        Wed, 06 May 2026 06:19:50 -0700 (PDT)
Received: from mma-H9MHD44.mymodem ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm5336035b3a.57.2026.05.06.06.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:19:49 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: don't recalc min def for S1G chan ctx
Date: Wed,  6 May 2026 23:19:25 +1000
Message-ID: <20260506131925.2088353-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506131925.2088353-1-lachlan.hodges@morsemicro.com>
References: <20260506131925.2088353-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 873674DAE91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36027-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

__ieee80211_recalc_chanctx_min_def() currently does not attempt
to find the min def for S1G widths, meaning the BW will never change.
However, the following call into ieee80211_chan_bw_change() will
lead to a WARN within ieee80211_chan_width_to_rx_bw(). Not only that,
this entire path is geared towards 20MHz based channels, so it doesn't
make sense anyway. For now, return early when calculating the mindef
for S1G channels.

Fixes: d879d4da4579 ("wifi: mac80211: clean up initial STA NSS/bandwidth handling")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/chan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b9d563f927da..c64a99131954 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -751,8 +751,14 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 				  struct ieee80211_link_data *rsvd_for,
 				  bool check_reserved)
 {
-	u32 changed = __ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
-							 check_reserved);
+	u32 changed;
+
+	/* No recalc for S1G chan ctx's */
+	if (cfg80211_chandef_is_s1g(&ctx->conf.def))
+		return;
+
+	changed = __ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
+						     check_reserved);
 
 	/* check is BW narrowed */
 	ieee80211_chan_bw_change(local, ctx, false, true);
-- 
2.43.0


