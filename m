Return-Path: <linux-wireless+bounces-15091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3279C083F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6082EB21228
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4420FA81;
	Thu,  7 Nov 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="f/h0W3EH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578620F5AA;
	Thu,  7 Nov 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987845; cv=none; b=rq1agPNwpRFp8tLfOxUDCLI6076P/C2JuXFBUbLYG4yZ3S+e6iDX1pvvaie9ez3r7eIT7n3od8fvYiXBa/gx76cTvIWNi3AdeY2jwm4ehSq1uZvjJsuzIAeLJy1W1ju+cQZPZpE/WdRwJxwZUcAFLr+RJxYEdk9Qhcxu0O3/Ss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987845; c=relaxed/simple;
	bh=2fXu02djOUbW12f9rN17PdMppmReu0y1sKJC/M4mSbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp+N+98stHsnGaG4sOwNe/hVOWZUKOxZFY1KrXbcUl7Op954ILiVS1v/51PERi7ktO3kiqSRRgOtwtf+46s6ZzHxmOD+J2SId9XYTuFnr4N/Rr+mSqVy8OcH89WoGjMKeSpW5OcWwFG6NuXVqrPwF19xbILJPywlTXG5Ds1VJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=f/h0W3EH; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 434F81E745C14;
	Thu,  7 Nov 2024 16:47:17 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Sv7eHPjlQN2k; Thu,  7 Nov 2024 16:47:17 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 116111E745C18;
	Thu,  7 Nov 2024 16:47:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 116111E745C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1730987237;
	bh=yeTJJf0j6OBQT2TE53J81tDrRIh7LJlEe8Kf/bwPuZI=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=f/h0W3EHkyzCEERzZftR+hy1q43FV1KmbtX2gggJbVv2ZeZ6wJGhCESrvazrLnf+X
	 qCG3ZaYq/uGxy4AOLLKOktqR09pE3xRAg21TOJOIaym9S9D67ADvbapNKYXp8bQh3x
	 k7bcIZLfhbGQTBPzvyNxEystZFxnqvXw4ZOGXChDB/xSrNPXaDjA91kqRPGAxFPzZf
	 86ETu0yBw9LZ2zVffpwsUBnaXZ2PDAGv24k+MAp2z2ULjFmJ36b9gPlLIH4H/E4W4v
	 Uv+HbvZOI3hTCy8VsfKgUvrTi8i2fZT+y9sbSgJaux9Zw5RT26Wf/JfMJcb41/+c7l
	 GBf4rRWJRGJvA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NVhiVd6hBdlb; Thu,  7 Nov 2024 16:47:16 +0300 (MSK)
Received: from [10.254.65.205] (unknown [92.242.54.217])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 267F01E745C14;
	Thu,  7 Nov 2024 16:47:16 +0300 (MSK)
Message-ID: <57d4fa02-0b03-0a46-dc97-320fa5e5b540@rosalinux.ru>
Date: Thu, 7 Nov 2024 16:47:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] wifi: rtw88: Add additional USB IDs for RTL8812BU
Content-Language: en-US
To: Zenm Chen <zenmchen@gmail.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pkshih@realtek.com, kvalo@kernel.org,
 rtl8821cerfe2@gmail.com, usbwifi2024@gmail.com
References: <20241107002846.13748-1-zenmchen@gmail.com>
From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
In-Reply-To: <20241107002846.13748-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

07.11.2024 03:28, Zenm Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> From: Nick Morrow <usbwifi2024@gmail.com>
>
> Add three additional USB IDs found in
> https://github.com/morrownr/88x2bu-20210702
> to support more RTL8812BU devices.
>
> Signed-off-by: Nick Morrow <usbwifi2024@gmail.com>
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>

> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/n=
et/wireless/realtek/rtw88/rtw8822bu.c
> index ab620a0b1dfc..8883300fc6ad 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> @@ -67,6 +67,12 @@ static const struct usb_device_id rtw_8822bu_id_tabl=
e[] =3D {
>  	  .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* LiteOn *=
/
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x808a, 0xff, 0xff, 0xff),
>  	  .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* TRENDnet=
 TEW-808UBM */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x20f4, 0x805a, 0xff, 0xff, 0xff),
> +	  .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* TRENDnet=
 TEW-805UBH */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x056e, 0x4011, 0xff, 0xff, 0xff),
> +	  .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* ELECOM W=
DB-867DU3S */

> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0107, 0xff, 0xff, 0xff),
> +	  .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys=
 MA30H */

I have verified that the vendor website

https://www.mercusys.com/en/download/ma30h#Software

suggests to download Realtek's 88x2bu driver for hardware v2.

This device also exists in the wild: https://linux-hardware.org/?id=3Dusb=
:2c4e-0107

All hardware probes by that link show that this device did not work -- wa=
s not supported by any in-kernel driver.

LGTM.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);

