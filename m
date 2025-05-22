Return-Path: <linux-wireless+bounces-23301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066FEAC0A10
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F279E54D7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908881F09B3;
	Thu, 22 May 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U21b/ZmY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A621EF387
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910833; cv=none; b=JQR3GRNd+spc9IFICSASIYTUlcMpQMOmsSpOJ90PP1Zp8F86/0vRHMWLG/XCfPn9f/R7rr4CBPkieYBGSYi0duJ2pvtd+0JJ4aNTshUY9T+xEOvbVoTuq9W2YvO4+s1FPRPUV04RVsWM8kBj+iiMZWRLJwpnVt66RbLFn0LHpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910833; c=relaxed/simple;
	bh=jju+ESNIpxjstyHulF5LE3le2WgHgFlpun9BFHugu/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/VuU06EIejCIzeBzSpzCTvptYtOhmioZjG19SV7OZ6MAt/a2ATslba4bTECkaWt64FBh8WK0/1K7pSG4sPe/Z7ABzSrXFDailon0ilMhChCd0YnZatJMwVGUsApsyOTxDX2/Vw8HXTK7Ydy/+LPagQMLEPn4tVCN48k/j0eO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U21b/ZmY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7sgq0000862;
	Thu, 22 May 2025 10:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	66JRZYMR9SkL5k8nHHxRPlTtkxwBwCYENksJW9jxiwA=; b=U21b/ZmYLTmY33/q
	H0ZbrmQjWfEStSCRfKtevWNw60Tw+1sOTQg8K1Xco+JhEpM3Dyt/aaGPtsSqMkcj
	jGWEIIziENRKyGSW15AOu51K/7rAuN7wi+k52Hr0ws7Rh8AkLQqcY863t5da4s5C
	nFHQX3kwSL2IQtI7hdJNMvpm/slVQvvJPCFim4RGzWpMZqE/3OdGPG4KcfLvKCdH
	z/YVthwQE0B3149gg3mdDLWt4WWMMM3dpOZC5Xx9j7H3dfJrY3zO7RyaKGBs+Qgt
	210kpwWKibzT4T0vd966hIHyddTpzbQYypBA4L2xJm2Iqqu2iWelAXIcjWJwYw37
	rfb+6A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6wy61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 10:47:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54MAl6Vq020565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 10:47:06 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 03:47:05 -0700
Message-ID: <0a36d45b-a2f4-4fd9-a1f9-39e91bee82c5@quicinc.com>
Date: Thu, 22 May 2025 16:17:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
 <20250522085601.2741458-4-quic_sarishar@quicinc.com>
 <9be5a453-730f-4ed9-b9fc-1e703f38f9f0@quicinc.com>
 <c8a6f706bc0aec46f7619ba3eb373f13d0c94969.camel@sipsolutions.net>
 <472f06ef-104c-44f9-be8f-5b077c958f43@quicinc.com>
 <5ead0c2ac031ecf225011ac4bceba755387fc918.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <5ead0c2ac031ecf225011ac4bceba755387fc918.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hDCJaFMcwaZi56qVH-RyDMCL3eeXHUdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEwOCBTYWx0ZWRfXxQSvSmS/AcfK
 ZuwvaMVADK65gBL3oV6cMPbU3RKD50fJFCUUqTMz3AII+GLyzt290nQTU+vjf71o/wcCp4iYexc
 pbcrbA0fcWm/Y/AwWg1C2/0mpuo+apsVoSZBkJQL1AFB7CFZPjNwxL2qpKpKTqcHOYPvJdC6/op
 2CmKTeUJgQGgM2IJpsk0zVtlcFu1cXbuaXvZ1yoKBbNnjCKOvpf6kmrX7FEli3lTaEuLjQDyvuN
 M/ag4hDbwp6t7jBKY0kNDVTTI4zqalmPBm+HbZ26zXJxwg4goFxoRcrtUWNy7Hgue7UfVNrk4fH
 gcyCXxXb07I4HNxz12MrmWMkqYFR+StWd1IaiamWsXm1pV5NGNTHbJbuhyUzuvPy1eqjI0mmsyN
 22GSsHRB/KQLFQs7HQteA7eFlOkwAGcvLkeusz1Cjqf3aVtyeAz9y4iV7qabz6ODj+fr59r6
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682f00ab cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=OH1kPfueQ7qu1kQgljkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hDCJaFMcwaZi56qVH-RyDMCL3eeXHUdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220108

On 5/22/2025 3:31 PM, Johannes Berg wrote:
> On Thu, 2025-05-22 at 15:27 +0530, Sarika Sharma wrote:
>>>
>>> Probably not, though maybe we do want the link addresses in the station
>>> delete message to userspace?
>>
>> Then may be reporting station data will work here?( already happening)
>> As overall station is getting removed, not just any of links.
>>
>> If really a use case then can allocate memory for link_sinfo as well
>> during the station delete?
> 
> I don't know if it's needed, we can always add it later if so?
> 
> And maybe we'll rework the allocation anyway so it's on-demand.

Sure.

> 
>>
>>> But the warning was just an inconsistency issue - why should users set
>>> the valid bits for a link but then not have any link data? That seems
>>> wrong?
>>
>> It's not exactly incorrect, since there's a scenario where memory isn't
>> allocated for link_station (such as during station deletion).
>> Perhaps we could add a comment to clarify this behavior?
>>
>> Then either way, if really link_sinfo required to be reported(for link
>> address), then need to allocate memory during station delete for links.
>>
>> or if need to add WARN_ON_ONCE(), can reset valid_links during station
>> delete?
> 
> I guess I disagree and still think it is incorrect, it means something
> (mac80211?) set up the valid links bitmap but wasn't able to fill in the
> data. Why would that make sense?

True it shouldn't, I agree.
May be then I can set up the valid links bitmap from mac80211, only if 
memory is getting allocated from cfg80211 for link_sinfo?

> 
> OK, maybe there's a conceptual difference here. I'm reading the
> "valid_links" as "for this specific statistics structure, these are the
> valid links".
> 
> If you read it as "for this station, these are the valid links" then it
> makes some sense to have the valid links filled, but no statistics.
> 
> But I'd argue that latter interpretation doesn't make much sense since
> to userspace they look exactly the same. If we had say the link address
> outside and then the link address would be there even in the absence of
> statistics, it'd make more sense, but that's not how it works?

Yes, currently the link address is part of the link_sinfo structure.
When you say "outside," are you referring to placing it directly in the 
sinfo structure?

> 
> johannes


