Return-Path: <linux-wireless+bounces-5815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F389D896FD6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91BE2819C9
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74E147C8A;
	Wed,  3 Apr 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="Yp8+JLC4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDD1474D2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149539; cv=none; b=Bv3chFgFwZNxtmFFT+MDC80+ygkz3YnnhTx4z3PHoycwq6P7av7HjTokyMl0Xj3WmAtPLArcJOb05rdGGUOtuYvyQ5Z/U6Kqg4C8LTeV2IjlaibsRwpCJ1uVKUDBTX2bdDJpZEzmxzpHGJA6vrdkEsPBxbE8/cIJshPRvBNMp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149539; c=relaxed/simple;
	bh=9W7EaQCc71PpFxZtrRnJbzx0Wp7qmcJCqdZHuoipVxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFD69faGd7KmjAZt5SHJqW/Q9YXAt1bpywRlP1DQpMW+Xyripym9P6LL5hfkI44DrRzZu/3h7llGimZoWMIBmKZ2D6TNhzwXU6O3yJcgN5AjHUDgorFLPmm8u2UsHxqq78HSPNjWqxAMO4/M6IQtm5ECnGBS3kTdl1MiWhFnsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=Yp8+JLC4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44ad785a44so731028966b.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Apr 2024 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1712149535; x=1712754335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Yy1+Kh6mnrNkIsDDzZC6QpS6YqOrI64OZBtZfxhZvo=;
        b=Yp8+JLC4SPLKM4TkVloMV8ZmkijWh8KYEeT7OsNRtkFTs4qmfh9n529qIxghmpnjMY
         eQxlytlGYbGqGR4wW70dYFyeylcLjxIBI+eIqb1P7/sNo7peVHKH5PTwVPzw6QeiEAXJ
         rxgCHTGr5LSnH3/+gsa7cPWUJohayHeoPSd/iiW4nXYcN2lgz7Hf0DJMHAC9+aR6tfAQ
         irMlf+VoSlICeF+Rert9dAhbURD8h/DyToyA29umQgNxbF7bIs76Sp1Q0yG94Tk51NyL
         i3Mm1IdpXjQoTD79nIVW7RLnGui0K+G7sdygtdthLqyqK3y8ks1E2S/XDBIWDRPQqVc2
         bicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149535; x=1712754335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Yy1+Kh6mnrNkIsDDzZC6QpS6YqOrI64OZBtZfxhZvo=;
        b=F9oGZS7vwbPgk+n+XLMEATqjJLTKo5qA2RteaN0GM5ceRyMeLHSUt9Zh7ctWzaaRbm
         lt1+UC/LDttoZAkhLCMg4oRrqlMni+N7f2/4UvBVzEpuYe666NBn7oAGGNI9GgtKekWK
         sXJPvqg3Ca2+M/YkW2U2zToBc20PhxSIfszVVGnJA9UmsYPhHhH2VovGIxkFBQBuOAS0
         34yW3QwCfK97mRG+E/A87+r5RUmaaeNA8beufu22DQg6wycdHqkteMbDv+thjUltN7vK
         PHmdGImoY+rGjYx+g1Cq3pNgPlrkRL+msFD5+hfrNykUHQ0NREyMpv2lXOISquadRHIG
         l4mg==
X-Forwarded-Encrypted: i=1; AJvYcCUN06DLF+cAeqfWsHxmyHKlNu5m4zLLI+UNHQiVTvesDcenFLDUGur7rjxXSQQOjUBWT2nSQaDiTexdUYal/vsmDSWP+88iCPopafYE8Us=
X-Gm-Message-State: AOJu0Ywh8N6aQmYuezx7bw5UInRjjQo0lh2SwJ1axV0ia0UUWHONJnf/
	7aD6QsONIJteg9lIdOqCOK3YYCbgDE6LR/PTRixiqbddeznVpqJZs8U7hlQerNU=
X-Google-Smtp-Source: AGHT+IHvCjxIoDEM81ThMFGXmAee2lKZJYRPwGZglynP/ylH/CdDRIdN1evuMgXWrVvChyW1q2UCWw==
X-Received: by 2002:a17:906:d28e:b0:a4e:648c:1138 with SMTP id ay14-20020a170906d28e00b00a4e648c1138mr6161495ejb.67.1712149535307;
        Wed, 03 Apr 2024 06:05:35 -0700 (PDT)
Received: from ?IPV6:2a02:8428:2a4:1a01:79e6:9288:5142:9623? ([2a02:8428:2a4:1a01:79e6:9288:5142:9623])
        by smtp.gmail.com with ESMTPSA id xh12-20020a170906da8c00b00a4e579ce949sm4817000ejb.51.2024.04.03.06.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:05:35 -0700 (PDT)
Message-ID: <91031ed0-104a-4752-8b1e-0dbe15ebf201@freebox.fr>
Date: Wed, 3 Apr 2024 15:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 MSM <linux-arm-msm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 17:55, Dmitry Baryshkov wrote:

> On Tue, 2 Apr 2024 at 18:31, Marc Gonzalez wrote:
>
>> So, if I understand correctly, I take this to mean that I should:
>>
>> 1) DELETE the qcom,no-msa-ready-indicator boolean property,
>> 2) ADD a "qcom,msm8998-wifi" (name OK?) compatible,
> 
> I'd say, this is not correct. There is no "msm8998-wifi".

Can you explain what you mean by:
'There is no "msm8998-wifi".' ?

Do you mean that: this compatible string does not exist?
(I am proposing that it be created.)

Or do you mean that: "msm8998-wifi" is a bad name?


I meant to mimic these strings for various sub-blocks:

arch/arm64/boot/dts/qcom/msm8998.dtsi:          compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                                  compatible = "qcom,msm8998-rpmpd";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-qfprom", "qcom,qfprom";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-qmp-pcie-phy";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-qmp-ufs-phy";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-tcsr", "syscon";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-tcsr", "syscon";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-pinctrl";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-mss-pil";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2",
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-gpucc";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-slpi-pas";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-dwc3", "qcom,dwc3";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-qmp-usb3-phy";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-qusb2-phy";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-mdss";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                          compatible = "qcom,msm8998-dpu";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                          compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                          compatible = "qcom,msm8998-dsi-ctrl", "qcom,mdss-dsi-ctrl";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-venus";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-adsp-pas";
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-apcs-hmss-global",


And these strings in ath11k:

Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml:      - qcom,ipq8074-wifi
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml:      - qcom,ipq6018-wifi
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml:      - qcom,wcn6750-wifi
Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml:      - qcom,ipq5018-wifi


> I'd say, we should take a step back and actually verify how this was
> handled in the vendor kernel.

In our commercial product, we use the ath10k driver in the vendor kernel (v4.4 r38-rel).

It looks like Jeff has already performed the code analysis
wrt vendor vs mainline (including user-space tools).

Regards


