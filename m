Return-Path: <linux-wireless+bounces-6269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AB48A3594
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2662F1F22A99
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A414EC60;
	Fri, 12 Apr 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JlzrxUr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271114EC59
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946293; cv=none; b=XFaW/H6mdTECEQCI4Sz7I5kezg191uqxXhblZblODpLPVNZuzGw6OS6VVJz4hdk5OSE58iwWgCZl6Ff2cLvhOliSj5QvanXsFw17rdc7JBpFgkn80zg+FGP4a1PM2OZWSIZ2uSklm/n+Si6ghkkEKS5gH8MQ05HYDQB76EaSLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946293; c=relaxed/simple;
	bh=0Npk2kLtvZMTYscnRKNjVBIU6zpDC1W0G2MK7jB1FRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nBTG543klcQ25Zel4IQ2yk5ZNsoqfPoM60eciqxVlG7J74ULUhizO8RUuf5RARUs9KvqntO5VJkZ3mzHDs/SOTpWFCRgP01/sA7ZiV68BVWOFh6RqpRlkxcnrWBHfYU3hXHF6pKyscsu3VDcKgU4jo0cFjIWC8sQ5uoKZI8Y2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JlzrxUr8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CFtYTv018527;
	Fri, 12 Apr 2024 18:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=//sLiW85Bxfbd9zXPLVrEkOLmIb+H1h+50cHmXblS3c=; b=Jl
	zrxUr8vc1LNoA5bR/ZQ9iNUZSTj80zrCC5E8Zbthy/CPGgfV6bPPji3e1YXHslM2
	NjaEQ1kLTxFARxxScZaGPu9KdvjCsdQUVWYJmnnSAsKgYycwC8lxeTCY/83eCtDk
	eFV8QKTRG0sz/2youV27MmeSVG4vH6zHhRspWvzdYmKyAS1EoOL+C2xm99OPvM5b
	KTWfpkekFFpFWPJPHg5taf/VEuDw2bpydLCafdLi/R2GYTT02NuJe51gHEVs59Lu
	UR5VwOZ/SQN+rGrjARks9UC1IndvTex09BT7nUKpzd4MlOG9q/HMnMbUH0OI44Al
	pwGpqn+XFYa/ToaliQqQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xesjbt7qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 18:24:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CIOkpN028816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 18:24:46 GMT
Received: from [10.110.61.220] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 11:24:46 -0700
Message-ID: <8122e56b-1e57-4501-8180-24a65247465f@quicinc.com>
Date: Fri, 12 Apr 2024 11:24:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: ath12k: rearrange IRQ enable/disable in reset
 path
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-2-quic_bqiang@quicinc.com>
From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
In-Reply-To: <20240412060620.27519-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YPAWdO0wpHDRN3Zfm3pPmV7Ghe6Tqld8
X-Proofpoint-GUID: YPAWdO0wpHDRN3Zfm3pPmV7Ghe6Tqld8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=931 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120136



On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> For non-WoW suspend/resume, ath12k host powers down whole hardware
> when suspend and powers up it when resume, the code path it goes
> through is very like the ath12k reset logic.
> 
> In order to reuse that logic, rearrange IRQ handling in the reset
> path.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 3c522a4b3e9b..28663cf4db30 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -879,9 +879,8 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
>   	int ret;
>   
>   	mutex_lock(&ab->core_lock);
> -	ath12k_hif_irq_disable(ab);
>   	ath12k_dp_pdev_free(ab);
> -	ath12k_hif_stop(ab);
> +	ath12k_ce_cleanup_pipes(ab);
>   	ath12k_wmi_detach(ab);
>   	ath12k_dp_rx_pdev_reo_cleanup(ab);
>   	mutex_unlock(&ab->core_lock);
> @@ -1136,6 +1135,9 @@ static void ath12k_core_reset(struct work_struct *work)
>   	time_left = wait_for_completion_timeout(&ab->recovery_start,
>   						ATH12K_RECOVER_START_TIMEOUT_HZ);
>   
> +	ath12k_hif_irq_disable(ab);
> +	ath12k_hif_ce_irq_disable(ab);
> +

This core reset is called due to a fatal error. In case of an unlikely 
scenario, when there are consecutive fatal errors notification before 
the first fatal error is handled, then we will be disabling same irqs 
again. Shall we have a check here to see if ab's already in reset using 
ab->is_reset.

>   	ath12k_hif_power_down(ab);
>   	ath12k_qmi_free_resource(ab);
>   	ath12k_hif_power_up(ab);

