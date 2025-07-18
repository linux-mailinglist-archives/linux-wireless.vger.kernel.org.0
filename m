Return-Path: <linux-wireless+bounces-25644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22FB09D57
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 10:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBC61C40A65
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756BF21FF5D;
	Fri, 18 Jul 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6hI3PNg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA32192E5
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825838; cv=none; b=e5U6luoYetACVMrOTb1+Wre5OwG9iUK6nWv2vJm7+GlETnQUu2S7B+hWxh6lX9tCmKDCPXylldsA2OAwIWSCxVRUc0JEO+YfVKi1OBK5UGzPNhHaPRtnc6gEJj2Jdq77/9NNzv1vEqyfsG5y/6QzIPL70CGOHdgXeSmqI1lDkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825838; c=relaxed/simple;
	bh=Cd4S2/x3c2nivhZqYlZo9PbkOfdJG+AH9/oE2X9+BKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQ1ValKiz4wcTm2EgK2LcjYt01cbE3A3X2LRYLcw/ZxkTkkJHn2kq0pbeX2KgB0wV71c+BchtHdKxkgoHNVT6vZERCUKxFD9FKgskYGEm3I7eaesgoTMuyOZhlBTfzU1QXpghu6uAuSz7THku7oAP4Lye+ve06bBUSEw2Cx9ook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6hI3PNg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7pGIQ028066
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 08:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxueihSNUT2gvfRCYLszVQxvKLpm8BbA2TEvBIULlTw=; b=R6hI3PNgaBmb/wKU
	275ikXLUpWvTan0VU9GJXpxejQRUnNmYjnz3Mjm+JRaQKEbHtpKcco40BPvput0d
	puOMJKcwtKqrsuQ2OHqbMBHdCuUtebky9mT1WZcjzgj6uVfCu43dqDULfuW08Q5/
	TtBicGgbRW/EQqxyOxhIi3MVKKDq0IzmdayJQEuVIYc7BoEfF38Rpmd2RW9WKmmU
	ipF0/rUS1BDPZsI0gy3p11dQvPviH3W/C03bxuszcW/qEluvI0XXHe79F2wP3dqx
	M/fBzMbRZjT0jGgnqMTSTD6nfLu3AgAAkJq3SDOWiAKKqhS0vdPHRr2JjTJwPs7N
	RhZIUw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh62w3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 08:03:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so1376373a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 01:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825835; x=1753430635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxueihSNUT2gvfRCYLszVQxvKLpm8BbA2TEvBIULlTw=;
        b=p3ManGBD7e6rTRsiwdOo8QT0BuSA08hhKDQOPE2anpSXGioCrLDwt25uMWSc62pmL+
         0D9WRVlojxlUB+sJpy/tfISLmZhKwhdldZrj03kd+69NgRFtuzVWUm6Um1xpfjXLoC5b
         ay8FLuAckR35aY0tSwTC1EGrqKmEgj96jlUlsFB9f4C1WemOX2YbEA5xkITNE3ckP1OG
         ljYYv+PRbS7wY0HaGs2YxXqud5yYDBMadjLkVNy3GIhhKIZqE/id0LYvTEOazTqCgmmM
         b/qtnudssfHfzZ02rftLiT4QR0wdRRdhIK/RXFRftIKMC6u8A90JEkhDHDoCHVJsEs09
         SEpA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Rls9sHTDl6UPpksUEZK4B2Ohhz2SwQHflSSQ7ZTqC07U7U+r/McLz/3kFzYY0ICjPRMhnx9Fum3aRRKFCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YymEaoGK8nQ5oYOg64UnfFfRo1qvQy9Kmu1E9Ig+x6/YcCMrTy+
	Hlz32zt8WJhOabYgK4kqd8X/31q6LF812utq3f9jtfCFDU4qjZEola8qmsAmhqKyCX8Ao/Qo/Z4
	XrotAWnAzXOqrAHtwPJpCVD9O2saZCj26QAxSwB2ZZW4+y/0E/d4R1czByqinO3qqNFa46g==
X-Gm-Gg: ASbGncsFm9qw2njPbfAZf+wA9trdUSk3QpCezWA7//FcuxDacJJ4K8p9nkD7t5W0HIq
	jRmUsShPGA2epfeY7tDOv03ZbHEgQDFBBgLnTYiwaTl1jWHMH6XAu37sZ8ObbkULAMk99WWuRLa
	HjDdt79gWMrim1GUivxTF1VT6d+5LeJvDdaVKqS3zSgKcZAg3qX1q353v+FDL7ecddTAAqb3hjH
	rlzjb/F+F9ienBbZSzbesQ8LM5u/F7t/HlcvOEE0GM5hritl1mIcPy5B5fZHzsJLCFbZcW/0MqL
	HokgNV1baU6X1nuauN8VFsHGQY09E0O6xdkSr3WFn0o3oOQu2Q1pEnpGvS4T0dnbJ1Z6ig==
X-Received: by 2002:a17:90b:38c8:b0:313:287c:74bd with SMTP id 98e67ed59e1d1-31c9f4c46d3mr14699050a91.33.1752825834935;
        Fri, 18 Jul 2025 01:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxPYhZgCck07MGmNFAvaF85ucZQYS+3cPmHxVMPoQhjM4CsqlXubj80zgLzii9a5VFOEcvWQ==
X-Received: by 2002:a17:90b:38c8:b0:313:287c:74bd with SMTP id 98e67ed59e1d1-31c9f4c46d3mr14698992a91.33.1752825834371;
        Fri, 18 Jul 2025 01:03:54 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc0be8975sm737350a91.1.2025.07.18.01.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 01:03:54 -0700 (PDT)
Message-ID: <aa2f6350-3235-422b-be04-a03bd3a1010d@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 13:33:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Manivannan Sadhasivam <mani@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
 <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
 <o2gqqty6lakc4iw7vems2dejh6prjyl746gnq4gny4sxdxl65v@zmqse3244afv>
 <1db7c119-882f-4184-9ca4-9dbe5a49cb16@oss.qualcomm.com>
 <gx5gruyhrhwhvwkiqlkp2bggqd4oqe4quvqiiphfzolhjtzun6@okogvabkqah3>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <gx5gruyhrhwhvwkiqlkp2bggqd4oqe4quvqiiphfzolhjtzun6@okogvabkqah3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6879ffec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bhzlIsU2D2yyHOt3_ukA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: gg4ex-MYxIaX_MIrsQdmR7yAPBUvtqgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2MiBTYWx0ZWRfX4hpL6ksH775T
 lcTCw6lQ9H871S0TOKgmVXp2T9OklAAJZoYixuOdgrfPIcI9JJDiOg5Wx/1//Pk0sc1QaGU+iiF
 czabb2bF3nni8U0g6GFUggLAzqBmKQg7vTRO1X6RpVOpI7LwmYey/EDUQykDoHHv4ZtOEc5tU1l
 gAZqzsaYg1sfc9RHLmkgZb33lhvI66O70NV769mjWD9tktCBCaRCzexZ/gLErjFALegE78VKgce
 WSMdXnct6tM1pP8o6xSX4vKvPo7VaWNetxZ+bjK5OR2hkugKv5doM1Zyfq44Lkmo0gQF9/Hgwl3
 /jIAAhlI5E0i+MSMcHZ4ZLqZvZe9v/s5wBGmsW24fXI8G96cCgGF+YoMqh2XBEy5l4+RhMN7det
 oVbVZjA3BomnpselTFO7oMylJZtxRUYkUTxO/yZF48uQEEpNZKTBlCnNz+8jweT3rY2GsbK2
X-Proofpoint-ORIG-GUID: gg4ex-MYxIaX_MIrsQdmR7yAPBUvtqgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180062



On 7/18/2025 1:27 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 10:05:02AM GMT, Baochen Qiang wrote:
>>
>>
>> On 7/17/2025 7:29 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jul 17, 2025 at 06:46:12PM GMT, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>>>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> @@ -16,6 +16,8 @@
>>>>>>>   #include "mhi.h"
>>>>>>>   #include "debug.h"
>>>>>>>   
>>>>>>> +#include "../ath.h"
>>>>>>> +
>>>>>>>   #define ATH12K_PCI_BAR_NUM		0
>>>>>>>   #define ATH12K_PCI_DMA_MASK		36
>>>>>>>   
>>>>>>> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>>>>>>>   		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>>>>>>>   
>>>>>>>   	/* disable L0s and L1 */
>>>>>>> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>>>> -				   PCI_EXP_LNKCTL_ASPMC);
>>>>>>> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
>>>>>>
>>>>>> Not always, but sometimes seems the 'disable' does not work:
>>>>>>
>>>>>> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
>>>>>> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
>>>>>>
>>>>>>
>>>>>>>   
>>>>>>>   	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>>>>>>>   }
>>>>>>> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>>>>>>>   {
>>>>>>>   	if (ab_pci->ab->hw_params->supports_aspm &&
>>>>>>>   	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
>>>>>>> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC,
>>>>>>> -						   ab_pci->link_ctl &
>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC);
>>>>>>> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
>>>>>>
>>>>>> always, the 'enable' is not working:
>>>>>>
>>>>>> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
>>>>>> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
>>>>>>
>>>>>
>>>>> Interesting! I applied your diff and I never see this issue so far (across 10+
>>>>> reboots):
>>>>
>>>> I was not testing reboot. Here is what I am doing:
>>>>
>>>> step1: rmmod ath12k
>>>> step2: force LinkCtrl using setpci (make sure it is 0x43, which seems more likely to see
>>>> the issue)
>>>>
>>>> 	sudo setpci -s 02:00.0 0x80.B=0x43
>>>>
>>>> step3: insmod ath12k and check linkctrl
>>>>
>>>
>>> So I did the same and got:
>>>
>>> [ 3283.363569] ath12k_pci_power_up 1475: link_ctl 0x43
>>> [ 3283.363769] ath12k_pci_power_up 1480: link_ctl 0x40
>>> [ 3284.007661] ath12k_pci_start 1180: link_ctl 0x40
>>> [ 3284.007826] ath12k_pci_start 1185: link_ctl 0x42
>>>
>>> My host machine is Qcom based Thinkpad T14s and it doesn't support L0s. So
>>> that's why the lnkctl value once enabled becomes 0x42. This is exactly the
>>> reason why the drivers should not muck around LNKCTL register manually.
>>
>> Thanks, then the 0x43 -> 0x40 -> 0x40 -> 0x42 sequence should not be a concern. But still
>> the random 0x43 -> 0x43 -> 0x43 -> 0x42 sequence seems problematic.
>>
>> How many iterations have you done with above steps? From my side it seems random so better
>> to do some stress test.
>>
> 
> So I ran the modprobe for about 50 times on the Intel NUC that has QCA6390, but
> didn't spot the disparity. This is the script I used:
> 
> for i in {1..50} ;do echo "Loop $i"; sudo setpci -s 01:00.0 0x80.B=0x43;\
> sudo modprobe -r ath11k_pci; sleep 1; sudo modprobe ath11k_pci; sleep 1;done
> 
> And I always got:
> 
> [ 5862.388083] ath11k_pci_aspm_disable: 609 lnkctrl: 0x43
> [ 5862.388124] ath11k_pci_aspm_disable: 614 lnkctrl: 0x40
> [ 5862.876291] ath11k_pci_start: 880 lnkctrl: 0x40
> [ 5862.876346] ath11k_pci_start: 886 lnkctrl: 0x42
> 
> Also no AER messages. TBH, I'm not sure how you were able to see the random
> issues with these APIs. That looks like a race, which is scary.
> 
How about using locked variants pci_disable_link_state_locked &
pci_enable_link_state_locked give it a try?

- Krishna Chaitanya
> I do not want to ignore your scenario, but would like to reproduce and get to
> the bottom of it.
> 
> - Mani
> 

