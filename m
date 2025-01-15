Return-Path: <linux-wireless+bounces-17538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F9A119D0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 07:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C43160E0E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FF22F395;
	Wed, 15 Jan 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gxfcQvOW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FC1E04BE
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923235; cv=none; b=WUZxwAo6rjNMJluXzQ0e6dX5AQ3GhAGjMEiJcpbCVG9Rds8ZuRiOcmCFQOrcaurGNw5hZjMmbYGT//83TbLQMKHiG2pc8gytmeka0GYg6VDGaYTqcDlxyLlJbsAjieByZQBeRQXfWPmbpeRFf1R3DgjjbsdPLsDZb5PAJberpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923235; c=relaxed/simple;
	bh=Q79ZEeUAeLF+Uyfe69DcvF2W/uDAZJBaSspOaLbCy+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBssd7j5A7EF2VljEQYOWsFfj4nmqZDJwXBAqX4E9BkXlPQorDKy82vt779zqi+5R1FSTFVBOfhUzWyYZq0Z3de3RpWcfZh0+vB3RKgO/y6PGdkqbz5Qex8WShFU9jps+5TiKZDgoFnKOEsg9TnYYD5V+Tti9GTfNj5Mod17Y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gxfcQvOW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F1tWn4027626;
	Wed, 15 Jan 2025 06:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5sYl1wC3JgvCHCJY/Gd5OBjKg6wONCo9a/K13IpvQpk=; b=gxfcQvOWMDLjij0p
	j9y9O1wF4wpUB4m2v0o6MCyipgwiccTnSXRXTkCgaT0f5i4iP7LaEWx+2bqYVYKF
	WTT3MxdQ1/VG1UyqyGZfHDLevb/mf1JQoxSGvO8zR+enYFFSeefvy+ur16OlnPeh
	XS7cs+MGsVVyUXTn2mIPnNwIeFyw6daUEp5eTj0zlpKMAMd2HeZLyqkv/oaWpCUc
	nfXNUyzIuUudzlYbH3/pGQq/DVf7WQYs3KylaT0IpanRG4tMJv0fwZvaSmQMv856
	J4Y6DDZzz+uVstZAmUIWpp/gkrK5LAzufR9fWeXENEQ2TQA4OTjhfblKf/UYT49S
	ig44aw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4463sm0jwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:40:21 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6eKD9028531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:40:20 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 22:40:19 -0800
Message-ID: <63dfda06-b83d-422a-af39-6af3c55dfbd9@quicinc.com>
Date: Wed, 15 Jan 2025 12:10:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/7] wifi: cfg80211: reorg sinfo structure elements
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <20250110042449.1158789-3-quic_sarishar@quicinc.com>
 <2f3a8f1c5e9dd41ef38e7dc7cf9411d00313a806.camel@sipsolutions.net>
 <3d18b02c-3f70-43a5-b825-0d191336a3e4@quicinc.com>
 <f8de2e7127b7a79e259bf14c62c4eb0ef25ddfb6.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <f8de2e7127b7a79e259bf14c62c4eb0ef25ddfb6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: crKJZ8gaUr9xTGn0Yh95hK_OftIJtwFn
X-Proofpoint-ORIG-GUID: crKJZ8gaUr9xTGn0Yh95hK_OftIJtwFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=788
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150047

On 1/14/2025 4:49 PM, Johannes Berg wrote:
> On Sun, 2025-01-12 at 13:40 +0530, Sarika Sharma wrote:
>> On 1/10/2025 2:49 PM, Johannes Berg wrote:
>>> On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>>>>
>>>>    struct station_info {
>>>>
>>>> +	struct link_station_info deflink;
>>>
>>> Having a deflink here seems kind of questionable?
>>
>> ohh! why so? In other structures like vif, sdata, sta, we did the same
>> way. So why can't we have the same way here as well?
> 
> Well, (a) I tend to think in hindsight it was sort of a mistake, but (b)
> we couldn't really do it differently due to all drivers. But here you're
> already touching all the code anyway, and it's mostly cfg80211/mac80211,
> so why bother?

Sure, I will remove deflink and instead could use link pointer (link[0]) 
to fill statistics for non-ML stations.

> 
>>> Why not pass multiple pointers?
>>
>> Sorry, I didn't get you.
>> Did you mean keep the sinfo structure and call this for filling all link
>> level, non-mL, ML information?
> 
> I think I meant that we could have per link pointers passed to the
> method, but we might as well just have them in the sinfo struct as you
> introduce in later patches.

Sure, will introduce the link pointer here and use link[0] for non-ML 
stations and corresponding link pointer for ML stations.

For drivers that offload link decisions and do not provide per-link 
statistics, a flag could be used to indicate whether the per-link 
statistics is filled from driver or not, if not can use link[0] to fill 
the station information and if yes then can use the corresponding link 
pointers to fill link level information.

> 
>>>> -	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
>>>> +	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
>>>>
>>>
>>> A little less renaming would probably also make this easier to review.
>>
>> Sure, but this is corresponding to filling link level data, that's why
>> just renaming sinfo to link_sinfo.
> 
> Yeah, but does it matter so much? :)

Not really, this is just done to differentiate the structures 
used(station_info or link_station_info) and code readability purpose.

> 
> I guess the flipside is that this way it's easier to review that all
> values fall into the right place, but I think the data structure
> organisation you did mostly ensures that anyway? Not sure though.

Yes from data structure organization it is taken care that it falls at 
right place.
If it found to be difficult to review and required, I can rename to sinfo?

> 
> johannes


