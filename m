Return-Path: <linux-wireless+bounces-2135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CDE83114A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 03:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3341F22659
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898D2115;
	Thu, 18 Jan 2024 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bX/tX9wZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE55211C
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543804; cv=none; b=ZrsRIyQgJSNCYSpytFYsjua9fGQSRJSJsDxkUqes+x+brIgExaK9Bs+eMNIuTzL+IIkKhbBgqOOJkCbpmD8Tn0A25BGgBnBDbJohylCULUL2NeGKUDaKAJXY/rYwoIHjVOe1rndPw8LJe2uDbpIo/tW+k8iucshCSF3mqx2TDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543804; c=relaxed/simple;
	bh=oHJSnLQ8kEJEBy4jHDkX33Lq4d2vVBNmWu1l7ysFh3s=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=n5EBM7t7psUhDvAMAApGeUSf75bTmd84uSuxGmZSPa8lPjYbdk+L3ci2VnYaV/6uVXRAc1zXayDYSvfxE+OW+Q3qL+JM1/FCi3XZgmOY5jHRwfgW9tKfvtjpjNfDOcEDeHMdDDilyD+dDjA4qgx5CnLLY0LOgX7ZTtdEDAnbij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bX/tX9wZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I1VIUu010429;
	Thu, 18 Jan 2024 02:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qJwNqiJ7X5VFwpQJcwrYyDtTs4VFOPesxsEGz+h5Z0w=; b=bX
	/tX9wZIdMpOLvJDTJSnvZQlGcIbeEd6/a/a0tgKcUI70KTzizGC376mhepTkrkIr
	enNzNI2D1amfITZj5SqTQjA4joqtZUO+V9v7TI+KK6JQSKdn2QDgIJ1H4/KHWdZ3
	auY1KjaNmDl/E3WseSKdFPEaEI/NfiPgI8MhDyVwvHomrTrXkRm6y8jLLUN/kkVF
	X9q4pg5R9P9wvVswpVGGheANNPBSzjGNC9UeCAQ6yJnG3dlGL+hxZ4E4I+t7MvFZ
	aCSZJYLyNzZ8fLt+AYIZ3E0miVQ2y8zZCelV1Kyo11hleAby7g+3OyqexeEES2G2
	YTOUuABUKVEMS+GrU2ew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpspf0434-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:09:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I29r4o009839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:09:53 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 18:09:52 -0800
Message-ID: <21e925bc-ee3e-4421-949b-b3839d2abdef@quicinc.com>
Date: Thu, 18 Jan 2024 10:09:49 +0800
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
 <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
 <cdec259a-b779-4856-8585-f285179e3671@gmail.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <cdec259a-b779-4856-8585-f285179e3671@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cNcpFGHioX5z5SG69UlCjER48sARv4Xc
X-Proofpoint-ORIG-GUID: cNcpFGHioX5z5SG69UlCjER48sARv4Xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180012



On 1/17/2024 9:20 PM, James Prestwood wrote:
> Hi Baochen,
> 
> <snip>
> 
>>>>
>>>> While I don't think there is a way for qemu/ath11k to get the real 
>>>> MSI vector from host, I will try to read the vfio code to check 
>>>> further. Before that, to unblock you, a possible hack is to hard 
>>>> code the MSI vector in qemu to the same as in host, on condition 
>>>> that the MSI vector doesn't change. In my case, the change looks like
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
>>>> b/drivers/net/wireless/ath/ath11k/pci.c
>>>> index 09e65c5e55c4..89a9bbe9e4d2 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>>>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>>>> @@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct 
>>>> ath11k_pci *ab_pci)
>>>>                 ab->pci.msi.addr_hi = 0;
>>>>         }
>>>>
>>>> -       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
>>>> ab->pci.msi.ep_base_data);
>>>> +       ab->pci.msi.addr_hi = 0;
>>>> +       ab->pci.msi.addr_lo = 0xfee00578;
>>>> +       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x 
>>>> base data is %d\n",
>>>> +                  ab->pci.msi.addr_hi,
>>>> +                  ab->pci.msi.addr_lo,
>>>> +                  ab->pci.msi.ep_base_data);
>>>>
>>>>         return 0;
>>>>
>>>> @@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
>>>> ath11k_pci *ab_pci)
>>>>         }
>>>>
>>>>         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
>>>> +       ab_pci->ab->pci.msi.ep_base_data = 0;
>>>>
>>>>         ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
>>>> msi_ep_base_data %d\n",
>>>>                    ab_pci->ab->pci.msi.ep_base_data);
>>>>
>>>>
>>>> This hack works on my setup.
>>>
>>> Progress! Thank you. This didn't work for me but its likely because 
>>> my host MSI vector is not fee00578. Where did you come up with this 
>>> value? 
>> It could, and most likely, be different from machine to machine.
>>
>>> I don't see anything in the dmesg logs, or in lspci etc.
>>>
>> fee00578 is the physical MSI vector so I got it using lspci in host, see
>> ...
>>         Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit-
>>                 Address: fee00578  Data: 0000
>>                 Masking: fffffffe  Pending: 00000000
>> ...
> 
> Mine looks like this:
> 
> ...
> 
>      Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit-
>          Address: 00000000  Data: 0000
>          Masking: 00000000  Pending: 00000000
I guess you got this output when qemu/ath11k is not running, either qemu 
not started or ath11k module not loaded, right? Since MSI is not enabled 
in this output.

Sorry I should have made it clear:
step1: start qemu and load ath11k without changing anything, then you 
get those errors;
step2: keep qemu running and ath11k there, don't unload it. Then check 
lspci output in host to get the MSI vector.
step3: Back in qemu, hard code MSI vector to the one you get in step2, 
then rebuild and reload ath11k.

> ...
> 
> I've adjusted the patch:
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c 
> b/drivers/net/wireless/ath/ath11k/pci.c
> index 09e65c5e55..1cc7115582 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -459,7 +459,12 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci 
> *ab_pci)
>                  ab->pci.msi.addr_hi = 0;
>          }
> 
> -       ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", 
> ab->pci.msi.ep_base_data);
> +        ab->pci.msi.addr_hi = 0;
> +        ab->pci.msi.addr_lo = 0;
> +        ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base 
> data is %d\n",
> +                   ab->pci.msi.addr_hi,
> +                   ab->pci.msi.addr_lo,
> +                   ab->pci.msi.ep_base_data);
> 
>          return 0;
> 
> @@ -487,6 +492,7 @@ static int ath11k_pci_config_msi_data(struct 
> ath11k_pci *ab_pci)
>          }
> 
>          ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
> +       ab_pci->ab->pci.msi.ep_base_data = 0;
> 
>          ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "after request_irq 
> msi_ep_base_data %d\n",
>                     ab_pci->ab->pci.msi.ep_base_data);
> 
> But still getting the same errors:
> 
> [    3.563057] ath11k_pci 0000:00:06.0: Service connect timeout
> [    3.565044] ath11k_pci 0000:00:06.0: failed to connect to HTT: -110
> [    3.567031] ath11k_pci 0000:00:06.0: failed to start core: -110
> [    3.777514] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
> [    3.777555] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
> [    3.885137] ath11k_pci 0000:00:06.0: firmware crashed: MHI_CB_EE_RDDM
> [    3.885178] ath11k_pci 0000:00:06.0: ignore reset dev flags 0x4000
> 
> I know this isn't a proper fix, so if its something that needs more 
> thought than just hard-coded values I understand.
> 
> Thanks,
> 
> James
> 
>>
>>> Thanks,
>>>
>>> James
>>>

