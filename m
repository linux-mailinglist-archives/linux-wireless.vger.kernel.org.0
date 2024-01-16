Return-Path: <linux-wireless+bounces-1969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 148DB82EC93
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 11:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841D1B21A9D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CE134C9;
	Tue, 16 Jan 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hxq29RwQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F9134C6
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G7aMuQ028637;
	Tue, 16 Jan 2024 10:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VvhLdr6mFFAFGIuY+ynkPyjKy181Xyr5JNpzaPSlpkQ=; b=Hx
	q29RwQBr+6bjeNr9JaIUYEr9ABY95bNbWAC+3RB5WJ0O6TcNt/bZtaL9+1rMRXk7
	mxEjOSsEaT5Xg/1lqZbxuD0Ix2Kvvk61G0JnVysx13C5JviI/yUWZrxvZ3LLFSZ/
	291MPwHtJFgK/LqXL8kR/2/aa5wvpcBkD7hWYfWsC00KygEnqN+W2JO7HCEGmhPn
	cBoejM2VsS7FMhGL2qhUwVQGtD9D1qSMaAMq9htdYiQHMFt5JbAsJugphIbUFCz5
	Otj982ZiWfu3ro17EnhniXe8jw4W/6ji5Y5AItgk4667Lee+Jh1ZPVe4j+wR64ji
	pmfbQjWCPV28imyuBRkA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnhmra6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 10:08:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GA8dqs027134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 10:08:40 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 02:08:37 -0800
Message-ID: <543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
Date: Tue, 16 Jan 2024 18:08:35 +0800
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
        Kalle Valo
	<kvalo@kernel.org>
CC: James Prestwood <prestwoj@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, David Woodhouse <dwmw2@infradead.org>,
        <iommu@lists.linux.dev>
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
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240115104658.0b56bd35.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F5zuezsJmQD0kiDrR1kv3POnn8LDAfrY
X-Proofpoint-GUID: F5zuezsJmQD0kiDrR1kv3POnn8LDAfrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160079



On 1/16/2024 1:46 AM, Alex Williamson wrote:
> On Sun, 14 Jan 2024 16:36:02 +0200
> Kalle Valo <kvalo@kernel.org> wrote:
> 
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>
>>>>> Strange that still fails. Are you now seeing this error in your
>>>>> host or your Qemu? or both?
>>>>> Could you share your test steps? And if you can share please be as
>>>>> detailed as possible since I'm not familiar with passing WLAN
>>>>> hardware to a VM using vfio-pci.
>>>>
>>>> Just in Qemu, the hardware works fine on my host machine.
>>>> I basically follow this guide to set it up, its written in the
>>>> context of GPUs/libvirt but the host setup is exactly the same. By
>>>> no means do you need to read it all, once you set the vfio-pci.ids
>>>> and see your unclaimed adapter you can stop:
>>>> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
>>>> In short you should be able to set the following host kernel options
>>>> and reboot (assuming your motherboard/hardware is compatible):
>>>> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
>>>> Obviously change the device/vendor IDs to whatever ath11k hw you
>>>> have. Once the host is rebooted you should see your wlan adapter as
>>>> UNCLAIMED, showing the driver in use as vfio-pci. If not, its likely
>>>> your motherboard just isn't compatible, the device has to be in its
>>>> own IOMMU group (you could try switching PCI ports if this is the
>>>> case).
>>>> I then build a "kvm_guest.config" kernel with the driver/firmware
>>>> for ath11k and boot into that with the following Qemu options:
>>>> -enable-kvm -device -vfio-pci,host=<PCI address>
>>>> If it seems easier you could also utilize IWD's test-runner which
>>>> handles launching the Qemu kernel automatically, detecting any
>>>> vfio-devices and passes them through and mounts some useful host
>>>> folders into the VM. Its actually a very good general purpose tool
>>>> for kernel testing, not just for IWD:
>>>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt
>>>> Once set up you can just run test-runner with a few flags and you'll
>>>> boot into a shell:
>>>> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
>>>> Please reach out if you have questions, thanks for looking into
>>>> this.
>>>
>>> Thanks for these details. I reproduced this issue by following your guide.
>>>
>>> Seems the root cause is that the MSI vector assigned to WCN6855 in
>>> qemu is different with that in host. In my case the MSI vector in qemu
>>> is [Address: fee00000  Data: 0020] while in host it is [Address:
>>> fee00578 Data: 0000]. So in qemu ath11k configures MSI vector
>>> [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and
>>> firmware uses that vector to fire interrupts to host/qemu. However
>>> host IOMMU doesn't know that vector because the real vector is
>>> [Address: fee00578  Data: 0000], as a result host blocks that
>>> interrupt and reports an error, see below log:
>>>
>>> [ 1414.206069] DMAR: DRHD: handling fault status reg 2
>>> [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
>>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>> request
>>> [ 1414.210334] DMAR: DRHD: handling fault status reg 2
>>> [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
>>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>> request
>>> [ 1414.212496] DMAR: DRHD: handling fault status reg 2
>>> [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index
>>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>> request
>>> [ 1414.214600] DMAR: DRHD: handling fault status reg 2
>>>
>>> While I don't think there is a way for qemu/ath11k to get the real MSI
>>> vector from host, I will try to read the vfio code to check further.
>>> Before that, to unblock you, a possible hack is to hard code the MSI
>>> vector in qemu to the same as in host, on condition that the MSI
>>> vector doesn't change.
>>
>> Baochen, awesome that you were able to debug this further. Now we at
>> least know what's the problem.
> 
> It's an interesting problem, I don't think we've seen another device
> where the driver reads the MSI register in order to program another
> hardware entity to match the MSI address and data configuration.
> 
> When assigning a device, the host and guest use entirely separate
> address spaces for MSI interrupts.  When the guest enables MSI, the
> operation is trapped by the VMM and triggers an ioctl to the host to
> perform an equivalent configuration.  Generally the physical device
> will interrupt within the host where it may be directly attached to KVM
> to signal the interrupt, trigger through the VMM, or where
> virtualization hardware supports it, the interrupt can directly trigger
> the vCPU.   From the VM perspective, the guest address/data pair is used
> to signal the interrupt, which is why it makes sense to virtualize the
> MSI registers.
Hi Alex, could you help elaborate more? why from the VM perspective MSI 
virtualization is necessary?

And, maybe a stupid question, is that possible VM/KVM or vfio only 
virtualize write operation to MSI register but leave read operation 
un-virtualized? I am asking this because in that way ath11k may get a 
chance to run in VM after getting the real vector.

> 
> Off hand I don't have a good solution for this, the hardware is
> essentially imposing a unique requirement for MSI programming that the
> driver needs visibility of the physical MSI address and data.  It's
> conceivable that device specific code could either make the physical
> address/data pair visible to the VM or trap the firmware programming to
> inject the correct physical values.  Is there somewhere other than the
> standard MSI capability in config space that the driver could learn the
> physical values, ie. somewhere that isn't virtualized?  Thanks,
I don't think we have such capability in configuration space.

> 
> Alex
> 

