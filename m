Return-Path: <linux-wireless+bounces-30314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4670ACF0420
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94353300F8BA
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5702264DC;
	Sat,  3 Jan 2026 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHLyDvPu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39861F4190
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767465782; cv=none; b=fhjTUVfSYhzyyyjChqSMzCbaWvRE7PPXRaA675LKHTY3gQxk/dzwJHzaq59mv0u1jrFYKDDYf1ynlgHlM1+yjiUAsBndYJ3yTLJo3wWHZN/dph5e4mlqv832rtqnWVY2wnGMq7u8dWvpLEh0/fANEzV8PvZ/+Dp3DH8XBXRDjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767465782; c=relaxed/simple;
	bh=D69avIEfpX7oKhQCnPm9koTWZ/87ghjYNH/XRRmIKD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iX4VCEW5mAeyU36SObiqdVKWtTPeBIrxEq0wL3u7jgBzcsG/niPavcfuQNveyrdrsFRpei5YLMcYuntBXmTPIeA8sQz8Xw9Gg+OxMMejEdSVxMs7jpDLcezFNrwWQ5AvLr3BLROq7Fhr/CJKLEQgZN+DN/rUewVBKk2788/GnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHLyDvPu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so19071934a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 03 Jan 2026 10:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767465779; x=1768070579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bcf3JMltMq6B3ayh2KI2Hnl3zzMj0i9VG17bkzRAzBo=;
        b=jHLyDvPuH/561HAXS76Xj5TYOUErLu6JB6wHLndQoyIHjaw2MJTDgj02PsNqDjQmaJ
         8USiil4PuWv2J0UYrlH4eAUccLeE7LT83lyjeIy1+kUXRLV79uASYNN8Njk9/3QemBX9
         IgAsT4Ufdpv6TgUblOtL7zMsUvwa9w0xgJAcuhoFF7R10OK+luKq1MoixQbscaQYhH6K
         35j2r5SYJJt6zNHsJJ806eIJSqR5iBHGJ9dg6N/xDP//mfwEAqiByZMZ5WIjovaBwk49
         xjyGvM+WNI+qcBBIocnQh8cfVmm5/luh0BsHradXpmlDlqgtiF23UfixA31xWBxn3fJ3
         pbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767465779; x=1768070579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bcf3JMltMq6B3ayh2KI2Hnl3zzMj0i9VG17bkzRAzBo=;
        b=rRDBTe3HddqzVVQjwTspS6c1KYIvBM8PtN6Kh2V5t4pra4HjCly7A6yG/ORrCjgSKZ
         otGD9dtIXpJI5Ee1YzPctsymXAK/ZIeQixdx7P1FnBHUoYcMubhnO7Sw38ZzNW83Atzu
         xzoM1l/6hMfN1NY1KxKZdE+Ksi4P+AZ0xTgz4rFII3kvqX0YDKy3Q6Z9ks4J75QMmPmi
         sgF2ZMHsObIxvXiv7iSFf6IMG6ILqH89ZynTInCIvMpJhgFR4S9TEdpkYdZE5ai9Laax
         WndEWJ4UguI6BrwNpcK7bpNAAPLYTw4tXCv3C+blSe4EWsnTiwrsY7i6KXvQ5dg872Lw
         FPEg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+TpEyPiu3SvA/Y+7rnIfftB24ZhvAUg4VDEWkpkWI66H3EFyA01elwbHqUTTQk9zuJTdZ+38X0V4ISmdeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEBLIaU19S00N4bSeBU1UaHY7vpNMC065wtujvWImbbKJpUxg
	zY9W3Igg9si2kKy73kCh/Tmbtn+ICTouj4fHi9Gr1a/UpbA91qOb53+tBQ2Qr73Jiob02P7h+ku
	KfS4DwV+NYrhCIUoQ3xXgG5xEx0UM+vg=
X-Gm-Gg: AY/fxX4jjWCEP5nM1L639yQbX3eo975q6evcixmr9kcJh+lhjtc7NjWP6/HNhuHrV57
	8d0a3JbT5tbzfUBeFKBnB6/yT78NuoAwJDMLtN8mlo6FXqlG/AdB1cSSQ7EXgMOssxdNmWhEao2
	yVpBYx1chLxZb4OYfIW1895O1FlfY0383tm+TGCdc0u7QO44k+DTzOBwd9HyvCBTcj/5aF34+yH
	QddcBO2cP3SbwXGlQqSgIiy8w8Ir4pUt4EEr5RagpUjHKlKJw12/SRv9lmhFl3xX/FkFXDdjDd3
	uFgGLlS4CKt5/aW8qd9205ZBepQ2f9lmPS7i6qzZzmkQ0Lxw61RDqEr5/A==
X-Google-Smtp-Source: AGHT+IFH05B+rMrvSMPIiZrsPLgws1FCVH8qzxE+CGadN526lnrLQdsn/Qo5n5+Tsk7x6vjxyppwePBD/Tdg7Rg6s9A=
X-Received: by 2002:a05:6402:520b:b0:64b:a79f:da3c with SMTP id
 4fb4d7f45d1cf-64ba79fdc02mr51226141a12.34.1767465778917; Sat, 03 Jan 2026
 10:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101062543.186499-1-zbowling@gmail.com> <20260102200315.290015-1-zbowling@gmail.com>
 <20260102200315.290015-5-zbowling@gmail.com> <CAGp9LzrdvaPPLUi9TgenXvD6jWdOK-=95D_Fo2UYOppyzGPprw@mail.gmail.com>
In-Reply-To: <CAGp9LzrdvaPPLUi9TgenXvD6jWdOK-=95D_Fo2UYOppyzGPprw@mail.gmail.com>
From: Zac Bowling <zbowling@gmail.com>
Date: Sat, 3 Jan 2026 10:42:47 -0800
X-Gm-Features: AQt7F2rzCrrGXs_P0KILVWkad7Ucdn-ziUPoIM_FiF0IuE-c3Zo_jCn5n0SjXiM
Message-ID: <CAOFcj8Qy=6gpKpkph_rj8Nyc82t_q87XM8B3hhmX0Rijv-FxeQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt792x: fix firmware reload failure after
 previous load crash
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

Thanks! I don't have a MT7921, only a MT7925, so no unfortunately. I
ordered off Amazon and should be here in a week or two.

Zac Bowling

Zac Bowling


On Fri, Jan 2, 2026 at 10:46=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wr=
ote:
>
> On Fri, Jan 2, 2026 at 2:03=E2=80=AFPM Zac Bowling <zbowling@gmail.com> w=
rote:
> >
> > If the firmware loading process crashes or is interrupted after
> > acquiring the patch semaphore but before releasing it, subsequent
> > firmware load attempts will fail with 'Failed to get patch semaphore'
> > because the semaphore is still held.
> >
> > This issue manifests as devices becoming unusable after suspend/resume
> > failures or firmware crashes, requiring a full hardware reboot to
> > recover. This has been widely reported on MT7921 and MT7925 devices.
> >
> > Apply the same fix that was applied to MT7915 in commit 79dd14f:
> > 1. Release the patch semaphore before starting firmware load (in case
> >    it was held by a previous failed attempt)
> > 2. Restart MCU firmware to ensure clean state
> > 3. Wait briefly for MCU to be ready
> >
> > This fix applies to both MT7921 and MT7925 drivers which share the
> > mt792x_load_firmware() function.
> >
> > Fixes: 'Failed to get patch semaphore' errors after firmware crash
> > Signed-off-by: Zac Bowling <zac@zacbowling.com>
> > ---
> >  mt792x_core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/mt792x_core.c b/mt792x_core.c
> > index cc488ee9..b82e4470 100644
> > --- a/mt792x_core.c
> > +++ b/mt792x_core.c
> > @@ -927,6 +927,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
> >  {
> >         int ret;
> >
> > +       /* Release semaphore if taken by previous failed load attempt.
> > +        * This prevents "Failed to get patch semaphore" errors when
> > +        * recovering from firmware crashes or suspend/resume failures.
> > +        */
> > +       ret =3D mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
> > +       if (ret < 0)
> > +               dev_dbg(dev->mt76.dev, "Semaphore release returned %d (=
may be expected)\n", ret);
> > +
> > +       /* Always restart MCU to ensure clean state before loading firm=
ware */
> > +       mt76_connac_mcu_restart(&dev->mt76);
> > +
> > +       /* Wait for MCU to be ready after restart */
> > +       msleep(100);
> > +
>
> Hi Zac,
>
> This is a good finding. Since this is a common mt792x code path, have you
> also had a chance to test it on MT7921?
>
> One small nit: the Fixes tag should reference the actual commit being
> fixed, e.g.
>
>   Fixes: <commit-sha> ("mt76: mt792x: ...")
>
> instead of the error string.
>
>                   Sean
>
> >         ret =3D mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(d=
ev));
> >         if (ret)
> >                 return ret;
> > --
> > 2.51.0
> >
> >
> >

