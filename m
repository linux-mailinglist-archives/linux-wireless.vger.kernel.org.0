Return-Path: <linux-wireless+bounces-2825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883A84275F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073731F25DE7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862E7CF29;
	Tue, 30 Jan 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aSAdYoB9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAB7CF08
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626752; cv=none; b=WcJDqmclsm1gClWqRjIsRHPMQaXh8xgkOLwMRtIbXXpzJDlvgMFGkBVxm0qTv5tyvN6yenK2lJcyVtXBqP7UYJcuXUuD69kbOMD82TgYTJPXXEvPreCc/n7DVXV39gc2dKYJlsVdK+4lB2YchOa6MIw7TjxlRV9YstNM3KjxMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626752; c=relaxed/simple;
	bh=9Te6Xjawbf4EVQN2F4eQcRMrQcCLRbZceAv2rUOa5Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uQtc4JxBw+Ce0AVofeCmozGj1tSJmnikw2Xxb37zsbl6KnJI7HGnnjAub/Ye3qQO257F0a/efwvEBKi5w2lLejQa2EofhgbBUEBdkqlhV7fh7BwVGInl7UD65zqIFj6fHzO8iinMQDCZ8FFTa7x83mZVFGg2BV0ujRRSWnuX4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aSAdYoB9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UBkFlq000534;
	Tue, 30 Jan 2024 14:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fdNjFLweiHVwb5x1YrXnrC/mCpj58gdWJ+qxD+jlLjk=; b=aS
	AdYoB9RmA4K9f6Kb5VdqRqyMsFQZNxfEe/sLotX/marsaJ2CKtZTFQKGGxiqL7vc
	pALTEKTsXBOpKem+KiRVR7TAgP0W3yGbPewqxqf+NjiT/z3+cFL9V6INw2oDF+ni
	OiEpsDR8+52eEqopuaGW6Pbz5oSHX/9su2o5REODTUIyV8njdLuTzsn28XYTBLqk
	tEc8/pOJreK9Zhz+VEc0lsdNmCltqk4adOK2KH2voDKsnNcekQX9Dy3bXzpl2ZgJ
	rKJucMXqDls9gHUdi+HjTEO4uuCdZszbEvvoIun0D5YVkamQ6AXUPCu25rPRrbhX
	AyvEJYGPYbOfYELrQVzg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxrq09db0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:59:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UEx64e003125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:59:06 GMT
Received: from [10.216.2.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 06:59:05 -0800
Message-ID: <14f9e510-8d69-41af-a68d-78d1e2dffe2e@quicinc.com>
Date: Tue, 30 Jan 2024 20:29:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: allow CSA to same channel
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20240129203544.ef7258d5790d.Idafe22e41621757458d4960659b9621853f7104d@changeid>
 <f4501322-c9e4-449b-9c81-f64a6d2172fc@quicinc.com>
 <fa1b179cd0d4de0c23e967d623f71314efc90235.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <fa1b179cd0d4de0c23e967d623f71314efc90235.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xcRKKzbb3hyfMs5tsCI_5vjoLM47eQqx
X-Proofpoint-GUID: xcRKKzbb3hyfMs5tsCI_5vjoLM47eQqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300110

On 1/30/24 20:23, Johannes Berg wrote:
> On Tue, 2024-01-30 at 20:14 +0530, Aditya Kumar Singh wrote:
>> On 1/30/24 01:05, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> This could be used e.g. for temporarily sending quiet
>>> (mode=1 in CSA/ECSA), or updating bandwidth. This is
>>
>> I know the intent here (from the other thread), but using the phrase _or
>> updating bandwidth_ is probably not correct since currently without this
>> change also, just changing the bandwidth is possible, isn't it?
> 
> Err, yes, indeed... bad commit message.
> 
>> Also, bringing a part of the discussion we had in the other thread -
>>
>>   >>> I'm thinking about removing that identical() check entirely - you
>>   >>> might want to switch to the same channel with quiet=1. At least for
>>   >>> testing that'd be really useful, and I don't think it really serves
>>   >>> any purpose to forbid it.
>>   >
>>   >> Yeah, we can do. But is there any actual use case? Also, what if some
>>   >> notorious user space application simply sends NL command without even
>>   >> quiet=1? There should be some check I guess?
>>   >
>>   > I'm not sure we care much about a broken userspace application running
>>   > with root privileges breaking something here? :-)
>>   >
>>   > And at least for testing it's very useful to be able to do that. Agree
>>   > that identical channel and quiet==0 doesn't make _sense_, but even
>>   > then I'm not sure there's a lot of value in not permitting it. With
>>   > quiet==1 at least it does make some sense still though, and we're
>>   > currently not allowing it, hence my patch (to be able to test
>>   > scenarios like that we saw elsewhere.)
>>
>> Agreed to your point. So in that case, should we skip the identical
>> check only when quiet=1?
> 
> We could, though I even now have a test (not posted yet) that's using
> this, but I could rewrite it to actually switch bandwidth.
> 
> I'm just not sure it's worth the extra complexity? What are we actually
> saving ourselves from by doing it? Clearly we have to handle this case,
> and whether or not it's quiet shouldn't really matter to the underlying
> code?
> 
> IOW, yeah, do have that information so we could just add
> 
> 	!params->block_tx &&
> 
> to the condition, but I'm not really sure what the value in that would
> be, other than some kind of accurate reflecting of how we think today
> CSA should be used?
> 
> But now that I think about it, Jouni mentioned yesterday that REVme D5.0
> is getting language to allow capability changes during CSA, so that'd be
> another thing to check for, you might (eventually) want to actually do a
> CSA to the same channel to change capabilities, without quiet?
> 

Oh! In that case yeah it is pointless. We can remove the check from 
kernel completely then.

> 
> Anyway, even without that, I think the check doesn't really help for
> anything. I'm not convinced the kernel needs to enforce a rule that
> "userspace doesn't do something useless"? From a kernel POV it doesn't
> matter if you can do it or not.
> 

Yeah makes sense :) Fine then. Let's remove it.

