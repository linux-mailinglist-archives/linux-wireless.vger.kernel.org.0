Return-Path: <linux-wireless+bounces-24370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3DAE496B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE70188542F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6899E1F94A;
	Mon, 23 Jun 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pivD3wi+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7B26D4F7
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693892; cv=none; b=eGj7QTaj4yGvdXuEe5GFQmNQurJwhwrxFZkwrZgivXIkys8yxXxWBmucI+5df7xrwf4Nvmp6lr+uInAz9Z3kmBxfezdbvvKVY6zGN05O1xexCpfPNOwJN0OeBlkm+YeJ1AeuSlHeFV7bgYLBLmqm1EebDc1bJBxGkXFEKO8aj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693892; c=relaxed/simple;
	bh=Wnm6+7ET2gLRuAI5Dm0HPnfT3cPMqm8XHbu23UksxCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2D8bmXsVlsi3Cd/br3yMWI8Dmks/tkWIWWPu/YzleJJ/L5/cz0X7QIVciqSH0cRkwZE8fyw/nwTfUhDSlMgf21cXfCqKco5noHLhAwHkCQ9FjcawpBKaU0J+I1QKTHtoqtvfRQtCLvCIYNKg5wFUJjBYJm7biEs1dC2fATzUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pivD3wi+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9HEko025855
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tYYI1PSVSslndP+Y1vEtSWhPe5cDz1pruNBScyDqPIM=; b=pivD3wi+mToh+Aj4
	iusKU7MzEl1DNzvcwUV9uWR9giA/Uh4clsHW2ze/6FeHCN7H0NuWti5nsNw0VLB3
	JL2BBbjd6H/7iMzJfzCs2dGHh8Fr1Y22bXa90iOa4iyLj3Z/ESJzteuuAS5lifM5
	1AG4gil4mmdm76m7GKQ6bUeUHiOHeC+FwBGLZGM/cqfqNksyZj5YbJzgMjGOmyMy
	2sQuVLcTHdh3nLZsr1TRMFf2F8i1LXUxhbX/A0x0TU0/brfVFDD5Qtv9+bt5bCL7
	e6FCSgjvI5rPKtRp/zkuWiL0zWY2jPRsczMBxc8wmMG9Q/KcNKoPjqJ2s2lfd/UR
	7nW+Yw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmju4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 15:51:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748b4d5c045so3478631b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 08:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693889; x=1751298689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYYI1PSVSslndP+Y1vEtSWhPe5cDz1pruNBScyDqPIM=;
        b=SptkOIuoRxaTW4qpifzLKuci8BG9Ku6aa7pnpKwgJnK5wL+L/wv78zbWAxY10JVDhl
         Lh7GL/dbOCSokcS7PzxbHIVacSgCCaafeAriNvTSbkuBxKZ9Dno23O9t6xl6ZBnd+YaZ
         UESzxAy4+IJuvydvkGUUl523LWQi63Oh3svGkSBrEDgz0BGLrQJZQW8Z7E9iQWc8gk+O
         cNftayCAhcoj60AjPIlRB+RjZ2idEYmd3swieWlJVLsN/2TrsFiJDicrgLMh0EHT+6V0
         M6Od8Qpn424nH37dlT0HQaCybHfmBKP//cUSah69eWagkDy4Lj+veKngN545QOz9NaMi
         dZow==
X-Gm-Message-State: AOJu0YxUYkKOSiSwVXBmMrh+nLyobpnxJ/yvkMbu8P0q1s09G1HA45j3
	roD1k1eBxbbPeIu2ACpQQ36jELJG7yXHdH6p9EQ94GXbescz2l76mp5BMZNmTBPDdh8PbXcA6wk
	SLNw/o+QYNXI0kpyWpeKj8ueO16cPaleABPITOGOCiS2nRvEsrRwiH8Lr1JEi7XP261TVfg==
X-Gm-Gg: ASbGncu0e/VqYcEvq8Hu8u74iY9MoU5iFO9pFKJsuxD/iqion8qoSpSYw1jcOHIZyKZ
	sSNnqGGYxXtwTzsCzfDBTa4K36YmXx8JsubrTHQzFszis7ZVa6sD42htVVRdL0g0WvMouFKOXSH
	P2toCMpm2lKCmjUOkQWJem/WO3yZSyk2GsbmcpD6szjJ3YK5E9326TnkyttdLtkSzcv0ECBBRC+
	JAVkm+KXUdapn+HwBO3oP71z6TPcwjcMNYHXHtM0nrTVqzR9ji0Dwbzx2m6Q2zWzWa4BkvMKmLY
	3kcFi1tYTVM4L/MW1GQ8Le11ADIifvw0SiAOwiA7TtDYAeD10Vik4JCIwqihoA==
X-Received: by 2002:a05:6a20:3d1a:b0:218:5954:128c with SMTP id adf61e73a8af0-22026f666ecmr17570750637.21.1750693889143;
        Mon, 23 Jun 2025 08:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTB8GCNbc/2fzaaqVs5wa367l84r5Matp1+jHk+iiUoxVmPBfLwYPyatl5Ffn2X2iX0KN87Q==
X-Received: by 2002:a05:6a20:3d1a:b0:218:5954:128c with SMTP id adf61e73a8af0-22026f666ecmr17570718637.21.1750693888678;
        Mon, 23 Jun 2025 08:51:28 -0700 (PDT)
Received: from [192.168.29.88] ([49.37.214.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a62633fsm8440158b3a.84.2025.06.23.08.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:51:28 -0700 (PDT)
Message-ID: <8e774154-1594-452c-858a-e16376dee09d@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 21:21:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: use real noise floor value
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
References: <20250528-support_real_noise_floor-v1-0-04507bd3bc76@oss.qualcomm.com>
 <500a10c9-c56e-4192-818e-8e07ef6c51f4@oss.qualcomm.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <500a10c9-c56e-4192-818e-8e07ef6c51f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tXKf09X1StnSd3nctLXdGSQm92v2AazD
X-Proofpoint-ORIG-GUID: tXKf09X1StnSd3nctLXdGSQm92v2AazD
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=68597802 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=wMrS+Y4uhDqG1CA/WHymIw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=eRXGc6zcnUY8UlbqGOwA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NiBTYWx0ZWRfX01vock/Wq5YE
 e5EgAIaE6J39qvIaxrWbeDPKo4uVG5BXjK1VXw5YZ+QKMZr8UhNlCa/ehTHIQwLy1N8OoEzUEgn
 Duxtp3Wij5qkFPUqxWNLbermNhMMsZuVQFz7SwLX1nWFNZ0chiUGp8Cxg7tmi/gXwQfJaEQ99L8
 Z19Stlp67VOLZpqHN+e6bXPZ/ewcEjIUbQ3l3NtrrsfXQHHOWZeXlFIL9ErBzwob4s5SvxsClMY
 5IeQ7QKHoQS1RbPmrhbSV27BH1J4+53PntrDkl1hqGapgyaYInAWNeQsYqE1URwpWqgKpfFOhr6
 J98E41VyPrQFDdFJ49r/5Ot1GUK6sNgT3IvlPjwIeeb/I/FaIlXgSimAOaOT2SdbaDIc1lC1fu/
 A5isa2ZDuRPi4d9rAlYJnE47s3emMcessTOt/sxp7Ad89xvKWTI/1nDDeraZr2gUqZGGmhRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230096

On 6/23/2025 8:30 PM, Jeff Johnson wrote:
> On 5/28/2025 4:23 AM, Aditya Kumar Singh wrote:
>> At present, the ATH12K_DEFAULT_NOISE_FLOOR (-95) is used to calculate RSSI
>> value, providing an estimated noise floor value. Consequently, the RSSI
>> value is also approximate. This works but however, using actual noise floor
>> value will enable the reporting of the true RSSI value.
>>
>> The firmware possesses the necessary data to determine the actual noise
>> floor. This data is provided to the host via the WMI event
>> WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID, which includes the
>> runtime parameters needed for calculating the real noise floor in dBm. This
>> event is triggered by the firmware during channel changes, temperature
>> offset adjustments, and hardware chainmask modifications.
>>
>> Add support to handle and parse this WMI event. Use the received values to
>> calculate and store the noise floor value and use at the required places.
>>
>> ---
>> Raj Kumar Bhagat (2):
>>        wifi: ath12k: handle WMI event for real noise floor calculation
>>        wifi: ath12k: use real noise floor instead of default value
>>
>>   drivers/net/wireless/ath/ath12k/core.h   |  17 +++
>>   drivers/net/wireless/ath/ath12k/dp_mon.c |   7 +-
>>   drivers/net/wireless/ath/ath12k/dp_tx.c  |  20 ++-
>>   drivers/net/wireless/ath/ath12k/mac.c    |  14 +-
>>   drivers/net/wireless/ath/ath12k/wmi.c    | 233 ++++++++++++++++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/wmi.h    |  42 ++++++
>>   6 files changed, 324 insertions(+), 9 deletions(-)
>> ---
>> base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
>> change-id: 20250513-support_real_noise_floor-205986936cd3
> 
> This series no longer applies cleanly on ath/main, please rebase
> 
> Applying: wifi: ath12k: handle WMI event for real noise floor calculation
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/core.h
> M       drivers/net/wireless/ath/ath12k/mac.c
> M       drivers/net/wireless/ath/ath12k/wmi.c
> M       drivers/net/wireless/ath/ath12k/wmi.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/wmi.h
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
> Auto-merging drivers/net/wireless/ath/ath12k/mac.c
> Auto-merging drivers/net/wireless/ath/ath12k/core.h
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/wmi.h'
> error: Failed to merge in the changes.
> Patch failed at 0001 wifi: ath12k: handle WMI event for real noise floor calculation

Done. Rolled out the rebased next version.

-- 
Aditya

