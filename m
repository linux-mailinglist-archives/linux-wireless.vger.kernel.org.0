Return-Path: <linux-wireless+bounces-35344-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOt5MoQw72kM9gAAu9opvQ
	(envelope-from <linux-wireless+bounces-35344-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:46:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7C4701CA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3FF0303181A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C73B2FF4;
	Mon, 27 Apr 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5kYFP3v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D833B27C3
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282977; cv=none; b=EwYKd1Fb1uKava09gL+0URsLqJAyergTtaItkFUdnocWh2+8ReSdIS6S5Pfu/WwHpgwC5g15SDvjTf37B1cDIGvAiwk7vwGdcdIa67RvKWzhV9/lQr/8q+ba4WWfCcqnn0uGExm1t2aD5iHQt2Fm4fmSUzIRFZqxA11BqXe1rSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282977; c=relaxed/simple;
	bh=1edNpC1S3o1g8pijgXBuglaFSA/F3emKEDJN0MbLjX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZZ2B2FjotlE5t/XaiwlmJibqMJv8tWt6hqTs7H1zhC9W3KQ2UOguC5wp2fEGBAwOnRpOd2z8+6CuiwRLKhvIoreXilFxVZTuUp4yJFc0dR+jG0j1O5vhMWKHvXDz16OvrDiAYAOStkgZRFNwBrp2rUxWKINp/5FpIxKqsqooSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5kYFP3v; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so5538224f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282975; x=1777887775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOSv4lT2swKkfFsu6N1e/4a2DMIWqM0T1MQJCs7ue+I=;
        b=p5kYFP3vdy0eLJt3Atr16/wsoN+QPC1oDEvDBq8lVmTQIibc7A7FKjTVGZoyWU3BdI
         FgUUz2XxmGtxDPwXkvs+TS4mWllYNGhdMkaGZ9yvimW0WJ0/UnhQHLNQ+ZJdpg3HrAGA
         4kvBJI6I49f4fjO/RH086B7G5faL/9zf9XbUB8+EfV9lfMD294S41vuEf9zQU0WDtE94
         cMiQdS2JCJ6U8zN81GxJCR8Hv/VqfAeSFATws9j97QsxD99t2tD9Zm4xIbIjxz51KhnE
         E4d6ixveIZ+D2sLN8EjGk0a/x0j2OaWGxMt0jYj023Ud53HtiAhkD5PbNxWNJAzMQFUu
         Ngbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282975; x=1777887775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOSv4lT2swKkfFsu6N1e/4a2DMIWqM0T1MQJCs7ue+I=;
        b=e4uavY88oPhogjhwWE6X4o5cZfSy8LblMy1NYyR/AqFSctDbAYVERFprRttJ3zwtjW
         0BwYnw1JAzxnSHyHIsvbMd6sIK7hy5efewskTJx3NeWV6Dr3BWgPKO6h3qy5SuPVs5h4
         4NP61Up5ZL91yaBxIM2/YSn2hTDKO5TZ2gxgm2oaRBiyf2O9pTkw1uIjHKOmYNhCNrYO
         8IVY9SNfMFUROIwxWnNdWlNBG25C/3PWNhhw44n9KvvZwHnyTQvKYEbNBUjk3i/lO+Hr
         u6Yj8crzU3KCAkL6G0tcCx1CEM3LzuWfN/2+XFvq0pBeOXjtPiNbowrX85Hw9uAC0z+7
         LyTw==
X-Forwarded-Encrypted: i=1; AFNElJ+6daKIAF285JtGUMVbe+uZnbnFlCOZLiN4BOEaITvqoiqVglavihpiToMksWalHI9J6NI1FTo5ildsqJxw/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRREhAMPbAs15PVy6rHtuKHhHO2ArMpzRiTaNqUoX+vG25NzQ
	mvsuGR4ZpZDpmvK3T6+i2Lv3imoIh8XFXW/kO3Uu0Buo2dmaE0nYyYeO
X-Gm-Gg: AeBDiest++54fBEueFgm4uPXuHkL8eXXLAERPyl9ZcZdunZJeh6vRYQK1bFdDgK/k+B
	PAVx0HfJIt9nI18yOKZIAD2Dix+XGBIwEuAdxVxHdLDHYjtiE8mRdFkn1Pwtuy8s6ZE7WG8vRzY
	sSz70GM+GMJfpOxaWj4XKjJ2uBVQdSuh2OUQuD7zN94lAdu7jRAgnHo7lO4nWJY8hiXBiS1l3Ye
	b1xxRqb/YuSCf17yPS09yllwYPyGYvTpKQGkIDWqP8Qme3cKqCkyh9MBIm4zWiH7kp+TCqAq02F
	+TuLv3cJkWe8ZrdK5rSmUhJtPqVQf66dE2KnkOXMinjilfPx+47OSe9QmS0J5VPAL9bElUwBZGD
	M7wQS16WxlTtmWliC/A+utR5KPihLgVYlJ4xL7HkrmphZQPzakEfru2neaVnnHpES4x8dH+PqV0
	JHRMal87XJFs12GOMcSuTNL0sj4PP1p4moNXi9Ej3RFyAQMnLjorg7STrM7hqlnIjiuDmgPEVuK
	uQ=
X-Received: by 2002:a05:6000:250f:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-43fe3dd397dmr66949426f8f.21.1777282974651;
        Mon, 27 Apr 2026 02:42:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm48891743f8f.1.2026.04.27.02.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:42:54 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:42:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Yury Norov <ynorov@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin\"   <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra   <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>, David Lechner   <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy  Shevchenko  <andy@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Richard  Cochran  <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,  "@web.codeaurora.org,
	David@web.codeaurora.org, S.Miller@web.codeaurora.org,
	" <davem@davemloft.net>, Eric Dumazet  <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni  <pabeni@redhat.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,  Yury Norov  <yury.norov@gmail.com>, Rasmus Villemoes  <linux@rasmusvillemoes.dk>, Hans de Goede <hansg@kernel.org>, Linus Walleij  <linusw@kernel.org>, Sakari Ailus  <sakari.ailus@linux.intel.com>, Salah  Triki <salah.triki@gmail.com>, Achim Gratz <Achim.Gratz@stromeko.de>, Ben  Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,  linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,  netdev@vger.kernel.org, linux-rtc@vger.kernel.org"@web.codeaurora.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260427104252.5203a50e@pumpkin>
In-Reply-To: <dc1b12e74b3f487eb531bf7def806f10d9a18b5e.camel@sipsolutions.net>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
	<6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
	<aeub59FBHbCy-KKP@yury>
	<dc1b12e74b3f487eb531bf7def806f10d9a18b5e.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2DC7C4701CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[gmail.com:s=20251104];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35344-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 10:29:21 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Fri, 2026-04-24 at 12:35 -0400, Yury Norov wrote:
> > > I (personally) tend to prefer the "__MAKE_OP" versions (*_get_bits()
> > > etc.), in particular because WiFi and firmware interfaces deal a lot
> > > with fixed endian fields.  
> > 
> > I don't like that __MAKE_OP magic because whatever it generates is not
> > greppable. And because we disable strict type checks for kernel, but
> > this API claims to typecheck the parameters for the user. So, the
> > following compiles well:
> > 
> >         u64 val = 0;
> >         ret = le16_get_bits(val, GENMASK(15, 10));
> > 
> > I don't like autogeneration in general. We generate, for example,
> > be32_get_bits(), but never use it.  
> 
> That's a lot of "I don't like", but whatever.
> 
> 
> > We don't even know the level of the bloat.  
> 
> These are static inlines so there's no binary cost, and given that
> you're complaining about them being generated you can't really *also*
> complain about too much code...

There is a measurable compile-time cost for processing the definitions
of static inlines even when they aren't used.
While processing the definitions of #defines is cheap, processing the
expansions can be measurable. Particularly when expansions get nested
as often happens when GENMASK() is used as an argument to FIELD_xxx().

Even trivial #defines can affect compile times.
The 'size' check in READ_ONCE() (etc) costs about 1%.
(1% may not sound much, but find 10 of them and it becomes significant.)
I suspect a lot of that is adding the extra external function to hold
the error message.

	David

>  
> > > Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> > > be especially useful for le32_get_bits_signed() for example, to have the
> > > endian conversion built-in unlike FIELD_GET_SIGNED().  
> > 
> > Maybe this:
> > 
> >         FIELD_GET_SIGNED(mask, le32_to_cpu(reg))  
> 
> Awful. "I don't like". But we rarely deal with bit-packed signed values
> anyway.
> 
> johannes
> 


