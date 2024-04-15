Return-Path: <linux-wireless+bounces-6298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B463D8A479F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 07:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEA11F21CE8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 05:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB24C9D;
	Mon, 15 Apr 2024 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kJ+Jm/7D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF454C8D
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159544; cv=none; b=Whc4UULhg3M1nNbZAz121ouYqcAV3Jlf4SgOZ7GFpoRD/R5a8MTyWE059jFf65Jwkfwo6dCocQjZ3HWD88pvPEMvtSIyfemW4Rj8XaF0rT9IhxtcS9fFHvhcjrhmxevtSt6vPMOABFz0JomdS/EE3GaptTJ0EKHcbvbskS/md5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159544; c=relaxed/simple;
	bh=xbJRVzshDTlJPZXXMbD6l1MEjVz57vvVVmYD4/etTsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t6YtoYn+M2qyiBI2hIgRDj0noXAhE02sA9AmHq4V0B9BIwQ7IiEGmVswB1iOrGL0BorXsfCQQwESFvCYanKHgWsGifRlAQswKvlVBQGKUiuzYCM0KTqqE2AbLHe5RaLTg3KGKs55ZnIoS8Mpdh0eokrt7JIYdDupPmqVHRPMQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kJ+Jm/7D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F4xx9x031087;
	Mon, 15 Apr 2024 05:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+O4aGNZrgTZjT0aCMHZbL1/O99msD2nnQ5tuUHcX1u4=; b=kJ
	+Jm/7DVRiVLEVUSEwdSlYiWpspzT6fvQKFCbOZdjDPj9YGNfVi4ALRaUENq+31gv
	J6zx3a3Rbb4udYnuH5HCLt1vCI6TXZfYfNvXenwK5keH+8pwx1fDDgcIBH90rpcV
	Y79h21rXoGUWZVmyOOYtL4LVgngYAsInzUABPN/5+4G1lyv6mrAJdy0FRm/3f/HI
	cJu8AEnLGsAggri85BAVVVIjVWYciCxjjoA42CdnI0ahPKrtZ6KosgzyeCmHgq77
	4i+/twzg/sNM273C3z7J8xgQkK9p4X51sR/QBBu5Ox1ywlnKwQmASGbTYBgBAkRN
	iEZWn+57WK+vPUQpvGtQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xggvgrvw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:38:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43F5cqNA018912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 05:38:52 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Apr
 2024 22:38:50 -0700
Message-ID: <ae78bdad-6f6b-8d8e-c324-7dc990895e9f@quicinc.com>
Date: Mon, 15 Apr 2024 13:38:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 01/10] wifi: ath12k: rearrange IRQ enable/disable in reset
 path
Content-Language: en-US
To: Sidhanta Sahu <quic_sidhanta@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-2-quic_bqiang@quicinc.com>
 <8122e56b-1e57-4501-8180-24a65247465f@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <8122e56b-1e57-4501-8180-24a65247465f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fLjXPDIzUIktC-wk4xrA8K2LHGf7EBc_
X-Proofpoint-ORIG-GUID: fLjXPDIzUIktC-wk4xrA8K2LHGf7EBc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=889 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150034


On 4/13/2024 2:24 AM, Sidhanta Sahu wrote:
>
>
> On 4/11/2024 11:06 PM, Baochen Qiang wrote:
>> For non-WoW suspend/resume, ath12k host powers down whole hardware
>> when suspend and powers up it when resume, the code path it goes
>> through is very like the ath12k reset logic.
>>
>> In order to reuse that logic, rearrange IRQ handling in the reset
>> path.
>>
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c 
>> b/drivers/net/wireless/ath/ath12k/core.c
>> index 3c522a4b3e9b..28663cf4db30 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -879,9 +879,8 @@ static int 
>> ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
>>       int ret;
>>         mutex_lock(&ab->core_lock);
>> -    ath12k_hif_irq_disable(ab);
>>       ath12k_dp_pdev_free(ab);
>> -    ath12k_hif_stop(ab);
>> +    ath12k_ce_cleanup_pipes(ab);
>>       ath12k_wmi_detach(ab);
>>       ath12k_dp_rx_pdev_reo_cleanup(ab);
>>       mutex_unlock(&ab->core_lock);
>> @@ -1136,6 +1135,9 @@ static void ath12k_core_reset(struct 
>> work_struct *work)
>>       time_left = wait_for_completion_timeout(&ab->recovery_start,
>>                           ATH12K_RECOVER_START_TIMEOUT_HZ);
>>   +    ath12k_hif_irq_disable(ab);
>> +    ath12k_hif_ce_irq_disable(ab);
>> +
>
> This core reset is called due to a fatal error. In case of an unlikely 
> scenario, when there are consecutive fatal errors notification before 
> the first fatal error is handled, then we will be disabling same irqs 
> again. Shall we have a check here to see if ab's already in reset 
> using ab->is_reset.
There is similar logic using ab->reset_count in ath12k_core_reset().
>
>>       ath12k_hif_power_down(ab);
>>       ath12k_qmi_free_resource(ab);
>>       ath12k_hif_power_up(ab);

