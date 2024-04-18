Return-Path: <linux-wireless+bounces-6538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D18AA17F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2529A281972
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C716C864;
	Thu, 18 Apr 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j2F6Kfcx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F9839E3
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462782; cv=none; b=Kc1tjb0FoD+/6T4Wpj7POpZvHQEvT4/gpkBlE8Kc86oTh4sPSF8SknUTKWLSeOJNpMlpfI8tAwmr77VNkQoIfVgz0MCF41EwjhJpBB3N1m/OMKqqneeqDLSRI+/Ok7r41fecPW0tdpe7K9ivZpBm/718Ah8JgijzGRqqPs1N4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462782; c=relaxed/simple;
	bh=+oBFLmYYdnYdhHrJ61MDOO559YjJWSSZMsZCsv4bCV4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QA3qFCDx7RExN/kb3wySWvkWPGF9eIX6C2JgHQow86WcBOOs1Cwim6coO9P2r5Ojhb+zj69bO0N+ckhXV04k0ZYtVaIhlLQlTdJHHdZzYK5pd960Q7BoTBvhzaoz1ugukqcx9UKrY3wrAzP3zZCrIqUMgEvf0oFx22oC38VxT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j2F6Kfcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IE0D10015491;
	Thu, 18 Apr 2024 17:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dz85mNbsScx0oCTKuf5RUVtvYV+yQpkJcRmPH3pjbSk=; b=j2
	F6KfcxOq82NuooEslqsdMBMFJ8drL5fBQRN6kajPz+wMFtFgP3h51Jgl2IV94o8l
	cV8tdaUp3X6hlpRB964UzA+uayGk9xP9iPgp/U91k8yuAj7hRiAtn9Ys07i7/Pq6
	EFHTJrliDV0G/d0w9fRai437ml2gPIEoyijIfNZ+e1oD0zLBWAto7tGhmX141Twj
	+mCsuOOmneVoQjw/nMxk6d4bFiBKjqhWRMx7I2pVwR8wmJeNnMyTwmJYyw70PW3e
	URYQGf+kBdiKgIteKQWf4FrnnYzLGsWwKhK05CoFSjnzpP8ZLiTP7ugJ9WgISd73
	LMYwHqfAKzfutjFKhNRQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk4vm8kq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 17:52:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IHqsle007957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 17:52:54 GMT
Received: from [10.110.20.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 10:52:54 -0700
Message-ID: <514da0bc-f9f6-41fb-9e3e-72677394695f@quicinc.com>
Date: Thu, 18 Apr 2024 10:52:53 -0700
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
In-Reply-To: <c5dec609-493a-4246-b006-aa905edfdac3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dYzQvRMXIznRtG_OfGlI_pUAiZk4Ivks
X-Proofpoint-GUID: dYzQvRMXIznRtG_OfGlI_pUAiZk4Ivks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_15,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=769 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180127

On 4/10/2024 1:25 PM, Jeff Johnson wrote:
> On 4/9/2024 12:09 PM, Nithyanantham Paramasivam wrote:
>> We observe intermittent ping failures from the access point (AP) to
>> station (STA) in any mode(AP-STA or Mesh) configured. Specifically,
>> the transmission completion status is not received at Tx completion
>> ring id-4(WBM2SW ring4) for the packets transmitted via TCL DATA
>> ring id-3. This prevents freeing up Tx descriptors and leads
>> to buffer exhaustion.
>>
>> Currently, during initialization of the WBM2SW ring, we are directly
>> mapping the ring number to the ring mask to obtain the ring mask
>> group index. This approach is causing setup failures for WBM2SW
>> ring-4. Similarly, during runtime, when receiving incoming
>> transmission completion status, the validation of the ring number by
>> mapping the interrupted ring mask. This is resulting in
>> validation failure. Thereby preventing entry into the completion
>> handler(ath12k_dp_tx_completion_handler()).
>>
>> The existing design assumed that the ring numbers would always be
>> sequential and could be directly mapped with the ring mask. However,
>> this assumption does not hold true for WBM2SW ring-4. Therefore,
>> modify the design such that, instead of mapping the ring number,
>> the ring ID is mapped with the ring mask.
>>
>> According to this design:
>> 1. During initialization of the WBM2SW ring, mapping the ring ID
>> to the ring mask will ensure obtaining the correct ring mask group
>> ID.
>> 2. During runtime, validating the interrupted ring mask group ID
>> within the transmission completion group is sufficient. This
>> approach allows the ring ID to be derived from the interrupted ring
>> mask and enables entry into the completion handler.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> 
Please remove my Acked-by.

I've bisected a kernel crash on my laptop to this patch


