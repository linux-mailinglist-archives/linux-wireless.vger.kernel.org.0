Return-Path: <linux-wireless+bounces-28387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB13C1D2C7
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 21:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59D814E17A9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC4314B85;
	Wed, 29 Oct 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqVKZDfl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B0311587
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768746; cv=none; b=RonKkaL76dh+dNZiUfgY41b3B2XPgQtN3/BxA3jhdsSzqvlD9KrDDZfBPgyW6Ppiz2tAA9fXJyh00bH2ovnn+Apn0uQMPTOoH8TP8v+BZl96z0C2CX6ROkWzzBphmSGBz/K5+SpgJYU5HBNKEueWQLF3iT3d+Dh7BTlv9Clyvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768746; c=relaxed/simple;
	bh=um/tVoXbdEDWtRKbDPvUuQcW+0FcwrOb0U/tmwLwaek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDL3juRmxKVKvrYFK0+RxFrnRpQwOuwnFe5V2YRV2jtB+3a9+YUmozAjJciulNlZ2J92IWayDR++zNv60aR3QuanaHso/NozJq8DZ6lbkJrhsL9SQbfyrBi5NBlVpblqMn2vcSXmEMjIbbLkPy9I2VcaTaO+xnMZWgl++KpTADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqVKZDfl; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e1a326253so438518d50.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761768743; x=1762373543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC8sv5nVVI5JjZAVR+hifwSr8nAzhJqQduX4ujCZR7I=;
        b=jqVKZDflRIaeh9eC2sCmAFs0sCyLWyxBlpfDzcln0UrqC67YFTdikbEBwjLa7dGXdE
         BzEibpp9ualSyfxUs1kJCZeFWp/mdvvHRMfmy3HIuzezjgFLakSd2mkd2lKmpMUt3VNB
         AJWEE2BCayboNzDmWryI5LO+kKkARB5x0t5KBN44uKbFYu6Lp+/2vdqXIs7e87ewz2Z2
         Yco4UI2uecN55KnGbrKd2c7uzvzb6FrvUDA+kRzJ2hxu4sXjsddsYdQ3LiX4f2QtqIUd
         uUzhM4+4/7dh9SRVqlppWfMPZwB3Plg/RestcMWLzhSPLUxQ9GkhmAKwRlPTajONNC/m
         7p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768743; x=1762373543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC8sv5nVVI5JjZAVR+hifwSr8nAzhJqQduX4ujCZR7I=;
        b=KR6cWiJ1SgYGt4G+JKMS5Y7Hu4wDYg3dipzkog7oXmFdaz0dkfP4aL39cJgssC6yZy
         R5piSyAbEhTwVWb3Izp03PZFtCo11TdNm8vnzAIr6wgYd2sovsaWnH8jCXAGP4LCfCey
         i7CdmzdWZbvZMRxDYWlYzwE5nUb6fO+kkrExxAZ71MTj5d8UOwncPQKF9M+fl/swaABX
         49sw0BDIBpjun8++7oH2oVt3RvfTwCSLdYYolNs9Yzainr1okvcYrsKzeqXAud0vnfb3
         lz5k9BTN5RV7eRjBM5sNizx4G6aFgHXDDJcFlom69iZVgt+dGJMhIjhg3lmD6nnn98Rs
         D2wA==
X-Forwarded-Encrypted: i=1; AJvYcCX5slDWdkfU+QcLktxQJqXRUUDQ8Ai2HLjDV+B8gAkw5kL0IAW37tS82Q6aUXtTZX3bIYxV/Oo8dsLi4IibUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHxZZgQ2tHnBuJyibkufNerXWaJLBftFDaNwjWP1TxgwAKTsa
	/afSUSg90rSHYrzqnvKtumgcbtNEEmdH5gxMhZ/gwT3QBEO44l5cFHQPik5MFJU/N/4tW+ETQdT
	mmqFs/gfZvwdSAuSrM8YEXYek0278KpCcxsA1
X-Gm-Gg: ASbGnctswXcNW0/TF/EhGVnuTTQje/+kGuwv8zgX4q6WfEFOiYX7VJZVwC6soQlpwEJ
	rBlEQxvd7nTivTBk1DqmK2kBrrcS12x3RNTJgKV6C0CENVSG8VUDKcN/UGwUhMp2cF1gaLggV8i
	D3DOb3TnnEeCwPW2WlzUz7UgFIEUxO+g1AQTMYExSUIaROBE6CdZoBgihur1OZjzS/H7o+9hchM
	DjO0JBlxoS838N/3Q1ZtYoiU2XfE4iqAvWx7m5kkIbXm4zQ4MnqD8bV+H8=
X-Google-Smtp-Source: AGHT+IHlC2vJ9MOy5SMuyr39csRGDgW2ebq4sozUhofv3qG694XVnBM5XEojvBZU5ygeiuDc1oaYIAG7PDq9K61FKLk=
X-Received: by 2002:a05:690e:dc2:b0:63e:2204:9416 with SMTP id
 956f58d0204a3-63f76d91439mr3487993d50.31.1761768742872; Wed, 29 Oct 2025
 13:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027171759.1484844-1-cjd@cjdns.fr> <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
 <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr> <CAOiHx=nqWEdHEMf5immXO0VwyzDakDV9AMsoDETcJ0F4FqUt=w@mail.gmail.com>
 <4d5fe35f-6841-4b73-9c8c-a1f3bce886c8@cjdns.fr>
In-Reply-To: <4d5fe35f-6841-4b73-9c8c-a1f3bce886c8@cjdns.fr>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 29 Oct 2025 21:12:10 +0100
X-Gm-Features: AWmQ_bnMO20yjsceLB8hiFSFJ1UyPWeJK08ZHhht06brEKUVc81COenzYsB_XPk
Message-ID: <CAOiHx=kfAwLzuoP2Y-AnGz4GysmszXq-f_et0rgd1j0thYv4Ew@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:24=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.fr> =
wrote:
>
>
> On 29/10/2025 10:15, Jonas Gorski wrote:
> > On Tue, Oct 28, 2025 at 10:42=E2=80=AFPM Caleb James DeLisle <cjd@cjdns=
.fr> wrote:
> >>
> >> On 28/10/2025 21:19, Jonas Gorski wrote:
> >>> Hi,
> >>>
> >>> On Mon, Oct 27, 2025 at 6:19=E2=80=AFPM Caleb James DeLisle <cjd@cjdn=
s.fr> wrote:
> >>>> When on a Big Endian machine, PCI swaps words to/from LE when
> >>>> reading/writing them. This presents a problem when we're trying
> >>>> to copy an opaque byte array such as firmware or encryption key.
> >>>>
> >>>> Byte-swapping during copy results in two swaps, but solves the
> >>>> problem.
> >>>>
> >>>> Fixes:
> >>>> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
> >>>> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
> >>>> mt76x2e 0000:02:00.0: Build: 1
> >>>> mt76x2e 0000:02:00.0: Build Time: 201607111443____
> >>>> mt76x2e 0000:02:00.0: Firmware failed to start
> >>>> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -1=
45
> >>>>
> >>>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> >>>> ---
> >>>>    drivers/net/wireless/mediatek/mt76/mmio.c | 34 ++++++++++++++++++=
+++++
> >>>>    1 file changed, 34 insertions(+)
> >>>>
> >>>> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net=
/wireless/mediatek/mt76/mmio.c
> >>>> index cd2e9737c3bf..776dbaacc8a3 100644
> >>>> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
> >>>> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
> >>>> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u=
32 offset, u32 mask, u32 val)
> >>>>           return val;
> >>>>    }
> >>>>
> >>>> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
> >>>> +                                         const u8 *src, int len)
> >>>> +{
> >>>> +       __le32 val;
> >>>> +       int i =3D 0;
> >>>> +
> >>>> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> >>>> +               memcpy(&val, src + i, sizeof(val));
> >>>> +               writel(cpu_to_le32(val), dst + i);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>>    static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset=
,
> >>>>                                    const void *data, int len)
> >>>>    {
> >>>> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> >>>> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offse=
t, data,
> >>>> +                                             len);
> >>>> +               return;
> >>>> +       }
> >>>>           __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_=
UP(len, 4));
> >>> Maybe just replace this with memcpy_toio() which does no swapping at
> >>> all instead of double swapping on BE?
> >>
> >> I'm not that informed about how PCI works so I had to test to confirm
> >> my understanding, but I can confirm that memcpy_toio() does not solve
> >> the problem.
> > Ah, right, I misread _iowrite32_copy() to do conversion to LE, but it d=
oesn't.
> >
> > What architecture is this you have? PowerPC? ARM? MIPS? 32 bit? 64 bit?
>
>
> MIPS32 (EcoNet EN751221 34Kc)
>
>
> >
> > So the differences I see are:
> >
> > 1. __iowrite32_copy() uses __raw_writel(), which has different memory
> > semantics than writel()
> > 2. __iowrite32_copy() assumed src is aligned to 32 bit, while you
> > explicitly align it
> > 3. memcpy_toio() will handle unaligned src properly, but does 64 bit
> > accesses on 64 bit systems (and uses __raw* again).
> >
> > Is src aligned? If not, then the issue might be 2. And if your system
> > is 64 bit, it would explain why 3 didn't help.
>
>
> I'm not a regular developer of mt76 so I wasn't sure if that was
> guaranteed and I just wanted to code for safety.
>
> After reviewing the code, I see that there are a few places where
> mt76_mmio_write_copy is being called with stack-allocated u8 arrays
> so it's pretty clear to me that this is being treated as a memcpy-like
> function and we should be handling unaligned inputs.
>
>
> >
> > As a first step you could try to replace the writel(cpu_to_le32(val)
> > with a iowrite32be(val, ...) which should do the same except avoiding
> > the doubled byte swapping. If that works, you can try to replace it
>
> This works.
>
> These symbols are a bit of a nightmare to trace, so I ended up making
> an .i file so I could confirm what's happening.
>
> iowrite32be() uses the version in iomap.c so I understand that's using
> writel(swab32(val),port), so a writel with an unconditional byte swap.

>
> writel() is more complicated, it's an inline function that is generated
> in a rat's nest of preprocessor macros in mips/include/asm/io.h
>
> The preprocessed is this:
>
> __mem =3D (void *)((unsigned long)(mem)); __val =3D (val); if (sizeof(u32=
)
> !=3D sizeof(u64) || sizeof(u64) =3D=3D sizeof(long)) { *__mem =3D __val;
>
> The source is this:
>
>      __mem =3D (void *)__swizzle_addr_##bwlq((unsigned long)(mem));    \
>      __val =3D pfx##ioswab##bwlq(__mem, val);                \
>      if (sizeof(type) !=3D sizeof(u64) || sizeof(u64) =3D=3D sizeof(long)=
) \
>          *__mem =3D __val;                        \
>
> The line "pfx##ioswab##bwlq(__mem, val);" is ioswabl() and the source
> of that explains the issue:
>
>   * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardwa=
re;
>   * less sane hardware forces software to fiddle with this...
>
> So this confirms my initial understanding, the PCI hardware is doing the
> byte swapping unconditionally.
>
>
> > with __raw_writel(), which then would make this the same as
> > __iowrite32_copy, except making sure that src is aligned.
>
>
> This fails.
>
> Since I'm the maintainer of this SoC and it's still fairly new, I wrote
> a trivial kmod to verify that unaligned access is not just silently
> returning trash, it works as though it were aligned so alignment is
> not the issue.
>
>
> >
> > Also you could replace your memcpy() with get_unaligned((u32 *)(src +
> > i)); Should do the same but inline.
> Good idea, I will do this.
> >> The issue as I understand it is that rather than making every driver
> >> carefully call cpu_to_le*() every MMIO write, someone decided to make
> >> the PCI host bridge itself transparently byte-swap all MMIO on the
> >> wire. Since most MMIO is hitting registers and most buffers are
> >> transferred by DMA, for the most part everything works and nobody
> >> notices.
> >>
> >> But in the rare case that we need to write a blob to MMIO, it gets
> >> transparently swapped in hardware so you need to use cpu_to_le in that
> >> case. Doing a search of ./drivers for write.*cpu_to_le I can see this
> >> issue comes up a bit.
> > Every (PCI) driver does conversion to LE implicitly by using
> > writel/readl (or iowrite32/ioread32) etc do the conversion to/from LE.
> > So writel(foo, dst )is a __raw_writel(cpu_to_le32(foo), dst) etc. PCI
> > memory is assumed to be in LE. If you are on a little endian system,
> > then no byte swapping happens, and on BE it will do byte swapping
> > before writing the value.
>
> Okay so it seems that in the case of MIPS, that's not always how it
> works.
>
> https://github.com/torvalds/linux/blob/e53642b87a4f4b03a8d7e5f8507fc3cd0c=
595ea6/arch/mips/include/asm/mach-generic/mangle-port.h#L17
>
> Since we don't know if the swap will happen in hardware or software
> and (AFAIK) this is not a hot enough path that double-swapping will
> have a notable performance penalty, I think the most sane thing to
> do is use writel(cpu_to_le32()) and not care if it's swapped back
> in the kernel or hardware.

Oh, I think I see what it happening here. ECONET is a Big Endian MIPS
platform, but does not select SWAP_IO_SPACE (most other BE platforms
do).

Does that mean the PCI space is swapped in hardware there?

I guess that means that anything that uses __raw accessors to PCI
space directly or indirectly is broken, as the raw data is now
actually in the wrong order and needs to be swab'd.

I don't know if it is a good idea to change this in __iowrite32_copy()
/ __ioread32_copy() (and other helpers), or if there are drivers that
use it on non-PCI spaces and would be broken by that.

If there is a way, I would suggest disabling hardware conversion and
selecting SWAP_IO_SPACE, but that will affect a lot of your code that
assumes that writel() etc don't convert to/from little endian.

Best regards,
Jonas

