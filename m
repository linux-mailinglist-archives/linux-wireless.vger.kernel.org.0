Return-Path: <linux-wireless+bounces-9865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E39241DE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9AB1C21E38
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377D1BB69A;
	Tue,  2 Jul 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W5KGNx71"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEF1BB687
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932876; cv=none; b=W00SdyTKmOjWpTGBaAnJte7YQ7D3U9dMwuQVRXXt+8RPkzO5oe/DQd7TFl9Vy9DjlqmwzAWI1zo95j4E9YdUG3ynxVtBc4DMevIG9G8DJQHW0DGJiUehx2ZotZSNvXwQgHm7jroKjo5ZTg53Rb588AOaZPxgWr0CK8K7J00BeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932876; c=relaxed/simple;
	bh=y3h9Lj+rw96CoGE/NedVPIkxpmqn+SRv6yREya76+o0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Q913BTQo1Lz7gicDmEawUxo+y3RSyO+V70yy67zLs/k9WTcs9b5HpW2ckK5LPK6B5qJb3njRtdv+npyFoMTT60/DeR+thpbRp0aAhuldpX7i0nfei+nMd+LCz3xOo1JHhJE+ehNriuYdsAhMorfn379eW/vnW2sOeextyrEHeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W5KGNx71; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79c04e6e1b9so312866485a.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719932874; x=1720537674; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZGnTq2knKKBXVMHhIAx+M8rWTgHWYjRDRYkxg04fz8=;
        b=W5KGNx71Z9jg7keSfYvFJ6JZMUT9z2wpkflPZk+/Ab7Ey3gwweYf7DctxeU9r2IsOg
         UxmkfZrQq2XHq3fIP9z/LQIhCpTf8kQiEgTM8dLpxLb4XfM70Dszo32k0ob3LBa/T0R/
         CyJHhAP/pPQObCAWwaZ0tOgJmN18PMLigUF1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932874; x=1720537674;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZGnTq2knKKBXVMHhIAx+M8rWTgHWYjRDRYkxg04fz8=;
        b=feJ13J6UoDhi44HPSywSBeqCk1hxM76EIeseHnOkJ5Nhze6smTC5kgO+d5LnyHajeA
         YVzPaXjzfea9jM69KbIxy/5wUw0QV7He9M1HcMMR45tBvoVUAg5ojWXkWNOUCnSQSwDH
         UtBxV3fdFXRWugDP4DYafq3Fl3N05B1x27eIYvmcp5bpiFUVut8Ir2Pv9WOfruU1bKgp
         BOvub6rkt6CVQQP4mJs4gcgSqAYThIaSxapd8cRgJqB81Dx3+X5dirqys5NxSmjth3zQ
         /0aWKAd6UmRaWjVwoeOCOsoEg9jABJTT0Xtlu0LW1UqJB4RFvo22GDT5L9e/fNMTnj5N
         Q5+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHLWRUPqMvYs7b62wHe0feWlfepDMr9tDsdpX3oqxTIbLVeRN98E5NboQlanvw3RkZIwtj0kfsFR58hGuQrJOAw+EJReFNcJ77PFlrmJo=
X-Gm-Message-State: AOJu0YyxIqF1/7gMdYier21zGqFX+DN9jA6AIPr9AqF76whJMb6HWDUb
	3VWxMqVdxcUlTnJQCDSsRXzlo4Kq7pijjjXGKIXJxjA/sbsYFOVG9J03YTam9Q==
X-Google-Smtp-Source: AGHT+IFT3KFWENwxvfDbJfuBesJru9QLfzhJS9tFply8t5qiy5/EzmRdd8/ZBMl+PnEJ5FqNrZilHA==
X-Received: by 2002:a05:620a:2a06:b0:797:d55a:5166 with SMTP id af79cd13be357-79d7ba89787mr1033682685a.58.1719932874359;
        Tue, 02 Jul 2024 08:07:54 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692945b4sm461249085a.57.2024.07.02.08.07.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:07:54 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Su Hui <suhui@nfschina.com>
CC: <kvalo@kernel.org>, <johannes.berg@intel.com>, <kees@kernel.org>, <a@bayrepo.ru>, <marcan@marcan.st>, <quic_alokad@quicinc.com>, <zyytlz.wz@163.com>, <petr.tesarik.ext@huawei.com>, <duoming@zju.edu.cn>, <colin.i.king@gmail.com>, <frankyl@broadcom.com>, <meuleman@broadcom.com>, <phaber@broadcom.com>, <linville@tuxdriver.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Date: Tue, 02 Jul 2024 17:07:45 +0200
Message-ID: <19073fcc9e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
References: <20240702122450.2213833-1-suhui@nfschina.com>
 <20240702122450.2213833-2-suhui@nfschina.com>
 <ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of 'io_type' in  brcmf_cfg80211_attach()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000007ea0d061c4514fd"

--00000000000007ea0d061c4514fd
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
>> brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
>> brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.
>
> Since you're going to be resending anyway, please delete the space char
> from the start of the line.
>
> It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
> It looks like it just goes to great lengths to preserve the original
> data in io_type...  So it likely is harmless enough but still a strange
> and complicated way write a no-op.

Not sure if it helps, but I tried to explain the reason in response to 
patch 0 (cover letter).

Regards,
Arend




--00000000000007ea0d061c4514fd
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB6VCGmFck08Oe87eDj
IG86W39dDecyS213otDN4jZ4xzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA3MDIxNTA3NTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAhV6/6PHa/hfQ08MhxvUTUwH3CV17jxOk1sxX
yPZ+qqhMuvMpWpQA8PUxlNfDmPhIb0sLzrwI4oEdRzKleqo7Nql6WehmNpPmKPs8GNuMbyEI78fI
lO9bwK1cHXSQbG3smc5GsOzNmZb5Bm9b86TwefIr4cJMgYqRZl8UNaqOwJ81KMwG9Pibb0sMT26O
NOHt9JYCH3r84aTNE1e1BStooH/R55ydKtWgHczF5lrSunKm9zNhJXx2T5l8TRUE4ilMcOu3AtYk
2NR5lxcZI3hVPsoNgbVWQvKOjfIUz8y1/gvF3mcLcw5lsba4309oQNM64aHs0JBqI2566vGNPx/K
1w==
--00000000000007ea0d061c4514fd--

