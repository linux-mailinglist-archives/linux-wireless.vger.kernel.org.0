Return-Path: <linux-wireless+bounces-20372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4BA60B1B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2363AAFDF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF91A23A4;
	Fri, 14 Mar 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RjmXgv77"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08A1A239B;
	Fri, 14 Mar 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940397; cv=none; b=terrq1fGEK5saYznYz60C0yn0GvYnCB/XNGQ+nAArUgJyCc3imyctXTc4MBxlCaFD5HNwR8nbaBYRoaaOEEa1AUFQBxFV1iqWpr1/GLdVYsLdTs33Kkf1gykEC1uqjw7uu/HtUmNvUUcxdDPEZlGTR0jg3YceKhhJjsKVAZ5mFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940397; c=relaxed/simple;
	bh=wHGBWtsMPmuso1Q5fzssqMxIVRQllayaogHToEaf7qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kNAMWvMiupLympzOSmOf+Q3/X6nuvR+sWThnsdi9KujfxdV9FNQYqqGrc/8vbM8+hDCSO0/wwtYvymRXUO/sYaz8egD33vQnww6Zi2VDMWy63S786SUmA710XB+ovP+zm9zv7eRYs0dzgCJwOP/Myc6GVQgjP7wDWIxqr/NaSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RjmXgv77; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNugE7031769;
	Fri, 14 Mar 2025 08:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dWMYNBNQo3yjPtpzhw+4+UtwxWTkNI2J/wxly3kI7cw=; b=RjmXgv775sM1hOMd
	6HMJRyboNt7SN/4B9mfZFltdEBrXkTZe7BMCWdXAcU7NERlapv/FEcgWD/+mZ4nw
	pby5qOtwBKugEg/9cvCL3x5kjPQB1oCAlh0ZFqJ2sQwOsn4YbhzN9J+Yjz/ojy0s
	SQYFO/mcDIeqwtey381a5UlQN/AIbCoGfeJqqd/9Io/U0utYwBetYiZdZfD2Qpqg
	nJSUTnzoOiadjkTI9AW8YPe7qUQg9isVsv2Bfnxk/Gci67O7vxz2I27PPZxDMg8l
	kif9Fu65XtcobnArhhZRMtMLnXtzf1GpKCYDvs4HYb6xuPjEbuGXHZiAFGWULz0D
	bTDgOA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bx1jjyhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 08:19:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52E8JoXx009396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 08:19:50 GMT
Received: from [10.253.39.117] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Mar
 2025 01:19:48 -0700
Message-ID: <9e1fd1ae-e770-44a7-81b8-696b76c71850@quicinc.com>
Date: Fri, 14 Mar 2025 16:19:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Johan Hovold <johan@kernel.org>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
 <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CNQqXQrD c=1 sm=1 tr=0 ts=67d3e6a7 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=IgN2TWT-nG-ZWJAHbY8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o8zj47opkgqqgW2nFBn1kG00Ec9lddI2
X-Proofpoint-GUID: o8zj47opkgqqgW2nFBn1kG00Ec9lddI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=746 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140065



On 3/14/2025 4:06 PM, Johan Hovold wrote:
> On Fri, Mar 14, 2025 at 09:01:36AM +0800, Miaoqing Pan wrote:
>> On 3/14/2025 12:14 AM, Johan Hovold wrote:
>>> On Thu, Mar 13, 2025 at 09:31:56PM +0800, Miaoqing Pan wrote:
>>>> On 3/13/2025 12:43 AM, Johan Hovold wrote:
> 
>>>>> +	/* Make sure descriptor is read after the head pointer. */
>>>>> +	dma_rmb();
>>>>> +
>>>>>     	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
>>>>>     	if (*nbytes == 0) {
>>>>> +		WARN_ON_ONCE(1);	// FIXME: remove
>>>>>     		ret = -EIO;
>>>>>     		goto err;
>>>>>     	}
>>>>
>>>> This issue can still be reproduced.
>>>>
>>>> [ 3283.687469] WARNING: CPU: 0 PID: 0 at
>>>> /drivers/net/wireless/ath/ath11k/ce.c:405
>>>> ath11k_ce_per_engine_service+0x228/0x3e4 [ath11k]
>>>
>>> Thanks for verifying.
>>>
>>> Which platform are you testing on and which kernel are you using?
>>>
>>> I'm still waiting to hear back from some people testing my patch on the
>>> X13s (sc8280xp).
> 
>> qcs615-ride, kernel 6.6.65.
> 
> Ok, so a downstream vendor kernel?
> 

Yes.

> qcs615-ride does not even have PCIe enabled in mainline yet, but I
> assume that's what you use here?
>   

Yes, also reproduced on qcs8300-ride.

>> I think the hardware has already ensured synchronization between
>> descriptor and head pointer, which isn't difficult to achieve. The issue
>> is likely caused by something else and requires further debugging.
> 
> Yeah, but you still need memory barriers on the kernel side.
> 
> It could be that we are looking at two different causes for those
> zero-length descriptors.
> 
> The error handling for that obviously needs to be fixed either way, but
> I haven't heard anyone hitting the corruption with the memory barriers
> in place on the X13s yet (even if we'd need some more time to test
> this).
> 
> Johan

Agreed with you, let's waiting for the feedback.

