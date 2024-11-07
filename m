Return-Path: <linux-wireless+bounces-15097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3469C08CE
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFC31C21607
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D413B21264A;
	Thu,  7 Nov 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKxv7Qlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE304212164;
	Thu,  7 Nov 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989390; cv=none; b=iDZqgytjzhJdTPeRH+xhUBw5yg3uqVbuwYkEItoovqvnryupVOfsH97Sz4KAITvtlEn2DVZ5zKIuJIcAoCnJ0HstfDqSXXaHiuSzGXULUe1piVy6zfyvGw+c09wiKA+D6KIAfqvbijyvu048hwJiV3nn7UA73HuUMWoKg5sP1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989390; c=relaxed/simple;
	bh=1vS1iTnD6kK4Vka3ccpXTZnspc8FPKXdaTMnnwk/7ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW/3ejjmrsB+2RskZB7qVZU9Xl/BPz9uItL9F433dyVhzquUVx8IhhMwN/5iPkEy5cfzy7ZYnCtyXi2DZUQnrEjLIy5FJ1W/zISaPpRJOMVykELR+SHeCm/qx6OGp7+zZFeEqjy+9s6aaYE1PHvjuC7eJmr65d1aT53T5Al8oIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKxv7Qlo; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so10037891fa.2;
        Thu, 07 Nov 2024 06:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730989387; x=1731594187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUgnIDdh1cnD0LhNQIlH/p+vDLHIa3VLvsqit2GvoCs=;
        b=lKxv7QloqV8mAWVPG5Ts/5fReg07+eXjWW/vN/x+ZWvVK+GqhAyko2urUtes95Wnr3
         uQ8FMQqHwP9o1TRZqKpsnDBfgffL+La4FE2ovSdHvAteLcvHfT5F12BvtDVNR4aJwiVU
         lkPQUGPSyw9HAI59hHhaR5N2d5r6E2nUsrusDGnfZbydvO6cg7V/jG1GNxR+pBEkgzF9
         2+zLiJmulCsoKWLCchywABeuX0rrGcjLWFJEIfxg/FTK+ILxv08qT0sjUlUeZeQuhUn9
         5WevkcrkNWMtCknryIktHSWfDbELZVPK8ahh18X4CDBCVBHI8a6HDIIPNrC/te3Yru4S
         C2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989387; x=1731594187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUgnIDdh1cnD0LhNQIlH/p+vDLHIa3VLvsqit2GvoCs=;
        b=U75GMYazqf7+4oG/N/RNIdyg65FP62SJYgM5TJGuADZdr7pKbsC91KqOmnLfIJHC4a
         0bdqTSWPYEncC6U49mSKFEDxDGtZGrulWgES8aDSuht/yoGrMaZRkVDrenaLdOApwxix
         qXO54j9/b409Ct4J5tJN5w0h7edIHcG8NN1TH0xI3RRtAvBOkELyZAcY/l+pxjtaM7yP
         BRl5IjJznWbOQreG0vBEiVf4JBW6jDdYAJQfayaF/plwsXPqwIfkBi5KaORB1H2k8W2W
         Z/6b6VbS6iZhLNcbiM8lqqTCAqn8AWPvrc5XppoYnMo/zj3Rli00hsAi/luQOXmHdbeI
         22eg==
X-Forwarded-Encrypted: i=1; AJvYcCV5tZ/JOcQa6z470OdS5eQIjeHMHvB9GQGqhtTZSou4DbFhn8QQAOYVkmlWRuJx7MMJjaykRly9TFhAeOVN5Q==@vger.kernel.org, AJvYcCVVFXOonDVXQ1vSs1jZQoP16khTpXETTHlNnOJjKi0c3ksvVDJITGMD5wzcxl9WolXyZ5ok5i0M@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyMGKXDaNCSMenY+h2FvZyGK5VziM6/Z+Os3nEZwH4v4SsEmd
	eNOEhQ/NOvYGMNdNCHocHXZZKYl3zF/y+dlnYfslV9Z+LsoI89g0d4cFMUFeM8xkZ80eBc7hPb7
	rPqDCBbfriYmlROsOzveeQWO+g2I=
X-Google-Smtp-Source: AGHT+IEUEm3f71Y+xcPEHsVfb+45JuNmoETWADbk+LZEUtK440SzmhyijTfpIVOoxaoBy19kekKKnMEtDcPAFd5vmcY=
X-Received: by 2002:a2e:bea0:0:b0:2fa:bad7:70fc with SMTP id
 38308e7fff4ca-2fedb7d8ae8mr133468261fa.29.1730989386881; Thu, 07 Nov 2024
 06:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107140833.274986-1-hdegoede@redhat.com>
In-Reply-To: <20241107140833.274986-1-hdegoede@redhat.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 7 Nov 2024 14:22:55 +0000
Message-ID: <CALeDE9PXj+gD=CzwaANLPThbDMFx-Y0AiGYfFmeMb9jJVu=Ynw@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 14:08, Hans de Goede <hdegoede@redhat.com> wrote:
>
> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
> except for the following 10, add these to the untested section so they
> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>
> This fixes these wifi modules not working on distributions which have
> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
> like Fedora.
>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
> Cc: stable@vger.kernel.org
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 7891c988dd5f..bd8e0076baac 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -8145,6 +8145,8 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x817e, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8186, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818a, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x317f, 0xff, 0xff, 0xff),
> @@ -8155,12 +8157,18 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x1102, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x050d, 0x11f2, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8188, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x07b8, 0x8189, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9041, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9043, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17ba, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x1e1e, 0xff, 0xff, 0xff),
> @@ -8177,6 +8185,10 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3357, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3358, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x13d3, 0x3359, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330b, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0x4902, 0xff, 0xff, 0xff),
> @@ -8191,6 +8203,8 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x4856, 0x0091, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x9846, 0x9041, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0xcdab, 0x8010, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x04f2, 0xaff7, 0xff, 0xff, 0xff),
> @@ -8216,6 +8230,8 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x0586, 0x341f, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe033, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x06f8, 0xe035, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x17ab, 0xff, 0xff, 0xff),
> @@ -8224,6 +8240,8 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0070, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x0df6, 0x0077, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x0789, 0x016d, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x07aa, 0x0056, 0xff, 0xff, 0xff),
> @@ -8246,6 +8264,8 @@ static const struct usb_device_id dev_table[] = {
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330a, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x330d, 0xff, 0xff, 0xff),
> +       .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab2b, 0xff, 0xff, 0xff),
>         .driver_info = (unsigned long)&rtl8192cu_fops},
>  {USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x624d, 0xff, 0xff, 0xff),
> --
> 2.47.0
>

