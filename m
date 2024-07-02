Return-Path: <linux-wireless+bounces-9857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013D92410E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E5D1C22607
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA41BA07C;
	Tue,  2 Jul 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AzqBcTtv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730DBE7F
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931300; cv=none; b=u4+7JQgezJqirw0c8sKD2+e+mB6Ql9tkBIwtjl9rsdF5fHoPdOWR07CEHhDLE08Ri4el7fLNsBMlAYPPT1Nsh3yhwPR1sbvBq5Mphs01DSq9mlxeL1OsRedMUk30xGRjkpFdbloPEVXdIYnzG/nuuysecBtWVkxKC49H18hMfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931300; c=relaxed/simple;
	bh=ojPBAzscT7qjU002Oye6xDt9BK23Uov875hbN8BHQOk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MBwgoug/YlrVgegr5Ub4d1/BvpN0KiYxSTRUZucY/U6zGKAXbMgo39ODs/wUPRv4tjz0bKKpVg9qbXI98j+ni6HVde+Wm0QOUIdJk0Ca2wTIbqjdGKLjvxjnl1iPXjyFtPh9rkKZkODLg7pyYWXyY4Z+/PQhLSf16X8S4si5MOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AzqBcTtv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295eb47b48so5239283e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719931297; x=1720536097; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojPBAzscT7qjU002Oye6xDt9BK23Uov875hbN8BHQOk=;
        b=AzqBcTtvDAwcCwwWbgf3CFgbSHA3iGHP4NGfGl7N7NWJ9n2m6vjjTucf7wlsr6zpwr
         8ibPB2+y+nF29zGPe0hyyoB6Z6lEXQCCfRAICEpJplaQsQ3tFcBWw58PVVpZKlVLMrOf
         ACVEOEzSa6FJq8tN0EdfYrCqYrEtthetoBI1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931297; x=1720536097;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojPBAzscT7qjU002Oye6xDt9BK23Uov875hbN8BHQOk=;
        b=Ki4Xma/P5D70JvtPGVVbmcSwCyFRjYT9szzB6pqiRViDkhOE87wLA4WU5rqSwoZ49W
         vKqaUErzkzbgLjC8sSFaduXIYwpz+qFkJCL2F0A0GHaXr/g+iCHO8hsme+mazznD8Oh+
         43lwbmk4KVvjjT9L0g0vKwbS4TD9uMJo4n0lvj+2OEgNEgaTTVZF3pN/n/x2lGtSimfz
         +jNyJ2XNcxYu/SJ0+aSompaMvr2sHNtI8AbAc9j4rLUslCKaesxOb8128kHDrad6zNmA
         HfxrjxhEC5emPF15pfnZ0ZLva8yHOFT89qi2+5ceGTFhl0iT0qJ7j9ElkFP4QGbwd3aK
         y4mg==
X-Forwarded-Encrypted: i=1; AJvYcCVv+bd8+WS1CIpi19eQdRijlhGrV65iW9XEQT8r55HScinSE4ToJfzjsCzYTu6sFk0zqpelbZhgWbq+MuNr+akrCAfxvB6VfpablSDFp6w=
X-Gm-Message-State: AOJu0YxTp0FFg6jnAOEn94xmb+Yyh8b62+KSSyYv8k2GghFvUxQdcjoN
	6V9FkqcEaLU56QtkbQKSznThnXN4aRyG8LHvSgc+q+riFc7X/vCVqozHGUo+1A==
X-Google-Smtp-Source: AGHT+IHVtX/aDIl+DTQjkyohV5orWbeyrkEnZIQBjZ2/ag5M0yWAft9UtgtEA9wk91x/iUtQEsWbGA==
X-Received: by 2002:a05:6512:114f:b0:52c:ccb4:ec70 with SMTP id 2adb3069b0e04-52e82661de0mr6094510e87.22.1719931296498;
        Tue, 02 Jul 2024 07:41:36 -0700 (PDT)
Received: from [10.229.40.68] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258036d034sm99115865e9.43.2024.07.02.07.41.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:41:35 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Su Hui <suhui@nfschina.com>, <kvalo@kernel.org>
CC: <kees@kernel.org>, <a@bayrepo.ru>, <quic_alokad@quicinc.com>, <zyytlz.wz@163.com>, <marcan@marcan.st>, <petr.tesarik.ext@huawei.com>, <duoming@zju.edu.cn>, <colin.i.king@gmail.com>, <u.kleine-koenig@pengutronix.de>, <quic_jjohnson@quicinc.com>, <linville@tuxdriver.com>, <pieterpg@broadcom.com>, <meuleman@broadcom.com>, <frankyl@broadcom.com>, <stanley.hsu@cypress.com>, <wright.feng@cypress.com>, <ian.lin@infineon.com>, <chi-hsien.lin@cypress.com>, <zajec5@gmail.com>, <antonio@open-mesh.com>, <franky.lin@broadcom.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Date: Tue, 02 Jul 2024 16:41:32 +0200
Message-ID: <19073e4c960.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <2db23d6f3bd62c955c76d30aa2dfc3f03c8c5748.camel@sipsolutions.net>
References: <20240702122450.2213833-1-suhui@nfschina.com>
 <2db23d6f3bd62c955c76d30aa2dfc3f03c8c5748.camel@sipsolutions.net>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH wireless 0/9] wifi: cfg80211: avoid some garbage values
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fedfcf061c44b55e"

--000000000000fedfcf061c44b55e
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 2, 2024 2:50:38 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Tue, 2024-07-02 at 20:24 +0800, Su Hui wrote:
>>
>> Su Hui (9):
>> wifi: cfg80211: avoid garbage value of 'io_type' in
>> brcmf_cfg80211_attach()
>> wifi: brcmfmac: avoid garbage value of 'status' in
>> brcmf_c_download_blob()
>> wifi: cfg80211: avoid garbage value of 'noise' in
>> brcmf_cfg80211_dump_survey()
>> wifi: cfg80211: avoid garbage value of 'chanspec' in
>> brcmf_cfg80211_get_channel()
>> wifi: cfg80211: avoid garbage value of 'freq' in
>> brcmf_cfg80211_mgmt_tx()
>> wifi: cfg80211: avoid garbage value of 'wsec' in
>> brcmf_cfg80211_reconfigure_wep()
>> wifi: cfg80211: avoid garbage value of 'wsec' in
>> brcmf_cfg80211_add_key()
>> wifi: cfg80211: avoid garbage value of 'val' in brcmf_set_key_mgmt()
>> wifi: cfg80211: avoid garbage value of 'wsec' in
>> brcmf_cfg80211_{get,config_default}_key()
>
> Uh where did all those line breaks come from?
>
> anyway all the titles are wrong - all of this is brcmfmac, not cfg80211

It made you look though ;-)

Gr. AvS




--000000000000fedfcf061c44b55e
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAKlUM4ImgXCxlmJ0BH
tb7nTJmgVvMg5/EK83EFkVXnKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA3MDIxNDQxMzdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAijGj2+2lkobAzOQh6mOKG/hUMQJ/ACLZkzTV
mf6LYme44Wbo1FTbaipjKCjy0FRy9s1heTPBdp0LXnLIscG0gVdKjz1+ARNmTvVC3Vfv19ZVPzZE
43Nbw/RJL8QaU3ApjN+FwJW+t4rHtd31NGco8nsnrkyk7oo8qTHyDZEtd+qBD6RKpP6+SysKumeT
TcNqIJYd0LnEvjPuuUi4TEfK2Fum6ID8CLJ8mbJL+b6KRQhFFqfkgH6bZ1bin6+63vufh/jbqMn5
jG2Uha+54U4CBAhPPyFRxbFf/RMZ8QI7bRYLJmOgikzhKGBCaYrQO48VnrKF4H25fdzEpoYLWzj3
tw==
--000000000000fedfcf061c44b55e--

