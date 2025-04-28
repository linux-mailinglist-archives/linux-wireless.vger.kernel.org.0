Return-Path: <linux-wireless+bounces-22116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF97DA9E7B7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1A33B0829
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098FC1A5BBA;
	Mon, 28 Apr 2025 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FvZWytwC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23011211C
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745817680; cv=none; b=Cx1GwDB6wUQvL/W65Sjxw8Iqkrva3wyCYIe+cxqrZsJGtYhgh9eLa1+0YmXbd1aacaDQIj035bSu/Zv6uLFPoNv88ONzIRehV7sPnlCg/gB8cmwEkbn6UnudO1Y17jF2Q53lMlfaAS7bux2WNwTwCyUQvbuuemeqi2It2nSSl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745817680; c=relaxed/simple;
	bh=VIEA19An8ZBqndkF4lhmi1beCoZlFQApe34UsmaELhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FVd+7enRRTm58qY0l8n9OzIVAAm4JnmsBDPKA1GGcLG9+3/PMC96dEOfeg32ILvn+tFY1MlNjchcRVBQGm93VhnHoqCjQeA6QtDka9SxAE3/o8AJ2ZffKI0YcD8gtSUzh6e8pJFmNIT+SLfGlHTUtCvEZqFiGsKutrVv4WG4cuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FvZWytwC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S5HO8T016985;
	Mon, 28 Apr 2025 05:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5OQNn24Iyf3CG5cj7DskG15GgMi87H/932MZJ38XKQM=; b=FvZWytwCKvOdwztq
	R6OlUi01gd/QPatjuLuj9prclMIspCPU1YrBaBqBZQmJXmfli7H1N7ihtqMtZ8q7
	1N0k0EXXZ0jmJYKOp9BHQfzcl+z1dWuHwXc3VJDUFNw1PCGbgju/4gojsabVX2Lk
	/H4nalQd7oa9Wyl9xajl693PlDDe/Z5t3IqfyyVSosuu1XGLUOIMFq25i/+x5Sc+
	yNmLiOG1uPB1hR+xp7xHcK34FQPmeQALwj5VhoNsY2w9/RUDcGs/u8f3sHEkRPFU
	5rdtZtkaJngALV/B74/JtDFwDHvea+N19FhB9ii1hn1u8r1UQC23E4Se7Uo4Qzau
	C2kFkA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468pg98qdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 05:21:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53S5L0lk031818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 05:21:00 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 27 Apr
 2025 22:20:59 -0700
Message-ID: <6dc1f603-096f-45e8-9a28-69e414fe467a@quicinc.com>
Date: Mon, 28 Apr 2025 10:50:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
To: Ben Greear <greearb@candelatech.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
 <c3a6b07e-007e-4168-bf8a-7b0d9ebbc913@quicinc.com>
 <927c6766-47d0-dcf6-cbe5-9da1e67292ad@candelatech.com>
 <c7d093ce-11fd-44e2-ab23-6ad5a3e4bb64@quicinc.com>
 <595c7624-c3ab-452a-b3c1-0b14184a6691@candelatech.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <595c7624-c3ab-452a-b3c1-0b14184a6691@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZpvtK87G c=1 sm=1 tr=0 ts=680f103e cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=kg9Ay9xMY8IGsOGWJPsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CUdIsUsbgEMWYc8XdeitloxS4UTecLas
X-Proofpoint-GUID: CUdIsUsbgEMWYc8XdeitloxS4UTecLas
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA0MiBTYWx0ZWRfXwk33XeT0EwdC PyheiHggyDHsx0yXHz9E7cDHFlWaw8RIX/5aC8d36yF2MKAzr2ppIClsStTUpI6gR7hvFXn/H2x mYQjhhzNzBzlsu++eTZFYmld0sX6Czzqo/jkVOeSbHnBiBoe+WUilrXaTMy7Tu3/Y7t7vlwKfJ6
 xMf5xjiGsDM8MxRkoVaBdMX0qaWpXY5nU0bJiAHURFiPAdeC+5d+op6rVWdYt3wLFLeudQUW/J+ BXH5qeTACRp2abrPqm2Uoz0mMGp2GhrVOcSuuwiHZAQieSJGmV6DJU4Ypm6AyaLk3ISLei0lt72 lnyvkGa1yh1FkvJPkb0AuAJGywBSgyhGycHhg74HnC2uILIrzTV54VKaf2YTYrs7fxlnKku9bx6
 Z+VtHEIGSv18PnN2qoK0iAXt5fqD1MqtutAk6rfrxWJ6F7lcACHPfQbFxRdwJWhJTlI/bedH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=863 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280042

On 4/25/2025 6:44 PM, Ben Greear wrote:
> On 4/24/25 22:33, Sarika Sharma wrote:
>> On 4/24/2025 10:32 PM, Ben Greear wrote:
>>> On 4/24/25 09:44, Sarika Sharma wrote:
>>>> On 4/23/2025 10:22 PM, Johannes Berg wrote:
>>>>> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>>>>> Current implementation of NL80211_GET_STATION does not work for
>>>>>> multi-link operation(MLO) since in case of MLO only deflink (or one
>>>>>> of the links) is considered and not all links.
>>>>>>
>>>>>> Therefore to support for MLO, start reorganizing sinfo structure
>>>>>> related data elements and add link_sinfo structure for link-level
>>>>>> statistics and keep station related data at sinfo structure.
>>>>>> Currently, changes are done at the deflink(or one of the links) 
>>>>>> level.
>>>>>> Actual link-level changes will be added in subsequent changes.
>>>>>>
>>>>>> Also currently, mac80211 ops .sta_statistics() is mapped to fill 
>>>>>> sinfo
>>>>>> structure. But to add support for station statistics at link level,
>>>>>> change the ops to .link_sta_statistics() to fill link_sinfo 
>>>>>> structure.
>>>>>>
>>>>>> Additionally, move connected_time before assoc_at in station_info
>>>>>> structure to get minimal holes.
>>>>>> pahole summary before this change:
>>>>>>   - size: 232, cachelines: 4, members: 23
>>>>>>   - sum members: 223, holes: 3, sum holes: 9
>>>>>>   - forced alignments: 1
>>>>>>   - last cacheline: 40 bytes
>>>>>>
>>>>>> pahole summary after this change:
>>>>>>   - size: 224, cachelines: 4, members: 23
>>>>>>   - sum members: 223, holes: 1, sum holes: 1
>>>>>>   - forced alignments: 1
>>>>>>   - last cacheline: 32 bytes
>>>>>>
>>>>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>>>>> ---
>>>>>> NOTE:
>>>>>>   - Included driver changes for fixing compilation issue.
>>>>>
>>>>> Does this really need to do all the changes in mac80211 and the 
>>>>> drivers?
>>>>>
>>>>> OTOH maybe if not then it would cause much more back and forth?
>>>>
>>>> Yes, true this patch includes only the minimum necessary changes to 
>>>> resolve the compilation issues in mac80211 and the drivers.
>>>>
>>>> Without these changes, compilation issues will persist.
>>>>
>>>>>
>>>>>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>>>>>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy 
>>>>>> *wiphy, struct net_device *dev,
>>>>>>       else if (left < 0)
>>>>>>           return left;
>>>>>> +    sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>>>>>> +    if (!sinfo->links[0])
>>>>>> +        return -ENOMEM;
>>>>>>
>>>>>
>>>>> This seems rather error-prone to me.
>>>>>
>>>>> We already have sinfo->pertid today, allocated and freed by cfg80211,
>>>>> and here you've added something that's allocated by the driver and 
>>>>> freed
>>>>> by mac80211. That seems odd in comparison?
>>>>>
>>>>> I'm not sure what the choices are, but I can't say I like this one ;-)
>>>>> Maybe it's still the least bad option.
>>>>
>>>> Options what I can think of here, other then above approach, may be 
>>>> can allocate memory during get_station() call only, in cfg80211(but 
>>>> this may not be memory efficient as have to allocate for all 
>>>> possible links).
>>>>
>>>> or, may be can introduce an API in cfg80211 to allocate the memory 
>>>> for sinfo->links, and call the API from drivers/mac80211 while 
>>>> filling the sinfo->links[] data.
>>>
>>> sinfo->links[] could be an array in sinfo instead of a pointer, so 
>>> whatever allocates sinfo
>>> automatically allocates the links memory area, and then just fill in 
>>> those values as needed
>>> in the driver and ignore them in mac80211 if not filled?
>>>
>>
>> sinfo->links[] cannot be used as an array because taking an array of 
>> IEEE80211_MLD_MAX_NUM_LINKS (15) would make the station_info structure 
>> too large, exceeding the maximum allowed size.
> 
> If you mean max allowed size on the stack, then you could alloc it from 
> the heap
> and free it when done.
> 
> Or you could just alloc storage for 3 links for now since no radio has 
> more than that currently.

I agree, currently it's 3 only, but everywhere we are using max-15, so 
explicitly keeping it 3 here isn't questionable?
Also, in future it will not be useful approach, when we need to increase 
the links(that time we have to change this to pointer instead of array).

> 
> Thanks,
> Ben
> 
>>
>> Instead, we can use the earlier method (define 
>> deflink(link_station_info) for non-MLO and use the same), but Johannes 
>> did not favor that approach, so I avoided providing this as an 
>> additional option.
>>
>>> Thanks,
>>> Ben
>>>
>>
>>
> 


