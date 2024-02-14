Return-Path: <linux-wireless+bounces-3584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395738548A6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FB62905BF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8318EB0;
	Wed, 14 Feb 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DKlkyPiK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7B18C38
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911064; cv=none; b=SHxWWv8bedjAnk+zDZLIn/GoSIvxYykap1X/R6KailCaVG8qGMf2PaQCO2vY3jXaRJljsMlphB5Np6WHOMo3U7PEdj2EGkcSg34XojeeLH5k9w4fc3XiM/VcIxCL9/lrHoTpnFZ0aOdSz8agUrwg2/dFTnCNbuFeGWBJFyc6JD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911064; c=relaxed/simple;
	bh=iwlDyV6hNSWu2bI84GC40ux1AgBhjzrgvgWcH15Llvc=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DfjkupNNwaPi+M9D1f7zEwYUZw/uFYPR0QKz62/aN9SfQ6cTGpKZedyFNoLrafs/IBjqgDNZTPtPf/IwlmxpNvzEIbw18RmDFOLkGYy/evOFbULrtewoVwxeUFXI5ovVd7EhkBNiPfw5od7SFaV80J/MVUc+Kz67xcbvJxuOPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DKlkyPiK; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6818aa08a33so6377026d6.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 03:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707911061; x=1708515861; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/Q3b4cyNa904y6qFDjk3Dff7m5EnCMd3Emt/9v6mOU=;
        b=DKlkyPiKXEB79x/4GVYvNEbgHrYUGPz7FoQR6+sXyXpFI/WDuGQJ8WHwV9pujrnrvS
         9aqmbPc1oyJJDlqkPFCZIYJAlItidY2oBsKZ6l0blJTKYVGfj/xzm7tdGjlGQfVSnUP2
         k21HhoyOfzk163ZngrGg5h5TBB14O/NMNl1NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911061; x=1708515861;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/Q3b4cyNa904y6qFDjk3Dff7m5EnCMd3Emt/9v6mOU=;
        b=jou6RNaHDuwmI5yzgy82sz8F9dkzw6QeK+tavht3cpQfph5y75SCtfCXnYv+u714rt
         u48rm8Q3Q1g9OzQYDJceJ50CCAJtUT2BGNjZRCCCNvGE9sqpq9fjTIvnuphdwCyPxll4
         g0q711RLmwuRnurI/V2vdgGTNEjGiiVno3zB4eVPU3C1xTiXKXuVXS1D4+Q9z3tikntX
         hT8OBtnHQ2XHhzz+AKNTuJIkEVXENvA701nkCaJPakeaxtLYfTtvfhsHSIuV5K/Ozq6W
         GTNMYCfK0bA+o61kel53MbnYAAU6vU57/vjueEZDhit6dmsaBqV62rhFaP2wZ/DBycz2
         3geQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVdIZ6pT2GiCGmMnrqa41GPvt6rTM9EQQtfeuWecRT+7DPxFn7ge/cl4t5hiAO6/UOXAPTOPVgl0Eg41PMKSoZMLZlbZGWbrON0bEteQ=
X-Gm-Message-State: AOJu0Yw0zHnZW89To9OBTY9bLnEqNzBBG4dUSb+ESosbTPxEEEDA/Uw4
	YydJuzXGjLCGLIPQJKj6+G3I+E2BY8cG4l8PUxNZN7rtYIY6zcVeIepShHBc0A==
X-Google-Smtp-Source: AGHT+IHa0rA74xmqMYo9zSd3n8Gmawv5z76NNPN8prHX4Z7IXiRHtc9kOqWnr+o4oNkyI0+wn3xA/g==
X-Received: by 2002:ad4:5c83:0:b0:68c:cd44:2c8c with SMTP id o3-20020ad45c83000000b0068ccd442c8cmr3380137qvh.2.1707911061369;
        Wed, 14 Feb 2024 03:44:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVve0DJegzdaJtdgMvpmoNcehG6YTqqIoINgQGcVxrxQQxIpJy+/VaXKIO3aTZsO4jfHSHHVYfA3tWpeEMcUyHawSAn8qs6gV0j9dCUMpu1idKhomkCB0ywAjnU8wuHzEMRT09PTw87pofSt9/AUltRy08oGXTq4O1NhSZpCCM=
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id ok5-20020a0562143c8500b0068c9c01d408sm498043qvb.1.2024.02.14.03.44.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 03:44:20 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Alexey Berezhok <a@bayrepo.ru>, Kalle Valo <kvalo@kernel.org>
CC: Arend van Spriel <aspriel@gmail.com>, <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
Date: Wed, 14 Feb 2024 12:44:17 +0100
Message-ID: <18da76e8e68.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <9032fcc0-e2c4-1e97-1eec-02c3727d3b2e@bayrepo.ru>
References: <20240208085121.2430-1-a@bayrepo.ru>
 <170775233602.2851594.8173116143852900695.kvalo@kernel.org>
 <9667b492-d3d3-4b04-bef4-f507387a9261@broadcom.com>
 <9032fcc0-e2c4-1e97-1eec-02c3727d3b2e@bayrepo.ru>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value to boolean
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000023331f06115608bd"

--00000000000023331f06115608bd
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 14, 2024 11:28:28 AM Alexey Berezhok <a@bayrepo.ru> wrote:

> 12.02.2024 19:00, Arend van Spriel wrote:
>> On 2/12/2024 4:38 PM, Kalle Valo wrote:
>>> Alexey Berezhok <a@bayrepo.ru> wrote:
>>>
>>>> In 'brcmf_cfg80211_start_ap()', not assume that
>>>> NL80211_HIDDEN_SSID_NOT_IN_USE is zero but prefer
>>>> an explicit check instead. Compile tested only.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
>>>
>>> Patch applied to wireless-next.git, thanks.
>>>
>>> f20073f50dfd wifi: brcmfmac: do not cast hidden SSID attribute value
>>> to boolean
>>
>> Alexey,
>>
>> Can you do a follow-up patch addressing my comment? If not I will do it
>> myself.
>>
>> Regards,
>> Arend
>> --
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240208085121.2430-1-a@bayrepo.ru/
>
> Hello, do you mean this kind of modification:
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 63f6e9436..d8f7bd5ce 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5269,7 +5269,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy,
> struct net_device *ndev,
>        }
>
>        err = brcmf_fil_iovar_int_set(ifp, "closednet",
> -                                             settings->hidden_ssid);
> +                                             (settings->hidden_ssid ==
> NL80211_HIDDEN_SSID_NOT_IN_USE? 0 : 1));
>        if (err) {
>                bphy_err(drvr, "%s closednet error (%d)\n",
>                         (settings->hidden_ssid !=
> NL80211_HIDDEN_SSID_NOT_IN_USE) ?
>
> If so, I will make additional patch.

That was indeed what I meant. Consider using local variable 'closednet' to 
pass in function call and use for error message.

Regards,
Arend

> Regards,
> Alexey




--00000000000023331f06115608bd
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBFwqX4d60+nOOHJpVk
YrV4eX3P3poA+ZMzTD5UnQrkJzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAyMTQxMTQ0MjFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJx7IICRJ9OPh9ovYf3N8SF/f97vE8OVXDy6R
w8P2oiTWVNkHI2IvLEjchC1+LNd3997naF849jA/2pvqOf+rrefSdXkUS0yCF/hCqnlprdU1QDZ1
zFP/+MN4OixlV1cW3yBfEvP8MiqNsU6Jcd89pROlZv2rw0fye25TXl8RGAvYGEuAgWKEdV+4VVKM
XHXEByBhCMs51+K+TSJiBG+IkvY1ziAI1QggRhQxqQ/KY6Pbo1AcpYnm8BrSxdbFRxTC3XgL+fth
g/8Aph5O8EWnpCe37odWBa/xkSB5MasaTw9SO1d3mlywtFMyUWLQlGQ43/5p2BK/0WLcYnymYbfO
7Q==
--00000000000023331f06115608bd--

