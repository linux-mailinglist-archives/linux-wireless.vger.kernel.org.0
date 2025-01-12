Return-Path: <linux-wireless+bounces-17381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC6A0A7AC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2531B16580A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9B881E;
	Sun, 12 Jan 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZtwPlpYZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490526AD0
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669719; cv=none; b=nUhplIVlioF/GP+TaEsqro7RVBeTPCD+VeYr/HftlKr46M1NVn6nUZ+0tffUo6InUCdzPKl+FcYsqtW6W2jH8SetrU8yI50rWqKccDKMabaxnsdTqjoBFPJBnq4K1LAyrAfFi/MmEiNuJ8Pk3gCwWlE2JRhNkEUHZJvQ/oIxCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669719; c=relaxed/simple;
	bh=Aa7WPa2N+td5m4YMcOg84qqtFETR+anYqyU92mPtW6M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Tfxd05zbvWRAqVDjrwiOkt7cpdaKv5vATQtJlxF8c8zYQRjd69WjqsZGiwQJPpaNzWCEFWNma2cuXWKWqA42Cg/S8Eods81gr3w44YefS1LKFmHXRUfmoj8AIyQBS4vi3IJ+8W0/5e8JfEAH3M/YsuFJ2aNsmf6ctCqXEN8OMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZtwPlpYZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C5OQ7U025042;
	Sun, 12 Jan 2025 08:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O2Q+S9al6na7dIvaq/GCn0XsBoNgwICNmno5uMiRCjY=; b=ZtwPlpYZT6hGB7kr
	6LPdwnQw/ClwKbgdRvZRPzqDx7xAkQZc3IMDysC47lHtmAcR8FR2d5KQxsVIGfgP
	pNWQGt83pUSGPfzKJ6DiNnMuo4CykA0LAvXxQJw2hoQx5grXjAGnYCZWzggGsBLC
	mC1EStTrBpSA2iAavev/ZKT8ex184DGGBmkFCg8HM3DCsuhmKrRNx+HTOgTR4/Gk
	P7XMZVEIbIwrJ17OjVfZhI89qq2C+My5utiuxF0C9BjXIsunne+7Yu4qLk6PzaBa
	w5/waVH3mUT+s75JP7p/8oJh65kc5EvEeLjGhktFduh0OSd5kmHLbE+nfm822DYy
	k87FaQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hjdhrwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:15:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C8F5u2001561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:15:05 GMT
Received: from [10.50.34.183] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 00:15:04 -0800
Message-ID: <77eb0ecd-f027-41bc-95e3-48c717fddad0@quicinc.com>
Date: Sun, 12 Jan 2025 13:45:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH RFC 5/7] wifi: mac80211: add support to accumulate removed
 link statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <20250110042449.1158789-6-quic_sarishar@quicinc.com>
 <18f299f82fd440f4067fcda1e1bc48e831ed7768.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <18f299f82fd440f4067fcda1e1bc48e831ed7768.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: STeE0w7XmIqy7NLVAqUqkIiY4rOVsnQX
X-Proofpoint-GUID: STeE0w7XmIqy7NLVAqUqkIiY4rOVsnQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxlogscore=510 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501120071

On 1/10/2025 2:52 PM, Johannes Berg wrote:
> On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>> Currently, if a link gets removed in between for a station then
>> directly accumulated data will fall down to sum of other active links.
>> This will bring inconsistency in station dump statistics.
>>
> 
> What if a link is removed and then re-added? Should it go back to that
> link? That would require keeping statistics per link rather than
> accumulating removed.
> 
> johannes

When a link is removed, its corresponding data will be set to NULL. If 
it reconnects, its statistics will start from zero. The link might not 
reconnect to the same link again. Therefore, retaining data for a 
removed link per link may not be useful, as the link is being removed 
and connected. It's better to start with zero rather than using previous 
data.

Also, if really link level storing of stats is required will add it, but 
currently I am not seeing it much useful here.

