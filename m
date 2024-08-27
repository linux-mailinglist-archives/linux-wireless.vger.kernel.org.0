Return-Path: <linux-wireless+bounces-12092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D996170F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 20:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D292888C1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5EB1CC170;
	Tue, 27 Aug 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fBCJXikb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39E7D405
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783769; cv=none; b=gFYg+wiFRL71sNPLzIaGjRMiOXwYT5tfSoxLOhh/BV/8WljQ5V1eDR3D9TYvtddXSbq57m8rfUpCe3m7FKtNgru7y9f83MSFWtJirnQPNKoW6aJIoMtpArU6MBI4tPxkMOehSSRPcJ+flHezGAUs8uEDoXAU2/GlwF8DYBEUpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783769; c=relaxed/simple;
	bh=wLmYdRTDwg6pHN7oMlJJtw6MDxRw9jt/JfswmJnQbuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tio9ANLhghLpNDQE0Y7WkC6vG6tDOzndMcYrS8mOr/igrw+JJkRvMhHq2ldJ8D7Wg9/ht4cSXlb5OaRzoZgEaXmvn/jlXvaSeBGpcG4mWSZGvWEIVQnGVDMawtEXDaSZ/pb/X//JfVbeyavj0haIYj3g9adRZ/jGt3nFaxtdEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fBCJXikb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RHE68i023225;
	Tue, 27 Aug 2024 18:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r2b2DewcXT6KbuAgMJahq33ZA3zaeLm/CBIEw0g+cGE=; b=fBCJXikb2MJbe4vT
	Z4KmMXSwb34xxIPsLE5Jm8LchOzLtcmFcs7b7zhambbEchYJ9hn+80rs9mkdi9Lm
	quS/96pYC2NlYYyNmjlXt/bFHDOpyltfx0zFD06bSufRPmuO/nq9QYwHH6m/7hQy
	JSjopGAI7zoBh1iCqcDMNMRORsQhzQi//VnCG7Ee6bQ4a9zx/O6q8vWavRwUa+ci
	fFAUVkkyaM1YiTpBGqBXuc005XkHxBZzyExc9yFDNrIcvMOv1PodTVMSnN3YL1/N
	ucInuT7Zj+tDdiagoMYcZnudRmzJleIwIYkfa0u67/T0KYL/U6pMazjPSnEZ0PZJ
	wEJ+7Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41798100pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 18:36:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RIa1De028252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 18:36:01 GMT
Received: from [10.111.180.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 11:36:00 -0700
Message-ID: <659cce3b-f92f-4d2d-bc9e-d2247addb0b4@quicinc.com>
Date: Tue, 27 Aug 2024 11:35:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Fix double free issue during SRNG deinit
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty
	<quic_mpubbise@quicinc.com>
References: <20240826053326.8878-1-quic_bpothuno@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240826053326.8878-1-quic_bpothuno@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ntuA0-O1BmUZa2K606GPTKO8cYb2gtBe
X-Proofpoint-ORIG-GUID: ntuA0-O1BmUZa2K606GPTKO8cYb2gtBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=822 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270139

On 8/25/2024 10:33 PM, Balaji Pothunoori wrote:
> From: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> Currently struct ath11k_hal::srng_config pointer is not assigned
> to NULL after freeing the memory in ath11k_hal_srng_deinit().
> This could lead to double free issue in a scenario where
> ath11k_hal_srng_deinit() is invoked back to back.
> 
> In the current code, although the chances are very low, the above
> said scenario could happen when hardware recovery has failed and
> then there is another FW assert where ath11k_hal_srng_deinit() is
> invoked once again as part of recovery.
> 
> Fix this by assigning the struct ath11k_hal::srng_config pointer
> to NULL after freeing the memory.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> ---
> Resending the original patch as standalone patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20230417054145.12359-2-quic_mpubbise@quicinc.com/
> 
>  drivers/net/wireless/ath/ath11k/hal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index f02599bd1c36..61f4b6dd5380 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1351,6 +1351,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  	ath11k_hal_free_cont_rdp(ab);
>  	ath11k_hal_free_cont_wrp(ab);
>  	kfree(hal->srng_config);
> +	hal->srng_config = NULL;
>  }
>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


