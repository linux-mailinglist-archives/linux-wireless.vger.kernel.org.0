Return-Path: <linux-wireless+bounces-23023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE0AB8D2D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79307A245AE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317A255F24;
	Thu, 15 May 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="phvsfbMZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA421A42D
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328610; cv=none; b=tOrvOzdquY3D64IV1rQb5dgMvkwRxDLiQv7MonGuze8kZGxM3NbPl80cL1V36Fc4XK/iouo6Df1t5ye4LQUOMG9dDIDI7HSOiTZDUwHvjX6LW4tDYaASN8RmXpNR7dOlt4yCr8ZUQWS2KWOycyrfRLVBnqvZZJwPS+id15RTdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328610; c=relaxed/simple;
	bh=y9C9CUl74FYHSVGrPjwTYPTwds3DCIH7PVUJWt9qefQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gYzIWamdeW11Ud1YybAVgdaqE6S+RAmKdQN3aiShNJz19+yzCYWen1ZczZC0YJ7oBbbF9ruvH4MmeLiW0QWj78dT01Pp0NG5G2yMHA7irkCOjhIpzBzAaCjsASw9smDz2TeZDIXzMnI8FsfqJIOo9u0DqjgwttFP6+aVt5Y+/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=phvsfbMZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFS3e000334;
	Thu, 15 May 2025 17:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eppr+2gkVvTItRxSquQcesr6+TduX8roIXLh95iRzgk=; b=phvsfbMZdoMzMDl2
	vlyp5cGK8TC9paGpadrzGy67L0j6PRvxlGO/bH/b6j+iBZKNj/rD6d/PDC5HLZL2
	XBhLAGR3Swcmrew7PYCn1FimnbHQ8/Z0IGrInSiKCoqK1US4/xnfDa0Dr0aEd0td
	JYcS/89+PB9eYE3B2R1kvQNFh9ahEzgoTKUCK4p86zx6iR5mEm18QXzl1GXgq9UK
	2nPM0Io0dDcBVGnZ1dE+FzZvhpmX59MJ3cY4i++/uG//jEcYneAGGdWydLceSSWe
	HVgzyqS1t8jEywpYTqS/jQ02D0XV+RB4BLKXtXVjP3012iZBuiFrk3pFTJbB+OaO
	7D8CDA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnxxjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:03:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FH3N9W012980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:03:23 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:03:22 -0700
Message-ID: <50ab5ba1-3812-44e4-bea0-6497358be9ff@quicinc.com>
Date: Thu, 15 May 2025 22:33:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 05/10] wifi: cfg80211: allocate memory
 for link_station info structure
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-6-quic_sarishar@quicinc.com>
 <51755b44ccf1f2e282bda7bacae41aa6677b146c.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <51755b44ccf1f2e282bda7bacae41aa6677b146c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mm6JgnqLjWrcis_Maxl0nFeVeUwpymJV
X-Proofpoint-ORIG-GUID: mm6JgnqLjWrcis_Maxl0nFeVeUwpymJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3MCBTYWx0ZWRfX5CuRWxhuS/wV
 WGvqVO1uGgKj9r5fyTgLNUM9r3RIjYgD42SzaEhqhsmmW62a47LOdiuJiSDhaRUxm4PwOFi2g/k
 3HoC6oKTfD3+191GiDHGtwGFrjyzxclgySBzlhx8yHLlHsjAKLXCydZL0i/3k5m5ITkn5liWhO2
 oxyuZ3+n5WUCaOIiHOF1yi8z1g/Pv4dsXP3mLCmaharwDL/slqSDJm+isSoPqs3SbUo2W/rlGzJ
 uxZo28V8maDZoOSf2sFiuZLaSFpDGY8m8DYn88nLDaTVTLWUTqy0B08M8bXrpYVHhnh5C6isLGY
 7fuPoMjoWA0mcvHy8CLWtN6b/Dnw77C9704j1uY9daBihqRthKC6yevgV5J8lsiQf+WZZS//kK3
 8A1Qb3f0iOCXQZcvJgf/FqYPLQn/zE66/69II6iazeSheU9rxWVGjPf6pKArQlYnTBGmBzHu
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=68261e5c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=IMyhMbOAxWuauNsxuE8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=593 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150170

On 5/15/2025 4:58 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>>
>> +++ b/include/net/cfg80211.h
>> @@ -8579,7 +8579,16 @@ int cfg80211_sinfo_alloc_tid_stats(struct station_info *sinfo, gfp_t gfp);
>>    */
>>   static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
>>   {
>> +	int link_id;
>> +
>>   	kfree(sinfo->pertid);
>> +
>> +	for_each_valid_link(sinfo, link_id) {
>> +		if (sinfo->links[link_id]) {
> 
> Took me some time, but obviously this leaks memory all the time. The
> hwsim tests blew up for me _immediately_ on this, FWIW, so maybe
> consider changing your config to have more kernel debug stuff when you
> run those. You do, right? :)
> 

Sure, let me change the configs to avoid this in future.

> 
> Ultimately, also I know I said to do it this way, but now that I really
> look and see how the tidstats are allocated on demand, we could do the
> same here?
> 
> And then you don't even (later) need
> cfg80211_link_sinfo_alloc_tid_stats(), allocating tid stats for the link
> or not could be an argument to allocating the link?
> 
> Anyway maybe we don't need to change that right now, but I think longer
> term that'd be the better internal API.

Sure, we can take this at later part.

> 
> johannes
> 


