Return-Path: <linux-wireless+bounces-2074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7596882FFD2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 06:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5AF288F2D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE48F65;
	Wed, 17 Jan 2024 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mk11eseO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB078F47
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469209; cv=none; b=UvZorO2SCPS3GReTJOcw1xqjWuqgyRj4UcSRIm/vlQkUrmhgijl4cMaS6wuX3K7xL7abmsbjps7W6uIQ1sSIlg1lRbm7k5GdLPtPWmnGvQF+TOpOQy2RCmzPQPiY8/Jb9z219dD7BTlJlh+zQGZxAElQUuPSwYy7kdXFUwr/sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469209; c=relaxed/simple;
	bh=nHd3XmR3r7ZSVKWWpzYaKdqNWoPPkfxIuE5xK84XXRY=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=Cs616ydaR6XlEx5/XWGA7dI6JoSP6K/QKRZ1VxjEh/ykJzAHlxkkxs8Tj/NMnygwHu0t0FtcT/5UeIlNNqCXXVqRGQGc/J9nlwhkWUB6LfPnm6XckP080z6rlQ3RkuDSMxBFZwyh7sx5f6XgkD/dyxY2kDiJPtWyxpFKU5kgzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mk11eseO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H2x1ir019770;
	Wed, 17 Jan 2024 05:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EK2Q9F0VzalOSp1xYGRINbraJvYUCEpexiyblMBeymU=; b=mk
	11eseOaHcBRHKniwZb0KDdvHotMQpSjxVoXh89e19pXQUd6/3Nqgu5uKnfcwfkVU
	0Kga7A2CyDuPdJ3Lx9c6yCJ9kokhIe+20RtQXmQT0ZV2joLFUs6pHytQN48W/FFG
	gQJhXrKufVc7OsjKR+Z10MX0Ts6ritrzYNLGsOrcpxJXo1dp2tHI3AKxeYDhLhgH
	OoPJCP4x4E+joNwYQPaCQUlW/iFSDiqc8IhGT+7SBkZxyGbNSzMcXqYVrDqBxmjq
	4URiCp6i/99Js3BQT0wewCF2M2eDyqln4bGWlltRNNdLKjVOxmBbGy/6jemLR7qZ
	oFECbpNTdTXR2Iy2vN8Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrndadpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 05:26:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H5QaBW001092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 05:26:36 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 21:26:35 -0800
Message-ID: <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
Date: Wed, 17 Jan 2024 13:26:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
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
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XHpg58u55UjWk8wZVZx0YhUECWYRQhwR
X-Proofpoint-ORIG-GUID: XHpg58u55UjWk8wZVZx0YhUECWYRQhwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_02,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170035



On 1/16/2024 9:05 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 1/14/24 4:37 AM, Baochen Qiang wrote:
>>
>>
>> On 1/12/2024 8:47 PM, James Prestwood wrote:
>>> Hi,
>>>
>>> On 1/11/24 6:04 PM, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 1/11/2024 9:38 PM, James Prestwood wrote:
>>>>>
>>>>> On 1/11/24 5:11 AM, Kalle Valo wrote:
>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>
>>>>>>> Hi Kalle, Baochen,
>>>>>>>
>>>>>>> On 1/11/24 12:16 AM, Kalle Valo wrote:
>>>>>>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>>>>>>
>>>>>>>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>>>>>>>> Hi Kalle,
>>>>>>>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>>>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>>> But I have also no idea what is causing this, I guess we 
>>>>>>>>>>>>> are doing
>>>>>>>>>>>>> something wrong with the PCI communication? That reminds 
>>>>>>>>>>>>> me, you could
>>>>>>>>>>>>> try this in case that helps:
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>>>>>>>>> Heh, I saw this pop up a day after I sent this and was 
>>>>>>>>>>>> wondering. Is
>>>>>>>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>>>>>>>> On the guest where ath11k is running. I'm not optimistic that 
>>>>>>>>>>> this would
>>>>>>>>>>> solve your issue, I suspect there can be also other bugs, but 
>>>>>>>>>>> good to
>>>>>>>>>>> know if the patch changes anything.
>>>>>>>>>> Looks the same here, didn't seem to change anything based on the
>>>>>>>>>> kernel logs.
>>>>>>>>>>
>>>>>>>>> Could you try this?
>>>>>>>>>
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c
>>>>>>>> This reminds me, I assumed James was testing with ath.git master 
>>>>>>>> branch
>>>>>>>> (which has that commit) but I never checked that. So for testing 
>>>>>>>> please
>>>>>>>> always use the master branch to get the latest and greatest ath11k:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>>>>>>>
>>>>>>>> There's a quite long delay from ath.git to official releases.
>>>>>>> Good to know, and I was not in fact using that branch. Rebuilt from
>>>>>>> ath.git/master but still roughly the same behavior. There does 
>>>>>>> appear
>>>>>>> to be more output now though, specifically a firmware crash:
>>>>>>>
>>>>>>> [    2.281721] ath11k_pci 0000:00:06.0: failed to receive control
>>>>>>> response completion, polling..
>>>>>>> [    2.282101] ip (65) used greatest stack depth: 12464 bytes left
>>>>>>> [    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
>>>>>>> [    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: 
>>>>>>> -110
>>>>>>> [    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
>>>>>>> [    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>>>>> MHI_CB_EE_RDDM
>>>>>>> [    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 
>>>>>>> 0x4000
>>>>>>> [    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>>>>> MHI_CB_EE_RDDM
>>>>>>> [    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 
>>>>>>> 0x4000
>>>>>>> [   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
>>>>>>> request (mode 4): -110
>>>>>>> [   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode
>>>>>>> off: -110
>>>>>> Ok, that's progress now. Can you try next try the iommu patch[1] we
>>>>>> talked about earlier? It's already in master-pending branch (along 
>>>>>> with
>>>>>> other pending patches) so you can use that branch if you want.
>>>>>>
>>>>>> [1] 
>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>>
>>>>> Same result unfortunately, tried both with just [1] applied to 
>>>>> ath.git and at HEAD of master-pending.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> James
>>>> Strange that still fails. Are you now seeing this error in your host 
>>>> or your Qemu? or both?
>>>> Could you share your test steps? And if you can share please be as 
>>>> detailed as possible since I'm not familiar with passing WLAN 
>>>> hardware to a VM using vfio-pci.
>>>
>>> Just in Qemu, the hardware works fine on my host machine.
>>>
>>> I basically follow this guide to set it up, its written in the 
>>> context of GPUs/libvirt but the host setup is exactly the same. By no 
>>> means do you need to read it all, once you set the vfio-pci.ids and 
>>> see your unclaimed adapter you can stop:
>>>
>>> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
>>>
>>> In short you should be able to set the following host kernel options 
>>> and reboot (assuming your motherboard/hardware is compatible):
>>>
>>> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
>>>
>>> Obviously change the device/vendor IDs to whatever ath11k hw you 
>>> have. Once the host is rebooted you should see your wlan adapter as 
>>> UNCLAIMED, showing the driver in use as vfio-pci. If not, its likely 
>>> your motherboard just isn't compatible, the device has to be in its 
>>> own IOMMU group (you could try switching PCI ports if this is the case).
>>>
>>> I then build a "kvm_guest.config" kernel with the driver/firmware for 
>>> ath11k and boot into that with the following Qemu options:
>>>
>>> -enable-kvm -device -vfio-pci,host=<PCI address>
>>>
>>> If it seems easier you could also utilize IWD's test-runner which 
>>> handles launching the Qemu kernel automatically, detecting any 
>>> vfio-devices and passes them through and mounts some useful host 
>>> folders into the VM. Its actually a very good general purpose tool 
>>> for kernel testing, not just for IWD:
>>>
>>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt
>>>
>>> Once set up you can just run test-runner with a few flags and you'll 
>>> boot into a shell:
>>>
>>> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
>>>
>>> Please reach out if you have questions, thanks for looking into this.
>>>
>> Thanks for these details. I reproduced this issue by following your 
>> guide.
>>
>> Seems the root cause is that the MSI vector assigned to WCN6855 in 
>> qemu is different with that in host. In my case the MSI vector in qemu 
>> is [Address: fee00000  Data: 0020] while in host it is [Address: 
>> fee00578 Data: 0000]. So in qemu ath11k configures MSI vector 
>> [Address: fee00000 Data: 0020] to WCN6855 hardware/firmware, and 
>> firmware uses that vector to fire interrupts to host/qemu. However 
>> host IOMMU doesn't know that vector because the real vector is 
>> [Address: fee00578  Data: 0000], as a result host blocks that 
>> interrupt and reports an error, see below log:
>>
>> [ 1414.206069] DMAR: DRHD: handling fault status reg 2
>> [ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
>> [ 1414.210334] DMAR: DRHD: handling fault status reg 2
>> [ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
>> [ 1414.212496] DMAR: DRHD: handling fault status reg 2
>> [ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
>> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
>> [ 1414.214600] DMAR: DRHD: handling fault status reg 2
>>
>> While I don't think there is a way for qemu/ath11k to get the real MSI 
>> vector from host, I will try to read the vfio code to check further. 
>> Before that, to unblock you, a possible hack is to hard code the MSI 
>> vector in qemu to the same as in host, on condition that the MSI 
>> vector doesn't change. In my case, the change looks like
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
>> b/drivers/net/wireless/ath/ath11k/pci.c
>> index 09e65c5e55c4..89a9bbe9e4d2 100644
>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>> @@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci 
>> *ab_pci)
>>                 ab->pci.msi.addr_hi = 0;
>>         }
>>
>> -       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
>> ab->pci.msi.ep_base_data);
>> +       ab->pci.msi.addr_hi = 0;
>> +       ab->pci.msi.addr_lo = 0xfee00578;
>> +       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base 
>> data is %d\n",
>> +                  ab->pci.msi.addr_hi,
>> +                  ab->pci.msi.addr_lo,
>> +                  ab->pci.msi.ep_base_data);
>>
>>         return 0;
>>
>> @@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
>> ath11k_pci *ab_pci)
>>         }
>>
>>         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
>> +       ab_pci->ab->pci.msi.ep_base_data = 0;
>>
>>         ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
>> msi_ep_base_data %d\n",
>>                    ab_pci->ab->pci.msi.ep_base_data);
>>
>>
>> This hack works on my setup.
> 
> Progress! Thank you. This didn't work for me but its likely because my 
> host MSI vector is not fee00578. Where did you come up with this value? 
It could, and most likely, be different from machine to machine.

> I don't see anything in the dmesg logs, or in lspci etc.
> 
fee00578 is the physical MSI vector so I got it using lspci in host, see
...
         Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit-
                 Address: fee00578  Data: 0000
                 Masking: fffffffe  Pending: 00000000
...

> Thanks,
> 
> James
> 

