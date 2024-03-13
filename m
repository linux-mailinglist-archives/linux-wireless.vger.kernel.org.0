Return-Path: <linux-wireless+bounces-4674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3B587A7EA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 13:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C32863FC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBA2EAF7;
	Wed, 13 Mar 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jk9LdkGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57B224D8
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334681; cv=none; b=aOmT1iD/zu8t4dHCp87H8uADmZOu4Y225u+f/Ywqin1TfZqfxC1vqwJxj1wE23Rjc7m7EZNhoevp7C5Jh5JsYw4V7pyc/W9j27lfqiIYVgph5oABpJsGDTzwW2jvmAu0AuOqSjJOnWddIoJv50YL+LhMvuWYgo2xTJsHY4vvmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334681; c=relaxed/simple;
	bh=C0yIS6HrVwe7Y3ASdjpBJV5Fmxw4ZQj9Nja4AoDwbaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MivTT9iuu7bWvBu8hzjOJjoNAZ6GrwFzaMw52lFV0Kv67GrKoajq9vM8YaIJY/74jtZnE2iobTY4lRyG4SGTJqKU6LQ9ZmF75rdy45+Nsc8kaJrOn52EengTXQhkcaJxaCpph2brJYCEDcJFAzze/HB9Md0rGw95MUhfAfdQiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jk9LdkGI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DBpufQ031383;
	Wed, 13 Mar 2024 12:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WDFy/DERmqi1Jb2rQOYRdIoz3wrBTbxJjE/j67jSBKI=; b=Jk
	9LdkGIMpIxXi/zapREb8nk5YS324LxE/EYt7y0Z7cd8MAYHvPx+Q65ShwZ1y9cxq
	snbpkg8ukh7JkhkQm9PMHWGjXicQKbhw6ZsNQl3fvq92GUfERk442JARgpGm0PsF
	SZnkIl16f/N7DtPpNrTjL8GQursfQAMM1w07ekB9UylL/0nvXVdeNnch6bW5txni
	t7TAAxuaOE9JufCJt+Ix/eDCWwX7TB4uNwwoRMP2X4dkx1XNaAXizJ9wP1wOOGlh
	uPJNq1iygMaXy8PYnSaFIbhQHuln5xyaq3viouhoPdSUNLjJZa+6diTrNzdFVitY
	taNc4cDGROeeCp8YgBtg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu62w8uj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 12:57:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DCvqep029281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 12:57:52 GMT
Received: from [10.50.3.124] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 05:57:49 -0700
Message-ID: <3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
Date: Wed, 13 Mar 2024 18:27:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-2-quic_ramess@quicinc.com>
 <4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jZT_D5PLqpTMDZyKpPbdhOBWT-CXLGXC
X-Proofpoint-ORIG-GUID: jZT_D5PLqpTMDZyKpPbdhOBWT-CXLGXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130097



On 3/13/2024 3:23 AM, Jeff Johnson wrote:
> On 3/12/2024 6:55 AM, Rameshkumar Sundaram wrote:
>> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>
>> Currently MAC HW un/register helper function support the single radio.
>> To enable single/multi link operation in the future, the following helper
>> functions need to be refactored to accommodate multiple radios under a
>> single MAC HW un/register:
>>
>> 	* ath12k_ah_to_ar()
>> 	* ath12k_mac_hw_allocate()
>> 	* ath12k_mac_hw_register()
>> 	* ath12k_mac_hw_unregister()
>>
>> This refactoring will make it easier to scale these functionalities and
>> support Multi link operation.
>>
>>                           Current Multi wiphy Model
>>
>>   +---------------+          +---------------+            +---------------+
>>   |  Mac80211 hw  |          | Mac80211 hw   |            | Mac80211 hw   |
>>   |  private data |          | private data  |            | private data  |
>>   |               |          |               |            |               |
>>   |ath12k_hw (ah) |          |ath12k_hw (ah) |            |ath12k_hw (ah) |
>>   |               |          |               |            |               |
>>   | +-----------+ |          | +-----------+ |            | +-----------+ |
>>   | | ar (2GHz) | |          | | ar (5GHz) | |            | | ar (6GHz) | |
>>   | +-----------+ |          | +-----------+ |            | +-----------+ |
>>   |               |          |               |            |               |
>>   +---------------+          +---------------+            +---------------+
>>
>>                             Single wiphy Model
>>
>>                              +--------------+
>>                              | Mac80211 hw  |
>>                              | private data |
>>                              |              |
>>                              |ath12k hw (ah)|
>>                              | +----------+ |
>>                              | |ar (2GHz) | |
>>                              | +----------+ |
>>                              | |ar (5GHz) | |
>>                              | +----------+ |
>>                              | |ar (6GHz) | |
>>                              | +----------+ |
>>                              +--------------+
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |  12 +-
>>   drivers/net/wireless/ath/ath12k/mac.c  | 184 ++++++++++++++++---------
>>   drivers/net/wireless/ath/ath12k/reg.c  |   2 +-
>>   3 files changed, 127 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 97e5a0ccd233..ff831faa4945 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -951,13 +951,21 @@ static inline struct ath12k_hw *ath12k_hw_to_ah(struct ieee80211_hw  *hw)
>>   	return hw->priv;
>>   }
>>   
>> -static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah)
>> +static inline struct ath12k *ath12k_ah_to_ar(struct ath12k_hw *ah, u8 hw_link_id)
>>   {
>> -	return ah->radio;
>> +	if (WARN(hw_link_id >= ah->num_radio,
>> +		 "bad hw link id %d, so switch to default link\n", hw_link_id))
>> +		hw_link_id = 0;
>> +
>> +	return &ah->radio[hw_link_id];
>>   }
>>   
>>   static inline struct ieee80211_hw *ath12k_ar_to_hw(struct ath12k *ar)
>>   {
>>   	return ar->ah->hw;
>>   }
>> +
>> +#define for_each_ar(index, ah, ar) \
>> +	for ((index) = 0; ((index) < (ah)->num_radio && \
>> +	     ((ar) = &(ah)->radio[(index)])); (index)++)
> 
> 
> this seems like logically the wrong order of operands
> this is an operation on the ah object so IMO that should be first
> the actual iterators i and ar should follow that
> 
Sure Jeff, will rearrange the operands as suggested.
> and guess we have to figure out how to suppress the ath12k-check issues with
> this macro
ath12k-check complains about the reuse of ah and index arguments which 
may get evaluated multiple times if its an arithmetic expression, But 
areas where we use the macro in our code aren't doing so.
Do you have any suggestions here ? or shall we go back and use this 
for-loop inline.
> 
> that's my only comments on this patch.
> 
> /jeff

