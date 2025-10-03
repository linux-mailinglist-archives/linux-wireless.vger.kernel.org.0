Return-Path: <linux-wireless+bounces-27802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E2BB7A3F
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Oct 2025 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCFE3342035
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Oct 2025 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD52D3EE5;
	Fri,  3 Oct 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Iq7E0TfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456281482F2
	for <linux-wireless@vger.kernel.org>; Fri,  3 Oct 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510943; cv=none; b=KDy7hCSpEyVxsx+ji3mvi5Otoh8t0iOqCRGmmfAKKykrtTx4Q9vvwuRApkJjNA3ps0aJyjxi/+0i9g0685cnacNa0F8ExqccYaAC/w7Ko5UDOU7zocJ10SOQDzRrlFrf1xXbJZdAZAP7Dd/EbC2w/y+B/lJ3Bsm586Sw/bGQPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510943; c=relaxed/simple;
	bh=Nqeq3WQMuIwEi92DgQELoiMN3nr76JiuvnZrP1A+1Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kclX3BQ/KI3djxoNvB7MlSZd8FuSgX5aDAw0Npvp2x5L9Ip9iDMJ1cVIlKC7JYBDoDlOfxR798jGVafGu0muWh8zCWQQpKqLp1pbnBjOl0j5r9LjUDJfharhS1H7vXdLL6pS2mZWjptD2VvqOAb14XImF4GeZ/a2ky2L08j+oLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Iq7E0TfN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1759510930; x=1760115730; i=wahrenst@gmx.net;
	bh=Nqeq3WQMuIwEi92DgQELoiMN3nr76JiuvnZrP1A+1Co=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Iq7E0TfNXc29UNaiag7fY598LJQMt+uAhZ+xgQ+xwhNeKTlc6y1epXO+H5BRn+s4
	 3WXNgjWZHgG6Z5wiA5Lmz2MmekGkpFKzt6KIZVSMN/oe8Zar7JaVB7ndZEL6OFKqr
	 n5CEL3tDJqyplegrEC4yvaT24XizoTZfmtiZHDq25vDw7rnJj8hn7IpU0JFqI1KVo
	 8zvOc7MH1TO0JVqAjrQDnMvCbD+4L4RVVQeSh4dcGe53PMy6GT8yEboftU5ISGozb
	 0XkdDM+HhIqc6GQiI1KlXxHZx8z4MkdP1aE4qFOtRnMgtRz28GI23n+MH3e6ItRh1
	 AiUt2mYkbzUdtHbfHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1vCjNv1rsz-003Wc5; Fri, 03
 Oct 2025 19:02:10 +0200
Message-ID: <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net>
Date: Fri, 3 Oct 2025 19:02:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Richard Reigh <richard@govivid.ai>, s311332@gmail.com, chris@streetlogic.pro
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
 <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
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
In-Reply-To: <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zjYyXgQOJ5fc+0YYZSJlMnik81YEiIEPb8a4o0HSqwt1i1d7MHU
 RM8n4g+1off5o/mb/BeroQvxzKq15+wtcczkjcZJ/sDCZdQkto/z/ZCwR3fvdH8WFZiPCVj
 1mqd0yj0LhPVLZcJwaLebZl06MKxJQdcopfPHz58+oTwwtl7K/z1uCNW/9r1JlUeTxkVw++
 jlyZYMFC4uWwNZAJ2GqFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XfuNJ2C01R0=;K28X3ddIuFPIKu+NUlLgvSB+oar
 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

Hi,

Am 03.10.25 um 18:00 schrieb Arend van Spriel:
> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai>:
>
>> When iPhones query network information via the WiFi settings "i" button=
,
>> the brcmfmac driver crashes with a NULL pointer dereference. This occur=
s
>> because the P2P device vif is not initialized when handling certain=20
>> action
>> frames.
>
> That does make a lot more sense than the line that gdb gave me with my=
=20
> driver rebuild attempt.
>
>> Add NULL check for vif before dereferencing in=20
>> brcmf_p2p_tx_action_frame()
>> and return -ENODEV when vif is NULL. Also modify
>
> Now I don't think it is necessary to bail out here. See my suggestion=20
> below...
>
>> the retry loop in
>> brcmf_p2p_send_action_frame() to stop immediately on permanent failures
>> rather than retrying.
>>
>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>>
>> Signed-off-by: Richard Reigh <richard@govivid.ai>
>> ---
>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c=C2=A0=C2=A0 | 16 +++++++=
++++++++-
>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c=20
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> index 10d9d9c63..2c73156fa 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct=20
>> brcmf_p2p_info *p2p,
>> else
>> vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>
>> + /* add NULL check */
>> + if (!vif) {
>> + brcmf_err("vif is NULL, cannot send action frame\n");
>> + return -ENODEV;
>> + }
>
> Instead of giving up and surrender we can use primary vif, ie.=20
> p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
>
> if (!vif) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brcmf_dbg(TRACE, "no P2P device set=
up\n");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vif =3D p2p->bss_idx[P2PAPI_BSSCFG_=
PRIMARY].vif;
> }
this looks much better. But the whole patch needs a fixes tag.

In case this issue is reproducible before Linux 5.8, the tag should=20
reference:
18e2f61db3b7 ("brcmfmac: P2P action frame tx.")

otherwise it should reference:
d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p=20
presence request")

Best regards
>
> Regards,
> Arend
>
>


