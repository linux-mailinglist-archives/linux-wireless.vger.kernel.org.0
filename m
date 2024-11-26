Return-Path: <linux-wireless+bounces-15715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6A9D9970
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 15:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FAA168A75
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9F1CB32A;
	Tue, 26 Nov 2024 14:17:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736AD515;
	Tue, 26 Nov 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630635; cv=none; b=JCekQQOWVfoIjhfjyfi1myw9VDESCbEa76kpAxBwq2FnYj9R3Umyj4e8ex6SPkQ+raM7Zsj6QVzAgsD/1Src9MWKqqwOeEBhZw0IHo+Qb7iC7/4INBVSAJHwj7XSiVHHD7nrLhTG6F9zDylTyaHIPstMcGzhS53TBDzfQTI8n1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630635; c=relaxed/simple;
	bh=Af8h1x2GkRXVSShLvaf0DhS8aMbO/cKYrKI0lw1igO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIOcc5p18hVb/ZpJSCMop8J4/yCyHlAms2MNnx9Lw7oBsOXBw8W20fffezW2eVRP4VCVE1SD8aaFxcSdLZ+88F4RVnFXC5yMtRrzhljU/QK8jlDr1BZIGStMWOOe9mrPUe/unm7kqWfhWrwMCIVqeN2VD7BzNf1f9CkFcTCgYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eeb2680092so56530477b3.1;
        Tue, 26 Nov 2024 06:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732630632; x=1733235432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMlKAosx+8F5oQA944QEaviPdmzNr2nURUNr2vUH2Fg=;
        b=cPyTszDipHNPhx1JvUT91zmmYnq1JdRRZOFWU1Wuq/IvZzIq+V6q8RQqiD3By5W7zp
         D3LAQBBrTpiUhm0jOE5e1NXbz1MAH0oENuwuUgAWGYr85F5wmKE2pvR6nMDFukKdM2Ih
         wwKZLjDy7QVALWTl210Q8+KHZ0oH5e28QF6KnCn/kSapYUY8Z6pS+2CFeEhZOvH0mKLt
         h0EVcxPYgtM9riMvNu76MqTFBroyQLkNd1UUpgZIpMjwO6F4oZh4DnTvv5I/bTB+4xHQ
         Cacv27MNaW9suUHoL7xED1e9qZBlpemPVxwx3GVsQjCKkh0CLu2WoKxQuK+GvDwZtFGh
         slhg==
X-Forwarded-Encrypted: i=1; AJvYcCVw3eGkmVXqmfPZ7R7GwwA1MwpgSZ/Qv7a0RrUlXjzUQvAWlTaTkLqgQR9kQSkQQSMxzRRSiwKzokbaN7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/E37FhOcQS2VhiHo/uHdITs3jqNo7DkIuF2doqianoI7qWFL
	/sFfu6QacXBZE14yXWLCjlQkiVojbuiPrwlxS0N2j34YKwFswmqi4e1RI4Sb
X-Gm-Gg: ASbGncuTbQ7cne7lnALjYT5wI4wCqDR1/Hf7bNK7SYSo6NqIlQEm0394db0SjWlRXJf
	6Zk2mfF1YHjG9pbyREMWE3AVB5Nf9IJS7sHScxas2Yn3IbG3CqaUTpLo3DJ7gLTMV1/ik6+DLlQ
	Btt8fBCUs84DT4oQOvnG3X0z0djHz8nQhIFM1/6Y3E0FYkmdLgF9dR2962MEeMnqWtHNQ4IlkKM
	acITh+M9zKkBGCX5eKtodQxKFi6Dqm1eE6kQDadwga0kucXjEMvPHgBS+MEWgSaXddXa0D14JmZ
	nPl1MiVXsGxAwmj5
X-Google-Smtp-Source: AGHT+IFBchqzOT0RNGF3KcSaIzd2T7wuyqBh2cE/WpfXrfrI1EMnCRKUUnKTc+qC/InZyC8KP2I2Cg==
X-Received: by 2002:a05:690c:4512:b0:6e3:ca30:25f with SMTP id 00721157ae682-6eee08e8ce4mr163739067b3.25.1732630632459;
        Tue, 26 Nov 2024 06:17:12 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00835e1sm22950947b3.93.2024.11.26.06.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 06:17:12 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ee7a48377cso52524837b3.3;
        Tue, 26 Nov 2024 06:17:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWj1SCjrkHHrbVsKxQpmZ1e3eU3nPgWKyKQ20hP5Lu+Fy5Xv4ZifZRK0UyU84JLnqpvG81kH2Tej/Vaw4c=@vger.kernel.org
X-Received: by 2002:a05:690c:3193:b0:6ee:f2fa:b8a3 with SMTP id
 00721157ae682-6eef2fab97emr74621687b3.5.1732630631703; Tue, 26 Nov 2024
 06:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
 <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
 <CAMuHMdXbnZc7rYc7ibRNWY6EfRLh-7g0yDeZ3Zk5OXCQ9Cr=cA@mail.gmail.com> <8221a4a01cb838159828961b6d8d99753ecc31b9.camel@sipsolutions.net>
In-Reply-To: <8221a4a01cb838159828961b6d8d99753ecc31b9.camel@sipsolutions.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Nov 2024 15:16:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbCaMBwjrb+ZJj+MMQvOm8Y=xKfaxVhYVb79WyO4Z-4Q@mail.gmail.com>
Message-ID: <CAMuHMdXbCaMBwjrb+ZJj+MMQvOm8Y=xKfaxVhYVb79WyO4Z-4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Tue, Nov 26, 2024 at 10:37=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2024-11-26 at 09:38 +0100, Geert Uytterhoeven wrote:
> > > Thanks for your patch, which is now commit 8dc6d81c6b2acc43 ("debugfs=
:
> > > add small file operations for most files") upstream.
>
> Or rather "no thanks" ;-)
>
> > > > +#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
> > >
> > > As the minimum alignment is 2 on m68k, you cannot use bit 1 in pointe=
rs
> > > for your own private use.
>
> D'oh. Sorry about that. Though honestly even if I _had_ seen such a
> comment deep in maple tree code, on that struct I'd probably have
> assumed it's because there's no pointer in it and thus no alignment
> anyway...
>
> But sounds like you're pointers don't need to be naturally aligned, and
> so 2-byte alignment is sufficient.
>
> I guess we _could_ solve that by __aligned(4) on the fops structs, but
> ... I'm not sure that makes sense.
>
> > Reverting commit 8dc6d81c6b2acc43 fixes the issue,
>
> Clearly. Though have to also revert the related patch in wireless :)
>
> > and reduces the
> > atari_defconfig kernel size by 447 bytes, according to bloat-o-meter.
>
> Well, fair point, but if we care about size then we can win back more
> than this by converting about a handful of debugfs files to short ops,
> and if there are no debugfs files then we wouldn't need debugfs either,
> I'd think.
>
> So I think in a way the size argument goes the other way (with a little
> bit of extra work), if that was meant to be an argument at all? :-)

Assuming non-wireless drivers can be converted, too?  As none of the
classical m68k machines support wireless, so far nothing is gained...

> From: Johannes Berg <johannes.berg@intel.com>
> Date: Tue, 26 Nov 2024 10:29:23 +0100
> Subject: [PATCH] fs: debugfs: differentiate short fops with proxy ops
>
> Geert reported that my previous short fops debugfs changes
> broke m68k, because it only has mandatory alignement of two,
> so we can't stash the "is it short" information into the
> pointer (as we already did with the "is it real" bit.)
>
> Instead, exploit the fact that debugfs_file_get() called on
> an already open file will already find that the fsdata is
> no longer the real fops but rather the allocated data that
> already distinguishes full/short ops, so only open() needs
> to be able to distinguish. We can achieve that by using two
> different open functions.
>
> Unfortunately this requires another set of full file ops,
> increasing the size by 536 bytes (x86-64), but that's still

226 on m68k.

> a reasonable trade-off given that only converting some of
> the wireless stack gained over 28k. This brings the total
> cost of this to around 1k, for wins of 28k (all x86-64).
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJ=
faPWDKiQ@mail.gmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, that fixed the issue!
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

