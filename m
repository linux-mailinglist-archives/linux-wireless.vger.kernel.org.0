Return-Path: <linux-wireless+bounces-34671-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE39Ay+d22mCEAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34671-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 15:25:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231C3E3FD9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD862302D088
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB637C110;
	Sun, 12 Apr 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccArJm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA737C91F
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000188; cv=pass; b=fSPDBVqPNXriH82DEYg2qTh4PjqKQKywIHM1oS0bYQQqROcHkgGLCyTqtCCh/TgADpfdnQ85Defs+j2zOqnCI4f0WhDdR1c8QuwaylUyErHVol8qGczCA8zG83On4jRvzZ3hQxS6u/P2axxEQWJv2soXXvq2EaHvv3zXLe2NelM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000188; c=relaxed/simple;
	bh=1p6x7PvyQL+5PGqdAnx23TY8v0cVXdqCOnUZdmPD2Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3G1bkxJCBx6Jzb5/KUJVDWxGskEy49ReyW5OARjycUHa9TI+PRt+rVvwFGsDxrvbZgS59LspWYDk/aKxaBwsZqxUvCTT8TCDoY7Pq36P2OmcP+RrWmDqyDxYz72spiDMJYXbhu777txFnUsdbkqdDRC6QRHrJh1TvRqg1W35pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccArJm9; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6717ead1d6aso229991a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 06:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=CeyoHHWLmX9dgaOH9cPA4qJpDAfQluw+M/st/xeRTvXlqxJFn3XFXaqGLg4exeZ3WE
         VbICUMjxWUtSrdjNqZOqPjRhp1XHHDfLzOy1+1Jdn04mq9jdHpQ5VVSwGsA7Uv3RuUI0
         TVwsYMIkAxwR9CKGS0QodWEi7CqL3qDNdAo6mDCBXn2N5h+mQzznd08QQd5+IfVtuUei
         3gD0XkRR3wxC9UciOVBP8Gz0Jh7Pr36GFPjVlJBZr8LqHhcEEmFF9u22qSldHf7c2JoL
         tlMhWLhBXFHc24w+FDTawJzAauOJrB3jXZrRqGYiX1C2C1U6ZjCpNjTntKtIp/5A4JlS
         H1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=M2eayRy55MhBIFtgXMTRlQcmUjrPg09SnfgggmbGsdU=;
        b=BHAVK5ln66DGqj9sWWoEKGHo5Fnuk+PFqvsbQZ706wZaLGTo8eFSyLe6JMaqA7b49n
         ChwDjVkyGzu5uZteE9Mh7miix97jCDXaOq9SJrLqvjwDo4cxQODo25uCDL+gp8RpJfY2
         YDz115zcJ8wH4fbxiPEP4cgFKR5uzZum67KAPndqtE5osVlQ6g7csgjW9jkilKIZti4U
         syyPRJxMeYrGjzXaqDB2LebraEHOs6gRlrnPGYA/LOqyc+sTXr+/pT1pIeCY5vQIvV8o
         KjMQH/9vu341GZFVXyU0XxDg9wm1nkNile96TemUWOUQlG7nMjU1ujkJE0ejFC4llA7g
         rPeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=dccArJm9v6h9Fdk8lDGNWZnQG14AQ9ZokHDnv7DAL1GW0R6BDoMR0waR0wHnO++sNY
         YJPJSDf/Eo4Jqw4GQ8Gz/T/rsLkNap5uTZ+EpwANfeQ1dFGXyG88+fN/49+h4JvC9C7c
         2+asFn0yzVsL4n2hJqrH+GINWtCINsNrMCDz6yHqeLWKks0EsNy7ssNes4vhdFLCd+tg
         k2Ys2/EuxonOOeyCkSNs/L20e6zSdmHhXIY25hzHxXat+VjZowRiCo0VNk9bdjlPvxYt
         DV9owUMCQ8VWv/4Ldm8HtUCj9QQlhYJyZr8JnJBv87EbzYIfO7KpnQu2sRPezsHrfV9J
         1U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=gE1IlWbE4iQ6ReN2q2AaqkFt2dl73fse447n1Jm3GNsTe4101k1gzJQQAOKJVbgnjB
         47K7H1oE9zS6m8pS4lWLGDCKAvWsQ18kTNvRFnJhha5qby647DSYja6Bc5iOeIXE77nh
         0+bbQYnaWh5ksVp30bYE5YnbTsb/j0TvOKsu2ZunTQBwjdC2Tp3Wn46kfH0t2erT06Vs
         AQ8LKV2c4Ak1EqaiWjMs/S5a0o9dqvxhsuf87m0gQPNZ9mqECXqaFutVYJ7w7c5zcWEw
         LtyxrzHW0PqDqIuwkRvXjsFozRib3630V8inkV1WLBfD72W7U1NW3SJwkso1AG6pWyrG
         lkDA==
X-Forwarded-Encrypted: i=1; AJvYcCWtMcxnb59zswEiAMHTC1XqwvWXonLHBqlQ0a0JLrBU5iFHgDHcEUeQdfrAOrVa3eB3tpKE6ysFYBvkI71TSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjcMe8iqaGvb7i0sssquS/7bhSu+3chJHKN+MPSTStrSBPXUv
	tsa7KcAiQuU1xUID7GV6d4sFdBpdFax8wK1jRqtdnQbVPXlGeDT/meF8rscWJTdnzYRzq/hWPRh
	gBhHVxShw1JM+xYcZnYtRJQajzLTyqX4=
X-Gm-Gg: AeBDiesqb24Pp3BtZAX90ThCJ79TDDNhK9ZO/2y7DVgEUoiNylljv019qxegv/C7fwl
	oIzEzebm9lKrfPZ2GND8EbOtP5/8Nh3g7yhFpuclgn1YFzh+WaMPwjVB4wshWI7aU1mMD1kAq4O
	wdB6TN10sPTZquCHgG1lWMdfhCCLK1KcqbMK6qgcgFPQi8jY6YNe9sb23zGcUd1rHWNmM9R5bYI
	rIvGDxcXJMNVwGTK6FYiB2lNljMvXdOqLObyo96g4SfH6wGUFWs90dXztEVPD1l0be7fnhetnET
	34CwPFiAjqSsWoOBnfA3YMv1z8aDMloLnCIfsvCd
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34671-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmag7@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9231C3E3FD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

