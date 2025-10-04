Return-Path: <linux-wireless+bounces-27804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71219BB8B8F
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 11:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0365B19C17CF
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5C2580DE;
	Sat,  4 Oct 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b2pjOV45"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410922D4C3
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759569745; cv=none; b=tqq8sUHMwl8lxsEzxrMw9d/rX+NFnqm7IlX58viDW/89YM07LD2nGGVpp9hSRoURKO7BfSPHevaD5l/DWCuq7VoqToaxNmlAbgeLzW2hKlQKw/34TBqk+0u0JxCQ7H1vEoAAmkLHYvimMh3vRgFCsBviDqtbhDhM7jXtVgxftws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759569745; c=relaxed/simple;
	bh=ZmyMGfMZ+K2xxoVKJqoVBAY7ECrLP6O6Bcf4c/6rrMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M21N8iRMAWH/l9ro9une3nmoXqX/WWuWGOZZgTeSMR5wv4vf21nupI4Av0wj1vu4Sv1UMhvwOIqondpbbcEvaYCJ0vFiF/AxcYwcn2vg1mJAGIV3SSHjo54Sm8apMfScd/yxOf19z84rndtGJR4WvprAtPLAK/uiMbMlBcFtfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b2pjOV45; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-8e261568020so657630241.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 02:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759569742; x=1760174542;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gmE8pFoMdkdE0KelxB23jm1mbZIhWP+s1H/ee1V/VY=;
        b=arLF4twBmzG24fjKdFIIbUJsZ1M0tus3s3AXhIDmhPDpONevr7Ie3NK8D9bVrrnJvG
         JJnQPiT3CiUZJ7ukp63U9PTANjGDksMWo/TUq5mhGJr7drgzXBvAVcTTJ5TblWc5a7Sz
         HnwzDnr7Bf9AQyiapbgdMvvqr6oO0SqcsKEBzG/3sbj7/ifIMbXj9JFD/qSNJFK90Tti
         fhOSBHS56Cdm0qUky/ijzF1XUajNMm2JIfOWzYOJ23aucEGsv1YNkhS9GsAJXfGnxEM6
         mR5pLbbwBgxYWhdMOCWJ4mVBVo/wOyyT8UUOKwIGe4ovUhxEEw24hSHaemn8KWfOscOy
         YhYg==
X-Forwarded-Encrypted: i=1; AJvYcCXg42TzN4YPFfv258oCqZfArXutyDeilKlh/yAVdHKMu3e2g8crDbc0FvGZYR/L7Nhp3StjM6ZR9m2dRMsrhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78/8rucB0u81jx6apTganTamBmorc15EVEjvVzLTMIwX0ANTv
	VJUMMcSMe7iDTT8H452pVvVarMV8McNkmh55OugYcWaqccUJ0UlCY2m6QhPTEdPUwS0j6jdK2X8
	0ikAn1vb27j7eq5vI+3D0CpHjOhEamnZBmTby+uhGtNICxAksyl9SPri1nN9r5VZqrKtdqdwDaZ
	6fCZr0D0xiPe+W5yUn7QxTEbtjH1YwaWbhPnvCaOczrFhhIP/cLde2DB2MwFDEV8+DpPZ9ZaVcQ
	Ms2zr19UK0fvSfhiAZfECeZ/eXt
X-Gm-Gg: ASbGncvc1ii4HyHcoWdOPvtJw95NHhzcCXVDp9w87zUlpX3JdfYE9AIqLF97YmwsRSF
	VH6wcadEgLCkcHqcByFUADZF20eKGcV+hvC8jLbkpPEHHexorUJT+6mJpS/p3qQpfKDYzKOYN8U
	d8rfdL27ZjFjCyAVg4YRdY2TRdWLizd5XCFHsGSu/gEM8IEilCdZMF4SXbB8tUn6sm4aXyIuD2r
	g2z7G3AMwlb+4bt011uP8p2qfQXsp5WmbPY4qWEV1ly7Gs7qr+UMDU6uRRRpcn99V2pVO97WPWS
	1S3UWw7b7Za3M/TM+ngenPWLXCBOBURSdt3+AwgisylGKdHaOdlNkMOXdr7yl912gIk9vboOOiG
	F64C08lYbUWcS5xFKkhIvR1QaLlofTAtdZEihU7HeH9atrgm3Hh6hKMgO5vv+3/wK9WIHKCOr8i
	ENqEJsMX08
X-Google-Smtp-Source: AGHT+IGserGyTwXPg+m5Hm6KQTtBLxBXA0cP2p808rRNnXcu+5oZ5zkXgXSq9M41zvz3XrBr2RjOT8E0v6hC
X-Received: by 2002:a05:6122:251e:b0:52f:47de:3700 with SMTP id 71dfb90a1353d-5524e89b027mr2048946e0c.5.1759569741760;
        Sat, 04 Oct 2025 02:22:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5523cffacc7sm716675e0c.3.2025.10.04.02.22.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Oct 2025 02:22:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6394a37e473so1805728a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759569739; x=1760174539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE8pFoMdkdE0KelxB23jm1mbZIhWP+s1H/ee1V/VY=;
        b=b2pjOV45rH3X6uZuhXvcjuBm79wJxdm0zrVJf9oGyXPWcs8ON3g6SOKh++/GSePUA3
         OpupE+2RpbB6MfxUVrxzSkh1z0gfoCmt4MNI7ShXoFb4vyJf3uhTWZ9ixRzXrwwkAJ+l
         1X1OJgt17aF1z9Od6MQ+VprCHAT3FvznG2R+w=
X-Forwarded-Encrypted: i=1; AJvYcCXOg4CDJ5wRVwnNcD8e+NBbkrLVYkjc+MYukxwXhQzwuOLIxZsYdcOqenKgqf7GOZYZ/nt8PEdzBgKV40q9hg==@vger.kernel.org
X-Received: by 2002:a05:6402:3484:b0:634:b3d3:70f9 with SMTP id 4fb4d7f45d1cf-63939c27455mr6163405a12.28.1759569739546;
        Sat, 04 Oct 2025 02:22:19 -0700 (PDT)
X-Received: by 2002:a05:6402:3484:b0:634:b3d3:70f9 with SMTP id 4fb4d7f45d1cf-63939c27455mr6163381a12.28.1759569739121;
        Sat, 04 Oct 2025 02:22:19 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b6927sm5860587a12.14.2025.10.04.02.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 02:22:18 -0700 (PDT)
Message-ID: <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
Date: Sat, 4 Oct 2025 11:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Stefan Wahren <wahrenst@gmx.net>, Richard Reigh <richard@govivid.ai>,
 s311332@gmail.com, chris@streetlogic.pro
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
 <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/3/2025 7:02 PM, Stefan Wahren wrote:
> Hi,
> 
> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai>:
>>
>>> When iPhones query network information via the WiFi settings "i" button,
>>> the brcmfmac driver crashes with a NULL pointer dereference. This occurs
>>> because the P2P device vif is not initialized when handling certain 
>>> action
>>> frames.
>>
>> That does make a lot more sense than the line that gdb gave me with my 
>> driver rebuild attempt.
>>
>>> Add NULL check for vif before dereferencing in 
>>> brcmf_p2p_tx_action_frame()
>>> and return -ENODEV when vif is NULL. Also modify
>>
>> Now I don't think it is necessary to bail out here. See my suggestion 
>> below...
>>
>>> the retry loop in
>>> brcmf_p2p_send_action_frame() to stop immediately on permanent failures
>>> rather than retrying.
>>>
>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>>>
>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
>>> ---
>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 +++++++++++++++-
>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>> index 10d9d9c63..2c73156fa 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct 
>>> brcmf_p2p_info *p2p,
>>> else
>>> vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>>
>>> + /* add NULL check */
>>> + if (!vif) {
>>> + brcmf_err("vif is NULL, cannot send action frame\n");
>>> + return -ENODEV;
>>> + }
>>
>> Instead of giving up and surrender we can use primary vif, ie. p2p- 
>> >bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
>>
>> if (!vif) {
>>        brcmf_dbg(TRACE, "no P2P device setup\n");
>>        vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
>> }
> this looks much better. But the whole patch needs a fixes tag.

Sure.

> In case this issue is reproducible before Linux 5.8, the tag should 
> reference:
> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
> 
> otherwise it should reference:
> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p 
> presence request")

Both good suggestions. Looking at the code I would say that 18e2f61db3b7 
("brcmfmac: P2P action frame tx.") is the best choice.

Regards,
Arend

