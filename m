Return-Path: <linux-wireless+bounces-1714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BCE82AEF6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 13:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FECB22B2D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273E15AF8;
	Thu, 11 Jan 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6TUWK5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68815AF7
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5fa4b03f3f5so21722627b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 04:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704977307; x=1705582107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6whrmn+g/DFxEN3vjjKCiQLmg4dZXZT9/IAiHb8rGs=;
        b=e6TUWK5CqwOhD2v08ZJYFzY42Fdhe7P4/QovPidFHNLJoOmV84p4JxgsUUqUUXmivy
         irXZOKGCbPbC42f+3RN99UHsfmkbHTMRflo68iITto+hIIifWqB2xwjxKUUUrgynOXu9
         1DT/ntFtA4lZGPEMGgMv8xVN+x5vGHAioNeTMVs4c1bhD7wAYpCOdDGCCGf5V2385t90
         wogRInyUh6pEz4IInXt6ZuUdsRU96PjBNyHCPhIfXbs2sPPAB3VrKTx2Xs5PK3lVCDBL
         Ho9+VmbQPKxSW1elB5w7QjcLIzxiIRqBFVlkgeYaLdydtgNISViPuUixKjQ9WOpRwhjK
         8LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704977307; x=1705582107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6whrmn+g/DFxEN3vjjKCiQLmg4dZXZT9/IAiHb8rGs=;
        b=WwRfTu/rt/K1AlMCI97kKWoX5mWmdcyvXNbzgzE/Y5nyxTdw+D11L4kSyOlSDhEZiF
         uKcNktsBllDj0TvkUwYOY32Iru9Dd7JcJkbyFi15QYCWyjNT10AvTMrHfbJVANHX4cJN
         iqKIjjdwVfrh21IrBtAdNxN7izuYJrcAvhkxZSiKRLc1pHQ4r09gh6dDjCzrG0RRH+Ih
         Du51sO8XSef4hkCqZkpVLuWY48dw6C1aHeL+rguxjiizXLyiE66xJzxbLNbpqvy8+kP8
         bA+jBFCE+vyKhhqAv28QA+HuDBIL9T/nOzTfJSg3eg6zNg50/5fLoBpaFJzyev4wQMOw
         j/OA==
X-Gm-Message-State: AOJu0Yzfx63L+mCwem4DowpownxETc0FF3DTCWAMxWl2JuBClHyzo8IX
	mjA138zXNz6C+N2dk0h+mUHtWiNwoJE=
X-Google-Smtp-Source: AGHT+IGIiiSCnLuz9aK/rkGfErwMC8jvAY1lkl+G/3llyfHBz5E9MjuaSY9IQW3UumTLhKw8ax0yqQ==
X-Received: by 2002:a81:99d2:0:b0:5d7:60ed:6a93 with SMTP id q201-20020a8199d2000000b005d760ed6a93mr510107ywg.54.1704977306991;
        Thu, 11 Jan 2024 04:48:26 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a22d800b007831f8c5aeasm315052qki.55.2024.01.11.04.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:48:26 -0800 (PST)
Message-ID: <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
Date: Thu, 11 Jan 2024 04:48:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87mstccmk6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kalle, Baochen,

On 1/11/24 12:16 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>> Hi Kalle,
>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>
>>>>>> But I have also no idea what is causing this, I guess we are doing
>>>>>> something wrong with the PCI communication? That reminds me, you could
>>>>>> try this in case that helps:
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>> Heh, I saw this pop up a day after I sent this and was wondering. Is
>>>>> this something I'd need on the host kernel, guest, or both?
>>>> On the guest where ath11k is running. I'm not optimistic that this would
>>>> solve your issue, I suspect there can be also other bugs, but good to
>>>> know if the patch changes anything.
>>> Looks the same here, didn't seem to change anything based on the
>>> kernel logs.
>>>
>> Could you try this?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c
> This reminds me, I assumed James was testing with ath.git master branch
> (which has that commit) but I never checked that. So for testing please
> always use the master branch to get the latest and greatest ath11k:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>
> There's a quite long delay from ath.git to official releases.

Good to know, and I was not in fact using that branch. Rebuilt from 
ath.git/master but still roughly the same behavior. There does appear to 
be more output now though, specifically a firmware crash:

[    2.281721] ath11k_pci 0000:00:06.0: failed to receive control 
response completion, polling..
[    2.282101] ip (65) used greatest stack depth: 12464 bytes left
[    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
[    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
[    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
[    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
[    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
[    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
[    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
[   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode request 
(mode 4): -110
[   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode 
off: -110

Thanks,

James


