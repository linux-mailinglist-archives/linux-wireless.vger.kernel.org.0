Return-Path: <linux-wireless+bounces-32766-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLDXKFilrmkFHQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32766-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 11:47:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1F7237570
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43DA3072676
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836338BF8C;
	Mon,  9 Mar 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2k+OyIA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92663939B1
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053175; cv=none; b=Mg2TxTmFwpdZ2B4FD/f4qWheo4XWtqiRgfMJVS/EL1P/ZZzUFTLoMzNF4h3HP6uUy3ZVjpJHfRAEbTLnwtsUm1NC4WG2vblNq28fXoH0gw8HO935CF5AoUacBkV0PP8LsblUWJPo3gKtA8OwAOm6UJOPAGXowxoLfh0YfwuNcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053175; c=relaxed/simple;
	bh=o7zitKHdQAd9c2Tsyz3y+v+M/geb+4XgWhFo6cmTvJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMghyFpvziZCJnYseq8b+u3iaTJeFMoITPAstUBf+xaQ3EOhAPxsp5o4xI3XboWnowfhYWaW72FXOgWJBnZ+JQLra5STe9a4j6HcNzmUjm97pUpGoS0dfD+QfTeRYAS7k5QQA71qqJfW0bitxHQVGCL8uhQ//a7QHb8IbAIeZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2k+OyIA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7927261a3acso102472987b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053173; x=1773657973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZg1yY5ls1mtKKFKgOw9TLLgLzir1wngFNkwG/M8ZHo=;
        b=I2k+OyIAvNJbLV+mFqiAY5UfIw2E8zQjFIhuBGPQMlyYHx82YqZ4zJMsMpDuN9Z/R9
         y31CPectduwyrgAz6+diCJJK4/3dJqN0QyFcLzlDXsMl0wrcggWGa8gchNp7H8Gpqj5V
         wWidMjdcUjWw9Tfh2zBDsY5pIMyY5hh6Ki5UzD2yn+QSdQnI9ZT5yb+6Gt036qU5OLU9
         L3UO5GUxfFUJwHApT6cQNFhe2sLc2VquPK469w8b4d1e0r4ij4dlxfXALX4R+dAKi+qc
         b/MkXJWjACa+FAPdmR+O657ddiiUGYK+RrjutpG5i0sHGV8Jtp/jvckD14S6MaywS//9
         D7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053173; x=1773657973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZg1yY5ls1mtKKFKgOw9TLLgLzir1wngFNkwG/M8ZHo=;
        b=ViN0gjt4tG7BNvaYukyxcyuWzV+vykhFF+65FHUAuVk5Opa0VlTeHIYtU3d11AOtrD
         5Rf2ZXsvSReHWOIDePzYnbuixWuwl4QU2IKDa6hknLV9P1pLBNcZsthVZF1JM9uHXQWd
         mfTSDDnLAdDpO+VMAmLSMMqNBcbz6zWqV7qRloI92qQeSeKSfKgitUti9yAV3EeYpB3W
         xD6KDoUoW92GOznq0bbl6HIHpenNQfRgXeJlnLoLdczLvTCi8hjVwNSTJPaWmK1VOYSi
         mx0zZs0poNxitkppO94jGAEEwfGDVnFDFlHhRZlon1aoWb+/bfpwEPh66hymN9O6I8hL
         WePQ==
X-Gm-Message-State: AOJu0YxfQfCLXd9vTlxzC8so0VeO7PnWSOiwQq7Ctjs9f0Wh3AWyBDZp
	MFBzSrsKy6abslL2fTYGQ/eerFWLvebSfbL7phMruwTiyRECVFuf1Cn2
X-Gm-Gg: ATEYQzw9jx0VVDtDWza9rw9V65aWXlg5mkAh4w97yArdeo7C+ctElS8FLK/rAlqvsxs
	WDkGgc7lQn5xh9Mos5ehMxdTB0+YLRVm+/qOxPLBNWTF0lPOBEg/gSWtx00x87xwZgJ7NgOLaXQ
	0KWTOSnPgkLpXMh0C7kJLENrtjL59T35GlvOJ/c0nQd+WEppBYthFm44zIsF4jK57Ue6xLokJG8
	BvTuTkbhooMIy/rFB48nXYtDGl0SftURRSLN+UAQrV4MjuNbRsxtzdx8NOShjxJjoafIFq+gP49
	rgsZ1w/Tan9N/ORXFeQriLm7pPPwmyhq1sqiDhXHokAREg0N+geDDCau54+BHVIpJAEmaAbmPgN
	cfzbzBbkQZNg/t/OSCSaXMssS069DLe1lMeAdlv4t66ilcv6byZBMKaInhbRvbSDHdICmChsMoQ
	DrmtVmVF2P9SB9eAnny1Sh6A==
X-Received: by 2002:a05:690c:c52e:b0:794:cf56:5bc4 with SMTP id 00721157ae682-798dd7967acmr94008297b3.43.1773053173020;
        Mon, 09 Mar 2026 03:46:13 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76c0:3d0::26a:dc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dec8bba7sm44033197b3.2.2026.03.09.03.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:46:12 -0700 (PDT)
From: =?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	oscar.alfonso.diaz@gmail.com,
	=?UTF-8?q?=E5=82=85=E7=BB=A7=E6=99=97?= <fjhhz1997@gmail.com>
Subject: Re: [PATCH] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Mon,  9 Mar 2026 10:45:59 +0000
Message-ID: <20260309104559.22252-1-fjhhz1997@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8155c8f93c233e430c75c98bcdaea219b16e9596.camel@sipsolutions.net>
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C1F7237570
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32766-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fjhhz1997@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.951];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, 2026-03-08 at 16:45 +0000, 傅继晗 wrote:
> Fix this by falling back to the first entry in local->chanctx_list
> when the monitor vif has no chanctx and the driver uses real channel
> contexts. This is analogous to how ieee80211_hw_conf_chan() already
> uses the same pattern.

On Mon, 2026-03-09, Johannes Berg wrote:
> I did have pretty much the same attempt at a fix:
> https://lore.kernel.org/linux-wireless/20251216111909.25076-2-johannes@sipsolutions.net/
>
> but it was reported to cause crashes on certain devices, so we didn't
> think it was very safe at the time.
>
> Is that no longer an issue?

Hi Johannes,

Thanks for the quick review and for pointing me to your earlier v2
patch.

I see the key difference between our approaches: your v2 iterates
the chanctx_list and only proceeds when there is exactly one entry
(going to fail_rcu if more than one exists), while mine blindly takes
the first entry via list_first_entry_or_null(). Your approach is
clearly safer -- in a multi-chanctx scenario, there is no way to know
which channel the user intends to inject on, so refusing is the
correct behaviour.

I have tested my patch on an MT7921AU (mt76, USB) adapter across
v6.13, v6.19, and v7.0-rc2 with managed + monitor coexistence, and
have not observed any crashes. However, my testing was limited to a
single-chanctx scenario (one managed interface + one monitor
interface), so it does not rule out crashes in multi-chanctx
configurations.

Could you share some details about the crashes that were reported
with your v2? For example, which devices/drivers were affected and
what the crash signature looked like? That would help me understand
whether the issue was specific to multi-chanctx usage or something
more fundamental with accessing the chanctx_list in this code path.

If you agree, I would like to send a v2 that combines both approaches:
use list_first_entry_or_null() for simplicity, but add a
list_is_singular() guard so we only proceed when there is exactly one
chanctx -- matching the safety constraint from your v2:

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2399,10 +2399,24 @@
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
+		ctx = list_first_entry_or_null(&local->chanctx_list,
+					       struct ieee80211_chanctx,
+					       list);
+		if (ctx && list_is_singular(&local->chanctx_list))
+			chandef = &ctx->conf.def;
+		else
+			goto fail_rcu;
+	}

This avoids the ambiguity of picking an arbitrary chanctx in
multi-chanctx scenarios while still fixing the common single-chanctx
case (e.g. one managed + one monitor interface).

Alternatively, if you would prefer to revive your own patch, I am
happy to help test it on mt76 hardware.

Thanks,
Jihan

