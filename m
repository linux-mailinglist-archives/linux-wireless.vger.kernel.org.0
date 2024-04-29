Return-Path: <linux-wireless+bounces-7010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C119D8B6633
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749572813CE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E581802CC;
	Mon, 29 Apr 2024 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="By+awNSK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BC143C7B
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433085; cv=none; b=pwIEISlZMm8u31Xjd0+H9BCYTxtKT6zEl8PEZg91/QdJmEJb4pQ6T3sdlzs5mBmxp7nICidiBlAwF+7JLE/F7nGXrvMDzLORFgvuZjsJblqTt6dU5kmbXRCv6UoyPbVc7gK+NxVENOSK/ISTL5eqg5ZJkYZzHKnboK1SjUGcpSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433085; c=relaxed/simple;
	bh=jpJg343tUvEgPaQ82/BOHJpfijqZQCt7NOG/nMRYgUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMB4bCnJduwvXFFWUQZXa4moZnkqdDIIrD2oiqBXVoMxyp5X2m8Ho60UeHLRPOfB4IwZsKBC64O4ZTYZSE0K3AD4TbuUCG0uTblTOg1EKgFbqszOEvINJCI6PveMz4RSKRozRnKbiGbqca4J18XfRTmZa2HIYb/Y5iflBevuM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=By+awNSK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343c891bca5so3857424f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714433082; x=1715037882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fd2LTJN7mExidgR4wG0glRVq7EWgwgs0gJNGj4m+AT4=;
        b=By+awNSKrtGmMSRj8m4dgRnK/FToHqG2QVUeukifKGPGIuaahBz+q2qT1k3tUmmwQF
         w3V8qCZeHqfEsJ0Z0iCJ6kZMsrYfWXMZ2vCUI8OadcSHl4AJbTGpZMhwAADFpmt2B6YC
         5l6YUZzFEzwcJLa3smm3s1LnFrAxoCjiQ7X+6vA666OVklgO7/Dnqm55WvM5fM7Y17Rw
         TszylIvC71DSCvn42Hkq5X5BG/pCxrYVaaekBzVaq4xcSe9DC9SdoKvB4jeQL+EpCb7q
         69KE5V4ypvIo15L9S6wPRNBdwJHe1Cvne0HhvTOyKpmCzAcrqdTU5cSUbRODpkGlLYvQ
         JeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433082; x=1715037882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd2LTJN7mExidgR4wG0glRVq7EWgwgs0gJNGj4m+AT4=;
        b=lG/PWdzL16XpCt59bTVKeUvDwTgm/to4jv7RAMpmN96tHFkpRHAJ+ONpcFqDcQcfUc
         JoMwbfN7UnWPg8tnwL6zNnI2v+FtPkZ6hhQPfWwqZY95tDzswzsszNHV5AID4jX252ry
         RYsjTsZpfBUscSUL+F1cGnCZdV3h4pbuRlV52WcsDufXqDBo45Rjvp0XAolUK1ItpBgw
         qY/M5DN3/c221R+U9xH5+5E6NfdaFWprvniLTHyf84wdiKctxf/6ekwCFDULCbtRnRhL
         Lfe7oHLCdAqNnaj037OiekQ5zXXkBuGcVfpR39OLO8EG3acqFoo4yFefnhZZnKUG88wI
         jqYA==
X-Gm-Message-State: AOJu0Yw+8d4X2rSJ7okh1WLz72xslI0Smcr48XAW+hI7bqg0Z3ulpJzW
	1sn3/dNKMY05wrVHhYJIH6yzENDqx9RT50wZgzGDu7uNaT4hIuRRvOygzmZqznz75LYTitFY+xG
	T4DGgsw==
X-Google-Smtp-Source: AGHT+IHE7q9J0s4PVV5qxrR1nnvsJd1w+fjAvErLazpWYnvpEwqc/iF7E4hKZWuHUnbgRl27LnK9TQ==
X-Received: by 2002:adf:f5c7:0:b0:34a:d1d4:cb3c with SMTP id k7-20020adff5c7000000b0034ad1d4cb3cmr9833037wrp.39.1714433082505;
        Mon, 29 Apr 2024 16:24:42 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b0034d7a555047sm315284wro.96.2024.04.29.16.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 16:24:42 -0700 (PDT)
Message-ID: <463bcd2f-c741-4120-b7ae-2bb55d5211e3@linaro.org>
Date: Tue, 30 Apr 2024 00:24:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Work around missing MSA_READY indicator for
 msm8998 devices
To: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 15:01, Marc Gonzalez wrote:
> Work around missing MSA_READY indicator in ath10k driver
> (apply work-around for all msm8998 devices)
> 
> CHANGELOG v3
> - Add a paragraph in binding commit to explain why we use
>    a DT property instead of a firmware feature bit.
> - Warn if the "no_msa_ready_indicator" property is true,
>    but we actually receive the indicator.
> 
> Marc Gonzalez (3):
>    dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
>    wifi: ath10k: do not always wait for MSA_READY indicator
>    arm64: dts: qcom: msm8998: set qcom,no-msa-ready-indicator for wifi
> 
>   Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml |  5 +++++
>   arch/arm64/boot/dts/qcom/msm8998.dtsi                           |  1 +
>   drivers/net/wireless/ath/ath10k/qmi.c                           | 11 +++++++++++
>   drivers/net/wireless/ath/ath10k/qmi.h                           |  1 +
>   4 files changed, 18 insertions(+)
> 

I wonder if you could infer the workaround based on firmware version, 
instead of kernel passed flag ?

---
bod

