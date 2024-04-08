Return-Path: <linux-wireless+bounces-5974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B67889C8D4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F7228327C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9411420C6;
	Mon,  8 Apr 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="Xu4WFH6E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2D1420BB
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591586; cv=none; b=fZcctYwjO50DxCb0YmKpYCcsIfdXmYmfRcs3pzNNjHmT7d1XQAlib5So+UIeF2btF1Ckur9mi5AablssWq3gs/HUOUMQzEMvFqVs3GmmMYASOHXVbZzgGmGsDAt3Y8mDeQCNTT5wgCn7SDQOIigZorJ1B95d/1zd/lkIMhlYmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591586; c=relaxed/simple;
	bh=o4sMfO3P+yHIzU4znX3Ln+B4/lunBLP/NFn03V3qShA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZB1SayzRx+YSHH6isII9fy1HpfT8lXCn/ktBd574zu4TMJ4EkABGz+dVZZ4E2iidHJq2FlF+K9V13c6ofOCF01ce2nD38d7xOwSsDC1+AdDxfqeITHE3e5KvZ+PhAQ9mVuEN8BCqBR+6eVybgNZrU9CHzB44T2rHEmQPe1UFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=Xu4WFH6E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343b7c015a8so2896898f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Apr 2024 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1712591582; x=1713196382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PV2QGCABE36oWSsPi/l6CQE6DAlPBHE1k65KDD12Caw=;
        b=Xu4WFH6ExaEjmRxntUEBVoALd+sLinkF1Wx8YEZ8i5fMlVMTD6U5UhCcv01vn04+mA
         E+rZRi2E0w3t/IGTfrS++QcDFuul4omM6CaD+Y28dWyvV9xLkz+/x+DtDRVcixnCxwR8
         nCC/lEDU7rL2ocNpJvSIrir7WDoocAQ/fFRGn56MsHG0TUky1yog7wzuy/lSlJZgaihE
         UO4iPzbcAhOugF9XkhIZ3MPF9YX2h1f7lT1g9Fm/nytCh1etDTRQZIoTSDygoXWAof6h
         Ud8rtcpc+chEu+trXufRAabxLuvLm/Y6lCDTISjjO0/bSJRZM/2FwqcqDtjXw+LExMMV
         GfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591582; x=1713196382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV2QGCABE36oWSsPi/l6CQE6DAlPBHE1k65KDD12Caw=;
        b=QFr2RyvLjw8MSb0ht6J6M7HnefGOJbnJ6ZV8bwptpV+Lq70QBEK7Hfycz/jztgovgp
         lx0bcXaS2IIDjnHFTk1wh444lAkTNTy/QBSemkxMbY+pC3y0bSVn39XJiXQzZ0ukTo0e
         lwIdPQ+nWuk8RZW9cFsJZMw9w+kIh4LApioFVIki+5OuF9KgSIGH3SnfNapimZO/+WN/
         beD38Y2yMJesKir6xbNEHVy8j28sGJ5734VOj68Wp+3YGHbX0qRoOkZWNJmyC4wSpN3L
         V2XVVkB3y2zhTm7XRJFPQO/LflC/Ol3TBvR6F1MM+m71TxsKMy/XhB+En7Wb9ezaIQgc
         747g==
X-Forwarded-Encrypted: i=1; AJvYcCUfGHNFb4FJfhGTQdNVcz38nct0NkjBJy5CbirOtqcLivBE7BhFb+6DgOLGurccd1qUOialabtrakm0RAuFFvpniHlBfVIcUMx/VTHndvU=
X-Gm-Message-State: AOJu0YxR+WuY0xWJBa0Sl6ZWtXnO6QXGPBAHcDVByPMJMl0oMoK3XHEm
	yHgNAyTnjAA67g1bACePMR/dI3M9kTaYgeMVKDsGEk0q26kK5zy9Sp/KwyFql38=
X-Google-Smtp-Source: AGHT+IF87J4Q/rgFnwCIm8WBGlFyl1vMp8m6s/lxg+SxFZ0lmZ8/wXNjMI8XEjSdYdJzrpjZ6SXNIA==
X-Received: by 2002:adf:e647:0:b0:345:5ff1:245d with SMTP id b7-20020adfe647000000b003455ff1245dmr4115241wrn.32.1712591582423;
        Mon, 08 Apr 2024 08:53:02 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b00343daeddcb2sm9341328wrs.45.2024.04.08.08.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:53:02 -0700 (PDT)
Message-ID: <ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr>
Date: Mon, 8 Apr 2024 17:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
To: Kalle Valo <kvalo@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k
 <ath10k@lists.infradead.org>, wireless <linux-wireless@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
 <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
 <87ttkh49xi.fsf@kernel.org> <e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
 <87h6gh406w.fsf@kernel.org>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <87h6gh406w.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 17:28, Kalle Valo wrote:

> Marc Gonzalez wrote:
> 
>> On 04/04/2024 13:57, Kalle Valo wrote:
>>
>>> Dmitry Baryshkov wrote:
>>>
>>>> I'd say, we should take a step back and actually verify how this was
>>>> handled in the vendor kernel.
>>>
>>> One comment related to this: usually vendor driver and firmware branches
>>> go "hand in hand", meaning that a version of driver supports only one
>>> specific firmware branch. And there can be a lot of branches. So even if
>>> one branch might have a check for something specific, there are no
>>> guarantees what the other N+1 branches do :/
>>
>> The consequences and ramifications of the above comment are not clear to me.
>>
>> Does this mean:
>> "It is pointless to analyze a given version (or even several versions)
>> of the vendor driver downstream, because there are exist a large number
>> of variations of the code." ?
> 
> I was trying to say that because the design philosophy between vendor
> drivers and upstream drivers is very different, we can't 100% trust
> vendor drivers. It's a very good idea to check what vendor drivers do
> but we just need to be careful before making any conclusions. Testing
> real hardware (and corresponding firmware) is the most reliable way to
> know how different products/firmware work, unfortunately.
> 
>> And thus, "it is nonsensical to try to "align" the mainline driver to
>> "the" vendor driver, as there is no single "vendor driver"" ?
> 
> No no, I'm not saying that. I have suffered this "N+1 different firmware
> branches behaving slighly differently" problem since ath6kl days so for
> me this is business as usual, sadly. I'm sure we can find a solution for
> ath10k.

Hello Kalle,

I can spin a v3, no problem.

Do you prefer:

Option A = never waiting for the MSA_READY indicator for ANYONE
Option B = not waiting for the MSA_READY indicator when qcom,no-msa-ready-indicator is defined
Option C = not waiting for the MSA_READY indicator for certain platforms (based on root compatible)
Option D = some other solution not yet discussed

Dmitry has tested Option A on 5 platforms, where it does not induce regressions.
I worked on msm8998, where Option A (or any equivalent) unbreaks WiFi.

Please provide guidance :)

Regards


