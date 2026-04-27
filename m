Return-Path: <linux-wireless+bounces-35426-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E5pLK7i72kHHQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35426-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 00:26:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBC47B6BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F943012C40
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA1346AFD;
	Mon, 27 Apr 2026 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdWV3Icl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FD3191C8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328786; cv=pass; b=ShVOVRpNx9jGpAQeoYeuDLIgmknHEbgkjwqLEgNfoPUdRD8HEOb860gkBZz9p0+cCBGgtm29ri9vutgYucKxrZ4aVh+2nUCNDKMVqVIxO5t+7lKsimK3dg5MKjq0TEevIp6ihdnEbAuvc0C/YmJbK55y0rLyo4Kg3JyvzdDR3n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328786; c=relaxed/simple;
	bh=S3qyMlpHJTCVyK0JtEuGGG3MueDOMcf3irmOYzvUmRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5fXIGMYsdPIdKh1RjpSRjpeF1igcWgk7pto/wh7UQr3SXCQSQFG0ZCX64nEYx6hy3iGUkyLZK2KAoS+UJT4iL78jazDoxBtQl4QKgSoRLt4X1UXowC+DXibpp0a+feUGFoGo8kwpqwe6MaSCSsbnzXLUSFUu/IUQGVfwzpAqPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdWV3Icl; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-479932ccb9bso3095820b6e.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 15:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777328784; cv=none;
        d=google.com; s=arc-20240605;
        b=M0rqdPhZWR1SM5ysZax64ygY9LCuvE83U7DF/QsoCts9AskK0GIWjduUPk9X5+GUnW
         rfijZUROOwhY1dgzOHwbZqY7VaGaqa1t9K1ijXpiatxJN4Q110960DKdPG7M0FpjC1WI
         r7hNBWWSn3WKF4FWUPIuRxLsdmR/2F0Fo2FXFFyFmH4vwNJ1mH/oeZw3PdTE2EsBcr9a
         1PycHA7VoE3XenqhL3ldaZ+j3/9KZXiYSpDBfYDZL8peKV/1Oe3HuGOaSMRAmX5gCfJE
         KTLLg5AOynvAQYpNrhcZsA0tINYPbitvwaB1qImsh8RIp4QwkfUh7mMDoh3QOq/QrO3z
         kN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S3qyMlpHJTCVyK0JtEuGGG3MueDOMcf3irmOYzvUmRA=;
        fh=07pzEypc6GPJgNsuOsSqxN5YVnjHU8ATikuS2SndVEM=;
        b=RUCokLNmsX7Bi4V6pvoCwlJe3KkEpsPCwKFD6mhgA+RcHCouKUUKs50Hi5SZnuwp61
         xKo2sI0T9vQvGs0zrpQUJvgTNiGKrMzvRbDwuZWppRJJPFeA9suMGmgeOkeM04JWlWdz
         6yCOzC+NrwPjMdO4xpqKPNb9bXq0KsSXwnyOS+wJULYYRlsuA1AMPlAn7fPUd2RBWsle
         1lCq3lF/y9uZNaZkdyh56z+c/TagQQVW3H6ZTWV15FkQXuUIQuiNRTMuGJJk9/lW7m98
         TJ4nstUdl9uvoEODfbYjYiD5VyETjhQdbX68vcp1ZF4KPUDyEkC60YW5YcAOsYroOyLp
         9DkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777328784; x=1777933584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3qyMlpHJTCVyK0JtEuGGG3MueDOMcf3irmOYzvUmRA=;
        b=gdWV3IclgJzDALruIwMe7wSZOQwCGwL3rZMbjbec1CuCJxsohMZ9SZYROsj9aRIbOg
         tA1sEBdDiPO65eJR7FkHgSU4J1PIXK6mWFSzLk9y6WqHKcQ30R7htBOJCHDxwV47mMYT
         CAwGYdlNlepmA54vRjsLDHq9OS5Ji1qvZJZcow37cSS2SSX87pRgOmrMFlLjg7TvaHKy
         EtmFEPnl287hXYlPh6EJtUTcud8DOVKdsH6T40xVOdd6yYyysRb+Kvh1sjrpLBVRJCuO
         ftfZgmFJa0bHOxOzoTE+hqFC/jN7yS235uYuye/L41ssBrh1L3YCaRXvKEg8aoUYhxeM
         xd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777328784; x=1777933584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3qyMlpHJTCVyK0JtEuGGG3MueDOMcf3irmOYzvUmRA=;
        b=ZoKvGkEYNIVR4jPMID4XLsNr9RVUynnpaNrZ+50QAeYZxWU6xZnuj5usaQPaTAByU1
         zKc/fVv7mgols14F46To+fL+ykZN7cmMWLR6uT1sL/IBLCRUWEmxO1QVVbxndtse7RhT
         tA9tBkLEK5pme9z6ojCxpSwsUYTUaKxO+qPDGYuFSH0LXMBOTOkN80VjF72OyfXf5Zhn
         8TaZ0FFca4zJjOC5Mm340z3kqYf0h3bCXIkZpsNpHHksuyzMKwatghRuOtjFNjeZgv5b
         /a/kD4ReLEHsG6t6sP3HQk0ujZmy8x0KFTLjL9uaM2LDxmOWfRqrq4YCrenj/ehJNlh6
         8lSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qSXGU3LgUUSxu4HBAQLK2bt74Pz2rET0Y+BbncYEK9kUQ0HDMKubaZ9Cp7CrCBUycIOFSQ2F8N54AoGNGqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9V1TIBqC51Mx/5jqDh1ebHp0WIi/1YNNAFWiHXArEuOgt+TN
	bN+HRHROeHx+pxSkEAtJTkCV/6HI3ZyQB5Eluwcy0MdaIki6vn0eyI0XLRlbma6c871J4ZKO/qI
	PIRwsnQ9y+ETeBs2Ps77CV+O3SJJoDnDQ6k5MVJC7Sg==
X-Gm-Gg: AeBDievGB+otF778wB/eBzEyje1s0cA2c/pWTbJkCOxaZyTFp2ShUPu/lmbhUTjG8OO
	TMTPKx9afxUFVcb1S/X+MfbCfhyjekIWrsLTcB4DY5QVi2V32wjKSLtacm+tG5HZdZxdFUVlaLw
	TSjK1lRW7dKYVMIpHI6c0iEVa546LnAzEwEYhDxchgxrD6VY33yPojxI2fmASV8vi8SgqFnbdKG
	VOwJ3GB/IPFnXvFkj77GulMR8/g5sxPbQks5dG24cCLl/grqubvfdC17L/vxLBU9G+/VlB38UCL
	AZBf5IYuu6Ujmel6J9E=
X-Received: by 2002:a05:6808:660f:b0:479:e9d2:26a3 with SMTP id
 5614622812f47-47c28ee99d7mr409041b6e.19.1777328784090; Mon, 27 Apr 2026
 15:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com> <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
 <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
 <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
 <CALdGYqRK+a7-7WEXgp1H-w-1AaQhhbTW9FTWtpmfGN_yXuDGSQ@mail.gmail.com>
 <4f40d96c-4cd5-4e01-846b-745e346b6744@gmail.com> <CALdGYqSAr9kgFQw5=fht1N4Tn3JEZwro8f+JveDGMU3VVYNvzg@mail.gmail.com>
In-Reply-To: <CALdGYqSAr9kgFQw5=fht1N4Tn3JEZwro8f+JveDGMU3VVYNvzg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Tue, 28 Apr 2026 01:25:46 +0300
X-Gm-Features: AVHnY4KgYqypD5yGuqjEDtk2RmC5YG3QXPDqbyxjPyfxc2sO2hvKWZO6kzuSjOI
Message-ID: <CALdGYqTRqWO_3aZewGKix=PWROnXXdYiLYS00faBKymhEKcC-w@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 11FBC47B6BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35426-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Bitterblue,

While looking through the driver code and my recent logs, I tried to
do a bit of amateur analysis. I noticed a small detail in the RX
validation path that I wanted to share, just as some food for thought
for the future.

In `rx.c:rtw_rx_query_rx_desc()`, if `pkt_stat->phy_status` is set,
the code calls `rtwdev->chip->ops->query_phy_status(...)` (which maps
to `rtw8821c.c:query_phy_status()` for my chip).

I saw that if the PHY status page is invalid (like the page 10 in my
previous log at 02:59), `query_phy_status()` prints the "unused phy
status page" warning and returns early. However, because it returns
`void`, it seems the caller (`rtw_rx_query_rx_desc`) just continues,
calls `rtw_rx_fill_rx_status`, and returns `0` (success).

To my untrained eye, it looks like this allows a frame with an invalid
PHY status page to still get passed up to mac80211.

I was wondering if it might make sense in the future to change the
`query_phy_status` callback to return an `int` (like `-EINVAL`), so
`rtw_rx_query_rx_desc` could drop these malformed frames before they
reach mac80211.

Of course, I might be completely misunderstanding the architecture
here! I also realize this would mean touching the `ops` struct for all
chipsets, which is a big change. Please treat this just as a humble
observation from a user. I leave it entirely to professionals like you
and Ping-Ke Shih to decide if something like this is actually needed
or correct.

As I mentioned before, the current patches are already doing a
fantastic job preventing the system freezes, and the laptop works
great.

Best regards,
Oleksandr Havrylov

