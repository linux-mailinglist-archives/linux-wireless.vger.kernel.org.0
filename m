Return-Path: <linux-wireless+bounces-25088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7660CAFE4A9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E7F3B8994
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B51FC0F3;
	Wed,  9 Jul 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iYq/vskr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE42877E2
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054972; cv=none; b=J4SdIp7C2NPqTihtcHTO6M7rnW+YCwx016wybZV/D14xeJ9bxOlLHw5lc7vURonZjDJHu/npbO8SbymqUZxqapMCS4ZervGSPKxKPhXZQUq1zcOsk0X7xgoPCNyQxvKQPR8igvvAwfceHIUjtQGtbSh9Pt4zuE02e72b08lmI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054972; c=relaxed/simple;
	bh=loQt67nb2SPfJibU3i/qoAOrbY+JfRlScYxUSDuK5DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSo3MCsvjrzSjln+oodf1tDeWUq4qYAotbOhG6pBHXumKWf6JDmRoyKwXzxqq+Kl2YHDAT+1Wkv1MJjg4/syvhmvoacK2GnPYJrSm9CXd8sWEh4Q5y1zvctH6tjGhtw4NBfqVAeZXi2U5AjmIOvOOQeR2raW9DGn2lalc6BVF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iYq/vskr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697jhGw010137;
	Wed, 9 Jul 2025 09:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sN5kSzrQQWZGXR5xtpzPMPoQQW+Iuy/wmw/1sYAsetQ=; b=iYq/vskrEfYnbb2W
	XoGx4hckt0l+31mHa12tlF1b61EDIdhEpHCOPoGmvW6ZQ56DJFZ7T5ZEzu60T0ru
	WHwXZV2uRIRQPYV7Gft2PMY7tf6KGh21FUXYdkQa1zm4r1ssAjJj8nSReh8YwWBH
	6262qqJzvuM4CwGMI2Ehdabw1o0kNf80uSU5Ht6M6KInY/R5iaeV+MkwOV7E9BL/
	ojMfIK1x//Cy8QtzKH061w3qdmfQK3eD1blD03u5oZaoWwSyjgQWC/lZj0Amahl0
	Y3DbL6dddOmni+tdO5uYD8jbvRy3e6Xt+/iQyZN9MG1V1IhZb4StJVyhAGWdCoEa
	4r99Nw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smafgd1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 09:56:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5699u4IC006298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 09:56:04 GMT
Received: from [10.110.15.206] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 02:56:02 -0700
Message-ID: <18cadaf7-5d0f-49d0-a9de-d237eef52e1f@quicinc.com>
Date: Wed, 9 Jul 2025 15:25:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Add support to enqueue management
 frame at MLD level
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20250703051711.2839934-1-quic_rdevanat@quicinc.com>
 <d2d8778d-a39f-445c-8d08-8759c1aee07f@oss.qualcomm.com>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <d2d8778d-a39f-445c-8d08-8759c1aee07f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZJ/XmW7b c=1 sm=1 tr=0 ts=686e3cb5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=BhiHL6Vfu_Ttk14HBKcA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vaUAooN6rlPdXFmOGh67O7S5MI6YwFOL
X-Proofpoint-GUID: vaUAooN6rlPdXFmOGh67O7S5MI6YwFOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4OSBTYWx0ZWRfX1d0DkWAbG/ju
 6ChqeUY4aVwKmDHPkrDOO1iXwSmb2s+lye8MRDg+RfGBFbGVXgbCb4fNH+3T3xDzaAK/i9+eyhF
 sYLN9pe/ZXDMUkQ3osS6h/1WOoDj1C1SCOVAxVbs/+xzh9mL8ULp7SBEMpmO4CUoxefg5cGrqcP
 hIhqgfv0g/kXKXLr0w14uq7/ybteLiKwTpc2npvT+nI6FRNtFFzH+ic8UylO+WDbOiOn9Bdz7Av
 +UP8mq19Yu5RLBjuQmvwmHu51V72yHhn0waRxlfdfSabAeXcxjzm6ZdRF1W7sHinNRqN8OPEPjx
 msFTL+0UHi0OsA79aZ4nNmvKm7J+jQIsoA4Zd/umd2wjSe7xCcTR2rnEZjt42Z9x3mc9EuGJ6xj
 1hYUeViAlAjkl7WLUiqdTyve2nxXL29AShmwFcUfQaCbYbjzNLfg8ce1MC2+5gtC23YzIS07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=828 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090089


On 7/8/2025 9:37 PM, Jeff Johnson wrote:
> On 7/2/2025 10:17 PM, Roopni Devanathan wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> A multi-link client can use any link for transmissions. It can decide to
>> put one link in power save mode for longer periods while listening on the
>> other links as per MLD listen interval. Unicast management frames sent to
>> that link station might get dropped if that link station is in power save
>> mode or inactive. In such cases, firmware can take decision on which link
>> to use.
>>
>> Allow the firmware to decide on which link management frame should be
>> sent on, by filling the hardware link with maximum value of u32, so that
>> the firmware will not have a specific link to transmit data on and so
>> the management frames will be link agnostic. For QCN devices, all action
>> frames are marked as link agnostic. For WCN devices, if the device is
>> configured as an AP, then all frames other than probe response frames,
>> authentication frames, association response frames, re-association response
>> frames and ADDBA request frames are marked as link agnostic and if the
>> device is configured as a station, then all frames other than probe request
>> frames, authentication frames and ADDBA request frames are marked as link
>> agnostic.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
>> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h |  1 +
>>   drivers/net/wireless/ath/ath12k/hw.c   | 55 +++++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/hw.h   |  2 +
>>   drivers/net/wireless/ath/ath12k/mac.c  |  5 ++-
>>   drivers/net/wireless/ath/ath12k/peer.c |  2 +-
>>   drivers/net/wireless/ath/ath12k/peer.h |  1 +
>>   drivers/net/wireless/ath/ath12k/wmi.c  | 56 ++++++++++++++++++++++++--
>>   drivers/net/wireless/ath/ath12k/wmi.h  | 16 +++++++-
>>   8 files changed, 130 insertions(+), 8 deletions(-)
> This no longer applies cleanly to ath/main, please rebase
>
> Applying: wifi: ath12k: Add support to enqueue management frame at MLD level
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/core.h
> M       drivers/net/wireless/ath/ath12k/mac.c
> M       drivers/net/wireless/ath/ath12k/peer.h
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/peer.h
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/peer.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.c
> Auto-merging drivers/net/wireless/ath/ath12k/core.h
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/peer.h'
> error: Failed to merge in the changes.
> Patch failed at 0001 wifi: ath12k: Add support to enqueue management frame at MLD level
Sure I'll send a re-based version.

