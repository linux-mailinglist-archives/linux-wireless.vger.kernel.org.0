Return-Path: <linux-wireless+bounces-7601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18C8C43CE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131A1283157
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F94C84;
	Mon, 13 May 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ot2s94kg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642746BF;
	Mon, 13 May 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612948; cv=none; b=mAC/7TFMZugcpoEwri+LSdRhAhMUvsFMNQ7BGQC9cjOUtEP/qV1RsI4kZoknbXCi6vNTcCsqfA/6gLpaiH1Uj6JXowXA/8g2sXZIL2m5zDPzmgB5ZqAf4RFLybZ+BUqXF44eRjJ4L4pQz3jfOOp0Q3sgUXhrbGzdKtdB8olkEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612948; c=relaxed/simple;
	bh=ImN2q9/z9gWMEu16rbIbzzPAMPmRzbl4JRpfAmk7AiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JQgbG63jOK5jym+vJkbEv4gyhLI+NTI3Ex25TYVu83v6l8xKZoONW+6OiVHT3pDgyh4BtzX5fvsBd3nVZ7rS4ogaP8fBp6wuliqlMdnfs2DhfOHR6K/6AzGqZTdU5/2EwoCVle9XV7awbs7KezGft0uirBneptAuJM/w1iEuqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ot2s94kg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DBUkAn007037;
	Mon, 13 May 2024 15:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bsQVXHQhWcmCU6NOkodQMdmrvCdS8Y6ZYWpxSKXCq5k=; b=Ot
	2s94kgxemLwA0C1ORnZVlYrsU4hNHoTC3atqoxeFML79O4bm19olYVpqllB6nVGb
	3Hep4rdlTJq2NYb853/N1KBriosnWWkH5yg08nE2aHiPAUbraSuzYoi7uRy2f0s3
	xjE3a6IjmVg4pd+t03QbhHkRi1QHPtuzlKfuTE9arTWefviC/0Tk9AcAce+GSY9o
	XsS/7fxwZ5FFvWW7SDzEsAo552XQmQK4EapJT27Z21Y8wa+kef6GsRq5hKbI6Yo0
	3nsE4StRJC3r0mWdcOZL+v1rK+fIUV8Uq99KN40AZV9tfuccOGxUHjxJZIPx7wut
	A1PYpTgST3o5IqOYCX7w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3j28ger0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 15:08:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DF8jgx007751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 15:08:45 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 08:08:43 -0700
Message-ID: <a3854bed-7229-47a9-a71b-72f5f68ec13e@quicinc.com>
Date: Mon, 13 May 2024 08:08:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Sebastian
 Gottschall <s.gottschall@dd-wrt.com>,
        Steve deRosier
	<derosier@cal-sierra.com>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
 <878rcjbaqs.fsf@kernel.org> <648cdebb.5d0a0220.be7f8.a096@mx.google.com>
 <648ded2a.df0a0220.b78de.4603@mx.google.com>
 <CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
 <87v83nlhb3.fsf@kernel.org>
 <7585e7c3-8be6-45a6-96b3-ecb4b98b12d8@quicinc.com>
 <cce2700c-e54f-4a50-b3f0-0b8a82b961a4@quicinc.com>
 <663e2bd9.5d0a0220.d970d.cbf8@mx.google.com>
 <a56bd4f9-d76b-4924-a901-554d71ea17bd@quicinc.com>
 <87seyojuuq.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87seyojuuq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: voR0tJwiuCbfgjHvs1Pyr62cWm_ZV8QO
X-Proofpoint-GUID: voR0tJwiuCbfgjHvs1Pyr62cWm_ZV8QO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_10,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=848
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130098

On 5/11/2024 7:17 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 5/10/2024 7:14 AM, Christian Marangi wrote:
>>
>>> On Thu, May 09, 2024 at 09:48:08AM -0700, Jeff Johnson wrote:
>>>> On 5/9/2024 9:37 AM, Jeff Johnson wrote:
>>>>> On 5/8/2024 9:50 PM, Kalle Valo wrote:
>>>>>> Sorry for the delay but finally I looked at this again. I decided to
>>>>>> just remove the fixme and otherwise it looks good for me. Please check
>>>>>> my changes:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>>>>>>
>>>>>
>>>>> I have a question about the copyrights in the two new files:
>>>>> + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
>>>>>
>>>>> My understanding is that Qualcomm's affiliation with Linux Foundation via Code
>>>>> Aurora ended in December 2021, and hence any contributions in 2022-2023 should
>>>>> be the copyright of Qualcomm Innovation Center, Inc.
>>>>>
>>>>>
>>>>
>>>> ok it seems like Kalle's v13 had:
>>>>  + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>>>
>>>> and Ansuel's v14 has:
>>>>  + * Copyright (c) 2018-2023, The Linux Foundation. All rights reserved.
>>>>
>>>> So Ansuel, is your work on behalf of The Linux Foundation?
>>>>
>>>
>>> When I resubmitted this at times, I just updated the copyright to the
>>> current year so I guess it was wrong doing that?
>>>
>>> As you can see from the copyright header this patch went all around and
>>> I think at the end (around 2018) the Linux copyright was added as it was
>>> submitted upstream. (can't remember if maintainers were asking that)
>>>
>>> So me watching the old year and resubmitting it, just updated the date.
>>>
>>> Soo I think we should revert to 2018?
>>>
>>
>> Yes, in this case changing the Linux Foundation copyright back to 2018 is correct.
> 
> I changed it now back to 2018, please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5eff06bef76b6d4e1553c2d4978025c329d8db35
> 
LGTM, thanks!

