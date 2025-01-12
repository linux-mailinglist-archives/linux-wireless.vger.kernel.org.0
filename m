Return-Path: <linux-wireless+bounces-17382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD7A0A7B2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7048F3A59E6
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53826AD0;
	Sun, 12 Jan 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h5WkPHd6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A9881E
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669890; cv=none; b=JHbydPbd5562AOe55rCyL9yeiHoK6v+8kuOKyF1xYstTbkhds7FPRWQJnLCb0E4e51up06JOyhTeAV7gYKyzeC2Wd11+evL6ox392SICeV9SYW6qAIXE8f24Z40b60IxM9INELwW4DubA91Ug+qnoW/a4kerY0sB8LhcuP5L/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669890; c=relaxed/simple;
	bh=FuzroNJMg4oYnzRNtTnAtUleZrSjMKBkqMyNokACBcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LpX2BpBkBOYJdUmGiUu8iA5zwJ8d+pzSxNIKZCS5vasbUAezjQIcezFld7JTT5nHaKgRV5jG7Hn439VKHAW5E65vJeXgDk7NuTq4fqhNcikr3ikX/gKQsfVXFQnriQriujxPWcX9e7VwG1THrmMGnOOynnNbs9DULKnukvQO9KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h5WkPHd6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C8AZAc001023;
	Sun, 12 Jan 2025 08:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LVtSqVE5nTkSemnPiF2rw/oSXjCInHQ3aXD+sGactoI=; b=h5WkPHd6Pu1mR1n9
	ONwW8DkpY1T+RYbroTPy/BOeFt+CuherYvVt66x9rz72k+90TRXh66RRmF41cVbS
	sNwK1Y/YC4V3gqGVO365fBxCAooc6Ypqw46iUBrMQm+DhfqruKpj4GOCU9KkMKiU
	Tv7Up6gi1E/wSkOjtb6ANXCGnj/XTM51Bmj+IiDZAUBUYH6q1/IAekajH2y8b962
	TqDULx5BYHAlafbGL2ufXyLQGvH/EKKG/DDlYgL2/PD0zdUqtHAcVi9o4n6Jug8p
	kwE7vRRQ09+gJ7RxY70L8V9n30NB0Z5SGAkYgkViAbwPkL5dNUr1oUSypDCmhyNf
	J39LhQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44484x84h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:18:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C8I3BB017334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:18:03 GMT
Received: from [10.50.34.183] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 00:18:01 -0800
Message-ID: <e3c5d6e6-c5b6-41da-889c-46b2aa2323b9@quicinc.com>
Date: Sun, 12 Jan 2025 13:47:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/7] wifi: cfg80211/mac80211: add support to handle
 per link statistics of multi-link station
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <8eae424c1dbb45921dcfa6cc8bd07440d3e77632.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <8eae424c1dbb45921dcfa6cc8bd07440d3e77632.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dKdS8PVz-z6Mtlihhl3LMklJNkcwVVku
X-Proofpoint-GUID: dKdS8PVz-z6Mtlihhl3LMklJNkcwVVku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=723 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120072

On 1/10/2025 3:15 PM, Johannes Berg wrote:
> On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>>
>> Current flow:
> 
> FWIW, I really would have preferred to see this discussion separately in
> terms of cfg80211 and mac80211. Yes, the design phase obviously requires
> both to be addressed, but once you have that I tend to think it's easier
> to reason about them individually.

Sure, let me check what I can do here.

> 
>> Proposed flow: (Changes in last block)
> 
> Which kind of implies that cfg80211 didn't really change in terms of the
> high-level overview, but I'm not sure that's really true?
> 

 From cfg80211 still sta_set_sinfo() is called, sinfo structure is 
getting changed. Sure, will add about the structure change in proposed 
design.

>>   +----------------------------------------------------------+
>>   |                 sta_set_sinfo()                          |
>>   |   1. fill sinfo structure- info related to station       |
>>   |   2. if MLO                                              |
>>   |      a. call sta_set_link_sinfo() for each valid link    |
>>   |         i. Call mac80211 ops- .link_sta_statistics()     |
>>   |            to fill link_sinfo structure                  |
>>   |         ii. fill remaining link_sinfo structure          |
>>   |      b. call sta_set_mld_info()- to fill accumulated     |
>>   |         stats at MLO level                               |
>>   |   3. if non-ML                                           |
>>   |      a. call sta_set_link_sinfo() for deflink            |
>>   |         i. Call mac80211 ops - .link_sta_statistics()    |
>>   |            to fill deflink link_sinfo structure          |
>>   |         ii. fill remaining link_sinfo structure          |
> 
> And that's simply too much detail. The ASCII art is also a distraction
> rather than an aid if you ask me ;-)

Sure, will move to points about the design proposed.

>>
>> Alternate approach:
>>     - Keep sinfo structure as it is and use this for non-ML or
>>       accumulated statistics for ML station.
>>     - Add link sinfo for links with only certain link specific statistics.
>>     - Keep mac_op_sta_statistics at MLD level and let driver fill the
>>       MLO and link level data, if driver not filling let mac80211 fill
>>       the data.
>>     - Corresponding changes done to embed statistics into the NL message
>>       based on the sinfo/link_sinfo.
> 
> And this kind of data-structure based discussion is actually completely
> missing for the proposed solution?

Sure, let me add about the structural change as well in design flow.

> 
> What about drivers that might offload link decisions and not really tell
> you per-link statistics? I mean, I don't even know if such a thing
> exists, but with a data structure like that you could still have it?

That is taken care, if driver is not filling the link info, mac80211 
will check if it filled, if not it will be filled by mac80211.

> 
> Should mac80211 even accumulate? Why not cfg80211 accumulate over the
> links? And if mac80211 keeps the removed links per link then nothing
> else is even needed? Or it could pre-fill the MLD level info?

Sure, we can do the accumulation in cfg80211 instead of mac80211.

> 
> johannes


