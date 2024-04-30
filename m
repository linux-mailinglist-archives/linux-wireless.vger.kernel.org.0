Return-Path: <linux-wireless+bounces-7039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7918B72AC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FD52826E7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167468801;
	Tue, 30 Apr 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="P9OCNXbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AB12D1F4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475452; cv=none; b=eQd89gtHzMfqfI0YAVrNo3qLSdfCZKsBwb+5+XaX7JGzVGc3xXuPFGX/Ubc3zTX6m7ghtJIZMYzM/39hw2OZy25LzBNrtso3Z5bYoXEicpBd2VOvmvLCorR7UBtlNUeb/4R2vsCg/fZxZTEBx+jKKMimqsoJ+Cw1Cbx36zWCM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475452; c=relaxed/simple;
	bh=9wFxLBqV8gHEoV/6++2pbOAsb7GIV+1fcEeXcgCzTGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUhyZB4U8rJFGNIHe06rFF8wKvQEMvW3WBLocOPJuH/lgca8H+1W/rukqc6TX84ORrI1YTHzomWLjVacmr3cRdfBraadMdRz+kP/txJ68FttX+siF7ImPsZmPNDqhrLIiWAK+VAuLJHED9FvCJU+WHZcQZa7t3udDRi895uITUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=P9OCNXbf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34d8d11a523so294966f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714475447; x=1715080247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIvWhOtQaSbhbwjiVrfaYv89apMYv7P7i1/N8DdL+Ko=;
        b=P9OCNXbfJilgamkQT8WIaZw5A0RhnXiL9K/yVBBAMujjUEGDO+PWBA0Pbb4XehFFlQ
         2XoW5+Sfy9KV4ptP2uEOcgDxn27h1dB/n3TgoxH0RI172XCJW7Hfh0O4rUDC5IJ9uZYu
         UpImnl/LOZufRaTqbyP1+9uns2rClspV8ImSchM7ySv2d3OC6b0MR02HZdJzuI+BEnhO
         9S7JBaF/p9HvqrOV6vxLkeiyV599g4DsoHrtNM6fef/7kAjzJix28dMwKgtGVR8BggfA
         Q4KdlUXzyoQf0kcZhb6tada7VSHUSinAj9/E9BryNplz7ZHEBguZLvX1EAERqRXjU5gB
         i5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475447; x=1715080247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIvWhOtQaSbhbwjiVrfaYv89apMYv7P7i1/N8DdL+Ko=;
        b=p5oLfxfb6zSJiEsgk4qHyGdG/QkFpSJ+9MA9OaszLs7rbKi3FMjJrp1PhM4rbj1Mnn
         8Mi7+lCDE85p217MhkLEzkBGTpWRfcQ9IYA6dvWZfrdk0aVwnD4fDAtjMxf8J5miO1Yd
         ZvoTZf/xovpYLyPxtplNR1EdwU8w3xCIoF8y9vQZyfvQnfcvhGWbGpjk35xZFcZRj1vy
         dEhAAC/wG2VJ6+fijAHNOJ9C18bRfndoJNITfYiz1WdcbcyyEUKEPmmkA7yeNWDJPL07
         dF0oBxh4cOrCetOUneTQJygYZjzuinzXjB8L8PMc9HkvcMjpyLsQsrjoIk1614fFGMwr
         n4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU+wrI+EYttBfj3Fb2GhoL8pyTpho6yDHkNGoSyRhV0KrBQ6DWtJM6UxD2dIxvQo4ajKvRkB0eBbUOJG0tfBRliziOTeKI8bzhFvN/AP9M=
X-Gm-Message-State: AOJu0YxNyuWNxRo8NwfTKdqCob09ezeVeH4C6Sl2xI6+27J6yjzSGwFV
	m2ogg0gLiA4qEkVSeaqMF56Qk5LZivUhRgPZgamFvcqKQXiO7IsAiVEEa7Dx3ro=
X-Google-Smtp-Source: AGHT+IGQOo0rskPzhDLRD7me8gspVxoemoUYNb/vPah60Lt9ZvK0rsJKvU9gxcYOnL3jSoqIaHMdCw==
X-Received: by 2002:a05:6000:d49:b0:349:eb5a:3b4f with SMTP id du9-20020a0560000d4900b00349eb5a3b4fmr1980272wrb.45.1714475446694;
        Tue, 30 Apr 2024 04:10:46 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id x5-20020a5d6b45000000b003472489d26fsm31853409wrw.19.2024.04.30.04.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:10:45 -0700 (PDT)
Message-ID: <b6a1eadf-477d-48a8-bf39-ac3c3191e929@freebox.fr>
Date: Tue, 30 Apr 2024 13:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
To: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 MSM <linux-arm-msm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
 <54ac2295-36b4-49fc-9583-a10db8d9d5d6@freebox.fr>
 <ZjBV+th9DmnNLhnN@hu-bjorande-lv.qualcomm.com> <8734r3qysm.fsf@kernel.org>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <8734r3qysm.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 06:06, Kalle Valo wrote:

> Bjorn Andersson wrote:
> 
>> On Mon, Apr 29, 2024 at 04:04:51PM +0200, Marc Gonzalez wrote:
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
>>>
>>> Kalle Valo first suggested setting a bit in firmware-5.bin to trigger
>>> work-around in the driver. However, firmware-5.bin is parsed too late.
>>> So we are stuck with a DT property.
>>>
>>> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
>>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>>
>> This says "Pierre-Hugues certifies the origin of the patch" then "Marc
>> certifies the origin of the patch". This would have to imply that
>> Pierre-Hugues authored the patch, but you're listed as the author...
>>
>> Perhaps a suitable answer to this question would be to add
>> "Co-developed-by: Pierre-Hugues ..." above his s-o-b, which implies that
>> the two of you jointly came up with this and both certify the origin.
> 
> BTW I can add that in the pending branch, no need to resend because of
> this. Just need guidance from Marc.

I typed this patch all by myself with my grubby little paws.
You can drop PH's S-o-b.

>> Other than that, I think this looks good, so please upon addressing this
>> problem feel free to add my:
>>
>> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Thanks, I'll then add this as well.

Cool. Almost there :)


