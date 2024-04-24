Return-Path: <linux-wireless+bounces-6752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FEA8B00A9
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 06:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4648C2842B6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 04:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215B15444D;
	Wed, 24 Apr 2024 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iKZi0ZT/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E1152E0B
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934036; cv=none; b=F7wsRiqQ5u+DXCPs0VYxJjILiyKUj3CAJsE4AOLdy7s8mvbPuoX7PANIhWnrH/HMk8n5I4Cb9j5eyYXjuzDxzjPeiJELI2KHXFcYl/YB1ElCGURD3QHjNgL6hozkeONnbZ3w7Tj1Vz4h7LdFYI3wiMGPdQiGLiXjgs4HUSOST3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934036; c=relaxed/simple;
	bh=jutHfkvEe7NBp5bTxPMT8MyV3cqiQWBI/qsX6bd7M8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RIh9d9AnsqNZ3/ng9kR8vxOUI7p6u+iA8qkvvzQcZG/EFDevDVX8adS7uxuHS35TJO5ixXYNERjFCjKzTqHNZ5dd4M860ztRXDmDguk3ApGYf+1t01bqRfrazNiCvUr8e5LXwJdS/Xm98HTyVvK24Ayn/Lj1Za6ozsVSOa5d1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iKZi0ZT/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O2Om3W003007;
	Wed, 24 Apr 2024 04:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nblxhXYkAXAZVwap7pH+eW8JayGCJBu1tUBVT9ImzfA=; b=iK
	Zi0ZT/c6DSDNmf/U2ZbO2/61o81ZboRF46hCAzBT3MUbtIpyLom9SeWxTOB0XpX8
	xMIFOoGm3CTNvDmQaS5WRfH1L5Dlyh1JoWfbnb0sxWeDymdQJyzDrqezUW2mWbO9
	oiUw2P0ErpLv73dnlJu85nrkiQcWASRKlEYUN1MQoOHV1iaclJgd1aA4YbI2GZTb
	uK7UoTEq6jaieBpZ6Kp0mHX42RFvViAXKSU4xjxHK44GgbIFIrvQSfbbxK5it9Ud
	ZagxHuED5yIiTPAntJAUsqxlC1YzHjLAcY8itr38Sj9rOYbJFDdKsfXCHv+lfnh1
	Y+zJL0JmTmYnAvzylUWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xppn5gfse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:47:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O4l7H0015981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:47:07 GMT
Received: from [10.151.41.99] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 21:47:05 -0700
Message-ID: <cf025908-8e88-f60c-6466-9fdf1bccff09@quicinc.com>
Date: Wed, 24 Apr 2024 10:17:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240420083750.1545670-1-quic_hprem@quicinc.com>
 <878r14v2o4.fsf@kernel.org>
 <57002bbf-2c85-4fa7-b249-4bd3f2ba1bcf@quicinc.com>
 <8734rbidcg.fsf@kernel.org>
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <8734rbidcg.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3rtB8pnUaMIBfRkaI4YQUuEQxg7Bq_i3
X-Proofpoint-ORIG-GUID: 3rtB8pnUaMIBfRkaI4YQUuEQxg7Bq_i3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_02,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240019



On 4/24/2024 10:09 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>>>> Depends-on:
>>>>          [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery
>>>> procedures
>>>
>>> Are you referring to this patchset:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/list/?series=821155&state=*&order=date
>>>
>>> That was sent three months ago and at least I couldn't find a newer
>>> version. So I'll just drop this patchset for now without even looking at
>>> it.
>>>
>>
>> Yes, I'm stumped as well. the patch specifies:
>>> base-commit: c416602943dd36fbd13af7496430723935c867a3
>>> prerequisite-patch-id: a4d62344b11368fb7e549c03b6a31f7ba4c9e2bb
>>> prerequisite-patch-id: b4a1e18a85d8c1e337fa133c2bd2956c33b11046
>>> prerequisite-patch-id: b16edd310baa35e2500267e338f60c9a2e6594e1
>>
>> but lore is unable to find those prerequisite patch-ids, which leads me to
>> believe that they were rebased internally but never posted.
>>
>> I tried to apply the January series on top of the base-commit:
>> c416602943dd36fbd13af7496430723935c867a3 but it doesn't apply cleanly.
>>
>> So I think we need to have a rebased and updated "Refactor the hardware
>> recovery procedures" first.
> 
> Yeah, it's waste of everyone's time to submit patches like this which
> don't even apply at all due to missing dependencies. Please don't do
> that.
> 
Sure. Sorry Jeff and Kalle, My bad!. yes,the dependent patch should be 
rebased. Will respawn this series after the dependencies are at the latest.

Thanks,
Harshitha

