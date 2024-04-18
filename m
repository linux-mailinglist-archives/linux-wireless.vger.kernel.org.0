Return-Path: <linux-wireless+bounces-6499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3458A939E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CB1F22759
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EC2CCC2;
	Thu, 18 Apr 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmOFwMfd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC429A1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423539; cv=none; b=RJXr/MlQ+gttFkxbRhncABWVbLXdBKociakP18ZvJogKAtcj8QMRviSQ696xHcsiPkGuqOZsbvJ4/4fKzKuGDW5ZCx3lBSBr+Ow8ByVHMGTeK7iqkV+WLF9JGSXSb20EPX3J1DAdR8ONqAEhtmdUwcI3iZNVYANCRmwVVuFWbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423539; c=relaxed/simple;
	bh=fqnLSOH5zPrCMvtJ2d6LYJsDLsF0Hn0aRK3rSDh2Vdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEzWs/z9hEr8NYWJ01Rjy/1D4QTkt2aa2YN8Fn0G4RarIXpcZbWC4jI4ceDd2UZWpxKwTjsMd0rKmRWt0BTiX4K6FrxzTnwc8nG4hOwxl0QbtdneWkk9AOeLl9xC3A7fWY/8n15b66ZspwuIZTQ9fanhBrS+PjDSXJjzxzZz49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmOFwMfd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-418bbc690e1so4443715e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713423531; x=1714028331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqnLSOH5zPrCMvtJ2d6LYJsDLsF0Hn0aRK3rSDh2Vdo=;
        b=RmOFwMfd7nwZWtRJvQtlwOzk152xyUAQF33vXKmfgKyQA/Qtz6DjtOUXkOkRTuPNFT
         7P8A7GdDxNc3M6tjWsMr+vMQ4/1qz2otWfm+OWvgL/u8TTkTpm9ehYqAgnxb4VYdvnmR
         7X5XUNZE4GUYQls+CfSzey16LAv4xlCaEL5TBDv/iSSvUVfNzDBNU0p6qo5TLTvkIywX
         ufBt2OTJK2D+7+mS6nVYcRvYAl9qaF0lIce978mKuZHBnglll7unuO00gAJ0pfP90TBz
         mfxpWWOR8bdRCcA66KCglQmBNdzOfszT1IhKH8D5t033teS9ljuMCySuEDxjRCoHIO4E
         qCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423531; x=1714028331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqnLSOH5zPrCMvtJ2d6LYJsDLsF0Hn0aRK3rSDh2Vdo=;
        b=SDzBtgd2p5onNNLeW1sS6jn2MdEhOJM1PdtLquzXzLynhN6ggCS/BygpmeLkJ6WRFe
         gszeGrAoW5Cwj1HwCjfvx5iWGm1hnfKADqoYWTbdcO4o2qKBn3KBjSxSQBQvOXSinKbd
         QKxrancizWWN9LKIkZsiGmLS5c24GfV0Q7Q/5JN7FMihkn2v/0aVa262q9IlDCUJ733/
         FODqYqfnUOkWNpfP+FBZqXjhdzU7ZviX4jQxtSqqGgWdH1WhjlFDo1bqrMdkBk7IUpnq
         BqtbRbz2SkEgG5Rx1HET65nyuHUj3DnSd/Or4jkNHYhyYQgE8Ghewaol85OwmNYwHVCb
         vaYA==
X-Gm-Message-State: AOJu0Yx6RANMGgkWzZ8GwAll3/XxhcBWvL14JXuqVmqsPei59Xoy8SjP
	fj4vvjhFaY3Rf9WXe3CdeBIhiohLOcNS5033Rqkk98VX/+hbodXQ/GPC/6pwTk75eOA6HDjySdc
	fxveS5+LV4vRRMvuTT2fgBGbqE4Koc5bF
X-Google-Smtp-Source: AGHT+IFxhtiLfb+mv0xnlFHbhMNeWx1+bYS9mdf2mKXyGrDG9owpyzM7aPu8p9adVpvov/wCgG5qzdbGmOym18tAlgk=
X-Received: by 2002:a05:600c:444f:b0:416:b91c:f310 with SMTP id
 v15-20020a05600c444f00b00416b91cf310mr1036317wmn.22.1713423531388; Wed, 17
 Apr 2024 23:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com> <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com> <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com> <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com> <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
 <e4ccf840-a38c-455e-af75-5f4db8a97702@lexina.in>
In-Reply-To: <e4ccf840-a38c-455e-af75-5f4db8a97702@lexina.in>
From: Gabriel Tisan <gabriel.tisan@gmail.com>
Date: Thu, 18 Apr 2024 08:58:40 +0200
Message-ID: <CAD9ZU8C1mf92UH1_k4bB5yTr8yXLX_0CDZHFz+Yh6Z0MQZLs=w@mail.gmail.com>
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Viacheslav <adeep@lexina.in>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@ Viacheslav:
Can you please tell me which repo did you use when your run USB 8821cu
successfully in AP mode ?
From your log bellow it seems that is not the mainline driver rtw88_8821cu.

On Wed, Jan 17, 2024 at 10:49=E2=80=AFAM Viacheslav <adeep@lexina.in> wrote=
:
> I have USB RTL8821CU. It works in AP mode:
>
> [511809.841083] usb 1-1.4: New USB device found, idVendor=3D0bda,
> idProduct=3Dc820, bcdDevice=3D 2.00
> [511809.841111] usb 1-1.4: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [511809.841118] usb 1-1.4: Product: 802.11ac NIC
> [511809.841124] usb 1-1.4: Manufacturer: Realtek
> [511809.841130] usb 1-1.4: SerialNumber: 123456
> [511809.973789] usbcore: registered new interface driver btusb
> [511810.432057] usbcore: registered new interface driver rtl8821cu

