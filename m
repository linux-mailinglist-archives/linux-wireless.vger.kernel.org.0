Return-Path: <linux-wireless+bounces-18513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D9A28737
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC13D168FC3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD522A7FA;
	Wed,  5 Feb 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W9ZxUfDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F901D7985;
	Wed,  5 Feb 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749578; cv=none; b=IbmvkmoDvPkyH8yU6/7SThnQkOStB64Z8K2RFxbTAEoYlSyCqVOEpJxE1jN08EoTN/BnvQlwZQFeYxLZhsL47Srcjo+DEva50+MF6LNmtNKZm9GaKwI5lS88jvcCWErdUOK35NKmnXK5MCVFIpWH++64goSQKQZqHH5s8zvzq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749578; c=relaxed/simple;
	bh=BMMdGh0m1XSUjpnLw1cw4cmZPbOCtVdzE3BdNEFI+QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nOIBh446nhE31RC9EsRZiiaX7Jw6T+pwIrCs3MOs8otpxTVnBXUbx21vheC2UGzNou0yERmXype+Z80kOoXa/7/bix3EfQ7Iomevnk5+mrhCgEEKFHV5QJNj5H29wvkz9SZqI0GQ+u47DzNICFslrH1V8JOSxom09FNnDPwtgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W9ZxUfDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51561pTb023597;
	Wed, 5 Feb 2025 09:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1DRDwzg7jRP9FoY4EZ2cmdf6ROjlJkCPnZVzZlK67l0=; b=W9ZxUfDGLF9mnh8W
	8vgth5FT3Gy9QnhHn7rKVCHIPcHAGXQxE0TvB8iv56hOgDD4aR8Q8fkQjLgzPfxp
	v/Af1AcpRjTgo9QMvgJ0Nxqkrp6PmBS3DLf5kmpqbcHEUMugEnTdmsRZsFagyldQ
	eVG9nIbHhDr9rOvvos8wiqI0t/vQVDbF6qIvvJ45Z4pY7XyVs5KUzxBN5ulXfGx4
	zhRnmz9/flsncUtXIt3rSAiVGTigAE9VW2k1pVBjgQKcIkYw7AXgMblL4hZsc2Es
	lQYaaxYlF5gsajPT8z+H7XBdYR9edJXxsntIzE3soXBKTzbwOhPTvZTIB4Y7TGDX
	todGNg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m2bxrghf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 09:59:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5159xUMO019677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 09:59:30 GMT
Received: from [10.151.41.196] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Feb 2025
 01:59:26 -0800
Message-ID: <8fc38912-f1f2-438d-a8ab-bfabb31825fb@quicinc.com>
Date: Wed, 5 Feb 2025 15:29:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] wifi: ath12k: add support for fixed QMI firmware
 memory
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-8-quic_rajkbhag@quicinc.com>
 <4c9b512f-59d2-4d96-a899-5af4de2c823e@kernel.org>
 <7d5f7b4c-2a55-41c7-b85c-cb4cd76d553f@quicinc.com>
 <962dc257-f7a6-49c7-b760-a31fd84e7a56@kernel.org>
 <c7d9842a-96bf-41aa-8046-52c3e45f90d4@quicinc.com>
 <f8b8a39d-043a-4be0-9024-c080cf864e7b@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <f8b8a39d-043a-4be0-9024-c080cf864e7b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jm_ina_HOBmu5klqHlDOJakEN7WiTm66
X-Proofpoint-GUID: Jm_ina_HOBmu5klqHlDOJakEN7WiTm66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050079

On 2/5/2025 2:37 PM, Krzysztof Kozlowski wrote:
> On 04/02/2025 10:06, Raj Kumar Bhagat wrote:
>> On 2/3/2025 3:42 PM, Krzysztof Kozlowski wrote:
>>> On 03/02/2025 10:44, Raj Kumar Bhagat wrote:
>>>> On 1/30/2025 1:16 PM, Krzysztof Kozlowski wrote:
>>>>> On 30/01/2025 05:35, Raj Kumar Bhagat wrote:
>>>>>> @@ -2646,6 +2663,136 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
>>>>>>  	return ret;
>>>>>>  }
>>>>>>  
>>>>>> +static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
>>>>>> +{
>>>>>> +	struct device_node *mem_node;
>>>>>> +	struct resource res, m3_res;
>>>>>> +	u32 bdf_start_addr;
>>>>>> +	int i, idx, ret;
>>>>>> +
>>>>>> +	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
>>>>>> +		switch (ab->qmi.target_mem[i].type) {
>>>>>> +		case HOST_DDR_REGION_TYPE:
>>>>>> +			mem_node = ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
>>>>>
>>>>>
>>>>> Why cannot you use existing API for reserved memory -
>>>>> of_reserved_mem_lookup()?
>>>>>
>>>>
>>>> The of_reserved_mem_lookup() requires reserved memory node to read the memory and
>>>> return in the structure "struct reserved_mem".
>>>>
>>>> The of_reserved_mem_lookup() would be used after we get the reserved memory node
>>>> using the API - ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
>>>>
>>>> In next version we would use of_reserved_mem_lookup(), Something like below:
>>>>     mem_node = ath12k_core_get_reserved_mem_by_name(ab, "q6-region");
>>>
>>> Then why do you need ath12k_core_get_reserved_mem_by_name() in the first
>>> place? Just use of_reserved_mem_lookup() directly. Why do you need to
>>> parse phandle before of_reserved_mem_lookup()?
>>>
>>
>> Sorry, I'm having difficulty understanding this.
>> We have the WiFi node at ab->dev->of_node, but we don't have a node for the reserved-memory
>> 'q6-region'. The of_reserved_mem_lookup() function requires the device node for 'q6-region'.
>>
>> Could you please suggest how we can use of_reserved_mem_lookup() without obtaining the
>> 'q6-region' node first.
> 
> 
> Hm, it seems you are not using it for this device, so indeed you need to
> parse phandle. You can still code it simpler -
> of_property_match_string() is not necessary and
> of_address_to_resource()+of_node_put()  could be in the
> ath12k_core_get_reserved_mem()
> 

Thanks, will make it simpler.


