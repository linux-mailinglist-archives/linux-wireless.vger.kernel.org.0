Return-Path: <linux-wireless+bounces-4211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCE86B5BF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96EC5B27653
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3533FBB8;
	Wed, 28 Feb 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="DXrmfXjQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AB3FBB4
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140751; cv=none; b=iyZDfsxexAlX4Wc4noLCF0RG3ZfRLAgMzVbuGpk91N5c5bMGSmWL9MWXrv/9+odBmkZKP9D4Lpgk4bqrYf6nE1qdGQAggwNWEU+SB2Jv+esqZnv/WsqMbLfmuqxDkfMXF46s5waAh9mEQ/OzPiAPBTtNuE497tzo12gDZnD7pRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140751; c=relaxed/simple;
	bh=aFsYKNxuMdtcs33QU/5Jsqcp+ASWrz7gi1ostsw1AUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfCxG+iWWJvkXxahTSoRC+LVrCeo1ZZK1MG1FMv9dBOA1cI+vaEq3AC14MK21b4QqunnXy57XTTBtPFHQq3eoW/wee/5eJiwH7qBFgRM2oWJTljSO6Lf+mV0BY7skZMaDjycajXEjtBldhuBuPul4zy4KbdPiwkATwoo1KLRXgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=DXrmfXjQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512be9194b7so6009355e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709140746; x=1709745546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=likxxYoOfEMuAKtEYTDM9v8GLGgkDJojgZCQVbAvfQM=;
        b=DXrmfXjQSajsclQwZGhOS9uebMhrSySXVGzI/eiLLTMg2I1OoZ2Lsbokbx00WldgDo
         lrOzLK32H7nT/8ce9V8Pnj+kURYG3XsqcbkOzrj40YXx09tFIhMECf8xlm1qyB9vz1aP
         SxvdZ4Dv6ZBW044erGyiQPo3bBqvT9l1zvp2WM4GURvvL1v6zW/UaqMrhXfx0f0FWHkK
         7dzv+stdKWwfOhqXpn2tXiol8utcKFs+JZlrPUyHN47ZV3Zg2aj87liO9Wd8obwHtE/B
         ZdEz9Dv4hwzlk2w2jDU1j+PTQuGIWokbufBtU8dtG3YL7yNGbOVaQPgvIbbBYhzf4QAT
         1joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140746; x=1709745546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=likxxYoOfEMuAKtEYTDM9v8GLGgkDJojgZCQVbAvfQM=;
        b=Jkewavlg86Ryu+6UUcHKvbWe9LSFoSQ1P0+IqLyWHfRcJZ2YhSXIlogdtojn97N0Ea
         TgP1n9Mz7oo6K5wIa76vfzcrmDL/NVxzCQlVxVtNsq8sl3lpp2EP6JGoe0mfdUQJJf7k
         dUU3doQ0YijLh2PQiC10ZRB0xmcYYzxUrx2A5s1qyoDQygrVzBOhi5DGDsSaDdvitbdM
         DBa0byULVWyghbRqiAZJhoKVBjT++C3JU+FZrQCd1tsrivF2t+ynpLznr8skxgiZeVW4
         XKuKjGXHUlz4srtjyPlxFmcowhWEK5AvUigUALGS7lnslo+K2nODDYTce72LnrnOihdL
         2k7w==
X-Forwarded-Encrypted: i=1; AJvYcCXbSJnVo4+EFbplwLJlLy5FAhxdukjMhbVsCmbg+pbiUj3qWfqvlcwg4fuHpZhrU6ieT06XKJu+PGZ6v71rYqMmZ14iqOYCOWXIK76fXXA=
X-Gm-Message-State: AOJu0YxyhKUYwDH0vGisVJ7MeFdFxZhtTW8ZF2P4/ewbab6Pn9wcXgAi
	V5hpYBlG9QMDRVBswiQpemt7yYlaZcZqTAlpHKJ5h9yY43g9fiSngV7nMJd5KUI=
X-Google-Smtp-Source: AGHT+IEE4slZWG1595pj5QbfSYHDutE8sbK9mwf+NBrBMJOjYn3TB2ETiL96EkfflJv/cEyXxsBr/g==
X-Received: by 2002:a05:6512:398f:b0:512:b372:4eed with SMTP id j15-20020a056512398f00b00512b3724eedmr296674lfu.8.1709140745602;
        Wed, 28 Feb 2024 09:19:05 -0800 (PST)
Received: from ?IPV6:2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456? ([2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b00412b10ce488sm2803097wmq.23.2024.02.28.09.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:19:05 -0800 (PST)
Message-ID: <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr>
Date: Wed, 28 Feb 2024 18:19:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <87wmqoilzf.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 17:37, Kalle Valo wrote:

> Marc Gonzalez writes:
> 
>> On 28/02/2024 15:03, Kalle Valo wrote:
>>
>>> Marc Gonzalez writes:
>>>
>>>> +  qcom,no-msa-ready-indicator:
>>>> +    type: boolean
>>>> +    description:
>>>> +      The driver waits for this indicator before proceeding,
>>>> +      yet some WCNSS firmwares apparently do not send it.
>>>> +      On those devices, it seems safe to ignore the indicator,
>>>> +      and continue loading the firmware.
>>>
>>> This sounds more like a firmware feature, not a hardware feature. What
>>> about having a flag in enum ath10k_fw_features in firmware-2.bin?
>>
>> Are you using the word "feature" as in "it was done purposefully" ?
> 
> No, there's no bigger meaning like that. It's more like ath10k has to do
> something differently when a certain bit is enabled in the firmware. I
> just had to pick a word for the enum and from my limited vocabulary I
> chose "feature" :)

Understood!

>> Is enum ath10k_fw_features also supposed to include work-arounds?
> 
> Yes, and we already use.
> 
>> Sorry, I've grepped over the entire Linux source code,
>> and I cannot find where ath10k_fw_features is used,
>> other than in ath10k_core_get_fw_feature_str().
> 
> Here's one example where in ath10k we use a feature bit as a workaround:
> 
> 	/* Don't trust error code from otp.bin */
> 	ATH10K_FW_FEATURE_IGNORE_OTP_RESULT = 7,
> 
>         ....
> 
> 	if (!(skip_otp || test_bit(ATH10K_FW_FEATURE_IGNORE_OTP_RESULT,
> 				   ar->running_fw->fw_file.fw_features)) &&
> 	    result != 0) {
> 		ath10k_err(ar, "otp calibration failed: %d", result);
> 		return -EINVAL;
> 	}
> 
> BTW for modifying firmware-N.bin files we have a script here:
> 
> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-fwencoder

If I understand correctly, you are saying that there is
(maybe... probably) a bug in the FW, so it makes sense to
tag that specific FW file with a special bit which the kernel
will interpret as "this FW is broken in a specific way;
and here's how to work around the issue."

So this bit would serve the same purpose as my proposed
"qcom,no-msa-ready-indicator" bit (that bit existed instead
in my board's device tree).

The problem I see is that the firmware files are signed.
Thus, changing a single bit breaks the verification...
UNLESS the FW format allows for a signed section ALONG-SIDE
an unsigned section?

>> As mentioned in my other reply, there are several msm8998-based
>> devices affected by this issue. Is it not appropriate to consider
>> a kernel-based work-around?
> 
> Sorry, not following you here. But I'll try to answer anyway:
> 
> I have understood that Device Tree is supposed to describe hardware, not
> software. This is why having this property in DT does not look right
> place for this. For example, if the ath10k firmware is fixed then DT
> would have to be changed even though nothing changed in hardware. But of
> course DT maintainers have the final say.

At some point, we start wandering into meta-physical considerations
such as "if FW cannot ever be changed, when does FIRM become HARD?"
(and other GPLv3 niceties). But this is a discussion for another list.

Regards


