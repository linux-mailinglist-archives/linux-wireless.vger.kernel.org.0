Return-Path: <linux-wireless+bounces-4380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DE872080
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 14:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5033AB27FD5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665E85920;
	Tue,  5 Mar 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="QNuzpWb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA184A48
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646075; cv=none; b=ivdcKNZ8CevrQVABL0JkNB/290DcM+JApQUaza32ldlNgWBtHcqFtgLbBJlmEabbZcP7niz5+rWx1MBqCyIx/QXeqex2m8H2GfbMEVKtpZp9aqUoO+rvJ9A4cYi4Q4HZnSus5uKcAeQt3biHmYvr887bIw2QNWJrX1BlROL4IFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646075; c=relaxed/simple;
	bh=8o53L5Lk5BZaa5VeWtc1gnuSD4KrasUsHwk5A9UIlFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTODXE0giuoI8EYJAvm5XbyUoqPVS6q2njBhvXWpfaU4gnYfymVeSPzdpO/0JKSXYqazZJF51elLVEhuWypZqn36CL+s8QEJWe8cpHMCW3zOpWb/Vb92grvaM9iUZ5SpjZaJwn4K9cJ4LHEnVRd39gMfedO5b/ksu0jfeVauE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=QNuzpWb8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso6858650a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 05:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709646070; x=1710250870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWMosuJd6KOK3Ke8ji6R8Nxsr6pMCIN4zMcfmAiXvcI=;
        b=QNuzpWb8VftY0O7mHRbZ6o0HoexuVS8d7+7rSl0B5OWXkaoRsM/DiDVueSDeASOhv6
         qla8hjsqSycKUL6MrgrAPW5zhFDysYLcBQu/7AHY1Hpmt7j+pEY0QBuc9uLPr/vrH403
         QvmuUSRuLkLEc2Mvf6rf4R54+iD+WVbgPok/6i37hsL4dakuJkGm/+CHii7io/NrJIOb
         qfTemSh+lXP6GQaIqfLxCkM0Z/ZTjQ/kUnh0mGrQQMWOjmskw8TcTixuoIVkMux77wsQ
         q/UuKJvPR/FKd4f6+/heqT6sAmn488i4610uPa4n/ct2uS8M4LKfN/4jxobddKyy8E5P
         UK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646070; x=1710250870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWMosuJd6KOK3Ke8ji6R8Nxsr6pMCIN4zMcfmAiXvcI=;
        b=E7KbFoB0Fzdc2fa5oKdX1worSdt93Zdoww74nAwSsoxl2SP7thGaud1ys4mlfvCtEJ
         WnG2LTJsHIhQEJZSznfW8HFSAXSShSjs7NVSTF4HUXy9x9CwVVR7IQPNb1SxvGVTkoGU
         AxWYqbAEoSYcj6W0JzjWrBUAfFSv10NaeJcJSrdLIw0bLBr1jdagxw0RmgoEOZifklX9
         WTPpGRdOmK82q52qVeyUamRlcsz02kyjOAk/S8h03JoiaarAkXZ8exceZ6Pn7T2QrM4e
         2Re2XdeRlBA1YwB7hbJTk5yjpasjuEHImL+McarhK0K4ivq3lLUHBDeZrNPaOgMoAHWA
         wGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX98Zad+8yLz2hQClDmks0EXZi1tRDRNnmFYQy+PaaObZ05nGSyJ44bLczm8M4E9LMG3jUXp9p+pRYdB9z84UHXyD1J0ZdYsO59HZBnN6o=
X-Gm-Message-State: AOJu0Yxatcos5xkNYaoDs3oesNiBebtZQ1z1TAjpv/DsSIEswQpneSWF
	6cGqKvI1EwL7D1mvEmMnaRzFTgMUUTQNelx7n1gBIiMTzAjOFksvwPB2ijsl/eg=
X-Google-Smtp-Source: AGHT+IHOy4H+KwN+3BZ2BxwwFf9wu6lXSZYWE8FaLOKY/ogkOvlTx3vkijOKPnd5EhunmsO46V6uLw==
X-Received: by 2002:a17:906:558:b0:a45:ae87:ec09 with SMTP id k24-20020a170906055800b00a45ae87ec09mr570427eja.60.1709646070166;
        Tue, 05 Mar 2024 05:41:10 -0800 (PST)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00a4558314ea0sm2190947eji.15.2024.03.05.05.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:41:09 -0800 (PST)
Message-ID: <4df78b7e-92dc-45e4-9d5f-9ec8793c4fd3@freebox.fr>
Date: Tue, 5 Mar 2024 14:41:08 +0100
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
To: Conor Dooley <conor@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
 <20240304-component-animator-e2ee0ab7574a@spud>
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <20240304-component-animator-e2ee0ab7574a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 20:34, Conor Dooley wrote:

> On Mon, Mar 04, 2024 at 05:21:37PM +0100, Marc Gonzalez wrote:
>
>> On 29/02/2024 19:40, Conor Dooley wrote:
>>
>>> On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
>>>
>>>> Marc Gonzalez wrote:
>>>>
>>>>> As mentioned in my other reply, there are several msm8998-based
>>>>> devices affected by this issue. Is it not appropriate to consider
>>>>> a kernel-based work-around?
>>>>
>>>> Sorry, not following you here. But I'll try to answer anyway:
>>>>
>>>> I have understood that Device Tree is supposed to describe hardware, not
>>>> software. This is why having this property in DT does not look right
>>>> place for this. For example, if the ath10k firmware is fixed then DT
>>>> would have to be changed even though nothing changed in hardware. But of
>>>> course DT maintainers have the final say.
>>>
>>> I dunno, if the firmware affects the functionality of the hardware in a
>>> way that cannot be detected from the operating system at runtime how
>>> else is it supposed to deal with that?
>>> The devicetree is supposed to describe hardware, yes, but at a certain
>>> point the line between firmware and hardware is invisible :)
>>> Not describing software is mostly about not using it to determine
>>> software policy in the operating system.
>>
>> Recording here what was discussed a few days ago on IRC:
>>
>> If all msm8998 boards are affected, then it /might/ make sense
>> to work around the issue for ALL msm8998 boards:
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
>> index 0776e79b25f3a..9da06da518fb6 100644
>> --- a/drivers/net/wireless/ath/ath10k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
>> @@ -1076,6 +1076,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
>>  	qmi->ar = ar;
>>  	ar_snoc->qmi = qmi;
>>  
>> +	if (of_device_is_compatible(of_root, "qcom,msm8998")
>> +		qmi->no_point_in_waiting_for_msa_ready_indicator = true;
>> +
>>  	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
>>  		qmi->msa_fixed_perm = true;
>>  
>>
>> Thus, anyone porting an msm8998 board to mainline would automatically
>> get the work-around, without having to hunt down the feature bit,
>> and tweak the FW files.
> 
> How come the root node comes into this, don't you have a soc-specific
> compatible for the integration on this SoC?
> (I am assuming that this is not the SDIO variant, given then it'd not be
> fixed to this particular implementation)

I see only
"qcom,ipq4019-wifi"
"qcom,wcn3990-wifi"
"qcom,wcn6750-wifi"

arch/arm64/boot/dts/qcom/msm8998.dtsi uses "qcom,wcn3990-wifi"
(which is also used for 9 other SoCs).

IIUC, you're saying there probably should have been a generic
compatible AND a board-specific compatible, like for ufshc:

$ git grep qcom,ufshc arch/arm64/boot/dts/qcom
arch/arm64/boot/dts/qcom/msm8996.dtsi:                  compatible = "qcom,msm8996-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/msm8998.dtsi:                  compatible = "qcom,msm8998-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
arch/arm64/boot/dts/qcom/sa8775p.dtsi:                  compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
arch/arm64/boot/dts/qcom/sc7280.dtsi:                   compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sc8180x.dtsi:                  compatible = "qcom,sc8180x-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sc8280xp.dtsi:                 compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sc8280xp.dtsi:                 compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sdm845.dtsi:                   compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm6115.dtsi:                   compatible = "qcom,sm6115-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
arch/arm64/boot/dts/qcom/sm6125.dtsi:                   compatible = "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
arch/arm64/boot/dts/qcom/sm6350.dtsi:                   compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm8150.dtsi:                   compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm8250.dtsi:                   compatible = "qcom,sm8250-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm8350.dtsi:                   compatible = "qcom,sm8350-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm8450.dtsi:                   compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm8550.dtsi:                   compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
arch/arm64/boot/dts/qcom/sm8650.dtsi:                   compatible = "qcom,sm8650-ufshc", "qcom,ufshc", "jedec,ufs-2.0";


If all msm8998-based device trees had (for example)
a qcom,msm8998-wcn3990-wifi compatible, we could have
matched that to apply a quirk to all msm8998 boards.

Did I understand correctly?

(In the toy code I provided, I matched the of_root because
there is no SoC-specific compatible for the device itself.)

-- 
Regards



