Return-Path: <linux-wireless+bounces-2093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9A8306F0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8651F26423
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDC1EB49;
	Wed, 17 Jan 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZmVh13P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F531EB24
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497629; cv=none; b=YYhEEJ/3uvlbLHvj/5ayUaKjR/G+pJpb+DOqpQEvDmNSuKvgLG1nOvWWhiO0rTzRglYKdMVW+PrNAJ3JEAV6/qaj2YhXBDv6O/VpjMbFSwNU2u6Na1kfVNtXiRvAra1845q9vPBBEZTqrtxZDhsF1aF8dInPnb6sU01lr4dyrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497629; c=relaxed/simple;
	bh=totttXj8dGPuahsjJvn8NNbD4AtslA//K2/BLdkuTAY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=ISW0uSTom7veRk2cNUOK+IXviJVWwyBmqtWgl8lkZNCV1eEz2KO9nw4O1nNHbIizQ1Tyt9B0AjoGCASo5KdlrmDYmrgvYz6/rblrl2sK3hXy+Bz1PhDhaXBAuGw4rOlUJtl60SRxxt4FrnuRwYFP7VzpXLOLuU6jWxX/BB4vJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZmVh13P; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7836fea0ea2so61914285a.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705497626; x=1706102426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ayacpk0mYFVAI8Zmor+mj51uWH17gR3u7QFZfKXaCao=;
        b=DZmVh13PZT3ePR8vpx0dja1sAVDOj3ZpvwRDAOrHP8ElYs+TV0KeUsZXV/thvDoHH8
         PyCjafZ/4V+qgvvhjfA9aqxnGsw44sQPfdm9GGtbi7L+qDf3W5TRLoL9tRBk/gWi+EC5
         O9jVjsvajE537KNMhm62qtOk4yb8wSu1l0cEiBheDRKbWfKcjB1ykDYZFG0Qk4HfJ4nF
         4Vkzni1bzJP6Z22jIQ/H34naU9lpZo8wP9jTnYsCPhUYWqpexIms+OtRXYngebntpw3S
         J0P+j+kfgXlW3jbKjglU+5pnoj63V163ZqMO8MD9d6v1FfcCv2KbEIBlg1y6GJn1k95R
         +1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705497626; x=1706102426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayacpk0mYFVAI8Zmor+mj51uWH17gR3u7QFZfKXaCao=;
        b=Z/tceDTLOQYQ+jw7YO7xGChz2rlW6wtatk+vahOeGjq6CXbPdrmCea62nc9VpgQERK
         OWw8JCUuaREoZp+7orEneBGDe2xYJql7+vvKe2VaoEQH53Fxksh2OWJdnn14pHbjgvg7
         9qFEHbaRJxjIxMhthJ5FD/oEJaDi45HdD1gHQImE5dVSg+OGNtKDON09bUgIoaHIVFNo
         YE5B+qNcrmBObUviSvkGgtngv8PTAqLTKcnP4XOVCoFqpA57lfCGousVt7W01aqjuxLY
         dt6fFNuHcHatCaN887+0Ihvx0aMowcKgGvGnr+sWnj6BQf2b9ydw8Po/DJ13L6a9v5CX
         f42A==
X-Gm-Message-State: AOJu0YzGQ3SC7s0P/va7gVgjG3AExfaJcEQkdzrZOt++IKZzYbeiHl2S
	ILbS614XXX+Zvu5+kY5LFIQ+UG0bgoE=
X-Google-Smtp-Source: AGHT+IEaJK5Q6fRGT5r0up1X7hjzPl1BKX4+mHAJ/6UQ4kh4T+61U6WyhpQLyAEDalAyUPCYfKmy1g==
X-Received: by 2002:a05:6214:230f:b0:681:2640:3c17 with SMTP id gc15-20020a056214230f00b0068126403c17mr12740581qvb.55.1705497626436;
        Wed, 17 Jan 2024 05:20:26 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ee14-20020a0562140a4e00b0067f64c06bcesm4979071qvb.102.2024.01.17.05.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 05:20:25 -0800 (PST)
Message-ID: <cdec259a-b779-4856-8585-f285179e3671@gmail.com>
Date: Wed, 17 Jan 2024 05:20:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org> <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
 <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

<snip>

>>>
>>> While I don't think there is a way for qemu/ath11k to get the real 
>>> MSI vector from host, I will try to read the vfio code to check 
>>> further. Before that, to unblock you, a possible hack is to hard 
>>> code the MSI vector in qemu to the same as in host, on condition 
>>> that the MSI vector doesn't change. In my case, the change looks like
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
>>> b/drivers/net/wireless/ath/ath11k/pci.c
>>> index 09e65c5e55c4..89a9bbe9e4d2 100644
>>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>>> @@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct 
>>> ath11k_pci *ab_pci)
>>>                 ab->pci.msi.addr_hi = 0;
>>>         }
>>>
>>> -       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
>>> ab->pci.msi.ep_base_data);
>>> +       ab->pci.msi.addr_hi = 0;
>>> +       ab->pci.msi.addr_lo = 0xfee00578;
>>> +       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x 
>>> base data is %d\n",
>>> +                  ab->pci.msi.addr_hi,
>>> +                  ab->pci.msi.addr_lo,
>>> +                  ab->pci.msi.ep_base_data);
>>>
>>>         return 0;
>>>
>>> @@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
>>> ath11k_pci *ab_pci)
>>>         }
>>>
>>>         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
>>> +       ab_pci->ab->pci.msi.ep_base_data = 0;
>>>
>>>         ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
>>> msi_ep_base_data %d\n",
>>>                    ab_pci->ab->pci.msi.ep_base_data);
>>>
>>>
>>> This hack works on my setup.
>>
>> Progress! Thank you. This didn't work for me but its likely because 
>> my host MSI vector is not fee00578. Where did you come up with this 
>> value? 
> It could, and most likely, be different from machine to machine.
>
>> I don't see anything in the dmesg logs, or in lspci etc.
>>
> fee00578 is the physical MSI vector so I got it using lspci in host, see
> ...
>         Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit-
>                 Address: fee00578  Data: 0000
>                 Masking: fffffffe  Pending: 00000000
> ...

Mine looks like this:

...

     Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit-
         Address: 00000000  Data: 0000
         Masking: 00000000  Pending: 00000000
...

I've adjusted the patch:

diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
b/drivers/net/wireless/ath/ath11k/pci.c
index 09e65c5e55..1cc7115582 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci 
*ab_pci)
                 ab->pci.msi.addr_hi = 0;
         }

-       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
ab->pci.msi.ep_base_data);
+        ab->pci.msi.addr_hi = 0;
+        ab->pci.msi.addr_lo = 0;
+        ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base 
data is %d\n",
+                   ab->pci.msi.addr_hi,
+                   ab->pci.msi.addr_lo,
+                   ab->pci.msi.ep_base_data);

         return 0;

@@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
ath11k_pci *ab_pci)
         }

         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
+       ab_pci->ab->pci.msi.ep_base_data = 0;

         ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
msi_ep_base_data %d\n",
                    ab_pci->ab->pci.msi.ep_base_data);

But still getting the same errors:

[    3.563057] ath11k_pci 0000:00:06.0: Service connect timeout
[    3.565044] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
[    3.567031] ath11k_pci 0000:00:06.0: failed to start core: -110
[    3.777514] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
[    3.777555] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
[    3.885137] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
[    3.885178] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000

I know this isn't a proper fix, so if its something that needs more 
thought than just hard-coded values I understand.

Thanks,

James

>
>> Thanks,
>>
>> James
>>

