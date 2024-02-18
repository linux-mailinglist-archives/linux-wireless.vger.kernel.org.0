Return-Path: <linux-wireless+bounces-3738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAAA8594C0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 06:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAA31F21832
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF62F50;
	Sun, 18 Feb 2024 05:13:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.133.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCD81F
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708233235; cv=none; b=PExe9TGgKXBKswSQicYLMNmhxsgJDOlR0oy85giPHFExkYErdxyweY8M4kLV1htyuPwCumOoM1sqz1rJzxw8Aop2B8UkHyrBmmIz5v7zGToXLcNrPeR8UjM35kot4V9rz1HZ+55pkhslYWyYuWJ9M6b7cQ74ZWVymKJw4co9hLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708233235; c=relaxed/simple;
	bh=RHeCw9Z+IWmg4RqmRz1r2PffNmgSpj5q4KLifT6vlAI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lVlNorLgaCTfU9BsjHC6OdrhhbU9GS1U0SmH2pkxVSFubKRE4d+qFGw6laXUjixr6NssOwfJx4O1LI4OC7BeRy9qI+lrUbfB7q06DKLn65EfJX/MMyROtD+Gauh0+3fky03PJybG0aXJ/2go2Neq3qk02tgBhdHqLVGlIsqQh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.133.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-IOSV6mB5Oj-j8DFm2g739A-1; Sun,
 18 Feb 2024 00:13:49 -0500
X-MC-Unique: IOSV6mB5Oj-j8DFm2g739A-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id 73A2C810602F1;
	Sat, 17 Feb 2024 21:13:48 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id oKc450eIm3De; Sat, 17 Feb 2024 21:13:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id 4239381288C67;
	Sat, 17 Feb 2024 21:13:48 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA;
	Sat, 17 Feb 2024 21:13:48 -0800 (PST)
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa
 RockPi-S
To: Larry Finger <Larry.Finger@lwfinger.net>, linux-wireless@vger.kernel.org,
 martin.blumenstingl@googlemail.com
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
 <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
From: Brent Roman <brent@mbari.org>
Organization: MBARI
Message-ID: <f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
Date: Sat, 17 Feb 2024 21:13:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:46.0) Gecko/20100101 Firefox/46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mbari.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Larry,

Radxa confirmed that they do not program the eFUSE on these boards.
We do not get a sensible MAC from the chip, so I derive a one from the=20
CPU's unique serial number.
It's a hack, but it works well and is standard's compliant.

The RockPI-S a *very* inexpensive board, so I can understand Radxa=20
wanting to minimize the time spent configuring each one.
https://shop.allnetchina.cn/products/rock-pi-s

The vendor driver seems to deal with this by applying typical gain=20
parameters when the eFUSE is invalid.
With that driver, this board's WiFi performs beautifully, despite the=20
unprogrammed eFUSE.

Would you accept a patch to add this logic to RTW88?

- brent


Larry Finger wrote:
> On 2/15/24 17:55, Brent Roman wrote:
>> Originally sent to linux-wireless on Feb 1, 2024:
>>
>> The Radxa RockPi-S has a built-in RTL8723DS interfaced to a Rockchip=20
>> RK3308 A35 ARM64 processor on one of its SDIO busses.
>>
>> I maintain Armbian's support this board.
>>
>> The built-in WiFi works perfectly with RTL's 8723ds.ko driver.
>> Recently, the rtw88 driver got support for SDIO.
>> https://lwn.net/Articles/925940/
>>
>> However, when we attempt to enable the rtw88_8723ds module, WiFi does=20
>> not work.
>>
>> Specifically, the WiFi scan returns only the strongest AP while=20
>> indicating that AP has a very weak signal.
>> No connections can be made.
>>
>> Unloading the rtw88_8723ds modules to replace it with 8723ds=20
>> immediately restores WiFi function without the need to reboot the=20
>> system.
>>
>> Has anyone tested the SDIO variant of this driver?
>> If so, on which board(s)?
>>
>> I'd very much like to get this working.
>> Any tips for debugging, or just getting relevant info from the=20
>> driver, would be appreciated
>
> Brent,
>
> Yes, there are SDIO cards working with the RTW88 driver.
>
> Is the EFUSE properly encoded on the RockPI-S? If not, then the=20
> parameters of the chip with respect to gains are not set correctly.=20
> You should be able to see that condition in the dmesg output. Also, is=20
> the driver getting a realistic MAC address? That also comes from the=20
> EFUSE.
>
> Larry


--=20
  Brent Roman                                   MBARI
  Software Engineer               Tel: (831) 775-1808
  mailto:brent@mbari.org  http://www.mbari.org/~brent


