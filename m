Return-Path: <linux-wireless+bounces-2067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A282FC82
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 23:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EF61F2A048
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB07200A8;
	Tue, 16 Jan 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VTAtwrSO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB4200A5
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439489; cv=none; b=kenpUL7TioR72wMjgIsYNpc0QEWlx7XEbpZZRPMp0Riy7VyUNwuvZJPUOgIvRKmKFHFWF0sUSSVn9nHJbFG6HLXkCXO563hZj7/obhQvE7bSTGqsvLzP9i7z2+Xd4RvnE3wjdfLjrAXxWcIHtnwyLx3EopPUbgRRF93s+nFqMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439489; c=relaxed/simple;
	bh=/IDidVcveZ++lQC+hCBxuHGCSTDI0ixoqcUyJYal5Ww=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=OaII2EDkDu41ArtLopPP7InQ7iPT8jitdcnkWeOddLUX685ZBVHTi7J9CSC+TrFRs0rfZvdEXMf60cqqdXOiu7C0jsf5rEgZOGQA7aH7CfO/2kLMZ9yj6cTGOH4PUgNWLoY8YuRz+hkKSt62DYPTPc6+yIFiiKxR09vmjx1B/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VTAtwrSO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GHJmLg008703;
	Tue, 16 Jan 2024 21:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ntTg0X+EOcZumleCxTU3lAbbf9/sklJEYhE5L7Q2eO8=; b=VT
	AtwrSOibpv1xqgQ1qYxlB6B0gJZY2wQPxgyUcqYYHyHAPOL8jPdDhE4PZ4iABoA8
	/ylRhB6+TwSeJWOgWWV1JSy0hEznlfdpzT81/FO6SQ5pSER2rlb0OO2AbhJMyKSO
	gaIUE3ow85tGCVJet8oVhGsP/f2FpX22QAhcFLAk13r7JcOD8R8aFMTlW2BXlR5C
	9SjaBNBllJBQkmvpIDnBmNIP+KpAIV4nHZaNTfu3D8uIiMu3OP+uzWvkr+ECDFpV
	3JGIfebVe63S1zD/crmCfLzOoFkjiFR4UnjvL2V20j4CVB+K3NFySJLHYBUZkqaE
	bGB86o7bBukH1h5IKWiw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnn1qsyra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:11:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GLB06D029109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:11:00 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 13:10:57 -0800
Message-ID: <71559fe3-3125-43c4-959a-32bc30e165e4@quicinc.com>
Date: Tue, 16 Jan 2024 13:10:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse
	<dwmw2@infradead.org>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        James Prestwood <prestwoj@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <iommu@lists.linux.dev>,
        "kernel@quicinc.com"
	<kernel@quicinc.com>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org> <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <87il3w7zjh.fsf@kernel.org>
 <20240115104658.0b56bd35.alex.williamson@redhat.com>
 <543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
 <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
 <20240116112845.55ebfcf7.alex.williamson@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240116112845.55ebfcf7.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NVbf2E3F484SdgKaOFbxgXcUbnAeSTyW
X-Proofpoint-ORIG-GUID: NVbf2E3F484SdgKaOFbxgXcUbnAeSTyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160167

On 1/16/2024 10:28 AM, Alex Williamson wrote:
> On Tue, 16 Jan 2024 11:41:19 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
>> On Tue, 2024-01-16 at 18:08 +0800, Baochen Qiang wrote:
>>>
>>>
>>> On 1/16/2024 1:46 AM, Alex Williamson wrote:  
>>>> On Sun, 14 Jan 2024 16:36:02 +0200
>>>> Kalle Valo <kvalo@kernel.org> wrote:
>>>>   
>>>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>>>   
>>>>>>>> Strange that still fails. Are you now seeing this error in your
>>>>>>>> host or your Qemu? or both?
>>>>>>>> Could you share your test steps? And if you can share please be as
>>>>>>>> detailed as possible since I'm not familiar with passing WLAN
>>>>>>>> hardware to a VM using vfio-pci.  
>>>>>>>
>>>>>>> Just in Qemu, the hardware works fine on my host machine.
>>>>>>> I basically follow this guide to set it up, its written in the
>>>>>>> context of GPUs/libvirt but the host setup is exactly the same. By
>>>>>>> no means do you need to read it all, once you set the vfio-pci.ids
>>>>>>> and see your unclaimed adapter you can stop:
>>>>>>> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
>>>>>>> In short you should be able to set the following host kernel options
>>>>>>> and reboot (assuming your motherboard/hardware is compatible):
>>>>>>> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
>>>>>>> Obviously change the device/vendor IDs to whatever ath11k hw you
>>>>>>> have. Once the host is rebooted you should see your wlan adapter as
>>>>>>> UNCLAIMED, showing the driver in use as vfio-pci. If not, its likely
>>>>>>> your motherboard just isn't compatible, the device has to be in its
>>>>>>> own IOMMU group (you could try switching PCI ports if this is the
>>>>>>> case).
>>>>>>> I then build a "kvm_guest.config" kernel with the driver/firmware
>>>>>>> for ath11k and boot into that with the following Qemu options:
>>>>>>> -enable-kvm -device -vfio-pci,host=<PCI address>
>>>>>>> If it seems easier you could also utilize IWD's test-runner which
>>>>>>> handles launching the Qemu kernel automatically, detecting any
>>>>>>> vfio-devices and passes them through and mounts some useful host
>>>>>>> folders into the VM. Its actually a very good general purpose tool
>>>>>>> for kernel testing, not just for IWD:
>>>>>>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt
>>>>>>> Once set up you can just run test-runner with a few flags and you'll
>>>>>>> boot into a shell:
>>>>>>> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
>>>>>>> Please reach out if you have questions, thanks for looking into
>>>>>>> this.  
>>>>>>
>>>>>> Thanks for these details. I reproduced this issue by following your guide.
>>>>>>
>>>>>> Seems the root cause is that the MSI vector assigned to WCN6855 in
>>>>>> qemu is different with that in host. In my case the MSI vector in qemu
>>>>>> is [Address: fee00000  Data: 0020] while in host it is [Address:
>>>>>> fee00578 Data: 0000]. So in qemu ath11k configures MSI vector
>>>>>> [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and
>>>>>> firmware uses that vector to fire interrupts to host/qemu. However
>>>>>> host IOMMU doesn't know that vector because the real vector is
>>>>>> [Address: fee00578  Data: 0000], as a result host blocks that
>>>>>> interrupt and reports an error, see below log:
>>>>>>
>>>>>> [ 1414.206069] DMAR: DRHD: handling fault status reg 2
>>>>>> [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
>>>>>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>>>>> request
>>>>>> [ 1414.210334] DMAR: DRHD: handling fault status reg 2
>>>>>> [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
>>>>>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>>>>> request
>>>>>> [ 1414.212496] DMAR: DRHD: handling fault status reg 2
>>>>>> [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
>>>>>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>>>>> request
>>>>>> [ 1414.214600] DMAR: DRHD: handling fault status reg 2
>>>>>>
>>>>>> While I don't think there is a way for qemu/ath11k to get the real MSI
>>>>>> vector from host, I will try to read the vfio code to check further.
>>>>>> Before that, to unblock you, a possible hack is to hard code the MSI
>>>>>> vector in qemu to the same as in host, on condition that the MSI
>>>>>> vector doesn't change.  
>>>>>
>>>>> Baochen, awesome that you were able to debug this further. Now we at
>>>>> least know what's the problem.  
>>>>
>>>> It's an interesting problem, I don't think we've seen another device
>>>> where the driver reads the MSI register in order to program another
>>>> hardware entity to match the MSI address and data configuration.
>>>>
>>>> When assigning a device, the host and guest use entirely separate
>>>> address spaces for MSI interrupts.  When the guest enables MSI, the
>>>> operation is trapped by the VMM and triggers an ioctl to the host to
>>>> perform an equivalent configuration.  Generally the physical device
>>>> will interrupt within the host where it may be directly attached to KVM
>>>> to signal the interrupt, trigger through the VMM, or where
>>>> virtualization hardware supports it, the interrupt can directly trigger
>>>> the vCPU.   From the VM perspective, the guest address/data pair is used
>>>> to signal the interrupt, which is why it makes sense to virtualize the
>>>> MSI registers.  
>>>
>>> Hi Alex, could you help elaborate more? why from the VM perspective MSI 
>>> virtualization is necessary?  
>>
>> An MSI is just a write to physical memory space. You can even use it
>> like that; configure the device to just write 4 bytes to some address
>> in a struct in memory to show that it needs attention, and you then
>> poll that memory.
>>
>> But mostly we don't (ab)use it like that, of course. We tell the device
>> to write to a special range of the physical address space where the
>> interrupt controller lives — the range from 0xfee00000 to 0xfeefffff.
>> The low 20 bits of the address, and the 32 bits of data written to that
>> address, tell the interrupt controller which CPU to interrupt, and
>> which vector to raise on the CPU (as well as some other details and
>> weird interrupt modes which are theoretically encodable).
>>
>> So in your example, the guest writes [Address: fee00000  Data: 0020]
>> which means it wants vector 0x20 on CPU#0 (well, the CPU with APICID
>> 0). But that's what the *guest* wants. If we just blindly programmed
>> that into the hardware, the hardware would deliver vector 0x20 to the
>> host's CPU0... which would be very confused by it.
>>
>> The host has a driver for that device, probably the VFIO driver. The
>> host registers its own interrupt handlers for the real hardware,
>> decides which *host* CPU (and vector) should be notified when something
>> happens. And when that happens, the VFIO driver will raise an event on
>> an eventfd, which will notify QEMU to inject the appropriate interrupt
>> into the guest.
>>
>> So... when the guest enables the MSI, that's trapped by QEMU which
>> remembers which *guest* CPU/vector the interrupt should go to. QEMU
>> tells VFIO to enable the corresponding interrupt, and what gets
>> programmed into the actual hardware is up to the *host* operating
>> system; nothing to do with the guest's information at all.
>>
>> Then when the actual hardware raises the interrupt, the VFIO interrupt
>> handler runs in the guest, signals an event on the eventfd, and QEMU
> 
> s/guest/host/
> 
>> receives that and injects the event into the appropriate guest vCPU.
>>
>> (In practice QEMU doesn't do it these days; there's actually a shortcut
>> which improves latency by allowing the kernel to deliver the event to
>> the guest directly, connecting the eventfd directly to the KVM irq
>> routing table.)
>>
>>
>> Interrupt remapping is probably not important here, but I'll explain it
>> briefly anyway. With interrupt remapping, the IOMMU handles the
>> 'memory' write from the device, just as it handles all other memory
>> transactions. One of the reasons for interrupt remapping is that the
>> original definitions of the bits in the MSI (the low 20 bits of the
>> address and the 32 bits of what's written) only had 8 bits for the
>> target CPU APICID. And we have bigger systems than that now.
>>
>> So by using one of the spare bits in the MSI message, we can indicate
>> that this isn't just a directly-encoded cpu/vector in "Compatibility
>> Format", but is a "Remappable Format" interrupt. Instead of the
>> cpu/vector it just contains an index in to the IOMMU's Interrupt
>> Redirection Table. Which *does* have a full 32-bits for the target APIC
>> ID. That's why x2apic support (which gives us support for >254 CPUs)
>> depends on interrupt remapping. 
>>
>> The other thing that the IOMMU can do in modern systems is *posted*
>> interrupts. Where the entry in the IOMMU's IRT doesn't just specify the
>> host's CPU/vector, but actually specifies a *vCPU* to deliver the
>> interrupt to. 
>>
>> All of which is mostly irrelevant as it's just another bypass
>> optimisation to improve latency. The key here is that what the guest
>> writes to its emulated MSI table and what the host writes to the real
>> hardware are not at all related.
>>
>> If we had had this posted interrupt support from the beginning, perhaps
>> we could have have a much simpler model — we just let the guest write
>> its intended (v)CPU#/vector *directly* to the MSI table in the device,
>> and let the IOMMU fix it up by having a table pointing to the
>> appropriate set of vCPUs. But that isn't how it happened. The model we
>> have is that the VMM has to *emulate* the config space and handle the
>> interrupts as described above.
>>
>> This means that whenever a device has a non-standard way of configuring
>> MSIs, the VMM has to understand and intercept that. I believe we've
>> even seen some Atheros devices with the MSI target in some weird MMIO
>> registers instead of the standard location, so we've had to hack QEMU
>> to handle those too?
>>
>>> And, maybe a stupid question, is that possible VM/KVM or vfio only 
>>> virtualize write operation to MSI register but leave read operation 
>>> un-virtualized? I am asking this because in that way ath11k may get a
>>> chance to run in VM after getting the real vector.  
>>
>> That might confuse a number of operating systems. Especially if they
>> mask/unmask by reading the register, flipping the mask bit and writing
>> back again.
>>
>> How exactly is the content of this register then given back to the
>> firmware? Is that communication snoopable by the VMM?
>>
>>
>>>>
>>>> Off hand I don't have a good solution for this, the hardware is
>>>> essentially imposing a unique requirement for MSI programming that the
>>>> driver needs visibility of the physical MSI address and data.
>>>>   
>>
>> Strictly, the driver doesn't need visibility to the actual values used
>> by the hardware. Another way of it looking at it would be to say that
>> the driver programs the MSI through this non-standard method, it just
>> needs the VMM to trap and handle that, just as the VMM does for the
>> standard MSI table. 
>>
>> Which is what I thought we'd already seen on some Atheros devices.
>>
>>>>   It's
>>>> conceivable that device specific code could either make the physical
>>>> address/data pair visible to the VM or trap the firmware programming to
>>>> inject the correct physical values.  Is there somewhere other than the
>>>> standard MSI capability in config space that the driver could learn the
>>>> physical values, ie. somewhere that isn't virtualized?  Thanks,  
>>>
>>> I don't think we have such capability in configuration space.  
>>
>> Configuration space is a complete fiction though; it's all emulated. We
>> can do anything we like. Or we can have a PV hypercall which will
>> report it. I don't know that we'd *want* to, but all things are
>> possible.
> 
> RTL8169 has a back door to the MSI-X vector table, maybe that's the one
> you're thinking of.  Alternate methods for the driver to access config
> space is common on GPUs, presumably because they require extensive
> vBIOS support and IO port and MMIO windows through which pre-boot code
> can interact with config space is faster and easier than standard
> config accesses.  Much of the work of assigning a GPU to a VM is to
> wrap those alternate methods in virtualization to keep the driver
> working within the guest address space.
> 
> The fictitious config space was my thought too, an ath11k vfio-pci
> variant driver could insert a vendor defined capability into config
> space to expose the physical MSI address/data.  The driver would know
> by the presence of the capability that it's running in a VM and to
> prefer that mechanism to retrieve MSI address and data.
> 
> Alternatively as also suggested here, if programming of the firmware
> with the MSI address/data is something that a hypervisor could trap,
> then we might be able to make it transparent to the guest.  For example
> if it were programmed via MMIO, the guest address/data values could be
> auto-magically replaced with physical values.  Since QEMU doesn't know
> the physical values, this would also likely be through a device
> specific extension to vfio-pci through a variant driver, or maybe some
> combination of variant driver and QEMU if we need to make trapping
> conditional in order to avoid a performance penalty.
> 
> This is essentially device specific interrupt programming, which either
> needs to be virtualized (performed by the VMM) or paravirtualized
> (performed in cooperation with the guest).  This is also something to
> keep in mind relative to the initial source of this issue, ie. testing
> device drivers and hardware under device assignment.  There can be
> subtle differences.  Thanks,
> 
> Alex
> 
>

+ kernel@quicinc.com for added visibility and advice

Full thread:
<https://lore.kernel.org/all/adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com/>

