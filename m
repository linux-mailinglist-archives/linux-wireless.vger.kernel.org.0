Return-Path: <linux-wireless+bounces-21999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3FA9AF12
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66EE9A2A55
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E51494D9;
	Thu, 24 Apr 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XmOVP0UR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74354279
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501626; cv=none; b=jV1ysrBvK5k3tNJvOJn6R6U0qDKnIii/QRHEk+6b+ENB541OLZa1djqaMgBIf0aa+WjdHcXWGP3xJjC9/7upVzYaMTY2W8imN9qCrBksm0pPnXfuDeWYTg6fDfxO2bAnzjUw4LRKMpKPeAPO1cle7gnQ9V8qisrpk2cM266RvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501626; c=relaxed/simple;
	bh=eBw8apmvQ9lu8uu/YHT8mE2egHUGGnunO3AClS1ksYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HEoHbLfBMbRtxWb/RToT3vNJyGo7nGGDgXZbuZxU7/4AhBb98VBT4Z0G2sF94ZmV9I6vm78XnlResrYqBP/vmfUfHaZ9beeNhXCHLq3gVooxNGL0Ojqe+W7tQj9LMwJDfck1JULjmxIuPiNpqwjchhBu2q6Q3jC+QZxgNlzUBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XmOVP0UR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3Cig013019;
	Thu, 24 Apr 2025 13:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DOoQqW1XfoJpIHvDjiXBTphoQo42crECrkz1lOMw3wU=; b=XmOVP0URDqWWbUay
	4s77+hKAcJujbuk/C72qOaijOn51l7hD5aL2O0+xqZ73au5GiM76H7HQ/amIXe1k
	0vnaseRb53YiYklcgD2PJNbcHoJYn3noIMYLT5iL4qTzNskJTDD8szPlu7OFm4En
	rja6+R3UiGY5gyExG0xGpD3sT6DhibCGaKgoEgEfeNkn0C3Fh+vzem4KWcQxMMUB
	NKqziJnnGRHHeIHXXLeNRfYEaLuU0YVpuwrv6/lRUmFGRd557FcoBpMXInfUyoBn
	AlmNTZ06LKf9PLyVMLeRPtua/58OM1s6ZFT/9nqHpqaPddj/dWlilebhJiUH5Y63
	L7wKhQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh05rfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:33:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53ODXdbJ029791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:33:39 GMT
Received: from [10.50.43.121] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 06:33:37 -0700
Message-ID: <8594f374-52d8-49bd-8643-dd65e8c5589d@quicinc.com>
Date: Thu, 24 Apr 2025 19:03:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 5/5] wifi: mac80211: set tx power per
 radio in a wiphy
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
 <20250328122519.1946729-6-quic_rdevanat@quicinc.com>
 <3719131760bb5070378e397d716edde394256933.camel@sipsolutions.net>
 <097f0aa3-997a-453f-a2b4-c6126ed5e606@quicinc.com>
 <93c626d968e02f64b85280cd12f2ad6fa9b0ac74.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <93c626d968e02f64b85280cd12f2ad6fa9b0ac74.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MSBTYWx0ZWRfX2YRBTchW/ce5 woUusg9l8WZPLYFlDjWN99P6V5TAqLmNxlbQWP40pHP2luuc6E7oNiIl9F7vU2xN0M6bdoB5YxC h8ovYkS7uqUrKI9OGtN5pkmbGUd7adwkFBuzX3m/2JPO00taR2MS3GsSdVVMqVTQg3LC15+rdO7
 ymI4T7OmPQ9xwAzIsPRbZGDkO/xQKbZmw+08XWgZcyruJJFzTFTMWd8NRfMLUgU0qr0v4UvyVvW oGJL7itQETxN9BeBMbK58wIKtsUw4KjFBOOeGZPo+rbbVEHn/A4R+aR/V7wKJmEy2NHa/b5gV5J pyhoIUBUl6lahbEyLxCn2OIkDLEisNuKdN7Q712SskBrcql7Wz+YRqunofPH0dPSyrxDCOPCywz
 3Cfkg2LR4yEppAhfLQ/zfe4fm1PmUm3tVIElEKogEPqd7O8bH7hsKyjVNySfmQeaH2X0gGSn
X-Proofpoint-GUID: x3VVb39ZmKv23JaKL2ewkCfRknxerj5f
X-Authority-Analysis: v=2.4 cv=ZuTtK87G c=1 sm=1 tr=0 ts=680a3db4 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=H_-G0BPlKIabq9mcF5EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x3VVb39ZmKv23JaKL2ewkCfRknxerj5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=494 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240091



On 4/24/2025 6:59 PM, Johannes Berg wrote:
> On Thu, 2025-04-24 at 18:57 +0530, Roopni Devanathan wrote:
>>>
>>> Hmm. Is this really enough? What if the link gets disabled and re-
>>> enabled on a whole different chanctx on a different radio? Or other
>>> things like that?
>>>
>>> Seems like we may need to change how the TX power is stored in mac80211,
>>> rather than just paper over it like this?
>>>
>> This means that get_tx_power handling should also be changed. So I might have to work
>> on resigning this. 
>>
> 
> Maybe, I'm not really sure? Was just thinking about it.
> 
>> I'll handle this parallelly. Meanwhile, can I send out the first three
>> patches handling get/set RTS threshold in a separate patch series?
> 
> Sure.
> 
Will do, then. Thanks.

> johannes

