Return-Path: <linux-wireless+bounces-22734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C65AAF647
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F699E0AAD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF2423D284;
	Thu,  8 May 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AYWcwW9v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B723BCF2
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695097; cv=none; b=kP8g8MeJqMTaIA3KELSBx7gruRerPFy/eLT8sJhW3+KKWLb20nkhKOH8MJ2ij13J5d4w0gxe6Icd0If0pIzBwu6xukbxhg8KBQtbjkXsCq/LeCPFSs6CrVoMKxpp2eknVfatl6PKvjdaybWWGivBrC4jYpDCsSv0zkq91x2WdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695097; c=relaxed/simple;
	bh=wgfYY4Q2sT4vRTLma0ZQKaqrwDVPvstjSFrLBmHnOOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFjQQduoqCD45uuXWDu8vQ/whX63ROKXH4PQIMPEyzSime4SmnkG6wttdnOmsNyRdbnFBX+/dNO3/NM7cnpdUpl7AjyiDKDidzWsyAmW2Sd6Hn0gtgRb72lwwXGxgi3mfE+eFb73pXEnKl2ALc8HAsWJa8H07k8C7wBOQ+gMFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AYWcwW9v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484XB5m016373;
	Thu, 8 May 2025 09:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+JtTXXMWzCHAp10ug2WBqQ9GVOTgyonlMaoybL6ERGE=; b=AYWcwW9vl/Gq2X/3
	IYzew6Sh9WY9Yevhm/IHypSxyIR0DQ9XxS/nh6stI2TBRj7OfBQFatN8gDG/Vm2C
	wQi/ecQJ+f9z+e6BNDuWG+19iZvrW7t8Y7pVZ0gMoVsxtz6ZO5mtGZT3VwYWGgFf
	GJYJEtLl9yuSkdvvRENZVML4TXXq6yeb4p7MxwdEd4noUlTm2HuYiMbiAhIol4Lz
	DOB2XWEKTPnbi8aeGCIqGUZtklOuwtDlju4rMehKoMke08s6mvh8agoSFn5dJpuy
	aGEcWqD5sAyA7NI56vsrYyDI7vzrXzrPrMDlQ93P+5pt095kdckZi2iN/BJP8cUd
	kxyJcw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp8rptm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 09:04:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54894omb029373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 09:04:50 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 02:04:49 -0700
Message-ID: <14df6327-1a31-4ddc-a2b5-1055cbd5b686@quicinc.com>
Date: Thu, 8 May 2025 14:34:46 +0530
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
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <a12320b826ef7395bde044d9dcc7ad9f902c6ef9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H5n5g-EEFPz4q2KqgaZn6zPaRrWAWgpR
X-Proofpoint-ORIG-GUID: H5n5g-EEFPz4q2KqgaZn6zPaRrWAWgpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA4MSBTYWx0ZWRfX9dKdJPLZYjo6
 idAbs84vFrho/zOmfqSsMHykKoL+t47eyuNhaEg4vro9/jZzoeoW6ieP3bnGYVe3i2tCsNqgb5s
 5n3yDOvFhH+dAjgATuyx+bsCNB+tNQR22lrlpmV0iL24L+V1Rhkly0W8RO7fOqpce8rucjiPg3L
 9e714FymUC3FDH8Y74z2MUIz3vcN0FfVNwh6bechfip8vzRsHzB51MdgNYXgkXisPVLdJ4kR3jV
 q9oMiT15gk7KKWV95d5y9aBGL9oyygh9dtcCughfDKsOyL4TSZ2w2Yu59h998nFsR8Ahe3Y7bdu
 rrKPVA84OaR3EBi5a4Rwtn3Hzw38lGY4ouWT/fXiXLi/Fc0dP945lYyY8aiJiaNvaigqR80T8vi
 16m+grOsFATD9suaDor/XTVwBu0tMT44uYvO7Y0JpgTpk+xkt3LaCYEQQGi/rPKMOQhkjH/c
X-Authority-Analysis: v=2.4 cv=e/4GSbp/ c=1 sm=1 tr=0 ts=681c73b3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=3wW6UygicesnfgbMZDIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080081

On 5/7/2025 6:57 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>> Sarika Sharma (11):
>>    wifi: mac80211: add support towards MLO handling of station statistics
>>    wifi: mac80211: refactoring sta_set_sinfo() to add support towards MLO statistics
>>    wifi: cfg80211: refactoring nl80211_set_station() for link attributes towards MLO
> 
> These three seem fine, modulo the nits. But of course that's just
> initial refactoring anyway.

Sure, but may be with this approach, these patches needed to be 
refactored again or some of them not required.
Let me check and update accordingly.

> 
>>    wifi: cfg80211: reorg sinfo structure elements for MLO
> 
> Here I'm really not very happy with the massive changes in all drivers
> that now have to use link[0]. Especially since you later add back the
> station_info statistics again for accumulated statistics anyway ...
> 
> But to be honest I completely forgot all the history here. Looks like
> your initial patches couldn't even build, so I can't compare well with
> what it would've looked like before.

Oops! if require can send new version V7, in building state(as already 
prepared the patch as per last comments)?

> 
> 
> I think it might make sense to treat "accumulated" and "non-MLO"
> statistics the same.
> 
> In the accumulated statistics you add
> 
> +	u32 rx_packets;
> +	u32 tx_packets;
> +	u64 rx_bytes;
> +	u64 tx_bytes;
> +	u32 tx_retries;
> +	u32 tx_failed;
> +	u32 rx_dropped_misc;
> +	u32 beacon_loss_count;
> +	u32 expected_throughput;
> 
> and realistically we could also have _most_ of the others (not all
> really make sense though, admittedly), I think it'd be easier to just
> *add* per-link statistics instead of refactoring things completely in
> all the drivers, at least for an initial version. We can see more
> cleanups later.

Sure, if this looks more fine.
Will work on this.

> 
> We can also prohibit filling entries that make no sense for multi-link
> statistics when provided on a global level, though honestly I feel like
> for most of them we should actually provide some value, even if tx/rx
> rate is just the best rate of all the links, or something like that?

Yes, but then document for station_info structure needed to be updated here.
As for some of fields it will be similar for both non-Ml and MLO case.
But some of fields like signal,rates, etc, meaning will be different for 
non-ML and MLO stats.

> 
> However especially initially as the code isn't complete, we can also say
> that things like pertid stats aren't allowed on the STA level, only on
> the per-link level, if per-link statistics are provided at all; that
> would save some code in the accumulation in cfg80211.
> 
> 
> So I think overall it'd be nicer to
> 
>   1) Add a separate struct link_station_info to what we have now
>      (instead of refactoring everything from station_info into that
>      new struct).

Sure.

>      Maybe also need to see if everything really makes sense - you showed
>      the connected time as global in the commit message, but have it per
>      link in the structure?

Yes, it is there at ML level as well at link level.

>      This would also not yet require any drivers or mac80211 to change at
>      all, since it's just adding a new capability.

Oh! Do you mean not add all the things now at link level? and add 
afterwards as per requirement/ while adding new capabilities?

or add as of now and let driver/mac80211 filling those capabilities 
handle it later part on.

> 
>      Oh, in terms of allocation - the struct isn't huge now, do we even
>      care about simply adding 15 links? It still stays well below a
>      page as far as I can tell ... keep it simpler for now?

Okay! but although many fields are more applicable at link level. So 
isn't keeping the pointer is better then keeping array[15](seeing error 
with array [15], mentioned below)?

> 
>      That also saves the back and forth you have with patch 08 where you
>      basically just add stuff back that was there before. But now you've
>      already converted all the drivers, needlessly in a way.
> 
>   2) Add the needed nl80211 to show the per-link values, and that then
>      immediately requires the accumulation logic. For values that we
>      don't have accumulation logic for (yet) we can suppress the ->filled
>      value, possibly with a warning/message?

Sure, let me check here.

> 
>   3) I don't think we need this wiphy flag really, as long as we have all
>      the links allocated we can see if anything was filled. If nothing
>      was filled at all we can know the link wasn't there?

Sure, got it.

> 
>      But also that's to say that it doesn't really _matter_ if a driver
>      has multi-link or not, even if it has multi-link and can only
>      provide accumulated statistics then - apart from it having to figure
>      out how to provide the rates if it wants to - that should be fine?
> 
> Up to this point the this outline should give us maybe a slightly less
> efficient internal representation, but an internal representation that
> doesn't require changing hundreds of lines of code across every driver.
> In fact, it should require _zero_ changes in any driver up to this point
> because it's perfectly valid for an MLO connection to provide *only*
> accumulated statistics (of course not what we want, eventually.)
> 

Sure.

> 
> Next would be actually making use of this, of course, which is more
> work:
> 
>   4) If we now have station_info with links[] in it, statically
>      allocated, mac80211 can be refactored to fill that, basically what
>      you have in patch 9 except without the allocations.

Okay, but declaring station_info with links[] of 15 statically will be good?
As many of fields what I currently included in link_station_info make 
more sense at link level, so that fields needed to be at link level.
So, overall structure will go out of stack for cases where station_info 
is declare at stack.

error seen we use an array [15]:
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c: In function 
‘rtw_cfg80211_indicate_sta_assoc’:
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:1930:1: error: the 
frame size of 3112 bytes is larger than 2048 bytes 
[-Werror=frame-larger-than=]
  1930 | }

> 
>   5) Patches 10 and 11 basically stay as is.

Sure.

> 
> 
> I don't really see _much_ disadvantage with this. Yes, we allocate more
> memory, but these are ephemeral allocations, we don't even hang on to
> them very long. An array that is literally of structs rather than
> pointers to them is easier to deal with. Having pointers would also
> work, or having fewer entries and not indexing by link ID, or having the
> per-link as a variable array at the end and then it's still an array
> just allocating how much it needs ... But I'm not sure that's all even
> worth it for an allocation that'd now be ~2.7k and very short-lived? And
> allocating more smaller structs probably isn't really all that much
> better than one bigger one either?
> 
> Anyway if we find an issue with this we can still rework the internals
> later, but I'd rather not have so many driver changes unless we know we
> need them.
> 
> johannes


