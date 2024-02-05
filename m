Return-Path: <linux-wireless+bounces-3143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2184A045
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E5F1C20C30
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9632C684;
	Mon,  5 Feb 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Z6EKlFqS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7D40BE5;
	Mon,  5 Feb 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153040; cv=none; b=B06kEsMN0Uu5TTFaHLQnIMI2KlBOwiRmFn2B9f1pbCZmt4PUpCX4GXJ+Aqj8BYbktyYa7pO3yXdoMyz36Yi390nkBnj8fEU/lTRpCCw+sdxhYqFUrdoDZn/wm7oIrSokb5/R33LVoWXyCn3JnoOq7MpTpn+yEo5cJyIygU3LBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153040; c=relaxed/simple;
	bh=E55RYmUBMQctuQemb587garWRVyRdXxZB3yTZLeiizM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JipciB2JHmBin14OQak6IqwcgaG84GglnjfJfvwqdL9CsfvQIRJBYb5Vcej5BU59VE9Yo0j0zO5YbPFb62RK14aARUH663IB6R1qt/nWIHXznIuk1gN5VtWE5xbvYhTbtPYZ682Aj7HyUcUy2IdZhH+ZLjcATPQLB9Yitvysmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Z6EKlFqS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707153025; x=1707757825; i=fiona.klute@gmx.de;
	bh=E55RYmUBMQctuQemb587garWRVyRdXxZB3yTZLeiizM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Z6EKlFqSh56cw9sBTtbuDIdE3GLhmjjTkFt6eJe0ybbGFfNNPitNcwCSmX7q2GTz
	 ADi1JIY7qFIoNeUWEoivKllMeVSkI946Zjlv+MQkjBtZEru8zI/ZjFAMCIeBN9adX
	 iMk0UMIpXh85/vUBG9f2F2QlLLnN1TFZwRAmeJ0c2UGHwjAUxWvBQlBsp4Ya/oRX8
	 al2RF/s2tFNEPRt334tkRJxIX/DR15XrmqldufosodBXfDK4hcP4Z8rs5kN1JX/M1
	 LsZeRhc2QkpOqtSmrlzqM0yndM4KYnq3EkRbF+GI4PFvPuSI/SwqHoFoa90vNS88z
	 jq1Tcpn0Raf+2lnK+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.18.163]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1qvsDY3lDk-016M7v; Mon, 05
 Feb 2024 18:10:25 +0100
Message-ID: <ab86faf6-63bc-4e99-8c62-3e397c01ea23@gmx.de>
Date: Mon, 5 Feb 2024 18:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
Content-Language: de-DE, en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-3-fiona.klute@gmx.de>
 <40d7f3f551254cb8b3cdfcba25052550@realtek.com>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <40d7f3f551254cb8b3cdfcba25052550@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwX8aFVC5Z11pkhJyfN9w9WeV/W5WL7O0l/olb858OlZSGJCQKn
 lf+hxDVSwBGSI7VbYSM23rImicVLYXkdmfR1VMrEMWed//klLIkc/vecS22kXpOONFF5EGq
 K0TV1K2/58ghn+De3dwQOYFSG0aoaU+Zz2MQ+QE1IYsAvpHV70b3oxXqosrO4iRjtSlwL8S
 Cx60zGI+8dDieNkAVXSIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zhj0d47jiLU=;ewJA1H2iD5Rnd26js52JcdJH8ZG
 ALkwG3lMhhx3QQufm0AKJHtqRBl124jxqfU6B8NKv58qMhWArrJkZHPtzIjehoG5fMrzRG0TW
 uW0CkOdt+5iDDEsYltZEiwbD2NgkNAd0x1RECBwZRwirSd123Eu/dE7ETmv7qcSYTqd/OJVL3
 NUPZWCWuVKx7arXYWq3s4oUingtkvbcJcXinlFb3sFfIu8JO2N0JDOc6J7ds8wnPxd3/CCqRD
 coA43Rbg3/GMCvOdiAX0JSigaGy68SOxGj/GFg42+LKbwe7J2oBIG/Uzv/Vycgk2clzAh15z8
 HbZ6tMEx7hysKCTOVQmBCj0HrISibRSH+3zSkBifsCywW2M64xpoARBKMogaqlJkOxhnf5gk8
 F+ktBEY2IhE3gG2Ex/rzfD19rWnEp7ASwa+rW4+nQbFcnuAglo5gK7vG2Pm8bT5kJovMRg+bR
 R6xHx4aX9g2q3660x5kY6caYI9brYhr//6qiK7b95838OvabyU7fUDTIbssFXoT/j+pcVvC90
 498IIOnFCoUrwqO0W2o91xzSZYK5z01oBrapTpScaLZ3QsRc2SviZOuFY6hpX9E6ugzvl03Qs
 oxIGFog4qI7lx17KHOdjEob2tc5pGXqjxMIeq6mB4C2nfizcdmxBY1uxzZPyvdL5c5hY9MZEn
 y4+jgiNqwJS4jNc3UClN6XDDyhb3jCp8xF0DzbKiaeYop1EI+yhQ2XxABsH4wZNA+OTZFhqYP
 u/DPlBLmY85TzmGA/NfSKLidgHzzBr05j76/Xe+oNQDmSh9Un2W+yfB9qZomvLepqzEdtky/u
 XkgmOPosSOuEucLO5KD1mNBE38PK3w47FA3Kbey926Gys=

Am 05.02.24 um 03:17 schrieb Ping-Ke Shih:
>
>
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Friday, February 2, 2024 8:11 PM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>=
; linux-mmc@vger.kernel.org; Pavel
>> Machek <pavel@ucw.cz>; Ond=C5=99ej Jirman <megi@xff.cz>; Fiona Klute <f=
iona.klute@gmx.de>
>> Subject: [PATCH 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
>>
>> Some 8703b chips contain invalid EFUSE data, getting detailed
>> information is critical when analyzing issues caused by that.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>> The TX power table debug output function (rtw8723x_debug_txpwr_limit)
>> isn't specific to the chip family. Should I move it to debug.c
>> (e.g. as rtw_debug_txpwr_limit_2g)?
>
> I think no need. My another thinking is to add an debugfs entry to read
> these stuff out, but if failed to probe we can't get these information.

Okay, I'll leave it where it is then.

>>
>>   drivers/net/wireless/realtek/rtw88/rtw8723x.c | 159 +++++++++++++++++=
+
>>   drivers/net/wireless/realtek/rtw88/rtw8723x.h |  11 ++
>>   2 files changed, 170 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> index 2b58064547..bca650c6bb 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> @@ -63,6 +63,163 @@ static void __rtw8723x_lck(struct rtw_dev *rtwdev)
>>                  rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
>>   }
>>
>> +#define DBG_EFUSE_VAL(map, name)                        \
>
> I think we should not hide 'rtwdev'

Okay, I'll change that.

>> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%x\n", \
>> +               (map)->name)
>> +#define DBG_EFUSE_2BYTE(map, name)                        \
>> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%x%x\n", \
>
> Should format be '%02x%02x' for two bytes?

Right, otherwise the output could be ambiguous. I'll fix that.

>> +               (map)->name[0], (map)->name[1])
>> +
>> +static void rtw8723xe_efuse_debug(struct rtw_dev *rtwdev,
>> +                                 struct rtw8723x_efuse *map)
>> +{
>> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->e.mac_a=
ddr);
>> +       DBG_EFUSE_2BYTE(map, e.vendor_id);
>> +       DBG_EFUSE_2BYTE(map, e.device_id);
>> +       DBG_EFUSE_2BYTE(map, e.sub_vendor_id);
>> +       DBG_EFUSE_2BYTE(map, e.sub_device_id);
>> +}
>> +
>> +static void rtw8723xu_efuse_debug(struct rtw_dev *rtwdev,
>> +                                 struct rtw8723x_efuse *map)
>> +{
>> +       DBG_EFUSE_2BYTE(map, u.vendor_id);
>> +       DBG_EFUSE_2BYTE(map, u.product_id);
>> +       DBG_EFUSE_VAL(map, u.usb_option);
>> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->u.mac_a=
ddr);
>
> Just curious why 'mac_addr' is the first one in rtw8723xe_efuse_debug(),=
 but
> the last one here?

I just followed the order of elements in the EFUSE data, as described in
the rtw8723x[eus]_efuse structs. I don't know why it is that way.


