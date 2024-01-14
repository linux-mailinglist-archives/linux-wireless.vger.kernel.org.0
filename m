Return-Path: <linux-wireless+bounces-1885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407582D089
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 13:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB6C1F218FF
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F411866;
	Sun, 14 Jan 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ykzm99J3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372F4626
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ECUNXj029363;
	Sun, 14 Jan 2024 12:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kVDLCmu1HPIDXNubYu8nKYPaR8pIz4+hElnHGJhhzFw=; b=Yk
	zm99J3HZW+xj8dm1yb/35RA/C4SFYIXeVKR2n5S+74aOZ8CpZAgAngb6WnHj6iEx
	1lsqgBKQo7Ywj6zhIuEJfiSig5orzhASh6ki7kngZfVuXneezOmyphMOF8Y0dpym
	VbZH0h/8Lhjq7v0C3aBvF7+bvNbH0GYnGU+2XHb6Gla/YRr0gEuGt0yW1VPu9WFJ
	SrUsSn44pPJG+wiSEnojRdQTGxXT6wCp49abUO3SXumAL1TnPsNNuj+GbDJsNdT/
	YowwpcCjXaOZYmIrVmIbCy2y7uQmvUbBoog9LyOdGXng922oydSmp7uvaXtlWlkN
	8Vx5EEl3Wm/lNn9I9u3A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmgt9nye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 12:37:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ECb8Lv027442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 12:37:08 GMT
Received: from [10.253.12.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 14 Jan
 2024 04:37:06 -0800
Message-ID: <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
Date: Sun, 14 Jan 2024 20:37:03 +0800
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
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I17hN3dBRRncW40uKPxADCJmUN8xfY3J
X-Proofpoint-GUID: I17hN3dBRRncW40uKPxADCJmUN8xfY3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401140099



On 1/12/2024 8:47 PM, James Prestwood wrote:
> Hi,
> 
> On 1/11/24 6:04 PM, Baochen Qiang wrote:
>>
>>
>> On 1/11/2024 9:38 PM, James Prestwood wrote:
>>>
>>> On 1/11/24 5:11 AM, Kalle Valo wrote:
>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>
>>>>> Hi Kalle, Baochen,
>>>>>
>>>>> On 1/11/24 12:16 AM, Kalle Valo wrote:
>>>>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>>>>
>>>>>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>>>>>> Hi Kalle,
>>>>>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>>>>
>>>>>>>>>>> But I have also no idea what is causing this, I guess we are 
>>>>>>>>>>> doing
>>>>>>>>>>> something wrong with the PCI communication? That reminds me, 
>>>>>>>>>>> you could
>>>>>>>>>>> try this in case that helps:
>>>>>>>>>>>
>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>>>>>>> Heh, I saw this pop up a day after I sent this and was 
>>>>>>>>>> wondering. Is
>>>>>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>>>>>> On the guest where ath11k is running. I'm not optimistic that 
>>>>>>>>> this would
>>>>>>>>> solve your issue, I suspect there can be also other bugs, but 
>>>>>>>>> good to
>>>>>>>>> know if the patch changes anything.
>>>>>>>> Looks the same here, didn't seem to change anything based on the
>>>>>>>> kernel logs.
>>>>>>>>
>>>>>>> Could you try this?
>>>>>>>
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c
>>>>>> This reminds me, I assumed James was testing with ath.git master 
>>>>>> branch
>>>>>> (which has that commit) but I never checked that. So for testing 
>>>>>> please
>>>>>> always use the master branch to get the latest and greatest ath11k:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>>>>>
>>>>>> There's a quite long delay from ath.git to official releases.
>>>>> Good to know, and I was not in fact using that branch. Rebuilt from
>>>>> ath.git/master but still roughly the same behavior. There does appear
>>>>> to be more output now though, specifically a firmware crash:
>>>>>
>>>>> [    2.281721] ath11k_pci 0000:00:06.0: failed to receive control
>>>>> response completion, polling..
>>>>> [    2.282101] ip (65) used greatest stack depth: 12464 bytes left
>>>>> [    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
>>>>> [    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
>>>>> [    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
>>>>> [    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>>> MHI_CB_EE_RDDM
>>>>> [    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>>>>> [    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: 
>>>>> MHI_CB_EE_RDDM
>>>>> [    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>>>>> [   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
>>>>> request (mode 4): -110
>>>>> [   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode
>>>>> off: -110
>>>> Ok, that's progress now. Can you try next try the iommu patch[1] we
>>>> talked about earlier? It's already in master-pending branch (along with
>>>> other pending patches) so you can use that branch if you want.
>>>>
>>>> [1] 
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>
>>> Same result unfortunately, tried both with just [1] applied to 
>>> ath.git and at HEAD of master-pending.
>>>
>>> Thanks,
>>>
>>> James
>> Strange that still fails. Are you now seeing this error in your host 
>> or your Qemu? or both?
>> Could you share your test steps? And if you can share please be as 
>> detailed as possible since I'm not familiar with passing WLAN hardware 
>> to a VM using vfio-pci.
> 
> Just in Qemu, the hardware works fine on my host machine.
> 
> I basically follow this guide to set it up, its written in the context 
> of GPUs/libvirt but the host setup is exactly the same. By no means do 
> you need to read it all, once you set the vfio-pci.ids and see your 
> unclaimed adapter you can stop:
> 
> https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
> 
> In short you should be able to set the following host kernel options and 
> reboot (assuming your motherboard/hardware is compatible):
> 
> intel_iommu=on iommu=pt vfio-pci.ids=17cb:1103
> 
> Obviously change the device/vendor IDs to whatever ath11k hw you have. 
> Once the host is rebooted you should see your wlan adapter as UNCLAIMED, 
> showing the driver in use as vfio-pci. If not, its likely your 
> motherboard just isn't compatible, the device has to be in its own IOMMU 
> group (you could try switching PCI ports if this is the case).
> 
> I then build a "kvm_guest.config" kernel with the driver/firmware for 
> ath11k and boot into that with the following Qemu options:
> 
> -enable-kvm -device -vfio-pci,host=<PCI address>
> 
> If it seems easier you could also utilize IWD's test-runner which 
> handles launching the Qemu kernel automatically, detecting any 
> vfio-devices and passes them through and mounts some useful host folders 
> into the VM. Its actually a very good general purpose tool for kernel 
> testing, not just for IWD:
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt
> 
> Once set up you can just run test-runner with a few flags and you'll 
> boot into a shell:
> 
> ./tools/test-runner -k <kernel-image> --hw --start /bin/bash
> 
> Please reach out if you have questions, thanks for looking into this.
> 
Thanks for these details. I reproduced this issue by following your guide.

Seems the root cause is that the MSI vector assigned to WCN6855 in qemu 
is different with that in host. In my case the MSI vector in qemu is 
[Address: fee00000  Data: 0020] while in host it is [Address: fee00578 
Data: 0000]. So in qemu ath11k configures MSI vector [Address: fee00000 
Data: 0020] to WCN6855 hardware/firmware, and firmware uses that vector 
to fire interrupts to host/qemu. However host IOMMU doesn't know that 
vector because the real vector is [Address: fee00578  Data: 0000], as a 
result host blocks that interrupt and reports an error, see below log:

[ 1414.206069] DMAR: DRHD: handling fault status reg 2
[ 1414.206081] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
[ 1414.210334] DMAR: DRHD: handling fault status reg 2
[ 1414.210342] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
[ 1414.212496] DMAR: DRHD: handling fault status reg 2
[ 1414.212503] DMAR: [INTR-REMAP] Request device [02:00.0] fault index 
0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
[ 1414.214600] DMAR: DRHD: handling fault status reg 2

While I don't think there is a way for qemu/ath11k to get the real MSI 
vector from host, I will try to read the vfio code to check further. 
Before that, to unblock you, a possible hack is to hard code the MSI 
vector in qemu to the same as in host, on condition that the MSI vector 
doesn't change. In my case, the change looks like

diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
b/drivers/net/wireless/ath/ath11k/pci.c
index 09e65c5e55c4..89a9bbe9e4d2 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci 
*ab_pci)
                 ab->pci.msi.addr_hi = 0;
         }

-       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
ab->pci.msi.ep_base_data);
+       ab->pci.msi.addr_hi = 0;
+       ab->pci.msi.addr_lo = 0xfee00578;
+       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base 
data is %d\n",
+                  ab->pci.msi.addr_hi,
+                  ab->pci.msi.addr_lo,
+                  ab->pci.msi.ep_base_data);

         return 0;

@@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
ath11k_pci *ab_pci)
         }

         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
+       ab_pci->ab->pci.msi.ep_base_data = 0;

         ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
msi_ep_base_data %d\n",
                    ab_pci->ab->pci.msi.ep_base_data);


This hack works on my setup.


