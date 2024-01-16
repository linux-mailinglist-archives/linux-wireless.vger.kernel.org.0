Return-Path: <linux-wireless+bounces-1979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710182EF61
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 14:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDAA1C22E28
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D41BDC2;
	Tue, 16 Jan 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCBn09x+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9421BDC0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-429c7ba12a2so32401601cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705410357; x=1706015157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMyoE0CoNSm3fuY7i7G7KD+fZOF7GEEhgAjyXp/kUv8=;
        b=UCBn09x+iMAArSP2KG+Pl3n6AC58bDnzR9qID1nYCt/6LrrzJ16y/w9TgQpx1BqraQ
         YwIJAEZxWSfekhcAy2ZXSYvpaj9v4Uh3Op27Ib5m+0yS4meQWxZnV8dZWzyuEihY7Ic6
         X9wI4BobhcddSuzxtt+qx8RFrimyIHnQlG0V7oQ89J7cigGEwwmxpn8nBUsGjCrqSwxN
         eqxkjPD4HwWVKpP0rGn0tTopTOB6WPmcAhXEH8l6jZm9wAOPTLdfLLyCKfXqNd8MhW4v
         NWCrMcMZNCyNZFqpWN2/ldkuHAWI1dwBXVa8PwvfSYeb8IrwZDD04CTtURhj8UcZJPlW
         d9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410357; x=1706015157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMyoE0CoNSm3fuY7i7G7KD+fZOF7GEEhgAjyXp/kUv8=;
        b=hKGUadBJH8vPYLcgHugJeZER+fgjSWPzUFJ4lfqfDGd9Vg7IHGLOVZciBrDlFxEu73
         p8du7zGW+Wsa/dXyldL04dTe8q0Hrf4vibu/7RH6VDZTyFEvlnHKje56bTVousSFK8K9
         Ee5Ls4BpzhauY9aI+TWmPm9N0/6sNYxq2Y4cJTxzrDJDRK2/TzPa2L9TzIVSpLCJHoSW
         oYUMf2HyJtp5Kdt+ws5LkS+aBoAbMxPJ5DY6x6r1G43WywobnIjkOGgA8ZYSd0BXKIhd
         aBA+vHphC/ARu29Jitj4M0RUEbnqef1kXYgyy1scJmYMskKSODle2omYXRgu9OP2cIfi
         NMNA==
X-Gm-Message-State: AOJu0YxEY2H69DZjiCQmIJ7cnlfxUj9GsPZLfAGlguoSCdtM7zy5RtHv
	hyVoZ418IXLF9wHrEPv8qRo=
X-Google-Smtp-Source: AGHT+IFrIiNKTcl8aNaV4lwcxs9e28ORM0BGWqVOh/sj3Tyefu2A4/bKBnindTXK8BtWOLcrtorrVA==
X-Received: by 2002:a05:622a:1a9d:b0:429:d954:b342 with SMTP id s29-20020a05622a1a9d00b00429d954b342mr6703001qtc.73.1705410357318;
        Tue, 16 Jan 2024 05:05:57 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id t26-20020ac86a1a000000b00419732075b4sm4826547qtr.84.2024.01.16.05.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:05:56 -0800 (PST)
Message-ID: <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
Date: Tue, 16 Jan 2024 05:05:55 -0800
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 1/14/24 4:37 AM, Baochen Qiang wrote:
>
>
> On 1/12/2024 8:47 PM, James Prestwood wrote:
>> Hi,
>>
>> On 1/11/24 6:04 PM, Baochen Qiang wrote:
>>>
>>>
>>> On 1/11/2024 9:38 PM, James Prestwood wrote:
>>>>
>>>> On 1/11/24 5:11 AM, Kalle Valo wrote:
>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>
>>>>>> Hi Kalle, Baochen,
>>>>>>
>>>>>> On 1/11/24 12:16 AM, Kalle Valo wrote:
>>>>>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>>>>>
>>>>>>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>>>>>>> Hi Kalle,
>>>>>>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>>>>>
>>>>>>>>>>>> But I have also no idea what is causing this, I guess we 
>>>>>>>>>>>> are doing
>>>>>>>>>>>> something wrong with the PCI communication? That reminds 
>>>>>>>>>>>> me, you could
>>>>>>>>>>>> try this in case that helps:
>>>>>>>>>>>>
>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/ 
>>>>>>>>>>>>
>>>>>>>>>>> Heh, I saw this pop up a day after I sent this and was 
>>>>>>>>>>> wondering. Is
>>>>>>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>>>>>>> On the guest where ath11k is running. I'm not optimistic that 
>>>>>>>>>> this would
>>>>>>>>>> solve your issue, I suspect there can be also other bugs, but 
>>>>>>>>>> good to
>>>>>>>>>> know if the patch changes anything.
>>>>>>>>> Looks the same here, didn't seem to change anything based on the
>>>>>>>>> kernel logs.
>>>>>>>>>
>>>>>>>> Could you try this?
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c 
>>>>>>>>
>>>>>>> This reminds me, I assumed James was testing with ath.git master 
>>>>>>> branch
>>>>>>> (which has that commit) but I never checked that. So for testing 
>>>>>>> please
>>>>>>> always use the master branch to get the latest and greatest ath11k:
>>>>>>>
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>>>>>>
>>>>>>> There's a quite long delay from ath.git to official releases.
>>>>>> Good to know, and I was not in fact using that branch. Rebuilt from
>>>>>> ath.git/master but still roughly the same behavior. There does 
>>>>>> appear
>>>>>> to be more output now though, specifically a firmware crash:
>>>>>>
>>>>>> [    2.281721] ath11k_pci 0000:00:06.0: failed to receive control
>>>>>> response completion, polling..
>>>>>> [    2.282101] ip (65) used greatest stack depth: 12464 bytes left
>>>>>> [    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
>>>>>> [    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: 
>>>>>> -110
>>>>>> [    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
>>>>>> [    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>>>> MHI_CB_EE_RDDM
>>>>>> [    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 
>>>>>> 0x4000
>>>>>> [    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>>>> MHI_CB_EE_RDDM
>>>>>> [    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 
>>>>>> 0x4000
>>>>>> [   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
>>>>>> request (mode 4): -110
>>>>>> [   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode
>>>>>> off: -110
>>>>> Ok, that's progress now. Can you try next try the iommu patch[1] we
>>>>> talked about earlier? It's already in master-pending branch (along 
>>>>> with
>>>>> other pending patches) so you can use that branch if you want.
>>>>>
>>>>> [1] 
>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>
>>>> Same result unfortunately, tried both with just [1] applied to 
>>>> ath.git and at HEAD of master-pending.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>> Strange that still fails. Are you now seeing this error in your host 
>>> or your Qemu? or both?
>>> Could you share your test steps? And if you can share please be as 
>>> detailed as possible since I'm not familiar with passing WLAN 
>>> hardware to a VM using vfio-pci.
>>
>> Just in Qemu, the hardware works fine on my host machine.
>>
>> I basically follow this guide to set it up, its written in the 
>> context of GPUs/libvirt but the host setup is exactly the same. By no 
>> means do you need to read it all, once you set the vfio-pci.ids and 
>> see your unclaimed adapter you can stop:
>>
>> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
>>
>> In short you should be able to set the following host kernel options 
>> and reboot (assuming your motherboard/hardware is compatible):
>>
>> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
>>
>> Obviously change the device/vendor IDs to whatever ath11k hw you 
>> have. Once the host is rebooted you should see your wlan adapter as 
>> UNCLAIMED, showing the driver in use as vfio-pci. If not, its likely 
>> your motherboard just isn't compatible, the device has to be in its 
>> own IOMMU group (you could try switching PCI ports if this is the case).
>>
>> I then build a "kvm_guest.config" kernel with the driver/firmware for 
>> ath11k and boot into that with the following Qemu options:
>>
>> -enable-kvm -device -vfio-pci,host=<PCI address>
>>
>> If it seems easier you could also utilize IWD's test-runner which 
>> handles launching the Qemu kernel automatically, detecting any 
>> vfio-devices and passes them through and mounts some useful host 
>> folders into the VM. Its actually a very good general purpose tool 
>> for kernel testing, not just for IWD:
>>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt 
>>
>>
>> Once set up you can just run test-runner with a few flags and you'll 
>> boot into a shell:
>>
>> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
>>
>> Please reach out if you have questions, thanks for looking into this.
>>
> Thanks for these details. I reproduced this issue by following your 
> guide.
>
> Seems the root cause is that the MSI vector assigned to WCN6855 in 
> qemu is different with that in host. In my case the MSI vector in qemu 
> is [Address: fee00000  Data: 0020] while in host it is [Address: 
> fee00578 Data: 0000]. So in qemu ath11k configures MSI vector 
> [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and 
> firmware uses that vector to fire interrupts to host/qemu. However 
> host IOMMU doesn't know that vector because the real vector is 
> [Address: fee00578  Data: 0000], as a result host blocks that 
> interrupt and reports an error, see below log:
>
> [ 1414.206069] DMAR: DRHD: handling fault status reg 2
> [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
> [ 1414.210334] DMAR: DRHD: handling fault status reg 2
> [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
> [ 1414.212496] DMAR: DRHD: handling fault status reg 2
> [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
> [ 1414.214600] DMAR: DRHD: handling fault status reg 2
>
> While I don't think there is a way for qemu/ath11k to get the real MSI 
> vector from host, I will try to read the vfio code to check further. 
> Before that, to unblock you, a possible hack is to hard code the MSI 
> vector in qemu to the same as in host, on condition that the MSI 
> vector doesn't change. In my case, the change looks like
>
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
> b/drivers/net/wireless/ath/ath11k/pci.c
> index 09e65c5e55c4..89a9bbe9e4d2 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci 
> *ab_pci)
>                 ab->pci.msi.addr_hi = 0;
>         }
>
> -       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
> ab->pci.msi.ep_base_data);
> +       ab->pci.msi.addr_hi = 0;
> +       ab->pci.msi.addr_lo = 0xfee00578;
> +       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base 
> data is %d\n",
> +                  ab->pci.msi.addr_hi,
> +                  ab->pci.msi.addr_lo,
> +                  ab->pci.msi.ep_base_data);
>
>         return 0;
>
> @@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
> ath11k_pci *ab_pci)
>         }
>
>         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
> +       ab_pci->ab->pci.msi.ep_base_data = 0;
>
>         ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
> msi_ep_base_data %d\n",
>                    ab_pci->ab->pci.msi.ep_base_data);
>
>
> This hack works on my setup.

Progress! Thank you. This didn't work for me but its likely because my 
host MSI vector is not fee00578. Where did you come up with this value? 
I don't see anything in the dmesg logs, or in lspci etc.

Thanks,

James


