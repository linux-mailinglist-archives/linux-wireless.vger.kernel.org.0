Return-Path: <linux-wireless+bounces-6646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08CF8AC785
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570D3B2194A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD8482C1;
	Mon, 22 Apr 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FiZIvgz9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78054BF6
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775695; cv=none; b=VPL3BGml7exq3Wbd7lEuuBTtY1q4lGAk7VkjEa6Qj1aae9G6dAUzd57v20E4DSCb5zDiSIPUT5J5iUgJ0Z24E5w+9EytSYuNiqjeJqB+jxGoJBTMI7uMzu48bMZyZ7S+a+skTVTaKkLEm8aqz2/uz+e8/0QZ6ZUbWEwIvwSFEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775695; c=relaxed/simple;
	bh=VCYhUgUnCyAR2aYYXg9xKrgDBbveRw2wpD/zI0mQPaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oI8mR1eAUjf5T92/XdlGw6tSRAIR9GWNUPX1zGYNYNsgEavcu+mtrhJ39yrE0PVNQHQBFFKjEdY4BoKAnGwmFk9J/3284qYIfPaHMsOGvj7ClGPc54S4prge2X5FRvxcEyrQ4GZ8MAn0JXMlSE79VjTQWn17f7dsR8HrAfzKt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FiZIvgz9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M5pr9w002869;
	Mon, 22 Apr 2024 08:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pzxl6oxLyapzyUybXBGxjz0KtwE6eWc6uTgTbRzy4iY=; b=Fi
	ZIvgz9wyowczsSwfRq79DvaMxTRxT9EXb9Bq0ba4sHUIUYz1HjPPM6V+o+Y+//7n
	xYDDntyIrDyxy90RQRI32ao+2lV45r688nPu3fK/y7mjcDqszcJKMy4R8ygLCGnI
	TjneOKI1ufP0gKmI6UxcHQNF2EX7I4XK9pfqpJCdT1SRDqD+G+d4MVTr6QZSdOyE
	+87M0RPo4Fh/RHuBBI17KLpVdUJj5iaulWCWmBLFnHXcyKfc3S+wCJgi4ictRxIb
	28PRYy6KQgN6UJSaiZbNOp9ZsB4kDjva7vVrxfg2vrvT1HZDrlABKlAUwcf8j0KB
	s+9jNn9SW69sRWQvxRDg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm63a3pm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 08:48:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M8m7ua026451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 08:48:07 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 01:48:06 -0700
Message-ID: <99cbc879-3cbd-4c35-b5dd-991f8871607e@quicinc.com>
Date: Mon, 22 Apr 2024 14:18:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] wifi: mac80211_hwsim: add support for BSS color
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
 <20240416045943.576656-8-quic_adisi@quicinc.com>
 <01fc6041e04b05ac6909a9818c9a890628542373.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <01fc6041e04b05ac6909a9818c9a890628542373.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gJEytez0bSMU1O3pky8cOj6p-FJf3CEP
X-Proofpoint-ORIG-GUID: gJEytez0bSMU1O3pky8cOj6p-FJf3CEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_05,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220038

On 4/22/24 13:45, Johannes Berg wrote:
> On Tue, 2024-04-16 at 10:29 +0530, Aditya Kumar Singh wrote:
>> Advertise support for BSS color and then once the countdown reaches 0,
>> call color change finish.
>>
>> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
>> ---
>>   drivers/net/wireless/virtual/mac80211_hwsim.c | 6 ++++++
>>
> 
> Not quite related to this patch, but I wonder ... what are you testing
> with this? How?
>

I'm testing only color change done via user space for now. Currently 
hostapd does not have support for that but I have changes for it too. So 
after adding cli support, I have added hw_sim test cases to test and 
validate it (non-MLO or HE scenario as well as MLO). And like CSA, 
currently for MLO, color change test only on first link. Non-first link 
will be added later.

> Seems like we should actually filter on BSS color in hwsim on RX
> somehow? We don't have PPDUs per se, so we'd have to tag it somewhere
> else, but that's doable?
> 

Yeah seems like but need to deep dive. Have not thought about this yet.

> Otherwise are we even testing all of this fully?

Not fully. As an initial step, currently supporting changes via cli. 
Then we can add the required RX details via some means so that when it 
reports packets to mac80211, color collision detection can automatically 
happen.


