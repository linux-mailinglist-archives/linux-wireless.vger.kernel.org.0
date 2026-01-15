Return-Path: <linux-wireless+bounces-30841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3611BD22C70
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9652F3018356
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 07:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D8329C40;
	Thu, 15 Jan 2026 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoWy5ZF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1C2E090B
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461580; cv=none; b=Is4rQ2VIvXluBMhopp8pm96MKQWC1YPyLC7Iz8ktwwrxEp50NXV+hsGyzNvlqnI7bI3bMN1zqHAmEiJ773GDS39oOQoGbZ4+xPiq3lwP3h1FiYjZM4NXz1SkyCIQfkzezp8T82Jd5tqHohQsXop8qjsrsmhxj6hB6cU0N0dMiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461580; c=relaxed/simple;
	bh=9Kit2tUkn4yeuCCRo7RysNTmX3aWbGfheTdACCzBk8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiVQD5UQHyDzLW+NwIgVeagjy/DArnchfv7GhYqgr4iwLDOiExKVOG790NmPp9awqomxrpZkgP8Pso7tTHwaHupSJK2J93AaBt/BCk+GJYR9VIdat0RskZz50ebysNTRqL6RRbEroRxE+F5ELwExnysUaAgmpwdhvqI2TeeNljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoWy5ZF/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so2980218a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 23:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768461574; x=1769066374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/5XmxwHwYCP8/uagwllmfFu0i9L1U3rU59lyz06mIM=;
        b=CoWy5ZF/LZH0GyLhfu6owfMZBb8psQVTJn6EcyTrR0QTx3M4++k4oCnabeWjcgW5GL
         c4Ru71FMAGvO3SZT8D/EPOopFNJy01dNL2ytzjCMx5fnaLTZmZJJQSIsd18fwHJtVnUA
         IRU5ODEmacgg3XKMB2GzmYMaSBOsuqWGvEELrgcCfA8qUp30Y5L9cku7m4c6oWH9ofL/
         m4bKpViyrgYl0iBztEMIxXn2N/6oiRSVu0tbGxubmfsU1BpiJlpP369ze6sSm3RmGomb
         mMZdcI/BX4ULLT3rlQurjOPJJ7lfVkNWvDAL8g7KofXxLBJIBeOO+jKxrUxhaWwryf0U
         9sSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768461574; x=1769066374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/5XmxwHwYCP8/uagwllmfFu0i9L1U3rU59lyz06mIM=;
        b=ud1mGhzSuq3qKGCxAq6i6+m2YlrMFp9+ZhY7l3t9zDXRP7qz2RQy6E4wy+Oghf9Lzw
         ILpZR6a+JSRKBxdG2TvlTzDubJHm9Cz8kP3gnmyVeM44t2HqP1uNqq50as2Of/ze7IIY
         Zsh5rYXEaohBnobXaqLF/zprIgB0/vbtMehr/OZ4Sca6LHdIc8hN2MMC+GFhdxvbgDlK
         t7sJuOxtHFVMRKz1SMJ7TGYeDX+02QNteBlR2jE6nEdhhTYNcZfpeJJIMgKug61CMfU0
         kdwMb8ldBOKMYjpvTOY40/otf71qssdiyftFnvv+/lvnKzTEJlenpJZRygsA8RGFpBAy
         bxvg==
X-Forwarded-Encrypted: i=1; AJvYcCWjnPECfNDMjPwgWxReNtxZg6RUU9Y3Ud2scv/XiHVELPkQAXDz1SVVHWdBlet20/B/nOsGEqdQ3tFuQdroUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6xS+IfJND8kexNyO/oybamYPrR2dCmBTVZwJP5AuCPOBlTL4
	5EZpWUIKIHkr+Rd1mEEkVEbCQt8THO9tx47XRXUWp1SLefDYWe20hwqJ5h3mIqJLVAd/exORB2J
	dQU1/dvFsiW5J7+xs+iEHJt/l9vhNSFY=
X-Gm-Gg: AY/fxX6jjnzmjttAMPWuIhl+L97BhSzkgyUihN8tko65ewl9QKi2ASCeDPrda7MqO5i
	F/4UMvDG3QGJ4E0wsSfB/tKWxrSQZHUXOi43tLizj19ph9v57gfwsYVi1L4uN/hXDIe/dtPtBlE
	R08+LEottqRMiHR/2O0QbMhTWrhGSf8VCesbwtCeWGAyE/+8U4KjK4M4b7rCBe0cQrCInexcH4P
	5NkJXCkwMLg0bsj/uKFGSoiEiRAfhpGa5F42oQDxvAq3IovjLPPbpZvRQBIX0aoJ+yJAFnGrNlL
	8Qtg5F3yMGuoIX6mPfY2CMOIwyxiu8hQgOuSfNu2BvvFF5FM8qnWnGbrmA==
X-Received: by 2002:a05:6402:6c9:b0:653:c2ad:6d93 with SMTP id
 4fb4d7f45d1cf-65412e18ab4mr1261487a12.2.1768461573636; Wed, 14 Jan 2026
 23:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101062543.186499-1-zbowling@gmail.com> <20260102200315.290015-1-zbowling@gmail.com>
 <20260102200315.290015-5-zbowling@gmail.com> <CAGp9LzrdvaPPLUi9TgenXvD6jWdOK-=95D_Fo2UYOppyzGPprw@mail.gmail.com>
 <CAOFcj8Qy=6gpKpkph_rj8Nyc82t_q87XM8B3hhmX0Rijv-FxeQ@mail.gmail.com>
In-Reply-To: <CAOFcj8Qy=6gpKpkph_rj8Nyc82t_q87XM8B3hhmX0Rijv-FxeQ@mail.gmail.com>
From: Zac Bowling <zbowling@gmail.com>
Date: Wed, 14 Jan 2026 23:19:21 -0800
X-Gm-Features: AZwV_QjK0v0tbT6r_b00Qb_Rg8mpI0meBJa8q-dEZ2am_HkmFWL9JtfuJmh_Ov0
Message-ID: <CAOFcj8SnLPZoq7JLhUGZKmJVTt=iGC6AcTxghauz91PfDCm+ew@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt792x: fix firmware reload failure after
 previous load crash
To: Sean Wang <sean.wang@kernel.org>, linux@frame.work
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While I'm still waiting for feedback from folks on these patches, I've
set up a public repository with all the fixes for others experiencing
these issues and created a DKMS package for folks so they can easily
load these patches as an alternative driver since so many folks are
running into these same problems on several popular commercial laptops
and desktops:

 https://github.com/zbowling/mt7925

  The repository has:
  - All 18 patches from this series I've sent here (different versions
of these patches that apply cleanly to different kernel versions)
  - Pre-patched kernel branches (6.17.x, 6.18.x, 6.19-rc5) in another
repo linked in the README
  - A new DKMS package for out-of-tree builds (requires kernel 6.17+)
with various hacks with #ifdef kernel versions so that the single
package works for all recent kernels.

The DKMS package builds mt76, mt76-connac-lib, mt792x-lib,
mt7925-common, and mt7925e modules with all fixes applied.

Testing in the community with everyone experiencing these same panics
in the current upstream version, I've heard feedback from many folks
that this patch series (either just apply the patches or using the
DKMS build) that this fixes most of their issues.

There still seems to be ongoing issues inside the firmware related to
MLO and deauths with certain APs (especially with my Unifi U7 Pros)
but at least this keeps machines from crashing while it the chip
resets so you only suffer momentary losses in connectivity instead of
straight-up kernel panic or a deadlock.

For anyone still hitting the NULL pointer dereferences, mutex
deadlocks with NetworkManager and friends during MLO and deauth
situations, or suspend/resume hangs with mt7925 - this DMKS package or
these patches should greatly help.

Happy to address any review feedback whenever you finally have a
chance to look at these.


Zac Bowling


On Sat, Jan 3, 2026 at 10:42=E2=80=AFAM Zac Bowling <zbowling@gmail.com> wr=
ote:
>
> Hi Sean,
>
> Thanks! I don't have a MT7921, only a MT7925, so no unfortunately. I
> ordered off Amazon and should be here in a week or two.
>
> Zac Bowling
>
> Zac Bowling
>
>
> On Fri, Jan 2, 2026 at 10:46=E2=80=AFPM Sean Wang <sean.wang@kernel.org> =
wrote:
> >
> > On Fri, Jan 2, 2026 at 2:03=E2=80=AFPM Zac Bowling <zbowling@gmail.com>=
 wrote:
> > >
> > > If the firmware loading process crashes or is interrupted after
> > > acquiring the patch semaphore but before releasing it, subsequent
> > > firmware load attempts will fail with 'Failed to get patch semaphore'
> > > because the semaphore is still held.
> > >
> > > This issue manifests as devices becoming unusable after suspend/resum=
e
> > > failures or firmware crashes, requiring a full hardware reboot to
> > > recover. This has been widely reported on MT7921 and MT7925 devices.
> > >
> > > Apply the same fix that was applied to MT7915 in commit 79dd14f:
> > > 1. Release the patch semaphore before starting firmware load (in case
> > >    it was held by a previous failed attempt)
> > > 2. Restart MCU firmware to ensure clean state
> > > 3. Wait briefly for MCU to be ready
> > >
> > > This fix applies to both MT7921 and MT7925 drivers which share the
> > > mt792x_load_firmware() function.
> > >
> > > Fixes: 'Failed to get patch semaphore' errors after firmware crash
> > > Signed-off-by: Zac Bowling <zac@zacbowling.com>
> > > ---
> > >  mt792x_core.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/mt792x_core.c b/mt792x_core.c
> > > index cc488ee9..b82e4470 100644
> > > --- a/mt792x_core.c
> > > +++ b/mt792x_core.c
> > > @@ -927,6 +927,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
> > >  {
> > >         int ret;
> > >
> > > +       /* Release semaphore if taken by previous failed load attempt=
.
> > > +        * This prevents "Failed to get patch semaphore" errors when
> > > +        * recovering from firmware crashes or suspend/resume failure=
s.
> > > +        */
> > > +       ret =3D mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
> > > +       if (ret < 0)
> > > +               dev_dbg(dev->mt76.dev, "Semaphore release returned %d=
 (may be expected)\n", ret);
> > > +
> > > +       /* Always restart MCU to ensure clean state before loading fi=
rmware */
> > > +       mt76_connac_mcu_restart(&dev->mt76);
> > > +
> > > +       /* Wait for MCU to be ready after restart */
> > > +       msleep(100);
> > > +
> >
> > Hi Zac,
> >
> > This is a good finding. Since this is a common mt792x code path, have y=
ou
> > also had a chance to test it on MT7921?
> >
> > One small nit: the Fixes tag should reference the actual commit being
> > fixed, e.g.
> >
> >   Fixes: <commit-sha> ("mt76: mt792x: ...")
> >
> > instead of the error string.
> >
> >                   Sean
> >
> > >         ret =3D mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name=
(dev));
> > >         if (ret)
> > >                 return ret;
> > > --
> > > 2.51.0
> > >
> > >
> > >

