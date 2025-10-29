Return-Path: <linux-wireless+bounces-28353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F2C1959B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B153AA6B8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B662D3724;
	Wed, 29 Oct 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsTbBoAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBE25F96B
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729339; cv=none; b=fbtgafXJJNrxzfjQErukSx3PT4ntEYC1Hl0N4pPG/emKzJsPmHSgdwsat+1CPfFLV7JFs2ZxHohC66fV1tCcTWD0jOi5os8Y9h/h5hQ5fBeMj1HQXxgczundn6fl12MX+kIpNSW2b7JQfZtsWBpAFX1Dw82O0CpejuOGKs5iA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729339; c=relaxed/simple;
	bh=itjsDcySguGaFki53FVnzohhMjE5+9HRovLjl7e5KEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7e/QXlPKOO7k5W3GbNzXCkLR1j2PsZGOmBlcRVsdl96FL+mLE7EpQ/BxpLxG7VBoZXNNI1HuF/Av8SzLXcQXWFwDqJlBkCi80rfk22FuGBo4Vfk+bQ+pQUs1HQBs9MhryjMzX/SaH0Bv0bKi9XAut+y+/4/FrRtxdAdSlkxq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsTbBoAK; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78485808eb3so79743787b3.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 02:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761729336; x=1762334136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UygssEPwtyV4QTrYeX1AiLSpA4gBFv6ObS7fU3X7V2U=;
        b=RsTbBoAKdChs3u8HeEImtn3XsdxcY/nT5avZ8hOVQGdIKxahhuxWZMWoIXPTbzOdAs
         wVjUSQBwHfj1vVvdNIJDUKxNXntGysUDVm0jdjFIwbARqbFwReho2jI3R2eY4p3ENNqK
         4KDccfNWLImRaXZ7QUYCst8M9sOv6MOlBo2AHEVoDsX9v6s9vsBstqQoO6SE2A/usQzI
         ApGUF8OeaSoB3tGuIv/iQT7BibIvX7zPzJbSviq1ENHVTYo066GI359S0QHFYOMkrtgT
         fcSi0QRBD60W6ckqaJIS7oqSozJXCUvce2midHR8CpUo4aBcruTTVqXkVwNAT+4veBg2
         82LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729336; x=1762334136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UygssEPwtyV4QTrYeX1AiLSpA4gBFv6ObS7fU3X7V2U=;
        b=X/Tar1/BIsOvkJEA/aaLXYpQAW+vR9wtihW5koD3QeDwbjugX6mSx01K1wOGmkCOR1
         FvinESIXuN0OtIKlo+2ZzkZ7FnLdgv8k1+IyNpMkR81ZcfiWggz81CFGPFQbqzxzGX7G
         L0oa+KlZMQFMjSkzq7Tvjp1L+ppv0G1WM/RmWzSdkEwtBOItYQKBGt1zoHYqiQBNH7m0
         jaz7GkXCwPi9n85FDTSvw3FRmUms7Jr9830JQqlQekNjLki6av94ioECDimRCRVGP5PX
         ntvecr76AzjAH3dad5eWDBuOz2b0ZUnE4bM/Dt4KxkTlhBkW9OvPzFB0FNoWwOUKjGdy
         kn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWU8X2r6o/y3rmBzFfaD3aHV4HQI09LQvzQrxbIelXnkwj8x5SH42tDzra8qlfbqbHDGA0llbwP53uP7h5uUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQJ2w4O8cMBGRrqG0R94RLFdIIWR96kwFuh2kIgB9JPecGalC
	qPwdN52K4MurU0r9NxDmYgKda05qVrUI48rQGYC18vXa4S5FNkrYGU3DrxIm+BNQ/WIxxeBB8yr
	GMtUSmiLZBWVSKjZ6/P1DLBoQuSn2Y84=
X-Gm-Gg: ASbGncuFhjpULqds4R4PDlheuV6KqErMPKvsZoW04+tCjQdpV88qy1X3aIQfRbTwgmq
	mXwVD5qs27kTnRDJAj3asKH3sa6gWH3SzUdBvJF0hlCldOPMMPYaAo1GUv66rSa22sz8PX7nq7u
	IKIvhnGjCE5HIqTvZWTcuystrlcWeLD2WLVrMETRC5oZ0LGMgTyl5waapNlpEJb1UjUaaELMbjy
	4dF6pfyQ/+F/VpSzjFj1yCU+e/Q9IF/nQN6iKSn6LCcBHX9bKaelrHmnkQ=
X-Google-Smtp-Source: AGHT+IEQDyFSthCYxiKEqlJv14a8jhCmiZaL70iGNaUt1WzUGm5AZRwZxAZ/eefAJU3mVt3LlAEv2c8FlDqRddjvGN8=
X-Received: by 2002:a05:690c:74c2:b0:781:1c9e:fc82 with SMTP id
 00721157ae682-7862903d263mr21137247b3.48.1761729336254; Wed, 29 Oct 2025
 02:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027171759.1484844-1-cjd@cjdns.fr> <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
 <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr>
In-Reply-To: <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 29 Oct 2025 10:15:24 +0100
X-Gm-Features: AWmQ_bmyo1Vk5GBvVeX6G5wl6wdQm6iXyIxD4JsyZ1GGxh0xGeFFX2edoLr2NHM
Message-ID: <CAOiHx=nqWEdHEMf5immXO0VwyzDakDV9AMsoDETcJ0F4FqUt=w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:42=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.fr>=
 wrote:
>
>
> On 28/10/2025 21:19, Jonas Gorski wrote:
> > Hi,
> >
> > On Mon, Oct 27, 2025 at 6:19=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.=
fr> wrote:
> >> When on a Big Endian machine, PCI swaps words to/from LE when
> >> reading/writing them. This presents a problem when we're trying
> >> to copy an opaque byte array such as firmware or encryption key.
> >>
> >> Byte-swapping during copy results in two swaps, but solves the
> >> problem.
> >>
> >> Fixes:
> >> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
> >> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
> >> mt76x2e 0000:02:00.0: Build: 1
> >> mt76x2e 0000:02:00.0: Build Time: 201607111443____
> >> mt76x2e 0000:02:00.0: Firmware failed to start
> >> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145
> >>
> >> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> >> ---
> >>   drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++=
++
> >>   1 file changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/w=
ireless/mediatek/mt76/mmio.c
> >> index cd2e9737c3bf..776dbaacc8a3 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
> >> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32=
 offset, u32 mask, u32 val)
> >>          return val;
> >>   }
> >>
> >> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
> >> +                                         const u8 *src, int len)
> >> +{
> >> +       __le32 val;
> >> +       int i =3D 0;
> >> +
> >> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> >> +               memcpy(&val, src + i, sizeof(val));
> >> +               writel(cpu_to_le32(val), dst + i);
> >> +       }
> >> +}
> >> +
> >>   static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
> >>                                   const void *data, int len)
> >>   {
> >> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> >> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offset,=
 data,
> >> +                                             len);
> >> +               return;
> >> +       }
> >>          __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(=
len, 4));
> > Maybe just replace this with memcpy_toio() which does no swapping at
> > all instead of double swapping on BE?
>
>
> I'm not that informed about how PCI works so I had to test to confirm
> my understanding, but I can confirm that memcpy_toio() does not solve
> the problem.

Ah, right, I misread _iowrite32_copy() to do conversion to LE, but it doesn=
't.

What architecture is this you have? PowerPC? ARM? MIPS? 32 bit? 64 bit?

So the differences I see are:

1. __iowrite32_copy() uses __raw_writel(), which has different memory
semantics than writel()
2. __iowrite32_copy() assumed src is aligned to 32 bit, while you
explicitly align it
3. memcpy_toio() will handle unaligned src properly, but does 64 bit
accesses on 64 bit systems (and uses __raw* again).

Is src aligned? If not, then the issue might be 2. And if your system
is 64 bit, it would explain why 3 didn't help.

As a first step you could try to replace the writel(cpu_to_le32(val)
with a iowrite32be(val, ...) which should do the same except avoiding
the doubled byte swapping. If that works, you can try to replace it
with __raw_writel(), which then would make this the same as
__iowrite32_copy, except making sure that src is aligned.

Also you could replace your memcpy() with get_unaligned((u32 *)(src +
i)); Should do the same but inline.

>
> The issue as I understand it is that rather than making every driver
> carefully call cpu_to_le*() every MMIO write, someone decided to make
> the PCI host bridge itself transparently byte-swap all MMIO on the
> wire. Since most MMIO is hitting registers and most buffers are
> transferred by DMA, for the most part everything works and nobody
> notices.
>
> But in the rare case that we need to write a blob to MMIO, it gets
> transparently swapped in hardware so you need to use cpu_to_le in that
> case. Doing a search of ./drivers for write.*cpu_to_le I can see this
> issue comes up a bit.

Every (PCI) driver does conversion to LE implicitly by using
writel/readl (or iowrite32/ioread32) etc do the conversion to/from LE.
So writel(foo, dst )is a __raw_writel(cpu_to_le32(foo), dst) etc. PCI
memory is assumed to be in LE. If you are on a little endian system,
then no byte swapping happens, and on BE it will do byte swapping
before writing the value.

Best regards,
Jonas

