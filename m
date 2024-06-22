Return-Path: <linux-wireless+bounces-9456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B191347C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BB4B20938
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757016F0EC;
	Sat, 22 Jun 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lit3eSVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE9149DFF;
	Sat, 22 Jun 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719067236; cv=none; b=dn/YOqreEnvVDOsxNISmXWXNXN7G+A6+b+W1E6Wn2W2vLlTg++icku9E9FA5nYgAremWZ40E1y5pRLL5eljIbqZnHvA2Lwl8r5AX49+aocAD51w+335ljPpLggRcNJclIvAzRuRkQ8ZnQ/ct/hGYNgiWVc/kxvqEIIdDGmey0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719067236; c=relaxed/simple;
	bh=Q0ksDFS7CReuixIpPxkRe47dyKFB6+Rqury9eTqmSYc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=W0m0pgEuaaOfNFs24+R9sbPRBSdq3zCtDlGSnNgfJz3ej7hXpG0Iic3FWybAew78hM6JER5U7KfsBGN5st0R5J2euQiBEIstZK8ZeL/QLjZJHorWBHrjZ8n4zoz++zIOelXkQzTBYdqqeoZCWOWRb3DAroHYWJjQDsuc8kv4HzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lit3eSVN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so2813816a12.0;
        Sat, 22 Jun 2024 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719067233; x=1719672033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xmdyLBFz77XS47EVsvObz9UqsWdp6rRxOKjf2P/6PE=;
        b=Lit3eSVNHNoUTZWze6jTSiptluOOblyM6M3XBU+/da2h68qiJzW5WZTfSUuPGedvp+
         8qYVE+Wyy9kwVbO5gM2VAAdOwHMLT6tvldeuOXZqwlZjAYEyJCGP9CYv2H7ZOGMiSXao
         NTrDIj6mD31vRO1Chvd5PkaGWOzl13MA9ySuTfsJ189kqWmHf8U35U3qvA1Q+QDORT1C
         KHQr0L3rSGBHPH1Nzs+2zs0lbNmFc7Irdbs2cu80FKyYmT/p+TrwpZWtQA1JgOvTL3mZ
         k3mjIjNUDDssdES3KlLD2zpR81PcSrGabeumRC3Vw6//7T6AclQE1nzWET4iXIQg9Ccx
         PQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719067233; x=1719672033;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xmdyLBFz77XS47EVsvObz9UqsWdp6rRxOKjf2P/6PE=;
        b=fpkJdYmT59MKomate7u5V99X+rGfRISm7XUgfvKqEvwp9dRZmgZYRRFzlNEuMUMuFw
         NU7GfzY3+zQHY8SDr2MXV42eWtINbVxNqwCPfR11mjonX2iDW+pmtY1NDDOpsEqcWdfK
         qlE/nQQn3ShOnHBUnx9147dwcLc1d/UUgNWklT//mCEoOB4KLVljuvuAZ0d4uPrpMj6I
         xILcN6R6c8NB/clyHP6TUmVkHdtV3PeCEjoGESgk6hnfqja7KGI2xofml1VUe9I61dDI
         k+EAF0h5lXr0Y1mb9J0fenPu1pzOpMowwkKXcqvTDJVy4jv2tzEoGpU771BhgEwEWYay
         KEUg==
X-Forwarded-Encrypted: i=1; AJvYcCXr1cgyaONSIUFYrpMMpPy9EBdJwN6wWXmyMOKRw+sJhmdgrZY01L0wVv7znFbJFRAdG77GyjhabD0oPKgo6ZuFx9jkXLCdsaft0/HfflUY/BqnCzvzI+MfXfe+QJ/p4uDkbCMT7J47Zxf1gkU=
X-Gm-Message-State: AOJu0YxJeyr49dm3m7P1JfIykqF1pPDWSc6TtGfFUb/SEJKX9NrFiRDp
	PK3g454cdN3y7B4OpkYGs/xV0zCGpuyoZdJzh49WX/BCxJeXJ74=
X-Google-Smtp-Source: AGHT+IE9fcO0mDTf+bO2w2lEqiW7y4kUE7+hvn8rw2hkuaclpX7mFXguP9D91iIUgWfFOFtAPmCNiw==
X-Received: by 2002:a50:ba88:0:b0:57d:40aa:9486 with SMTP id 4fb4d7f45d1cf-57d4bd811f4mr141284a12.22.1719067232026;
        Sat, 22 Jun 2024 07:40:32 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:818f:ca1:d4f4:472d? ([2a02:810b:f40:4600:818f:ca1:d4f4:472d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305351dbsm2418275a12.77.2024.06.22.07.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 07:40:31 -0700 (PDT)
Message-ID: <da5c6875-ffec-4b0e-a7c5-2fc2bc5fe9b0@gmail.com>
Date: Sat, 22 Jun 2024 16:40:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: of: Support interrupts-extended
From: Alex Bee <knaerzche@gmail.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <20240621225558.280462-1-knaerzche@gmail.com>
 <190402b87a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <19040354ba8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f81489b4-ed60-43df-826a-1f9593802be8@gmail.com>
Content-Language: en-US
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <f81489b4-ed60-43df-826a-1f9593802be8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 22.06.24 um 16:07 schrieb Alex Bee:
>
> Am 22.06.24 um 15:49 schrieb Arend Van Spriel:
>> On June 22, 2024 3:38:32 PM Arend Van Spriel 
>> <arend.vanspriel@broadcom.com> wrote:
>>
>>> On June 22, 2024 12:56:02 AM Alex Bee <knaerzche@gmail.com> wrote:
>>>
>>>> This "new" version of defining external interrupts is around for a 
>>>> very
>>>> long time now and supported and preferred by irq_of_parse_and_map
>>>> respectively of_irq_parse_one.
>>>>
>>>> Support it in brcmfmac as well by checking if either "interrupts" or
>>>> "interrupts-extended" property exists as indication if 
>>>> irq_of_parse_and_map
>>>> should be called.
>>>
>>> All very interesting, but why should we add code for something that 
>>> is not
>>> specified in the bindings documentation?
>>>
>>> NAK (for now). Feel free to update the bindings document.
>>
> Sure, if you insist on it, I can update the bindings document. So far not
> many (no) users did that, as it is clearly specified as an alternative in
> devicetree/bindings/interrupt-controller/interrupts.txt (sure, it's 
> not yet
> converted to yaml yet).
If you are worried about schema validation: Some magic will accept both
"interrupts" and "interrupts-extended" if only "interrupts" is specified in
the binding. Not sure that happens.

>> So looked up the interrupts-extended definition:
>>
>> The "interrupts-extended" property is a special form; useful when a 
>> node needs
>> to reference multiple interrupt parents or a different interrupt 
>> parent than
>> the inherited one. Each entry in this property contains both the 
>> parent phandle
>> and the interrupt specifier.
>>
> They point in this particular case is not how many interrupts exsist, but
> "... or a different interrupt parent than
> the inherited ..." which is almost always the case for brcmfmac, as it
> usually specifies a gpio controller as interrupt parent. So:
>
Maybe I should resend with a verbosity-increased commit message?
> ...
>         interrupt-parent = <&gpio0>;
>         interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
> ...
>
> gets to (a single line):
> ...
>     interrupts-extended:  = <&gpio0 RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
> ...
>
> Which is a much nicer form, imho.
> And by the way for instance
> arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts already uses it that way
> and the interrupt will currently not picked up (at least not by this
> driver).
>
> Alex
>
>> Given that brcmfmac device will only have one interrupt item defined 
>> there is no need to use it. If someone can give a good argument to 
>> support it please chime in.
>>
>> Regards,
>> Arend
>>
>>
>>

