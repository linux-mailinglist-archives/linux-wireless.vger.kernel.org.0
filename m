Return-Path: <linux-wireless+bounces-4303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E786E677
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6E62886CC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF5443E;
	Fri,  1 Mar 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Cf9qg9p7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71783A1D7;
	Fri,  1 Mar 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312095; cv=none; b=GmWlIJcRlMIuOzWOSmEGUaIr+IondJ2fPs9upy0hkii8mNcIg+Mty3Dkcl/OVdzsa2+5jBFgrt3R28hGAtNqOCqOrDsXINahoKM5Pa1b9ziIHAHp43A7SwlnQdBr2kEjiTKinp39/ucF65D9zZoxYvNgcIJincgzAkfo6yWnTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312095; c=relaxed/simple;
	bh=f8/rMyUg9FuVECy3YwsX+FGC9fVnlTu+TOaoGeIh/9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjyjkWMtjfGNLQaXs8bJkQWa7zjdIiRztOxrTMZR3WbsYdoZg8pnDSadLlLrPVVrTSAkhy2LojlP329bYVqt1e1TijK4813DQF1497hAXy6X32B5of5V1u4CLixNn4R8YOa0XY6u3WeWKglCqItARC4b88X2aqeZWO+uzXckTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Cf9qg9p7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709312078; x=1709916878; i=fiona.klute@gmx.de;
	bh=f8/rMyUg9FuVECy3YwsX+FGC9fVnlTu+TOaoGeIh/9s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Cf9qg9p7fen1dtghoz94OvVPQ6hbed96M4hrNdYXDg6UzXvCRGeBxdw28PdTcBAh
	 zC05VMzdytOmXaYZiPNJSqagh8CNSd8AG9rTywPFAJWIF6Dqc4bE7HS9qBudJNILD
	 ahRpVRtp03urEhNnZKNOhY3qwbaahKE20QwMOZKwfp1NEeu22zZmxI/uLiWWn82lp
	 iK0Mt/yvaPnAUx6ZGRZ5gIGsX0O6r131ySLsqg6EsGQ1L1XyHLVSp0mD3fcF0zmdy
	 zx6O0a3RYDJZqfHREd3L3aWn98eHqaGYp9NV+YoWpqnRYA0LgZcXChX7YKk4gGCg4
	 i/6D7Pa0O4H0xkAqbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.26.244]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1qxDjm0LV6-00yhxo; Fri, 01
 Mar 2024 17:54:38 +0100
Message-ID: <7b860e34-705b-43d9-9e61-cefdd768ccd1@gmx.de>
Date: Fri, 1 Mar 2024 17:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
Content-Language: de-DE, en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz" <megi@xff.cz>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-6-fiona.klute@gmx.de>
 <3805850d51334319984bc304ca1dc3c4@realtek.com>
 <4fc45b4289d747dd80f76dcacef3c54d@realtek.com>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <4fc45b4289d747dd80f76dcacef3c54d@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+X5ub84Ek1IUhOL2LGiGFvucBqpRvmgsm4QcmUvrnCacPZMIBlC
 Owtrq1IyPzNn9bNLSiM79YzGnrfg2arcgp1PKmE9cswPCDno1+EMV+hxukKNK9mrUtCfa18
 VdkAecNt16Vz7FziEZZbuCdTWBeDEt2ylgInaMRUEszrDJdFvO9lmbUxXR4UCXp7w7ZJt1x
 NhrRaqm5G6XfUJPgVh/wA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mtEZIwzA0a8=;Q2O80z9l2Lkl7qp5XTsQKfdWarX
 IFL9Cz7aZBdBTIBFWKmb/dO6sLaqJMhNNUqLA7+lIBEhN+I6gEHhzs5/DuhwlEesR0gB++dDA
 TAB8qO4HG4/JKyih40wbHuh3gpqfB2klHHM7YNVSz01urHQl1xR7jqyUugfEIG7XRzJBrC5KR
 mhDQBe6Fmu35L+5Mmi3bVR0GNQ7YnlMhYjux0EqKjFl3b4jRVtj2+NW/D+Vmew4uQLMGJU8vx
 G1ZVMqnbryRq7fB0eX5SFLOsFlqLgrzXKwi5bc9SIbebmpveTMRhVoJ3cjp7sy/ouWlIx/QlD
 zJZMnG2t00c+NUYWYlP0GWAggvY+MEjmRs7JTRPt8/DMabZFla+oZs4FWjgJMglCmWS4/wsYY
 MOL2L/XjyXcem6XR2ZWkRFJUloEzG0TOwnjkXuq3m20HHr6oHr4BpWEejPLu+7ZW6O1c0oFqs
 kRaM1Zd9vMGaRtZKq4M8WiLFYnNU4D6227SbcmxV+plRpT4fQ9xiOD/WAg1mfIjsOsUx8aQrD
 N07j0WGfKALn421o4yQudIidm1fl8ftHcrIHrcQjAvRktHnf9TKWa0Mfzhnl3KbhIIIbn215C
 ARi3nP1nHvRkCV3pbC6l/RbFHVDiXbpmn4BH5/ELAitMKTE32WI6nEWc5+XJ5qIrNzTpjWjAV
 8tgDT8TNY646FMF4hNVdQ2XB7dvEvWVf28j9d9UAGJ+Rck9D/91KVUkXfvn2lOkdy/0RWINvi
 sZ8/Fjs8ELjReIWGAGKiLWHzqfRfO7EadQfSb/9504dzadVDV0Q1/nCyJ0+NN9WJd9o58o5iV
 +wZvGEOFGbj0+1p0nkVBj1OWkaCoiFFFXUiEQivgao3Oo=

Am 01.03.24 um 05:36 schrieb Ping-Ke Shih:
>> -----Original Message-----
>> From: Ping-Ke Shih <pkshih@realtek.com>
>> Sent: Friday, March 1, 2024 10:33 AM
>> To: Fiona Klute <fiona.klute@gmx.de>; linux-wireless@vger.kernel.org
>> Cc: kvalo@kernel.org; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org=
; pavel@ucw.cz; megi@xff.cz
>> Subject: RE: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
>>
>>
>>
>>> -----Original Message-----
>>> From: Fiona Klute <fiona.klute@gmx.de>
>>> Sent: Wednesday, February 28, 2024 7:55 AM
>>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>>> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@li=
naro.org;
>> linux-mmc@vger.kernel.org;
>>> pavel@ucw.cz; megi@xff.cz
>>> Subject: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
>>>
>>> +
>>> +#define TRANS_SEQ_END                  \
>>> +       {0xFFFF,                        \
>>> +        RTW_PWR_CUT_ALL_MSK,           \
>>> +        RTW_PWR_INTF_ALL_MSK,          \
>>> +        0,                             \
>>> +        RTW_PWR_CMD_END, 0, 0}
>>
>> Move this macro to main.h along with RTW_PWR_CUT_ALL_MSK.
>
> Think of this again, I prefer removing braces
> #define TRANS_SEQ_END			\
> 	 0xFFFF,			\
> 	 RTW_PWR_CUT_ALL_MSK,		\
> 	 RTW_PWR_INTF_ALL_MSK,		\
> 	 0,				\
> 	 RTW_PWR_CMD_END, 0, 0

Okay, will do that. And it gets rid of the odd "tab plus space" indent
for most of the definition. :-)


