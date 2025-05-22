Return-Path: <linux-wireless+bounces-23297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE32AC092E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE132188AFBE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CCE1C5499;
	Thu, 22 May 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gJmO8ItJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA51EDA3A
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907879; cv=none; b=YViViWHDq3xR0HvZHBrFYUxtEdQU3jPQ/BXBnaYzkfzDTSUoY9BiQr1xFs+hW4wqOHCJesReImiTKMZxKqQKRoXw4OEBGJon8pP+60kE/Mw//V9XH7AqUUEedgu1bDO4aDKExZQIDitBEJZYUx4H2Yw6M7JlHm6dgBEF/Hjucnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907879; c=relaxed/simple;
	bh=suX1GwYmyAC2jvou3q13k4SWlHVbyxinDv4uRpp5ZFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j0S0x44zVCDtgzSQHfFj+Xq01n4aCLLNpv8rYC+ZGNY3XvX8JeYC1RlXmnD0k5X3rBwyDCpq+j8qGkqkyUVqujpqDBas/tK8EVeA4XDNwJW3pQCCP+xdVPID012jf+ZXK9haJFU3Pm1w8KmPpd1oJl7VErA6g78MC9L86lNF8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gJmO8ItJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7w5OB000836;
	Thu, 22 May 2025 09:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AN47n9qJXIjHLfk7JOBOQugdafcTkaFau76voiCnp+U=; b=gJmO8ItJQR4b+Jpr
	PaaXiYvQx5LaqpAnXiALkyJesaU8ZMHjhTOrAlW587Tyk1bGQaBTVYgPF1XyXM3I
	rN6lsTtqH1yQseyj10Zo/wo4qiDYYLDrZK/cF8yaGsRubtQtWaROjFo7NoeERHzl
	ZNN2K/IAMchoCWVzOm5NOfrVOocvOGkzLPjaDrDBqPDJ2lozCSMQ1AiHy0WZP9+Q
	5hdjQSNY1fhzaeJobPjUj+3AtsGvuSZSLD8YXZTQjQp6XM1qggL3LtOUETUsFrQM
	vmKMYV75mdMdqe4B0qAaHcYOL27eM+HMoZqfLT+Jtqzp9F28EauoqMrSWkx1h0Xc
	HvoO4g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6wtuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:57:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M9vkqx026253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:57:46 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 02:57:45 -0700
Message-ID: <472f06ef-104c-44f9-be8f-5b077c958f43@quicinc.com>
Date: Thu, 22 May 2025 15:27:42 +0530
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
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <c8a6f706bc0aec46f7619ba3eb373f13d0c94969.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 28VP_eT0o3DPgcebcJbU6xD8wD4WUMMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5OSBTYWx0ZWRfX00V7tw0YhVs8
 pug/GGYTi6Ako1b3mwf8Gw4tADOYvPS98OQWWLPNH50kAjFsGdai/jXiFCBoJbEtdr92qBFBKGp
 NbbJxKIuVniZEmxkiJj+ALOpgDQiEE0+VyNJrIKjFuVVnPHb3OYTRiQEUF6XLP5pdbMgXl3HCXC
 e63ttG6hhjKcACCdlhDqK9L5DRKx3uIWGHdhAXwMrgA8TAYnH7BptZf8T/YNw/vcVGLaoQnrJDi
 75CJI5sMoqCmHVoa9HklYdAARvekQWW1hDtZ1ekWm0z2F3vqmGBVEjE7xBq4qt5bOrO7t4j3Bqq
 H3OugVjUy+iSVEU3DHkaqTzXOibYJt0/+DHmIlg1xl3HpQZWIKTEJpmT+9vZUCpm5aehaUSPrUg
 dSNI0I9yRGhgmWxBoFXEZ2ALg9KfTSjzrcS37Fqje/pvD0RIxM3kbn5O5aqTCJEJg0cRtxAf
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682ef51b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=VjOyoXfQC14vM6LE9PsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 28VP_eT0o3DPgcebcJbU6xD8wD4WUMMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220099

On 5/22/2025 3:05 PM, Johannes Berg wrote:
> On Thu, 2025-05-22 at 14:33 +0530, Sarika Sharma wrote:
>>
>>> +	if (sinfo->valid_links) {
>>> +		links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
>>> +		if (!links)
>>> +			goto nla_put_failure;
>>> +
>>> +		for_each_valid_link(sinfo, link_id) {
>>> +			link_sinfo = sinfo->links[link_id];
>>> +
>>> +			if (!link_sinfo)
>>> +				continue;
>>
>> I have removed the WARN_ON_ONCE() check for !link_sinfo because
>> link_sinfo can be NULL during sta_destroy.
>> It appears that nl80211_dump_station is being invoked during sta
>> destroy, though it's not very clear why this happens in that context.
>> Introduced in patch " mac80211: avoid excessive stack usage in sta_info".
>>
>> Since link_sinfo memory isn't allocated during sta_destroy, there's a
>> valid chance it remains uninitialized,
>> which triggers the WARN_ON_ONCE() and causes hw_sim test cases to fail.
>>
>> Let me know if I am missing the requirement to allocate link_sinfo
>> memory during sta destroy.
> 
> Probably not, though maybe we do want the link addresses in the station
> delete message to userspace?

Then may be reporting station data will work here?( already happening)
As overall station is getting removed, not just any of links.

If really a use case then can allocate memory for link_sinfo as well 
during the station delete?

> 
> But the warning was just an inconsistency issue - why should users set
> the valid bits for a link but then not have any link data? That seems
> wrong?

It's not exactly incorrect, since there's a scenario where memory isn't 
allocated for link_station (such as during station deletion).
Perhaps we could add a comment to clarify this behavior?

Then either way, if really link_sinfo required to be reported(for link 
address), then need to allocate memory during station delete for links.

or if need to add WARN_ON_ONCE(), can reset valid_links during station 
delete?

> 
> johannes


