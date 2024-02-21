Return-Path: <linux-wireless+bounces-3867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17C85E41E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A907F1F2482F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9C1DA32;
	Wed, 21 Feb 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o9V6B6R7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12E33F7
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535619; cv=none; b=qkv6t3xcTm54L6xQerDXcI2k4oY8ymr4AsmSAS80U0rI8uAPnTb4vsH6/h9zGHsblz4LR8bfCjNZhPUzINKVe7ue4sWfvHaWKNQiNTLDYBMLGv0zTsRWCyB6JRby8Puyl8GS2EocLyiTW2GMc4nX9P96DNFKoYvHBz9HQi5IzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535619; c=relaxed/simple;
	bh=+VMw/YQz5Rcq3+ybO/hnQmYxH8wqlD/4kIGM1Aojx9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l+JGrjrgTdMBJkaJk+yccQQ2d/pqIm2d5rEbw7USMNexiTstGcjkv4THSBm4ggkfV3dHUN7MAGKbuk6kGuCjuFc6vmOK4ggtTRj19DPL7FJP1pDVWbVJPJPUKpgzlBWcI+VyZ2nCNIhYPy4YhDDNoe1B/sWTdpjkS/8/LFQ0CRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o9V6B6R7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LFtVKJ004408;
	Wed, 21 Feb 2024 17:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DZ427HggZUXrl3z87rbg2SD+3slf0S6YtqzmYEdMCy4=; b=o9
	V6B6R7vXTKDZR2/tHw4AH1OuKDgy8qjOvBsedP1+oM6DIyKvyy7Azzxx4L7UI+36
	5+tqSwEYc9gBCZvV9nD+jM21PK367dJXH2/ZgZscPhAbwQnWq4phVWzqpU8aN7J5
	7f1al4+VZAvdOa8bsgrvFB0PAsccbOFznLjw9hS14TNPze8U446lMRjjosX/5qKC
	QQm094NTmxL93/5U6ybJOD0uw/Mcy4kRZwCxnhJJY8RykmQe6vvmDZmZn2rSxO4U
	0CI80JvaTP5JqeM687uzm0Cc6cc5LVEWGhPfvz86G0PozCYFsWAUDzqsli6wcfvS
	o8ZUfriW7OopkNu2CAvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfm78x7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:13:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LHDX9m023516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:13:33 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 09:13:32 -0800
Message-ID: <77a93ab6-24d8-4e29-9fe5-849a0ec0a91c@quicinc.com>
Date: Wed, 21 Feb 2024 09:13:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: ath11k: rearrange IRQ enable/disable in reset
 path
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221024725.10057-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GowBYTm6jBpbFJk2R7d0H2IOcW3G-7f4
X-Proofpoint-ORIG-GUID: GowBYTm6jBpbFJk2R7d0H2IOcW3G-7f4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=577 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210133

On 2/20/2024 6:47 PM, Baochen Qiang wrote:
> For non WoW suspend/resume, ath11k host powers down whole hardware
> when suspend and powers up it when resume, the code path it goes
> through is very like the ath11k reset logic.
> 
> In order to reuse that logic, rearrange IRQ handling in the reset
> path.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


