Return-Path: <linux-wireless+bounces-8011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52108CD43F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD941C20B41
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4706514830E;
	Thu, 23 May 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4idvlyW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D014A0A9
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470575; cv=none; b=fL524Ru6i5+roILchnLs1g40K2hbTvhe0ws2K4PML9TjhJaMwBBee8jJzEeSB23MlhlctdfC7CGKFP/cMFVi8b3o1u1p4q70iFMpHQWstiSWV3j0E6UV0e1i+QjtQXf+KfcAH3D0wPBqaoQr8xDaTw56k/Z+9sozHJ91fV+rI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470575; c=relaxed/simple;
	bh=awXgn97k/Jzyo1Mu5hBUCfyrDHou+X4Jq8qgFF8ackw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e5MEslKuXE02GIoEBvEx9y+m9shoX3JIXofFgjssKU80CStRK59dVz1HZOBxm6+9KmiVcpbYIXbSrbFyVI8ZXyUarqehSB7uUjko+ZhGn9rxFlPpTPPfXyS9MJMj66ihXUMVXKLG1PlUXoM+PDGyXNp8qi/KdTms4iA/LVy52Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c4idvlyW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4jTVc010543;
	Thu, 23 May 2024 13:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	blURCmU04AaYllZh5ZopH5oqpVdNY0UpaU9BsvQVE8s=; b=c4idvlyW8xrth78i
	o6wlDt4X7lBM+wM8mN4bk9VFXEVOQPPjp0RX2Hcn24VjC2ISEf7WwZCHHQoNG2k/
	vTEnP/68wTqgftTwDUF+cgRsf0jl39I7WqCT0t6tGEF3TWrPXvT/cA0kAS38NnJh
	EJTGDaL5WrhSDCVPrYUl+CbX/7AgcIUF0qxatvYnP7KCaQBf1Z9Rxg2TQzjyCmZA
	NJudH+yeU20JDEcydiGa47RCr6RnyItvcbkHIMOw4fJzJeIrLS5Rq3jgRhT1dmBk
	kHPhhAdYhXkxI23h8J+3y3yHSSUf78P8wglJ/dRNgIMzFuWnkE4qvYba69wYo7J6
	5VENkA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y9y29s6d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:22:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NDMkpB010710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:22:46 GMT
Received: from [10.50.62.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 06:22:44 -0700
Message-ID: <cc0f9850-f323-95ab-7dd8-9be28bf7ee53@quicinc.com>
Date: Thu, 23 May 2024 18:52:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] wifi: ath12k: improve the rx descriptor error
 information
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
 <20240516000807.1704913-3-quic_periyasa@quicinc.com>
 <87a5kgbrcq.fsf@kernel.org>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87a5kgbrcq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 96ok3QNy3RwX2hGKVnvkelRu9-YQzJky
X-Proofpoint-GUID: 96ok3QNy3RwX2hGKVnvkelRu9-YQzJky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_08,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=501
 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405230092



On 5/23/2024 6:46 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> The ath12k_dp_get_rx_desc() failure log currently contains the same
>> information across multiple Rx data paths and lacks sufficient detail for
>> debugging purposes. To address this, change the ath12k_dp_get_rx_desc()
>> failure log to include cookie information along with Rx path details.
>> This will provide more specific data for debugging purposes.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_rx.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> index 37205e894afe..85ce6e840efa 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> @@ -2625,7 +2625,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>>   		if (!desc_info) {
>>   			desc_info = ath12k_dp_get_rx_desc(ab, cookie);
>>   			if (!desc_info) {
>> -				ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
>> +				ath12k_warn(ab, "Rx, invalid cookie 0x%x\n", cookie);
>>   				continue;
>>   			}
>>   		}
>> @@ -3323,7 +3323,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
>>   	if (!desc_info) {
>>   		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
>>   		if (!desc_info) {
>> -			ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
>> +			ath12k_warn(ab, "Rx Exception, invalid cookie 0x%x\n", cookie);
>>   			return -EINVAL;
>>   		}
>>   	}
>> @@ -3742,7 +3742,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>>   		if (!desc_info) {
>>   			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
>>   			if (!desc_info) {
>> -				ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
>> +				ath12k_warn(ab, "WBM Rx err, invalid cookie 0x%x\n",
>> +					    err_info.cookie);
>>   				continue;
>>   			}
>>   		}
> 
> In the error messages please try to use full english sentences to make
> them at somehow useful to users. I tried add those now, please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4033754ea78119ede328f09005b8ae1e9dd3f4f2
> 

Agree. Looks fine to me.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

