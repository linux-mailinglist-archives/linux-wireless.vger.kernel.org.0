Return-Path: <linux-wireless+bounces-4897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7987FAE5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4721C21BE6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE0548F9;
	Tue, 19 Mar 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HZZO3gpe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713607C6CC
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841085; cv=none; b=MvIYABZrUPW6YJcwy9pLRfG/0oLj4L5e8dVM15EGA13mrsWfSKmD7BMTkoXInqe1Qn6PIs0Bzf7MddxpixaY/hVCd8XHS6PDK4W6NoPuM9//fMY6QqOlD/AQT5zv1xbaZTFYMUEdclO5uxTP7SzS0AwzY655/E/KBB6PEzDL6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841085; c=relaxed/simple;
	bh=6BbMu81K3KnrjmEE6asZwNZqoUgFyfAm10JGNy8uEaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=USmSxl2yf88LFHQdimqWkqAjDcA8V4VkYEv9+fmlC/F/OfXklepCpNRP4GbBdXwiBuTyL1hxjw9w/K8cOBEBNprVHbInyWCB7eYLZpAWJ+EYETskl/mbmoH3MoYAEVhSIPfvBK1ov2ZFCzGHz5d9px+2teP1C0TWH3DBF6B7W3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HZZO3gpe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J6iM53020456;
	Tue, 19 Mar 2024 09:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KqPIZmPIiOpiB2ei3mWHbtzUgzEyOQtTsWsDdS9stQY=; b=HZ
	ZO3gpedKEM5n95QMtTG7h36EsxDiR/V+EkZZYYW7a3u7XyI7bFjpfE29HbMKG5MF
	7ZpLX2nbXS38PTDz6OMbtDwxTQ+fzaTG7/jNUxdYvCH4TXg/oZ4zNJJPeRAFN3XP
	xKqcTwb3pjOum+uunSS2b2IoS00vj7beD9f52ZUur3cUcrxAHck6c/oqig0kjc0+
	PIp41B4qqVdDYhA6C3uMP7EJqqSTryKoEx+c5irpbvYDzh/HFBO3wDvIY6LbM/1u
	XBo/vrlXT5S6UcO8dgA2AJdflnzDdLYukQ8Vd+Bv8cgPP/SX/SmoACigfH9PaGiu
	FvtkmXR9jSywXAGBk3Jg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5pprd18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:37:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J9btXV014258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:37:55 GMT
Received: from [10.201.208.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 02:37:53 -0700
Message-ID: <1e9c36d9-0a2a-e458-a727-9630746b24e7@quicinc.com>
Date: Tue, 19 Mar 2024 15:07:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] wifi: ath12k: Optimize the lock contention of used
 list in Rx data path
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
 <20240226162310.629162-3-quic_periyasa@quicinc.com>
 <87msr4gbps.fsf@kernel.org>
 <33d25f11-d54d-6161-383d-d3823d5f6d19@quicinc.com>
 <874jd3cszc.fsf@kernel.org>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <874jd3cszc.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b6gz-0-YDzJKHQImmwcb49uOG2ZTgJRt
X-Proofpoint-ORIG-GUID: b6gz-0-YDzJKHQImmwcb49uOG2ZTgJRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 priorityscore=1501
 mlxlogscore=229 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=1 suspectscore=0
 spamscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190073


On 3/18/2024 11:39 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>
>> On 3/11/2024 6:35 PM, Kalle Valo wrote:
>>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>>>
>>>> When a packet arrives in Rx rings, the RX descriptor moves from the used
>>>> list to the free list. Then, the rxdma ring gets replenished, where the Rx
>>>> descriptor again moves from the free list to the used list. At the end, the
>>>> descriptor came to the used list with unnecessary list movement. The
>>>> descriptor used list is maintained in the Rxdma ring structure, which
>>>> creates lock contention for the list operations (add, delete) in the Rx
>>>> data path. Optimize the Rx data path by removing the used list from the
>>>> common Rxdma ring and maintain as a local variable in the Rx ring handler
>>>> itself, which avoid lock contention. Now, to find the used list descriptor
>>>> during descriptor cleanup, we need to check the in_use flag for each Rx
>>>> descriptor.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>>> Before looking at this in detail: When optimising something it would be
>>> good to have before and after numbers showing the improvement. Otherwise
>>> it's just wishful thinking.
>> I don't have numbers. Like you said, Its just a wishful think.
> So do you still want us to take this?
>
> In the future please do provide numbers to show that the optimisation
> really helps as intended. Otherwise we might even go backwards.

This is a simple UDP UL throughput test case results on x86+NUC device
with QCN9274 card

Before:
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft %steal  
%guest  %gnice   %idle
Average:     all    0.24    0.00   12.54    0.08    0.00 23.33    
0.00    0.00    0.00   63.81

After:
Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft %steal  
%guest  %gnice   %idle
Average:     all    0.34    0.00    4.60    0.00    0.00 19.59    
0.00    0.00    0.00   75.47

is it fine to capture in the commit log ?

-- 

Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி


