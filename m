Return-Path: <linux-wireless+bounces-538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1C808708
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 12:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A480828372A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210DF3308F;
	Thu,  7 Dec 2023 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=zerobeat@gmx.de header.b="kJj1mOxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428B1731
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1701949918; x=1702554718; i=zerobeat@gmx.de;
	bh=yyQQor8VqlyfEyy8C7JN+1AdgRagJoQvPeCciTQsJyY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=kJj1mOxCG/Grof/l1oSkNm2Oz4ARLv6pf4I7g2gbBC8Y94pEiZQ8jLpvUGE55peW
	 ccVIisCQJ8tDQt/4re4JBV58Epx3B/UHIeAShYaB7N0HyjXKYNU2mRUa5F607akcP
	 vF6WXEzh6/1PMZ5GlRNgk5+jOmr8e2tghpsKJQrRKE3LwqUjY9qeQcKGFJXtuePcL
	 V8KR5q7KsUx/m+MpUWmr/hIDMyhdXPPjKv54d46oKsjhAyNBqeIDdy0q798oZkAj6
	 W+jxdUY5M0Ep1QhXXfcZGMu5raxmohOfgoC4+WDhJzkqqmoqosAMb4aHjiHQrt/FQ
	 lv8iDgHzrpRUilxMVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.2] ([217.244.252.215]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1qtOv91d6v-00I0B3; Thu, 07
 Dec 2023 12:51:58 +0100
Message-ID: <bbbecb92-82ae-4920-b26a-f23f257c4b46@gmx.de>
Date: Thu, 7 Dec 2023 12:51:58 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
From: ZeroBeat <ZeroBeat@gmx.de>
To: linux-wireless@vger.kernel.org
Cc: Jes.Sorensen@gmail.com
References: <5fe2c3dd-5eb8-45df-9717-87808537ff6b@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <5fe2c3dd-5eb8-45df-9717-87808537ff6b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SZ8/6tBR2x6DndejsZp4GRCA5NyoRNOywhsksGdiZP8y/LRXe8Z
 Hftsmksux5ULXM+cvc2VnIY+TII8TK8972Yb1nAKTXLsQRa+oRxyyPb/P6bxPV+DwjiqUtQ
 w2dbfxmTt860pVB7RPtEGugHPmDk7EWnBtgj5NZddIlBrKQDQpzLqum5MT19UWTBRbsv9Xd
 IkTX7LUGz6JGVARRjsLDw==
UI-OutboundReport: notjunk:1;M01:P0:Kd26Csq3+uo=;jMeOEiQWV/cQe2gUtsytUOVIssT
 i7OtWto3GqEMwbw7eAIL9AUzQzBrumluttYA1K1rUJuieZf1RG7EjS5OvbJDDqMAihy2XM+Nu
 DGIRAoJaejIRNagE0+lA8PW85DOmeOLT3keMcgEwPMj705KqobZuNG8bldJT5OIor1hjyq1eU
 SetBHct26hkaDvxiyb8Yg4XHapTTXXnabb4NyWcW0MUL2JHoy8OIGevf+w6YvS0nKIvMp0lOu
 411eH3zLbjX5YFUXkUjJjGZi6wR7XxxjD3MVjOetbs1bL7NUbsYhAr3v3DlsfpSh4AhuJPBb/
 YnkwlQrTYdlUnGfBjxByryGcJhssGWs4zeHhSNXVGCy8GU89hD2wgK5fxLA+xbOydP30U+fNy
 GAhlasycgnbDW9cqhTi1vM/n9akEAPCby+q/a7ev93gNlPFd0i6oC8mRrPi1DKNLlvrXvExBC
 cT03rws96bEONF4yQXAn8K7CGlHebIIAPVpGj5mZG4mibNg1qiSCXdlXx7nEMFY+rknR1L3L3
 PPGQhW2rWncCGYoiKNNciUDcEQ8v+5g8qCsGxqxm0wZTSVul+Bf2Ichs0Jb0+IM9HtbXS4ehh
 5rjgAgjrku92cBoKJQ/c7Fb/Q94phc+hx6wsT2wc7zaVGimrbfG4KpZ1FrPn8wGioKvawqDIo
 uStxZAEwFUbMW+SYDHJWrIvandwL/jEd1N9Nb7i/KGPt3H7mGOujPtgoDEc8eOCaJBhwgcCv4
 VdrWtlMY1zsMb/znKVaM/syUgef6S8KdH9fSFklEqHYdH/K8e4dZRXUSAJnktLecxLAANWNjU
 5nwn0xiY1UBl4xGXlblCHqaNx1lqll5wiyL8qudrT97KpWBwVisoop/qTX9Mky/fX/SNiITZK
 TF0ovh8gV2lLpciOcO3CLE9xrY2QIUTfFmPRyIj7HG4EY4RVk4URpucgMEfBqV6mnRJjKVpYj
 csMRsOMl2J2C+TLwJWt6DUAerac=

Please delete the suggestion.
Further changes are needed to ensure the driver runs stable in combination=
 with
TL-WN8200ND(UN) v3.0.





Am 06.12.23 um 12:48 schrieb ZeroBeat:
> From: Michael Dieckmann (https://github.com/ZerBea)
> To: linux-wireless
>
> Subject: [PATCH] wifi: Realtek: rtl8xxxu Add new device ID
>
> This patch will add a new device ID.
> Patch will close: https://bugzilla.kernel.org/show_bug.cgi?id=3D218231
>
>
> TP-Link TL-WN8200ND(UN) v3.0
> ID 2357:0126 TP-Link 802.11n NIC
> https://www.tp-link.com/de/home-networking/adapter/tl-wn8200nd/
> Sold in Germany.
>
>
> --- linux/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c.orig=C2=
=A0=C2=A0=C2=A0 2023-12-06 12:38:51.929484252 +0100
> +++ linux/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c=C2=A0=C2=
=A0=C2=A0 2023-12-06 11:54:12.524302276 +0100
> @@ -7957,6 +7957,8 @@ static const struct usb_device_id dev_ta
>  =C2=A0/* found in rtl8192eu vendor driver */
>  =C2=A0{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0107, 0xff, 0xff, 0xff),
>  =C2=A0=C2=A0=C2=A0=C2=A0 .driver_info =3D (unsigned long)&rtl8192eu_fop=
s},
> +{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
> +=C2=A0=C2=A0=C2=A0 .driver_info =3D (unsigned long)&rtl8192eu_fops},
>  =C2=A0{USB_DEVICE_AND_INTERFACE_INFO(0x2019, 0xab33, 0xff, 0xff, 0xff),
>  =C2=A0=C2=A0=C2=A0=C2=A0 .driver_info =3D (unsigned long)&rtl8192eu_fop=
s},
>  =C2=A0{USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xf=
f, 0xff, 0xff),
>
>
> Thanks for maintaining this driver.
> Best regards
> Michael Dieckmann

