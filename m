Return-Path: <linux-wireless+bounces-16474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2FE9F4CC2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 14:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5401162944
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A331EF1D;
	Tue, 17 Dec 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kwsnvvq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608894A23
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443259; cv=none; b=H7v0F2YgOzcY9mxB6G3TvpsP+zaYx9r0eHR/BWG6ZB5Fp5D5L+TKqMg6lM568spX9yF/KlnocxsMsmRcBmCkYTk1wz78LYaCFbO+nOh/A6iL5ySBQ17rX957xABLYWCbiZ7Xbdg6HsJBYolFxftE+iCBuYoFPp9/xWlJLrV2KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443259; c=relaxed/simple;
	bh=QPYAQujeLc+sZ++Hm5Q2SUar+FH/gKDhR2nAsfF31+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQH+rfYEgQX6ZM/kgIGwaQlo/0+wHz4+FjNkzv6NI7aCvj7y4YdbA8o8kGpTqVTy1PiO6sSNqLOiHmtuR/3dOoc1XMpSqdkvHFIMBd5whTzR/RjU+MITmMTlmN0/4qCwW6xHu+m1s7K94qCyPEBQq1P2swZkJU4DTYjt/khz45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kwsnvvq9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso39692965ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734443256; x=1735048056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y657ctG9meyp3qn03fBBJBlI5XMwlxpNahazuTFD7E=;
        b=Kwsnvvq9AlE9jAAqwc83wCTSLowX8wN8H3rSpHBVH8BT0MWwLKjv1KDrzJOrrG3ReL
         a9hDiq/eTDv5VqGe/zuDIwkhoLlmiMDlqYY9kddrqy+sxyUtf4+Br1KC8Z16HudTgxY/
         4TiVQSN1n30xnXYGQdexzDjmhAW05h1VyGOsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734443256; x=1735048056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y657ctG9meyp3qn03fBBJBlI5XMwlxpNahazuTFD7E=;
        b=Dwby5y1U0v+Sjj+AKeJLm6/7uNXz9w6BbjtvRA5RqTWMoWGIzL9AdD/5FeqzIRTlue
         R4GkEo00GHoTk+cHia1Qpax1bT+PAgfmMdtYadc+C5TwpF2sspgCe9gXkZHxyIvv+mh6
         6P7RZIU5c11K6/Dv9SgkQ5Dpb/v6g8dVqv2dlhqVrWMF4LzwDs2sBWutybQr06+sAtl8
         JFc8AQYriHhJ0JbpNo9j1AWAXhckR5kTFJUFUzxrpilQqW2pBMxcm8b5LC/tVu+FMjZn
         quIodCWjCmA1XRptjnO4ycIQIz7HMSdo+78gErn9LvGBxZnjJADDPuPG/1SZzFkVQ4Fr
         dZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyN4GVdmdg7ywgcXEWld9yUv2b0qH2b38tWUflfp+gh4HjhIzEYAzkjwnBqtYeu04mjvpQKtPWHQwOA4QFvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCRa1XrOtHfjXqaozA2GS0HC9DoLNeaqjtJH6X2t4WcgsYtYR
	1sWtRrDjlMiTbIoxR2yikfQhITVkWaNGnEtC0xkn+TCSoigZ3Yv6Wb9vWpiygA==
X-Gm-Gg: ASbGncs9n0T8RWZ4zO3ywBS48s1BQMKPTL+9kT8CcULHMMNN3l4g2V1lVFvd3BrUpCi
	H5CxkYZLKKj5xNV87g7TG5C+sExGGH439c1PiFvbq8SRFJGf9rAiWBYna6Kyjgb/z5Apx+Z/T/s
	E7qGYmewzDBq9sZ2m7cHB8SOjjDImsNf1gsBIGDnJQX6EKziZKArye6r8vvYYdC7GIcloZyqKCA
	iTz3bwZW3HTCxypk0kXcfOxcoC0ab/1wamT14qdMxfbN4jrw2meHE4A16QhpzK8Jkf0CzDgaFPn
	PNdqicQ=
X-Google-Smtp-Source: AGHT+IFFTAppFFfoI8UrpYTs/5v8h3zIZUD0SIZ/23qoiAwzBJ61guRTsJCS8zjzOBosLeNMTDVs4g==
X-Received: by 2002:a17:90a:e70d:b0:2ee:df57:b194 with SMTP id 98e67ed59e1d1-2f28fd6b922mr21114490a91.21.1734443256495;
        Tue, 17 Dec 2024 05:47:36 -0800 (PST)
Received: from [10.176.68.94] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daed8esm10049236a91.19.2024.12.17.05.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 05:47:36 -0800 (PST)
Message-ID: <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com>
Date: Tue, 17 Dec 2024 14:47:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: KeithG <ys3al35l@gmail.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com>
 <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
 <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com>
 <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com>
 <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com>
 <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/17/2024 1:13 AM, KeithG wrote:
> On Mon, Dec 16, 2024 at 1:50 PM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On 12/16/2024 1:21 PM, KeithG wrote:
>>> On Mon, Dec 16, 2024 at 3:47 AM Arend van Spriel
>>> <arend.vanspriel@broadcom.com> wrote:
>>>>
>>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
>>>>> On 12/16/2024 1:17 AM, KeithG wrote:
>>>>>> On Sun, Dec 15, 2024 at 11:33 AM Arend Van Spriel
>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>
>>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
>>>>>>>
>>>>>>>> On Sun, Dec 15, 2024 at 6:12 AM Arend van Spriel
>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>
>>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
>>>>>>>>>> Arend,
>>>>>>>>>>
>>>>>>>>>> I looked through the info where I got the latest firmware:
>>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-
>>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
>>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/
>>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
>>>>>>>>>> and did not find anything, but I really do not know what I am
>>>>>>>>>> looking for.
>>>>>>>>>
>>>>>>>>> I think I had a bit more luck and maybe found the needle. I sent out
>>>>>>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Arend
>>>>>>>> Arend,
>>>>>>>>
>>>>>>>> Can you send me a link to that patch? I want to try it.
>>>>>>>
>>>>>>> Hmm. I explicitly sent it to you, but here is a link to patchwork:
>>>>>>>
>>>>>>> https://patchwork.kernel.org/project/linux-wireless/
>>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
>>>>>>>
>>>>>>> You can apply it on top of the other 3 patches.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Arend
>>>>>>>
>>>>>> Thanks! I got it.
>>>>>> I am building now and have tried to apply what I think are the correct
>>>>>> patches. They do not apply cleanly and I had to hand edit things. My
>>>>>> guess is I messed something up.
>>>>>> I will see what happens when I reboot. It'll take a few hours to build
>>>>>> on my Pi4 then for me to install it on the 3b+ to test.
>>>>>>
>>>>>> I hope I understand which are the '3 other' patches.
>>>>>>
>>>>>> This is the one I got from your link:
>>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>>>>>
>>>>>> These are what I understand are the '3 other patches'
>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-
>>>>>> firmware-events.patch.diff
>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-
>>>>>> station-mode.patch.diff
>>>>>>
>>>>>> If they are not correct could you send me links to them and I'll try
>>>>>> again.
>>>>>
>>>>> You got it right. Kuddos.
>>>>
>>>> Ignored my spelling checker, but apparently it should be "kudos".
>>>> Another lesson learned today.
>>>>
>>>> Regards,
>>>> Arend
>>> Arend,
>>>
>>> Thanks for the confirmation. My attempt at a hand edit to apply the
>>> rejected portions resulted in a failed build with the current RPiOS
>>> kernel in the git repo:
>>> # uname -a
>>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST 2024
>>> aarch64 GNU/Linux
>>>
>>> When I try to apply them, I get this:
>>> $ patch -Np1 -i
>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch.diff
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> Hunk #1 FAILED at 6752.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>> Hunk #1 succeeded at 524 (offset 33 lines).
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>>> Hunk #1 FAILED at 1359.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>> Hunk #1 succeeded at 74 (offset -1 lines).
>>> Hunk #2 succeeded at 336 (offset -70 lines).
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
>>> Hunk #1 FAILED at 15.
>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
>>> 1 out of 2 hunks FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
>>> $ patch -Np1 -i RFT-v2-
>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch.diff
>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station-mode.patch.diff
>>> $ patch -Np1 -i
>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
>>> Hunk #1 FAILED at 337.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
>>> $ patch -Np1 -i
>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station-mode.patch.diff
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> Hunk #1 succeeded at 75 (offset 1 line).
>>> Hunk #2 FAILED at 1940.
>>> Hunk #3 FAILED at 2158.
>>> Hunk #4 FAILED at 2216.
>>> Hunk #5 succeeded at 5522 (offset 22 lines).
>>> Hunk #6 succeeded at 5697 (offset 90 lines).
>>> Hunk #7 succeeded at 6126 (offset 125 lines).
>>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
>>> Hunk #9 FAILED at 7647.
>>> 4 out of 9 hunks FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
>>> Hunk #3 succeeded at 243 (offset 15 lines).
>>> Hunk #4 FAILED at 244.
>>> Hunk #5 succeeded at 507 (offset 18 lines).
>>> 1 out of 5 hunks FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
>>> Hunk #1 FAILED at 8.
>>> Hunk #2 FAILED at 39.
>>> Hunk #3 FAILED at 49.
>>> 3 out of 3 hunks FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
>>> Hunk #1 FAILED at 42.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
>>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
>>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>> Hunk #1 FAILED at 450.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
>>> Hunk #1 FAILED at 94.
>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
>>> Hunk #1 FAILED at 15.
>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
>>> 1 out of 2 hunks FAILED -- saving rejects to file
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
>>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>>
>>> Is there another missing patch?
>>>
>>> The kernel for the RPi is at this commit:
>>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6.y,
>>> origin/rpi-6.6.y, origin/HEAD)

So what repository does origin refer to. Can you share the URL?

I will check if I posted any patches between 6.6 and 6.10+ Get back to 
this later on.

Regards,
Arend

