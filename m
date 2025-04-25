Return-Path: <linux-wireless+bounces-22032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D95FA9BDE5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 07:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5464425F0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 05:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D0229B18;
	Fri, 25 Apr 2025 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ghHUxKKY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24007227E93
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559214; cv=none; b=OpbLNsSHAU5Q/QdtDqMKOhhvuIi2ZlMVkakDDr4RLPoNR4qzHYRVdq8yDc8yKQnfqUbUMMcT6T4v3sCO+vgCvGo0Nj7B5i3V2RM2tqPqOK3LxuxmjvsGV7fzwkyQhqSaQmLKZmX3WynUtXm9Ml+kJiJjhkK2VGK/EcQIbSBzjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559214; c=relaxed/simple;
	bh=vmeGG6P2HUOMrzCrFegMpQ2+cxpWiv450xMyQDyppC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YtMjXQ4aufZEnmf+IT/Al956ToZUhy0H5RojEtO1wX4zJ1iTJJ7KVTTcmUZtgIE2cuasEYvrf8/gVirMQxFontEIjTtxkyJh+MSMMUbdE55iEoRW0qepF9l52JEOWvxGLnz4XzHQ8S4RtItLUZk7DM/HH9u0fFkLHZ0pdjPjv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ghHUxKKY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P17BMu020372;
	Fri, 25 Apr 2025 05:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mo4Z2uVu2HlCmv7ydqeSTT7KbtfNnHlqnlLuYDv7PfY=; b=ghHUxKKYtCZUxMlQ
	uFfp01qSlXGFCG20uaRDRTisOyN3sobp514g3+TsnGyi9t8aeu9PO9x35Qfxgwes
	Mv9mlGfW/g2kNnckN1kRzK2o38VZLQvQ+k8dE16U/Dzd+vDRoL/E/a76/pvWTatv
	STd6MaL/4nERpfARykZ+HGYOCu56CojaFgUgoWALlSFn5/DPmDu9aTD4t6ikG6J9
	xEZXIGkGxcC3b32sx5UPVEcJyKIzLmv/GfLBj8IhrHX7mwh5ojWScVJQB8MZKYz3
	j53WyUGJLXExmIBTa037BkJMB0034KThRXADbaWlQ/Gz+WPzLWWMxj/N59aOfY05
	ojOsCw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1qu6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 05:33:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53P5XQcr004741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 05:33:26 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 22:33:24 -0700
Message-ID: <c7d093ce-11fd-44e2-ab23-6ad5a3e4bb64@quicinc.com>
Date: Fri, 25 Apr 2025 11:03:21 +0530
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
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <927c6766-47d0-dcf6-cbe5-9da1e67292ad@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sNS2YoX-FtJCdygTc3wUl-s24PhEA6kB
X-Proofpoint-ORIG-GUID: sNS2YoX-FtJCdygTc3wUl-s24PhEA6kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzOCBTYWx0ZWRfX1XMkP+Eq3iI2 jQ2/F4SIYfi4tlRVv1RCteZxTauT8zdp1seh/YE7HxOWqYJ4JQAo8kZBwQ1gf1V+ImFqm2pf52Z hKPqZEvF3AcvK0vLcLE6+g/9sUHi2pb4ZUx6iTPOcN25Y3sEBOBUG7wIF69t+x5lHS5E6SN1EQS
 QHuWk+RfWGb7TiVtF9M+50xnpcLOv4x1dDqCNIilZBobygLUDi+xNOuR65U4XhVXWm0O4NFRZy7 dpX3Hz3srPx9GWoAikh3w7khgArg02In0dhG/+Yjs3ruuttzimvLV/qHZ8448+m5j/sHX8j2jGs be/A3BJ30A6WX019XQbvCkofgpLhrtoa0InjdJqZ4TXtaHL9XhpEtu0fvQtppRFvkcUv9rqvPsr
 9q5gHXhn3BH2pkAiR9bK52kmg5ndzC6AYY/EB++VaJa+BVgxS6i89IAgE2l9OTbPi0TPbQnJ
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=680b1ea6 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=ybY5iexyr2P27qrjYAwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=819 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250038

On 4/24/2025 10:32 PM, Ben Greear wrote:
> On 4/24/25 09:44, Sarika Sharma wrote:
>> On 4/23/2025 10:22 PM, Johannes Berg wrote:
>>> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>>> Current implementation of NL80211_GET_STATION does not work for
>>>> multi-link operation(MLO) since in case of MLO only deflink (or one
>>>> of the links) is considered and not all links.
>>>>
>>>> Therefore to support for MLO, start reorganizing sinfo structure
>>>> related data elements and add link_sinfo structure for link-level
>>>> statistics and keep station related data at sinfo structure.
>>>> Currently, changes are done at the deflink(or one of the links) level.
>>>> Actual link-level changes will be added in subsequent changes.
>>>>
>>>> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
>>>> structure. But to add support for station statistics at link level,
>>>> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>>>>
>>>> Additionally, move connected_time before assoc_at in station_info
>>>> structure to get minimal holes.
>>>> pahole summary before this change:
>>>>   - size: 232, cachelines: 4, members: 23
>>>>   - sum members: 223, holes: 3, sum holes: 9
>>>>   - forced alignments: 1
>>>>   - last cacheline: 40 bytes
>>>>
>>>> pahole summary after this change:
>>>>   - size: 224, cachelines: 4, members: 23
>>>>   - sum members: 223, holes: 1, sum holes: 1
>>>>   - forced alignments: 1
>>>>   - last cacheline: 32 bytes
>>>>
>>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>>> ---
>>>> NOTE:
>>>>   - Included driver changes for fixing compilation issue.
>>>
>>> Does this really need to do all the changes in mac80211 and the drivers?
>>>
>>> OTOH maybe if not then it would cause much more back and forth?
>>
>> Yes, true this patch includes only the minimum necessary changes to 
>> resolve the compilation issues in mac80211 and the drivers.
>>
>> Without these changes, compilation issues will persist.
>>
>>>
>>>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>>>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy 
>>>> *wiphy, struct net_device *dev,
>>>>       else if (left < 0)
>>>>           return left;
>>>> +    sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>>>> +    if (!sinfo->links[0])
>>>> +        return -ENOMEM;
>>>>
>>>
>>> This seems rather error-prone to me.
>>>
>>> We already have sinfo->pertid today, allocated and freed by cfg80211,
>>> and here you've added something that's allocated by the driver and freed
>>> by mac80211. That seems odd in comparison?
>>>
>>> I'm not sure what the choices are, but I can't say I like this one ;-)
>>> Maybe it's still the least bad option.
>>
>> Options what I can think of here, other then above approach, may be 
>> can allocate memory during get_station() call only, in cfg80211(but 
>> this may not be memory efficient as have to allocate for all possible 
>> links).
>>
>> or, may be can introduce an API in cfg80211 to allocate the memory for 
>> sinfo->links, and call the API from drivers/mac80211 while filling the 
>> sinfo->links[] data.
> 
> sinfo->links[] could be an array in sinfo instead of a pointer, so 
> whatever allocates sinfo
> automatically allocates the links memory area, and then just fill in 
> those values as needed
> in the driver and ignore them in mac80211 if not filled?
> 

sinfo->links[] cannot be used as an array because taking an array of 
IEEE80211_MLD_MAX_NUM_LINKS (15) would make the station_info structure 
too large, exceeding the maximum allowed size.

Instead, we can use the earlier method (define 
deflink(link_station_info) for non-MLO and use the same), but Johannes 
did not favor that approach, so I avoided providing this as an 
additional option.

> Thanks,
> Ben
> 


