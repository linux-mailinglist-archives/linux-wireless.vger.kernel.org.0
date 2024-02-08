Return-Path: <linux-wireless+bounces-3343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110684E485
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99978B25896
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9F78667;
	Thu,  8 Feb 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EJA6Oyp+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674747A713
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407822; cv=none; b=W0yqSsPlL+6Pysihqh5bE2PWI4Be5KhuQPEMgpflsnhPUFzja2NOb2e+BQWaF37/p27Xnm5GM0UZpLH7cQY8t57AjdKHZ4Ca2qiHICu34Jf0+fmFC7x5UKsrtxa5TDlP5iijgg9rXwwJsIlwTuUpCYfmjajb9W+MdPvPLYFClxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407822; c=relaxed/simple;
	bh=/bx/QxivVk8MWroQaT+I1SUoeW2B+oLeP7yHyT2Fkjc=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lneg+1h0WU78yOnxyvKB8s9A4CLwvpRspDZvLstYFOE9uaeCKVMO+5D9ehrxC+peFLXbrKSTKEn33x8GT+dJQURRJfjVRfcbQP5e/aRh9sFKbUb079qMhGQrJC3uJyQyXpnzwmC6+kXC9KEuwnIAjIq0jSVi0EllwtiwnswdLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EJA6Oyp+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68cd058bc95so160986d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Feb 2024 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707407819; x=1708012619; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4PW1BE069GkBgkele7Eug1skC7UUgEXb8u20ol83HM=;
        b=EJA6Oyp+jYA/0PyAEs1Vc4BzDNvJBJyNCRP0XUWnzEG/IEjYDfkyvX+epa+m1XMN7T
         XM51Jg8RWGgOsC8pzAhlGi/MGOP50p/KYU6BzIKB1T9T4gOOWG2Nr4903CXiqim9xelS
         WhZb3ZNHUNxcHOCNHVxB3gK8GR1ahcFi/w/68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407819; x=1708012619;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4PW1BE069GkBgkele7Eug1skC7UUgEXb8u20ol83HM=;
        b=DJOprb3Hydf9YeIaAv+rTEvuLBawtaPJwJjI7ghswk3p6PTmd7kTMTI64g+N97Q4Nb
         wiQURgSw9D/O60miPgseAfULAq1P29381sDTCbX/vUn+zspRIBo35nHPj+GVzCU35xNJ
         u3Ymln7JxQdt2nR3d6LWnjGmuSViBBPoMpcJeNbyJhOT7+5X/7DxHNBdaZIiurtgL+KG
         MB8y9kI1Lj2tsgSr9tQ1EmOaStekF5vEwFhu1fJYNRUfIImv6o4dxNTl15k0xx5hvgji
         zb/pX1vtYJysPgPHImC/0XpWP7Bh5QLq7ARhtgNLrESMS95NafPtNyhKd8WZ7KsBzGTE
         lBnw==
X-Forwarded-Encrypted: i=1; AJvYcCXYENt9cSswko04dDTgRFvZ5WdCRII2FRSfylH4u7qxgFG2AG0rWgZocAJk9+pROorLWK/y9pQNzaz9peVN+72yHDhxfpAQS6mZNn1I/nI=
X-Gm-Message-State: AOJu0YxrdOL2szK5G+ugjE+vh1ZAzmJvwltsQbii7NYnj74AjPPgSO+V
	wwpIULIfi4wvqNVr12Zfkij3pwE/x9ietdlBcObO5ZK04g/3/B2hfUhtInOI0Q==
X-Google-Smtp-Source: AGHT+IHQeUNJqf8wXElNtjs5sPXSs9sYaYhfKRSxTKJgH8z/j5ZRE4+zU0LqWqf92jRnN67OmHWP3w==
X-Received: by 2002:a05:6214:3f81:b0:68c:8ee2:3fa0 with SMTP id ow1-20020a0562143f8100b0068c8ee23fa0mr11751668qvb.11.1707407819250;
        Thu, 08 Feb 2024 07:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyS6QmyhnYPRPY+CVAaVnu5T/uRKizXUk32TWm18+sAIotexi7nrdmI3djY0Sgk3fTIE8gw8xIw94zbu03MP2h5EMQgyizHMUWQcWHxGcSzuT2ka437AMObbZevH+YZ3MbHb+dxA2LCXy5ILFqzkeKMgtXCTw8VyUI/cRXVwr2u4DVTm2qIZqS5PVEe/w=
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id mb3-20020a056214550300b0068ca9ea78cbsm115347qvb.21.2024.02.08.07.56.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:56:58 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Alexey Berezhok <a@bayrepo.ru>, Arend van Spriel <aspriel@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
Date: Thu, 08 Feb 2024 16:56:55 +0100
Message-ID: <18d896fb158.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <4e3b72023f30d8765154805816e6eb1f4e73593c.camel@sipsolutions.net>
References: <20240208085121.2430-1-a@bayrepo.ru>
 <1bc49c2a-1f62-4801-90c3-048b27f6475c@broadcom.com>
 <4e3b72023f30d8765154805816e6eb1f4e73593c.camel@sipsolutions.net>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value to boolean
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000091812f0610e0dc02"

--00000000000091812f0610e0dc02
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 8, 2024 3:15:25 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2024-02-08 at 15:06 +0100, Arend van Spriel wrote:
>>
>> settings->hidden_ssid has already been used above in following call:
>>
>> err = brcmf_fil_iovar_int_set(ifp, "closednet",
>>   settings->hidden_ssid);
>>
>> So we pass the value as is to firmware using the same assumption, ie.
>> NL80211_HIDDEN_SSID_NOT_IN_USE. Is this not ABI thus very unlikely to
>> change?
>
> The ABI won't change, that'd break all the users of nl80211 that use
> this :-)

Right. So basically the assumption that NL80211_HIDDEN_SSID_NOT_IN_USE is 
and will be zero is a safe one.

>
>> @Johannes:
>> Actually not quite understanding the reason for having this setting in
>> nl80211. hidden_ssid means SSID element length is zero, right?
>
> Well, there at least _were_ APs doing the correct SSID length but
> setting all octets to zero ... Not sure that's still a thing though.

I now looked at the definition and see indeed two distinct flavours of 
"hidden SSID". Interesting although I have never considered it a useful 
feature.

Regards,
Arend




--00000000000091812f0610e0dc02
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC31X6axrdM7c8lNrcl
QVVyZfqN1dqXB4HCkh4od6ofpDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAyMDgxNTU2NTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA2yLUTHtuanrXkl26MTWd0ahrEjbX8f1pjuiZ
lGJ5WC7VYxoF6tfskI/TLHSq3e/SoyGG7OswbouUczAmz3kks3WrmfadXSek8he54eaC5J8ROyiX
1YnZjeU4ozP/IwuTdJM0m9dZkGclu9jr/9G1cLevMgCmmStSRMZ10RgsuZWwF11AOOgP5JwP1Trg
0o/GSfSZzsPo+WHVnf6IlfMJC5NsEgnQzh1C6Mky9KzWFaP2DrJfHlCj5FiUehJjZ82PKHNj1ml/
NZHrzOsSplGhCBCDLvoF+TJFo0RVol/QNhsRvvdb3c50Abs5ZvyVpmFPmYko7y7ISNAZrA4U1z0n
qQ==
--00000000000091812f0610e0dc02--

