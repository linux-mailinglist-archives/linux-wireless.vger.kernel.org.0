Return-Path: <linux-wireless+bounces-1718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E182AFD4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9FA1F22C15
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284032C7F;
	Thu, 11 Jan 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw9I0ThP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF932C6C
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4299e43a712so18145981cf.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704980332; x=1705585132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qholcl4vTuarhGXHoLJbL1nGyNZ5u3Lwy4788FltX8c=;
        b=Iw9I0ThPDM9JNOe8kY/L5OCKAy1tbM7dJsO7CZ1/Bobtz8WLurXu5FfpiciiXMSWc2
         S4MbeF228y7sySIIxvcw3gByFnGnZ7rvJDplRLxiRLjIcOyrbv9xkLVhMzqPDyz5DUZB
         qwdNU06C3hvjsQpasrure0o5js6QCn4vST2ba4OGXg36jd6bX5xXq0uI/A/kcCUsExmW
         xcavCIbtjuZRgfj/Sma8iTX6ySJd/Vp7hInjLAxixFsz8jC6v7EesAVdnjgLq0C6bxK9
         j37IY7Tj58ukuWRxE0a/h+HOzQdDpnWVBGDtsUq4QcqbBkegF+efci8qHZMxb2F+Unmv
         BTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980332; x=1705585132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qholcl4vTuarhGXHoLJbL1nGyNZ5u3Lwy4788FltX8c=;
        b=TnNBDGDFTWrrrGNvUtPihSsYBQVdhutBl2Robi1WLYsCDzYZ5+UZnclL7KhDro8OSo
         7mfwwGN6TkodQgVPLLmGTgGK5MYpgvneQFJVi3z4B+2fZcRTbFIAt9N8AI5pRY94YXpG
         A93MoRjh7riwy7xBi81nUz1RoojEScB+SZ88v2NUzcjOBQj3uG/5FxUtruku3mhPIymi
         wLzybyeChRi49ioHEhO5XeHX4WINY3631X65Lu4NkzxaEYpxL+vyFr3fyxCcLnWNUOQc
         rlZlQypqi1y1OWa9QbOK4EjmCvmh0MagbiHyzXqKySR3P1U/EIkxY7LoPzhzdrVbYkqy
         w/3Q==
X-Gm-Message-State: AOJu0YyNGtEX9IpC/tsr44u7/8yqNP6HlWsDb9AWOY7UwhQdyt9HexPd
	Tr+3qFQtLVZScqlRABaiq/E=
X-Google-Smtp-Source: AGHT+IFWartU9uhnCflOnfggaMnnGu/nXobBrdUEhsvWG6RL3MWsrJWLDYiu5zK/l7vf/9HaCrCj6Q==
X-Received: by 2002:ac8:5ad0:0:b0:429:c5d8:3f0c with SMTP id d16-20020ac85ad0000000b00429c5d83f0cmr797463qtd.93.1704980332546;
        Thu, 11 Jan 2024 05:38:52 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w18-20020a05622a135200b00427e3f2ff25sm426379qtk.78.2024.01.11.05.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 05:38:52 -0800 (PST)
Message-ID: <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
Date: Thu, 11 Jan 2024 05:38:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <8734v4auc4.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/11/24 5:11 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>> Hi Kalle, Baochen,
>>
>> On 1/11/24 12:16 AM, Kalle Valo wrote:
>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>
>>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>>> Hi Kalle,
>>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>
>>>>>>>> But I have also no idea what is causing this, I guess we are doing
>>>>>>>> something wrong with the PCI communication? That reminds me, you could
>>>>>>>> try this in case that helps:
>>>>>>>>
>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>>>> Heh, I saw this pop up a day after I sent this and was wondering. Is
>>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>>> On the guest where ath11k is running. I'm not optimistic that this would
>>>>>> solve your issue, I suspect there can be also other bugs, but good to
>>>>>> know if the patch changes anything.
>>>>> Looks the same here, didn't seem to change anything based on the
>>>>> kernel logs.
>>>>>
>>>> Could you try this?
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c
>>> This reminds me, I assumed James was testing with ath.git master branch
>>> (which has that commit) but I never checked that. So for testing please
>>> always use the master branch to get the latest and greatest ath11k:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>>
>>> There's a quite long delay from ath.git to official releases.
>> Good to know, and I was not in fact using that branch. Rebuilt from
>> ath.git/master but still roughly the same behavior. There does appear
>> to be more output now though, specifically a firmware crash:
>>
>> [    2.281721] ath11k_pci 0000:00:06.0: failed to receive control
>> response completion, polling..
>> [    2.282101] ip (65) used greatest stack depth: 12464 bytes left
>> [    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
>> [    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
>> [    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
>> [    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
>> [    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>> [    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
>> [    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>> [   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
>> request (mode 4): -110
>> [   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode
>> off: -110
> Ok, that's progress now. Can you try next try the iommu patch[1] we
> talked about earlier? It's already in master-pending branch (along with
> other pending patches) so you can use that branch if you want.
>
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/

Same result unfortunately, tried both with just [1] applied to ath.git 
and at HEAD of master-pending.

Thanks,

James



