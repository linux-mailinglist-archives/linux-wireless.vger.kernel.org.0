Return-Path: <linux-wireless+bounces-6082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BAE89EE9F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683C6B25128
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37F156C4B;
	Wed, 10 Apr 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nJfI8twh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E711552F7
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740572; cv=none; b=hl1XnYRyoRl7QO4/xYTOvuKX6w3nyILXV00IurHLpoauIKw74ca7j7/1hSXw9Ey0rCbYV6UxbQPqCw772bryJwH7cVPC+fXsVv+kgt3jKepCrZaKGxZUIlZQgrxw1l+Zclz46mbozwL8TIPl9tAtao83zG7n9MXzoHstXIb47ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740572; c=relaxed/simple;
	bh=Of3QT19oYmpAlD+PIsHNwAk5F4OZg/Gzm4GS1zkGiZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cRS6OkDx228LcbaELYUXKZ7n04bwKgFc8cxgCevuhSjZKJHifXPCYH3Ex0sBY5u/J4uT2nYwZ4O6n+WssHUhZ5TSTn/X4sqAxzNFXbpqsDGrx6Z34M+QQusHbiiGw0p0Auqnzd3RBb47SBkDbnvK/sfl3zHT2XEumPHQM800ibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nJfI8twh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A9Ei2m003079;
	Wed, 10 Apr 2024 09:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DuDwGgCvQAuQmeUcTOn0PGeRwAWoOKP+S09llJBOnDM=; b=nJ
	fI8twhb/6EpDojTm1u4TN6MuMbFOHdif30SI0Uk8t5BP6y/QesZTEdaA1plEktWF
	0PSiPQ3j67gc/kqIdd/8cgGP4RMrFOpsiUdIAmrBjacOaDZRSYkHkd9Eir/qro9P
	2AcM/IS8s2LNdxaK5EvRaoWaV03B/Z7HarGqXtJRX7sn/RDNrmXTOWKnZ3cAnR9u
	yIW0ZN31tQWFjvUa6JUo7vrrmDWpm2Ve2SQDvihFX016C2eiv9ZSnJ8JjHFMBA/G
	MZGkVAc1mdxwg8Kc+pk6qdl+ZjKcxDAlqZSx5o1ekiKcXDe+HZ+v4y5p6PjVAkvq
	AzZ9vDd+67NPziv0wJiA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdqy7r0bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 09:15:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A9FwDD024209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 09:15:58 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 02:15:56 -0700
Message-ID: <44733762-19d5-9a8a-dfa3-6700a4deb6b4@quicinc.com>
Date: Wed, 10 Apr 2024 14:45:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <d2e6360b-1092-4e57-47e6-c5f336f32c92@quicinc.com>
 <c2160c4616ef520d7037f9b7606b47d366f02dd6.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <c2160c4616ef520d7037f9b7606b47d366f02dd6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: szdwanENUyP7zzAaKoQax3DkHVGaORe4
X-Proofpoint-ORIG-GUID: szdwanENUyP7zzAaKoQax3DkHVGaORe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=652 suspectscore=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100065



On 4/10/2024 2:39 PM, Johannes Berg wrote:
> On Wed, 2024-04-10 at 14:38 +0530, Karthikeyan Periyasamy wrote:
>>
>> On 3/28/2024 1:16 PM, Johannes Berg wrote:
>>> That's a big set, not sure I can review it all at once :)
>>>
>>
>> I plan to separate the code refactoring changes from this patchset. Do
>> you have any concerns?
>>
> If you split it up? I don't see why.
> 

Based on the comments, the patch count for the next version is 
increasing. I believe it would be beneficial to have the refactor 
patches in a separate submission before sending the next version.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

