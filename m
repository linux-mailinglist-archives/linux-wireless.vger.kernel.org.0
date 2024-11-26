Return-Path: <linux-wireless+bounces-15707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1D9D936C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 09:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C115B22FD9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF1F1B4143;
	Tue, 26 Nov 2024 08:39:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5518C332;
	Tue, 26 Nov 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610340; cv=none; b=AiRA4NKZlIebCmmZXwcppgJRluTCcTeyBoi9oCYLoutg0ZXMuVCXDQckm+3snaMEQ2/2Bk/6TkPeO+memuTZNEKqxNOnlcC32g9HeRCkTZcBKLOfD0vj2+i9KxscvsZLhrs7vsfhNYaR2+STxxmKQ8nxI2nz0bjZDgf268LcQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610340; c=relaxed/simple;
	bh=YUKKRY7A2nE2FhB3ESXaNOsgnyAfymvw5W7zwhIFgMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAXZKm7LVZT6LosARFMhDyNCpC8UrWER8avOurFeZSEpesWDrM4vboasRcL5tyqJM2GmzwmPKjJqpTZareMTLtisDe5xFSkhd1eyymOwgiBpmpWddBoM/Fx8YBpL0v5vRvnfEnGBZoNcaqyIu5ZCXJCHOEgy2NvcGxZ+jQXcZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eeb31b10ceso54685537b3.1;
        Tue, 26 Nov 2024 00:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732610336; x=1733215136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjBErQLBEug3e9Mj9PlNyLOsB+0cCc+2zRG7fLFw9Bk=;
        b=nQ+wWmiQD5Yu6VukbPpYqDe+bEW2lKk5sufinN09M6KtIuNjQG4kqY14i1Fli1F8Gw
         K8MtLvOKg8zx7GwHuoPKF4HmGYrm+Ul9fOBpOppW893uRuLRsB05pVEi/wfP6xNfCsBT
         zQXFAkTVTlaDQCrPIXguPOPHGdnV995ZrUFkcL0WO9d3L8/Pg6lF//dIPfznRTvDLf7+
         ATRnbTKOVb1fRnBMwIuD1x37f7qQ51FKRB01YR8me4A5J4M6J5trGrDsYOsgv60z6bmW
         NSBypv6o6k2jBJ2BkTST+ZMpI6pnUFKN3CScaPOQjgWf3YelP6ttx8O2PwDSbTzeDhVw
         uZMg==
X-Forwarded-Encrypted: i=1; AJvYcCUo8LRVS7UtmBQE7Sl95T7n6qC0jzPk2uZfhRBQnf4oFzOUNC6ZAnJrPveTnYtgqxp0reALN8ia8qMp3hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SspLEvQVUFKQV1jLAKenRqCpMtV/GBo5o/su2eUVwKRx+Q3n
	c/8UMCHADNDBn1Gicu8VKC2mFg71WTqsJo/h2Wx4F9lgaHkBn1zssnEYTFPz
X-Gm-Gg: ASbGnctIU6NHpxAEUnf5BvgatG44TIycglS/zDu8mgz11IwwPcJZhrfQkiosgkzTSVY
	6e8+PEGt1O0As9OClBLRe7x/WiQWwk85Gbnv6nt/E0IXoq3qShGf1zUbwXwRDmIDiHnFKOzvhTW
	KsSiWneZJpckrCH9E63MEH+dQU1O9fk9Wnov1SMuVU4/pCwt80lKZ3VFO1ZUL+uSky09gopUxAe
	26v1akkKePVWWAQ977ND36XFbPP8P0twz+2vySZGT2zXqCDDVLUWznGmn5xEcxSP40drbOgnSwj
	HGMH9V4OQxy0Jqsj
X-Google-Smtp-Source: AGHT+IFkSHQmpSQVux66+DSg/d2jSO1uuc9fOdkblYsuHcM7FN6X7AC317/LY3nfBTx2m7p6Dhvv6Q==
X-Received: by 2002:a05:690c:688a:b0:6ee:4bee:d912 with SMTP id 00721157ae682-6eee09e9881mr152116967b3.21.1732610336234;
        Tue, 26 Nov 2024 00:38:56 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2c142sm22368897b3.48.2024.11.26.00.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:38:55 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee994218d9so47765467b3.0;
        Tue, 26 Nov 2024 00:38:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFWKNycsWsNRnr5FDDYIDGsll/RJIirjCqrs+dnzhUTppY1OmoaL/vtQNuV/v0o2tPJO0GmhFtNnK8BUs=@vger.kernel.org
X-Received: by 2002:a05:690c:62ca:b0:6ee:b43b:62f4 with SMTP id
 00721157ae682-6eee09e9dc5mr153772817b3.19.1732610335371; Tue, 26 Nov 2024
 00:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151838.26f9925fb959.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
 <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWu_9-L2Te101w8hU7H_2yobJFPXSwwUmGHSJfaPWDKiQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Nov 2024 09:38:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbnZc7rYc7ibRNWY6EfRLh-7g0yDeZ3Zk5OXCQ9Cr=cA@mail.gmail.com>
Message-ID: <CAMuHMdXbnZc7rYc7ibRNWY6EfRLh-7g0yDeZ3Zk5OXCQ9Cr=cA@mail.gmail.com>
Subject: Re: [PATCH 1/2] debugfs: add small file operations for most files
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Mon, Nov 25, 2024 at 1:37=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Oct 22, 2024 at 3:19=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > As struct file_operations is really big, but (most) debugfs
> > files only use simple_open, read, write and perhaps seek, and
> > don't need anything else, this wastes a lot of space for NULL
> > pointers.
> >
> > Add a struct debugfs_short_fops and some bookkeeping code in
> > debugfs so that users can use that with debugfs_create_file()
> > using _Generic to figure out which function to use.
> >
> > Converting mac80211 to use it where possible saves quite a
> > bit of space:
> >
> > 1010127  205064    1220 1216411  128f9b net/mac80211/mac80211.ko (befor=
e)
> >  981199  205064    1220 1187483  121e9b net/mac80211/mac80211.ko (after=
)
> > -------
> >  -28928 =3D ~28KiB
> >
> > With a marginal space cost in debugfs:
> >
> >    8701     550      16    9267    2433 fs/debugfs/inode.o (before)
> >   25233     325      32   25590    63f6 fs/debugfs/file.o  (before)
> >    8914     558      16    9488    2510 fs/debugfs/inode.o (after)
> >   25380     325      32   25737    6489 fs/debugfs/file.o  (after)
> > ---------------
> >    +360      +8
> >
> > (All on x86-64)
> >
> > A simple spatch suggests there are more than 300 instances,
> > not even counting the ones hidden in macros like in mac80211,
> > that could be trivially converted, for additional savings of
> > about 240 bytes for each.
> >
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>
> Thanks for your patch, which is now commit 8dc6d81c6b2acc43 ("debugfs:
> add small file operations for most files") upstream.
>
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
>
> > -struct dentry *debugfs_create_file(const char *name, umode_t mode,
> > -                                  struct dentry *parent, void *data,
> > -                                  const struct file_operations *fops)
> > +struct dentry *debugfs_create_file_full(const char *name, umode_t mode=
,
> > +                                       struct dentry *parent, void *da=
ta,
> > +                                       const struct file_operations *f=
ops)
> >  {
> > +       if (WARN_ON((unsigned long)fops &
> > +                   (DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT |
> > +                    DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
> > +               return ERR_PTR(-EINVAL);
> >
>
> This warning is triggered during boot on m68k:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at fs/debugfs/inode.c:457

> > --- a/fs/debugfs/internal.h
> > +++ b/fs/debugfs/internal.h
> > @@ -18,6 +18,7 @@ extern const struct file_operations debugfs_full_prox=
y_file_operations;
> >
> >  struct debugfs_fsdata {
> >         const struct file_operations *real_fops;
> > +       const struct debugfs_short_fops *short_fops;
> >         union {
> >                 /* automount_fn is used when real_fops is NULL */
> >                 debugfs_automount_t automount;
> > @@ -39,6 +40,11 @@ struct debugfs_fsdata {
> >   * pointer gets its lowest bit set.
> >   */
> >  #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
> > +/*
> > + * A dentry's ->d_fsdata, when pointing to real fops, is with
> > + * short fops instead of full fops.
> > + */
> > +#define DEBUGFS_FSDATA_IS_SHORT_FOPS_BIT BIT(1)
>
> As the minimum alignment is 2 on m68k, you cannot use bit 1 in pointers
> for your own private use.  See also the comment at
> https://elixir.bootlin.com/linux/v6.12.1/source/include/linux/maple_tree.=
h#L44

If you want to support truncated debugfs_fops structures, I am
afraid there is no other option than storing a flag, structure type,
or structure size inside the structure. The latter would allow us
to support not just full and short structures, but also arbitrary
truncation, given even more opportunities for size reduction.

E.g. something like

    #define get_method(_ops, _op, _op_fallback) \
            ((_ops->size > offsetof(struct debugfs_fops, _op)) ?
_ops->_op : _op_fallback)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

