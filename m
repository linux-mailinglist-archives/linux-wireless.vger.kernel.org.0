Return-Path: <linux-wireless+bounces-27892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA3BC6537
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 20:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5DD3ABAF1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C611E834B;
	Wed,  8 Oct 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cEUjFIoc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149823CB
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949253; cv=none; b=skSVdMp6eug2crSNk+bRCAeqO/P3uV00B7qMqu+iUbbtvdia2MsEtif0c6CRrEgTLos4n+biZ8Zk3RRx+Yjb9KLTLlfXCq3Ql0lx2Am+ZtmmmdFhqQKZY+2QLrkTfSxQ6v30EFRzKjdGjJmAZtIexL025D5GSP8KXs8kj8XrhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949253; c=relaxed/simple;
	bh=oARGZ/Uigev2OUQjparhkqsJ/8B0Bc9qqzIxWuZfA+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqGjVrn9kZgv905M9oTTq9FGLVdxxywOBDeb3rsabzMn+RFZE8Ad3klfgset/+mFNThWuF8unuSgbuP8f+VxfH3GkfcP5gguG5c41dSSapstALUblPFClqDWZCRL/Vkp/Qcp1DiuPrNL5QT3jVXR/L/WcJTe6h0nR6kRqmV2EI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cEUjFIoc; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7811a02316bso89449b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 11:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949251; x=1760554051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwOortMTHEjR5fNshyp9JXt7EgfSopghsEteNp61B+E=;
        b=dIcFAnpK91QhlOw7AVaH5QG0JtcPMqVrTPghWlG5aV50b1tbQOGUMZpK+/ZfzL2k4V
         wBJQZ4lFnnhTcPkeQ81x4Ztm8+bWIS8UPuFuUipVLeN8tuDunPSuAeDYdzAMGG22M7x2
         Wu2LdMelNVgIFuTaN2OfNYDsBDXkCv9QUYCUntSXciLXVk0umbj3vwwEfVuQ5/0d/Qzv
         xCd4wuJzL9e+szSivGXzRi4WkTlr1z30a3641bRc1w2XxaGXw5iGYMX6fiF8UzEFXwLv
         xSf+fpvoiM9boi+1WAdf0SfY0EznfHUOufhwfNRKxdi6fdDr7wR+SFeKmhNhX8zXtbE4
         9NiA==
X-Forwarded-Encrypted: i=1; AJvYcCWOBjcNHhvsiv6yVx12W8LvVNeQbtzF+PXDZEnwkrsu+Gd/fOavKmEASIjp//ewbMheIgLZDdwE0WHS4DSFZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+D1Vk70pHFckfQJT4US7aSMiVRlla4knekbWSfRc2zoLp6cs
	A/KBEbaQJYhxx+mpWsLC0G9PSIf8IWCH1rG0dpU0DYBtdCdMYCj7w/aELkRLSrZt0MfBXAuD8am
	CIJSGenJOv+45qYGxrNWnpk2mIg8JoF3CBpc8/ibfav5yGui/9kOvZS1vsboFeD5juaZtvLiy1b
	wg9pOd7MxvzjInnHJoU2lpTjZpNthMLr2rgwwbaUK0rNk9wwSuYTfjOqHVwTFn0ln9vCGSn3qpQ
	fQllk18kWOVeLhkMXNIAR6mRuni
X-Gm-Gg: ASbGncuwbnupTv4na5SUGPo2c1cJSRfix/pkj71/FWESaMLFOrWgHe/uR+bHOgiiHFq
	zIjPJgFFWmY2BRP/J95U9c6S+3Sbeqlr99IUJ3Ui0Z/0zFhDgOzqUdwSe0UMkeF3Hj1+tCIRwrR
	qwt4atfVl0931hx5qlKm06be/nKBh0QEIuxrG+3El8Ly2kIP1FxCbLLAh8o6k41F8yBBqbdCn1K
	VRBwjpy/Ola45S08kHOo4GhGSEPmaJUL57pK1TUF48IpME6ZEaeOZxUU0j9FNhujd3jPq2xA1tt
	Q3n4Mcj1esqqLQoIvUBRskgfkSnZicdOnOSLsqIUNXDAzC8b79+M98YFDOTSYeBKVv4mhAIpc2O
	4wGh3/gtEJqAWoiOCxpgyT0TvvX1aMG27aMjx2iMPnO2dC/wTXYSqLIkBJTHb8LFI4c5BZCq9Ad
	0vFLD9AMbs
X-Google-Smtp-Source: AGHT+IFEISQLIvLu3ZlRMOtFGwhXaRsddSKDkV3daxZ3J1Zqkq8ibhGtr4/aLpPrDMGrZmXzv6/Qp/JMJ2ro
X-Received: by 2002:a05:6a00:4fcf:b0:781:1916:c5fb with SMTP id d2e1a72fcca58-79385ddc921mr5769745b3a.14.1759949251086;
        Wed, 08 Oct 2025 11:47:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-794d54ef749sm43713b3a.7.2025.10.08.11.47.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2025 11:47:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8645d397860so61099785a.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759949250; x=1760554050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kwOortMTHEjR5fNshyp9JXt7EgfSopghsEteNp61B+E=;
        b=cEUjFIocEwt0LglzCo5v3mbDdw0EJIzdZTbhFwUV30ri9TWsXlWCurvr2aEJDa/CZ9
         ORnmSUbMdlZs7zfT0OiUXxRGsQNIgqVPVwKb1N0YyFQgT41IRvdPjQ7/w5+IlPlDPN2R
         0WuVE45IeZCluKqrIUcZLzvrSrghyezabEaes=
X-Forwarded-Encrypted: i=1; AJvYcCUC4VhzwoiB/0YFLFSpNb6KnnlUZlbrxYNQ/aI8SOKe7L1ocQj6a1ZfedAqh7wEjxVUl7nEimWQhrJGoWj0dA==@vger.kernel.org
X-Received: by 2002:a05:620a:2849:b0:828:984d:f44 with SMTP id af79cd13be357-883546e1988mr800250585a.73.1759949249484;
        Wed, 08 Oct 2025 11:47:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2849:b0:828:984d:f44 with SMTP id af79cd13be357-883546e1988mr800245485a.73.1759949248911;
        Wed, 08 Oct 2025 11:47:28 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ad8f2sm48229185a.20.2025.10.08.11.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 11:47:28 -0700 (PDT)
Message-ID: <77ace9a0-ca88-473a-85f3-967d90f28411@broadcom.com>
Date: Wed, 8 Oct 2025 20:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Richard Reigh <richard@govivid.ai>, Stefan Wahren <wahrenst@gmx.net>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org, chris@streetlogic.pro, s311332@gmail.com
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
 <199aacd7e50.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d1510cb6-a613-4e22-91aa-4fee1fdfa29b@gmx.net>
 <1bb08036-2569-454a-bd26-f1d713b4c299@broadcom.com>
 <f0352cba-0810-43c3-9c53-baa012f93513@gmx.net>
 <CAFwtOaWsS5U-gb3=DM0QZ6MuZgAHV-O-qLtC9-npQEjGsog1AA@mail.gmail.com>
 <281c880e-9e7b-4826-a275-0d02a040a37c@gmx.net>
 <CAFwtOaU3tDrKhwdAGi=C0-YJiZJzatBQiRRjsLQSiGC_4CUWPw@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAFwtOaU3tDrKhwdAGi=C0-YJiZJzatBQiRRjsLQSiGC_4CUWPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/6/2025 8:37 PM, Richard Reigh wrote:
> On Mon, Oct 6, 2025 at 12:28 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>>
>> Am 06.10.25 um 19:08 schrieb Richard Reigh:
>>> On Mon, Oct 6, 2025 at 10:47 AM Stefan Wahren <wahrenst@gmx.net> wrote:
>>>> Hi Richard,
>>>>
>>>> Am 04.10.25 um 11:22 schrieb Arend van Spriel:
>>>>> On 10/3/2025 7:02 PM, Stefan Wahren wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Am 03.10.25 um 18:00 schrieb Arend van Spriel:
>>>>>>> Op 3 oktober 2025 01:20:21 schreef Richard Reigh <richard@govivid.ai>:
>>>>>>>
>>>>>>>> When iPhones query network information via the WiFi settings "i"
>>>>>>>> button,
>>>>>>>> the brcmfmac driver crashes with a NULL pointer dereference. This
>>>>>>>> occurs
>>>>>>>> because the P2P device vif is not initialized when handling certain
>>>>>>>> action
>>>>>>>> frames.
>>>>>>> That does make a lot more sense than the line that gdb gave me with
>>>>>>> my driver rebuild attempt.
>>>>>>>
>>>>>>>> Add NULL check for vif before dereferencing in
>>>>>>>> brcmf_p2p_tx_action_frame()
>>>>>>>> and return -ENODEV when vif is NULL. Also modify
>>>>>>> Now I don't think it is necessary to bail out here. See my
>>>>>>> suggestion below...
>>>>>>>
>>>>>>>> the retry loop in
>>>>>>>> brcmf_p2p_send_action_frame() to stop immediately on permanent
>>>>>>>> failures
>>>>>>>> rather than retrying.
>>>>>>>>
>>>>>>>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>>>>>>>>
>>>>>>>> Signed-off-by: Richard Reigh <richard@govivid.ai>
>>>>>>>> ---
>>>>>>>> .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 +++++++++++++++-
>>>>>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>>>> index 10d9d9c63..2c73156fa 100644
>>>>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>>>>>>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct
>>>>>>>> brcmf_p2p_info *p2p,
>>>>>>>> else
>>>>>>>> vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>>>>>>>
>>>>>>>> + /* add NULL check */
>>>>>>>> + if (!vif) {
>>>>>>>> + brcmf_err("vif is NULL, cannot send action frame\n");
>>>>>>>> + return -ENODEV;
>>>>>>>> + }
>>>>>>> Instead of giving up and surrender we can use primary vif, ie. p2p-
>>>>>>>> bss_idx[P2PAPI_BSSCFG_PRIMARY].vif:
>>>>>>> if (!vif) {
>>>>>>>          brcmf_dbg(TRACE, "no P2P device setup\n");
>>>>>>>          vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
>>>>>>> }
>>>>>> this looks much better. But the whole patch needs a fixes tag.
>>>>> Sure.
>>>>>
>>>>>> In case this issue is reproducible before Linux 5.8, the tag should
>>>>>> reference:
>>>>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
>>>>>>
>>>>>> otherwise it should reference:
>>>>>> d524d5ce3655 ("brcmfmac: p2p cert 6.1.9-support GOUT handling p2p
>>>>>> presence request")
>>>>> Both good suggestions. Looking at the code I would say that
>>>>> 18e2f61db3b7 ("brcmfmac: P2P action frame tx.") is the best choice.
>>>> thanks. @Richard Do you plan to submit a V2 patch?
>>>>
>>>> Best regards
>>>>> Regards,
>>>>> Arend
>>> Stefan,
>>>
>>> Yes, I plan on submitting a V2 patch, after I finish testing the change.
>>>
>>> I will also add the suggested fixes tag to the patch submission.
>> Sure, take your time.
>>
>> Thanks
>>>
>>> Thanks,
>>> Richard
> 
> Hi Arend and Stefan,
> 
> Thank you for the feedback on V1. I've tested the suggested fallback
> to PRIMARY vif, but unfortunately it still crashes with a NULL pointer
> dereference.
> 
> The PRIMARY vif itself is not NULL (confirmed via debug output), but
> using it for P2P action frames causes a crash later in
> brcmf_p2p_tx_action_frame(). It appears the PRIMARY vif may not have
> the necessary P2P-specific structures initialized.
> 
> Should I:
> 
> 1. Investigate which specific pointer/structure is NULL when using
> PRIMARY vif for P2P operations, or

I would be interested to see the log of the "PRIMARY vif" tesing if you 
still have it.

Regards,
Arend

