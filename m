Return-Path: <linux-wireless+bounces-4312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DCD86EDA6
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE651F231BB
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349F6AD6;
	Sat,  2 Mar 2024 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="MWCI2s7w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA710E5;
	Sat,  2 Mar 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341054; cv=none; b=QAA1aCb4v1xYPmfeyT15ibOlsckXjmqI5ozhdIwV8pwkUkL/j00i/tS/Kqm75fyL3Wupq/c8o3Wsz3OuAMs8oE3qTro0tkKXo/qWbA4wEyjwfBsT6IrLfKiXnU7zJPI2hOm7ShqOH1Etb467652bK/qijHcZG2ATBycPwZdp6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341054; c=relaxed/simple;
	bh=HdjjSZHkIvezioP3p22iivT1Q2zoquV3UXNTsY218Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaHSewNQHdMHukDeaFhU6TA6uJRayEwAqUA/0ZWzvTXwtEo3jqtVFh5EvV6k2O+QIgJCwPDq7r2rgNt9JFBD9hx8pszf07b2bST5MJHPa/rYOxj39qiq6jqkB3aRKTrbxioAKfTZCNXUQlzFP715/4vfDn95kAs8Wd8zoPWSZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=MWCI2s7w; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709341036; x=1709945836; i=fiona.klute@gmx.de;
	bh=HdjjSZHkIvezioP3p22iivT1Q2zoquV3UXNTsY218Lc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MWCI2s7wg+n6j7NQP/zVJbNyR8XX5NsPO24CBFPr16esADJ7TD5VGJa7eSmxbVOP
	 Y9FN5jOD5uoFDNSdnjkFaPZ8a/MIO5u/Atm6aQQsr1X5n48DLkgim0bA6nxzMWgcL
	 ZBKibpj7a8aDZCB9TDVqc5dvmZnZcQR7isDbwymJGxyWjz2EczZSG2npLqUyB/Ndu
	 QPjfm17Mwc0TUtstdbKjdsN1ZX7HsZaK6P0l7PJPmKvA784dWeMMHsEaw0/bi2reD
	 59GaziX10bNzp8tqWp1hC/oWKeGI1d6wVidWbJ3MoCa4y+XiSKdNeLOwwaPBG0C8M
	 o5XgBDpCQjF63lT9YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.26.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1rbUit06L5-00E8UO; Sat, 02
 Mar 2024 01:57:16 +0100
Message-ID: <66a094b4-da4a-4211-ad9e-8c21cabe32cc@gmx.de>
Date: Sat, 2 Mar 2024 01:57:14 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "pavel@ucw.cz" <pavel@ucw.cz>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "megi@xff.cz" <megi@xff.cz>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-5-fiona.klute@gmx.de>
 <368ebc04c2ec436791a27b5661189783@realtek.com>
 <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
 <613176601db939f6e078b398c4207b6cd279b120.camel@realtek.com>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <613176601db939f6e078b398c4207b6cd279b120.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VbOVg0wjykTRwnN+1uyG4R7eIQOAAifA84Ajlr7vjqMW8/Xtxxn
 teGIFbCdPYbS1gYO3nLfNFkvpaRK4jrhMHgUSQ0E5kOLE1iuJA2OpxZOx6ytkQ1ZqSLEb1i
 qikeeR0gj/GDjDiAToD6NR8hVDcomdXbOdhO4I7bhb7RWKt9V/sTaX3tJZh2uQmAuMxcsZN
 oCe6iOLaZDimFWR/Kch2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iobTZX3IJn4=;ZQCqfKybbpJtLyrK3/du4VFL5FQ
 wnqF5ipVT3CW7IjcWEhX3MZfwjywj8bO/sBVttyhBgRnYvZcJ2xIuR1n6qqf9u9ALBUT4vc4b
 QtMQDdQMCavYA1+rkf+MYEjyhMyoVqnFqY0YuP/eOQmOZRYJt+s1adryUnRF7TQ1BdfFQ1hT2
 xf1arIuMcUZbVBCbD2QVPpSfwg0XRjk6vakBrt4zCaiRZoRmtSUBdsNEEXiKDuIAPZ+MzfUqh
 dBN4Hk8btJYp5BSQBtFFIUJ6iuxVKgYY0VSClQ81XSkjSGXXjd4A3qnNwTLoQ7pTRQ/EpshLx
 ir0hGo2rfZDLvUxXEIqM4bekBm/jCuCXW9eOETBj7EL93ss1YBqEB0hCT9t+Fz0OIOkrniLKi
 M43+8jhHSlEcSo1w4DVrYThkK6kJFASWCzsZmHLmuY596crbkuU6gjwDU5vjd+RDq8PsIwz1L
 lCFtJmKkTzHMdah1wzNuAFJA0Zg3isHk6jqs/jaLf+3+MuJ/pyiZLiolkfA7grotWbWmJNjS7
 XZhLVD1Q1S7VVMzrVLAGIviqG+rI9+XIyIsmnhRdGn5VxwtxXJ4F/FPpTwUV8ik8K5mIY8jl3
 yiRRnQ1IUlHwPMYnJ1LWLWxwN9ZfgE5q2NR7wwRATZ7+b2orBWNOAhRS6z8qUf119l1NgyvXM
 G2Jp2V86C72Is4wfhAg0R2Wltu+wPWX17K5WI/KSjwcai4PWXXuCf/ply4GdpVr5lCiGc+x84
 w51Q9QYeYJPj6bTeIKTNNboDsYwSPKLSC1wf6aHR2HJsUK5T8dw76h0pek/8iD1kY62k3iLEj
 U9ynou9tIJw1sevBLk9ve3tn6LmVg+cYpM0eoN6WdB13c=

Am 02.03.24 um 01:33 schrieb Ping-Ke Shih:
> On Fri, 2024-03-01 at 17:35 +0100, Fiona Klute wrote:
>>
>> Am 01.03.24 um 03:09 schrieb Ping-Ke Shih:
>>>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>>>> @@ -0,0 +1,103 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>>>> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
>>>> +
>>>> +#ifndef __RTW8703B_H__
>>>> +#define __RTW8703B_H__
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <linux/compiler_attributes.h>
>>>
>>> Removing these two headers can still compiled pass in my side. Please =
check why
>>> you need them.
>>
>> If I remove them whether the code compiles depends on the order of
>> #includes. If some other header that includes those two is included
>> before rtw8703b.h it works, otherwise it will break. I don't think
>> that's desirable, though other rtw88 headers already behave that way
>> (e.g. main.h must be included before the others). Also, clangd will
>> complain about undefined types (u8, s8), which is less important but
>> still annoying when working on the code. So I'd prefer to keep the incl=
udes.
>>
>>> By the way, rtw8723d.h does
>>>      #include "rtw8723x.h"
>>>
>>> Can we use the same stuff?
>>
>> I don't think so. The vendor driver has different code paths: With 8723=
D
>> it takes one for "PHYSTS_2ND_TYPE_IC" [1], with 8703B the one for
>> "ODM_IC_11N_SERIES" a few lines below. For those "2nd type" ICs there
>> are different structs depending on the page number
>> (phy_sts_rpt_jgr2_type[0-2]), while the "11N series" ones always use
>> phy_status_rpt_8192cd (all defined in [2]).
>>
>> However, the mainline rtlwifi driver has an equivalent struct called
>> "phy_status_rpt" in
>> drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h. I don't know if
>> sharing such definitions between different drivers is desirable. If yes=
,
>> please let me know where the header should go.
>>
>> [1]
>> https://xff.cz/git/linux/tree/drivers/staging/rtl8723cs/hal/phydm/phydm=
_phystatus.c?h=3Dorange-pi-6.7#n3142
>> [2]
>> https://xff.cz/git/linux/tree/drivers/staging/rtl8723cs/hal/phydm/phydm=
_phystatus.h?h=3Dorange-pi-6.7
>>
>
> Sorry for confusing. I meant to remove
>     #include <linux/types.h>
>     #include <linux/compiler_attributes.h>
> and to add
>     #include "rtw8723x.h"
> like rtw8723d.h does after this patchset, not reference to vendor driver=
.

Oh yes, that makes sense. Thanks for the clarification, I'll do that.

Best regards,
Fiona


