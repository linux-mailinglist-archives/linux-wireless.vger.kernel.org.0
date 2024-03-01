Return-Path: <linux-wireless+bounces-4301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D068986E652
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2EF1C250D5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D64C9C;
	Fri,  1 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="EBhgQyw3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284298F65;
	Fri,  1 Mar 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311634; cv=none; b=njYdsa5RzmfHy7hUabFFPufbJpms5JdAY8XYA+GrtQwx8FsjFDToQNyYXSU+3RXtW+rIozo/bx5UtFUxmRQ+2td/rZwWEcJeKCt7e7d0XG2ItBh2URO6V2VNJSkH6I0PThZ9xjpApboMqrMLGNv9r+UxLzTCw1Ktr+Q7fDlhFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311634; c=relaxed/simple;
	bh=xlqwWpcG6EW1Q4k9Nmo360zWF/4UyBn6V/F2xqHM9PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6lHA5ArdHAT4fx9cM+qMOyA/OdqNKQzd2+ACGKcV0Co849JMM2wr3d3IkU8wo3I6W0APVJnXe1JrXGofW9EPQO/r/URgSxoRTX+S21VbhHnoNVe1xVRAhNpo6pFW/TMrdRIHsrFPbJhXCav+OyY1ifR6W4K7WicWcWeA/k5la4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=EBhgQyw3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709311615; x=1709916415; i=fiona.klute@gmx.de;
	bh=xlqwWpcG6EW1Q4k9Nmo360zWF/4UyBn6V/F2xqHM9PM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=EBhgQyw3H/T6WrE4Q4irUlw7h6BYuPmORbR99dRVP25a+fq3MzLKxl2Txixfnc1Y
	 HXiXGxmH522OrZFEtUNyrzsvErXyxXqRCopFsq2uHOAG14qFd1iNfpP2u6j8Vaclh
	 96VswTFyjSKL6lnOiBTQ/cHX72woqV6OOQGVL+3ZzIHL96T67KwqMr0hbzCZEmYLa
	 xpkH43SZO2cEAZwT2+I1MtrORXWa4myq504W06Hke3ERSOLkfz9+HJxoHpjG+B1tq
	 WuM5kgDuppiHOR1IK3M038oOb5DJBAo2L4zBpvyQCP/uiRx9+bpspOf7eu91WPk+L
	 FLdaZG+wRAeML0uQpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.26.244]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1r3mf539i0-00njIF; Fri, 01
 Mar 2024 17:46:55 +0100
Message-ID: <da4b13d0-fe4f-4aec-8dfa-e64a5959387e@gmx.de>
Date: Fri, 1 Mar 2024 17:46:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
Content-Language: de-DE, en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz" <megi@xff.cz>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-8-fiona.klute@gmx.de>
 <9ee0cb2bd7694e0da8f0576da6a182b5@realtek.com>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <9ee0cb2bd7694e0da8f0576da6a182b5@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z9+JZpDhyg18pklHng7Crt8vflLg2nwuazVfmZ5lJLYYsfV2QPo
 mc1JBavRioDzhi8IgQYR0CGo0bWCV3qSJzhiWpOVb2FUhWMgL++4sfXlA0gHJOYG7FrNNZs
 Sh7L6jvTzOwqEHoage8kRnUa5/Sb78GDSFup6b39dggiJfK0X7IRtaKuxD5SlFo7fFWtAk4
 Aymk9NtoJF6oXdYMzZS7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KJNbZnyJyzQ=;mrj2NsQU8iTJG6YhvV/BSlqQsMu
 SsETvPqWrCAPFbuIeIm8BVkGjMTYrr228vJTYYxPhtY9frNQfDHigAjm3c0s/QPbRPQXZakTg
 VE3fUBxLkPt/lmKPsbZwTLIJ+PXc9QHvg5xs98p90J+VyJSCuwTZX7DgkWZAmh/sh10/fLBzZ
 5fEfpQIriOJ1XfrUBjHckXLM4gwd3HnqjYdsb8JsRUZeQh/xUeCgVrmbecQcFMNwm9a2HzZNi
 zCbDodk+XpkumTpAIQqVb9A9B9r6dEfBAuVlm1ziI0yp2I7OvLjDmRd3zgca0kjaLsKC6KWPP
 MqiuQtwOL0OfhUWxGqoCxStquiWbVKIPww6Po3r9jhokcB6BfFPKhyboJL+KKmIH13MH2ktnn
 JohhslP0l77prOX3S3pNbMA3P/AzRFa/7Cywf5C/D43zVHvxKmVjD/05zvOR3DQXgmxJ95+ke
 XjcyDw8ayzvxX6NkO36UjcC+/B+geI3Le05zI8vGa4vWN1Ej8aLPRaNxJ8xZmkEqYs4f2Mt5N
 eMiGjhkR1YgR9oiHBIpMusSRs462FVUCP/Pi16R4KbmUZ8IewWWFHPco5NorL/94PXHiI3+dS
 NZMkTESxg1KkQfjHvp/A8Y0afv164ngyiRvBxAMzFU37Oxex5dqCOIDWRaTHIUkGDaXNN9eVA
 Vk61JPEC4tkQccJZsgSQqYIDcdQMF8glX5wFrV7EXcO046Nq8oVxRHgqcHqFuYTl/eCKFuhnr
 m7YyNmCFmRDo3v+NnrdzXwbwvM0rfHrabCEYfbgx6KhHGNjSWR55BVpRZM0Xi5k7QBgMSiIED
 YZbEi6SegQQyxVkNk+buO2Xz9AxrjyVSXaNCi8yUEA8eA=

Am 01.03.24 um 03:36 schrieb Ping-Ke Shih:
>
>
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Wednesday, February 28, 2024 7:55 AM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@lin=
aro.org; linux-mmc@vger.kernel.org;
>> pavel@ucw.cz; megi@xff.cz
>> Subject: [PATCH v2 7/9] wifi: rtw88: Add rtw8703b_tables.c
>>
>> Initialization tables for rtw8703b: Initial register values and TX
>> power limits.
>>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>> Tested-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>>   .../wireless/realtek/rtw88/rtw8703b_tables.c  | 901 +++++++++++++++++=
+
>>   1 file changed, 901 insertions(+)
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables=
.c
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
>> new file mode 100644
>> index 00000000000..6ece407d560
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
>> @@ -0,0 +1,901 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
>> +
>> +#include "main.h"
>> +#include "phy.h"
>
> include " rtw8703b_tables.h" to avoid sparse warnings:
>
> drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:16:1: warning: symb=
ol 'rtw8703b_bb_pg_tbl' was not declared. Should it be static?
> drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:194:1: warning: sym=
bol 'rtw8703b_txpwr_lmt_tbl' was not declared. Should it be static?
> drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:306:1: warning: sym=
bol 'rtw8703b_mac_tbl' was not declared. Should it be static?
> drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:633:1: warning: sym=
bol 'rtw8703b_agc_tbl' was not declared. Should it be static?
> drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:841:1: warning: sym=
bol 'rtw8703b_bb_tbl' was not declared. Should it be static?
> drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c:901:1: warning: sym=
bol 'rtw8703b_rf_a_tbl' was not declared. Should it be static?

I'll add the #include. Oddly I don't get those warnings, I wonder if
it's a difference between Clang (which I'm using for easier
cross-compiling) and GCC?


