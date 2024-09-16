Return-Path: <linux-wireless+bounces-12894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB897A4CB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4781C21021
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B7149C57;
	Mon, 16 Sep 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aV5NxeJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754C1D554
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499174; cv=none; b=PL2TEMEpvJjKZVpifBhR6inXxx3mRZD8I01XZtCECTpUScMA0pc9gRd/A5oVHQgroQu539QQNcmaDm8Ev7IZuJkjg//W/lUdN3fREHkBIKK7CzjlAq+VQ9wkkHuVZLv9koTSqGkXETyOgia9235cjHlAMB0V/FY2StYXrsQaBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499174; c=relaxed/simple;
	bh=am/nC9J+8koHFaMZT1M+8BpLeTKQBlNjw+oV1d5Kfl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uUheQhPWNO40Vdjyky8Txk0SZSUH77LgTfhCD+UTgOLrEifpJgsgdhubl051uOlGP7ue0ZBJXnlEt5hYqpXaOSrlFULX40/xVD8TEac/7bYTaHR0eF1KbWAnPUcghmAC0JDcxUVyrVOn0Pcrb5ROtHRDGa6Xbub+vbSVkwcT3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aV5NxeJI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDTFQ1022178;
	Mon, 16 Sep 2024 15:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8XaacXL4gc8yj3nFhtHE/AqAWEIdSMrF711W/iV5K1Q=; b=aV5NxeJIOD0DDDNU
	GdggCwY/2XiP+NEZRyzNZ4SLodxZg7jT6AMYepkRd4+rps5f12Y7pkkyTdFjRHgg
	FisnC82y0F5AJDsFsjS9Dcm9Zg4gDpT82zGDJ1L7b8mYon7Pwq94pT6Fm473TjFq
	DjgIsUct3vgkCQ5GGewWZSDq/C5VnRx2Tg07+o/5NBM/qeG/GMxvliuSOOn4vvZN
	jEtAskfsG1B6ofelfIkQ+Lg3lN7LBFvNHZf2hFgfdqOkYAG1Pin9rmsaI8XVgiA7
	CDFxl4hH7d42tAQJqjyRSHzquzNkyRvUI5h/dVCGz6gm/XhZ6NmHCOPZnRsaqL+2
	8JtrJA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdmaeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 15:06:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48GF65OO017869
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 15:06:05 GMT
Received: from [10.111.182.118] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Sep
 2024 08:06:04 -0700
Message-ID: <11adb626-fc7b-46f1-a3eb-602731e3ea9e@quicinc.com>
Date: Mon, 16 Sep 2024 08:06:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: fix RCU stall while reaping monitor
 destination ring
To: Kang Yang <quic_kangyang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240913100708.756-1-quic_kangyang@quicinc.com>
 <20240913100708.756-2-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240913100708.756-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XPMpYmHvI4R5WpuVlcK_OgC62cm-xkGy
X-Proofpoint-GUID: XPMpYmHvI4R5WpuVlcK_OgC62cm-xkGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160097

On 9/13/2024 3:07 AM, Kang Yang wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> While processing the monitor destination ring, MSDUs are reaped from the
> link descriptor based on the corresponding buf_id.
> 
> However, sometimes the driver cannot obtain a valid buffer corresponding
> to the buf_id received from the hardware. This causes an infinite loop
> in the  the link descriptor based on the corresponding buf_id. However,
> sometimes the driver cannot obtain a valid buffer corresponding to the
> buf_id received from the hardware. This causes an infinite loop in the
> destination processing, resulting in a kernel crash.

there is replicated text above, remove:
> ...     the link descriptor based on the corresponding buf_id. However,
> sometimes the driver cannot obtain a valid buffer corresponding to the
> buf_id received from the hardware. This causes an infinite loop in the

> 
> kernel log:
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> ath11k_pci 0000:58:00.0: data msdu_pop: invalid buf_id 309
> ath11k_pci 0000:58:00.0: data dp_rx_monitor_link_desc_return failed
> ……
> 
> Fix this by skipping the problematic buf_id and reaping the next entry,
> replacing the break with the next MSDU processing.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index c087d8a0f5b2..072963d3396c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -4781,7 +4781,7 @@ ath11k_dp_rx_mon_mpdu_pop(struct ath11k *ar, int mac_id,
>  			if (!msdu) {
>  				ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
>  					   "msdu_pop: invalid buf_id %d\n", buf_id);
> -				break;
> +				goto next_msdu;
>  			}
>  			rxcb = ATH11K_SKB_RXCB(msdu);
>  			if (!rxcb->unmapped) {
> @@ -5405,7 +5405,7 @@ ath11k_dp_rx_full_mon_mpdu_pop(struct ath11k *ar,
>  					   "full mon msdu_pop: invalid buf_id %d\n",
>  					    buf_id);
>  				spin_unlock_bh(&rx_ring->idr_lock);
> -				break;
> +				goto next_msdu;
>  			}
>  			idr_remove(&rx_ring->bufs_idr, buf_id);
>  			spin_unlock_bh(&rx_ring->idr_lock);


