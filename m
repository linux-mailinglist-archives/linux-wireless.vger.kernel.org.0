Return-Path: <linux-wireless+bounces-36009-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KOhFrQ4+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36009-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 14:48:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BC4DA7BC
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D8EF3034643
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF644D696;
	Wed,  6 May 2026 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="kUnNmCli"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B9305E32
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071403; cv=none; b=C+IFBe7UJlSTj1gEl+kSsNhbzJa/Qkq+GNH7Qu2T+sj/1njV6QApMHo932vBwFs71zbVQjbMBsq1FMmCYk02/w7V2jW4KghqE2LZv8LuptsksSTAyKDV227dPVeyA3l333gPH6MFuQ/hX1Mhdejdy4nzqX3R35WcoZ4gI/oTE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071403; c=relaxed/simple;
	bh=YhHNqsg/tURdQNxFzMuH4ytP1oeHS4uyt0QZrhHvzJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8Q3FdNLtfnqle4uqyBRx52iYKh1Mkov/6ad/fe015+tBTiHteRPCkoUMFMLCn/5/ibn7xl+DuGszViVBDunptvkOkf3PH9DPnypjQRBPhjGmv7hHYzJBDcWGx7FK3mHxjr/C52ab1J0Ewp31WZAge5kmSkdXDH2svcS5UH8Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=kUnNmCli; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-364ff382b0bso5288656a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1778071402; x=1778676202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ssi6CVzQIVVUnPNmT1gr/sI4bY2x5eM4QCor84gRb8=;
        b=kUnNmCliaUkGoFP5C48WfysWXVHSrNYGEHq3eJpBezac5FUALf0bEyRekYWTaIrRNL
         QiG5AmAXglhMS2CzZ5Z12fp83XSUHY1VzsB4WEU1iZgKQeGv4e/6kuxlsIIhWDorcMSQ
         zmwfkSxv2SRhCtI3bWJNQWuDxgkMhFnYuL+5KjNKJhRMyG4hmYcwt//npsTobMRNP7OS
         3rPv/W6YcMilCVTmLn4X4lQGg1uKnI3L79hhtqqhY1DR5x2EWxeAt+HkzlHO+8u1u+ts
         vqhPCt3sWFmmEetRzs/S+P4OABBAur479Cez9trfLk1nlszUoPcZPQdcr06anr/O9t2M
         L+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071402; x=1778676202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ssi6CVzQIVVUnPNmT1gr/sI4bY2x5eM4QCor84gRb8=;
        b=r6YiIk2XZ5ibXzgVtOJmrlZ52lYZFFDqxA4Jds64obASbAbpY3J+UHFr70vtTfCC0P
         v9SFIhljTn7cN3jLVl6aZTvwU66drFOgWVRfOx9kZPqjysV0usMNwqi2C+94Hf5uieRt
         StvQSCJYUH/Pq63fbMg9k4JhcflXijYhTiaifQ/CUow7BcyKFs1UBSQVuB+AMoDobwVL
         Y7ffoiryBcWZUnzRHHABYoaFi0Dmj2RMPkobMCyFPqXN0NWOKGiki015EGgQN7dUTzOv
         ylXflJhzVgyuI/ygwjJxGsNcM7fKB6bXD8VUDN+8/SW/2PHT3KmyEa9B1QCwd6EMwOew
         1LZg==
X-Gm-Message-State: AOJu0YxiomjAc1Bu3bQd5QzNxSoDDV+t3h4SeLjAsmFnIbveU6NHM47S
	jF3Xib24KRsguvO7j07x22Nwvqbg0AxX/HoLDAWmp9QvE3J4QiLu85yPaJPk+VZiWbtZ2e/x7JD
	XSa0o
X-Gm-Gg: AeBDieuMhBVS0P9brnUn+Ykz3a/4Tsky8rNRgwDr+u+gDqYvs2t5OfOMi4qhKakZh6Z
	M7BEuYQXziG5g+vkgTPM8du9eCWBssfsA22VXY0Mi57za9Rr9bRnk/ERFMkWARC0RsesjO3RE5Y
	jtcMggp6z6EYT/e2IXtRt2EPRYlVwbN3H4HF7zHt5Fb5vtL8EL6IXA960BVYt29WS438OZCKcs6
	TxMTRJNwjW0PN6YIoY6jLLoMAy9Xzki7pYgxI3i/ElBNRGI3Sv3boDQq3pNg9UNgpAFEEm0SB6T
	636JUqj5DRplYqyERn7pkGJJXyUds8l+VxfOLBtFChtbkYmCKmzQb6AujvJj4nb49pbDpB3W8QC
	WorlFjWNHoxZJTrx5fMBmqXhA0HFq6cM2CVb2F/A1mJ/zCZ9sPls9igjaGk9NHxMS4V01Qiff4P
	ieZB6vmVqFemQFROUfyTMA4fPdYZYtoIXqiiZRBiAYpGxf9BNzuW/QAU/A3iAlsHfJV9mkipAuP
	XyLSft1JHs=
X-Received: by 2002:a17:903:4304:b0:2b2:6b58:9317 with SMTP id d9443c01a7336-2ba799d6c69mr19568775ad.39.1778071402003;
        Wed, 06 May 2026 05:43:22 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca244cfsm25172405ad.71.2026.05.06.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:43:21 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless 2/2] wifi: mac80211: don't recalc min def for S1G chan ctx
Date: Wed,  6 May 2026 22:43:07 +1000
Message-ID: <20260506124307.2070157-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506124307.2070157-1-lachlan.hodges@morsemicro.com>
References: <20260506124307.2070157-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC5BC4DA7BC
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
	TAGGED_FROM(0.00)[bounces-36009-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]

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


