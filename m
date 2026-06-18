Return-Path: <linux-wireless+bounces-37904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BPQ3FQ1lNGqlWwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:37:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC556A2C85
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 23:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rhOEY0O7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37904-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37904-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC19D3029AFB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B023254A5;
	Thu, 18 Jun 2026 21:36:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AA3101BC
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 21:36:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818618; cv=none; b=SfKBHPpgbnLDbIB2r6MR9PIbhOXkkoWN9QYFWyG4zbO7HgU9Xwk5uGtIoxbjEkcDDDv5VtBwL8QNywvz1dslhEqAJAFm1WmNwmoPMd09wR5k3rmaUWGdA90vAWgeEIR8PEcw2BMA/xVt0gHWbz/LmgAGz5o+VsngqFHzWBDisg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818618; c=relaxed/simple;
	bh=EYjP31/qXaZiOklDzkuCs/LFZj34JkJlNtH9t3PgL5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/MQM3dd2P3g3BHDRMXxOY+gMI8L/XeD3sLi9GvXYR4LBx9qCepcIPGHuSplFrtd1YuQ7zLEruVxxXTrKScfUc5ITzPp49NBCK9jok/04lWSRSeEMFCWJ36o9cJS9szHQlXIgDlVGrisZ2XSFVrrwxfrtBQlZuxzSD6QXFzyHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhOEY0O7; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso9789795e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781818616; x=1782423416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs7gyRJwRJkVNYolc+dgF0gvaFLP3C9o7IgJDu8x6hg=;
        b=rhOEY0O7aheml7HozBSg9yy6AQNFKvSAu4DFD6pIRRNk5PWvBuFMoaQWKfOH/uKsoF
         7konBO08nCgY6T6bYl3x/Hxmel/iCZ5DtWpdPuITX+MY8gUWDrPsaGj6i+15SokRSnUA
         Z4VazPgZj8FOO1aoZE309d8P3/zbLEoJvY5D3OluzLG2RNWX14qUvmDlpHnkUcMXSIiF
         N76LOAb+51Za4f+pwvLqxDBZs/B5N7TM6eG2kv4IRpUQXkgeBtdwf9LixVQof/ndFLbE
         OXc+CIkCquv7grahBxk9UQ5pBLHa0+P8OLyRFBEb85jn4zs3prd58MpxJEmCA7kjB9Dg
         EIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781818616; x=1782423416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xs7gyRJwRJkVNYolc+dgF0gvaFLP3C9o7IgJDu8x6hg=;
        b=XhmtJjjaCqkGRxs6G63Jq6PS5Y5H0sHtaV7qmFS232fBQQYcPB63LBRXaVP5UlhuMn
         NQRMdai0YZu+Uz05syRjItmch5NyfSadpOuCqKrxYX5aozi0J0FUiDivnCp1uTjxEGqs
         mjx/RzXnR4xlgaJTGIzi4bagBP8NIoDZGLQ9Sd5yHT3S8Y6Iapj5H7fDJivGtnRZ3VgJ
         XOEyufKnhfal4j42iB7pQ776LBO+a3g3qkQv3qM+vGAS6o3oQd2mbVMXbjLdHgwGSSaf
         1ZCwvUSEN3hT3NDBc/L0rSGDblal8F312ZYm8mdFF3mdZCz6OgHh/56Kz/u0lMISOJQW
         fkUg==
X-Forwarded-Encrypted: i=1; AFNElJ/EyPYHTysvyh6swaZ+NWdlnmNvKmqqkb45MgCBb7HOB4T/xanjD5dX2NMJcgmNnUWTsjRuDu6Q3PO59z3TNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9LLV3ieSXzJ5X9peVCii1Ii37QlKWL0BAeNXN18/BLvGu2kLk
	CcxptTkBYpxk2E33bHK8L4LGax7AWYTPhN0OlwjFplioL2ZO1tcRvurc
X-Gm-Gg: AfdE7cleRZztRUvFIIYROoMiGZViGN3XJnyretE3771DYdqUBLN/QiwFV2etkCnUhyW
	isvtLpnVBZ6QEkRQRUdnQZ451Uv98Zj9HoOISV2/rJglhh+00vbvquTkfpiEcpdmtojoDmTJfoZ
	wO3vrAaJnLjv2KoHk8avRIZYLjQjd+pDWGiZIZ+q6QfNM9g2xDnX2pq7MfWocDp7XZHkHAcGaGo
	opzespxx4gf9BZ9Hoc51+AwAHUsXNrVjn1iDn0eVCCBCxU/WQeNm/s/H4XM9jzF5fjsbJv8NboR
	aTziUz8JfJEdkuWjlE3f//0du8coYgSxcIckThmggX0UthOifmIfeLzKk3BcK0cNlSNoSRNHL/D
	qlv/BLOlFu0W+r5sbY9CyPgvjWdWNFFgLg2vluk4Yl+JiLQ5gWWyP+tRKCL7wJqz1XOhN/QGbhe
	VWteXOlKkpC1LsjDbS8dxEA1P4Sk3iNUOWNur6Qz6243gDrmkMlWZl2Lw9GFcU
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr9055505e9.5.1781818615679;
        Thu, 18 Jun 2026 14:36:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c114e22sm1701307f8f.34.2026.06.18.14.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 14:36:55 -0700 (PDT)
Date: Thu, 18 Jun 2026 22:36:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <20260618223653.01b42b38@pumpkin>
In-Reply-To: <37fcf7c0b1a330a40005fc5ddbe075267b93851e.camel@sipsolutions.net>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
	<20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
	<1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
	<20260617223056.754bfcb8@pumpkin>
	<ajOSqWpYUhFTVqP-@ashevche-desk.local>
	<37fcf7c0b1a330a40005fc5ddbe075267b93851e.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37904-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:andriy.shevchenko@linux.intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEC556A2C85

On Thu, 18 Jun 2026 20:53:37 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> (hah, just found this window open from this morning ...)
> 
> On Thu, 2026-06-18 at 09:39 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 17, 2026 at 10:30:56PM +0100, David Laight wrote:  
> > > On Wed, 17 Jun 2026 14:56:09 +0200
> > > Johannes Berg <johannes@sipsolutions.net> wrote:  
> > > > On Wed, 2026-06-17 at 13:12 +0200, Andy Shevchenko wrote:  
> > > > > Convert size_add() to take variadic argument, so we can simplify users
> > > > > with using a macro only once.    
> > > >   
> > > > > +#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
> > > > > +	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
> > > > > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > > > > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)    
> > > > 
> > > > I guess it's not going to really matter, but it would generate fewer
> > > > calls to have something more like
> > > > 
> > > > #define __size_add3(a1, a2, a3, a4) \
> > > > 	size_add(size_add(a1, a2), size_add(a3, a4))
> > > > #define __size_add4(a1, a2, a3, a4, a5) \
> > > > 	size_add(size_add(a1, a2), size_add(a3, a4, a5))
> > > > 
> > > > as a binary tree, rather than only cutting one off every time. Not sure
> > > > that results in hugely different code though - maybe fewer overflow
> > > > checks?  
> > 
> > Good question. I'm also thinking that one-by-one may expand in too much of
> > preprocessor code (haven't checked myself).  
> 
> No. I was confused, and managed to confuse you too perhaps, sorry!
> 
> We have to have the same number of operations (__size_add calls)
> regardless, since you have to add it all up: 1 + 2 + 3 + 4 + 5 has a
> fixed number of + signs regardless of how you parenthesise it.
> 
> I guess actual CPU execution would have a better data dependency tree if
> we balance it,

Absolutely.
Intel Haswell onwards and zen1-4 can execute 4 independent add/sub/and/or
(etc) every clock. 

zen5 wins with 6 arithmetic ops or 4 cmov (and 2 alu) per clock.

> but ... if our hotpath depends on size_add() we've lost already.

I've no idea what the compiler generates, but a cmovc to copy in ~0
when the add sets carry stands a good chance of being pretty near the best.
What you don't want is a conditional jump.
The add, cmov pair will take two clocks, but the pairs are independent of
each other (the carry flag isn't a limitation).
The cpu should be able to execute two add and two cmov every clock.
So with 4 values the 'tree' version is 4 clocks
The other problem with ((a + b) + c) + d is that execution can't start
until both a and b are available; with (a + b) + (c + d) it is much
more likely that one of the adds can be executed early.

Trying to guess the performance of modern cpu is non-trivial.

	David

> 
> johannes


