Return-Path: <linux-wireless+bounces-9121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C597090B439
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7181C22A4D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4431BDDB;
	Mon, 17 Jun 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d8QoCOIY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF31C2AD
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636277; cv=none; b=iDVuN6D4MLEB2q3GyQlfjy8VJ5q9Tm9XnUlXRZH9TwKLDxW6fTyWa8kCl6ZJg+Fu1V2RsH7B8DxJSJTYD9ykOfOuELVbQideoCPx04vJCjU5E+hi6v7s7L87050XiAFe9pKVWMfEIwhmeTWle+jZaVZ1WDe06QCZUo2QEWxfxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636277; c=relaxed/simple;
	bh=/DkOR738TmYDOooGrPOP8wxXzVGBOG4+es3DvgeHrlQ=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WB+y/Zq4tXTwJVQd2S8OgSpq+YDHbXQi3Xvdn3LtLbkuw7Upuyh/Oe1NY0e86ziIsZZ2Ps6fedwTOIRjlI2k21LM5jDsYx7O7cf0h5QQaDtmu3uWY4RFhhHcmGy2bcj2PTXJLBwZrqH8GSRfOs5ZsjlJRXbCbvk/Jx3rXBusKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d8QoCOIY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f7720e6e8so167976166b.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718636274; x=1719241074; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLet9zmo5UW5HmzlkcgKpZ+mok13cHRhtNxkNu+SlXU=;
        b=d8QoCOIYEP3sT9g4lwbm6qZicQN5a3O4MCrG+1szAdb5MW2IjTQ8tPZFdLW7iO2Uko
         NubCxVnLxn5hlP6eQvr2WkHSJglR0EsZ3fklsV2WQsJG9/ZC2gbJdWq+JbKQSSViCxyZ
         O9klh+FL+WQzoYmk7vent5C237LErTCgqM1Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718636274; x=1719241074;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLet9zmo5UW5HmzlkcgKpZ+mok13cHRhtNxkNu+SlXU=;
        b=ZR9TaLj3vvr1sPU3J2tcjjKMlp22azqGUx22ZKHdoeRQS4xeuOk3e63jLM7JhVOpaG
         Pd/OD29QdJr6Ij89qXOGPuM3Dlrvxa+0c0jEkSSMb1Gr07CVSW34brj0ENckSE1M0/nE
         zQDbqkk/guAgJquMqLeimaSZYU13dp0E1u3/2ICEPNBbaYaw6lD/oj0/hXOZhpOETlSI
         Qspn5Dx5+Yqn5ODV3wtaDrvC3/VBmWRg0DFX+doOToC/DDk43/A4YYSAY1dX/pIQU7DZ
         ns1+6KuHPqwl/7KZwiREAoR+GoJkE4tzozTpirGW/6J7BEc2nIqFxwKvINOYXUZ38kKw
         pkOA==
X-Forwarded-Encrypted: i=1; AJvYcCXl+nV7WBNcci/a+JSueq3CQMhdWo8azaIvCarDVXrVmK7bPntLH7Ef7tNh+iXN1I2MkM/LenakwdpPJrSa3/ObqrKooUIVmvW+vsE4qfU=
X-Gm-Message-State: AOJu0Yxb5nMYFBZBoi3+ISihDsGxvrZ4pJAFg7xpdwqtBxpLmm4F+DB5
	CoWcd355QpDfPiVHGrCgWDlB4dNzWD53ttaMc8Bp6P1veVRr+j7cU8CJ7kEW4D7gskWaAwOz9OE
	arA==
X-Google-Smtp-Source: AGHT+IFH/O0BfeGWIV0gH4dawn5yv56Id5lK62bbsMWnqc346dkUMOm3PNnwGutCw35z5P2YFImEew==
X-Received: by 2002:a17:906:2c16:b0:a6f:37b7:52e6 with SMTP id a640c23a62f3a-a6f60d13b6dmr858496966b.2.1718636274157;
        Mon, 17 Jun 2024 07:57:54 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f63f7e9d8sm415130766b.182.2024.06.17.07.57.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 07:57:53 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <brcm80211@lists.linux.dev>, <linux-wireless@vger.kernel.org>
Date: Mon, 17 Jun 2024 16:57:52 +0200
Message-ID: <19026b45980.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <87v827k8p2.fsf@kernel.org>
References: <Zmqf7jCqwlQNGM_j@x1.vandijck-laurijssen.be>
 <87v827k8p2.fsf@kernel.org>
User-Agent: AquaMail/1.51.3 (build: 105103473)
Subject: Re: brcmfmac: implement basic AP-follow-STA
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a568c0061b173079"

--000000000000a568c0061b173079
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 17, 2024 3:19:56 PM Kalle Valo <kvalo@kernel.org> wrote:

> Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> writes:
>
>> /* context */
>> We (Yamabiko) have an application where we migrated to a bcm4339 sdio wifi 
>> chip.
>> We use it in AP+STA mode: when the chip is detected (wlan+ add uevent),
>> we call 'run iw dev wlan0 interface add wap0 type __ap' and start
>> wpa_supplicant on wlan0 and hostapd on wap0.
>> The STA is more important than the AP.
>> We have 'roamoff' parameter set. We observed problems with the firmware roaming
>> before and switched to wpa_supplicant roaming.
>>
>> We run a linux v5.4.24 derivative.
>>
>> /* problem */
>> We observed that the chip is able to switch channel for wpa_supplicant to
>> connect to a different channel, but it soon looses connection because hostapd
>> does not change channel too.
>>
>> This did work with our previous wifi chip (realtek 88x2 something), which 
>> notifies
>> hostapd that it switched.
>>
>> /* patch description */
>> I went down and ended up modifying the brcmfmac driver, patch appended below.
>> For contributing on these mailing lists, I ported it to yesterday's master.
>> The idea is that whenever a STA issues a connect with channel info, the AP's
>> will switch to it too. This implies a small glitch in the AP radio, which 
>> already
>> occurred before my patch. it seems that the wifi chip cannot modify radio 
>> settings
>> per virtual interface, although the API to the wifi chip suggests it can 
>> (that is
>> most probable a more generic communication used for other chips that can do 
>> this).
>> The channel switch is also reported to userspace.
>>
>> To be less invasive, this new behaviour is put behind
>> a module parameter 'ap_follow_sta'.
>
> FWIW module parameters should be avoided, especially for 802.11 protocol
> level functionality.

Right. Only had taken a quick glance and noticed this. The 802.11 spec does 
not really cover the concept of virtual interfaces, but still having this 
solved through a module parameter for a specific driver is definitely not a 
first choice.

Anyway, I do have some thoughts about this patch. Hopefully I can dive into 
this in coming days.

Regards,
Arend

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




--000000000000a568c0061b173079
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA9/COoi2VLlWyAEPjO
nfN+LSJNis2pD5OqeHtNWOmi8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA2MTcxNDU3NTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAFG797p9nJVafRIz+baGd5i4TKtqyopy6UcoD
K36jGeisRk5sLN464pjNwb5BJCNENJ4FrmvmGtsXYSE7xxAQ7UyBco8IXwSJAxpGNyiHEgOl2a9O
q1WGJYYhHIDAK5IExsl6Aqngn758Jm16vXGhFYj8lI98M0gRQEET15Rw7R7DLztQyTZCtjACsCay
HTmPkEmm76dSa/WuJFZX5QAO7fvt02IZDDHHuweu3Ux57L5bfMNIDBzXq8DiZLJ+nTzE3O4wwOfn
/Dlne+Ho0CODyRReoucAEKnmpmgyuBPdJ8rUOeVJmlUE5gsCsj0vS7WNGmU2QcGTfFyBseJ3YSn/
6Q==
--000000000000a568c0061b173079--

