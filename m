Return-Path: <linux-wireless+bounces-26264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3EB209E9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43BB97B4A51
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E043221727;
	Mon, 11 Aug 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="D3xuoc75"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD8205AB6
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918141; cv=none; b=U0mGqoPT3wpZ7xIPxrlDiCssXF1wiDAZzIvGOos7pJynJ35p6/HyFCfSHPubDealFXzmbCNCT2oxcVITQHa5Kgg1AbkPzHn85zFNCGpp2lIyPLTBcdEpAenTay5lz252582hhgX5//o0wzQ5HY3J0LDHKUvrSfeMe+SVuXj1iSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918141; c=relaxed/simple;
	bh=CnQ2txXBF0xgZ/si9RvuQlSWz6FV9qHE6cSNcVH7h8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ou33QUKYwTr7A9AwDylNcgFkecT9G9oYL/zLc2IGzWlWjScw+hMt9evNoujcroSWlKSONr7eRv7JecZmcmaPgIXy3HFRyTtddYQ+SSNWVtrfnvKEmwdRJs5fdP/UoENy/rmZE23JR8/1pATyx8EI4tV8sSOuuk33eueNtpdYuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=D3xuoc75; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754918136; x=1755522936; i=deller@gmx.de;
	bh=CnQ2txXBF0xgZ/si9RvuQlSWz6FV9qHE6cSNcVH7h8g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D3xuoc75gKlkNAYMph1dvF7E7y1NeW8ALO4YR9/rD7J2f/kfr4jtx18g3SD0oc3S
	 sVURci3oT7ES4X0VQiUnTauqpEj1nVbtmzKGdHczllUmn5NPCpZ+FfBnO8gIjgkI4
	 lBZIAc6D2ByWvkAcrGsIfGlsxtFs9edY86Lvs3yBLXs9OAT02+3UOHVZ7CeWquMnV
	 Mhn3DxXgBZ3gP5YpynQQvXTKyMrEyeTSsfLybabVo53PAfEym+1r7OeATpkrm61MO
	 c8e4NMYVAGUDqnqZoaNboaXOX0/HInrb0phqwrptVFq6fpOin4UZllEsp4Jdc6Jg2
	 aw2tgWLxoBY9zWwuKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1uRijL1W5T-00yExq; Mon, 11
 Aug 2025 15:15:36 +0200
Message-ID: <8903e378-326d-459a-ad7f-65b2d2ff4d36@gmx.de>
Date: Mon, 11 Aug 2025 15:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8188S WLAN Adapter failure
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Jes.Sorensen@gmail.com,
 Ping-Ke Shih <pkshih@realtek.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>
References: <ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de>
 <015e5657-d21e-4214-9854-975c32b1990f@gmail.com>
 <34e345ed-a114-494a-b3f7-72dfab6b628a@gmx.de>
 <aed4c8cb-b265-444d-a17c-eb464cf4dd78@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <aed4c8cb-b265-444d-a17c-eb464cf4dd78@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/7qXPajBvqYlPD0kIvhjFtJqc2G/kxcCCa/oCtaYNUvtv0SpM0d
 3wo0B625xHUVKc2phCj0wSwOnhUrL/kyOVNRkJEzYXvzxeBpKyqfm7Ejmazr7dTW9PrJgVv
 e8fFpSq1TFmTTORFBtpt4X//TQolHI84geXGeW39rUGdBCgnm2BmdXtPAwRhDorr5ADK9v0
 95v9J3fUSQe6MMB6RVQSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2AvKQJEcEZU=;txpj0P8mPm4S5gWaG3FotpvfKU8
 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

On 8/11/25 14:56, Bitterblue Smith wrote:
> On 11/08/2025 14:46, Helge Deller wrote:
>> On 8/11/25 00:12, Bitterblue Smith wrote:
>>> On 10/08/2025 23:36, Helge Deller wrote:
>>>> The USB dongle which came with my DreamBox DM7020HD years ago seems t=
o fail now.
>>>> Any idea or suggestion what I should try?
>>>>
>>>> [427792.562049] usb 3-7: new high-speed USB device number 56 using xh=
ci_hcd
>>>> [427792.689358] usb 3-7: New USB device found, idVendor=3D07b8, idPro=
duct=3D8188, bcdDevice=3D 2.00
>>>> [427792.689376] usb 3-7: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D3
>>>> [427792.689381] usb 3-7: Product: RTL8188S WLAN Adapter
>>>> [427792.689385] usb 3-7: Manufacturer: Manufacturer Realtek
>>>> [427792.689388] usb 3-7: SerialNumber: 00e04c000001
>>>> [427792.695145] usb 3-7: This Realtek USB WiFi dongle (0x07b8:0x8188)=
 is untested!
>>>> [427792.695151] usb 3-7: Please report results to Jes.Sorensen@gmail.=
com
>>>> [427792.934142] usb 3-7: Dumping efuse for RTL8188CU (0x200 bytes):
>>>> [427792.934151] 00000000: 29 81 00 00 a9 16 00 00 b8 07 88 81 90 85 6=
2 9c=C2=A0 ).............b.
>>>> [427792.934155] 00000010: 06 00 ec f0 0e 16 44 3f 17 03 4d 61 6e 75 6=
6 61=C2=A0 ......D?..Manufa
>>>> [427792.934157] 00000020: 63 74 75 72 65 72 20 52 65 61 6c 74 65 6b 2=
0 18=C2=A0 cturer Realtek .
>>>> [427792.934159] 00000030: 03 52 54 4c 38 31 38 38 53 20 57 4c 41 4e 2=
0 41=C2=A0 .RTL8188S WLAN A
>>>> [427792.934160] 00000040: 64 61 70 74 65 72 20 00 00 00 00 00 00 00 0=
0 00=C2=A0 dapter .........
>>>> [427792.934162] 00000050: 06 02 00 00 00 24 24 24 00 00 00 26 26 26 0=
0 00=C2=A0 .....$$$...&&&..
>>>> [427792.934163] 00000060: 00 00 00 00 00 00 00 00 12 00 00 09 0d 00 0=
0 00=C2=A0 ................
>>>> [427792.934164] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00=C2=A0 ................
>>>> [427792.934166] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934167] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934168] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934170] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934171] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934172] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934174] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934175] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934176] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934178] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934179] 00000120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934180] 00000130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934182] 00000140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934183] 00000150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934184] 00000160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934186] 00000170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934187] 00000180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934188] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934190] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934191] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934192] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934193] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934195] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934196] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff=C2=A0 ................
>>>> [427792.934198] usb 3-7: RTL8188CU rev A (TSMC) romver 0, 1T1R, TX qu=
eues 3, WiFi=3D1, BT=3D0, GPS=3D0, HI PA=3D0
>>>> [427792.934203] usb 3-7: RTL8188CU MAC: 44:3f:17:03:4d:61
>>>> [427792.934206] usb 3-7: rtl8xxxu: Loading firmware rtlwifi/rtl8192cu=
fw_TMSC.bin
>>>> [427792.938371] usb 3-7: Firmware revision 88.2 (signature 0x88c1)
>>>> [427792.939417] rtl8192cu_power_on: Enabling LDOV12D (24)
>>>> [427793.115145] rtl8192cu_power_on: FSMCO_MAC_ENABLE poll failed
>>>> [427793.115156] usb 3-7: rtl8xxxu_init_device: Failed power on
>>>> [427793.116003] rtl8xxxu 3-7:1.0: probe with driver rtl8xxxu failed w=
ith error -16
>>>>
>>>
>>> Your dongle has the RTL8188SU chip inside. rtl8xxxu and rtl8192cu
>>> are not the right drivers.
>>>
>>> The right driver is r8712u, but it was removed in kernel 6.13.
>>
>> Ah, ok.
>>
>>> You can use kernel 6.12. Or you can compile r8712u for your current
>>> kernel. Maybe r8712u could even be accepted back in the kernel if
>>> you convert it to use mac80211/cfg80211.
>>> https://lore.kernel.org/linux-staging/20241020144933.10956-1-philipp.g=
.hortmann@gmail.com/
>>
>> According to that commit message, a replacement with MAC80211 support
>> is available at https://github.com/chunkeey/rtl8192su
>> But development on it seems to have stopped some years ago.
>> Is there any specific reason for this?
>=20
> I think the people working on it ran into some problems with the
> driver/firmware and also didn't have time for it anymore:
>=20
> https://lore.kernel.org/linux-wireless/3717687.FpcDfXaOEr@debian64/

Interesting.
Thanks for the link!

>> I have no clue on wireless development, so if I'm willing to test this
>> driver and provide feedback, would someone be interested and may help t=
o bring
>> it upstream? Or doesn't it make sense to invest the time in that?
>>
>> Helge
>=20
> The work has to be done by someone who has the hardware. That makes
> you the best candidate for the job.

Yes, sure, *if* I would have at least *some* knowledge about WIFI.
Instead I'm happy to sponsor this USB dongle to someone who is knowledgeab=
le
and who is willing to spend some time on it (again). Just let me know.

Helge

