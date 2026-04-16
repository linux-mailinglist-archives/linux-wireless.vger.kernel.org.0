Return-Path: <linux-wireless+bounces-34887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNAdKlbI4GnjlwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:30:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD540D6F5
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C08393004DBC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86C63A7F5F;
	Thu, 16 Apr 2026 11:30:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D73A8722
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339025; cv=none; b=jm/g9fMOFTE5DjyR+KI3iKcX9/C9kl9mmcGUki7jCxJ6Yi9IGxg37Wp11dVlZ3VoQ9iL1W0fiiQAuVGmRbaaDiRI8fIgXrd9etT6Khc6nYJYYYGFSx4l3O2DIwS+lzBM3Gc3KgIQGW87wTTrHKHxByfNKE6V8uFweBlFAwUuSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339025; c=relaxed/simple;
	bh=FSgVIzpnraycKQsxAztrNgNSM9On/XU1ftEj+pCL/gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3Dmj0ckh7e2+FNI+Kp7fAWoTZV0iZqSARMhbAgxTtGcGx3Fakfect39YXDWNTpRF/1qGdo0ciWDhNWjSm2CeXvG7cPwffu6d+RfNPw7iPZw1bUr9iOA8iEprQDUqDZnhQWMImPpaqn92XY/LokOT1QyunPuqJiSEglOjY0hAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-470145d7df5so4674303b6e.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339024; x=1776943824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AptjVPQ97g683jPGYCmYUacoTRTAG/3/TQY5t1TSdkk=;
        b=HB9Zrk+I+UWHY82UhQYYEH86ebvPODFmT3YUbb71wQqMGI5S2EaH3CxNlq8LWTuDSO
         2CsUXQMP8e7g5XOxQCEM6nr8nut8gb3LpPqbbBlKE9h5rGR6B9pd7PdjhhEhJtqv7pKk
         Al6EDkw7p6HxhhNi8GUB2JhgSnJvAAJ05CB9Hux7Cc5gq7FBDeEaUTcIjFHMLHeD/Bcl
         yOS9WC8AfPFEEYyWWfA20UW8SIMN7pZ/4KSHYRMXVkLkENJPvfhxg1GHC7110ROi7c4T
         PI9gGZB0hefpg56ul70KiuswYz1gGZ3Ici4vObq+l+6TP9ONKBn6pwntGVYuWLlV5BVt
         yeiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9M5nRsA8PpWRWrIAHeuek3uE+q2OtFgXx0FMsVQCBESWl5f4iSFFROUfed7gqvMpq+RdXXNWBzbZekSrkOmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfIsIM+8US7B/afnxv4UYCLoVepAECfWpEMrXBZrM7Kx8KrQu
	c0PtQssOSCuv0DakeF5YXSRUu/oidssReefv8TfXUE9l+RDNq43SRBKYZm9wJkim
X-Gm-Gg: AeBDiesnTsie7RRK59UftrnoQZmbjyKm2iINCDWVCtfcguX5Y2zkWCgv9QbKARsynRA
	ppac3G0WBOYOjNRNGG2luePhPE5m/On3azYIWR/UUm0jGq4PgvoHSGHEHwhEq1S799RJyAr+f0G
	4m+zM7wr78WU7UmGkq8ffnX9ZJGc2Rqc19LDMX1/o9QYOC5mOQ3I6YK5ARnhBxBxCBpYV50zg3H
	V2IAusEqhFjMSPaAWcmkwXgBLbo0vXbSYQunsyzDFQxCIjngmCLJWzNvHquZkGy7sGzypLhFPKj
	X0BKgvSypfO/v5/BSgCQvAnfvNDUUx0qhiUfRUA1vSxd8D1LYr2MJtyfyHzmXL6Qo5zHX893wGK
	8+Vae/J8aGW1Rs0u8i7O0auxFziINHK52etd8DTHCbvj+qKlkpeZqtp49Sh5+QDWM7y/lrhS+5R
	snf69aAItwo8LacsgPd8PKBQ7IJdRCM9GijpVGRiOHY7818/c7OOXUWe6IaFXFpFQ/57+bd50eh
	xA=
X-Received: by 2002:a05:6808:470b:b0:46c:cdf4:1bde with SMTP id 5614622812f47-4789ca3aaadmr13134372b6e.10.1776339023632;
        Thu, 16 Apr 2026 04:30:23 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4797a4d94besm2528909b6e.12.2026.04.16.04.30.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:30:23 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4670464029eso4446667b6e.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:30:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/4QBoBiKA4fs5GPOaR5O3SqgOFKv6JV5qlbhjD6wN1pCLDywvYbF7fCxMJG3PKZpEjbzEmcv6PP/BetIj7FA==@vger.kernel.org
X-Received: by 2002:a05:6122:788:b0:56f:1ed6:1d29 with SMTP id
 71dfb90a1353d-56f3bca6059mr11244615e0c.9.1776338533353; Thu, 16 Apr 2026
 04:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120317.910770161@kernel.org>
In-Reply-To: <20260410120317.910770161@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 13:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
X-Gm-Features: AQROBzBwwjc8yd10cT00Tu5Dl2qrCYQStWr3Lcobhh8coMrpPeCH9vhBSNokYJk
Message-ID: <CAMuHMdX1aShz8esbYzJ7T-0Na6++_Yi315aCiUx0Cnsgod5uUg@mail.gmail.com>
Subject: Re: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-34887-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-m68k.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A7FD540D6F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 at 14:18, Thomas Gleixner <tglx@kernel.org> wrote:
> This has been scheduled for removal more than a decade ago and the comments
> related to it have been dutifully ignored. The last dependencies are gone.
>
> Remove it along with various now empty asm/timex.h files.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

>  arch/m68k/include/asm/timex.h       |   15 ---------------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

