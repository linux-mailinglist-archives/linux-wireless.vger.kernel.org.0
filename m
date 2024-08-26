Return-Path: <linux-wireless+bounces-11948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FE195EABC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562581F216EA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C6D139CFC;
	Mon, 26 Aug 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Iy2MmbaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0685654;
	Mon, 26 Aug 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658290; cv=none; b=kLioVdUzYXKqEbMwZYq109MbKGDEYYUnIwKXPNR2HnFkgyvM6oPdVNPv2JdzSW/YgR3exl38jmZcfoGi2/oOInzY2pK0/AsvW1ZW0X9xip7EepcE+O9AeSi6bZ+fRawNxs72Mw2/ev4++45DKVA5xz1+Vx0Hr1hV/KlT3yh4n/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658290; c=relaxed/simple;
	bh=mFCyXF9RIT3BfuxQITKG4+gybhWmW25JaO1vwdN+664=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZAMC+9I69bnYqTHWqSkX/Hu1TT+6fvEQAU+U5JiOpsmQwWAB/a6ByyLWZpsr8w74G/FvXXB9iUjz/d045oZOELRfFzZFdt62JCL9QDqgBRlpzMU0uYmISOmlv0iByDCQJQn/J7TY6iZKnFYNxGH+AhwTxG0gDyKm3Se/mEKNiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Iy2MmbaQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q0R3ZF008206;
	Mon, 26 Aug 2024 07:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7oYkUV5ASS9hlhzaDIw+nRplvB4HQ/LLZ9O4q8rWFlk=; b=Iy2MmbaQe1a9Z4Vy
	9R3z/L9HnwY7AHxlklWzSFEdor0SW5y+atF+vdxpyTRWt2lSAzlnuGFEulrsgf0L
	EllFI4B0vlh4LldG53qigSQnNPPiK56fse8VLk5lXijJXhhXyJEBA45lacvQSnOb
	lHYFJxvdsqrGqK/m17pKJmecPAwTFwWzK7YcK2ou76Itd/CCvK0WzTxNFOUnAJQo
	RB/v6fEGvJV1yQhwNJrUIk3a/keDdsiU2uQG8jqdxEqY+t1ieVgls3Nkr+P7soeD
	WuXnnsRl/0nPGatO2No72gQNAHVWGTJ3RsTJH+B6PK140feUVgoiH+Agmq7wRBIz
	999y6A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179antv3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 07:44:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q7ig7e021506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 07:44:42 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 Aug
 2024 00:44:40 -0700
Message-ID: <b3247591-d917-450a-9364-97a5a4f9a030@quicinc.com>
Date: Mon, 26 Aug 2024 15:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: Set IRQ affinity hint after requesting
 all shared IRQs
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <kvalo@kernel.org>, <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
 <20240823155502.57333-2-manivannan.sadhasivam@linaro.org>
 <d3ceaead-5619-4413-acce-64567c08fb27@quicinc.com>
 <20240826070143.ejd6vuorseogmdfe@thinkpad>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240826070143.ejd6vuorseogmdfe@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4q-YRT6t2D4787U_Cqz7T1uNQR1asJh5
X-Proofpoint-ORIG-GUID: 4q-YRT6t2D4787U_Cqz7T1uNQR1asJh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_04,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260061



On 8/26/2024 3:01 PM, Manivannan Sadhasivam wrote:
> On Mon, Aug 26, 2024 at 11:04:41AM +0800, Baochen Qiang wrote:
>>
>>
>> On 8/23/2024 11:55 PM, Manivannan Sadhasivam wrote:
> 
> [...]
> 
>>> The warning is due to not clearing the affinity hint before freeing the
>>> IRQ.
>>>
>>> So to fix this, let's set the IRQ affinity hint after requesting all the
>>> shared IRQ. This will make sure that the affinity hint gets cleared in the
>>> error path before freeing the IRQ.
>> if you check 39564b475ac5 ("wifi: ath11k: fix boot failure with one MSI vector") you would see that the hint is set before requesting any IRQ for a purpose.
>>
> 
> Ok, thanks for sharing the history. However, commit 39564b475ac5 looks confusing
> to me. It asserts that changing the IRQ affinity changes the MSI vector
> programmed to the device, but I've never heard of that behavior. IRQ affinity
> change is supposed to only change the CPU mask for the IRQ.
vector has to be changed, or how does kernel change the target CPU of a certain IRQ? On x86 platform, this is done by apic_set_affinity().

> 
> For confirming my suspicion, I added the debug print in pci_write_msg_msi() and
> I can see that it is only getting called once during pci_alloc_irq_vectors().
> 
> Moreover with my series, WLAN is working fine on QCA6390 with a shared vector:
> 
> 213:       6766          0          0          0          0          0          0          0   PCI-MSI 524288 Edge      bhi, mhi, mhi, ce0, ce1, ce2, ce3, ce5, ce7, ce8, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EX
> T_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ
> 
That is because kernel allocates a vector targeting CPU0 at the very fist time, which is exactly what we want by setting IRQ affinity. So there is no need to change vector any more, and therefore you saw only one print of pci_write_msg_msi(). above interrupt counter is a direct evidence to such guess: all interrupts received on CPU0.

Actually the issue mentioned in commit 39564b475ac5 happens randomly. But whenever it happens, you could see interrupts received on CPUs other than 0.

> So I think the issue fixed by 39564b475ac5 should be reinvestigated.
> 
> - Mani
> 
>>>
>>> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
>>>
>>> Cc: Baochen Qiang <quic_bqiang@quicinc.com>
>>> Fixes: e94b07493da3 ("ath11k: Set IRQ affinity to CPU0 in case of one MSI vector")
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
>>> index 8d63b84d1261..0c22e18e65c7 100644
>>> --- a/drivers/net/wireless/ath/ath11k/pci.c
>>> +++ b/drivers/net/wireless/ath/ath11k/pci.c
>>> @@ -886,16 +886,10 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>>  	if (ret)
>>>  		goto err_pci_disable_msi;
>>>  
>>> -	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
>>> -	if (ret) {
>>> -		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
>>> -		goto err_pci_disable_msi;
>>> -	}
>>> -
>>>  	ret = ath11k_mhi_register(ab_pci);
>>>  	if (ret) {
>>>  		ath11k_err(ab, "failed to register mhi: %d\n", ret);
>>> -		goto err_irq_affinity_cleanup;
>>> +		goto err_pci_disable_msi;
>>>  	}
>>>  
>>>  	ret = ath11k_hal_srng_init(ab);
>>> @@ -916,6 +910,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>>  		goto err_ce_free;
>>>  	}
>>>  
>>> +	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
>>> +	if (ret) {
>>> +		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
>>> +		goto err_free_irq;
>>> +	}
>>> +
>>>  	/* kernel may allocate a dummy vector before request_irq and
>>>  	 * then allocate a real vector when request_irq is called.
>>>  	 * So get msi_data here again to avoid spurious interrupt
>>> @@ -924,17 +924,20 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>>  	ret = ath11k_pci_config_msi_data(ab_pci);
>>>  	if (ret) {
>>>  		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
>>> -		goto err_free_irq;
>>> +		goto err_irq_affinity_cleanup;
>>>  	}
>>>  
>>>  	ret = ath11k_core_init(ab);
>>>  	if (ret) {
>>>  		ath11k_err(ab, "failed to init core: %d\n", ret);
>>> -		goto err_free_irq;
>>> +		goto err_irq_affinity_cleanup;
>>>  	}
>>>  	ath11k_qmi_fwreset_from_cold_boot(ab);
>>>  	return 0;
>>>  
>>> +err_irq_affinity_cleanup:
>>> +	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
>>> +
>>>  err_free_irq:
>>>  	ath11k_pcic_free_irq(ab);
>>>  
>>> @@ -947,9 +950,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>>>  err_mhi_unregister:
>>>  	ath11k_mhi_unregister(ab_pci);
>>>  
>>> -err_irq_affinity_cleanup:
>>> -	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
>>> -
>>>  err_pci_disable_msi:
>>>  	ath11k_pci_free_msi(ab_pci);
>>>  
> 

