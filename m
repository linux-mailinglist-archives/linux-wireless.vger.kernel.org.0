Return-Path: <linux-wireless+bounces-5479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB396890704
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9099329CA1A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072393D55B;
	Thu, 28 Mar 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RTIQINPq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E475338D
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646371; cv=none; b=KO0lNN07NGDefolkUguPJcvMqyLTScdnnhztVdfLMgB+/ZQHLljmIF7ZBuqqOZsCyLJyYelxDmx8mWf0WrVW6xZQ4ZNxs3uPvQHdVEmsnm8xDBPnqITDeJ13X3WzGbCRnKV+TLlglYCLwNF1z/s7WQGpA9drIYWp/vGsOAo0v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646371; c=relaxed/simple;
	bh=TzwdDB14feassZ9JU/jgbnPtK1DJkwjr23TRXIaZEo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dWZw2mv0pdrF9IjFBI7JEspdX92W8i+v03WQxN4CQuMmechW43o6J9VgQPE74HQ0CBUjySFy+G9QSUYfB/a9BS190IiyTpuxgG/Ue6i/hyntiJWZMAbf1hqh8VOtWALMfuW8f5FUgCuOPday9aitcb5MzsUdHwJuH2Jn3CUpwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RTIQINPq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SGVLAi028527;
	Thu, 28 Mar 2024 17:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fZ7Iz+yfSs0sampUggH73kYieS4vekjfL+iln2taZrw=; b=RT
	IQINPqiBhseq5dTY1ok6Gw7AeOMMEyE2NPLP3nPzw4JO2bqOZgB/+2mF12ED98Tr
	VZ5ONNcJ1125MEFxk7bsqC+pfiCqu3dEmubbVM8TCuM4sV7Wn4gV5SdeIJHGjhbJ
	9ddzj3O++mWIEuvBYpXYdMrd87CbjtzrNfDPFsxif4WLILYtmyA7LKrTZMrK32Xa
	s99jO9+EYl8ZHqTgb03gfhsmW6D7HMXzOwqNaR+qhwc3QCa31NG9VENVouRxx/zM
	M8b5HAWyrYLmBQDG0aR7XM6AbwP3bvKMvJIRG7AwtPtXOfID/YX0FoyuQlyK3P2F
	xhTc+I8SchPzYJGoJEEQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5580sjrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 17:19:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SHJLmb002014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 17:19:21 GMT
Received: from [10.216.50.75] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 10:19:19 -0700
Message-ID: <4d569d40-d0a8-10d5-7e6d-4c9c03c14371@quicinc.com>
Date: Thu, 28 Mar 2024 22:49:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
 <20240319134522.4021062-2-quic_haric@quicinc.com>
 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
 <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
 <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
 <68c6fcbd-0aaa-43b2-b5e2-08367c11e79d@quicinc.com>
 <f5cb9edcea875920e0ce156be76d06c78d1279ec.camel@sipsolutions.net>
From: Hari Chandrakanthan <quic_haric@quicinc.com>
In-Reply-To: <f5cb9edcea875920e0ce156be76d06c78d1279ec.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fE9fTy_kJYLw3umQrVz9eDuBMvdDCR7p
X-Proofpoint-ORIG-GUID: fE9fTy_kJYLw3umQrVz9eDuBMvdDCR7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280119


On 3/27/2024 8:37 PM, Johannes Berg wrote:
> On Wed, 2024-03-27 at 08:02 -0700, Jeff Johnson wrote:
>>> I'm also imagining that we change the API from cfg80211 to the drivers
>>> to get the *link* STA information, and do the summing up and/or "best"
>>> selection there in cfg80211 itself. However, I am prepared to accept the
>>> possibility that we may do _both_ in the API, if not all drivers can
>>> even do all of the statistics per link. We should probably still have
>>> the link STAs in the statistics in nl80211, but then they may not be
>>> populated?
>> First remember that there are a lot of statistics, and each driver is free to
>> return as many or as few as they support, indicating the ones they are
>> returning using the "filled" bitmap.
> Yes, I'd think we want to use the same data structure for both, though
> setting something in *both* links and *mld* would (should) be an error.
The statistics can be populated by driver or mac80211.(say tx retries, 
tx packets etc)
So we should also change the existing stats update in mac80211 on link 
STA basis instead of deflink?
>> I would expect MLO-capable drivers to
>> provide the same information on a per-link basis that they previously provided
>> on a per-interface basis, but the "filled" bitmap leaves that to the drivers.
> Unless we don't actually ask the drivers at the MLD level if (the
> station is an MLD). But I suspect we will have to do both, ask for MLD-
> level stats and link-level stats.
>
>> But I think a fundamental question needs to be answered: To what extent do we
>> need to support legacy userspace applications that are not MLO-aware?
> I have no idea who even uses this and how :-) But I guess things like
> NetworkManager might, even just to show some signal strength values
> etc.?
>
>> My expectation is that MLO-aware applications only need the per-link
>> information, and from that they can derive their own "aggregate" of the
>> per-link information.
> Agree, though it'll be a long time until all applications are MLO-aware?
> Unless there aren't many using it, but ...
>
>> So to support that we'd need per-link nesting of the
>> associated attributes.
> Sure, that's a given.
>
>> And if we don't need to support legacy userspace we
>> could completely remove populating the top-level statistic attributes. Non-MLO
>> interfaces would have a single link nest that contains the same information
>> that is now in the top-level of the NL message.
>>
>> But if we need to support legacy userspace then we would indeed need to
>> continue to populate those top-level attributes with some form of aggregate data.
> I think we probably have to.
>
>> And even for the MLO-aware case there is the issue of how do we want to handle
>> the case that links may come and go, and hence aggregate counters would appear
>> to have huge fluctuations in values when links are added or removed if the
>> aggregate values are only calculated by adding the values from the
>> currently-attached links.
> Good point, when they're really removed we'd want to probably keep that
> value as a bias for the MLD-level stats?

ok. Then the statistics value in MLD STA would be bias + summed up value 
of currently alive links?

On the same line , ethtool stats(*interface level stats*) in 
mac80211(ieee80211_get_stats())
computes the stats by summing up the current STA statistics.
Here stations can come and go and the ethtool stats may not reflect the 
total packets transmitted or received by the interface.
It just reflects the summed up value of current alive stations.

Since these two problems are similar (ethtool stats and MLD stats 
calculation),
would like to understand what type of value would be more useful to user?

> johannes

