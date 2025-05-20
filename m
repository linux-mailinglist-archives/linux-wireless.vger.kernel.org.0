Return-Path: <linux-wireless+bounces-23177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67519ABD384
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A011B660CD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ABB21CFFD;
	Tue, 20 May 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cl2kK8Sr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EE14F9FB
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733706; cv=none; b=m6nAEvC7tZQEmj5yjbEdNVna55tpu2FoQYPeOxexZBkiOg2KZ3PMFppC5F9uZ2w2H/kYCupN7i+0TDF0Qfypw6BDHVC3dbwJYo5y3iTtXOt6GhxpuagZ/kS1LpinMK3X25M6zDUXZpjZEoUK2A77cbicfgQFAFCMTY8txqb2etU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733706; c=relaxed/simple;
	bh=WBMpJuzToU7crMWXLhvSP6cYRkYKw2Jh8WBvGtMaph8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SuvO8GoghQzDRqiysTO9MGOzMF8xJ0eXU65Aq7ld/b2nLL26wBoKDZGnAdMFhy8UAQ3AO0cKXXrP2J6qzplWp9aWQ54Z7VMYtDMxCzLBlhs0/83dFqCiX5aj/B6TUNZPtLqDc1R/D2FEn2VE6OnRrPvCXu6KbGWvhk51gQZYyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cl2kK8Sr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K4Veuq023337;
	Tue, 20 May 2025 09:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6hnAUT/ctF6YJbPqDckm9fBdAdF/Y63Pap7uEutjALs=; b=Cl2kK8SrX3h/+I13
	6zTALdTMAATz4XJND707XY60AqHTnPK3VrumpCIYCOHGwyLxYTJRDEbRTzjD4Y1d
	+1Tt97RlCar/32K/a6s6fuDjpoJ2Nu3zyXOv0Al/vR1enGqLYmL8ymPxv2nd9XrF
	nmyCPuc1uaTEfVeus4KiNKZLhb6o8J30OCeToVt0ucx7ItKcAWIdzYmDPEPMXD4U
	rcl8EKFEnZLAMUW0trC7neOiibUlQ16sFkSMelobN+AreojMlwnaydaJe6NnwCTa
	Oq5ctJD0HHLlpphNbfwF9Q2LXsYdDVbYx1C36dTIQ7Vq0aGuv7P2s27c6Wssr6qo
	zJKWUg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r041uuwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:34:59 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54K9Yw3g003708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 09:34:58 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 May
 2025 02:34:57 -0700
Message-ID: <e94d2023-7d58-4b83-9a0b-47026a7a6549@quicinc.com>
Date: Tue, 20 May 2025 15:04:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 07/10] wifi: cfg80211: reset
 sinfo->filled for MLO station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-8-quic_sarishar@quicinc.com>
 <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
 <dd416225-2302-4f50-a980-a76c7e541fe4@quicinc.com>
 <f2a8671507db0aea673d61f78f1934212263d434.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <f2a8671507db0aea673d61f78f1934212263d434.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3OCBTYWx0ZWRfXzfYOy33sAjCT
 mQUSD0fZar76OpJfASthoVlNsAWH7z6JjUiF6TiCQ0VfJH4+fG6Aij+kJtQ7ssEpzoPU3R/qHhr
 x/8jnn9uXgr5Zy+/k2pdXRoCKdokreo71i1/pa5gbVhhmwMJ4NjDTkm9DtNsaPPxVRs59OrV8O4
 V8YGx6kLO2Qv8BsjtgzWaLVnp+Pl+VbRar8XpQNwlA82XPQoelX3H+1mRkpFFr25F/FllwkYrQO
 r9of+F05b0T+xX16pxgMxZ2UzouKrmuVRgZgjAl4EMucT1AhNRIJe8ICl1DIODT/waYQmtnrfJ/
 pXEpOYpKy4GI0fbyQHhClyNKGXy6BStmred23lmY2p6yazfxIvVgRvlsP8NcXMx4G4ViZKUFcVa
 87ooNeAmI11WNlM3SQfHoYXKXqiTz7YqD9bRmmlAIZcRz7MkeElG2aptataXDYeJqZ/oNh8K
X-Proofpoint-ORIG-GUID: _YGHMBPE9I_WCnyo5XWVcFtnm8onMgyX
X-Proofpoint-GUID: _YGHMBPE9I_WCnyo5XWVcFtnm8onMgyX
X-Authority-Analysis: v=2.4 cv=HIjDFptv c=1 sm=1 tr=0 ts=682c4cc3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=RiyiJO5gf1nf5XWLE8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=716 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200078

On 5/20/2025 2:12 PM, Johannes Berg wrote:
> On Sun, 2025-05-18 at 22:04 +0530, Sarika Sharma wrote:
>>
>> I reviewed the code again to check for pertid and realized that it is
>> applicable at the MLO level as well. The rx, tx fields are reported per
>> link (which can be accumulated for the MLO level), while the TXQ_STATS
>> related fields are applicable for station level meaning MLO level.
>>
>> Therefore, pertid is applicable at MLO level and also at link level for
>> rx/tx fields.
>>
> 
> Hm OK? Not sure I completely follow. Still seems mac80211 should only
> fill that up with accumulated-from-removed-links stats?
> 
> And now it gets pretty tricky since we have some stats that are
> accumulated from removed links, and some that aren't?

Then it seems I need to maintain all accumulated fields data to be 
filled from accumulated-from-removed-links stats first, that will 
automatically reset if some deflink values are there and fill with 
removed links stats.

> 
> johannes


