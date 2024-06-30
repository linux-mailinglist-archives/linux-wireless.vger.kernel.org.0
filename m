Return-Path: <linux-wireless+bounces-9727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CF91D13F
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 12:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700F61C20BE0
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FB313A89A;
	Sun, 30 Jun 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KCF8oolh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAB12D1ED
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744710; cv=none; b=BsMhtnE0TiaYS53nL7OwLTTEr+3FAzi5iLztoWZlF9isGCxhETJcOCjpRkYKhudgemHg9HRrsfHnORqpGq48b2UygKs+30mw/y0FUAy9y/93WZws2N7X1econyPq22pSm0ezrQcMAOHz4VGtyFk7aWbjYicNspVDU9Y4pCReAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744710; c=relaxed/simple;
	bh=IvlAB29/qRSHYaPBCZ30nDaMY9W37KksWvDneMIozG8=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CliO6X7lwYCOsP3o8lghuOI1IHQuWyAE+7nFfXBqGrD7KbxiRKgeAO/upxhQDH+2nWGH0xAk/PZFcnZRsyln0imJxqC5tXxJesKmi6F5nhFefoePboUriZnnf8Id22gVSwpPeO7DffGHfwIsYKe073VR+wccJ7JT36UI1DBe1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KCF8oolh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7523f0870cso15105566b.3
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719744707; x=1720349507; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajdoa9X4QCCOKpndI/KZC1+PpRCTqUjYMRhs3Shfwpk=;
        b=KCF8oolhfFEcAvenkfoDdoIvmX5XW85L9AIIagb/S+L7pFJBjxMY25RuSYQ4zG10BN
         0SgmCWgOqcnshvwL4kX6NCSP+pr7P15t8gYdyJwmeH/LcTNiSvMBtuPE1LBaqQSq1ziC
         hNjU99dJ62Cm6YZ/1+UlDwnVKr7FiSRVV4C2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719744707; x=1720349507;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajdoa9X4QCCOKpndI/KZC1+PpRCTqUjYMRhs3Shfwpk=;
        b=EQUeJK4j+p3VLihFWLhXd3LtzYOM+bPQJRa5uvIzSRUdG3iGMFa3dx02gzcmKpD60f
         9cEYNLd+u48WNmVZHGtBqJkNkcPtCemGbs4YosQ7Ue3Vl/bCRkbp87jn/uAA+N3YVU24
         GLML5pNKVK1/wQZVHyt1ztLahTVLEsqgHIqkkVw8tDh0xRUWZVqt6Rdr7hm221zJyd9J
         te3wupoFoyjbA+HaRppbvz3o5uScs+MBIyJ7b02mywMBvpUyHGVm2+1rueuToYzCQh8s
         za8rbM8Z20AeUM1ClDTsF3+WQRWPb1wsrS7l6D5oqc0Zcozet4FBgTcoT16Zb9LnImNy
         ASvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0xEGKm/rwBqF2bxdV5iP2zShH9RoV15JDG1P6nUg9TnARxZ5PHNLzctx6EtxhrijVP+nb2PpEvTAypvWzzfksCHVMTs6wEI5MrlJWSlA=
X-Gm-Message-State: AOJu0Ywx3gnBUKRb5B0942DIfCmOOz9hyVVXkCJnbWWJTOMtUJ9n8YPI
	VYsL6MobWChfOYhutJK6pTQGkvRG7Rtw8b1YVGN9BV1pRGnYqYMQXR0r7MnxLg==
X-Google-Smtp-Source: AGHT+IHqXK4sB8oBb7KRPu5Nbgngk9XNwKyJTwWUPZT4CqqnLhwKZZbrMG4VU6Ars2hfH5hEuB1sXA==
X-Received: by 2002:a17:906:6a24:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a7514402304mr204151166b.8.1719744707156;
        Sun, 30 Jun 2024 03:51:47 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0651dfsm237167266b.142.2024.06.30.03.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2024 03:51:46 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Stefan Wahren <wahrenst@gmx.net>, <wens@kernel.org>, Jacobe Zang <jacobe.zang@wesion.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Date: Sun, 30 Jun 2024 12:51:44 +0200
Message-ID: <19068c5ae00.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <8e44631c-955f-42de-bb2f-f3a32c79f1c1@gmx.net>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-5-jacobe.zang@wesion.com>
 <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
 <TYZPR03MB7001AC28827A86338BF2B77380D22@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <CAGb2v66Vk8SMs1TOs+80Jy5fXumuYqCx59Tzd_N7wJAfyysQcw@mail.gmail.com>
 <8e44631c-955f-42de-bb2f-f3a32c79f1c1@gmx.net>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000069727d061c194431"

--00000000000069727d061c194431
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 30, 2024 11:54:43 AM Stefan Wahren <wahrenst@gmx.net> wrote:

> Am 30.06.24 um 11:15 schrieb Chen-Yu Tsai:
>> On Sun, Jun 30, 2024 at 5:10 PM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>> Hi Stefan,
>>>
>>>>> WiFi modules often require 32kHz clock to function. Add support to
>>>>> enable the clock to PCIe driver.
>>>> the low power clock is independent from the host interface like PCIe. So
>>>> the clock handling should move to the common code. Sorry, not i cannot
>>>> give a good suggestion, what's the best place for this.
>>> I think the clock is used by the PCIe device so enable it in this file. 
>>> Also I checked
>>> use of clock which in spi[0] or sdio[0] device was enabled similarly to this.
>>>
>>> [0] 
>>> https://lore.kernel.org/all/20210806081229.721731-4-claudiu.beznea@microchip.com/
>> You're looking at the wrong driver. For brcmfmac, the lpo clock is toggled
>> by the MMC pwrseq code. And for the Bluetooth side (where it really matters)
>> for UARTs, it is in drivers/bluetooth/hci_bcm.c. and documented in the
>> binding Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
> Thanks for clarifying. So this change handles the PCIe case without
> bluetooth. For USB the clock control doesn't make sense.
>
> Sorry for the noise

So someone could end up with both wifi and bt LPO clock defined in DTS 
file. Not sure if that can be expressed and validated in device tree, but 
at the least there should be a fair warning in both binding files that 
there can be only one!

The LPO clock matters to the chip. It is not specific to the BT part. The 
clock is important for the power-up cycle. The timing difference WL_REG_ON 
and BT_REG_ON is expressed in LPO clock cycles.

Regards,
Arend




--00000000000069727d061c194431
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDa2AZi8L4XSq4RqH3T
ZgHw2+DGNXcGvo3EmgIQ3SuywTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA2MzAxMDUxNDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAFg2B4wdCpp+Ji7jgMrS2vrSl03HVGEIZj4xu
Og9J4Bei4dGFcpNMqYreRpeNQI70jSl54CuCLoPhGTtERkvM5eRnO0HQrKwGNNa4U58Tr7qQ3hu8
zmAoujTyKs6Xn0/y3ileNOGJSqsVLFQQEsdXZb69mwAPRwkiB3ojgLwA+yFJZclMUxZLuLBlqMsh
dHq3s6QbAS5bpW9KY6vI+JnfO8rIm7wO5h228KITkOGqgRljBgpiRTqddeCLfeooS6ws79pHHx6B
Z8zNJw/EXVcRG0rM/o2BSFO9bs32tOjCFKz6/KC5gGJ/EV/7Pf1BEmEn2BPsi7EdkbuTEQZMK/fm
8Q==
--00000000000069727d061c194431--

