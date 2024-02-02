Return-Path: <linux-wireless+bounces-3035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A278847120
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 14:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC961C2170B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E6344367;
	Fri,  2 Feb 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="KYLKVZsB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6945C06;
	Fri,  2 Feb 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880493; cv=none; b=Ct0WdVRI8X8yfCnxAyOLGXNeocV1dTuQExix7MQ2UwzIihXGkkmjLSw9a55rP6YRugF3M1Af8P4yKg7csH0YPQ6yLAMmOt7CXHvEqxrZ7FjvTpwHF1qwYDaupwmP/77s8UxzE7HdQRScxxyw6XFtaokLAR3JzWESWI5/R2LoYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880493; c=relaxed/simple;
	bh=aG9lEA7K175xndaZuz+/EoqdgcuO1uvUck/Qw69L9Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUkmDbaK+6CdyjQUEMxKKUC8LV/3LX/WRlcECerDYYGiWHn7cB6Bp315vjoS+vkdHmbdLNIjtbMSmWebT88xnWMLVH20LfqUg/ZUIOg2KMEuqboFU3VyCiYvRmHvV/rUZltNnjnqCr9UghbYaBKlte2aYobOxHuSQ5V7inTv58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=KYLKVZsB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706880475; x=1707485275; i=fiona.klute@gmx.de;
	bh=aG9lEA7K175xndaZuz+/EoqdgcuO1uvUck/Qw69L9Lc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KYLKVZsBl1OdTidz13XCG5LAWfVK0X4OzNDHxW8zNSr2z9/h6iFozzdUEXdZ4YaT
	 04jpGTWQQNsL+vMqStPrGXG4WzRdDL7X8a7CnUO0JWMJ3r/xBvJhHRutlEv4ru4mH
	 f9bjygoSjz/zfTMIdX9tQcAJNRMO4c7eAj1oKitcRGQj/efDs//V+NZ281jYhew25
	 78xmPX65CPbruhFDw0/Wiea9xTU5in8ZTqyoTFWOYdM/l6xOmmGD4nlIxaX2U9f/w
	 maUD61GLsPLtKPGZUJOf9uFlplWeG9K0GYndRp6b0z/yCHiB5CyLHFvgpQTxnoGDa
	 BvHYzxK4YEnG2Dfcpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.17.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1rc6ZY0VCB-00UWSy; Fri, 02
 Feb 2024 14:27:55 +0100
Message-ID: <b8c1a26e-13d9-405a-bbd5-70a7daf75323@gmx.de>
Date: Fri, 2 Feb 2024 14:27:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <0a5c896a-6dab-4979-a6a3-344dc71bca98@yandex.ru>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 xsFNBFrLsicBEADA7Px5KipL9zM7AVkZ6/U4QaWQyxhqim6MX88TxZ6KnqFiTSmevecEWbls
 ppqPES8FiSl+M00Xe5icsLsi4mkBujgbuSDiugjNyqeOH5iqtg69xTd/r5DRMqt0K93GzmIj
 7ipWA+fomAMyX9FK3cHLBgoSLeb+Qj28W1cH94NGmpKtBxCkKfT+mjWvYUEwVdviMymdCAJj
 Iabr/QJ3KVZ7UPWr29IJ9Dv+SwW7VRjhXVQ5IwSBMDaTnzDOUILTxnHptB9ojn7t6bFhub9w
 xWXJQCsNkp+nUDESRwBeNLm4G5D3NFYVTg4qOQYLI/k/H1N3NEgaDuZ81NfhQJTIFVx+h0eT
 pjuQ4vATShJWea6N7ilLlyw7K81uuQoFB6VcG5hlAQWMejuHI4UBb+35r7fIFsy95ZwjxKqE
 QVS8P7lBKoihXpjcxRZiynx/Gm2nXm9ZmY3fG0fuLp9PQK9SpM9gQr/nbqguBoRoiBzONM9H
 pnxibwqgskVKzunZOXZeqyPNTC63wYcQXhidWxB9s+pBHP9FR+qht//8ivI29aTukrj3WWSU
 Q2S9ejpSyELLhPT9/gbeDzP0dYdSBiQjfd5AYHcMYQ0fSG9Tb1GyMsvh4OhTY7QwDz+1zT3x
 EzB0I1wpKu6m20C7nriWnJTCwXE6XMX7xViv6h8ev+uUHLoMEwARAQABzSBGaW9uYSBLbHV0
 ZSA8ZmlvbmEua2x1dGVAZ214LmRlPsLBlAQTAQgAPgIbIwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBOTTE4/i2fL6gVL9ke6nJs4hI1pYBQJkNTaZBQkNK+tyAAoJEO6nJs4hI1pY3qwQ
 AKdoJJHZpRu+C0hd10k6bcn5dr8ibqgsMHBJtFJuGylEsgF9ipWz1rMDWDbGVrL1jXywfwpR
 WSeFzCleJq4D0hZ5n+u+zb3Gy8fj/o3K/bXriam9kR4GfMVUATG5m9lBudrrWAdI1qlWxnmP
 WUvRSlAlA++de7mw15guDiYlIl0QvWWFgY+vf0lR2bQirmra645CDlnkrEVJ3K/UZGB0Yx67
 DfIGQswEQhnKlyv0t2VAXj96MeYmz5a7WxHqw+/8+ppuT6hfNnO6p8dUCJGx7sGGN0hcO0jN
 kDmX7NvGTEpGAbSQuN2YxtjYppKQYF/macmcwm6q17QzXyoQahhevntklUsXH9VWX3Q7mIli
 jMivx6gEa5s9PsXSYkh9e6LhRIAUpnlqGtedpozaAdfzUWPz2qkMSdaRwvsQ27z5oFZ0dCOV
 Od39G1/bWlY+104Dt7zECn3NBewzJvhHAqmAoIRKbYqRGkwTTAVNzAgx+u72PoO5/SaOrTqd
 PIsW5+d/qlrQ49LwwxG8YYdynNZfqlgc90jls+n+l3tf35OQiehVYvXFqbY7RffUk39JtjwC
 MfKqZgBTjNAHYgb+dSa7oWI8q6l26hdjtqZG+OmOZEQIZp+qLNnb0j781S59NhEVBYwZAujL
 hLJgYGgcQ/06orkrVJl7DICPoCU/bLUO8dbfzsFNBGQ1Nr0BEADTlcWyLC5GoRfQoYsgyPgO
 Z4ANz31xoQf4IU4i24b9oC7BBFDE+WzfsK5hNUqLADeSJo5cdTCXw5Vw3eSSBSoDP0Q9OUdi
 PNEbbblZ/tSaLadCm4pyh1e+/lHI4j2TjKmIO4vw0K59Kmyv44mW38KJkLmGuZDg5fHQrA9G
 4oZLnBUBhBQkPQvcbwImzWWuyGA+jDEoE2ncmpWnMHoc4Lzpn1zxGNQlDVRUNnRCwkeclm55
 Dz4juffDWqWcC2NrY5KkjZ1+UtPjWMzRKlmItYlHF1vMqdWAskA6QOJNE//8TGsBGAPrwD7G
 cv4RIesk3Vl2IClyZWgJ67pOKbLhu/jz5x6wshFhB0yleOp94I/MY8OmbgdyVpnO7F5vqzb1
 LRmfSPHu0D8zwDQyg3WhUHVaKQ54TOmZ0Sjl0cTJRZMyOmwRZUEawel6ITgO+QQS147IE7uh
 Wa6IdWKNQ+LGLocAlTAi5VpMv+ne15JUsMQrHTd03OySOqtEstZz2FQV5jSS1JHivAmfH0xG
 fwxY6aWLK2PIFgyQkdwWJHIaacj0Vg6Kc1/IWIrM0m3yKQLJEaL5WsCv7BRfEtd5SEkl9wDI
 pExHHdTplCI9qoCmiQPYaZM5uPuirA5taUCJEmW9moVszl6nCdBesG2rgH5mvgPCMAwsPOz9
 7n+uBiMk0ZSyTQARAQABwsF8BBgBCAAmFiEE5NMTj+LZ8vqBUv2R7qcmziEjWlgFAmQ1Nr0C
 GwwFCQPCZwAACgkQ7qcmziEjWlgY/w//Y4TYQCWQ5eWuIbGCekeXFy8dSuP+lhhvDRpOCqKt
 Wd9ywr4j6rhxdS7FIcaSLZa6IKrpypcURLXRG++bfqm9K+0HDnDHEVpaVOn7SfLaPUZLD288
 y8rOce3+iW3x50qtC7KCS+7mFaWN+2hrAFkLSkHWIywiNfkys0QQ+4pZxKovIORun+HtsZFr
 pBfZzHtXx1K9KsPq9qVjRbKdCQliRvAukIeTXxajOKHloi8yJosVMBWoIloXALjwCJPR1pBK
 E9lDhI5F5y0YEd1E8Hamjsj35yS44zCd/NMnYUMUm+3IGvX1GT23si0H9wI/e4p3iNU7n0MM
 r9aISP5j5U+qUz+HRrLLJR7pGut/kprDe2r3b00/nttlWyuRSm+8+4+pErj8l7moAMNtKbIX
 RQTOT31dfRQRDQM2E35nXMh0Muw2uUJrldrBBPwjK2YQKklpTPTomxPAnYRY8LVVCwwPy8Xx
 MCTaUC2HWAAsiG90beT7JkkKKgMLS9DxmX9BN5Cm18Azckexy+vMg79LCcfw/gocQ4+lQn4/
 3BjqSuHfj+dXG+qcQ9pgB5+4/812hHog78dKT2r8l3ax3mHZCDTAC9Ks3LQU9/pMBm6K6nnL
 a4ASpGZSg2zLGIT0gnzi5h8EcIu9J1BFq6zRPZIjxBlhswF6J0BXjlDVe/3JzmeTTts=
In-Reply-To: <0a5c896a-6dab-4979-a6a3-344dc71bca98@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AxQdN89vvNzQPCX6BALxNFfc+QPQPvSQm1KuiN6GsCkDVwGmqDR
 KNXclpPEhhJHunJ8NVxoeKVMW09LkjV0DipkTC5jNdjkY/K3UWUUL0t6xS6FArmnphdR4sw
 D1w9CiVij59AHLdcaRRGPR6rIhVyTjIokvl1pDzDLhuoDEEabNQwVLK7qU4B03cyjyqFQp3
 vRwpbtEz/bDAn9C+mv/lQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EfWC5nxivtA=;t94CcqK8bdKMywUJu1RlGNVQMQn
 mdeW5Jsc8grsKg5vRqeQTMevhZU0Fxks8vlDeSJt2KfDjTOMcwMm5b8kwKRIHF/sFRkA/zr8H
 Aj2HzgA8syjLjM4RRYen/XXsrL5ToYdIA57OJavNie9kUzIbO+cPPLoTMJ/dGPbrTNm9O5Oc9
 DMXoUrdKjCCnfq47Pv69glS3qwvjS9nMLgAVzitAmsS3oJEh5EuHUUWfvK1vguprPmivM2yzP
 9INL4Vu2ZpbyeD+rFeUcmgRn4Ob8Mxpy06YFYAPaOBiIIiZXDPkRp0e2kyVezZMnugbdCOmCZ
 Ly2rsnfN4v5z7LugmhbyplZRUmAu1CmixmFMP34Rs7EhMh+inbgHd370ppsFoxrtADrrX55rB
 aEYtxX2AhbCQVrZG7lsSrLycs47Nta57SQ4kcyfFaPr3QnRPGb5Z5x8+PD5wLpyQnKPSmBRnV
 Uz7RBnt5dvPrSKH4Uol1c4D6asNBH3fXIXYk7EB6HX0JInKLaiesgLOsibEUMu76iz7iT8Y/E
 HmKWc4pTml2nw/J0tZVqHpJQ04Wt8NGNBBJl1dEyrx1s2fqGfa7yDNK8I/tiYdiFh4GqKBvdK
 Z6O5yp1DKiQ+0GVQ/LnIMv/6fASSoXFRkRoJ3iISKMdB4/q1eNgtAfCnO8xr87JqGxa+K8TQf
 Dp/NPbfUnVJnSTO+tkWA5YToMcpNJzU/TcaFInGQrdOZFB5Sx6af4zUyQUl9wMbuncx8POXXO
 haXvG3qhBwARXx3XPrdcvoTX+Sdz5v33TGS+81czK+HRVQExJHoQ6W2gfTCV9SBQJ2nwM4CkH
 kYLPIOXU+A+kP9JneiU8WjILn9NjIDVl8sq6aVD6GAQxQ=

Am 02.02.24 um 14:13 schrieb Dmitry Antipov:
> On 2/2/24 15:10, Fiona Klute wrote:
>
>> This patch set adds a driver for RTL8723CS, which is used in the
>> Pinephone and a few other devices. It is a combined wifi/bluetooth
>> device, the wifi part is called RTL8703B. There is already a mainline
>> driver for the bluetooth part. RTL8703B is similar to the RTL8723D
>> chip already supported by rtw88. I've been using the out-of-tree
>> rtl8723cs driver as reference.
>
> On top of wireless-next (17903a283593), I'm seeing:
>
> drivers/net/wireless/realtek/rtw88/mac.c: In function
> '__rtw_download_firmware_legacy':
> drivers/net/wireless/realtek/rtw88/mac.c:940:33: error:
> 'RTW_CHIP_TYPE_8703B' undeclared
> (first use in this function); did you mean 'RTW_CHIP_TYPE_8723D'?
>  =C2=A0 940 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rtwdev=
->chip->id =3D=3D RTW_CHIP_TYPE_8703B &&
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 RTW_CHIP_TYPE_8723D
> drivers/net/wireless/realtek/rtw88/mac.c:940:33: note: each undeclared
> identifier is
> reported only once for each function it appears in
>
> It seems that 'enum rtw_chip_type' has missing an entry.

That definition should have been added to main.h by patch 3 ("wifi:
rtw88: Add definitions for 8703b chip"). Was there some issue with
applying that one?


