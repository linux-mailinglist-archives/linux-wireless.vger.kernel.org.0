Return-Path: <linux-wireless+bounces-16304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CC9EE445
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6175818838C0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FE210F6D;
	Thu, 12 Dec 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BXQF+TeX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F761E89C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999836; cv=none; b=u6jRVdKK3woVnEDhch/zlNQY1nWY3loQ206asbBNYZ04TwjeyGbOZkVNqjz1d4ZU8KLjXN+jbwOHbBI8eedS+fRTbtALtHjGIc9ktrsQlVNGLFoDgjvPJakoen0bJbA3/4MFAC6DD/WpDJ6r3081Rm1Vj2xVFTJzeNgZpMwYJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999836; c=relaxed/simple;
	bh=E56ZSPTXfKJH/vyMuI4vuJ4g3BjAA7Zc9abApNohL0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VP8lXwMfjHOXL4/oqru3Pxenlnc5DHQWgKDaspLwgSpev1Kgyupxl1tcjqOXvAbiZwarOEM8BSTixRxHCvcUjS7jGCtEDvY8LiTDwDDayQzYYol8F5r0a+Mb+XdHVpaJ6rxV+A/WSwoDOnt1hmLfp8l2jyKtJM2LsJK8cVWu7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BXQF+TeX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC8Zcw1019803;
	Thu, 12 Dec 2024 10:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HigRuxDBdLbc9O45GBx63qcbP0OKoXUWYz/y47PHbvI=; b=BXQF+TeX851eUAs+
	YdGSEJZA7CDDKfNqd5v7d5YDfZfwNxfHu8mDxGA2HgyC/S4P+n+9ja6hcA8y7R+q
	0tRIeOfNHVx0txDAElXPGgE+IQohjKP6iTbOpWVBODOsSi0PRlVUCtgC+fmbOo0w
	VSrj5XjJlM4SS7Lkk2sMXG6w1WV13xqOI+17m0plt2SoWW+9jlD1eLAr8R9U4+R+
	nNdHFNzwS57p3eWxpcKdYbDMmBparTKpJCSPsmoKBDNOFU/jtxAHpIapbExoQJnP
	o65DMHa4Hebj8NTI0Ex2ytyfcF54klzewFQGLGsTgEEVw433abJqALQ/pvxJs/ps
	A9mv+g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdyt5f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:37:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCAb8Tg017272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:37:08 GMT
Received: from [10.50.0.236] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 02:37:06 -0800
Message-ID: <eed819dc-f1da-1ee2-9e8e-c32d0a4c4c7d@quicinc.com>
Date: Thu, 12 Dec 2024 16:07:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] wifi: ath12k: Fix uninitialized variable access in
 ath12k_mac_allocate() function
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241212004906.3087425-1-quic_periyasa@quicinc.com>
 <20241212004906.3087425-5-quic_periyasa@quicinc.com>
 <87v7vppc6c.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87v7vppc6c.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KWyRC7qdvGlwy66CB9Iv4GBX4EX0NdyT
X-Proofpoint-GUID: KWyRC7qdvGlwy66CB9Iv4GBX4EX0NdyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120075



On 12/12/2024 1:26 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, the uninitialized variable 'ab' is accessed in the
>> ath12k_mac_allocate() function. Initialize 'ab' with the first radio device
>> present in the hardware abstraction handle (ah). Additionally, move the
>> default setting procedure from the pdev mapping iteration to the total
>> radio calculating iteration for better code readability. Perform the
>> maximum radio validation check for total_radio to ensure that both num_hw
>> and radio_per_hw are validated indirectly, as these variables are derived
>> from total_radio. This also fixes the below Smatch static checker warning.
>>
>> Smatch warning:
>> ath12k_mac_allocate() error: uninitialized symbol 'ab'
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 5cdc1c38b049..98b2f853d243 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -10962,8 +10962,20 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>>   	u8 radio_per_hw;
>>   
>>   	total_radio = 0;
>> -	for (i = 0; i < ag->num_devices; i++)
>> -		total_radio += ag->ab[i]->num_radios;
>> +	for (i = 0; i < ag->num_devices; i++) {
>> +		ab = ag->ab[i];
>> +		if (!ab)
>> +			continue;
>> +
>> +		ath12k_mac_set_device_defaults(ab);
>> +		total_radio += ab->num_radios;
>> +	}
>> +
>> +	if (!total_radio)
>> +		return -EINVAL;
> 
> 'total_radio == 0' is more readable as it's a counter. Also please add ath12k_warn()
> 

This condition came due to no device handle (ab) present in the 
ath12k_hw_group (ag). ath12k_warn() cannot be used since no device (ab) 
present here. Additionally, ath12k_hw_warn() also cannot be used here 
since ath12k_hw (ah) also not created.

In future, we can introduce device (ab) and hardware (ah) agnostic 
warning helper function ath12k*dbg() for this usecase.

>> +
>> +	if (WARN_ON(total_radio > ATH12K_GROUP_MAX_RADIO))
>> +		return -ENOSPC;
> 
> BTW ath12k_warn() is preferred over WARN_ON(), but this is just for the
> future as this WARN_ON() was already there before.
> 

Sure

>>   
>>   	/* All pdev get combined and register as single wiphy based on
>>   	 * hardware group which participate in multi-link operation else
>> @@ -10976,14 +10988,16 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
>>   
>>   	num_hw = total_radio / radio_per_hw;
>>   
>> -	if (WARN_ON(num_hw >= ATH12K_GROUP_MAX_RADIO))
>> -		return -ENOSPC;
>> -
>>   	ag->num_hw = 0;
>>   	device_id = 0;
>>   	mac_id = 0;
>>   	for (i = 0; i < num_hw; i++) {
>>   		for (j = 0; j < radio_per_hw; j++) {
>> +			if (device_id >= ag->num_devices || !ag->ab[device_id]) {
>> +				ret = -ENOSPC;
>> +				goto err;
>> +			}
> 
> ath12k_warn()
> 

same here.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

