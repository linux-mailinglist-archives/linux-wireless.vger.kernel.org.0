Return-Path: <linux-wireless+bounces-13088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7E97EFB3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313761F22004
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8701EEE4;
	Mon, 23 Sep 2024 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BBMXPvuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907C2629F;
	Mon, 23 Sep 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110838; cv=none; b=tZeUeaOrQdAARwDhT1Wiu05/E/UNQEgDT1CfgdV6Z5/ob/ezQfS8m4n5i6LKwFYArGbRSV72YozaVtl+gKkIy9rrks+cGJ4e7QhtabD8jdxz87lO1wXwxQ7zTeplPO8p3q6t/qPufT2rLL2Qus+vLf6lWZmOVoCwtlIrBQLQJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110838; c=relaxed/simple;
	bh=v+yxPs8GZWg6nkLoPwBWjRb8a1YmkY1GCLemw8pnWUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQG2/mx9eTRKbT/yjM0swTAsLbaJ2BdN6SOqf8voFZvNgif6H7HVGPE6VBb/oa/EUvpwppH1YLdj3vr051t6TdeGhdcdvlYbMxSrje6DRB8CnA9wGpL/mvI9NiI1ekpWBQvLOQxpkNwuom4Wmh34J7SPtOy1vRir3DTaaCqNmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BBMXPvuU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727110807; x=1727715607; i=markus.elfring@web.de;
	bh=q+VlKGwRDHTO+bOEiYO1KfMPblTtmzY+O1n5BAz3cc4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BBMXPvuUJVDwzgv6az3DHdD+mUYQSYeKkbF7duHFNHOgiw18X0An0jR9exzEjGot
	 r7vT+0/ElA8R024ZP8rHvVQHa/qyTogXiEdNZfZyfJOnQYnsPKukmgv9XM40een8e
	 gkPIDyPV72BsP63rwkQHUaL/hduBuCm/0L+7NwjsoLhwD+VRJXp4ylnVndNvJRB3T
	 6uqw+k/ahTi7kAVyiulcIc5tysFpUcPwvBl0hdt1x3CV0pPl/YziEWe1KOhHNsVWH
	 CeX0em+lQdLx9Ud0LSV078rephSU/UtHUdqGLBS/ooeP1R+rNZZv4ac+7AozTO64Q
	 vTeJMEeJlOTonCdlsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnFyI-1sBm6N1VDA-00ibs9; Mon, 23
 Sep 2024 19:00:07 +0200
Message-ID: <45f6c8a7-4021-483a-aa81-a836cd3fbcd8@web.de>
Date: Mon, 23 Sep 2024 19:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ath6kl: Reduce scopes for two variables in
 ath6kl_sdio_power_on()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <julia.lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>
References: <d5a19bb5-f940-4f07-9f98-c670d96cc839@web.de>
 <33b08664-fa25-4cef-86b2-49f65b4369c9@web.de>
 <80b820cd-9255-473e-8e4a-3e7d8612d876@quicinc.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <80b820cd-9255-473e-8e4a-3e7d8612d876@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XDK6MwoVMWqJJGON/YSF3HHcH+Xhz28db+WaYrZBNH25hIHj4jT
 N/UpcCsqcGeD2odrBnHVvmU6x5Ys12u+a9YY/RC3q6LkqqdTPWig9T6X2RWQiEB5n06twWL
 jbUx7zWXEVG1ry1vPdK3nqY38g8wk3WeREbkr0S2QZdWfzxm92Y3tFqZK6caq7y/AFM4sGX
 M7EdTGGy5LnQkexBR+GGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q1IiIedNCjA=;Yj5YomPI5jtOX8SJdZnOlD+0aZA
 RMByUd5TrDN0aBgGo8bF2nyEjoXpweAitlGJB7k6lUXmbp44jjUpRXqFkoNDHRJeFOdEU3Owx
 BG0tzTOMUVNVm1rntoCUL5CLxd3++ME+Cz6vjrmG2OYjIDpQl/mWBAo1pUld2x/Dkvypqm75b
 1505pzW5Ky/2WoMOdU4ixUKKq0MDVP+Fd/KPSYXgAbeD6pKE2tsOAgyB/0ULis5HhMuhMqDSK
 ab0b7wKFUW10zkKlkx9l+GteDgSx2tt81ZOWBa8qisMU0hmox62ISh49+YU1AV5AuRpwCOQkM
 +pgONpwqP2ZTpSuglMHNJ8VlRYiW8ypVhpQfxPE/6KK9CekRCBkL6Q8Pc1rPSWrGrwMdGN8Dy
 mExENObEf5kF6WXalrKfaismHJ9JAsUaSQnEMb+MNoYTOmjrqQH+25F2Qj2kn0yfy1beaRBJm
 3HY9MzTlYrPdvukAg2XA+bEg3ecP7kY5IWkxgRrQioCChVDHMe813WaYQ/GxYlEtaOpygtkm7
 zOE3d8KrLPFiXmGof+CaPwn/axLQftxec6OGPeAkFB93e6wulZ3lq4IOiNtbUu9ni3D7zUyI4
 GvUs1W+AKo0G3QBPlpKDZgp4UfVeLY0vqNLrTnm0Ux338ibCVe01YAWviNrRXYDdJr1mjQtmw
 0dadu6XXe6CJOEoFhl9zLjj1hiQu31BgzUrk/9A+eoElrjfL5xOfuaP0PwMGLZYsRkHbGwNJR
 OC9lfGdzMw80Pr5pq8ZT5Nr1k66j0jJAkF+Gl+UyS/yzy3qhAI9Qjg0zQsnoydOF1eBilERLN
 hzg9VZhoncAI2wjd/cTRAmCg==

>> Adjust the definitions for the local variables "func" and "ret"
>> so that the corresponding setting will be performed a bit later.
=E2=80=A6
>> +++ b/drivers/net/wireless/ath/ath6kl/sdio.c
>> @@ -503,17 +503,15 @@ static void ath6kl_sdio_irq_handler(struct sdio_f=
unc *func)
>>  static int ath6kl_sdio_power_on(struct ath6kl *ar)
>>  {
>>  	struct ath6kl_sdio *ar_sdio =3D ath6kl_sdio_priv(ar);
>> -	struct sdio_func *func =3D ar_sdio->func;
>> -	int ret =3D 0;
>>
>>  	if (!ar_sdio->is_disabled)
>>  		return 0;
>>
>>  	ath6kl_dbg(ATH6KL_DBG_BOOT, "sdio power on\n");
>> -
>> +	struct sdio_func *func =3D ar_sdio->func;
>>  	sdio_claim_host(func);
>>
>> -	ret =3D sdio_enable_func(func);
>> +	int ret =3D sdio_enable_func(func);
>>  	sdio_release_host(func);
>>  	if (ret) {
>>  		ath6kl_err("Unable to enable sdio func: %d)\n", ret);
>> --
>> 2.46.0
>
> NAK
>
> no maintainer wants to spend time on patches like this which bring no re=
al
> value to code that is not actively being maintained, and which violates =
the
> established understanding that, except under certain recently establishe=
d
> criteria, declarations and code should not be interleaved.
=E2=80=A6

Would you find other software design options more acceptable for further
collateral evolution?

1. Additional compound statements (by using extra curly brackets)

2. Moving a bit of source code into an additional function implementation


Regards,
Markus

