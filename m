Return-Path: <linux-wireless+bounces-22757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE780AB04B3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A4B170578
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101C284667;
	Thu,  8 May 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIqjP2w6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A901E4BE
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736485; cv=none; b=MlGS0b5d6HRrnsVzVfTn4qerRkEWhG7ew4X0t4Uf5FqYZBo0kimr+O7Gr/MjOD3otz1dku7wXZ7SEoJSuzXU07TLewUN+j9Yt1Ky1NiDAGGywDBUdo9wmouB6bu9fBUtjM4Ze1qQpXWTYHVxE8LrpEM3xMOfof39b9Opjq7Ibfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736485; c=relaxed/simple;
	bh=bP2Pf6SXwn7FpWaU6TdYJx0/WYYo8BLZoS3AgYfFMzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YNomq6/hcwcTi5B+U+qm6wXgRAdfAZeLlLTuwU+AdI0EIZ1/99JA3KdL8Z36RXjbtAnXeJIQ3xKsg6MxUSR+jTsP8T9QDVpNz/CWdLd3vknfhbKqSdVs3BuvcVtc5fYWD3cCp8PLKlEyhovDNQNBILUtP7MzEGDJ/29hS+Svk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIqjP2w6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25d2b2354so238081266b.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 May 2025 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736482; x=1747341282; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpiGmGmsn7qvi89P3DpfkRsxq67BoNdkh3fWqhgRW94=;
        b=SIqjP2w6MqlcWmbQkQ/h49U5WRdG5z0qxW7xr1sSdoJTt9+EN+hJGXWk8A9llVbh9s
         ClSFHEfzul/93t5QEQ6B1vjllayTPQ1ipktj5M6A4iAQgRwli1NZQZOcKSvAl7O8e4Q9
         23oxh98kwQy1y5wZqAAx+B6dfTHpnvr8DZ1PgD4fZ6ZcoYVq+pTmCkZm/wEJG4A0YDPd
         VSpeXKo/Eq82IIbRTt3D/lVU/EKu3qSxFcrydo64Lc9CRcWm7ut1NnuPZhecoowp4982
         hyAZVdqTBRYm+6d+HSc4KW50ptSA0a8w/7QCqZQg0/wymy5wjpWaHyMmP9P5in9GeYAC
         pTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736482; x=1747341282;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpiGmGmsn7qvi89P3DpfkRsxq67BoNdkh3fWqhgRW94=;
        b=dSBcO8wfGjiC9VnNJOM+9Da1QS+eNEnOx+9D9gIoeiNHrnIS9yQI0iz4OVW0I9/T/6
         vsh3nDWjBtmHlH8uysgm4cXQcnosOXG2b3adrB+07V2LsIeXjsO7dnq2ziHjfPBGgW8o
         GjRUa0RyV3Zeq5OTdoUAyOq2Sh85rj++BxnJEVgouBgKjo3e3CINAa3lm28gyn9y2gmD
         h9ED8Ws42Suw4N8i5HXMr8LIqjRK75PWZk3OIY5vU8fRV2H5ZEbcyK6iJfnqGok/c5LF
         xNXBlfDwyt8w9PeWeHlFQR31Uzzfxywf0xQGx6iaVUXteut+m8Zd9BInzI3itZFQi3+O
         ihFw==
X-Forwarded-Encrypted: i=1; AJvYcCWjCHL5TeoKsN0ctPFhKcgNXGiTEdalL44G7Nx/qgFGIep+y1uf7/d05Fw3XJlDyU2nZegPVke/CeDRHzYMHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqaLvJWnS01qg7jTXaYCq1UFDf4uFV5ihBpaGnjzp0tlHdrDcC
	SxQnpGwcT6hRbIijaI0c2FGD+GmMAad4Ap1tm6Qjo6GbTWLlrU8nK3gRSqYfxSwdKfbfovq/Qn9
	DWoGf2x1Ju2MQuCJC+qalnENvjkc=
X-Gm-Gg: ASbGncuYKvSmU96x8ORrNq9prryJjtiEggDzGEgnICP6pYgQkfcnFkYyYwxDw+HrxUP
	6ngV/fz03DvplURjm+BYC2LJTnz53MARODx2bsqBw5dgTpEuTzmjLUDjA68qvk7fmsi418A8f3+
	rHXlLis1Yjhrudi7+BpyVfPVpPTsDhZIpaVgb3Fmo4X1/kA5g57dbLhHmMNPTQZ7Ep
X-Google-Smtp-Source: AGHT+IFMn0RlHyrgMVQipzfktU2amZP5WR9WDKNxUOmGGFPPMNxLYB/KAf9KPkFankIyUHvDanyMsY10l/KJwH/rULI=
X-Received: by 2002:a17:906:ba90:b0:aca:cac7:28e2 with SMTP id
 a640c23a62f3a-ad21927d08fmr102257766b.40.1746736481427; Thu, 08 May 2025
 13:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com> <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
 <ae5013a930574e68b96544df82f93157@realtek.com> <CAD+XiyEQPt9HGngt0XBB7Hf=0tDHHcU+3=E20vhPnC3VL1Y+vg@mail.gmail.com>
 <31b6571789b34b95aca2bca73dca2d62@realtek.com>
In-Reply-To: <31b6571789b34b95aca2bca73dca2d62@realtek.com>
From: Samuel Reyes <zohrlaffz@gmail.com>
Date: Thu, 8 May 2025 14:34:25 -0600
X-Gm-Features: ATxdqUE17AIxhwCQThOZWFlrMLQihTxJZf9bT1KZWR_g6RnFuiQOgnkyEI6piqA
Message-ID: <CAD+XiyEXU_cxgfk1DxFZLFMLXWbmo-cDf7d30Hb1F7_BqdBCQw@mail.gmail.com>
Subject: Re: RTL8922AE driver issues
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:23=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > On Mon, May 5, 2025 at 8:11=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com=
> wrote:
> > >
> > > Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > > > Big update, I updated my motherboard to the newest BIOS (vF4) and i=
t
> > > > has helped dramatically with the amount of errors in dmesg. But the
> > > > issue with the connection dropping after some time remains. I added
> > > > amd_iommu=3Doff to my kernel parameters and ran sudo iw wlan0 set
> > > > power_save off. I did NOT apply the kernel patch you included yet. =
I
> > > > ran dmesg when my connection dropped and saw a bunch of 'failed to
> > > > update XX RXBD info: -11' errors again.
> > >
> > > I don't have clear idea now. Please try my patch first.
> > > I will check internally and will need your help to collect more data.
> > >
> > > >
> > > > I managed to capture the connection drop in a recording so you can =
see
> > > > what it looks like on my end. My connection will remain 'broken'
> > > > indefinitely until I toggle airplane mode.
> > > >
> > > > Video: https://youtu.be/BbVlTU8K9Hg
> > > >
> > >
> > > Can you open a terminal to show kernel log next time? I would like to
> > > know disconnection happens along 'failed to update XX RXBD info: -11'=
.
> > >
> > > By the way, please not top-posting in wireless mailing.
> > >
> >
> > Hi!
> >
> > Thanks again for your assistance.
> >
> > I spent all day yesterday and this morning trying to figure out how to
> > apply your patch and wasn't able to do it. I'm by no means an expert
> > and quickly found that patching a kernel is no easy feat.
>
> What are the problems you met? Below is the rough steps to build driver:
> 1. grab kernel source
>    git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table.git
> 2. switch to tag you are using
>    eg. git checkout v6.14.2
> 3. install toolchain/kernel header by 'apt install'
>    sudo apt install build-essential
>    (I don't remember how to install kernel header. Please google it yours=
elf.)
> 4. make driver
>    e.g. make -C /lib/modules/6.14.2-061402-generic/build M=3D/$(KERNEL_SO=
URCE_PATH)/drivers/net/wireless/realtek/rtw89/
> 5. rmmod/insmod
>    ```lsmod | grep rtw89``` can see all rtw89 modules
>
>
> > I wanted to
> > record a before and after video (before your patch and after) of the
> > download, but since I couldn't figure out how to patch my kernel I
> > only have a before video. It has the terminal running so you can see
> > the errors pop up in real time. It's pretty long since I recorded it
> > from the very start of the download. The crash happens at around 11:30
> > into the video: https://youtu.be/2nrLOuY6Pwk
>
> I guess the cause is that RXD can't be recognized and then
> "failed to release TX skbs" can't free TX WD properly, so run out of
> TX resource. Therefore, let's try the patch to see if we can resolve
> 'failed to update XX RXBD info: -11' problem first.
>
> >
> > P.S. I hope this is what you meant about top-posting, I also had to
> > research what that meant and how to avoid it :P
>
> Yes, it is. :)
>

The obstacle was unloading the module which was in use to load in the
patched one. I did it though, I had to boot from an Arch live
environment on a USB.

Anyways the patch works!! dmesg is clear of those pesky RXBD messages
and my download completed without failure. This is the first time I've
been able to make a large download like that without the connection
dropping :)

You'll see the download speed dip a few times (e.g. around 4:45
minutes in the video) over the course of the download, but it always
recovers successfully. In the past those dips were a sign of the
connection dropping.

Video: https://youtu.be/A5PUGaIo_pw

