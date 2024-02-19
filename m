Return-Path: <linux-wireless+bounces-3789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7985A9D0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AED287CD4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E644C8D;
	Mon, 19 Feb 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dd2m7mHl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E2446A5
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363257; cv=none; b=O+i/9Si4CjJqrJVXGjWWGCCaXKl/8dknpk+eikAKv3xOr9XHligcM+H8sTCFSS2eggn4OzivNwcXHRE9bNRBUgUr0ZP+sEr+JLe7vwwuDwAyLzKLifA4PIVpnDJ1agHUGFGWPV9/jwNHU+5PUk24hTTheEV53bIriX3+iuIxdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363257; c=relaxed/simple;
	bh=MnYUJ6wp1GBxvr8K+KV8urogHBU74uDc7sLUcCgL5Rs=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jr/Jas1WLyaF8QcGNDvhVPYoyg4j5kb1kEsn357N5RaC5NF2FbskKaJIHnuTqeeGn4ZpSzkzm/cbxTD6Rm3AMe/tdNfoZbbr7JPpaCvfrCJ1q/txaxjPxrOkIJ3nzO3aFJPToCufE1soZinpgd5K43LQzSgz0GW0Td7tSwVA8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dd2m7mHl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso79832966b.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708363254; x=1708968054; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7D5MzPR2WYSzvNFMVk1Au4+Zo2HpC+WKZAwn9Hnhzdk=;
        b=dd2m7mHl+3WsNPl0ZUUXIhWt/OvycjjeXNopelkjTxUV+TAw8qKCFr50akDbe/wGcT
         RNADQ2CJ7I9hN9QN2+PHjP75LHrGrp+tnml0NXUM+IgdZalA/XTXNAKJCCl7SuLEwty7
         w5N7c3K8Dsi4Vcz4rCw76sqweJ9q3i8rsV9S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363254; x=1708968054;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D5MzPR2WYSzvNFMVk1Au4+Zo2HpC+WKZAwn9Hnhzdk=;
        b=eDVGBIJg2POWS4a2ie/JSug64N9m4G1uip6z9yPnOTpaxCyZtCdY53hzbxAY/zTfo+
         Udjh901antBsEp8GPhFpDYQm6ydcl4OkN5o1tBVkHuFDyZ7RSn3mZ2gjRh/I6IvJTTgQ
         jTvEvjDdSwOiikZUoRVVZvpBCQ88fIw8mAvSt0aknvUgCWBBoA0OMnEmA8leuMcHCGSi
         nEeDK4m+XFUmnZIfXMoz0HxeoBqNT2u998t6jlG7KoOSjOiR5gQ64VuaRFR66BHCcpvD
         BHv2QBVqGMAeNyr80OOBi144NUpRPPvUItjo6x78qSdCGLAJaYldf/+fGjDxxtJbsIS+
         Do3A==
X-Forwarded-Encrypted: i=1; AJvYcCXm0aaadBJrCSpc0fSO+8FpxT0PgLJzEadMUX2Q/lzFjdPoZ+RlbZ14eAkmx/G0ssR0SoZa82n4bx2hlKmVU920lJKFmrVDArycOHHNb/Y=
X-Gm-Message-State: AOJu0YwFabqh2PagANu2Sx6Zqdyb6RSU5yKQUJLHb2BwgYYdwDqQciPR
	UiR75+iEkoYRquEvblU3TN1BT1WqCYbyvdkNVR/Roe9lrFC9x4D00OmQ2PfMMNVJJbfROggVJCX
	iQIsi
X-Google-Smtp-Source: AGHT+IHBp4Q+AR5oRZfYNbt22WygVHvlo5RrSziK6Ppgb3DVY4am+2AdHMsZr6YAwU9BPg6aaA3vvg==
X-Received: by 2002:a17:907:20e2:b0:a3e:9df3:b2e7 with SMTP id rh2-20020a17090720e200b00a3e9df3b2e7mr2470386ejb.35.1708363254183;
        Mon, 19 Feb 2024 09:20:54 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906e00200b00a3e1939b24csm2861597ejb.208.2024.02.19.09.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Feb 2024 09:20:52 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Alexey Berezhok <a@bayrepo.ru>, Arend van Spriel <aspriel@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
Date: Mon, 19 Feb 2024 18:20:50 +0100
Message-ID: <18dc2627950.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240214152117.14467-1-a@bayrepo.ru>
References: <20240214152117.14467-1-a@bayrepo.ru>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH] wifi: brcmfmac: do not pass hidden SSID attribute as value directly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eed5750611bf5086"

--000000000000eed5750611bf5086
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 14, 2024 4:27:35 PM Alexey Berezhok <a@bayrepo.ru> wrote:

> In 'brcmf_cfg80211_start_ap()', not assume that
> NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
> an explicit check instead.  Use local
> variable 'closednet' to pass in function call and
> use for error message. Compile tested only.
>
> Addition for the following patch
>
> commit f20073f50dfd1 ("wifi: brcmfmac: do not cast hidden SSID
>                  attribute value to boolean")
>
> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 63f6e9436..cd6e01f23 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5269,7 +5269,8 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct 
> net_device *ndev,
> }

I think there is some misunderstanding. There is no local variable as I 
suggested. Here is what I had in mind:

     bool closednet = settings->hidden_ssid == NL80211_HIDDEN_SSID_NOT_IN_USE;

> err = brcmf_fil_iovar_int_set(ifp, "closednet", closednet);
> if (err) {
> bphy_err(drvr, "%s closednet error (%d)\n",
> closednet ? "enabled" : "disabled", err);
> --
> 2.39.3




--000000000000eed5750611bf5086
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBRR+glbjvOuD8Ws2n8
xt6IS6ZU03vLHLLd3DCkxgfoATAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAyMTkxNzIwNTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdKg7sMU6qdOlXYTk+mX/Apw6fZz2lF3niYAp
GLpJxgmjgHBDRacEpo1PAuKxWPLByEK1TAJ1CYmqFHgw9y0Ybu9LfyvZKJEIOJWCrpevGznUIK8I
KD+uEyVvRHPywCdAfm0GaACRR0ywgrTIpMSaPc9k648Gd5BkAGsMuKRMoPhayWidf7m8XiaoE5/g
QP3UF0O0rCUHxp1fMh/m7re/r9AC3bR6yJ1WcnZbeKuceBMFOFmjHLf7NU84J6Kz8PpzMGXJu1or
MHS7OF3HqKZTVwYFDPuohabF7NJsKc4FsUnEoACzMYJSN4aM5ezaR9zXhVi6mfOYDQm100lq+25V
xg==
--000000000000eed5750611bf5086--

