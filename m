Return-Path: <linux-wireless+bounces-1812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419282BFF0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 13:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02352863A2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761F59B55;
	Fri, 12 Jan 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHZMcgjs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D059B54
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6813ab2078dso6554846d6.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 04:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705063627; x=1705668427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7g4YqR/zubrO9qNwlFhZX3vRqYIObUAIcfTlTohn9o=;
        b=cHZMcgjsPQYAdb1Nu4aH7YxS0XPVEs+cpMlfodKqewtaJF/AaGw465PcIur+LHeSC1
         0Eih9LyTizy7V82xBwkez9EoBQE9vc550IueUsvpKlJN0RQd/WJ8Fv8IsArFeK+HIkm5
         u19bcJUX3O82Yq0247oIJ+ZNukWtuZk9vCr6fq/lp82SsxmxvgeTkw+1b+K9UU11V8O2
         m8MTtfIobbM9hI/BIfKy7aYaWjqgJBcXQXIC3QTflTJE0e+bdkccgD/bs3GLGctAitpg
         N+mD1w0Xg9GV8q6motY++MfDpG0SgIcthH3VrxqmVyziEWCe267s7g9qJcPIEOeiSh8h
         b5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705063627; x=1705668427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7g4YqR/zubrO9qNwlFhZX3vRqYIObUAIcfTlTohn9o=;
        b=qsLUf/BLZVRy/ZZEfQEHmn57qYJOFfmUR4F4NWSclE3pFt2XVOgrHh0Yko9DWN+GU4
         KLhJatjLPsVZFMd9hFeUQAvXz6H9/GpXf6t4+Szm0hbwht4rHA02tTyXkLmJsU10RQwm
         VGlmUMh67j6N734aZXpBaoS8cpms/vANYQANHmVhPCTUgKyX6+dtE5kzlr2p7YcwpFWt
         85qfn4sNpzx1oU40Y7BgPFLDf5+gOgB90N3Aq/BWBW7pFVyRZsij7DnuSnNUGIth3bu7
         uU1UWwle/WXtyxKuSq33ZXvNFubs4Qg5NLt98Y+8+PeIKI0ZocrLPBCskXn0SaV99Cqn
         f2bg==
X-Gm-Message-State: AOJu0YyEzIWMEyIuJNspp+cgUsnFrKW2VrlIH24fsv3VRHSL9fjmcwGp
	ZVmPM38rvP3UmRwWnJHVWNE=
X-Google-Smtp-Source: AGHT+IHWE64FifTd2MSsza7siBMGznvOgRD4Gjciqy6we/h3XrIgnNa6dLIcQUbiyPjFJRgJ4CvkLA==
X-Received: by 2002:a05:6214:29c3:b0:681:1977:c048 with SMTP id gh3-20020a05621429c300b006811977c048mr844699qvb.58.1705063627336;
        Fri, 12 Jan 2024 04:47:07 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id ei19-20020ad45a13000000b006805bd3058asm1018606qvb.75.2024.01.12.04.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 04:47:06 -0800 (PST)
Message-ID: <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
Date: Fri, 12 Jan 2024 04:47:04 -0800
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/11/24 6:04 PM, Baochen Qiang wrote:
>
>
> On 1/11/2024 9:38 PM, James Prestwood wrote:
>>
>> On 1/11/24 5:11 AM, Kalle Valo wrote:
>>> James Prestwood <prestwoj@gmail.com> writes:
>>>
>>>> Hi Kalle, Baochen,
>>>>
>>>> On 1/11/24 12:16 AM, Kalle Valo wrote:
>>>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>>>
>>>>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>>>>> Hi Kalle,
>>>>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>>>
>>>>>>>>>> But I have also no idea what is causing this, I guess we are 
>>>>>>>>>> doing
>>>>>>>>>> something wrong with the PCI communication? That reminds me, 
>>>>>>>>>> you could
>>>>>>>>>> try this in case that helps:
>>>>>>>>>>
>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/ 
>>>>>>>>>>
>>>>>>>>> Heh, I saw this pop up a day after I sent this and was 
>>>>>>>>> wondering. Is
>>>>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>>>>> On the guest where ath11k is running. I'm not optimistic that 
>>>>>>>> this would
>>>>>>>> solve your issue, I suspect there can be also other bugs, but 
>>>>>>>> good to
>>>>>>>> know if the patch changes anything.
>>>>>>> Looks the same here, didn't seem to change anything based on the
>>>>>>> kernel logs.
>>>>>>>
>>>>>> Could you try this?
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c 
>>>>>>
>>>>> This reminds me, I assumed James was testing with ath.git master 
>>>>> branch
>>>>> (which has that commit) but I never checked that. So for testing 
>>>>> please
>>>>> always use the master branch to get the latest and greatest ath11k:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>>>>
>>>>> There's a quite long delay from ath.git to official releases.
>>>> Good to know, and I was not in fact using that branch. Rebuilt from
>>>> ath.git/master but still roughly the same behavior. There does appear
>>>> to be more output now though, specifically a firmware crash:
>>>>
>>>> [    2.281721] ath11k_pci 0000:00:06.0: failed to receive control
>>>> response completion, polling..
>>>> [    2.282101] ip (65) used greatest stack depth: 12464 bytes left
>>>> [    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
>>>> [    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
>>>> [    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
>>>> [    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>> MHI_CB_EE_RDDM
>>>> [    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>>>> [    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>> MHI_CB_EE_RDDM
>>>> [    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>>>> [   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
>>>> request (mode 4): -110
>>>> [   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode
>>>> off: -110
>>> Ok, that's progress now. Can you try next try the iommu patch[1] we
>>> talked about earlier? It's already in master-pending branch (along with
>>> other pending patches) so you can use that branch if you want.
>>>
>>> [1] 
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>
>> Same result unfortunately, tried both with just [1] applied to 
>> ath.git and at HEAD of master-pending.
>>
>> Thanks,
>>
>> James
> Strange that still fails. Are you now seeing this error in your host 
> or your Qemu? or both?
> Could you share your test steps? And if you can share please be as 
> detailed as possible since I'm not familiar with passing WLAN hardware 
> to a VM using vfio-pci.

Just in Qemu, the hardware works fine on my host machine.

I basically follow this guide to set it up, its written in the context 
of GPUs/libvirt but the host setup is exactly the same. By no means do 
you need to read it all, once you set the vfio-pci.ids and see your 
unclaimed adapter you can stop:

https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF

In short you should be able to set the following host kernel options and 
reboot (assuming your motherboard/hardware is compatible):

intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103

Obviously change the device/vendor IDs to whatever ath11k hw you have. 
Once the host is rebooted you should see your wlan adapter as UNCLAIMED, 
showing the driver in use as vfio-pci. If not, its likely your 
motherboard just isn't compatible, the device has to be in its own IOMMU 
group (you could try switching PCI ports if this is the case).

I then build a "kvm_guest.config" kernel with the driver/firmware for 
ath11k and boot into that with the following Qemu options:

-enable-kvm -device -vfio-pci,host=<PCI address>

If it seems easier you could also utilize IWD's test-runner which 
handles launching the Qemu kernel automatically, detecting any 
vfio-devices and passes them through and mounts some useful host folders 
into the VM. Its actually a very good general purpose tool for kernel 
testing, not just for IWD:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt

Once set up you can just run test-runner with a few flags and you'll 
boot into a shell:

./tools/test-runner -k <kernel-image> --hw --start /bin/bash

Please reach out if you have questions, thanks for looking into this.


