Return-Path: <linux-wireless+bounces-7394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07258C115D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 16:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D6F1F219D4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A72BCE3;
	Thu,  9 May 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="boiAOWrV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66015AF1
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265557; cv=none; b=Tmi6Q03SXu35tLplh2+oKTvWWfbPpVtb/CUp/aW4oQcm2qwlgBzGDLJ6m/V9qs4KLhFTvARcJ5T9Hg0ctHD0V+eE7IJeLL8uubNZMk3MAIbCRLhvX7hSCcI1/v78qTTWyTXpVjkZY/lNw8/UZ9fQd6uOTNkJ8nYOKN6wEbvq+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265557; c=relaxed/simple;
	bh=fXAUNA4d0tCc+1gw5RCwgwumRmENtHZZPQYEGEcbZbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=sLNsS82PtC/ZDyN9qy/Fmesa+6hrVagGK5tNvkchOnh4n8+Pasq1heDmk8EoNrWg6EZPGQY5m8JUrwpO/aClnu3PAk9BYvtx20q+FvkfZqopFA5KyumedOKH72KhtTs9tr/UngRZ515tVEzQdEsP2QtF7JbTY03ZtxmN7UPvFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=boiAOWrV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4497BMxN007934;
	Thu, 9 May 2024 14:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kaKX5pD/wsH8AgtifBxYzaXGEYxu1ITHFtiP2x1Rjiw=; b=bo
	iAOWrVND4rBbPEgpRlN+R6cPFqh4FvoVMe7FmicwmPRMlIR0V8Ev63++zP0fCpWt
	s1Z2ikcAPif4I0lyTAhZKoBnuTrz0cAofkfy9LUH0IQRPvQ8us1CpoOQnC+nG+C+
	ZXQOLNynEA6pOiLctZSiJ2aUyJgA6DDofvylLsDVE3+qxqweE47Jbyby2jKqDOCw
	vxKGKQFKpMnXmXw6/HX6XIpyg/KXdsO1R0V4Lo1LZaKW+QqYwto4Xv6dadmI6ssB
	xTawiJWf9rj/i9I0QZ7tfD+EM7tpZOqh27seydCVWzBJxdFfdq5S728mTlO85MQ/
	fbasxWXmRJjtQ67jZE7A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09ejtw8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 14:39:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449Ed9Ef015323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 14:39:09 GMT
Received: from [10.110.102.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 07:39:08 -0700
Message-ID: <b96ae3ec-44e0-42e1-8b3f-89144f01c272@quicinc.com>
Date: Thu, 9 May 2024 07:39:07 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240409190922.4180631-1-quic_nithp@quicinc.com>
 <c5dec609-493a-4246-b006-aa905edfdac3@quicinc.com>
 <514da0bc-f9f6-41fb-9e3e-72677394695f@quicinc.com>
In-Reply-To: <514da0bc-f9f6-41fb-9e3e-72677394695f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i-CvSkEb0wCyAFFxzWNamhiFsiLM1pHJ
X-Proofpoint-ORIG-GUID: i-CvSkEb0wCyAFFxzWNamhiFsiLM1pHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_07,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=660 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090098

On 4/18/2024 10:52 AM, Jeff Johnson wrote:
> On 4/10/2024 1:25 PM, Jeff Johnson wrote:
>> On 4/9/2024 12:09 PM, Nithyanantham Paramasivam wrote:
>>> We observe intermittent ping failures from the access point (AP) to
>>> station (STA) in any mode(AP-STA or Mesh) configured. Specifically,
>>> the transmission completion status is not received at Tx completion
>>> ring id-4(WBM2SW ring4) for the packets transmitted via TCL DATA
>>> ring id-3. This prevents freeing up Tx descriptors and leads
>>> to buffer exhaustion.
>>>
>>> Currently, during initialization of the WBM2SW ring, we are directly
>>> mapping the ring number to the ring mask to obtain the ring mask
>>> group index. This approach is causing setup failures for WBM2SW
>>> ring-4. Similarly, during runtime, when receiving incoming
>>> transmission completion status, the validation of the ring number by
>>> mapping the interrupted ring mask. This is resulting in
>>> validation failure. Thereby preventing entry into the completion
>>> handler(ath12k_dp_tx_completion_handler()).
>>>
>>> The existing design assumed that the ring numbers would always be
>>> sequential and could be directly mapped with the ring mask. However,
>>> this assumption does not hold true for WBM2SW ring-4. Therefore,
>>> modify the design such that, instead of mapping the ring number,
>>> the ring ID is mapped with the ring mask.
>>>
>>> According to this design:
>>> 1. During initialization of the WBM2SW ring, mapping the ring ID
>>> to the ring mask will ensure obtaining the correct ring mask group
>>> ID.
>>> 2. During runtime, validating the interrupted ring mask group ID
>>> within the transmission completion group is sufficient. This
>>> approach allows the ring ID to be derived from the interrupted ring
>>> mask and enables entry into the completion handler.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>>
> Please remove my Acked-by.
> 
> I've bisected a kernel crash on my laptop to this patch

While debugging my crash I've determined the issue isn't with this patch, so
restore my:

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

/jeff

