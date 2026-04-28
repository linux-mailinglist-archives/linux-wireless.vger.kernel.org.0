Return-Path: <linux-wireless+bounces-35482-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLf/NT+A8GlSUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35482-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:39:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A4481A41
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 962F230F9B8C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD643A6EE3;
	Tue, 28 Apr 2026 09:32:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76D3A63F6
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368735; cv=none; b=bdK1HeiC6VIFYNAj69Zi/w33lov36nFZ4Gru7PDpKki014tf8XZHOk+1fgipaYIjkAkMmkNPJSgjHb/Bgop2ApbH8uV7uXaWnm7Zb3iSccXunqnYkWvhAJSV35+6WVzbQkjTXZY2QIBpHgT42c69McEQa2BDTcgudz+rqesTRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368735; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGsW4eTo7ifZOEjEiOZ1WhRtgc29vqWAsy/MVH3CaCW63/oiP2bmWtxnq89ZuiHbunIypDy05xkjBApOp0ydaW9VE269W/UfuIxuoT/F+iP6KUdLu0Nr71iH3yh3o+cTJlCH1W1xpRqNVliiYrjt+SyR87Ha+Zx4mPaTcTYLE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso15351874a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368733; x=1777973533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=aeEvuSJCQh+LQBpWSmdUABhDP2QwKt26gUAiqHq7RwH+H8FZQ+NlPrJI5nhhSPAvwJ
         BGLlB0SN04BHth3BnWXmv0koKqa4SObzLRaZU5geaZi4dqe6aBn/FGLQZqflm/lT96wB
         8rkZdQER5p5b+IpejOdXmh67NXc5LShwDxt/0dKJUtgS4bOaZczCS2oVfYe3HUR7t7cd
         /QZiA1h4QVxloshnZh/4fxOdzvhdQd91USfdl6IiDauz4vak+0gPxR8hd0MZRgW32cl2
         E6v8uTFrbpiMq2KQQtMyUItUpVP492bHcdi+sUAytPs+zSqO9IptVKajMEokv5fxbUyJ
         Cg2w==
X-Forwarded-Encrypted: i=1; AFNElJ8kmb095ki6Jk+/xTIcpFDJ4Ae6TPrSJ3oMxekyyGxxiwbU76jXe3j5lyrk2Lro82N4vZfWEasihjp3xI4ACA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00RhEtUjyxvMst71U0ifmqrLGC/hMFh9EPr2EGQ5qp2Behz2q
	54tvpM6pLKE6kr5Be5HtdqReXC/t5ZBfQvVcc/He8udZQYoVwEGINeKxuwCV3o4e9ek=
X-Gm-Gg: AeBDietjheIZ7ZX6N8ihgiVZ9QkiVxBMO8uRvPsnc3nfCJnkXc8jXWhsWUHFW1TsI1C
	iZBG14lTsoP3nmFvBWUSgKugZcvhHUud8XrBR6EftWI8swq+76ffXetYWUrUqHef+k7nmaeJKNG
	kjwBwcSMWQmC3B/PBeNBcUmM1kCwg9pYBXwM/4JN5J0NwO024B/WGtb1SjQatzQsBmjI9Qdqfti
	hBbnUflQT5TpWTyWryNRp6yf72Bsqcz1sxdOvok2tYXwY7/+aQ45GsFUoADBd3ssQx3YayNyg6L
	RFPV89ZqKSWIQTOB16Bqj6y0AJds1l6XyC8RRyYKPqKf0lqczj1tWt7LQJxd0unHmc/VplEJl0/
	xxPenlL91has1GI4bY1pLAYX1bRE0+/6wIXaIQ0jmrpjuzwEB4a1y9t2GhgCM3h0l4f1zNvTkhf
	qIpgRDOtZhz01YzUl69u4eRlqSuCYOcw6ZtEySmAHi60I3O93aJIcdELWVh8zPE/DtCy0lfqU=
X-Received: by 2002:a17:906:ba89:b0:bad:a28:e09 with SMTP id a640c23a62f3a-bb804d28002mr143779866b.41.1777368732328;
        Tue, 28 Apr 2026 02:32:12 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c57f559sm73985466b.61.2026.04.28.02.32.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:11 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19506906a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/tDOo4dcBhTonq9JpUO5KnPiXgW2L3GZ1b49FjixsFR0MLBmrUT/NhfK95PCTE5rQ6HZysp65T1utbSfKIGw==@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 589A4481A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-35482-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

