Return-Path: <linux-wireless+bounces-14376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C939AC9AE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE5C280F3E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891B81AB6F7;
	Wed, 23 Oct 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvKMFIP3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2814D2AC;
	Wed, 23 Oct 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685325; cv=none; b=A/oC0xz6yfeJlsv4LEpc+xnsZt6WSMmPb93AzYNKDc9tMtZ+up6Cwdo4kCnrGY6fVBMOF3QPY9iHa4SFEFJLKSFUPhIr2LDMz9b4wBRrCdvaUxwRNJuWzWMFsc1sFp4BkgvyeH80hyDi3PpT2tmPMmH9jwWW+O3AoImYtHUXxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685325; c=relaxed/simple;
	bh=F3oVWNgIClwObbZ786CTcXhGTYxKdHNsWla3wR2/wGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thb1EtCFrH6i74nsopKW/K4wW7VVdEbTfQCHZD9di1RbCeMHQeyC5eh0EYUxdoI/XcPP/U+kYASneAQVT+ykpwzgocX5u1iIXz6/tUA9cr28++KuLxSToHF5sd2zHyvjPST90RRZf5il8OZZlEHbkY0u+0upoasjm23kzx0igoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvKMFIP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84640C4CEC6;
	Wed, 23 Oct 2024 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685324;
	bh=F3oVWNgIClwObbZ786CTcXhGTYxKdHNsWla3wR2/wGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EvKMFIP3M8vkM4ZW58KdPKtmIehEQyM8FHsKpCHfIOhW8RWY8Ua8XKlFEGpadMddX
	 /TgAaKC6fI+xVlh/BQ1jFl4gt54EYbOEk3MvICqac0SDZHaDFp/xrhu3TabdkdZyxd
	 HU0gQLh6p0EsNkKauvBXcT4/ZLUf6paGuFDKfSWsSOsx3Y/aOkZsVfDxzvPnOLQ91u
	 bqUptE3GqcWTDaSLh9jWFB3yBXBUOtW1e66k6YvKrgj+XTXCJ/mBWuI2A+Qwb97FYh
	 glRNPdw2kohcyhARw2Eg3ArJM7YgBXEhNCbuBfVKCuojfDut12ef2j6poKlQhowhxi
	 HhJuMRxRQA+Sg==
Message-ID: <50c0f184-030b-4a19-bf8a-077505170f03@kernel.org>
Date: Wed, 23 Oct 2024 14:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: net: wireless: update required
 properties for ath12k PCI module
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
 <20241023060352.605019-2-quic_rajkbhag@quicinc.com>
 <87db3d68-ab1a-4cc4-9857-416de39cea0f@kernel.org>
 <e2c1ce1a-89af-4feb-a21a-9ca2578430e7@quicinc.com>
 <b97b8350-3925-40b0-8f87-f89df429a52a@kernel.org>
 <e7b27f57-efb2-45ea-bbe0-e5aeb90cbff9@quicinc.com>
 <606083d8-4332-45e4-be41-08ca5425cc03@kernel.org>
 <94defe49-c87a-44f6-8768-03f3d6687ac3@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <94defe49-c87a-44f6-8768-03f3d6687ac3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2024 12:28, Raj Kumar Bhagat wrote:
> On 10/23/2024 12:29 PM, Krzysztof Kozlowski wrote:
>> On 23/10/2024 08:53, Raj Kumar Bhagat wrote:
>>> On 10/23/2024 12:17 PM, Krzysztof Kozlowski wrote:
>>>> On 23/10/2024 08:45, Raj Kumar Bhagat wrote:
>>>>> On 10/23/2024 12:05 PM, Krzysztof Kozlowski wrote:
>>>>>> On 23/10/2024 08:03, Raj Kumar Bhagat wrote:
>>>>>>> The current device-tree bindings for the Ath12K module list many
>>>>>>> WCN7850-specific properties as required. However, these properties are
>>>>>>> not applicable to other Ath12K devices.
>>>>>>>
>>>>>>> Hence, remove WCN7850-specific properties from the required section,
>>>>>>> retaining only generic properties valid across all Ath12K devices.
>>>>>>> WCN7850-specific properties will remain required based on the device's
>>>>>>> compatible enum.
>>>>>> Just not true. These apply to all devices described in this binding.
>>>>>>
>>>>>> NAK.
>>>>>>
>>>>>> Don't send patches for your downstream stuff.
>>>>> This is not for downstream. This series is the per-requisite for ath12k
>>>>> MLO support in upstream.
>>>>>
>>>>> In the subsequent patch [2/6] we are adding new device (QCN9274) in this
>>>>> binding that do not require the WCN7850 specific properties.
>>>>>
>>>>> This is a refactoring patch for the next patch [2/6].
>>>> It's just wrong. Not true. At this point of patch there are no other
>>>> devices. Don't refactor uselessly introducing incorrect hardware
>>> Ok then, If we squash this patch with the next patch [2/6], that actually adding
>>> the new device, then this patch changes are valid right?
>> Yes, except I asked to have separate binding for devices with different
>> interface (WSI). You add unrelated devices to same binding, growing it
>> into something tricky to manage. Your second patch misses if:then
>> disallwing all this WSI stuff for existing device... and then you should
>> notice there is absolutely *nothing* in common.
>>
> 
> I understand your point about having separate bindings if there are no common
> properties. However, the title and description of this binding indicate that it
> is intended for Qualcomm ath12k wireless devices with a PCI bus. Given this, the
> QCN9274 seems to fit within the same binding.

Feel free to fix it. Or add common schema used by multiple bindings.

> 
> Additionally, there will likely be more properties added in the future that could
> be common. For example, the “qcom,ath12k-calibration-variant” property (which the

You are supposed to add them now, not later. See writing bindings. They
are supposed to be complete.

> ath12k host currently doesn’t support reading and using, hence we are not adding it
> now) could be a common property.

What is "host"? Either the device has this property or not. Whether host
supports something does not really matter, right? You have hardware
property or you have it *not*.

> 
> If you still recommend creating a separate binding for the QCN9274, we are open to
> working on that.


Best regards,
Krzysztof


