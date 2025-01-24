Return-Path: <linux-wireless+bounces-17888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C05A1AF9B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 05:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C863A8C98
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 04:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA57155759;
	Fri, 24 Jan 2025 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YFYa+OKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33D29A0;
	Fri, 24 Jan 2025 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737694281; cv=none; b=S3OXhHgr3ZN9CgENuhGrZCMBFleX1KQYNACnF394hKpiMugrdEylQgcsSyLVyMNCv0/34Pi9kw+6EYRkIfhQxycPyhzu4ERn+dwflYr5PKfgggPQ9hTjBOkg0eIwFSnN63uOOJyyecJr5HUbDvfaYH70eCnmAfAx2IRKeKseZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737694281; c=relaxed/simple;
	bh=unCCtEatlk+BschkiNMt4WiA7UQ0GhCzN/qpWuvSoyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LrgabSUS7dDh8PdbOHTXyL/cwwZR7p+SODHOrtdde4Do2PZ4BP6piDoQn0lyqp57v7CeJTfurlTggMS1K6ZD8iwlRami8tP6B/fI7ZyfNECuVWuZA8hE/zTbgoztQaxZ6+rxJj5OsxcAgwm6FN45LHzCt9pCzC9bxjB4ixBPHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YFYa+OKn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O1Kv7D021872;
	Fri, 24 Jan 2025 04:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fsSZgH3HhKpGI7TPi6vV14BAPG/S4uELsqFLHf9F88=; b=YFYa+OKn9VLKP7kd
	WtF4/idAKfDK2y6K/1iJbVOOGbPr1zVxqXGw//uqrvFJxyqVC2MEqDrbcLFlwX5y
	5fcPZgi92wegTah/RPJ7qaH+C8EYkqNb3+/Qdz512jc4qIn98jSxU466plvJ3oh3
	QuugRIeN+VvbvcPxbNfgDl0U60cTP/+/yGSyAXp8l6si493TAb3lSrkK8yL2TtU1
	r5i3r0izANMU39wrqE2dxgjyNVxyqhfTUG5hn4EQpZ5y90fDSTSRFJma9OrCB4Q9
	2Q2Ks9UGWQjVn7GUbi4t6PGm+7BlJubXqT53w7dZaEZvaRbmbr1JgyVQ+nRzvjCc
	hacAAA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c147rcg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:51:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O4p5PR003949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:51:05 GMT
Received: from [10.216.47.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 20:51:03 -0800
Message-ID: <d0d863e4-6681-419b-930b-867c97e158fa@quicinc.com>
Date: Fri, 24 Jan 2025 10:20:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wifi: ath12k: add MLO CSA support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com>
 <4629864f-010f-4524-8861-1381f4b18614@oss.qualcomm.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <4629864f-010f-4524-8861-1381f4b18614@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aTJ_aIlfrf0pET9DENqXCL3agp8AG1u-
X-Proofpoint-GUID: aTJ_aIlfrf0pET9DENqXCL3agp8AG1u-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240033

On 1/23/25 23:20, Jeff Johnson wrote:
> On 12/23/2024 8:21 AM, Aditya Kumar Singh wrote:
>> Patch 1 and 2 are pre-req fixes (applies to non-MLO as well)
>>
>> Patch 3 basically uses arvif->link_id to enable MLO for CSA while adding
>> support to update counters throughout the CSA time.
>>
>> Patch 4 fixes a potential problem seen when medium is busy. Again this
>> applies to both MLO and non-MLO. But this is exposed only when Patch 3 is
>> there.
>>
>> ---
>> Aditya Kumar Singh (4):
>>        wifi: ath12k: update beacon template function to use arvif structure
>>        wifi: ath12k: fix handling of CSA offsets in beacon template command
>>        wifi: ath12k: update the latest CSA counter
>>        wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE
>>
>>   drivers/net/wireless/ath/ath12k/core.h |  2 ++
>>   drivers/net/wireless/ath/ath12k/mac.c  |  7 ++--
>>   drivers/net/wireless/ath/ath12k/mac.h  |  1 +
>>   drivers/net/wireless/ath/ath12k/wmi.c  | 61 +++++++++++++++++++++++++++-------
>>   drivers/net/wireless/ath/ath12k/wmi.h  |  2 +-
>>   5 files changed, 56 insertions(+), 17 deletions(-)
>> ---
>> base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
>> change-id: 20241217-ath12k_mlo_csa-35bd512a05ae
> 
> fails to apply to current ath/main
> 
> * Applying 20241223_quic_adisi_wifi_ath12k_add_mlo_csa_support.mbx
> Applying: wifi: ath12k: update beacon template function to use arvif structure
> Applying: wifi: ath12k: fix handling of CSA offsets in beacon template command
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/mac.c
> M       drivers/net/wireless/ath/ath12k/mac.h
> M       drivers/net/wireless/ath/ath12k/wmi.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
> Auto-merging drivers/net/wireless/ath/ath12k/mac.h
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.h
> Auto-merging drivers/net/wireless/ath/ath12k/mac.c
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.h'
> error: Failed to merge in the changes.
> Patch failed at 0002 wifi: ath12k: fix handling of CSA offsets in beacon template command
> 

Sure will rebase and send next version.

-- 
Aditya

