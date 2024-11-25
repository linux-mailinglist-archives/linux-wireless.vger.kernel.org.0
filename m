Return-Path: <linux-wireless+bounces-15688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7169D857C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 13:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0228716F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539519F120;
	Mon, 25 Nov 2024 12:37:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2A199EB7;
	Mon, 25 Nov 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538241; cv=none; b=YOwSeUm4MdZrYp3GCisODbZAaYyjzVLCa7/hFY48FA9P8lYBw8JclyEF3Bgdps9k0JSWxI7mb3j1ht9au7TmlZBhNkO5uyEl35lB6Rljn4dMtuoTYSco17Sq6T5AjL2Ya4dZlDq9WU4S4RbDzsqsdPue/UB+uGwRLtuJuBNmyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538241; c=relaxed/simple;
	bh=FXd94cOQtbf3ElQGJhsLavBZtZ3IdYaJXAS/35jCjWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmrqE6bypmElXuRyaxtEbPqYQlcvv4n6qvARZXzWTwrhXHYNHCd4o222WBy59mruW+JkhmGcgObITJIF6+5VCVYqg6Gi6b1gdcVwNffzQaDKMSXFWycgLEFbeysNk88RP1SxHucaNfRknUTOEUMYGcMIG/ed5RULn6+vNvCPhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e388e1fd582so4326047276.2;
        Mon, 25 Nov 2024 04:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538237; x=1733143037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jDTUnR+iAlcoHbj6WgacjmHkCIwMIUy0wV0qU2IATk=;
        b=m1paU3bnk5cGbcD80zQE2dvWayAYrpgf3UeFL0reBm7aAAC3itXdGP5p26QwQ4HN+F
         aI+TIn8inFNd8kQcsNuVuybNyr4tTaGTqdf0g/Pd+SZcGLf7gejiKoEhKkS/AbG8Fdgh
         KDF/8aKAZHm4oF2gBlctF7FxyJmsIml4XS4qFnz7Ndvb+L79GnIMWps2gjy8hezofe8q
         0QqKfXgjGrQ+wrsLgMZNEkIVhQDNZxuiuVYXBvhIoXX80UgX3FQYaL+uGwN578byOQXd
         mjlnSrdDvswrJiiyZgmrIe56lMa0bG2wNWLWv1BkQknOi79AFaSW/GgBRB6qMDT0E7p3
         IgLA==
X-Forwarded-Encrypted: i=1; AJvYcCXLsMqZCYF8RC+enE3l6KZNUXg1XwIHRlnNOl4eJDuSeW2dSGFSwRGkPkVPOUFyUCJMoJm/ZUBCZO2z47A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQaKsILK5AbH2DpK/y3mBp4hoC1ZxI/cQY4lJ/HmQvesCiRB/
	CTfbkn9JaN0eBJiNjfm2Uu9NHmDN47AlwsYb3x1P7aGJbt4t2QzZKplr3NFv
X-Gm-Gg: ASbGnctMlMLkhoP7LGXvQRlQ8UKJMyUCHADAroJqSl5KmQ8VzhMmCQT8g7j41GRPLcu
	KcZuwN29wj+hMpGqfr9JDZOYce8EPqgpal5HuTywWzpnxpefpjmOmwdA2G35fLzLOsV8Tb60S1m
	ImjNkHW81DAuZnWEW2dfcKGl/Tlq4DjXshMgqRUVyFm99Vtl6W405792G4CKMT0LfVLVEEl5wdl
	HgwBrX8SyB1/jp643rI3U8/iHWnWQCPFm//CHJDNgPJTnIMmled68zaxkF/AO9nkx2bjoz1F1hU
	IbXypNACl2Ya+V3R
X-Google-Smtp-Source: AGHT+IEGObkd39Ew+bSVzl7V8lMlbdsW81Lzzy3i/pprxtOI2SCLIwMFWhjFMtncYVi05jH8XN/dbg==
X-Received: by 2002:a05:6902:18d0:b0:e33:1492:cd63 with SMTP id 3f1490d57ef6-e38f8ad733fmr9241288276.8.1732538237002;
        Mon, 25 Nov 2024 04:37:17 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f604b594sm2478166276.18.2024.11.25.04.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:37:16 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eee6874ef8so26515727b3.2;
        Mon, 25 Nov 2024 04:37:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW22+6eM19f508hMQ4BlWmdzJ7cnsZJuIPoZEdpphhgzJ7ds15Vjr/Vuqg3chEU4xjSdlGIs8aHplbalEw=@vger.kernel.org
X-Received: by 2002:a05:690c:7084:b0:6ee:3f37:919c with SMTP id
 00721157ae682-6eee08d3f6dmr113218247b3.14.1732538236154; Mon, 25 Nov 2024
 04:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
In-Reply-To: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Nov 2024 13:37:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
Message-ID: <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Tue, Oct 22, 2024 at 3:19=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> As struct file_operations is really big, but (most) debugfs
> files only use simple_open, read, write and perhaps seek, and
> don't need anything else, this wastes a lot of space for NULL
> pointers.
>
> Add a struct debugfs_short_fops and some bookkeeping code in
> debugfs so that users can use that with debugfs_create_file()
> using _Generic to figure out which function to use.
>
> Converting mac80211 to use it where possible saves quite a
> bit of space:
>
> 1010127  205064    1220 1216411  128f9b net/mac80211/mac80211.ko (before)
>  981199  205064    1220 1187483  121e9b net/mac80211/mac80211.ko (after)
> -------
>  -28928 =3D ~28KiB
>
> With a marginal space cost in debugfs:
>
>    8701     550      16    9267    2433 fs/debugfs/inode.o (before)
>   25233     325      32   25590    63f6 fs/debugfs/file.o  (before)
>    8914     558      16    9488    2510 fs/debugfs/inode.o (after)
>   25380     325      32   25737    6489 fs/debugfs/file.o  (after)
> ---------------
>    +360      +8
>
> (All on x86-64)
>
> A simple spatch suggests there are more than 300 instances,
> not even counting the ones hidden in macros like in mac80211,
> that could be trivially converted, for additional savings of
> about 240 bytes for each.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks for your patch, which is now commit 8dc6d81c6b2acc43 ("debugfs:
add small file operations for most files") upstream.

> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c

> -struct dentry *debugfs_create_file(const char *name, umode_t mode,
> -                                  struct dentry *parent, void *data,
> -                                  const struct file_operations *fops)
> +struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
> +                                       struct dentry *parent, void *data=
,
> +                                       const struct file_operations *fop=
s)
>  {
> +       if (WARN_ON((unsigned long)fops &
> +                   (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
> +                    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
> +               return ERR_PTR(-EINVAL);
>

This warning is triggered during boot on m68k:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at fs/debugfs/inode.c:457
debugfs_create_file_full+0x36/0x70
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
6.12.0-atari-11072-gdeea1aa0a8f2 #1787
Stack from 0102fe78:
        0102fe78 0051acfd 0051acfd 00000000 00200188 005321b8 0042af36 0051=
acfd
        0002459c 00000000 005321b8 000001c9 00000009 00000000 005aff3c 0060=
f4d8
        00024644 005321b8 000001c9 00200188 00000009 00000000 00000000 0000=
00b8
        00000008 01020c00 00000000 0000209c 005f13e0 00000000 00000000 0102=
ff88
        00200188 005321b8 000001c9 00000009 00000000 005f13fa 005139e6 0000=
0124
        00000000 00000000 004370c2 000020f6 000000b8 00000008 01020c00 0003=
b03e
Call Trace: [<00200188>] debugfs_create_file_full+0x36/0x70
 [<0042af36>] dump_stack+0xc/0x10
 [<0002459c>] __warn+0x82/0xbc
 [<00024644>] warn_slowpath_fmt+0x6e/0xc4
 [<00200188>] debugfs_create_file_full+0x36/0x70
 [<0000209c>] do_one_initcall+0x0/0x198
 [<005f13e0>] tk_debug_sleep_time_init+0x0/0x22
 [<00200188>] debugfs_create_file_full+0x36/0x70
 [<005f13fa>] tk_debug_sleep_time_init+0x1a/0x22
 [<000020f6>] do_one_initcall+0x5a/0x198
 [<0003b03e>] parse_args+0x0/0x202
 [<0000209c>] do_one_initcall+0x0/0x198
 [<0041c948>] strcpy+0x0/0x1c
 [<00070007>] alarmtimer_suspend+0x6f/0x1fc
 [<005e9628>] kernel_init_freeable+0x140/0x198
 [<0041c948>] strcpy+0x0/0x1c
 [<005e9676>] kernel_init_freeable+0x18e/0x198
 [<005f13e0>] tk_debug_sleep_time_init+0x0/0x22
 [<0042b2d2>] kernel_init+0x0/0xf2
 [<0042b2e6>] kernel_init+0x14/0xf2
 [<0042b2d2>] kernel_init+0x0/0xf2
 [<00002524>] ret_from_kernel_thread+0xc/0x14

---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at fs/debugfs/inode.c:457
debugfs_create_file_full+0x36/0x70
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper Tainted: G        W
6.12.0-atari-11072-gdeea1aa0a8f2 #1787
Tainted: [W]=3DWARN
Stack from 0102fe70:
        0102fe70 0051acfd 0051acfd 00000000 00200188 005321b8 0042af36 0051=
acfd
        0002459c 00000000 005321b8 000001c9 00000009 00000000 005aff3c 0060=
f53c
        00024644 005321b8 000001c9 00200188 00000009 00000000 00000000 0000=
00b8
        00000008 01020c00 00000000 0000209c 002a44f0 0029c032 005b8a1a 0102=
ff88
        00200188 005321b8 000001c9 00000009 00000000 002a450e 00539121 0000=
0124
        00000000 00000000 00462a86 002a44f0 0060f53c 000020f6 000000b8 0000=
0008
Call Trace: [<00200188>] debugfs_create_file_full+0x36/0x70
 [<0042af36>] dump_stack+0xc/0x10
 [<0002459c>] __warn+0x82/0xbc
 [<00024644>] warn_slowpath_fmt+0x6e/0xc4
 [<00200188>] debugfs_create_file_full+0x36/0x70
 [<0000209c>] do_one_initcall+0x0/0x198
 [<002a44f0>] deferred_probe_initcall+0x0/0x8a
 [<0029c032>] _mix_pool_bytes+0x14/0x1a
 [<00200188>] debugfs_create_file_full+0x36/0x70
 [<002a450e>] deferred_probe_initcall+0x1e/0x8a
 [<002a44f0>] deferred_probe_initcall+0x0/0x8a
 [<000020f6>] do_one_initcall+0x5a/0x198
 [<0003b03e>] parse_args+0x0/0x202
 [<0000209c>] do_one_initcall+0x0/0x198
 [<0041c948>] strcpy+0x0/0x1c
 [<00070007>] alarmtimer_suspend+0x6f/0x1fc
 [<005e9628>] kernel_init_freeable+0x140/0x198
 [<0041c948>] strcpy+0x0/0x1c
 [<005e9676>] kernel_init_freeable+0x18e/0x198
 [<002a44f0>] deferred_probe_initcall+0x0/0x8a
 [<0042b2d2>] kernel_init+0x0/0xf2
 [<0042b2e6>] kernel_init+0x14/0xf2
 [<0042b2d2>] kernel_init+0x0/0xf2
 [<00002524>] ret_from_kernel_thread+0xc/0x14

---[ end trace 0000000000000000 ]---

> --- a/fs/debugfs/internal.h
> +++ b/fs/debugfs/internal.h
> @@ -18,6 +18,7 @@ extern const struct file_operations debugfs_full_proxy_=
file_operations;
>
>  struct debugfs_fsdata {
>         const struct file_operations *real_fops;
> +       const struct debugfs_short_fops *short_fops;
>         union {
>                 /* automount_fn is used when real_fops is NULL */
>                 debugfs_automount_t automount;
> @@ -39,6 +40,11 @@ struct debugfs_fsdata {
>   * pointer gets its lowest bit set.
>   */
>  #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
> +/*
> + * A dentry's ->d_fsdata, when pointing to real fops, is with
> + * short fops instead of full fops.
> + */
> +#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)

As the minimum alignment is 2 on m68k, you cannot use bit 1 in pointers
for your own private use.  See also the comment at
https://elixir.bootlin.com/linux/v6.12.1/source/include/linux/maple_tree.h#=
L44

Reverting commit 8dc6d81c6b2acc43 fixes the issue, and reduces the
atari_defconfig kernel size by 447 bytes, according to bloat-o-meter.

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

