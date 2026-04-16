Return-Path: <linux-wireless+bounces-34885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F0FHZbJ4GkdmAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:35:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4A40D774
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049D6303817A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C590318B85;
	Thu, 16 Apr 2026 11:28:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1058460
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338912; cv=none; b=rvmZ/ElODzlqyfYr1keKSgyFiLeTE3FRWUInjaHdmafz0uocSozBrKt1ZFmnidzP2j6FAfTPmdXQgR2TaJlT185e9zezK+0Cdk48KwxHShAURB3ggRzEVRzB6LM3sKKlauRrTwSgVV+RgkMQzYRf4zs6OCNuDkG6ql0JJ1u/FGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338912; c=relaxed/simple;
	bh=onL90hyVAUlPY0ASaWQwK2lX8QEYr5m106IAfPoIE0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USKeM0S5WClekraNV3wxs/7mUiiY1oxTPP3eChzRENjFAX9EH34bXtH96nswtaNV9txMVWmVpO14bm8Dr+r1NfXNWD9c+EC09DQ0iqEDYF2HtYM++KnqumqgJv5sP/Ys/SBF2WsKmIOzKNrkHJ+8GH6uKl44FD/hM9oYu+SnsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89fc4147f2eso94830326d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338910; x=1776943710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N28AiHhMQm9a3ncbvMl4jwXcNZbOrN6OiiJm2DjJOE=;
        b=lZmcalW1PQok+OorNfcEh5g5qUb4se5GGkDxnwDfJzbpR3qkXt2sENs0Xxi5ofY/TN
         k5/+uayWQsiWQjkV0lgrGvR7FMBYfdP8h5FLq7K90pBRigq3Deq0bNszs1CGT9LK1RqX
         HZYkX8kRYX4uR1FznN0Dfe46Z7rmSG8UKYoiqmDWhTE+sEOaCxJmXs2krzSyhEQ5nFr6
         Bnjv4jdHjkCxsnPjwBDHyWEEqE65kmh6fXE4ybljRBVzatRClohrKKgsbdLjsr1fkMIN
         b3hNRVw2oeWuAiS3JJD+jOM+d2ruNyIA2sq5rgu+JlMFIgdxmRBuO6NErWXfXJQIMZUu
         fKTg==
X-Forwarded-Encrypted: i=1; AFNElJ+4GxTN7lzsIeMgkHGI/+xFI6Utrr1iZ5eWkD+5YJvB8YNmoXgdEU9R/YsqdX0Qc6qtnH/78pXfQNDVPTMRtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+c8f80z3XZJbRw+RxntVP4l4JajsyNje/sZkwXwV/n3iwXcW
	r5xmnIopsIuO62GVhk6reg5t0fWWF8gS10yC4aJOJjGr9vIbdnpqu0AvpCkl6jU+
X-Gm-Gg: AeBDievDQVWhUpFgxAE75rwYeVf1a/i1Ofl24qSd07HX3m3g45IqUL090H28d2SbHKo
	/dbsazxmBJFlF0dLiyIdws0EQLKkDa8DjobSplojDaLceXv8oEX9E+Ga0XFuddgSIpmwoqmFaft
	HxtFIFqE22SPj+y/Og3Xoz9b+kVqs4niPyr6QWU1VfqT8Nr0G74a9YxIZnbTsvNBtr5sE1L3+fQ
	gh3eAvkfrWontIC3PpJXyjKtu7yEXixCZ/CVCrfxM/HbC+oNEiH5O9c55c3Hu3/yQj5nsLfBKeq
	EsKJONVydreoL3LvGKj+Qh3BBkAD1As6vNYq9cIXYwBqkp0uifzLc8mi2bz/y6v5gl9tyNwcC6Q
	fHc+X3bKFAsPWSjiPcYdPR6CmRoKiG13PNZkysjF/9s5HBmVAcnn9I6VEQhdRHXyheHfXbowqdq
	X0o9KAyaNUadyKXwSkxOGeR/qczdbjZ4B764TurcG336omYtckxlwxkO7qikSAqX4EU5y2VVo=
X-Received: by 2002:a05:6214:1d26:b0:8ac:ab90:d764 with SMTP id 6a1803df08f44-8acab90dac5mr269536246d6.48.1776338909882;
        Thu, 16 Apr 2026 04:28:29 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cbbc1bdsm33317036d6.38.2026.04.16.04.28.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:28:29 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a016799d2cso84674996d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:28:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8j919DobI5391lNI79FtRT/hnBKY0Y9oHi6pj//oifR0+8VXQyvOXBoDbVrY/QF2ctuDAbaekd7ix5DcxtpA==@vger.kernel.org
X-Received: by 2002:a05:6102:3fa2:b0:608:1b6e:f4dc with SMTP id
 ada2fe7eead31-609ff0c50e9mr11028119137.11.1776338540828; Thu, 16 Apr 2026
 04:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.045532623@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
X-Gm-Features: AQROBzCyA8BqoTVnHFn7fWQMKVWyMF2wrQlYn44P8f0X0RsdCOwGnnxui8decDA
Message-ID: <CAMuHMdXtR7T62Wf+yDM=J0+96C64qRws=ffX_xXbfzfbS0Xz8g@mail.gmail.com>
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-34885-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20F4A40D774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 14:19, Thomas Gleixner <tglx@kernel.org> wrote:
> Most architectures define cycles_t as unsigned long execpt:
>
>  - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
>
>  - parisc and mips define it as unsigned int
>
>    parisc has no real reason to do so as there are only a few usage sites
>    which either expand it to a 64-bit value or utilize only the lower
>    32bits.
>
>    mips has no real requirement either.
>
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h      |    2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

