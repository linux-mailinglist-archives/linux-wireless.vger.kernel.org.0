Return-Path: <linux-wireless+bounces-4205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4ED86B39A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A925D1F238CD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674E15CD77;
	Wed, 28 Feb 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PrX32Ap/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428A15CD73
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135206; cv=none; b=OT1vx0MC6L/L7FopCSTv5sitcutIj2M4LVEPNvlOm4truyoyNbbCIXqOINZ7zf1k8pL0lSCjGJjBoWRTkFTyqX90bWz6Zm+lWYrxLSQSUX/fQppLZycZB8+czzNeQMB5QG2PJ1WoF2AzfvUGtGLHREz+TKPStmDF9xG/lhuYbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135206; c=relaxed/simple;
	bh=hbfHgygufL3amx161ypDTE9kc1zS58JuL5hZtG29Do0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=etwqU556n0UfNZCIh1n/mc0DffBNYZ9jVKi1IzjXkIxQVJy6T1rF3tilzgtlB076giqY8bvf4P9gtpNEwzpVSfD/m1dOGJkHNUTA57T4jn/irQSV1TiOihMOFRa/2tnAZR2mjMhCHHcccSW+QOPyKWYO6lfKQxwv8uGaAKqO4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PrX32Ap/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d32f74833so3117180f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 07:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709135203; x=1709740003; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9DwaFfbMt4LCxYoG2+3oek0h5cLmIci+nk5YW/mWr4=;
        b=PrX32Ap/+qvLz8QTDRKmjnCpbsjfQS5DNvYTry1j8U19IIA4Vhl8RwFHuB+tFeFyZ/
         lR7aFF/vkFBfRa0P7vLvMfpKApjqU79PvMc3eUwBKclVJ+eUnpJolimArKtWhef6G2iT
         cD9q95JTigGCwUzm2qi15ZMZr2+OO9wPDGh1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135203; x=1709740003;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9DwaFfbMt4LCxYoG2+3oek0h5cLmIci+nk5YW/mWr4=;
        b=u7V5A1QyFqJ/eKWGjbgW7bm3DucvuMYzQP7S85ICM+rYuYc/IycV0NcLW//kpGPd7o
         u6BRto0VUXEcyvu63IrwK+GLjbmFli4hci2Q+fspEwDbarAdR9JLtAk+kBmt/kIjD04v
         jAaHtSJGIF4upcuepHq/EvZMgCJbaqwnyD39nPDbJY9vHn+0b004qmwn5mtNh306bAsZ
         cY9qCX7G1ZQ+/JjZRZc+NSnrfsZiLMtbUwSdywPAxFFEk+9r9hm6lQVIbCTbn82LNmoA
         cB8EFkuglAAHN3lQZrS755xIyZ9A1DorzSP94HFmfU3b3X4G4FgXX2ZikfLWtJM6GKRf
         Wa9w==
X-Forwarded-Encrypted: i=1; AJvYcCUjVOXYz5eQGmg6H9qyrL8RWT+qEIr3e/0il0WjXLv7wfmQzAVFZ8c1WcFhk4M+/LYtILAgeMy3nd53kAHKLHRHEIjyhHDTcNU+wXuVSnc=
X-Gm-Message-State: AOJu0YwXlAamEYvuqFFPtxbmJIsekDrA5fgIvw4d8xaC0E9zy0WPl7U1
	JJq2vFs2N4vvxADDepKjB1XCljGAKfJ/h5mR50HR1GBh1IOiivCUhXlFgydX3w==
X-Google-Smtp-Source: AGHT+IHQN68KE4OEiZrl4HLpjd4rXhK4a01mIb7ofUTAPf156UfR5b+Zs8/4ExnmGn46/Je3C04ONg==
X-Received: by 2002:a5d:6288:0:b0:33b:5f1d:5ef4 with SMTP id k8-20020a5d6288000000b0033b5f1d5ef4mr9108503wru.1.1709135202946;
        Wed, 28 Feb 2024 07:46:42 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id bk25-20020a0560001d9900b0033dd98c518bsm9706734wrb.50.2024.02.28.07.46.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:46:42 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kees Cook <kees@kernel.org>, Duoming Zhou <duoming@zju.edu.cn>, <linux-kernel@vger.kernel.org>
CC: <brcm80211-dev-list.pdl@broadcom.com>, <brcm80211@lists.linux.dev>, <linux-wireless@vger.kernel.org>, <justinstitt@google.com>, <jisoo.jang@yonsei.ac.kr>, <petr.tesarik.ext@huawei.com>, <quic_alokad@quicinc.com>, <hdegoede@redhat.com>, <keescook@chromium.org>, <johannes.berg@intel.com>, <kvalo@kernel.org>
Date: Wed, 28 Feb 2024 16:46:39 +0100
Message-ID: <18df0654c38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <8B696743-9487-4A78-B9B4-16DA4F2F8E26@kernel.org>
References: <20240228063408.7006-1-duoming@zju.edu.cn>
 <8B696743-9487-4A78-B9B4-16DA4F2F8E26@kernel.org>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH v2] wifi: brcm80211: handle pmk_op allocation failure
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aabe890612730c17"

--000000000000aabe890612730c17
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 28, 2024 3:48:18 PM Kees Cook <kees@kernel.org> wrote:

> On February 27, 2024 10:34:08 PM PST, Duoming Zhou <duoming@zju.edu.cn> wrote:
>> The kzalloc() in brcmf_pmksa_v3_op() will return null if the
>> physical memory has run out. As a result, if we dereference
>> the null value, the null pointer dereference bug will happen.
>>
>> Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
>> for pmk_op.
>>
>> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 
>> operations")
>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>> ---
>> Changes in v2:
>> - Drop the new label and just return -ENOMEM.
>>
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index 28d6a30cc01..7af6d6448b9 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -4322,6 +4322,9 @@ brcmf_pmksa_v3_op(struct brcmf_if *ifp, struct 
>> cfg80211_pmksa *pmksa,
>> int ret;
>>
>> pmk_op = kzalloc(sizeof(*pmk_op), GFP_KERNEL);
>> + if (!pmk_op)
>> + ret = -ENOMEM;
>
> This doesn't fix anything. It doesn't stop the execution path; it'll 
> continue and immediately dereference the NULL pmk_op in the next line...

Crap. Do I look bad :-( Thanks for catching my blunder. I was seeing what I 
wanted to see I guess.

Regards,
Arend

>
>> +
>> pmk_op->version = cpu_to_le16(BRCMF_PMKSA_VER_3);
>>
>> if (!pmksa) {
>
> --
> Kees Cook




--000000000000aabe890612730c17
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAB++3izfh2Syu92o+y
vxWJqiRgwsXFP1x4dvDV25qhMjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAyMjgxNTQ2NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoM8k32aNHzKCHaJcwA1jVywRvXOGmAUQzXuU
hHapT1PhA3iUuhQTDPKEs4VviChvQCgzO3dcTomFtqfF8yW/ygsz7owT8IdGw+c/+Cbv7S1atZwJ
DEYd3FZ4i4ZMT9HB5LCeQX7sAUHGoUXlaRW1x9qt8SJVrCJoLgzQmJaMyDMk4RhVCSkWXT0HlEjb
vPtFk57HMy/F6zRTyl3s02qmCPqWjf/A4BmbFhEc/M7dbVQnuBRNZXNBQpM/fmp56WJz0d88cAdQ
a+6m8Ekl9CT0ymxjmuTceCZXcL1JeE+jWX2ffQjH+Wb67vr6KckgeJ6w05IsdW+Eolluv9v5rdHs
Cw==
--000000000000aabe890612730c17--

