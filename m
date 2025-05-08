Return-Path: <linux-wireless+bounces-22736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D70AAF6E2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E5A1C040E0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7F2620C3;
	Thu,  8 May 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YWp8L6LP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B271953A1
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697114; cv=none; b=ixFqcSn10Fds1m+ITuoaLviOE2KxKD0iI+cfgIRvKfz2YnGeUZXyKVrDDqeNEwuflUy/NKJSEMsHLBLDh24uojmfGTLJiZwksXdRsTqxKvqClWVVZb7/52vDnxZ05UKV2cL5tXBhDZ+Vm/+iFwn/LCQnhlMrhbsc1I1pqSB+Ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697114; c=relaxed/simple;
	bh=qmG5rjOfCtUo4YAFnKXYelDIwXFQfPNlfSS/ojBXQac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kcUyvn5Hvp5aNL9j2yKkWX6ksW37MtQBOYEm3BdNs7LTY+0vh6C432pggW4BYwTtecoNIxzPccZTjUbOK5hFPx5U6G3dLCzRIjm/hf8g2njs7iuw7q341bWE/6nqJeMehD1cuOuPuEuhQL0Hl13VLICgkbVdLIcZchaPEz2a4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YWp8L6LP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5488lS8x019189;
	Thu, 8 May 2025 09:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NPfnLomn7EZE6cCZVGVZSpojxyVevg8JR1IZGRZ/qbM=; b=YWp8L6LPC4RcaGm6
	4wlyaDXluRm2fYwlcZJB4V8v7ift515zSyP32XZbQjyPW4OoA7c+11CIUIwGYETk
	Jq3MArLMw7wmM5k0BrLUriOWlximWiDNyuAawa+MGqvXNNUZ3KL/ZWgGmLotrXeR
	IqGFK7QPD58GfSZ0AexOhiOH49CfHAXz7x60yM5ud+fY8QSPiQaKpKBHD6SDYjKy
	vrYsjOosCQXBW+pVHHjDJFE9MlHzpPmD7jZVPVUSVE7t0acd6o4RN/vejyjfg3bj
	KKM2izAI3Tlin6ry/FP/TZ47/rsKJXeWwbwsywSylhqOHRvLoQULQZ1yip1QHplk
	pHl5Dg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gsdj06bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 09:38:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5489cRZq007024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 09:38:27 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 02:38:26 -0700
Message-ID: <33c029c7-fee2-4a25-b56c-403eadadd153@quicinc.com>
Date: Thu, 8 May 2025 15:08:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <a12320b826ef7395bde044d9dcc7ad9f902c6ef9.camel@sipsolutions.net>
 <14df6327-1a31-4ddc-a2b5-1055cbd5b686@quicinc.com>
 <7a4a1d26e2c3905963fc5c7336fb5651a796a85f.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <7a4a1d26e2c3905963fc5c7336fb5651a796a85f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PMAP+eqC c=1 sm=1 tr=0 ts=681c7b94 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=3cuLYT9IQo7awuquwaUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA4NiBTYWx0ZWRfXyrPQA7SmuVI7
 RPI3NakwqiGeqasDDuYaueavBDd59C5siOYjXbF1pGxWt6Gx3JTHpsiycMBQWv7YSJhiNvxh8p+
 +MRaOFUeDUmg5uBVzDj9YeqDagUR86GFcmRnMrknUiHj0Cb2FR67lcLRK3QygkBcwjqisrK8Nmj
 f4FrEuY5zYZ/zZbCB/01QqdHqznVMaB5QHgOj4l/OiurVmpDA8ZUW3+T31p0J1ZNSz+bYvrtBrs
 JWVMzQ/eJHn3vnZGB1xeLO20ENfBiw/Kc1NRMkTCyVqFc4j//4+k4v7SDhJRuh9XmZkU62Dm2ZH
 07F9wu2AzfdkDa10jmIShDyCtzbAJOQMJN3e9Mf4GAN/e6eAzcsaDBD0vFDnoqfj9EGmIRVLOmW
 d5Yw6WoRTLZ6XKQxuzLacYfhJd+lD3iLlFZ6XZ4T/AP29q/1QPj5yGYwHqNQespiyLdOytvJ
X-Proofpoint-GUID: -8kaxi36GamATn9FPlcoG6i_TeVuxXe1
X-Proofpoint-ORIG-GUID: -8kaxi36GamATn9FPlcoG6i_TeVuxXe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080086

On 5/8/2025 2:47 PM, Johannes Berg wrote:
> On Thu, 2025-05-08 at 14:34 +0530, Sarika Sharma wrote:
>>>
>>> But to be honest I completely forgot all the history here. Looks like
>>> your initial patches couldn't even build, so I can't compare well with
>>> what it would've looked like before.
>>
>> Oops! if require can send new version V7, in building state(as already
>> prepared the patch as per last comments)?
> 
> No no, I meant *initial* patches, I was just trying to look at v1/v2/...
> to compare how much driver changes they all needed, but in the earlier
> versions you just skipped the driver changes entirely, so I couldn't
> compare :)

Yes, that patches send as RFC and avoided driver changes, to get review 
on design.

> 
> As far as I can tell this version builds fine, the robot seemed happy.

:-)

> 
>>
>>> We can also prohibit filling entries that make no sense for multi-link
>>> statistics when provided on a global level, though honestly I feel like
>>> for most of them we should actually provide some value, even if tx/rx
>>> rate is just the best rate of all the links, or something like that?
>>
>> Yes, but then document for station_info structure needed to be updated here.
>> As for some of fields it will be similar for both non-Ml and MLO case.
>> But some of fields like signal,rates, etc, meaning will be different for
>> non-ML and MLO stats.
> 
> Agree, and maybe some of the fields should just be prohibited for MLO
> (like signal/rate) until we figure out what semantics we want for them
> for MLO. But we can document and implement that, I'd think?

Sure.

> 
>>>       This would also not yet require any drivers or mac80211 to change at
>>>       all, since it's just adding a new capability.
>>
>> Oh! Do you mean not add all the things now at link level? and add
>> afterwards as per requirement/ while adding new capabilities?
>>
>> or add as of now and let driver/mac80211 filling those capabilities
>> handle it later part on.
> 
> I just mean wrt. the patch sequence.
> 
> As it is now you're making a lot of changes to drivers/mac80211 during
> the cfg80211 patches (specifically patch 4), but then in some sense you
> *undo* the need for those later (after patch 7 a lot of the driver
> changes aren't _really_ needed, particularly for non-MLO drivers).
> 
> That seems harder than it should be. We later have a lot of the fields
> back that were modified earlier, so I'm suggesting to just not do it
> that way, but rather keep _all_ the fields, then you don't have any
> driver changes.
> 
> Then add all the fields for each link, and the nl80211 code, aggregation
> code, etc.
> 
> And _then_ you can start moving things over much more easily, like
> mac80211 would start providing per-link stats for all the fields, and
> accumulated stats about removed links in the original "non-MLO-
> statistics" fields (regardless of whether they're reported that way
> because the connection isn't MLO, or because the driver wasn't updated.)

Yes, sure. I will start this way.

> 
> 
>>>       Oh, in terms of allocation - the struct isn't huge now, do we even
>>>       care about simply adding 15 links? It still stays well below a
>>>       page as far as I can tell ... keep it simpler for now?
>>
>> Okay! but although many fields are more applicable at link level. So
>> isn't keeping the pointer is better then keeping array[15](seeing error
>> with array [15], mentioned below)?
> 
> Right ... hm. I actually thought this struct was already not on the
> stack, not sure why. That's why I was talking about the size of
> allocations etc.
> 
> Alright, since we already have cfg80211_sinfo_release_content() it seems
> easier now to actually allocate the link stats dynamically, so instead
> of what I just said in my other email:
> 
> 	struct link_station_info links[15];
> 
> we'd have
> 
> 	struct link_station_info *links;
> 
> and then just make sure we allocate a 15 links array, and free it in
> cfg80211_sinfo_release_content().

Yes, can have that as struct link_station_info *links[15];

For memory allocation here, we have 2 approaches.

1. allocate in cfg80211 during get_station/dump_station call (by adding 
the wiphy flag introduced in patch-6 or allocate the memory everytime ?)

2. Allocate in mac80211, in sta_set_sinfo() during station_info 
structure filling?

> 
> That actually it looks the same for the users, e.g. "sinfo.links[3]".

Yes.

> 
> johannes


