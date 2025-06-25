Return-Path: <linux-wireless+bounces-24468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD4AE7E14
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FAD3B1A4D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B527F183;
	Wed, 25 Jun 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V64Lq3k8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975027FD46
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845114; cv=none; b=q2hDaJ8cyg/ec2dST98Ut9RXdCg8C7ORTnN1uG1zpJKXYtLgFKm/sBzWxTgkX10LSNv4/WrSseIvesgAfbYUUVvHsVtPtexlrPCaT0rplUTjJm7V2QbqZnzsRCWOLkd0MGa0Ex33DndjH/JrUaRzyDNRhhgYCsJKCyggWmATR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845114; c=relaxed/simple;
	bh=4EZhHLEmc1+NTDl5ltsHGyd1FPRZT/1XcV8a76/xWOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DxavpvXKsrGgq27/mJx8YdJPQoFAc3jgbRccIGrOpVR3pAB+zTer7Dte/dNIZNvAbJ/gbMZYUk4IF+6y2T6WBjQEd3Y/sXeS7JEiFifVcagRa6wCo2hzDck/lIxU2shqy02vq/Q/PgPgXwTBX29nQF68v328Qmo2QdBGgGDGy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V64Lq3k8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P46Ibb014676;
	Wed, 25 Jun 2025 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YdnsC9kLAq0q5ATU2gRZ/oEr/DWtX5t+k0lRuDsk5mM=; b=V64Lq3k8+V41aW/T
	OpAb7k1fesLeNLCd3xSwR56P99wnzzHTy0JfpJw2M5a7aRmFVTn6vTSS15CCuaq6
	WbpWEwt9JuK5BHJ+pK8KZ19Ndq/+Gt/CQKCcvHDIomAR9pB7T0uBJBYUwwrgBte0
	DbN/fRtq4vlQOUtGwRnVcOlUX1bf6ogLAc/pi3QoBFbEVKKMMOIxFN+/xwItYscZ
	w4I3qriVEjdOPjRLTVKCJyBfVycDLeOyUTAHB2NAuQSbb5etNMgMygaQLn5/YtZN
	Dt+oTvpM+1dv2BkJ7rw6pl9Rw41b90o5NGMWZWH+KXlSS9jIQrPpqoO4NMtiTFvv
	XPfGmw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpyndj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:51:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P9plDN013128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:51:47 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 02:51:46 -0700
Message-ID: <c22a9e7e-d0f7-477b-b732-c2454a0ac904@quicinc.com>
Date: Wed, 25 Jun 2025 15:21:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v10 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250528054420.3050133-1-quic_sarishar@quicinc.com>
 <ae46cc4ffc3ec8c776f70c4c61031d82ffdc4be0.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <ae46cc4ffc3ec8c776f70c4c61031d82ffdc4be0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685bc6b4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=uYVGJH5IAAAA:8 a=EfNIwosJjrvOJeLWEnwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZkEWZNUrOYKkpCLSUeX7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3MyBTYWx0ZWRfX6vzSUDVRQHQi
 RuLv8hIwhMFzPgumT4rlpegn7CcMKnDz4wRBS/Y97UrLk3P6sXpKpXyprV/pobvktHa2kQ5YLW8
 jPrAIDBXqJ6CIEAEOTOqPkxBNoHgJxau7h3+t1SArCbxyJ+7OzTn7PJbv1awB3xaza6nvkZp3+f
 msCLq//miNNvxKbAiNX72qBJPJbEJnrnEF8QQKtjEhTnspOZdpCpTrlL9yr8fvM4HA7tKgpyzBg
 nejMzR+6OfHcelIStOcFb4G9dnkdtS9J4uUaVwIIgZfVMDSlxZbcW0OoXYt55LjwDzkq4HtFe/u
 UqUKrDtS6IumrVo/nNQ6MpiJny9fL/O9D8+iZQaNkjLTvI3WwhXwzWKdDD18R+UvdoqrwVj0iNC
 lfwbVII9IZ2yYnFsivzgd5wxZWEycuHnF2tlQOZJ7yK0yPI4n0hUIAEjxLXIQFjKbSLm9yOC
X-Proofpoint-ORIG-GUID: ZR7OmOBbYJCnS0DlU7lS3EjCs1_ALeHy
X-Proofpoint-GUID: ZR7OmOBbYJCnS0DlU7lS3EjCs1_ALeHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250073

On 6/24/2025 5:10 PM, Johannes Berg wrote:
> On Wed, 2025-05-28 at 11:14 +0530, Sarika Sharma wrote:
>> Current implementation of NL80211_CMD_GET_STATION does not work
>> for multi-link operation(MLO) since in case of MLO only deflink
>> (or one of the links) is considered and not all links.
>>
>> Hence, add the link_sinfo structure to provide infrastructure
>> for link-level station statistics for multi-link operation(MLO).
>>
>> Additionally, accumulated stats for MLO are included in a concise
>> manner to provide a comprehensive overview of the ML stations.
>>
>> V10:
>>   - Add WARN_ON_ONCE(!link_sinfo), if valid links.
>>   - Fixed kernel doc error.
>>   - Corrected logic for setting sinfo->valid_links only if memory is
>>     allocated for link_sinfo.
>>
> 
> I'm going to apply this because we're at v10 and I'm losing track of all
> the changes etc., but while looking through it now, here are a couple of
> things I think you/we should still change:
> 
>   - We already require a call to allocate TID stats, I think it'd make
>     sense to also do that for link stats, instead of allocating _all_ of
>     them always. The cfg80211_link_sinfo_alloc_tid_stats() could go away
>     in favour of cfg80211_sinfo_allocate_link() that gets an argument
>     'bool tidstats' to allocate (or not) TID stats with it

Sure, will work on this.
Instead of allocating memory to all the links, can allocate in 
mac80211/driver( need basis).

> 
>   - I still don't like patch 7, I think that should be a WARN_ON_ONCE or
>     so and the producers shouldn't be creating that in the first place,
>     otherwise reading the mac80211 code is misleading since you don't
>     even get that data. Also the producers shouldn't even _have_ valid
>     data for these values.

Sure, can correct this in mac80211 to not fill these field (not 
applicable fields) for MLO and add WARN_ON_ONCE() for these fields in 
cfg80211.

> 
>   - What about TX statistics, we still have these patches:
>     https://lore.kernel.org/linux-wireless/20241218232519.3156080-1-greearb@candelatech.com/
>     which is still needed, right?

https://lore.kernel.org/linux-wireless/20241218232519.3156080-1-greearb@candelatech.com/
- This patch is needed, as it populates the sta structure at the link 
level instead of using the deflink.
However, I believe instead of introduction the new fields u64 
rep_packets and u64 rep_bytes — we might be able to reuse existing 
fields instead.

https://lore.kernel.org/linux-wireless/20241218232519.3156080-3-greearb@candelatech.com/
- This patch needs to be rebased or reworked, as the logic for updating 
fields at the link level for MLD has changed.
Updating the deflink in the context of MLD may no longer be necessary 
and could be avoided.

> 
> johannes


