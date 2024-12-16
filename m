Return-Path: <linux-wireless+bounces-16408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8A9F2D45
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 10:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF44188ADAE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55D202C2B;
	Mon, 16 Dec 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MJjpQqQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB41FF7DC
	for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342443; cv=none; b=mB7GszzPrt8dmba1wgJZWiNprMSDLVQe2A69gIfqtavGblUTgFCpoMMgmulPSXs9IJ0zTfmxNvKekjdtEteEji2hwxcwwGiV1kuTJx4/AdGexLCn+ddohviWfK777bMAdFXOTJoGutR27n+9YCFGhtv8d4GHPY5R59fPUDRJkJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342443; c=relaxed/simple;
	bh=IRjn40il3SQhE2uIEcMjacNa+gsinEVH2XPdFrjoWcw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AXrvnR5KtakxuzTC1E2efsA0WPwhB6Oi6K8mkSZSVajs/M0FVEgS4yTUGZ/mZ6HenW/9ZIMs/VipBVd2iDjbQRIgrTMIa2W8FRo8s2WcqTbKGOWDg4ZNIHJODfz4ILJuvcwkZp/qJKfdI4MiM/O1fBWmScB59/mYq5DggA83sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MJjpQqQI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so29479515ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Dec 2024 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734342441; x=1734947241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/HCPRB4VyzDsMOFgx4inSgYlFtMRCoevEhML9QepDeY=;
        b=MJjpQqQIl1rp3Ih+0DibFanFeCMq/vh64Az3eVlJhmNobieP9wb9FC4e4V4DffU7JN
         2iTMpGBPP6h6VtCS0xtSQ93ED7JWW98FQ4e42pmKZFHYWMEB3NG8PbQmWsgGhwy7yT9h
         t3c+5/WvAJnnJpS3trSo9N3rIoDZLAR/Rq0Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342441; x=1734947241;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HCPRB4VyzDsMOFgx4inSgYlFtMRCoevEhML9QepDeY=;
        b=CspclzZibj8h0lkibYSYay3faN9qzUjm4SheL5uzIDqJZRYWW6sf0mxYOBV7yzxTi0
         xkuGDXJ+1FHJYU+kDNBXVk5PF57nSHrP8HCZUEXPK9U0d584P1/LG8mfsc3172mrUCt1
         +lo6v2WtBf6ybXYEs0Q6LdBlFIKLcaSJeAJASGSmaFFU5e4aWj8NWDaRSXLwFY1oQjLf
         ayoXqjDPLywHpAEqQkmvPpVByGk4vS0QRKpbiQhKx+XeBpNJjhegkxO06yFV4/9TMdsk
         a1ll6wzXOyRDufjdFt2GEX/eu58YSHM1QB1BAWPbClLylvSHKH0IGhlFzslBjqUJLyIO
         tOSg==
X-Forwarded-Encrypted: i=1; AJvYcCVPhyFdukEjTrCRlz7D5xkAC1JT8BMKyRpHpLRoKphxczlFynojGob4D6eWFVV2pfqep+AMEC3egLCrJmrQpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXzerOitYyVRBvV8Xkys33OS8ZK00FyBDEdQ/s3gK/iheEXFA
	2a/4Gm+L+rSAHGJMI9nuKYMNxVNuDwAzqH73Dlu5HQ8vcLQM3O9pDShe9J9z7Q==
X-Gm-Gg: ASbGncsb7b8yhCX68GPlcSdW8dKSN2oYIz5hVM1CYq4dtvJFTmyWgyqjRyJ7/5gFFJ7
	6egBwptN6KluI+1LhJs+GQEHfrubX54auYZavmaSvezj8Fm7ojw2CC0m9KxzjYKkqNz3p2nA0Y0
	n7QvSp9RuaLXVEJl+yuMxlairn8/HvaOcmHk9SIRDH8AjqP1dQlapRU6ZDMipFPiA/Ig5bleV3J
	kYSihH4Q/c8sHB+lKoulphBMrqxWo6Bvp+UQmmZf3uqCjHcfWf2OmxArqPFtV/1a6cfBJ6g8R4J
	MW0mWlTs
X-Google-Smtp-Source: AGHT+IGpdPX9BY5G4+X8tRNio+DwzD9E2KOs35B0CWfQ1RXsBH/dYk8950ss/BwQXp/Z3+KC1wCJFw==
X-Received: by 2002:a17:902:f644:b0:212:1ebf:9a03 with SMTP id d9443c01a7336-2189298250bmr176045185ad.2.1734342441108;
        Mon, 16 Dec 2024 01:47:21 -0800 (PST)
Received: from [10.176.68.154] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dbaf69sm38920395ad.6.2024.12.16.01.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 01:47:20 -0800 (PST)
Message-ID: <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
Date: Mon, 16 Dec 2024 10:47:16 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
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
Content-Language: en-US
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/16/2024 10:43 AM, Arend van Spriel wrote:
> On 12/16/2024 1:17 AM, KeithG wrote:
>> On Sun, Dec 15, 2024 at 11:33 AM Arend Van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>>
>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
>>>
>>>> On Sun, Dec 15, 2024 at 6:12 AM Arend van Spriel
>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>
>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
>>>>>> Arend,
>>>>>>
>>>>>> I looked through the info where I got the latest firmware:
>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi- 
>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/ 
>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
>>>>>> and did not find anything, but I really do not know what I am 
>>>>>> looking for.
>>>>>
>>>>> I think I had a bit more luck and maybe found the needle. I sent out
>>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
>>>>>
>>>>> Regards,
>>>>> Arend
>>>> Arend,
>>>>
>>>> Can you send me a link to that patch? I want to try it.
>>>
>>> Hmm. I explicitly sent it to you, but here is a link to patchwork:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/ 
>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
>>>
>>> You can apply it on top of the other 3 patches.
>>>
>>> Regards,
>>> Arend
>>>
>> Thanks! I got it.
>> I am building now and have tried to apply what I think are the correct
>> patches. They do not apply cleanly and I had to hand edit things. My
>> guess is I messed something up.
>> I will see what happens when I reboot. It'll take a few hours to build
>> on my Pi4 then for me to install it on the 3b+ to test.
>>
>> I hope I understand which are the '3 other' patches.
>>
>> This is the one I got from your link:
>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>
>> These are what I understand are the '3 other patches'
>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and- 
>> firmware-events.patch.diff
>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in- 
>> station-mode.patch.diff
>>
>> If they are not correct could you send me links to them and I'll try 
>> again.
> 
> You got it right. Kuddos.

Ignored my spelling checker, but apparently it should be "kudos". 
Another lesson learned today.

Regards,
Arend

