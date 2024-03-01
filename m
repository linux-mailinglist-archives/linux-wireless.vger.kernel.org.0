Return-Path: <linux-wireless+bounces-4305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72C86E702
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715AA1C2299C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEAF2900;
	Fri,  1 Mar 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="B11MW7PV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195D16FF21;
	Fri,  1 Mar 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313357; cv=none; b=PE8kwuFTa8tGwIWw+tLQBHwzrCky28UepDqf4MFnEVUdkwx+W5EPqvGUluFGs84mwPJE8HvQQCurfDBHy0bNAptl18Y/myDHRT3DDvQ1Z4XWSGwnu0yRqrvWoYnnmKKKRkW4JemD/juiMjPS5n/5TImNZchjxTSL2YKBhGht8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313357; c=relaxed/simple;
	bh=kWp3++pMZYSW5hCzQ3OAsPTyxM4LoDUTJmw1JMeCKew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aK8g0wRJADOCA0tFQkweaTRbADVrZ/2aNP7x/BwBTZ/NPe1WR8GuQoMBU3Dltxi8s2zLCe+2Qpys9W1An3Bh72n8tandfePEDqirMOm8xjDhUz2PfvN4eoJdZurYmpMiobJdqXlV709st1g6mIC7pjX8w3Xn4jvCVOBJ0jEYA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=B11MW7PV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709313340; x=1709918140; i=fiona.klute@gmx.de;
	bh=kWp3++pMZYSW5hCzQ3OAsPTyxM4LoDUTJmw1JMeCKew=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=B11MW7PVHAtQEcGcSTbPS2v4u3e5OgEmtPG/40ESqnh17Y5rVJ4fQ30AqQ3s8D2v
	 hmn9ymRsnpVmTjaI4yO+7tbALalLxLGlO41XvUeRpYsjPz/brTW3RGK68ewrGMjJH
	 3qUfj5tNR0z8546NLGINyUlPzIFbHrfgQiphd/9r6MYzezdxCl2zamSATwtujN3dt
	 i9lDC5auw0Nbbtol43qoZideXjpUSmp/TIMix46NfKVU/PzsLn836Cb+2Yk7l1z3C
	 lp6t5EOzpc8Ys1tvgLhaSqsS+nu/hakm9hnaoftnuy6bTAdLbR728umACsjxYxWA2
	 hxii+rmTqaFxD/q2mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.26.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1rSiUh29Pn-00MpM1; Fri, 01
 Mar 2024 18:15:40 +0100
Message-ID: <5f505604-7bf1-471d-9e36-d9712daa9064@gmx.de>
Date: Fri, 1 Mar 2024 18:15:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz" <megi@xff.cz>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-5-fiona.klute@gmx.de>
 <368ebc04c2ec436791a27b5661189783@realtek.com>
 <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oBc/9sJlAJ9BjaP7BJSlBLNdXkjr1+CXPGS+/N9ZlDRsBaPhbnC
 8rBREzksiKnLGVOabO9IUClXt9+sQZf4jIyuPsgQB7q0mtkgd6i9ImMlgKeFleBDiLXZw0k
 jqJSuhm4EIxkZHO4E3FS/x7mJxhwzK1gnwDKN7KieegryS9dmtByMbRhz73YH1lJEsowioD
 9SFZTsK8Aw+8iJ9n7nuKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aWtxkTefEKo=;UfjjvKDI4U4cHpSbJKyIAVYwLHI
 qxcUOLvinek+jDolIMIqrCF6Blo0l3KfMyALyihFUTpBLFgXDBovnKEyYvbwgu9NAFz7tD4Fg
 /g5Hms4zj19WpBSOaGMyeB6FtvUb1piXZDaBQsjHN7yqTa8uFqAsQqpZ8xGd+axr949kMm5Q9
 6qSi/k85czlNhheU2Is0lcGqMqnoft2FGUJanl/wTPVxAKRCBMPJ3BSVvTdwFUdGw1rPWrmvB
 tBS1ryUffq0xHJFrLCrMBhD0CUsgpNduLLY1wbn+gD7ET42KRDApvWXFlsxmydIBDyu1BdauM
 l0QebPKPJr0NDqe/aVSNH+zGOFxV2SelJ1eyngmxFQ40Ugf/u8fRbIAiTX3S9TZUnuOAb3OKC
 cAD+kAr5dqjz4/HEQRFIKLD2Y8lWXaGUYngvghKSw4uR3Q895FO0AGUeg4pK2dwz+QJWDgJB3
 +OY/5Ffb1lB5nXStsVFY91Jr5la12yOQB04RjZ5+zCWo0lD7xLAb6rjnplAe9UCfijzXy7sLO
 iIe1XGw8ajK8rg34K4cdyRHOhQE7eR3hvpVz4Dy55bGK8aaeS4ZdlVsFIBeR7hHVO5OcwxW+g
 OjTbDxbVr+kqLEZzjc6sFKkNNKbfA/CVF1FglabCK+mwypAGUb4GW0aUrW+OsFV/gT9itZocp
 EWZVVQKKwBNKbipFvjCoAOVvAvbJfjJHh9XsnkbbW98z9htbayNV8KD6knj1o8a/06Oqruc7a
 02/Xz38aX7Vm4coNT0Bqla1Me9omOghzAvSo6al9nPfH7jef4r1oq/1u+qwdb4p+4Qbefi7fa
 dtQ+YZ6KF35hktD7UJwrLB4MfbViby5Ce5Bcmff0HctsY=

Am 01.03.24 um 17:35 schrieb Fiona Klute:
> Am 01.03.24 um 03:09 schrieb Ping-Ke Shih:
>>> -----Original Message-----
>>> From: Fiona Klute <fiona.klute@gmx.de>
>>> Sent: Wednesday, February 28, 2024 7:55 AM
>>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>>> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org;
>>> ulf.hansson@linaro.org; linux-mmc@vger.kernel.org;
>>> pavel@ucw.cz; megi@xff.cz
>>> Subject: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
>>>
>>> This is the main header for the new rtw88_8703b chip driver.
>>>
>>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>>> Tested-by: Pavel Machek <pavel@ucw.cz>
>>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>>> ---
>>> =C2=A0 drivers/net/wireless/realtek/rtw88/rtw8703b.h | 103 +++++++++++=
+++++++
>>> =C2=A0 1 file changed, 103 insertions(+)
>>> =C2=A0 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.=
h
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>>> b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>>> new file mode 100644
>>> index 00000000000..69dac101d33
>>> --- /dev/null
>>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>>> @@ -0,0 +1,103 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>>> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
>>> +
>>> +#ifndef __RTW8703B_H__
>>> +#define __RTW8703B_H__
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/compiler_attributes.h>
>>
>> Removing these two headers can still compiled pass in my side. Please
>> check why
>> you need them.
>
> If I remove them whether the code compiles depends on the order of
> #includes. If some other header that includes those two is included
> before rtw8703b.h it works, otherwise it will break. I don't think
> that's desirable, though other rtw88 headers already behave that way
> (e.g. main.h must be included before the others). Also, clangd will
> complain about undefined types (u8, s8), which is less important but
> still annoying when working on the code. So I'd prefer to keep the
> includes.

Correction: Only the linux/types.h is needed for that, I can definitely
remove the linux/compiler_attributes.h one.


