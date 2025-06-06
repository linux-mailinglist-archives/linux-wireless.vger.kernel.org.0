Return-Path: <linux-wireless+bounces-23781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A042ACFB0D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 04:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D946116EC90
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54F51CEAD6;
	Fri,  6 Jun 2025 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zn+DS2mG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A91ADFE4;
	Fri,  6 Jun 2025 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175386; cv=none; b=qMBfwVSQhpRuyuAXaRQP8D5GLv9Bov1G6Ip5hGjyFdbrwnDwofq48p1lPExw4vjlsC1+MXhxVS+21xuMgPQNQvPHN8TpyD/ipO6v8y+Xa+w7qdKaEIEi0Ucbdn6P6gBvzzBDAm+lanoRwQ8wLeBd55CiUEUK1LyoZ0bpRKJF4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175386; c=relaxed/simple;
	bh=wsB0/UnCVcv2fPYQQYlsF9Y97rjISgsD6ICGAr4ysvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qeX1EOQKzn45WdTysuowGhdKbJLszzb7YdFad+HLtUKkjbcVg8l0B7iKc9UhercOkGmuio8vCUt23j09K1citv1hbg0VQBoZc5Vyx+tlRm7sBnc+a666JQFdSfDeOY+a6B5nnhQ51Cm2UQszjcp3UKASx1X3gNvTYRvN17QEbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zn+DS2mG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555I83T1011829;
	Fri, 6 Jun 2025 02:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6QCEgkhg1+LKwur0LlMAqZRH5jjjkJ7LHNToJmV8QwA=; b=Zn+DS2mGmwOm40bf
	0CF0MYZaC11CHVQ8G6i1D92IzlEMHkwUh0k8NNntQdkZEOn9hWn85p+Abl+Hx5mr
	rN1u4DLvre0W7bbcMr9FBRFLdYBZ+a2mDNrdIRnoCAy8hvDphkDmlcRYhukSgbji
	pgb2IVp12N1/THgo2kq42Jeu5u4FykVo+5d8CPuP/xHwjxHMt6F6LT1sOXptjeho
	xQ9SHWcztC/IFs0mmf51ZyiLjH+SY/VgW4OXueFoHn9d5AbaMwbFnJZ1vB+dkcv5
	LQLMvOM0cHWG5ymNkK8z8YPxxJrRTCIlp/xjrlKv2y7IrrDWNIcjmOW+YxEh08jj
	MVxQug==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn05ddt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 02:02:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55622vWn026444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 02:02:57 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 19:02:55 -0700
Message-ID: <06daee91-709e-4a98-b7ff-8233d33877b9@quicinc.com>
Date: Fri, 6 Jun 2025 10:02:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, Johan Hovold <johan@kernel.org>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
 <03354d56-ed21-47e0-a52e-14f559ff3bfb@quicinc.com>
 <aEFupJ_nd9ryaTVt@hovoldconsulting.com>
 <bc2afbd6-2876-4f36-81cf-ad8960588a02@quicinc.com>
 <d3ec49ab-964b-4c50-a6ea-534b6c6e336b@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <d3ec49ab-964b-4c50-a6ea-534b6c6e336b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TheKKaAJNytXrshf7BLvc5A8V3afCvEE
X-Proofpoint-GUID: TheKKaAJNytXrshf7BLvc5A8V3afCvEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAxOCBTYWx0ZWRfX5b/ZSbQREFHi
 XZdmp8wAc8fMdifxKLXuh3IG9lfPzLKJIkcIa/SaRenibMznp2W7WePfxb+5u86EMyfbHUREjLE
 qImY+yvI/FwIct8WBy+wOgH7xLkoDr0bRlzYFWr824ykA7lNgM88OAQ8eXV7iCcWdX47XVSV7Ur
 WEL/mMmgwaKvuJ9maGLDMJW1dQHCe+euf0dW35FmLMJwXvrQdFCvkQav5wkln1xT+MX8vhf5tPV
 aEMlYwIdkadt7SE223RjgX8ysIKfoNdYSsd0Bb8vFTDQRZr5/OX6n/mVV44eq4D159ZpSr58VY2
 R6BCWoZVIqi+50J6kVJN+Ece9fpjHd+b47WUJvq4thmbZieG7Ehk3oMW/BecZFo+z7FNwmXrfWq
 lOkGhX0b/OLu+lEIwT7u+V5+yCSNBgGOldM0lWu9pyqMUANmwA4UJA2I4isSsdaq4BV5iuhr
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=68424c52 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=3zI7SI0Xz8OAuioJ69MA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060018



On 6/6/2025 8:52 AM, Miaoqing Pan wrote:
> 
> 
> On 6/5/2025 6:54 PM, Baochen Qiang wrote:
>>
>>
>> On 6/5/2025 6:17 PM, Johan Hovold wrote:
>>> On Thu, Jun 05, 2025 at 12:01:29PM +0800, Miaoqing Pan wrote:
>>>> On 6/5/2025 12:24 AM, Jeff Johnson wrote:
>>>>> On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
>>>>>> We previously had extensive discussions on this topic in the
>>>>>> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-
>>>>>> c34178e690fc@quicinc.com/
>>>>>> thread. On my platform, dma_rmb() did not work as expected. The issue
>>>>>> only disappeared after disabling PCIe endpoint relaxed ordering in
>>>>>> firmware side. So it seems that HP was updated (Memory write) before
>>>>>> descriptor (Memory write), which led to the problem.
>>>>>
>>>>> Have all ath11k and ath12k firmware been updated to prevent this problem from
>>>>> the firmware side?
>>>>>
>>>> No, as this is not a widespread issue, and addressing it would require
>>>> modifying the core underlying modules of the firmware. Therefore, we
>>>> chose not to proceed with that approach but instead used the workaround
>>>> patch I previously submitted.
>>
>> If firmware has a concern, how about doing it in host? As I know it is only a register in
>> PCI config space?
>>
> 
> No, host can only configure the RC, while the initialization of the EP can only be
> configured on the firmware side.

Are you talking about this specific register or whole configuration space? If it is the
latter case we already have something similar (such as disabling ASPM) done in host side.
Just curious why not for your issue.

> 
>>>
>>> I strongly suggest you fix this at the firmware level rather than try to
>>> work around it in the kernel to avoid playing whack-a-mole whenever a
>>> new (hard to track down) bug shows up.
>>>
>>> The barriers should be enough, but if they are not then the firmware
>>> must be fixed.
>>>
>>> Johan
>>
> This is beyond our control. After nearly three months of effort, we have decided to
> abandon it.
> 


