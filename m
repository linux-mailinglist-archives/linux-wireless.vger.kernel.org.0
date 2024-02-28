Return-Path: <linux-wireless+bounces-4208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94A86B45B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 17:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4511C2274E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561015CD4A;
	Wed, 28 Feb 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="mlSCuIkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32151C10
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136737; cv=none; b=OEYdU3yUqz6CnW30tD1/WQSAlRwLNnPQA5iEQ8PXXJeonfuqIB2j3LOY6Na22GbSBAQdqRlttyW8M5ujdDKXc7OWD7KgwPNOhzf+PJs11WWI0ZZ3yocTYXwEO5OWbWP2W+VqPNUuF79GJncDzQ5tTNAEgNvx87qI1OdC0A53g3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136737; c=relaxed/simple;
	bh=Bk/tiaNN2lMtAJpfzBNuyzp4nRnb/ODtaK+6b/dlsE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rpbl/8uf36kqSAVgoBr5XrIdqftL5maHGpGrnpDxfP0Jy47Hi4lTOlKFakvcaMEdwEHfzbgYjyqLCvA7DTnafLfxtn4w3Ym39qSAjjA1NH08kpepUqgcNmTkf5MOQb2s+lrfsEY2RhtczazYi6bABEnA47Z/bgZEbuBPow3nnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=mlSCuIkj; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d288bac3caso45045261fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709136733; x=1709741533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3BBUgnVwR3soaWOrmj3I3bXyg9YVedXAOrnYNtyhrU=;
        b=mlSCuIkjvxs2xtRzwCDjGffiBYYw6iCkXUgBZ1xHw0SVCE27dinE7ZDKSYPHKtcvGZ
         DkgoAZm/5AAmTr1RT4ZmGvJjkE1WRTFnY2+zfA8jrfjRrCVwOduNQg+WoGTPMc0i0xCP
         NqPs1Nbdvug77zQZy9VwSZgenpjOZ5e20JpvjwWegxNgwP8hn7Yy1HN4fnrRq9yg9UPS
         krX8KudVhg72Ci7zIcfDKg5TnZgObPCLyigWrx/ubhSnJXZzoMiQoKPgREwk1GQ1jf5s
         7xgcvxCPo8zkFZ31in8n8J7yv6T4jtl+7ANteHi2P/MFnomxzW/BWh7Zk3wXBupv2xwS
         GT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136733; x=1709741533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3BBUgnVwR3soaWOrmj3I3bXyg9YVedXAOrnYNtyhrU=;
        b=IhS9edsX6y27R2zkRaDMYBKzShUgXDgVNTxQ9KnHPHd2pv+/lXUj9B9xl/XfQYIVAD
         VzLRJiy98VgEi67tFPgkIBPf01dWkXwAvpLhDfHDFXvXe8m06In/3sVzIBIE+my2cIG7
         f+0VvRt35yrVd4qiixXVGS/3+H9FyOZY/Wu7FTSYb44J/VAUUEAXS/7KJ70AbHtIOFov
         xqZcCgFgLsRLc/VWDc0VQgkhysoFVP/t5mq/iB1l3fSPSDm0lQnUWx0jW6ODJ08ZZmB0
         VkJlb3Vf/A6n2OmTYgH3RZF2OS+KYbFdutomBpjik0J7KCFCTUs36PDUIOWe093tt8Sx
         QYdA==
X-Forwarded-Encrypted: i=1; AJvYcCW5P8VHuBVyitO1Krh8fZh1OQFRn0jUqVbO3CnVXTtBK16R0cTvegVuNo07IkyPZ6F0PnnxiDTa8/qnprhjZQKfE9QrMpzmVgM0+nIDAig=
X-Gm-Message-State: AOJu0Yy6iBuE7zItFBOaiAih+fCwre9vVvR1edHRFhQH5dZMb2MY3nl0
	2qufN/iaRyDHBBOFYhMtXh4sEEN/TE0Qoa2KvUu/mjZklEE6RV8M97+C1gL8TKc=
X-Google-Smtp-Source: AGHT+IGG6AdUTyo4FoBdAMSmEv7Y/fYF0GPaQX0fJK9UX1HC4EI51NFSONZdNCzGaVHNBmdKJDQbGg==
X-Received: by 2002:a05:651c:23b:b0:2d2:99a3:e508 with SMTP id z27-20020a05651c023b00b002d299a3e508mr3410724ljn.38.1709136732828;
        Wed, 28 Feb 2024 08:12:12 -0800 (PST)
Received: from ?IPV6:2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456? ([2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c2a4100b00410dd253008sm2487000wme.42.2024.02.28.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:12:12 -0800 (PST)
Message-ID: <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
Date: Wed, 28 Feb 2024 17:12:11 +0100
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
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <871q8wk7o3.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 15:03, Kalle Valo wrote:

> Marc Gonzalez writes:
> 
>> The driver waits for this indicator before proceeding,
>> yet some WCNSS firmwares apparently do not send it.
>> On those devices, it seems safe to ignore the indicator,
>> and continue loading the firmware.
>>
>> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>> ---
>>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
>> index 7758a55dd3286..145fa1a3c1c6a 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
>> @@ -121,6 +121,14 @@ properties:
>>        Whether to skip executing an SCM call that reassigns the memory
>>        region ownership.
>>  
>> +  qcom,no-msa-ready-indicator:
>> +    type: boolean
>> +    description:
>> +      The driver waits for this indicator before proceeding,
>> +      yet some WCNSS firmwares apparently do not send it.
>> +      On those devices, it seems safe to ignore the indicator,
>> +      and continue loading the firmware.
> 
> This sounds more like a firmware feature, not a hardware feature. What
> about having a flag in enum ath10k_fw_features in firmware-2.bin?

Are you using the word "feature" as in "it was done purposefully" ?
This looks very much like a FW bug to my untrained eye.

Is enum ath10k_fw_features also supposed to include work-arounds?

Sorry, I've grepped over the entire Linux source code,
and I cannot find where ath10k_fw_features is used,
other than in ath10k_core_get_fw_feature_str().

As mentioned in my other reply, there are several msm8998-based
devices affected by this issue. Is it not appropriate to consider
a kernel-based work-around?

Regards


