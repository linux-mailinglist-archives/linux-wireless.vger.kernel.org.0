Return-Path: <linux-wireless+bounces-3073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91101847DE9
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 01:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130551F24213
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314EC622;
	Sat,  3 Feb 2024 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="MuLNh+hO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CC626;
	Sat,  3 Feb 2024 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920592; cv=none; b=svgGS++5WPr/gazi0dK1dQir3FE1TCCC318nbZOLx9BFHdkghLV8J7pwjGqFEwMX6u4hCwrv4IaCHHUwPDYo+bJ2fGjE2EXr69lWkp5cB2R9OCJwm6XgK0ALC8+E+/gQ2REqLyOsWzHDhmYf1U78uI1T49hDy4gDkuJbmMrPnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920592; c=relaxed/simple;
	bh=QDuR/5MyowayfZ0+odzOM6+rY7JqHHO9zLULvOpKSHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHa9QorcuVe1w6eo9nHw+PhN72UyycXLws7AVwbM9OTQJ1Fl6Dak+m4SmtHz/DuN2AR5m8MwaqBYJ+GZy//fHSokBJgfKsYDuNeethBhGDoYSgHna3/jpfse/XtAOhvDR0uhW7AZoPi6hC7KePO5wC9rQjAn64qzYCY3184dJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=MuLNh+hO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706920575; x=1707525375; i=fiona.klute@gmx.de;
	bh=QDuR/5MyowayfZ0+odzOM6+rY7JqHHO9zLULvOpKSHs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MuLNh+hOxOtIOr225TvRTkzPh1DzXWIg5MnPHPt+N/gHcTkrh5WmuxDnEMbPdgil
	 S3UTPC2ltwRUY3wrSh0lbiop0QkIgKcKydBGsnmptiBJa6qUx9Ngp65IrSaajnUrw
	 3aQMvU4P6+A1s4+rmXhL2BbnBwO7AqFjQB7h/sBsrfPSeKhmYKuy1I/NcPXJCaq8x
	 4gFH1jhY1Yz/FoVGNKx3ZjXeDmDyZmOXtEqAWHGtdQp3iZyrHDJ9EPAHVq4RybT01
	 o5O4Catqyc+dpB1JW5hwg3C8HQRZLu6YlqVVx2aQM9P7wMjABn+wpK98Y5A0Lxx4e
	 gOjwoh0DE5lzbCahAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.17.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1rL5eB1xY8-00B3eh; Sat, 03
 Feb 2024 01:36:15 +0100
Message-ID: <0f256235-9889-4bb2-93d4-3424c478c661@gmx.de>
Date: Sat, 3 Feb 2024 01:36:14 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Content-Language: de-DE, en-US
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <Zb1ORD_Lzd4O4gu-@mobian>
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
In-Reply-To: <Zb1ORD_Lzd4O4gu-@mobian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zQzeANnUmlggm/tCpWMwaSqnUWkpxvJNFxF2RJhbCmfj1Rsp5pS
 WCffs2ToSHMff8/ExOSPnkw2842X7cnCudZpDDoRYXtkQw/d6Kq0nIb0H1pO+IxRKRbzd7c
 MGscFfhBUtus6LpZ3KSVG1qXFvEz3VsUg2jvQZiysepd2I1hdhajan/0+1I/D9XRBgOhmHx
 7U7c4XPSFsHee3ZCKT40Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2S5kQz1pHgA=;8u89sUw+VNfj3oonJufUr4EiJxY
 EhqCqu0EB6Owceh3tZUUr4YBmG2NQL3P7i8QR8wLmmxKbudYE1mYfxRQhsn9Nd9fsHykiBm1A
 /4TCUtWDWvVJ04K6kMvvDe+3XHpcjcx41sMC9GHTY2yKknYiEfTlEr/nrbTVqluWeCZOfhbJ3
 9WG44w3ye7gORpofy2JFRfYuB8T03SS015DePGVwYdNhIB9+uqc2VsNg3RTIfAaPvtQhdTxdh
 109CnFC2hCVBMmkkyI478Z8KZXVDut5vqqnD7I76y8WeEVe+Mnu60B+Jpd6XVSsPWX7XstNvd
 pgkHTcwHRcGNYsr49VtvGotOWo3a6O9YgKTqUm5dSfNm8ekgLv48nBvUvsrB45+/cKZAf7yUl
 YhcRkJbzJzHwKpGpfGCC40LixlvlJXnuqmJKTRvMFUdglxEjxHlF1lgsen/RePGv846qZ44S2
 9Sw/NtH2icZ2M/b0orxpYtTY65Wa4zrQIZUdwTAHUk4c5gtxizZTaWir4JX3dQ9m1jKkFwlfr
 BsogobXlag+7BVBE1cDcBaEvHRglSFiVDDjfcdy7fwRcVAho9cCYqFwjLtRAzh5LN3EqIQ/UT
 HosCJd2CiMdWVWzhn4wG+jmpREY6pQes97oJUpX9t8K5yy0XkvJfxgCgeTVop3DmGb4+3S30D
 0FIP7ZKOSbzyfg5hKqPMDdfVWBQ0ejju4sp8BIpWIWUuwk/H5iQpBMMm0Ar80gOHtrNryCUq9
 I3CK46Kl3t+PVRUPm7k++2Fm2TvGC44zKRzKq+igAYcuzD6wouh2r6LVfGmMhWSUCbQuNOuMS
 qZSNypnnNSM23ZMKbl0/0U2cl2RwmBgzX3kLSCgyPCcv8=

Am 02.02.24 um 21:19 schrieb Pavel Machek:
> Can I get you to apply this?

Done, good idea!

> diff --git a/Makefile b/Makefile
> index 1f8e8b6..fbc1f14 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,10 @@ firmware_files =3D rtw8703b_ap_fw.bin \
>
>   all: $(firmware_files)
>
> +install: $(firmware_files)
> +	sudo mkdir /lib/firmware/rtw88/
> +	sudo cp $(firmware_files) /lib/firmware/rtw88/
> +
>   %.o: %.c
>   	gcc -fPIC -DCONFIG_RTL8703B -c -o $@ $<
>
>


