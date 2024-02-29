Return-Path: <linux-wireless+bounces-4259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A986CDC0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AABA1C20A00
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70870AFE;
	Thu, 29 Feb 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="euMtdEpU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A170AD9
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221782; cv=none; b=hADbbhZy8CtQhx7tWfO+JaeqevXXydJeo7gEtcY+L78ZW1AxzH7qhommlxEXjvRcW6vzNND+OslkgxThdeqS+nvAbGjjPD2bRb4diZKTdWjlqA5SVrdxyhzUXt9bxXsEs8hEzpKDlnRG3n5/bCuJReKpWcAP4R1tUj2Xdb7e+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221782; c=relaxed/simple;
	bh=CHcI2S0JEPj8mELbXV5Hi3VYv5okgHeAmgENHLm1Efk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9JJrmrsULswaUXPhwVFGNbovRA1AqWeqN3kDyLTpm41L+8EdykncPVyQhwvaMcpP4CKtLQ2jodd9zh0WRGLL2yyw4xEOvU7OiF62rUT5JhvyMLA15RcunmaH0CKA9JQ9/Bdio2x5GuKhByakEqkCRIn596RFSnz4scja1h19aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=euMtdEpU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412c37a8001so546275e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709221778; x=1709826578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJWLEHwKCTq5M6yaIuOIWFF3XC8JrWtOfeFaJKHLycI=;
        b=euMtdEpUASCWHkgHI9o62h903+/f5eQ+yMeCJ7dB0LaTHtIXYiteBT1Jxc+tWiRw8a
         0PI0j+yS8g6fcfmUJ+0JOQOxUYjt7Zd6BZtlfQ4vDF1fjKzNDqg2mIeKOE4Iu+riR2NX
         zh85Bcp0h8ufFpaVFnuSpXT6UCw8E1MMpiwBFpgdoMHIVgDZm5m3BsaQHzUfm6xdHVJK
         ZhknKW46++XwHkbHdwXzyJWb07NRon2Rl8e1Xi668nI7qOkMkv84RenW1vwHZ2bDth4w
         xxAbH9CFVRsPbXZyKYs9JjmLNvn2wmZ80XkPU3jqj1n8SgjiAWdiDVWmd51lZRw9YQ2O
         kzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709221778; x=1709826578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJWLEHwKCTq5M6yaIuOIWFF3XC8JrWtOfeFaJKHLycI=;
        b=KrbEerYOo31MdLSI8C239gg0fe1HeDjUIYNMbl5Oqc132b0kgEPY1Qyojvusc0o9pI
         rxbmEWlPTvWmnZnmkiAbEuRbhQaCFJUSCIGfyGC1j0Akb6Gey1aH2BXmHUizxIiNYYmL
         UY6FRVZR1sLkSqgDTiC/l3unQfcu7NOf/uzw5tsTGKscJVOQvpOXkhqwsgAw+snjjk+R
         LUaJFqLMgXX6SsRj831GSyH27t9LE5/lOQxhPewQhMxGA2Kxl3r71cUBpxG3xCCpAqQK
         h+5NLwCCItZO/Vj7voxjZIRtY0kcc1mKcm5PWMwyZ+9dMGZe0RoQUusI+l2tr6WGNoRk
         8Njw==
X-Forwarded-Encrypted: i=1; AJvYcCVZkDmQUJ7Jmbdk1zt5wN1t87x+/zaPWjfO2d4QVzsfY/0jgI+peSvncbWALb0W7z0JnsRej+7C1APsOnqhKyNMAqdFTHA2hXTEeCCDMF0=
X-Gm-Message-State: AOJu0Yz2l98XF+5choQX9hC11S9g+TZrQKRHJ9sBEykd085FYoMfDWPy
	IbSkagdoMdas5qwDHtx5cAzPmkQXYYesIeXCRyXdxQXrqc2zBtIk5sc34NUr7OA=
X-Google-Smtp-Source: AGHT+IE9abPTuZJImsBPPVwExiBHv3+UHoPZOEA+bzFtWuIKypEfuzgNNp3VESK6x/US7chA1lqTew==
X-Received: by 2002:a5d:58f2:0:b0:33d:29c1:c28c with SMTP id f18-20020a5d58f2000000b0033d29c1c28cmr1851510wrd.66.1709221778325;
        Thu, 29 Feb 2024 07:49:38 -0800 (PST)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d4c4d000000b0033cfa00e497sm2074044wrt.64.2024.02.29.07.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:49:38 -0800 (PST)
Message-ID: <49bcc88d-2562-40c9-81f6-64a48deb2066@freebox.fr>
Date: Thu, 29 Feb 2024 16:49:37 +0100
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
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
 ath10k <ath10k@lists.infradead.org>
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <d8c90f33-d0ab-4d73-9580-2547446671a0@quicinc.com>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <d8c90f33-d0ab-4d73-9580-2547446671a0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 15:59, Jeff Johnson wrote:

> On 2/28/2024 5:24 AM, Marc Gonzalez wrote:
>
>> The driver waits for this indicator before proceeding,
>> yet some WCNSS firmwares apparently do not send it.
>> On those devices, it seems safe to ignore the indicator,
>> and continue loading the firmware.
> 
> Can you list the product/hardware/firmware where this is observed?
> Would prefer to fix the firmware if the issue is there

Hello Jeff,

Do you think it is possible that the ath10k IP block in the msm8998/sdm835
has never actually sent the MSA_READY indication?

Perhaps the vendor driver does not wait for MSA_READY, and therefore this
issue has never caused a problem downstream?

In that case, we could enable the work-around for all msm8998 boards?

Regards


