Return-Path: <linux-wireless+bounces-5749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1106A895844
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EDF1F245CD
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5413340E;
	Tue,  2 Apr 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="qZqAJKo8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A11327FE
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071904; cv=none; b=EnXULWDqhrNcBxxUZ7fVMTsIyOpnqdqGu/TONVpU7LXW7jiqFVqrLj/+qoJisWP6YD1g5BlX+BMJM5lYfXpEM36zlI+RSTatIq2F12vOjG4wd9PEjYXzjIn0GATccpAIG7Z2wHUjYVSZSir1OQeYNv2w9N8z4Pcy9gilUtqjv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071904; c=relaxed/simple;
	bh=8vXdqn4SbFT4RHfnsdGkXt/pEfwiD3lzaCRDv2hYwiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj4uXBvcoMchMp1vAlFE7n6ViZgrGIbRuibUDwo5qsgtd2QcqLxPENFUXfvSZFAWLQXqXVgTkqaYi5oWirqVcWO6ywrF15WBj5vbgETjElA0X3Fwg/2ShcKsSpNMr5LoW0gYw1GrP/AtoAgw8dsLFL6Xpyjs0hpnPyWxRosipkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=qZqAJKo8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d717269fso6334272e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Apr 2024 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1712071900; x=1712676700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Q4ndQzVnF5DXRDj2bg6xXjCGWqd/IU0gdb7DwVV7kw=;
        b=qZqAJKo8AXhyI5g9PHwt1Bv5z0VQzkkc1Vldz2iFBXdlduEtKfp7EBCYzXVomzAwad
         iWN7Ab5WMTDlIX84b+mSl2Tq6jeLvaxnfXM+HYNt93IOd72ucBe33d6Rfs5a5nT7IJQ1
         7ySG4lnjCn/QS1KP5W/inh0ntjSY2x88tHpDKKAWHdLcPzuH/UnxEROhSi4NHCcYnvKU
         s85n3lnm5moOvir/9usFIVq7kJEuWU5pjG3vnnQ8OXLS1hSfjlHqYVTothaqo5vQ/Nii
         /qNTx1Pxr3FQxbtxjo/yQ1R1cB10FEx+3norXq2CbrJC7p6YLznxx8ZwFmNkVeNOAdJo
         mxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071900; x=1712676700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q4ndQzVnF5DXRDj2bg6xXjCGWqd/IU0gdb7DwVV7kw=;
        b=BjJMGnDpc6COHXPIMdD0wZOmVmsh7FjAROcfohih4+5kHbMZXNipD/kOl1LX/CTUrD
         C5YcBgzdWjGjveXunp2/ywvRestEe2keKJgIgJWkF5t5poP6PujrLSJhLwzVOPOB9F7g
         0pvLTczHj6SI0+GyqXnFdkGWCadk9rGGl22Nu9kacvdV+Q7BWM19momPwG5zG/JKWlMG
         Df63F3caqFtvpSndyk+cy0mW31tZ092Sp/wcoGTfW7hlaftkm6VSCzBdn7dhdhy1iK6b
         KEq94oMaHKOYdJ8UBLdrGHjJ6BzD6twAajkaYUy9GasmPzwDkxAETsVGHiuZ6nqZhFwn
         5Sag==
X-Gm-Message-State: AOJu0YwIb9AmtSCat3YuPyYbSa+rMMAM1iOCJVVx6D7rZ8Nw1c6GFbr0
	XxfK3tU/2qhr+ylv6vdE8OAvpCYM70OOdQtVb20ejl2kI5L8Z/y8RDAtNNQWU4I=
X-Google-Smtp-Source: AGHT+IH3bfYQjzywARGZhfABTOMjHF4+sxFyXei/19hbg8R8ney+OlkZilRODA2wTPZWvmOFkumQBA==
X-Received: by 2002:ac2:5a4b:0:b0:513:d1c7:7d37 with SMTP id r11-20020ac25a4b000000b00513d1c77d37mr8478285lfn.51.1712071900000;
        Tue, 02 Apr 2024 08:31:40 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b004146e58cc35sm21617675wmo.46.2024.04.02.08.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:31:39 -0700 (PDT)
Message-ID: <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
Date: Tue, 2 Apr 2024 17:31:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 16:34, Konrad Dybcio wrote:

> On 30.03.2024 7:25 PM, Krzysztof Kozlowski wrote:
>
>> On 28/03/2024 18:39, Marc Gonzalez wrote:
>>
>>> The ath10k driver waits for an "MSA_READY" indicator
>>> to complete initialization. If the indicator is not
>>> received, then the device remains unusable.
>>>
>>> cf. ath10k_qmi_driver_event_work()
>>>
>>> Several msm8998-based devices are affected by this issue.
>>> Oddly, it seems safe to NOT wait for the indicator, and
>>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>>
>>> Jeff Johnson wrote:
>>>
>>>   The feedback I received was "it might be ok to change all ath10k qmi
>>>   to skip waiting for msa_ready", and it was pointed out that ath11k
>>>   (and ath12k) do not wait for it.
>>>
>>>   However with so many deployed devices, "might be ok" isn't a strong
>>>   argument for changing the default behavior.
>>
>> I think you got pretty clear comments:
>>
>> "This sounds more like a firmware feature, not a hardware feature."
>>
>> "This is why having this property in DT does not look right
>> place for this."
> 
> Translating from dt maintainer speak to English, a functionally-equivalent
> resolution of adding an of_machine_is_compatible("qcom,msm8998") is more
> in line with the guidelines of not sprinkling firmware specifics in DTs

I'm not so sure about that, as I had proposed

+	if (of_device_is_compatible(of_root, "qcom,msm8998")
+		qmi->no_point_in_waiting_for_msa_ready_indicator = true;
+

To which Conor replied:

> How come the root node comes into this, don't you have a soc-specific
> compatible for the integration on this SoC?
> (I am assuming that this is not the SDIO variant, given then it'd not be
> fixed to this particular implementation)


Then added:

> A SoC-specific compatible sounds like it would be suitable in that case
> then, to deal with integration quirks for that specific SoC? I usually
> leave the ins and outs of these qcom SoCs to Krzysztof, but I can't help
> but wanna know what the justification is here for not using one.


Then Krzysztof added:

> The WiFi+BT chips are separate products, so they are not usually
> considered part of the SoC, even though they can be integrated into the
> SoC like here. I guess correct approach would be to add SoC-specific
> compatible for them.


So, if I understand correctly, I take this to mean that I should:

1) DELETE the qcom,no-msa-ready-indicator boolean property,
2) ADD a "qcom,msm8998-wifi" (name OK?) compatible,
3) ADD that compatible to the wifi node in msm8998.dtsi
   compatible = "qcom,wcn3990-wifi", "qcom,msm8998-wifi";
4) In the driver, set qmi->fake_msa_ready_indicator to true if we detect "qcom,msm8998-wifi"

And this approach would be acceptable to both ath10k & DT maintainers?

Bjarne, Konrad: is it OK to apply the work-around for all msm8998 boards?


Regards


