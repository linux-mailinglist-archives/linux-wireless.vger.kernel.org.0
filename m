Return-Path: <linux-wireless+bounces-10238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C9931D48
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527771F22828
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D515F13D533;
	Mon, 15 Jul 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygproN6H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4C13B585
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721083610; cv=none; b=IjFyYxp3wBnnMknIKAbSNr3BAW731WJvUXwxvDhfvggcllOdfJS+444sDre5gH8hAsm2IWzOwXJmNRQi+t4yeqILcAQ4uJ/Iyj8d2EO8kdwSg/gRZrJpDP4J7gLWRVcA77lY+FREKEgpkZfe8oRf+G6A/gs8gccJePZpgNMyRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721083610; c=relaxed/simple;
	bh=QBduxMJn/8/VoYF+kBKf4aPNndK2PEZIT4i/cR4yh00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCAKQX39f3wW5KfgXXH41OOdYtDfPw9NUvEgzhcXyxe1yZQgbPQaBscbSQiWQDO28GtrJP6HEB/3cchIChGuzy74N0KNFgsgNHWenLi7Uc/xJhcLFM7yvvmoilOmn1/o//DORdZpNih6NVOnGwmB9MkmynOLSIaMuo6O/Sdxd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ygproN6H; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77bf336171so794665066b.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721083607; x=1721688407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/DrQDTkdWhn+Ce7ZQ8t9MzeROhcASOFp1mS0+Men98I=;
        b=ygproN6HuPmxAZ2LpsGfrTMxWIndv0e2eTh3eBD5l/24QS0rbmi8+ynETIW6ZA/ITe
         kQYZz8mTGhJ2fHvLXtdzvwFsuyWapMJQEjVu/PXr6emEppvWXKJtkSo+BgO31icmlV8O
         QDOL/sl4XDVms50cKQxmrw65747iY3HClPEB5hrmP4gdYCAeU2Lb+Ki028tlVYvBAPG0
         j8eovP7mDarZ3nuznRqoda++7AEZmQmGTAfRPi0b9f70M8B7AUGrwutYs0o8HaMeC8Xn
         zIra5Th8wPysSWTgLY1oClz9csvaTbs/nipv+mo4CsxYLXBN49wk22duQjG8KFBOjFso
         NwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721083607; x=1721688407;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DrQDTkdWhn+Ce7ZQ8t9MzeROhcASOFp1mS0+Men98I=;
        b=VpdjRplLM1xUZu7iFIa55XiG/ZWJEA6MnrH2jq2giUUm5yH4t1A+ta+7bFVFFvGenz
         XUkuosuTFBczlLWiZeGoJ7QKk7+s6hYkIrvCXqt4MBjk6e9jTpvWGT5ZG1COrvZOZtD2
         pZoV7S+V7JH3eMhAlVE7m1dj8t/OOuIwcIeMj40FU/XIEHddd77fELJKHNybJgQrf0c2
         VHq1reNJWt9yqMeiIB/7Raoyyd2u6p/WMEIzC89CeV2XMausSCBNRmMtFaNgSqDWxohr
         qQlJiqjmtrW0xO1FO0kPZlx8/0vffA19VFwBu2IjJGCdeID2RvdzB9cGioJiLuCEX461
         akYA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQ4NlBGyjshuanJIBhbr4HRfz9tjnrzLqpnKPxNlc5jDvSOwRMRCMHvFCBoWgkqMiS7407ZpkbxQu7wzbCtczNr0+TbCujYJqlbeowsQ=
X-Gm-Message-State: AOJu0YwIiuwnBebX9IqCVqMe39XuX9lThw7aJLhoZClGtILRnWT46lIw
	Oy352+nKjS1j31fXeuiGzIMDEYO+weoNnOeqleSrLs9O4TU4lBAb2W+Oq4ISEe8=
X-Google-Smtp-Source: AGHT+IG4DEesDMZcuysfgLZvQ/+OAO3Qsg+dE/NjXv/QQ07Ez023CbJmTu8w+jAxCcCb3jgETbq3fg==
X-Received: by 2002:a17:906:489:b0:a77:abc3:48e2 with SMTP id a640c23a62f3a-a79edc4be78mr2890166b.25.1721083607319;
        Mon, 15 Jul 2024 15:46:47 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d1a73sm247528966b.87.2024.07.15.15.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 15:46:46 -0700 (PDT)
Message-ID: <a077b6ce-4fe9-43da-9c6a-454df609fdfb@linaro.org>
Date: Tue, 16 Jul 2024 00:46:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: add ath12k pcie bindings
To: Patrick Wildt <patrick@blueri.se>, Andrew Lunn <andrew@lunn.ch>
Cc: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Steev Klimaszewski <steev@kali.org>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7B9uGVpeTSCzp@windev.fritz.box>
 <d921bf20-1d83-492f-ab88-0f23de26a649@lunn.ch> <ZpWQKMX9jhb-nNlh@mone.local>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZpWQKMX9jhb-nNlh@mone.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 11:10 PM, Patrick Wildt wrote:
> Am Mon, Jul 15, 2024 at 10:54:18PM +0200 schrieb Andrew Lunn:
>> On Mon, Jul 15, 2024 at 09:39:51PM +0200, Patrick Wildt wrote:
>>> Add devicetree bindings for Qualcomm ath12k PCIe devices such as WCN7850
>>> for which the calibration data variant may need to be described.
>>
>> Hi Patrick
>>
>> General, the device tree binding and the needed changes to the driver
>> to implement the binding are in the same patchset. I don't see
>> anything implementing qcom,ath12k-calibration-variant here? Does the
>> driver already support this, and you are just fixing up missing
>> documentation?
>>
>> 	Andrew
> 
> Hi there,
> 
> technically I could try and make that change, but I don't actually run
> this driver or Linux at all; this change is for running OpenBSD on that
> machine with a correctly defined device tree.
> 
> The realities of Linux being the de facto upstream for device tree
> bindings force me to submit changes here so they end up being usable
> for other operating systems as well.
> 
> I would assume that eventually someone that runs Linux will adjust the
> ath12k driver as well, because this kind of binding has been used for
> both ath10k and ath11k and this is just a copy with a name change for
> ath12k.

Paraphrasing a certain company.. Linux <3 OpenBSD!

Since as you mentioned Linux is the de facto upstream for dt-bindings,
many people identify those two.. I think a solution that would keep
everyone reasonably happy is dropping a line about your usage in the
cover letter

Konrad

