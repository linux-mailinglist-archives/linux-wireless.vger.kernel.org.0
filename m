Return-Path: <linux-wireless+bounces-22152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EBDA9F659
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E1A18970F7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320504CB5B;
	Mon, 28 Apr 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ve6fBED7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66E2820B3
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859521; cv=none; b=o6SQ+ansbnmOhlmT24sbJxRDbnKw1DK9mIDQOtLeUdp5BHhPJ0KMhNNO/aEiAi0mMxNcMbAqqRbJqRO7yQqC3fvNa0Rsx68BzIQbzurRhZlvkEdNiJSZnU/8+LgFH1pWdwORf63WIXVZlArwACmQRH5ywfDPU0pDYThHE+stWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859521; c=relaxed/simple;
	bh=ZCysVW0ijtAirt1jpvhRhd1z2/5WC1+IPutPzSdvUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/16UX0l3FqusXyUnCSZc3XPU6I1cSF7yP2incoOnuV389eTkjzuJEBd/c4Fq4l0pFrf6vgm8XBABeIeG672HRj9B5jT+NYnkXJVFcikC//nt3bs+Zz0qXKEggxWfuWcyXFYQRZGgGRFrQgTf+paxeY52ly22bWfnQZ5Gqlr9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ve6fBED7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SACaar025877;
	Mon, 28 Apr 2025 16:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HzX21koEHRC0TtniOqwDyy1Iu7MAbRwsGOhb2m2WgNg=; b=Ve6fBED7ssPACMtA
	iH9LY1FOx1DlliDaxX1BF3JvO8YQ2PnIlonobWKKP8zVXEcQiv3DSrVmyZef7loT
	r0HiziafDvOTS4FPiBu1JcwjlnD2ES94+Fs2bHLlBMwVOdYj/f6MAmJ74MaygWrm
	kEi5DfOJABOJsGX2/kToMzM3EfIochpc/WaH58yRWFvfxMzBPSG1eoMmEz8GoeGB
	uEcc4WF++RdWpoNrE8xU+S0AUk4WdqPkW/90wTaXv9yK/BlLl5i0+9acEroPB7uT
	cdXDz2mZUjvMQNhX2XTDeQB9+9cvXx3PXAl/u44d1D6hJP3G3NT5pR7PXEkVzlfL
	zzz/5A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468q321u0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:58:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53SGwWYB015569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:58:32 GMT
Received: from [10.50.3.121] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 09:58:31 -0700
Message-ID: <f4f36a51-bba3-4634-8d9b-8996712703b4@quicinc.com>
Date: Mon, 28 Apr 2025 22:28:27 +0530
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
 <6dc1f603-096f-45e8-9a28-69e414fe467a@quicinc.com>
 <fb8e9d15-3450-4462-b6d4-994abd15f8e2@candelatech.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <fb8e9d15-3450-4462-b6d4-994abd15f8e2@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=M7xNKzws c=1 sm=1 tr=0 ts=680fb3b9 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=gdyYJWGzbqt4PdqPVQkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8jp4yoPBs7ZsJeufImn6rz8u9ADQ411r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNyBTYWx0ZWRfX9znLYoATrdaN +1oX/YGzyoEmcb3A9bb0QFStAm3lLu9kE7lw+eokSwlNowPQ8SFZ5LIRIIdMtoce8T5Sn5BIijh BRfNcj7xiATfgb/vsgZ+tW8e6AkrkRSNpAnuLu4vJS4YyYkhUhglTygQYxaQsI9FF6Jm7dkS/7+
 5Kesqot4Eqz4NLdtYptTyK+DpH7dIZ1MQofEBpHHyFeD93cFkplcYAorKgcXcYIEv9Ll/MNAC5j OM3kNPtFUrSDT/rqWf5uuks5QesbRDclPuI40UhL5Nqrbkuqq/gbCOMSqGYgby6yZOwWfdKchdc pOSR9g8fPU2rMoCOTeeoqy9cquCr6gRgLm1peII8OEgeDYjo75Y1SsSUYI+ZpMSV5ah03RjQ9ZC
 TuymdhzyaHq+El0QPKeOkJTr1y3KjSsGvLMER8GxlXbT9g/j9XLy4nhG717ALsHLoyFGhZ6o
X-Proofpoint-ORIG-GUID: 8jp4yoPBs7ZsJeufImn6rz8u9ADQ411r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=739 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280137

On 4/28/2025 7:39 PM, Ben Greear wrote:
> On 4/27/25 22:20, Sarika Sharma wrote:
>> On 4/25/2025 6:44 PM, Ben Greear wrote:
>>> On 4/24/25 22:33, Sarika Sharma wrote:
>>>> On 4/24/2025 10:32 PM, Ben Greear wrote:
>>>>> On 4/24/25 09:44, Sarika Sharma wrote:
>>>>>> On 4/23/2025 10:22 PM, Johannes Berg wrote:
>>>>>>> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>>>>>>>> Current implementation of NL80211_GET_STATION does not work for
>>>>>>>> multi-link operation(MLO) since in case of MLO only deflink (or one
>>>>>>>> of the links) is considered and not all links.
>>>>>>>>
>>>>>>>> Therefore to support for MLO, start reorganizing sinfo structure
>>>>>>>> related data elements and add link_sinfo structure for link-level
>>>>>>>> statistics and keep station related data at sinfo structure.
>>>>>>>> Currently, changes are done at the deflink(or one of the links) 
>>>>>>>> level.
>>>>>>>> Actual link-level changes will be added in subsequent changes.
>>>>>>>>
>>>>>>>> Also currently, mac80211 ops .sta_statistics() is mapped to fill 
>>>>>>>> sinfo
>>>>>>>> structure. But to add support for station statistics at link level,
>>>>>>>> change the ops to .link_sta_statistics() to fill link_sinfo 
>>>>>>>> structure.
>>>>>>>>
>>>>>>>> Additionally, move connected_time before assoc_at in station_info
>>>>>>>> structure to get minimal holes.
>>>>>>>> pahole summary before this change:
>>>>>>>>   - size: 232, cachelines: 4, members: 23
>>>>>>>>   - sum members: 223, holes: 3, sum holes: 9
>>>>>>>>   - forced alignments: 1
>>>>>>>>   - last cacheline: 40 bytes
>>>>>>>>
>>>>>>>> pahole summary after this change:
>>>>>>>>   - size: 224, cachelines: 4, members: 23
>>>>>>>>   - sum members: 223, holes: 1, sum holes: 1
>>>>>>>>   - forced alignments: 1
>>>>>>>>   - last cacheline: 32 bytes
>>>>>>>>
>>>>>>>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>>>>>>>> ---
>>>>>>>> NOTE:
>>>>>>>>   - Included driver changes for fixing compilation issue.
>>>>>>>
>>>>>>> Does this really need to do all the changes in mac80211 and the 
>>>>>>> drivers?
>>>>>>>
>>>>>>> OTOH maybe if not then it would cause much more back and forth?
>>>>>>
>>>>>> Yes, true this patch includes only the minimum necessary changes 
>>>>>> to resolve the compilation issues in mac80211 and the drivers.
>>>>>>
>>>>>> Without these changes, compilation issues will persist.
>>>>>>
>>>>>>>
>>>>>>>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>>>>>>>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct 
>>>>>>>> wiphy *wiphy, struct net_device *dev,
>>>>>>>>       else if (left < 0)
>>>>>>>>           return left;
>>>>>>>> +    sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), 
>>>>>>>> GFP_KERNEL);
>>>>>>>> +    if (!sinfo->links[0])
>>>>>>>> +        return -ENOMEM;
>>>>>>>>
>>>>>>>
>>>>>>> This seems rather error-prone to me.
>>>>>>>
>>>>>>> We already have sinfo->pertid today, allocated and freed by 
>>>>>>> cfg80211,
>>>>>>> and here you've added something that's allocated by the driver 
>>>>>>> and freed
>>>>>>> by mac80211. That seems odd in comparison?
>>>>>>>
>>>>>>> I'm not sure what the choices are, but I can't say I like this 
>>>>>>> one ;-)
>>>>>>> Maybe it's still the least bad option.
>>>>>>
>>>>>> Options what I can think of here, other then above approach, may 
>>>>>> be can allocate memory during get_station() call only, in 
>>>>>> cfg80211(but this may not be memory efficient as have to allocate 
>>>>>> for all possible links).
>>>>>>
>>>>>> or, may be can introduce an API in cfg80211 to allocate the memory 
>>>>>> for sinfo->links, and call the API from drivers/mac80211 while 
>>>>>> filling the sinfo->links[] data.
>>>>>
>>>>> sinfo->links[] could be an array in sinfo instead of a pointer, so 
>>>>> whatever allocates sinfo
>>>>> automatically allocates the links memory area, and then just fill 
>>>>> in those values as needed
>>>>> in the driver and ignore them in mac80211 if not filled?
>>>>>
>>>>
>>>> sinfo->links[] cannot be used as an array because taking an array of 
>>>> IEEE80211_MLD_MAX_NUM_LINKS (15) would make the station_info 
>>>> structure too large, exceeding the maximum allowed size.
>>>
>>> If you mean max allowed size on the stack, then you could alloc it 
>>> from the heap
>>> and free it when done.
>>>
>>> Or you could just alloc storage for 3 links for now since no radio 
>>> has more than that currently.
>>
>> I agree, currently it's 3 only, but everywhere we are using max-15, so 
>> explicitly keeping it 3 here isn't questionable?
>> Also, in future it will not be useful approach, when we need to 
>> increase the links(that time we have to change this to pointer instead 
>> of array).
> 
> You can change allocation scheme in the future easily enough, and maybe 
> there will never exist any linux
> driver with more than 3 links anyway?  And you can allocate quite large 
> amounts of memory in the kernel,
> so you could always have it a single struct if you wanted.
> 
> Anyway, Johannes makes the real decisions on this, so hopefully you can 
> get his approval before you
> code something up he dislikes, I was just voicing my suggestion.
> 
> Thanks,
> Ben
> 
> 

Sure, lets see what's Johannes opinion on this.

