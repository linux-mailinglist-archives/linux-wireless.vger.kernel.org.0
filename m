Return-Path: <linux-wireless+bounces-34886-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCYKMiDI4Gn0lwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34886-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:29:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EEC40D6AB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B94F4300E6B0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA13A6406;
	Thu, 16 Apr 2026 11:29:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0E390C92
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338970; cv=none; b=St/zxX3GO8I/JWzoLo63HvTnSTH07PC4PlpCOnKY5lufGrkdswbd8iTes7eHNua5MWYlBg7ro/uOlVRHFR3ooSY9ePfCCafIgvISDQSNw0HoltkpvVETQgMdCHC5mhjuWEFOmGB8dQSX2H1UqMLK1yWi6RUjn6hfW26mvKwnR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338970; c=relaxed/simple;
	bh=5RcGmn3E6IkK/4PLTUVN24XJ2jAiV11BodM4t9S5uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHSeLtZ1mv7Px8BnFQcuzm1XTPFdRW5gp3BDdh550Zz+ehvpuC8kJZ1FcHpsx7/UakpqtNCj0n4hfbWxDuzgqzn/GMlavJ+ZkcxUyslvk6GulpedP6ll0f8v0A5u2PlGkqszPj+EUV5nNXrBqun3ozNO8K6k6gRFXUrdvR16Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8aca4e14411so58186606d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338968; x=1776943768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6jqlHRyBmHp78NPQbVn/INUSPCxYZ/sUXVIyq1nXfE=;
        b=rJPIbNAw+P9q6/J58CUG5YTfN+H9Tvf/mGmh0sDZEwkNZAabW4x+o8WuVvyJcvGvcs
         81PIwWRILqP+Ch4KTmA7IzQSUhswpDHod+CEfZzoN31Spxa58/9rXDV+CXlf8fc2Kjaj
         JCsNTnKc4Oj2sA9sGiLBwbA+9SQTPYF5M3x7WLwYF0bGQuZVIqaAsqEI61TzPBbQrjVl
         QPaf27aHeQr0w/Elcz9MxXIlh9UVWglxF5Ue5M9o03dR0wIK3c27chtztafJ+rWNFSpJ
         Cg5eNmFoXSIIc/97esXW4LI3W9NR7vn+3cORRA3mr864pGYcx8EhY23ZtnSnhmaNMO5Z
         LMiA==
X-Forwarded-Encrypted: i=1; AFNElJ/cJk666MYVSRVLYkOZ2YglvO/6s7ums3FgEh1asXrYR+pJG5PUJaKPyK3beuORaiVKv6aOZSHP/P89vZ88Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83jXFyOAb08tCR5BK/VU+FCk+CdVxnY3rqCsOQUiFyYMIdrO8
	+FQQbbAUjA4L4NvLlDbztkIgt4MRiQOjyOjJgMPRg9sEIQF1hfOadM3VlTlFPeQn
X-Gm-Gg: AeBDievAjntqvMB7NdE5K8gI3XtZShhmFp9QZNxYwSyEKNPTnWv36uCY2L/awV/Wi6o
	EIw8/klqKpfOHX/clYyqyvVCLe2lW/UXogkQ9E9fqcvpTELNoi2GzF+w6wNDBsXuzEq1Rb+o5pU
	2ZPJTM8b8aPQnryPoIvYW+lsBnfJJ45v+Nmo/zHJVQrglHMM+VPuuVb70AxQDa/NCe7uKgtle3j
	X3+ZMUQGevW8IJwJzpUpyZtycljjeJ3Dujo1EcRRdlqbDyNhfkkgp/6MyV86P8RpJnZyi4HyHLS
	iuypqj23Q6fC+yGVLROErPJQC+26qwUdtg6D+R3aSL2IyeEB3yF/iTsIZ8XxRZcSPjTU5+H6cSq
	5lkwmxV4u3kntctVmx4UcZl+d06TDXNnpe2aeNcUF89D9nxjg01YhJV5j8U4Ka3jbqiGd2uoPE7
	PoedHVazLiDwBeSTsm4EZs3JUVuGInDPyj4HIDKeniY7y2pSDkmn/LP0axOdyZR/MfG2A0knNhP
	fc=
X-Received: by 2002:a05:6214:626:b0:89f:e674:1f13 with SMTP id 6a1803df08f44-8ac8617ea67mr410583496d6.16.1776338968405;
        Thu, 16 Apr 2026 04:29:28 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c9394fdsm34083866d6.10.2026.04.16.04.29.28
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:29:28 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50335b926c2so59662411cf.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:29:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+LLMqQA/dtno8flsSBDLOna/UmmLWxf2oj9lznQtJufZL6NiAafkKN0/HFxfKHquCcgFWCskxOfSM1Pm44+w==@vger.kernel.org
X-Received: by 2002:a05:6102:6044:b0:5ff:c64d:2283 with SMTP id
 ada2fe7eead31-60a0157295cmr11348128137.30.1776338547396; Thu, 16 Apr 2026
 04:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
X-Gm-Features: AQROBzCJ6rVnwwfhi99PI36wWXAFQ5DEgo1zw3RhVwYNSXoxkTYAcgIxt5Z0K1g
Message-ID: <CAMuHMdVoo_6i9=2oQj-=yjW7nK8eL4og08bdYvk_EGj=_cQvQA@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, 
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
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux-m68k.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-34886-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25EEC40D6AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

