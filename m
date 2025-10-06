Return-Path: <linux-wireless+bounces-27822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25BBBE87F
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 17:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357DB3BCF31
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE1F2D640E;
	Mon,  6 Oct 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HqSzL4Rb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCB2D061E
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765673; cv=none; b=aXKhMYky/+F2eT8rRO53OHiJ/am/kgtEw5D/6tBf2Eg3NP+JIyNy7w9YbtS6yrBu3RXV1o870Hx/mxfa1GYGukkrlC27GP4n6UtaikHZ0opoaqI8BhEOCVUpYOWDEmmdcKYPjvRJv9epLLZUbCbWdwsvfi8LwgmiRU63MnduJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765673; c=relaxed/simple;
	bh=Aa+OeU54TOLQcMGCL7nhazNYztTHmk1CmLo/GAggcNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0NSSaeu99TyoKiUBKeGM6IRobC34IfrX43Ml7JHalU8X07kZmqIzcFSkSG0P6SQsWt9Ucv901r4MyxjvSZdFm5S6rQVQ4+eOT0e9RGSjTyXq2RpVUGzNSNeu22ZPNCczBCh2Hqe1TVns8MtYkLduP172lkKKAQvskGRJEsXi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HqSzL4Rb; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1759765662; x=1760370462; i=wahrenst@gmx.net;
	bh=Aa+OeU54TOLQcMGCL7nhazNYztTHmk1CmLo/GAggcNU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HqSzL4RbtIhfQE6Pc6CM0JeyexXYQWZB3bGl7TRpA5g+8bxkeGi5m7xc6fCnIoU7
	 KPShe0N7kPr9r2OwyFFlrMNrPKmHrAwZxU1u5wZdths6o5UACWmng3WsdDjwP8Av6
	 cgAetjq2e9YN1+kATgoDJQZwhyQ4nJyvzkuBy6lI8LuIhOd2wdgDKDyO8EjhapXjo
	 Zmb/4GG5l2t67XwlnEHZRtDGhthJnxK4SyhRnjfEWpfC86DhTCTbs+yz8N8ct9ZZa
	 x6YVJ7BpPljHos/UM+CGPPm3Q54AOKiOlBzYsK0GUhEu+UzLP51zLqJ2cGc0JFt3f
	 ZMVTuv6w5IlBgrKKFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1umk5I3RTZ-00TptB; Mon, 06
 Oct 2025 17:47:41 +0200
Message-ID: <f0352cba-0810-43c3-9c53-baa012f93513@gmx.net>
Date: Mon, 6 Oct 2025 17:47:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Richard Reigh <richard@govivid.ai>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, chris@streetlogic.pro,
 s311332@gmail.com
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
 <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net>
 <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3vl/M0M9PIBE/H0LhQDgUbrBn2sujfR/n7KiwzlVIvFBStcN9rj
 Spayj0Hb/1LHo+hRUyAHN5DlUpjvu3YY0CZNcE/JcDu52yG4zgupcS/bri99PvRboUedzz5
 2UWebLyg+EYaBZNJE4+mM3796sZJZgIxcwhxfpNSGzxcCMmKdEApm77FzgMaEaIPYDIk62F
 un0xD4FEqgsrtT+9nzTAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1abeHxSHIMw=;03x+BglaZj6MQ9k/TyQ4dICe+1I
 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
 Bx7P8YWGLD+Ro7j2J9mN9JqyTUhYr6+KdTEnZP

Hi Richard,

Am 04.10.25 um 11:22 schrieb Arend van Spriel:
> On 10/3/2025 7:02 PM, Stefan Wahren wrote:
>> Hi,
>>
>> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
>>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai>:
>>>
>>>> When iPhones query network information via the WiFi settings "i"=20
>>>> button,
>>>> the brcmfmac driver crashes with a NULL pointer dereference. This=20
>>>> occurs
>>>> because the P2P device vif is not initialized when handling certain=
=20
>>>> action
>>>> frames.
>>>
>>> That does make a lot more sense than the line that gdb gave me with=20
>>> my driver rebuild attempt.
>>>
>>>> Add NULL check for vif before dereferencing in=20
>>>> brcmf_p2p_tx_action_frame()
>>>> and return -ENODEV when vif is NULL. Also modify
>>>
>>> Now I don't think it is necessary to bail out here. See my=20
>>> suggestion below...
>>>
>>>> the retry loop in
>>>> brcmf_p2p_send_action_frame() to stop immediately on permanent=20
>>>> failures
>>>> rather than retrying.
>>>>
>>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>>>>
>>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
>>>> ---
>>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c=C2=A0=C2=A0 | 16 +++++=
++++++++++-
>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c=
=20
>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>> index 10d9d9c63..2c73156fa 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct=20
>>>> brcmf_p2p_info *p2p,
>>>> else
>>>> vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>>>
>>>> + /* add NULL check */
>>>> + if (!vif) {
>>>> + brcmf_err("vif is NULL, cannot send action frame\n");
>>>> + return -ENODEV;
>>>> + }
>>>
>>> Instead of giving up and surrender we can use primary vif, ie. p2p-=20
>>> >bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
>>>
>>> if (!vif) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_dbg(TRACE, "no P2P device s=
etup\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vif =3D p2p->bss_idx[P2PAPI_BSSCF=
G_PRIMARY].vif;
>>> }
>> this looks much better. But the whole patch needs a fixes tag.
>
> Sure.
>
>> In case this issue is reproducible before Linux 5.8, the tag should=20
>> reference:
>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
>>
>> otherwise it should reference:
>> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p=20
>> presence request")
>
> Both good suggestions. Looking at the code I would say that=20
> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.") is the best choice.
thanks. @Richard Do you plan to submit a V2 patch?

Best regards
>
> Regards,
> Arend


