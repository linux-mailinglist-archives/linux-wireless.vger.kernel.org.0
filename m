Return-Path: <linux-wireless+bounces-4771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A796B87C3C1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 20:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1411C21366
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C974BED;
	Thu, 14 Mar 2024 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="THa41/Ga"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306D2E410
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445154; cv=none; b=oAwXIzG+yRIx5L5jXI4KkUtXy/kkrSvlun2j7nHSFGPgXooi3PbmcH0HdPpi9/qU3o7xh2Xt4boHRN4sKOULmmDJZb02Sx5yc/lRClN+Tbc+ANFoJ4OKkZsYPkCDXqEsCzsg8PymLqssJF3QsR1PnU3BX4EQE+FdRTB/DLUYj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445154; c=relaxed/simple;
	bh=yO1Y9ijNN5HaD+qJhn+gjdK4bWQxw3YOGyQhAb5wyvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajy3OBS1RnOqmxMdulpocKqKXk/7+610uYC69JYkPMLI8ll5caVrPaKSerOSHZxR6TuE5ueBcVcodPIgzWL64QNsqKB4BIaUVWGAyqKBiEU9WXCOvoKYn511uTjKszJy7WU0KZCK47tb9QncI1iY65iSu38UW50vBrmHuDNEYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=THa41/Ga; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EIMmt7022229;
	Thu, 14 Mar 2024 19:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=B/KaWl0GPaaZMb8ZSsPnu+zNN9UBDBkXGIQ15mbtGUE=; b=TH
	a41/GaB+S41ITRbJw/hVbZa1hX7u+WxqPHI49eYSqGgNvBYwyMTw+hV5GHWCo+a+
	dakDrJWFhFsTo/RKhDwam+WjMjOUUrRu17wOsz+jIFZ0Z2mdeYMbGsa6ZgjyC7yq
	LJsRWZqMhliqpYMLG081fgomwQcFMONOZ/2p+P3wlkc6grLQtO6MGzAsoQmaxNI8
	EH8x4alcpVerOKPMHqKuZmYTxYC4in55tdD4LWc2LCrPY5ND+RAsoQTz2BTtwcf9
	7fVG5Ah7HK3WkBxJiB7xVxcfa4uFfX9LTTZGSda+fSTv9S3mQw+TfRksdWRBdKe9
	38D3PEI2KuVLJm8g0ymg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuujsst9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 19:39:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EJd4Pr021692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 19:39:04 GMT
Received: from [10.50.25.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 12:39:01 -0700
Message-ID: <f542dbeb-debf-4335-9d49-4d12510f8bb4@quicinc.com>
Date: Fri, 15 Mar 2024 01:08:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
Content-Language: en-US
To: Jonas Gorski <jonas.gorski@gmail.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
 <20240312135557.1778379-2-quic_ramess@quicinc.com>
 <4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
 <3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
 <605a673e-3686-47d0-b71b-1e314fde65db@quicinc.com>
 <87il1qf571.fsf@kernel.org> <87edcef4qi.fsf@kernel.org>
 <f768cfec-d20d-424d-85ef-3576434aca12@quicinc.com>
 <CAOiHx=kx03MKKyMcJPxYPZH=E7krZwfsDqq2xnow8qRB7D-aqQ@mail.gmail.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <CAOiHx=kx03MKKyMcJPxYPZH=E7krZwfsDqq2xnow8qRB7D-aqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0_OefDgNq13k7S93VxIRSDVzQWLAKFsD
X-Proofpoint-GUID: 0_OefDgNq13k7S93VxIRSDVzQWLAKFsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140152



On 3/14/2024 1:26 AM, Jonas Gorski wrote:
> On Wed, 13 Mar 2024 at 20:18, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>> On 3/13/2024 9:58 AM, Kalle Valo wrote:
>>> Kalle Valo <kvalo@kernel.org> writes:
>>>
>>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>>
>>>>> On 3/13/2024 5:57 AM, Rameshkumar Sundaram wrote:
>>>>>> On 3/13/2024 3:23 AM, Jeff Johnson wrote:
>>>>>>> and guess we have to figure out how to suppress the ath12k-check issues with
>>>>>>> this macro
>>>>>> ath12k-check complains about the reuse of ah and index arguments which
>>>>>> may get evaluated multiple times if its an arithmetic expression, But
>>>>>> areas where we use the macro in our code aren't doing so.
>>>>>> Do you have any suggestions here ? or shall we go back and use this
>>>>>> for-loop inline.
>>>>>
>>>>> The macro makes sense -- we'll need to update the overrides in ath12k-check.
>>>>
>>>> IIRC it is possible to avoid variable reuse in macros with typeof()
>>>> operator (or something like that). I can't remember the details right
>>>> now but I think there are examples in the kernel code.
>>>
>>> Here's the GCC documentation with an example:
>>>
>>> https://gcc.gnu.org/onlinedocs/gcc/Typeof.html
>>>
Thanks Kalle for the references, as Jeff mentioned below, we need to 
reuse the arguments since we write to ar and index arguments on each 
iteration.

Defining local vars using typeof() without limiting their scope (since 
we are defining a for_each iterator{}) leads other issues like 
redefinition of variables in functions where we use this macro more than 
once :(

Also even if we somehow manage to convince check-patch, we'll still end 
up evaluating index and ar arguments in every iteration of loop.
This just gives an impression to check-patch that the macro is unsafe 
(although logically its not).
Experts, what is the standard we should follow here. Please suggest.

>>
>> the problem here is that the macro actually writes to those arguments multiple
>> times, so we actually need to reuse the arguments
>>
>> the macro as defined exactly matches the semantics of other for_each macros in
>> the kernel, i.e. see in include/linux/list.h:
>> #define list_for_each(pos, head) \
>>          for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
>>
>> what I don't understand is why list_for_each() doesn't trigger the same
>> checkpatch issues. even stranger is that if I copy that macro into ath12k then
>> I do see the same checkpatch issues:
>> CHECK: Macro argument reuse 'pos' - possible side-effects?
>> #998: FILE: drivers/net/wireless/ath/ath12k/core.h:998:
>> +#define list_for_each(pos, head) \
>> +       for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
>>
>> CHECK: Macro argument reuse 'head' - possible side-effects?
>> #998: FILE: drivers/net/wireless/ath/ath12k/core.h:998:
>> +#define list_for_each(pos, head) \
>> +       for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
>>
>> So I'm really confused since I don't see anything in checkpatch.pl that would
>> cause the behavior to change between macros in include/linux/list.h vs macros
>> in drivers/net/wireless/ath/ath12k/core.h
> 
> The definition of the macro causes the complaint, not the usage of it.
> If you run checkpatch.pl on include/linux/list.h, you'll get the same
> output:
> 
> $ ./scripts/checkpatch.pl --strict --file include/linux/list.h
> ...
> CHECK: Macro argument reuse 'pos' - possible side-effects?
> #686: FILE: include/linux/list.h:686:
> +#define list_for_each(pos, head) \
> + for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
> 
> CHECK: Macro argument reuse 'head' - possible side-effects?
> #686: FILE: include/linux/list.h:686:
> +#define list_for_each(pos, head) \
> + for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
> ...
Thanks Jonas and Jeff for your insights!!

