Return-Path: <linux-wireless+bounces-2220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA08324B4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 07:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E0B1F230A1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA36320C;
	Fri, 19 Jan 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ft6+n/Wh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA673214
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646157; cv=none; b=eGRSSvK96boM8J3/uC437JZwA4xDGeYj9hgN5lbUCofzN/0TN8x0a/ckpNfPwvnDrjVuh2+mQ281K50UiShFj4qh7ekAp6mFAXxPCrjGgdfQ6e7IS/jMC8uJAte5wCsw3HaPwr2AGbg5VigJ3eO4m+f2k06kpFjqhk+Jv0u4P9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646157; c=relaxed/simple;
	bh=eX7xvem+lh/3zjxlSzDTlKoqF5bj2vzU0ZyZxoCGmFg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hIXvjU/Drjom4y1kuGhNXQhsDpT4FJ71OG8xSYmelY+q+qH/VIv38xI9XTbtf7cTeRjePx0qdPRwljFqBNzka09i30VKYuHi7ST8qtLD6sHQmY+blrX6IRi3pXeEliWVK4I/9h1uyFTNXnz99hstfaG5y+cGKGf3c7YrelWuuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ft6+n/Wh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e9e96edd1so2209005e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 22:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705646154; x=1706250954; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFhZxqU4qqtsRxDjH+i9san8h283XauCvxabB4jBrhw=;
        b=Ft6+n/WhZdSWiTGPNIZg+i/Q+1l54GOEBA2sAfPLBoEwSfXo3+EzAMI95T5XzcfiR2
         caeBTeugrxhb1B56mcazVRqOHF3XdDZpH4x18zzOg3Yva73/5Ddx9TF1TbxLxvS5oYuq
         sHwQuTdZyPquhCqi9Sv1HU5YzqE2UFbpugvhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705646154; x=1706250954;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFhZxqU4qqtsRxDjH+i9san8h283XauCvxabB4jBrhw=;
        b=Ri56h20QbhUaLMt9L+99Fs5SPJHfaTQECkcRfExeCSlb9Ah+O4T0fZ6FFRM1GsWEqd
         l941hKjmDEVcI79zDwZgDMXB8NMU4gLdEa9SBBCxjUIrOy7qH+RWBlxk5KN+hqSAz8BN
         TwsdcL7pMFpSMtDaLuvjOIzMW7kSLrKOjsvJOctPZyhGCrrT7MBB3YsBjve2lmWLb3nh
         qIduZCJ68aPY67ibjEshOny8nuXtMmbZz/QdwwIv9e4lXchPQC7UhDy9HAAWpkja0YEY
         lol30oeTRAzPYCuSnbQxQPaTZG4ndHAC34/Caawad4TgoMfp26UxTCyMZ3Y92JV3cmcS
         eK3g==
X-Gm-Message-State: AOJu0YxywH4ikv0niHmllvOYaoZo5Ahm3AsYjnHZgsc1z64Ml6MMRQyJ
	pINL/j6VakeHGHOLARc4fUDyz5qH8VxPJQoZ4KCyGXR+LDAbKgEIER1BBSxlOQ==
X-Google-Smtp-Source: AGHT+IEBPzwOZezXGXSCWQ9BDRSyPsVeJyLbriUCMGFPDHfdG7/87MipBNjjM+5QVs9CprSmp3eOjA==
X-Received: by 2002:a05:600c:253:b0:40e:4913:58ad with SMTP id 19-20020a05600c025300b0040e491358admr541847wmj.371.1705646153996;
        Thu, 18 Jan 2024 22:35:53 -0800 (PST)
Received: from [10.230.35.166] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d5903000000b00336c43b366fsm5668425wrd.12.2024.01.18.22.35.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:35:53 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kees Cook <keescook@chromium.org>
CC: Atul Raut <rauji.raut@gmail.com>, <aspriel@gmail.com>, <franky.lin@broadcom.com>, <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel-mentees@lists.linuxfoundation.org>
Date: Fri, 19 Jan 2024 07:35:52 +0100
Message-ID: <18d206ed558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <202401181217.1D75C32E@keescook>
References: <20230803052238.12147-1-rauji.raut@gmail.com>
 <20230803052238.12147-2-rauji.raut@gmail.com>
 <f739cc15-dade-4f69-a17a-30242026c099@broadcom.com>
 <202401181217.1D75C32E@keescook>
User-Agent: AquaMail/1.49.1 (build: 104901407)
Subject: Re: [PATCH v2] brcmfmac: replace one-element array with flexible-array member
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000247274060f46b1ea"

--000000000000247274060f46b1ea
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 18, 2024 9:19:52 PM Kees Cook <keescook@chromium.org> wrote:

> On Thu, Jan 18, 2024 at 02:53:28PM +0100, Arend van Spriel wrote:
>> + Kees
>>
>> On 8/3/2023 7:22 AM, Atul Raut wrote:
>>> One-element arrays are obsolete, and flexible
>>> array members have taken their place. So, in
>>> struct cca_stats_n_flags, replace the one-element
>>> array with a flexible-array member.
>>>
>>> This fixes warnings such as:
>>> ./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9: 
>>> WARNING use flexible-array member instead 
>>> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>>
>> I think this correct, but maybe Kees can give definitive answer here.
>>
>>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>>> ---
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> index de8a2e27f49c..fff32e54833d 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> @@ -116,7 +116,7 @@ struct brcmf_dump_survey {
>>> struct cca_stats_n_flags {
>>> u32 msrmnt_time; /* Time for Measurement (msec) */
>>> u32 msrmnt_done; /* flag set when measurement complete */
>>> - char buf[1];
>>> + char buf[];
>>> };
>>> struct cca_msrmnt_query {
>
> Normally a [1] -> [] conversion needs some details in the commit log
> about why this is safe (since it runs the risk of changing sizeof(struct
> cca_stats_n_flags). In this case, there's only a single user of the
> struct, and nothing about its use depends on its size:
>
> #define BRCMF_DCMD_MEDLEN       1536
> ...
>        struct cca_stats_n_flags *results;
>        char *buf;
> ...
>        buf = kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
> ...
>        results = (struct cca_stats_n_flags *)(buf);
> ...
>                brcmf_parse_dump_obss(results->buf, survey);
>
> So, the allocation size is big enough for the struct, and nothing
> depends on the struct size.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the confirmation.

Regards,
Arend

> --
> Kees Cook




--000000000000247274060f46b1ea
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCr4a0w6RFgPsNAyLKR
CdCNzIYmIgdF3kUmKHSjRkngGzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMTkwNjM1NTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABJy0Nj9echqcliFvoq7S0WszMdLL6oRb/lqT
HMdYTkqiAqQeyWMlR8zj0nxXyWdsWEg5zrkSn+V//Gcf4fLsCsjTLXyZo7m2YR0d35sHp1yXP7k6
OWCX8GePBVzI1bmN46/NICpu5jQ3rB93nWucOxg6czMVmlpkNIOFgKXXH8Yt75yqvMtlMS+4pssP
k5KiPdHB9OOAvKziGHIrlE1yh2l6gN0O/x+v3icIBry45HybM12Jzcs9qtihKUcoL2LlGdvPkbaC
f0FfpHaBe51KHPHZ9JfJb380qp/CeGjE/FJTutonSD8821WKyzxInLZDtnMrP9tBkW7aJRN7erMy
DA==
--000000000000247274060f46b1ea--

