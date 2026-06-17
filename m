Return-Path: <linux-wireless+bounces-37870-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EokECRkSM2p/9AUAu9opvQ
	(envelope-from <linux-wireless+bounces-37870-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:31:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42E69C886
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 23:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GZ3fenMF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37870-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37870-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F103F30262F8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683F39657A;
	Wed, 17 Jun 2026 21:31:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549637B00F
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 21:30:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731861; cv=none; b=nOEcMmMfgYV92O0qfuKP/VbqVXLgJzyTB/T0YjcZkwpLKIEZUH5Jlvk3Bu1+CdTuSaL8FKEtoZ+5P+uRn03chjROzXVnCzrUOJUgiDtvCV/ZVHzAQ811KlDbqUT1qzMteNtOeR2CpfvojJtFSAwv7ZOHF7ins86BGTPUXVNaeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731861; c=relaxed/simple;
	bh=VKPsWynGDM9pys60QuVcwARe1tdFU7Czo0xoqGYlLAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7yoGfUafd+04BmVsItNv6dTcTrtD7rPoB6R28NJlRdlWpkexHX10w23YSb1YO2Qp06GYxzcwruGzIpRg+SdHMYd/Y838XKGf/ZZCyvBbDNW6TvaAk1BuBbJ0IwQtK3euOqfSpfixIeMctUs8tUwpAGVRp2EozdCrHerFheu+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ3fenMF; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef29c5561so160406f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2026 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781731858; x=1782336658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeHK9f7qxiC+a+aM8unHOfffPeCuNSMjZHypTzZC9QE=;
        b=GZ3fenMF+Ea8FGHAhsl7ZsvaYtVff0Nyzw2jccXIO9pgZNGLQ4lKQLfE2JT2yQnGba
         qxBQrvw8ODKfuYyHkoG7DT+lrs/dziZLTJTIAjkRrI7zaYpWqV+MMbn9yQibp9Apo4qd
         S7F/4uEje0Vz5bib2jcz1gJ8E5C5TZYG0lFnFcKMNSy1EKL2CVXFvGsvDtri0QvhWHKU
         Ji34NQPFtq8ll+vkHyofOzCQSo72ataJOGP1EezZwSG/uNSz7AWcxVk3LE2GA9g3RN+Y
         SNfT5GgvS2ttS2x4ypLZUHpqaxfFtW3PINyDw9rcyAYT6NxdkiyFYA75hR0bqLhL2Kst
         WlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781731858; x=1782336658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeHK9f7qxiC+a+aM8unHOfffPeCuNSMjZHypTzZC9QE=;
        b=YXNCFp3pvLyksWXitoKC6S5neVfWqljtXxdq3OxWZl0ChZ8ww0unrfwzYCujT0XwmJ
         m24UeY+CowKXoVrvjI8RfzYcz02v91Ffk8tjiELX7ZUlK+/G25MBs8UBVImYL5Iw0/K7
         2GA5Ap0SsTfK+M299i3MqS+R/u75M2sRny4hX24Rn8Cln66SHSDFYTqKmq9UBXEkVV/a
         643BGj7c5k5y7SUaAEO4AMqyAk5QgGWZ/DR8XpRDbsD7gUUMCaHhdBvFZmkdO1oumVsL
         5kSI8pm0afYidN0Wm6/fyNQZhtMyqLkylMb0XdBa3WabW+ftOIFsd0vMrT5gszPic3j6
         hBpg==
X-Forwarded-Encrypted: i=1; AFNElJ9wmnV4y8UVmgcNvmbBTN3XbcddCc0p791QEEUGKq2aMB8mX4aNYGWuemnejLJY7WxnUyW9Y5Y8mVNlWVBlQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgRrKufn7wfJH7oNa0ZRij22uYvxETWQYZKCLvYKAr6Ctkliv
	JmeymEI/+ie7Q4eDv1/kqWFEkAX0Y6Bf5P3wfJ5tAW0G7ORgU4stxS8aLkwd7KeR
X-Gm-Gg: AfdE7ckgpPwvj/2D/QezIdHbCAD4aG14SSMYNSIzfJeWyCuQACfAHBs/bQtKe1yMJIO
	s7YeOSG1bEaqg26ZymaVA8eaQ6D1DNksdCcpyxdTrspZ+ufSjvBbvs3FQld2NeiwCzm5lMVTWIe
	ef4GZwPqHAyxS1s9SLplPotO2QIwYH4W7CTYzBoxiWvelGpGUj8URYsYZmdZ6sAdDcGxNMX7mVt
	Kf95mdko3a6H+xcadqUQ5F/8uzZEtAr8yC8rpHiGDhZXoxJMQgMUisbcB0nQug3UyTsdaeCbQsk
	Th53sb4nD7CbiwmkDTmy2tDquUriwzK2VIII4rdw/ppW6PHQjpMR5B8jn+hVtanYAt4e7IUBvoP
	LAK/O9HSPcQ/Za5f9ALpwtaDjucvAIf+I9qycQauzaFLgiGuwLH3UxeUSTbbbr/Zg2POz5rNiCe
	Gk9V7GKJMwaA7xt4CVgdRtCOK4cIJ6bGNTzRpqe2f8zL8sMz9rDEeRB9aifbka
X-Received: by 2002:a05:6000:288c:b0:460:3233:f994 with SMTP id ffacd0b85a97d-463adc9232fmr1301938f8f.43.1781731857875;
        Wed, 17 Jun 2026 14:30:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b3ed0d2sm18936916f8f.22.2026.06.17.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:30:57 -0700 (PDT)
Date: Wed, 17 Jun 2026 22:30:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <20260617223056.754bfcb8@pumpkin>
In-Reply-To: <1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
	<20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
	<1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37870-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:andriy.shevchenko@linux.intel.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D42E69C886

On Wed, 17 Jun 2026 14:56:09 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2026-06-17 at 13:12 +0200, Andy Shevchenko wrote:
> > Convert size_add() to take variadic argument, so we can simplify users
> > with using a macro only once.  
> 
> > +#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
> > +	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
> > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)  
> 
> I guess it's not going to really matter, but it would generate fewer
> calls to have something more like
> 
> #define __size_add3(a1, a2, a3, a4) \
> 	size_add(size_add(a1, a2), size_add(a3, a4))
> #define __size_add4(a1, a2, a3, a4, a5) \
> 	size_add(size_add(a1, a2), size_add(a3, a4, a5))
> 
> as a binary tree, rather than only cutting one off every time. Not sure
> that results in hugely different code though - maybe fewer overflow
> checks?

The binary tree stands a chance of executing less slowly because the leaf
adds can be executed in parallel.
Excluding the saturation checks (wtf is it called size_add() not
saturating_add() ?) (a + b) + (c + d) will usually execute faster than
((a + b) + c) + d because the (a + b) and (c + d) can execute at the
same time; unfortunately gcc will always generate the latter.

	David

> 
> Although your version make it really completely equivalent to the
> nl80211.c code, clearly it doesn't matter if all the values are "good",
> and I believe the overflow behaviour means it doesn't matter for the
> overflow case either?
> 
> johannes
> 


