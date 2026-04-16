Return-Path: <linux-wireless+bounces-34881-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN03Fpe64GmIlAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34881-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 12:31:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0089B40CF1E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D2CF3038C94
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52F392838;
	Thu, 16 Apr 2026 10:31:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5439A05C
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335507; cv=none; b=k/hkxsGQxzkEIbg1LK4eC28I49fR9cekX+24bWKPzSnieLFaWyZsUCrRM+Qf/fs6cXGPL5aTJh6bx0L5nx5ajhSGIkV+ryOgX9ccOCqi2nARKFSPJPWHl6ffbnHd6xRK73mnAYy2u29MX/PyAYi1DQ59rx3rr4UVR+o6vrSBbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335507; c=relaxed/simple;
	bh=Il5EilNKbQmVM1qv4XgxLAe02Z9+zxydkwUqJc2BPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1x1nY4iqiU3sm81zeQtxtaR3NKxGTdhsvogEKpr0fR3D0fAvX/hOKXzYIvLpPxuZvThTx8OqiEodLo7LtzRxsS19tZBZQvEfr+KbW6DY0OTY1k5X0H49kVBPxxqgGVcdTzfuLWZOOmeArqXsV9z9atZZKxMvLR00dZ/BZROFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbcb467f2bso7038891a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 03:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335505; x=1776940305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=iFMPb83uIrXG7iDx43l6Y4U8XQlcb8kvFisBL4/B+z3CcwGxi937rnsG40wX7EVtpl
         VhZi9E8PUHWPAHjPBDBKJcjmkd/yPyWNekD0/K/YzHmMXO3uSt+x0BVsRYdPqL7YJLCW
         YuknEDuRN0ZQYHV4z2YHqZXt3IwG7Um02Z7E8mmj8bXavWYDsZGaMk+uVYPcZugpo6tQ
         zJfjXLBxAmuU2KIN5JBTEnqcWPOac8GBxYq9IDGEx4lsvI2J4HMFxfub0SXYyDgvS1Y+
         joS3QTyEL543m7mwX4SQDscbTzQZNZdAVHDsrTkHnBP4iFWyLqCiXDRt9RMigri2DjPP
         ZkYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IrS3wuBLCT72KHAf3Kcfp2eXVB4VvozFfwt2FHQA2DBgVVeit2bf4T2bZZPx9F+2ZPGM8S5/xJ6+9ICUS8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgcflbRx5gSuEJ5deepnWJKmoL68WmkQPE6abX92OoFAmd/cq
	nCP2tqIHsVgAnE5JrFJFvUnVVNkt8tved46S7+Z1Fl670+E/mA+7uKdnp+awFeWx
X-Gm-Gg: AeBDiet5IfWRKuHpjNoramiw5H09B1yPuU4n0wbL01J6DeN91H6ZyuP9SB1V5AYaDkA
	QU4Do051d+8dSnGoggJRFd6SSdHXX59K5Od8nOjs5iTJDj/0iPf+GvIcNpppRi9/3wRS4jWg7Jr
	ExKM10SPeYf+2n5jaFNoWneX68F9WmRspCU7a2tckCuMd8jHG3277WnSsw7R24G0fQl/0QWFqEr
	/4dZLus1AYuVnKo5JSHYcOCM4CMwLxYjFcbOLs55Qpkc+gM1TPHXJZkCtmymftyAc2aMOTb+58w
	2BfXnwX/6h/CpMAOlDmYpkVkS7dXBtfTqzLnC2KouOhAvWArGfS6L02N1QjPyMjFIthThizbwv3
	F0x8GTlz3TcpmqQgYs0eOOITGNAVQN2HkJi2SXSKn/9ztK7hk0dhWFq4P8rwu8/9GQkd18pgVAy
	ILeGMUGs2e0ssqtbi9O0WWUpDKB+Xned64es/5606nGxLfauOUZWNQGdY40DStyWY5hDXs4hA=
X-Received: by 2002:a05:6830:668b:b0:7d7:eab6:fb23 with SMTP id 46e09a7af769-7dc27f7cf76mr17491455a34.22.1776335505047;
        Thu, 16 Apr 2026 03:31:45 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76a32728sm3372354a34.7.2026.04.16.03.31.44
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:31:44 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7ebe11bffso6493592a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 03:31:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9SDxyzxaFZzXulgGOv3TG73jYODUTJT8L+1eEoRGMTXfFD95sWjmTerhA5AshqZxs/DHFiTTII5c3NgBlQ3Q==@vger.kernel.org
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,gmail.com,kvack.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,infradead.org,plugable.com,mit.edu,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-34881-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 0089B40CF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

