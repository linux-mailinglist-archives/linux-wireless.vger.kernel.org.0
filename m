Return-Path: <linux-wireless+bounces-25919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C64B0ED6C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9913162030
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6A27F756;
	Wed, 23 Jul 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UqmbqFL3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853927FB1F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259962; cv=none; b=NTTynov75Za163aNXLT2t9HqCcBDAqlVVBVQaBXCC3m43oaLl1YSC/rYH0qxAsDVOXN08f+1LELVuEtWZtx64oq/aP4JPCqFh2v0utEbYAWRV2XwmShYcisCfej6SHzchvseaj/7PmLP0tOP3OXq/YWfLtKtG5t9c9am1xBtFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259962; c=relaxed/simple;
	bh=+u/o78KIR0LRcbln8o0Ki2zjZ78uhWvzFpWdlY9X3t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfg487xiOBuWcOIVgeK7z/xDm2Eu4Wvtl0rFu+u1Qw8ylTyUCNnKovgKKJ6mTmupoiORIJm3rd25M/txOfBbzNIEKarRdMjo+cET2cx2yXb3R661NRD9CC6iswvZSPUBMunKBTvYbUDuJL0wJ6nXIjKuxS1pzYolsEovXX7rCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UqmbqFL3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso12051509a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753259959; x=1753864759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGBvIyiqjTah6GGCtfPNUxIlt+eS62uIME3cKqtQzKs=;
        b=UqmbqFL3aOckzyEVDweQuULEdqiU3xqorYEa29VYitAsjdThkpPLZF+VX8xj/H0gq3
         PmCugmTilDbogNG38fhnlPwxeiV1J/K3wxxZAZS54eBmnTSDgzQP5MFwoao1VREfRIfe
         dBzLPcbkYwxwyYWouIqe4drbRyzL3U/462/4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259959; x=1753864759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGBvIyiqjTah6GGCtfPNUxIlt+eS62uIME3cKqtQzKs=;
        b=noWR2bJrDeB17JLSq22B/7A1XanW1jSRGjvB6sMybZOpQYg0HwE66TcWG0Yco660EB
         3vQWbYAdIGYcsm8+3/z+QztUW4y0VEe3RJ5+3BNLXepVU0eI2nfM+m4RBaQMXpRICzW4
         siyQMhg/7+zM9QfCALusaT+9isP15O7LasR0xokG+KNDqsPtU/dMBIskUtyEuguyQSOc
         qFH1EYy83K7J3eQ25eVD/S1MwTJXggoVlbl/R2hClaNSKF7XxrG/L4h0UFtHeTUfyCAJ
         mcnkiOMtnoB3Em713RUO1I2wxunaXiZ2l9aMmHBJBqZlALexMsTnEzeHgUDTk/18BgkQ
         84TQ==
X-Gm-Message-State: AOJu0YyHRZN3Ihq4eiQVhWdanq1RKytrnezdLcy7HNQScKIVTMpnRgN9
	718gdBq1Z9eEDTf/fE0okEK7X5OXlcjHobsOK0hfK/zqe1X7emXKJCkOu0xC8H+7qKBYnFG/7GY
	BJsUWmv+sRKpi0h9QrrVlBBL8h3DRmSP5RukLoK7bDRz67afKkLmvn+eG
X-Gm-Gg: ASbGncva7099RumTVg/sqUML1bOPR3DUokLjOERBU4NHDesOEivVqiaTVwrEtYaQ0EX
	mLC5T6F0+fgvlvFa2ChcwIgTT1AGu1P+g0oOYfLfroqbxuUtbaN0cUB37wcattBkXn3Yk1kOmNY
	zY0UHE61zZcT+Y5QR/peC+trkzqKi4RoANWIBeGxZC+QgB30Fo45Lee66QI8+1IUlF4k0wOCzZF
	bxR/m8s
X-Google-Smtp-Source: AGHT+IHEyUqsC1BUP7zQnSGAXmOQ/X4w+OWpJKXpVxfADNuNZezA78/wTb+qxNJSjUrEtbGd5Vpwq9CYcffU7W3Z2Ow=
X-Received: by 2002:a05:6402:5c8:b0:612:c846:cb67 with SMTP id
 4fb4d7f45d1cf-6149b40f872mr1497127a12.6.1753259958768; Wed, 23 Jul 2025
 01:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414083403.561646-1-dmantipov@yandex.ru> <d59805fc-578b-4421-90e3-40e322be0652@broadcom.com>
 <e0fbf753-61d2-411a-9a99-184b310ebe03@yandex.ru>
In-Reply-To: <e0fbf753-61d2-411a-9a99-184b310ebe03@yandex.ru>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Date: Wed, 23 Jul 2025 10:39:05 +0200
X-Gm-Features: Ac12FXyPLeXvhVw5f7-OAFbuxpFRsJeZPcyBZK6XtWbQMP8ZCNU8AhDYtYVCJO0
Message-ID: <CAF7Mx6p7QB52gvK=_0sfR=Hqc47QAKSh5MbS7OfKpPv1wpDWNA@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: avoid calling platform_driver_unregister()
 more than once
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000011f6ba063a94a5fa"

--00000000000011f6ba063a94a5fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:56=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> On 4/14/25 12:22 PM, Arend van Spriel wrote:
>
> > When the platform_driver_probe() fails it means that brcmfmac_pdata wil=
l be NULL
>
> Hm.
>
> platform_driver_register()
>   -> probe (which is brcmf_common_pd_probe())
>      ...
>      brcmfmac_pdata =3D dev_get_platdata(&pdev->dev);
>      ...
>   ...
>   if (!bus_for_each_dev(&platform_bus_type, NULL, &drv->driver, is_bound_=
to_driver)) {
>           retval =3D -ENODEV;
>           platform_driver_unregister(drv); [1]
>   }
>
> If we hit platform_driver_unregister() at [1], 'brcmfmac_pdata' is not NU=
LL and,
> if something goes wrong in brcmf_core_init() next,  platform_driver_unreg=
ister()
> may be called again.
>
> Shouldn't 'brcmf_common_pd_remove()' reset 'brcmfmac_data' back to NULL?

Hi Dmitry,

This one may have gone stale a bit. It showed up on my patchwork todo
list which we setup last week. I agree that reset brcmfmac_data to
NULL is needed.

Regards,
Arend

--00000000000011f6ba063a94a5fa
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
p8a1MYICYDCCAlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCctZ7mmv177Nd5gNFV
tahTtR4RpEP+BKPwrnEk1gAgGDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNTA3MjMwODM5MTlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBqvC3gT2qVW8X0mGv/RAJsktLOsK82vpmn6yTwezalkXkL285RDhOv
frgzpQgF6cLgRzmEvx6pNomuXnolsxFhPUMvVFxA1rEhCwV3RIhSbSRPpf91AIdc9NRjAFDm9YoZ
dcJw9MwW+/GJsCy5zybpLw4MYi6sx1aIb9JqrE71ECZafNGpQHibckC2zryFzhsU7K1cdE6QiRIu
6nNTEXNz8dVKr0tfTe/oaGaKTExUuVcUgM4ecOtvE4BnAULphkPjWB1WzwXYgHVCHMVd4gOl7Qu3
IRF12DG3270CUGSTtN289MNFIHVq5zgA9xgFr8XZMMMH6ROLXhx9FdG4LZ5R
--00000000000011f6ba063a94a5fa--

