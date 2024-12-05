Return-Path: <linux-wireless+bounces-15905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F09E4B86
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C8116A31F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDF1F5FA;
	Thu,  5 Dec 2024 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOL/ky7f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723918AFC
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360107; cv=none; b=brwitD6E4tlPxVGUCoitWMvI2ZRq7eGtQ85PIb3lmbec6UhVlScotTnaWuEoM1Qt8nnQFlhaSuFnOgwwm/9DLPYYffsbYz1X88LWD3myYjoXq+acbEm43XGPXv4owbtyITAILP6ZnGffyHaQLpB1xb8lNXRWWLZJ4hvE+SAACjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360107; c=relaxed/simple;
	bh=F+0aqhbfrPVV5PYQAZmQiiDn59cnwF52CCj5pxMAkOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyXb5pyXH2XRdlV7VPfJtc25TJiVxw/ltquu20hPyefyAii6h7GMVZ6p/QE7W9AVttb3D/C2wtctQ1Gia01G/k+/mUilLVrl46o2O07yaLaJL+ZeF7rd8Lz/AAQnzIMMO9IAAxH/3StCFkeQGzPXvGbzIjJ+nXpR7zxfwX0glYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOL/ky7f; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so305311a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2024 16:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733360105; x=1733964905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+0aqhbfrPVV5PYQAZmQiiDn59cnwF52CCj5pxMAkOc=;
        b=LOL/ky7fifbJvFq+3wDj8SZRWOVu1g7g9dZR1U/AAeLqnAAzaqCB4TfJ4m6e3R8izk
         OhsGRfuWqtvkLJQIqsmeOfDvR8Km6inEqknBkmPQKUsUhnW7oPKOZGTJBxdmhszwxNGC
         G16zt+ziXiJdDX4x8p8n6LchwiEnvmhP2xGzHxr8R9OHlMmRWngWlsYyYyGfmNKhjbTX
         evGNbQxa6DGBBIF9/DL/WZswztGT9oliQq1tV7iCAimUSXNvqzFz+jMxEzlWALv4T6/B
         eilCpFUPquMWmSJQb3a3W3SW63bMFQBW2ETZt5ebm7Ef4pnSUatfGmhGL2+VHzhfFxr9
         sw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733360105; x=1733964905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+0aqhbfrPVV5PYQAZmQiiDn59cnwF52CCj5pxMAkOc=;
        b=clVZKTMXM1vaoflIqCMvDhbHr0UWKOeQmxd6ysJgccwm7tJZ5WZPbnAzVjn0NVx269
         IL3mJtKHYN+tq8STK0z4OTf5XY1qu9+H78al70YEAympNewZXfMn2BIO8gVf1rLtdoYO
         2SL/Yyu7NDH/NEA4cJhc1622jgrL3ewY8LrGC7TxL7obwMtDwURZ7wCoCDZPT+b8Z6PA
         OBsGJkdXIrpDr3IAZmjJxfkZ1FpFJI6qHNIOxwOLZeZFBsVstfHoCFvK0IcnpxI6TrTG
         fUG7AGzNB+YF0tJ3RqBenOkpqDjo4p6kzLNGMp/2yLpBIKe3PcfTMX/2FHM9x+7KtNZ8
         gjcw==
X-Gm-Message-State: AOJu0Yw2ei/fAx3VmUkY4rHYapfiyQ2cZbFSCGvCUZ3Aui/VW0ZRXD/X
	PEo/m0HF3il02GFMQi+5wTpjQAF0e8evqsJo5ikbAaLtgqKdXyHcSfrK7SorxHut219ga30WAmW
	KvhtkiO0v37lUKDyZhTrNkAheZdY/vRKP
X-Gm-Gg: ASbGncukd+kkaRgXTahxceCGOvGPj9DGIEEorKpC8qhFOj1ttR9JhrhD2mFZmZTe+P8
	Iz7AkHlZKs3fY75+K+AOhUWsgR/ePWf4=
X-Google-Smtp-Source: AGHT+IFldZgDjr3d+zOXtTIS8h+gXv0XUugthAg19G5klaQzp3rgFJOU31zKZ0Cm3IJTLG3NxEOXicB+9jmmVVdrRxo=
X-Received: by 2002:a17:90b:4c4c:b0:2ee:dd9b:e3e8 with SMTP id
 98e67ed59e1d1-2ef1ce695bbmr9178721a91.8.1733360104757; Wed, 04 Dec 2024
 16:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_P=bz0DFU71jEnV4RkT-Vxwvb2GpPwvLnjmD_n=2hLfUw@mail.gmail.com>
 <19388725ac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_MJZ4VHvXiGj0qoimfQ8GLE6OEZe4DHZLx0H+0U_1X4pQ@mail.gmail.com>
In-Reply-To: <CAG17S_MJZ4VHvXiGj0qoimfQ8GLE6OEZe4DHZLx0H+0U_1X4pQ@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 4 Dec 2024 18:54:53 -0600
Message-ID: <CAG17S_NQ4vhKv153Hf_sfvseTpGjLr-UZQ0vEeqr-+q-op+R5w@mail.gmail.com>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:49=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> Arend,
>
> Yes, I can build and test patches.
>
> I will build a current kernel version tonight and will then be able to
> add any patches you may develop to address this issue.
>
> If I may ask, could you also patch the WPA3 External_Auth
> functionality as well? I can test patches to that as well.
>
> Regards,
>
> Keith
>
> On Mon, Dec 2, 2024 at 11:36=E2=80=AFAM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On December 1, 2024 10:55:26 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > > This floods the journal of my Pi ev ery 6 seconds:
> > > Dec 01 15:51:30 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > > 0xd022 fail, reason -52
> > > Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > > 0xd026 fail, reason -52
> > > Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > > 0xd02a fail, reason -52
> > > Dec 01 15:51:31 pi5 kernel: brcmfmac: brcmf_set_channel: set chanspec
> > > 0xd02e fail, reason -52
> > >
> > > Is there something that can be done? Is there something I can help
> > > with to fix this? I can test on multiple Pis, but cannot actually cod=
e
> > > anything. Is this going to wait for the new infineon driver
> > > development? The latest kernel where this has been seen is:
> > > Linux pi5 6.6.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.62-1+rpt1
> > > (2024-11-25) aarch64 GNU/Linux
> >
> > You can build and test patches? Is it only those specific channels as
> > listed above? Those are pre -802.11b allowed in Japan. I don't think an=
y of
> > the brcmfmac devices actually support those channels.
> >
> > Regards,
> > Arend
> >
> >
> >
I built a fresh kernel and can build and test brcmfmac driver mods on
my Pis. Awaiting further instructions.

