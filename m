Return-Path: <linux-wireless+bounces-22460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92351AA9A31
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9491118994F9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA831FFC50;
	Mon,  5 May 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6bi8Kk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E854279
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465182; cv=none; b=X3bb0p65ESFZ/IjNdJu0rYSmNKozWAv2pXDIVIH3ns9WQ9uXQSmL8n0BiFmxDZRjJwF31S6pqddIwhvkRxnEBUtvzq4ADqAxEel2StPUvpamaxUhMTBSM4YmRD4yobTle8FUOSrh3nTFViTKeO2dH8xlZ8ozyfbMd2CNZeD86Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465182; c=relaxed/simple;
	bh=AYSADc3wtB8Dy9FGjlKmPce9Ygp8RARu4b5GyPF0/Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvvuqVf/OYYdWilWB53LU+BDUGT9NRHSNr8B6w9oSvnoqPeWhkWPhH1OboH0Z+V0zJlIqZOIgPXA8pHSPNyHESYk6et7rpN8SDUBdtVk+FGWkmcJ+zG3fqyY2pKsNdx7bI4RIGHNxcO7expZiGPdO3FTq5RYMnGkRXVj5c4qYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6bi8Kk0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2aeada833so907834266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746465179; x=1747069979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Pv9kuiajRL9rhsWpA317JLxdwp+p1B2V543Ot4gN5g=;
        b=W6bi8Kk0QSrJ75dK2TIb/oj80JSZ6wnntptyPY2BU+zWMT0d0o1H3tzwe9RK+nWkx+
         sDbooOpNHYUDl6tPaNXxowUgf8nr+CQHjHN6XEixIN3LTgro3ox1SMAMfLYrOAl3SUMz
         0vFeTewp7W2O2GUqw2xkH8U4w/9kayBi6Rag4r7N9Ppg/HWOth0cFhZMR26eop2c7EOy
         NmxKQeV4XT5BrJmzpPcw+gfYSubpDZRcm/eDXUE7Dks9yC0w9Ea+RBwVgfhMhgyMrq1p
         pjCiE39jHHgS2iRrWqo3sglUwLZ2bl3jiXLCrAdv3SidypR3PWCBNpKdfkL98kjRsAFC
         k3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465179; x=1747069979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Pv9kuiajRL9rhsWpA317JLxdwp+p1B2V543Ot4gN5g=;
        b=qVvZF8jPS32VMCmJjaJHxqteYBQueRIw5pmvIXjkoMjXMXPcJoUF/4B42OAWGJrUTk
         BuugTUBjZd/nyQxnRrb1SkrXtxV11t4htC3X+BT9qFXWAhvPoE9hRDGtIjXtsGDi0G7x
         8IKMQsyKkiPrjqLoAY7FLYwpKJACcULiuEDMfnuaEB6W0OhMOU5Dfe8dmfvjOhl4bhCh
         9h4i4dJ6cgmtGASeJmFv4iRC37q/2xwU5zKL+JZ4RYADVDq5fkrH+/DwQ9SQhL6nIx9t
         7B6MCI8dzJDWfgLcxeJZsggaI6FupLhswtnhrBHYAOpLPzTTLwHWwK7Jje4gtXN7sMrM
         uy3Q==
X-Gm-Message-State: AOJu0Yw3AeLNIy0G8YkkM7/TX5UN9bil27M0cmC3vXuGEeMxogLYUpKB
	2eqVFxTH2L81UATuI1eLD8Sfk/qbQRGNAjw3N6jB5wDSUsVCta3kvbXBXWO1+3YbOUKrbo17bhS
	vPjD/5HHBvHZh4IolZiVRCoGEAWY=
X-Gm-Gg: ASbGncttnSq0gkj0ZroqLaIQBFW27LPhCv2UMh/dJPF5ueCEyQkyRjxejUhRpvKAKm5
	2xu1EDrHiZ/gh3gknD0mLkbJScTBgUsYIzwXrCPuMrAxFsbFsTWPslxAOknYPVtQpCAUHPWBwV7
	Fo5q5Csje02DdsokR9gji6KX4v
X-Google-Smtp-Source: AGHT+IE/6nVBZsAQDyzJcy+YZjASaJHU1con3EeZLn83v/8whRNc3ZqsuwNNMmMTTX7Z3SOAhypHzTl4vISeDnT756k=
X-Received: by 2002:a17:907:7294:b0:acb:1165:9a93 with SMTP id
 a640c23a62f3a-ad1d2e7af6emr30310366b.3.1746465178565; Mon, 05 May 2025
 10:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com>
In-Reply-To: <0cf9bd4b99864f428175e34a2f2e014b@realtek.com>
From: Samuel Reyes <zohrlaffz@gmail.com>
Date: Mon, 5 May 2025 11:12:41 -0600
X-Gm-Features: ATxdqUHlpLsFQvoFhDZ1D3wh8ShgliWyZRhYKTzGqdPBd0KLi0sXYru9bEY40hE
Message-ID: <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
Subject: Re: RTL8922AE driver issues
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Big update, I updated my motherboard to the newest BIOS (vF4) and it
has helped dramatically with the amount of errors in dmesg. But the
issue with the connection dropping after some time remains. I added
amd_iommu=3Doff to my kernel parameters and ran sudo iw wlan0 set
power_save off. I did NOT apply the kernel patch you included yet. I
ran dmesg when my connection dropped and saw a bunch of 'failed to
update XX RXBD info: -11' errors again.

I managed to capture the connection drop in a recording so you can see
what it looks like on my end. My connection will remain 'broken'
indefinitely until I toggle airplane mode.

Video: https://youtu.be/BbVlTU8K9Hg

Thanks for your help!

Samuel Reyes

On Mon, May 5, 2025 at 2:51=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Samuel Reyes <zohrlaffz@gmail.com> wrote:
> >
> > Hello,
> >
> > My WiFi has intermittent connection issues on Arch. My motherboard is
> > a Gigabyte X870 AORUS ELITE WIFI7.
> >
> > Even when installing Arch my connection was unstable, dmesg -T is
> > littered with entries like this:
> > rtw89_8922ae 0000:07:00.0: failed to update 162 RXBD info: -11
> > rtw89_8922ae 0000:07:00.0: failed to update 163 RXBD info: -11
> > rtw89_8922ae 0000:07:00.0: failed to update 32 RXBD info: -11
> > rtw89_8922ae 0000:07:00.0: failed to release TX skbs
>
> Could you help to enlarge retry count? or even larger.
>
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -228,7 +228,7 @@ int rtw89_pci_sync_skb_for_device_and_validate_rx_inf=
o(struct rtw89_dev *rtwdev,
>                                                        struct sk_buff *sk=
b)
>  {
>         struct rtw89_pci_rx_info *rx_info =3D RTW89_PCI_RX_SKB_CB(skb);
> -       int rx_tag_retry =3D 100;
> +       int rx_tag_retry =3D 1000;
>         int ret;
>
>         do {
>
>
> Since this motherboard is AMD platform, please also try to turn off IOMMU
> via kernel command line amd_iommu=3Doff to see it can help.
>
> >
> > My connection can remain active for a long time but will occasionally
> > disconnect. Toggling Airplane Mode fixes the issue. Prolonged
> > downloads, such as a large video game, causes the connection to drop
> > several times. Toggling Airplane Mode lets the game begin download
> > each time.
>
> Not very sure if disconnection is related to above messages. Try to
> disable power save to see if it becomes stable by
>
>     sudo iw wlan0 set power_save off
>
>
>

