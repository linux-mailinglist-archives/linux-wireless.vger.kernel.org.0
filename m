Return-Path: <linux-wireless+bounces-11700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B946958695
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501291C20AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE0B18EFE2;
	Tue, 20 Aug 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gu40qHE0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B518F2C1
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155711; cv=none; b=e1yjDXUQ+6Qw7VhRPvK+PcUKN9FqOn0edz7UYEJ8k6/p/wtfZ/d6j21sP2avssfkT7dNz4hpBfCMDWAf9yrspCpizNxtu1y93jc0can+9o6BzoVnE5tosD0EVWVLx2FHegLGXetjlXnTcoFbF0BXLqL3h97vGCQbvHfg3iJljEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155711; c=relaxed/simple;
	bh=x4U/btt7mjGRi3Yi+zkPc5H7FHFBEqZjpXjzyQRje5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYJHlEpdS6iapcJXdVXwXpYFAY+BDtnjXw/QP+llBPRChjIydNZNyCaavuk4mLGJfAo9V+x6fhF6QxRtq3Her/DskiWrlr84etO0vZdzjG46S9dpCg8EU6L8MnCIn5ptTfbIWKJ80G3BA4WrWvq8feL2tpMOwZDbSyK/0Qyg62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gu40qHE0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so3786255b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724155709; x=1724760509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IbVpyfwqhv4piKWS7dNawC8L8BPVEx8wqAU1wtbSNKo=;
        b=gu40qHE0auXXGqn8oH48ewrk/b/V+LBgCCRwQ6nJMRBAr5VfCTwL25CAXKDAA8K+Ej
         cCPeYs4O+W1iZML+nTh7jYNIaxoLaSL4r3CLhjEiQooDMdaKCX19Dn6oXvEM1IW4zgp7
         tmGCFVsDxewBaAlgp9wjs23eOsrnTvSdPAyvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155709; x=1724760509;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbVpyfwqhv4piKWS7dNawC8L8BPVEx8wqAU1wtbSNKo=;
        b=XZluP9j2bN7LF7iuuhTRpS5bljBSwdQwOjC/CgHABT8K0DQ7OcG/DiKCD8tmFCRhni
         QffOaV91Q16HYTY7ZJnHUPDYeWQJDrzkYu4kEMDhLvVre7A9G3utNXRJgpAVrhlWvfIL
         ruid/s6Tzac8MtXCmmQV2KfPwkG2/tQS707kfU5spj4+AO7TbKah1YXgM1094Hk7NAmo
         HHcv94+EsHNh+U/crb2QQFlbHj/FT20UQ5Fxq+JHhfDKof+TCpdPM6IyJNjUr6z+V4zA
         RVna8nYcuXmrOhkeCJWm/MggsChD8zi8KAl5qlJ6cmeB7Ywr6DwQeAAtjkSTSKhP+Q/i
         z2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFXFf2Xq/SAzbDyQQ7XvT//33+XCrIt2qGMa1ymJYy8MdkhpokaPKiHwBSAdSQrHUlngyQZssxBPmfK1r2dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tT2IOHbK7eNEKILGhlobg8vzVsfnGxISkRHJsxzrEpXAiH7c
	j+w69YC2jGqA6JXxE5A7lh2acU+gemVHzaYFr2Y4E9wt+qpw0EEgV9qCU7zxsw==
X-Google-Smtp-Source: AGHT+IFp7xb/SAfv+tua3AiKC9CRhyrsOygCVaDoXjPW1fXEyuw1UQRdPHzdsuQUranJi/3qssmWGw==
X-Received: by 2002:a05:6a20:2d14:b0:1ca:cd6d:bb43 with SMTP id adf61e73a8af0-1cacd6dbbe6mr1455297637.15.1724155708797;
        Tue, 20 Aug 2024 05:08:28 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61ef7a7sm9286043a12.52.2024.08.20.05.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 05:08:27 -0700 (PDT)
Message-ID: <0542d1e9-a395-497b-8920-4b0805d13557@broadcom.com>
Date: Tue, 20 Aug 2024 14:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property
To: Krzysztof Kozlowski <krzk@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 brcm80211@lists.linux.dev, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com>
 <172415246911.849656.16484336903356408566.robh@kernel.org>
 <7a5e37f0-4830-43f8-84c9-62b6614efaca@broadcom.com>
 <8d74380c-0090-4209-963e-e7dde57c4235@kernel.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <8d74380c-0090-4209-963e-e7dde57c4235@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/2024 1:50 PM, Krzysztof Kozlowski wrote:
> On 20/08/2024 13:43, Arend van Spriel wrote:
>> On 8/20/2024 1:14 PM, Rob Herring (Arm) wrote:
>>>
>>> On Tue, 20 Aug 2024 12:12:15 +0200, Arend van Spriel wrote:
>>>> When extending the bindings for Apple PCIe devices the compatible property
>>>> specification was changed. However, it was changed such that for these
>>>> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
>>>> string in the compatible list property as it was before that extension.
>>>> This patch restores that constraint.
>>>>
>>>> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>> ---
>>>>    .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>>>>    1 file changed, 10 insertions(+), 9 deletions(-)
>>>>
>>>
>>> My bot found errors running 'make dt_binding_check' on your patch:
>>>
>>> yamllint warnings/errors:
>>> ./Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: [error] syntax error: expected <block end>, but found '-' (syntax)
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml: ignoring, error parsing file
>>> ./Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: did not find expected key
>>> Documentation/devicetree/bindings/mmc/mmc-controller.example.dtb: /example-0/mmc@1c12000/wifi@1: failed to match any schema with compatible: ['brcm,bcm4329-fmac']
>>> make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dts'
>>> Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: did not find expected key
>>> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dts] Error 1
>>> make[2]: *** Waiting for unfinished jobs....
>>> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
>>> make: *** [Makefile:224: __sub-make] Error 2
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240820101216.355012-2-arend.vanspriel@broadcom.com
>>>
>>> The base for the series is generally the latest rc1. A different dependency
>>> should be noted in *this* patch.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit after running the above command yourself. Note
>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>> your schema. However, it must be unset to test all examples with your schema.
>>
>> Thanks, Rob
>>
>> I will have to setup my environment for that. Will take a while to get
>> it all working.
> 
> It's just two commands:
> pip install
> or pix install if you use newer Ubuntu (no magic here, just like every
> other Python package)
> 
> and then `make dt_bindings_check`, optionally with arguments. There is
> no environment needed, you can do all this in the same place you build
> and test kernel changes.

That's what you think. I am working on an IT managed RHEL7 server and I 
have to work around their infrastructure. So trust me that it is not 
straightforward on my side of the abyss.

Regards,
Arend

