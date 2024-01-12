Return-Path: <linux-wireless+bounces-1763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7A82B94E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D9E283CF6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835AD1379;
	Fri, 12 Jan 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jk4GENkG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803D136B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BNpjiG030749;
	Fri, 12 Jan 2024 02:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mlbz7xJnCPtf7gBKvyCSNeHI/pmuKypiw413nMGr3vc=; b=jk
	4GENkGjdq6L0J2gaGXlTc8I6xJ9r4VQ2HCFyWFJXLr9LVP/p2GIpQGgqSn8jm11Q
	ixnYX/sW4KLGQ519cEjfHa3NrpWG1dw8CQReAO06Wp1ccvOkxqcegiYx27OK6VVW
	Kx0xwkW+3LQANBQViW4UAkCCzPwkONL1fAOkmlqhfdCmYCq+bO6ahmTb+rZ1GPkg
	qHpNsx1TT2U0ZK09aAlnMnkZT4UPF2iOOgrr5SXLPCR5AdTb++z7hOOvK96fayiW
	poMxF96oDamPTYG2p5/IkRzcYAe2j4vefK/3TbNeJyzD74G/GaIK/1DS02y/3UHj
	hOHAXKR0NceWxcXvl5TQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjqx1ge0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:04:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C24S3M028981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:04:28 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 18:04:27 -0800
Message-ID: <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
Date: Fri, 12 Jan 2024 10:04:24 +0800
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
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qUdv7RmjPM8cNMY7UVFSEbAWmLzbCu30
X-Proofpoint-GUID: qUdv7RmjPM8cNMY7UVFSEbAWmLzbCu30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120013



On 1/11/2024 9:38 PM, James Prestwood wrote:
> 
> On 1/11/24 5:11 AM, Kalle Valo wrote:
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>> Hi Kalle, Baochen,
>>>
>>> On 1/11/24 12:16 AM, Kalle Valo wrote:
>>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>>
>>>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>>>> Hi Kalle,
>>>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>>>
>>>>>>>>> But I have also no idea what is causing this, I guess we are doing
>>>>>>>>> something wrong with the PCI communication? That reminds me, 
>>>>>>>>> you could
>>>>>>>>> try this in case that helps:
>>>>>>>>>
>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>>>>> Heh, I saw this pop up a day after I sent this and was 
>>>>>>>> wondering. Is
>>>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>>>> On the guest where ath11k is running. I'm not optimistic that 
>>>>>>> this would
>>>>>>> solve your issue, I suspect there can be also other bugs, but 
>>>>>>> good to
>>>>>>> know if the patch changes anything.
>>>>>> Looks the same here, didn't seem to change anything based on the
>>>>>> kernel logs.
>>>>>>
>>>>> Could you try this?
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c
>>>> This reminds me, I assumed James was testing with ath.git master branch
>>>> (which has that commit) but I never checked that. So for testing please
>>>> always use the master branch to get the latest and greatest ath11k:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>>>
>>>> There's a quite long delay from ath.git to official releases.
>>> Good to know, and I was not in fact using that branch. Rebuilt from
>>> ath.git/master but still roughly the same behavior. There does appear
>>> to be more output now though, specifically a firmware crash:
>>>
>>> [    2.281721] ath11k_pci 0000:00:06.0: failed to receive control
>>> response completion, polling..
>>> [    2.282101] ip (65) used greatest stack depth: 12464 bytes left
>>> [    3.306039] ath11k_pci 0000:00:06.0: Service connect timeout
>>> [    3.307588] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
>>> [    3.309286] ath11k_pci 0000:00:06.0: failed to start core: -110
>>> [    3.519637] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
>>> [    3.519678] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>>> [    3.627087] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
>>> [    3.627129] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
>>> [   13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
>>> request (mode 4): -110
>>> [   13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan mode
>>> off: -110
>> Ok, that's progress now. Can you try next try the iommu patch[1] we
>> talked about earlier? It's already in master-pending branch (along with
>> other pending patches) so you can use that branch if you want.
>>
>> [1] 
>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
> 
> Same result unfortunately, tried both with just [1] applied to ath.git 
> and at HEAD of master-pending.
> 
> Thanks,
> 
> James
Strange that still fails. Are you now seeing this error in your host or 
your Qemu? or both?
Could you share your test steps? And if you can share please be as 
detailed as possible since I'm not familiar with passing WLAN hardware 
to a VM using vfio-pci.
> 
> 

