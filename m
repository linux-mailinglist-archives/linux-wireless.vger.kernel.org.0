Return-Path: <linux-wireless+bounces-1203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765181C585
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16FA2833C0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF8C8E4;
	Fri, 22 Dec 2023 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DlkSkdGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5BC8C8
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3368ac0f74dso1015320f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 23:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703230246; x=1703835046; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z90iUI2iKbMfh0PzyXw4/xIjqXO+qedwWjHPMkQVwWw=;
        b=DlkSkdGpy3Zd7Bc5HB37s2GQSrKU4RHEyiq0dSIMc6Ca1+Id1VZT40OIlz/ixB9T+S
         JDz6asWKWdyX9q9mNhy8Wj/YOnf+LtlX2spvfekjVJtpGXwGsrybLSdSlUCQuVdKp014
         nT9aM+C5LB0eBzpJlpfF9IoaVtqzgjwMroIqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703230246; x=1703835046;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z90iUI2iKbMfh0PzyXw4/xIjqXO+qedwWjHPMkQVwWw=;
        b=ONeh7dDju7VnZY256jP0NMvqIbT6teQxTpgCVwDuBFfXdSTChQII8i5ksHIfLP2LAA
         FEilrhZWM3NVpS40lyscYSEOEiSu/4Hk+qNmWnSn87Ydu17Cy4AIjmLGfSQhgm68zYpv
         PXnzYJflPEMfw0BANQqNZZRbQbrWzwkSEoRX+wPjo64r/Ow7psCG889qFb+F4nMoX2jM
         2UfhTP5pIMMJorkARQq1YbJe8XONtkBTu5dnWRhZpcKETBxLJgIHiBEVS+jlQOGIL0oX
         rsKIWwQ7Hahy6JAETKVJylR8k8mC97bsgsOvbi0b9dQdsE3Q+/76GEok+u2CIhe073VY
         RkyA==
X-Gm-Message-State: AOJu0YxJMpyhU0Fs6xBC9XaGy9UW+FmHDmBfCWw2N8S+Or2Oeh4pKn9H
	FUtZPkHd562l6w0fY2IU9ajD8TFYj0N3
X-Google-Smtp-Source: AGHT+IEdCAwMHjGDoYZtfl0tUci5xWP6FI+sQZuQdPU4rC5mw4C2D6dBbSS+uUiRXsziYCB1vynxpg==
X-Received: by 2002:a5d:4d92:0:b0:336:392d:94 with SMTP id b18-20020a5d4d92000000b00336392d0094mr467671wru.123.1703230246340;
        Thu, 21 Dec 2023 23:30:46 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b0033660aabe76sm3622403wrx.39.2023.12.21.23.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 23:30:45 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, Neal Gompa <neal@gompa.dev>, =?UTF-8?B?UGF3ZcWCIERyZXduaWFr?= <czajernia@gmail.com>, Kalle Valo <kvalo@codeaurora.org>
Date: Fri, 22 Dec 2023 08:30:45 +0100
Message-ID: <18c906f0888.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <537c3ebe-ffe6-4579-a791-1450a3c1b107@marcan.st>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <20231221140416.223639-1-arend.vanspriel@broadcom.com>
 <537c3ebe-ffe6-4579-a791-1450a3c1b107@marcan.st>
User-Agent: AquaMail/1.49.0 (build: 104900403)
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d3039e060d1431d1"

--000000000000d3039e060d1431d1
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On December 22, 2023 6:28:12 AM Hector Martin <marcan@marcan.st> wrote:

> On 2023/12/21 23:04, Arend van Spriel wrote:
>> From: Hector Martin <marcan@marcan.st>
>>
>> Using the WSEC command instead of sae_password seems to be the supported
>> mechanism on newer firmware, and also how the brcmdhd driver does it.
>>
>> According to user reports [1], the sae_password codepath doesn't actually
>> work on machines with Cypress chips anyway, so no harm in removing it.
>>
>> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
>> patchset [2].
>>
>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>> [arend.vanspriel@broadcom.com: use multi-vendor framework]
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> Here is how the multi-vendor code could support both Cypress and
>> WCC mobility chips. As said it might be easier to just override
>> entire cfg80211 callback operations.
>>
>> Regards,
>> Arend
>> ---
>> .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 13 +++++++---
>> .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  3 +++
>> .../broadcom/brcm80211/brcmfmac/fwil.c        |  1 +
>> .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
>> .../broadcom/brcm80211/brcmfmac/fwvid.h       | 14 ++++++++++
>> .../broadcom/brcm80211/brcmfmac/wcc/core.c    | 26 +++++++++++++++++++
>> 6 files changed, 55 insertions(+), 4 deletions(-)
> [snip]
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
>> index 5573a47766ad..01025d5c137b 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
>> @@ -7,6 +7,7 @@
>> #include <core.h>
>> #include <bus.h>
>> #include <fwvid.h>
>> +#include <fwil.h>
>>
>> #include "vops.h"
>>
>> @@ -21,7 +22,32 @@ static void brcmf_wcc_detach(struct brcmf_pub *drvr)
>> pr_debug("%s: executing\n", __func__);
>> }
>>
>> +static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
>> + struct cfg80211_crypto_settings *crypto)
>> +{
>> + struct brcmf_pub *drvr = ifp->drvr;
>> + struct brcmf_wsec_pmk_le pmk;
>> + int err;
>> +
>> + memset(&pmk, 0, sizeof(pmk));
>> +
>> + /* pass pmk directly */
>> + pmk.key_len = cpu_to_le16(crypto->sae_pwd_len);
>> + pmk.flags = cpu_to_le16(BRCMF_WSEC_PASSPHRASE);
>> + memcpy(pmk.key, crypto->sae_pwd, crypto->sae_pwd_len);
>> +
>> + /* store psk in firmware */
>> + err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
>> +     &pmk, sizeof(pmk));
>> + if (err < 0)
>> + bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
>> + crypto->sae_pwd_len);
>> +
>> + return err;
>> +}
>> +
>> const struct brcmf_fwvid_ops brcmf_wcc_ops = {
>> .attach = brcmf_wcc_attach,
>> .detach = brcmf_wcc_detach,
>> + .set_sae_password = brcmf_wcc_set_sae_pwd,
>> };
>
> If we're going to move this into per-vendor code, we should also move
> the Cypress codepath repectively. Is there a reason why we can't just
> rename and export brcmf_set_wsec (as in my original patch) instead of
> duplicating the code here? Fundamentally this code already exists in
> common code for WPA support, so why not reuse it for SAE for WCC?

Agree. Just whipped up a first draft and this came out. Maybe I will make 
it a series, because there's more groundwork to be done like exporting all 
fwil functions and probably inlining a few to limit the exports.


Regards,
Arend



--000000000000d3039e060d1431d1
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDYYsoxYnoNJpNwh93n
jfMQI1rAFK3KLRZZER0WvtrPfjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEyMjIwNzMwNDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHnXf+ZBXAP4P6k1NVepqKoUEeWtImGstWh/E
Lf0PpArKlxee+xG95h4DQobXVA2PBvDapXZ+7vDNshi80ACuFL26NH1+c3Ay/2WxZ+VisNI7oSe1
G9YvmUDUhFJLfRtkSrk2wAl+n5bb8DRFGAuCFNE84odjgvl3f/yGE9QGwnT9O13uh3wPJ/5UUoNw
2A6WiRf18lsi1LhTEZujXyk3vCTtPmli6ifkweUDzFJvIhthOC5dJkVXu94z78Z0tDpDx/VFyqFi
bn1N7JnQQosZdWOxguOWNup4Vbmwn2r4kooUz+6qYcFe/V22OGuQwiSD+nHuJT2dYL0aKIWsAaTh
SA==
--000000000000d3039e060d1431d1--

