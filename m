Return-Path: <linux-wireless+bounces-7030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9298B6C01
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C991F225A4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1C179A7;
	Tue, 30 Apr 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h8EGiuqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59D211C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462959; cv=none; b=a83w0m2BOyUDUHbThmPejRjGDF1z2bhr7E4zD1KbgJFREiSTYBH6PigHwzPs2mKo/M9FAA34CD16JGRr2okm1+vjQOCAUCzp10vUTWrJBaF8FrJ/gG3ZbyMmjZxTFdAwQ9RhnHGkdgUduTrQoItYi8LxJYYEjm4eLMYlhCFJkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462959; c=relaxed/simple;
	bh=zZP+larKlWgQAYDSWMCVCiXuMGZF4xtPCRBztubuV7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eDkOgndo7tjrcH3ioKAaF4W6PhMHjUdJ3GQOTWg+xMOyVaOPBVhUgVgwVYby3vqiwbaNNBoycXivm5bLkme/ov9s7ffzjA85j8ysMb74RoY8JkaNKDQaAk5dg/rIXp3aPpVt+TKF/+DxgldcV0jhrVtR9qwKjm/MVDkdDPiEa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h8EGiuqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U7CMH2006602;
	Tue, 30 Apr 2024 07:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GSJXyLojc95CzlRegySG57zpsU09ycjRFGSiB4YgGH8=; b=h8
	EGiuqC36/gPUEemVrOUrwisrgrDM9EEYnuxlF7S3xO4jVx/gB0u3Y4RucJpCas1l
	jQjdAinF7l+5bG2F7C1ofEBRKo+ybhV+P3LsjobGyRHghcMfp1g81r3ljX85RcqV
	b3QQKyWRA0QCcziOEXzmoOwOd5MBwWEJjQg8wz91aiSx2DfOGYoSYsGr+PXmI40B
	ELGMF0yd751Fx7DS55KLun5zQQ2eMln4ZcRAUT+EyZwTd6IYh6lN3GeyM8eEK+o/
	uGa9N1+h+v7xxx4gz/AWa7dir+iw4KFGPW6DRUs9l9jaxluMEVLq09aBk/LWb8V6
	BAE7lWUB/zdi14sYEnvA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtv1hr20w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:42:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U7gUpI018029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:42:30 GMT
Received: from [10.151.40.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 00:42:29 -0700
Message-ID: <e7d71f62-9de1-413f-9695-96aa490daf63@quicinc.com>
Date: Tue, 30 Apr 2024 13:12:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] wifi: ath12k: drop failed transmitted frames from
 metric calculation
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429114841.413901-1-quic_kathirve@quicinc.com>
 <e1d428ee-0a16-4fc6-be0b-4c41036ff919@quicinc.com>
Content-Language: en-US
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
In-Reply-To: <e1d428ee-0a16-4fc6-be0b-4c41036ff919@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wKG-tLe4c69ARYUve4t-GjdCeokUSn97
X-Proofpoint-ORIG-GUID: wKG-tLe4c69ARYUve4t-GjdCeokUSn97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300055



On 4/30/2024 12:16 AM, Jeff Johnson wrote:
> On 4/29/2024 4:48 AM, Karthikeyan Kathirvel wrote:
>> - Use ieee80211_free_txskb() instead of dev_kfree_skb_any().
>> - Drop failed transmitted frames from mesh metric calculation to avoid
>> false link metric averaging.
>>
>> Karthikeyan Kathirvel (1):
>>    wifi: ath12k: drop failed transmitted frames from metric calculation.
>>
>> Sven Eckelmann (1):
>>    wifi: ath12k: Don't drop tx_status in failure case
>>
>>   drivers/net/wireless/ath/ath12k/dp_tx.c    | 43 ++++++++++++++++------
>>   drivers/net/wireless/ath/ath12k/hal_desc.h | 22 ++++++++++-
>>   2 files changed, 52 insertions(+), 13 deletions(-)
>>
>>
>> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
> 
> 'b4' is barfing on this series since you posted 3 patches instead of 2:
> [PATCH v3 1/2] wifi: ath12k: Don't drop tx_status in failure case
> [PATCH v3 1/2] wifi: ath12k: Don't drop tx_status when peer cannot be found
> [PATCH v3 2/2] wifi: ath12k: drop failed transmitted frames from metric calculation.
> 
> Why are there two different 1/2 patches?
Uploaded an invalid patch by mistake, have removed it in next version v4 
and also replaced a dev_kfree_skb_any() by ieee80211_free_txskb() in 
ath12k_dp_tx_free_txbuf(),

