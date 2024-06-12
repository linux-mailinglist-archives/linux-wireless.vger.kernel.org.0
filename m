Return-Path: <linux-wireless+bounces-8898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42D905CA9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 22:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF2287283
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 20:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388A55C08;
	Wed, 12 Jun 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ej4+2rfU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C8384A30
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223565; cv=none; b=sTGF8wQjWHCtbLhl5ZV+mSy4gkTDJvAi3iWJdWqbxk+Yo634L7hMDRYyM/igx5AlMIPr8KD7PojCaPtfDhYKzQw5EA/DXKu96+h81MtbmUP23xdszqHQTxnptgewiqj8ZJoyPCja+t6cOfZFWx9t9HlmDarFwI0LPIbX7WebtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223565; c=relaxed/simple;
	bh=nSDpHJm6w8bLo07m+Pg5bPxHbxN/IcGy3Po/I0rTgB8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Dnu42sC2sC5ASAkhx/7LLo9k6VQjAD/6p8hhJ+rf3/gP99XjhPwN9n7id4mf3S2BmORX1taNgFfyBpq0As8exgfXNf4KualRklQvA31bPnh/S4xeK98rMBWwpnm4AXj/2+bwHn36yy0TKXbbtTDaYAHx+OJBytgBVpT7DtfZ48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ej4+2rfU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cad452f8bso139066a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718223562; x=1718828362; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSDpHJm6w8bLo07m+Pg5bPxHbxN/IcGy3Po/I0rTgB8=;
        b=ej4+2rfUALbTWvqkCOquQf/LPWIEIgnzjcxPNMSzPDlfYPsrnnWC1zOBa7pxqWtsA8
         GLG6JY+9chQeGXNz3XDCUf7iXB2zrG0Mvv4mhsso8gQXTj8IA6G6INpvfLDE7agw94ak
         NNwhwHoomBaLJLekw+C1hyHsdJr5hBfx9fW5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718223562; x=1718828362;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSDpHJm6w8bLo07m+Pg5bPxHbxN/IcGy3Po/I0rTgB8=;
        b=MKGV+oG3X5LRn89npjLkzlLNKLmRzkOgXHTrUDPbEPyB/c6Myl/72vnkCs8kVhJtiD
         UXavJ82fCqC1rs14FGVZZzlfPSslXqHj4OzHJmoMBmok+l3YF9YnNDyPREy7bATlVqeh
         WhSpdEyd6kQj+wyiUR68gIguTh0L4b/HWqU8zBeeo7c2YXLYD0dKNTVDtoCQ66/jHiWG
         lNr3vEZb6UHyWnsgf78w4i2oQ9aAfvGRFJl1PPhXIMH48RW46Ney/Hxh8xuIWAUXTPPy
         BcwZqRBwcEAxblmdGe43BWCrpVR/Gos8HWJpvu9kGSLs7uL8vS4gArQvzKhS0AwQuUTU
         1uPQ==
X-Gm-Message-State: AOJu0YzQO6bvUXCdse5A+9jm4QKaJ9orX7zZwK2BYPu+2/KNAObzgIlo
	k6+tPCSAkR+mo2k4zrCepVHBDb4dVN/RCbkaoRbwKYbYQO2SjhKjV1Z1gF4wrLD8/GAoBS5GzfC
	VhqhG
X-Google-Smtp-Source: AGHT+IF9/hO+OSlRKrM2NebPkD3J8u1bnWDwfqhq3QbzpWaHWEzJ2qzNZFut3kCgSd696bwKQ5BAIw==
X-Received: by 2002:a50:cd91:0:b0:57c:7599:2c67 with SMTP id 4fb4d7f45d1cf-57caaaf188emr1697449a12.37.1718223561809;
        Wed, 12 Jun 2024 13:19:21 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57ca472956bsm2261399a12.29.2024.06.12.13.19.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 13:19:21 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Larry Finger <Larry.Finger@lwfinger.net>
CC: "linux-wireless" <linux-wireless@vger.kernel.org>
Date: Wed, 12 Jun 2024 22:19:21 +0200
Message-ID: <1900e1ae128.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <a7a5655f6a62c5795fdfa02e528cc1d93fb6949c.camel@sipsolutions.net>
References: <9b10768c-9fe7-40d9-a0b9-27d11a5e0e48@broadcom.com>
 <a648b5b187e2d01cd1dc47b6737c95ddc25259ae.camel@sipsolutions.net>
 <a7a5655f6a62c5795fdfa02e528cc1d93fb6949c.camel@sipsolutions.net>
User-Agent: AquaMail/1.51.3 (build: 105103473)
Subject: Re: WPA3 support for mac80211 drivers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000136840061ab7199b"

--000000000000136840061ab7199b
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 12, 2024 9:08:11 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2024-06-12 at 20:56 +0200, Johannes Berg wrote:
>> On Wed, 2024-06-12 at 20:51 +0200, Arend van Spriel wrote:
>>> Hi Johannes, Larry,
>>>
>>> I got a query from a brcmsmac user about support for WPA3. I had no idea
>>> what would be needed and actually assumed/hoped mac80211 would take care
>>> of it. My first attempt was looking in patchwork for other mac80211
>>> drivers adding WPA3 and found this one interesting enough:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20200526155909.5807-2-Larry.Finger@lwfinger.net/
>>>
>>> It only sets flag IEEE80211_HW_MFP_CAPABLE in hw->flags. So I suggested
>>> to do the same in brcmsmac. Unfortunately no success so can you think of
>>> anything else that would be required from brcmsmac.
>>
>> You need the correct ciphers too (at least BIP, possibly GMAC)
>
> No wait, you said brcmsmac, and it doesn't even have HW crypto?!

It probably has, but apparently we never implemented it.

> Then it seems like it should just work, does wpa_s have errors?

I am waiting for logs/sniffer captures.

Thanks,
Arend




--000000000000136840061ab7199b
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCW+AQ8JPfnwQ5oMScU
+njyFUP1jcuG/Io/vJjV5uk1VjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA2MTIyMDE5MjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAj3zKMnIaWxsgduV6/UZR8OvT87QZanaZJt2v
W2bvYCVstze+tgxJd7HnyLmSh1wOnsSM140Jm+SZTDBwGI+gAmCGm4kpWStteup1NF9K/I1l3+kM
/k6D5gfSsUE4NCz0/Sy2Roq9s/Qi40I9++ogPZk5uwlQMBvLA6O0an5PEAXc7FsMT8jVKxxecq5X
7OaEM344rIsc4bqaTfC6Iy2ehMGmtvzFzTpKPHVknO0REdq0rbORsYGh+NO3JnIplDy0s4wpDJ/J
QMPqGZTjx2cxETOD6Bxajzod/vvBfAcEX71EfZ4zlr4Rx9r8qRpLwNhSfWzGZ2RfVn4JVG0FnuT/
dA==
--000000000000136840061ab7199b--

