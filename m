Return-Path: <linux-wireless+bounces-10240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811CA931D67
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 01:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A865282BD8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 23:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8F1428F3;
	Mon, 15 Jul 2024 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5ZKjzgr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3913D24C
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084550; cv=none; b=XgYDM3G72u4i6OpvKFB18tSmXNG9o/eHlI3OSgBxE6KVZ0a6NGpvyJAl3g50KUsvvUsXC+v6hXebUnigE7HPeF4wweEu+llciwUU/hXyDs4DAwWH2NVKP71lgLytoFvr3wmgxll08LRzMIG/q5CA/KmjlUnRZcBB8QvKqzues6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084550; c=relaxed/simple;
	bh=Bv79ufjb/YuQlGBQSareRbyJTsESDapwqk8Zs05cIRU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nsvQMpG+9VQKEW3UV8gYkOIgze+XwhuIjG4d6gTtMLjgSdtSZbgJisMAFidnp2XT2UbCiFdZdiA2fsdTX1SsC0CW/4I0HZOrFnKsgraNFEf9/qvKCZyLFwhGk5EARh9+zGJNmiqrnHgNkKFJe1H4KgnXzVhrS+8lFm1Ud9/fWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5ZKjzgr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so5708396a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721084547; x=1721689347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3JmOGQR0ysnaffgZprc/f1WSqfrX8yr74EjZqjERQnU=;
        b=F5ZKjzgrzwPZHJTANwZuL2VSzbKad9nPsZF0byPuYXdkhmXcCXsWX+ggdkt6GtsTE/
         gZ/XMWzONka/w/EGw6QDSI2ZYZJLcPHfEgFkNE0fELDpV3qrusbUeE57U7q4D+CyyfAf
         oc3qbC1IG3TkXXozxScSrMZSweHnQF9uMkncgsLoF2qsAj7049+zUL1ppXswtMD2T0Kn
         j7N6nk9RkmCjRpiPvyrD5H2vgRPAOAZ4XQxnp7ef7RKig62LOK8KtedmfrbfQij7gJVy
         Td9X/A+Orvxl+RmG3k5TFketpGWLxolVtTwlsxAeJP91FkGYqgoVCM88QRIjulH6BZE4
         vAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084547; x=1721689347;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JmOGQR0ysnaffgZprc/f1WSqfrX8yr74EjZqjERQnU=;
        b=BV0w6yEpo2pKBTB11kndzhjmvjtXfn/JOrpvveGsVXccbs1A5t0efpGxQRr/MI3cEP
         IE5sQavdcl0B1k2TB0Hmr9/Rm37jLy50+K/pCTFwR9KYunOhhLw+gB+iv/+9Z5WrvWgg
         urs5cAaW9ttmuu6G97kmyb4/XgI4obk0Y3cU1EI1GghYhcG0Bgd88/eRzPvgukYjdsqe
         v8PD3e7Wa45JHNQQu747nZ7VT2jP/gsNsHkIkIJhtryCuEg75d8Ry3McMSR08kzHLEcZ
         mkCPWQxD7Dc3cPt0j2kw2DxE5jAIIpPZe37tJYZsxDOtq+s+2PsIcqf+QfD8L1Z79AVJ
         hcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUdi/fbp7F0dD7PD3HtCPAAruyBG3TQdBFoVT5OknKHGiCfaWC/V8EDjWvxPPprc9sSfoZKBLo2xc31SBJ+Y/FZdz2vVYtokdhd+iv9dg=
X-Gm-Message-State: AOJu0Yy46sHKIsCgkEuzdyI444PC0gpw5zlqfhv9dEbIiqlFNed8v69p
	ZYLN6kSe6zdyChNnjpalNM9Zs0QfwZPMQO604j4npnQvz98wTjvlNV7o3z3WqPk=
X-Google-Smtp-Source: AGHT+IEua67mNuG+vGiUh4kmzyHArfDV7peqK60g6E310elKRd08At/haCUvoXeti39nqYDGkkXjfQ==
X-Received: by 2002:a17:906:2b12:b0:a77:9d57:97ad with SMTP id a640c23a62f3a-a79ea46d6ecmr21463966b.40.1721084546823;
        Mon, 15 Jul 2024 16:02:26 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f21a4sm247073566b.113.2024.07.15.16.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 16:02:26 -0700 (PDT)
Message-ID: <9dc823e9-eef1-41a8-b151-43558cdd7c09@linaro.org>
Date: Tue, 16 Jul 2024 01:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration
 variant
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Patrick Wildt <patrick@blueri.se>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
 <ZpV7OeGNIGGpqNC0@windev.fritz.box>
 <cisap4ctuolfrs6hjqxz45fqtckcy6uhjzma2shcxkso73jvoh@jj7l4bgftoir>
 <ZpWbUjHna1cE5zHW@mone.local>
 <08b70537-d23c-414c-a539-d5166e9e27c1@linaro.org>
Content-Language: en-US
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <08b70537-d23c-414c-a539-d5166e9e27c1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.07.2024 1:00 AM, Konrad Dybcio wrote:
> On 16.07.2024 12:01 AM, Patrick Wildt wrote:
>> Am Tue, Jul 16, 2024 at 12:51:53AM +0300 schrieb Dmitry Baryshkov:
>>> On Mon, Jul 15, 2024 at 09:40:41PM GMT, Patrick Wildt wrote:
>>>> Describe the bus topology for PCIe domain 4 and add the ath12k
>>>> calibration variant so that the board file (calibration data) can be
>>>> loaded.
>>>>
>>>> Signed-off-by: Patrick Wildt <patrick@blueri.se>
>>>> ---
>>>>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts      |  9 +++++++++
>>>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi                 | 10 ++++++++++
>>>>  2 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
>>>> index fbff558f5b07..f569f0fbd1fc 100644
>>>> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
>>>> @@ -635,6 +635,15 @@ &pcie4_phy {
>>>>  	status = "okay";
>>>>  };
>>>>  
>>>> +&pcie4_port0 {
>>>> +	wifi@0 {
>>>> +		compatible = "pci17cb,1107";
>>>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>>>> +
>>>> +		qcom,ath12k-calibration-variant = "LES790";
>>>
>>> It doesn't look like it follows the rest of the calibration variants.
>>>
>>> Something like "Lenovo_Y7x" or "Lenovo_Yoga7x" sounds more logical.
>>
>> This is what's both in the DSDT
>>
>>   Device (WLN)
>>   {
>>     [...]
>>     Name (BDFE, "BDF_LES790")
>>
>> and kvalo's board-2.bin for this machine:
>>
>>   $ strings board-2.bin | grep LES
>>   bus=pci,vendor=17cb,device=1107,subsystem-vendor=17aa,subsystem-device=e0e9,qmi-chip-id=2,qmi-board-id=255,variant=LES790
>>
>> I don't think we can hand-pick these strings, they come from whoever
>> decided upon them and fed them into ACPI tables and QC's binaries.
> 
> Huh, great nod from qca!
> Looks like there's even a bit more hw supported in there..
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Ref: https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/blob/main/WCN7850/hw2.0/board-2.bin

Konrad

