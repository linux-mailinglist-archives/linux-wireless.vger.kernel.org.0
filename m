Return-Path: <linux-wireless+bounces-18106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B55AA21782
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9233E166CE5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 05:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092B188734;
	Wed, 29 Jan 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ei1I0nAj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698715672
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129824; cv=none; b=EtL66aubuy+GOjYAY7AtxNWAAn6DqTOJR/IOZ1K0MnMJz34HyVqZuRtK5FDn6hPXxJeNGPJ8/KLxvQ8f2XpdDSsYNHX0eIW9Q6bxteYqadFObDLkAbuWIxIMU+1If9Idd7YzXEsodL76KvenC5Xoif7Ao0SP1tI7xLEvHAGyZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129824; c=relaxed/simple;
	bh=otCy4AY0W3gEhNgUzZwpeHHm5lqfwsCvlphW0df+hIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pm6hDWZjWZ/iRsZCpkbqb0o+QZ66kHRFfsw5alFxexrJdXvGalL/IvF0snEO0HlIQxKmU+Kwre/85GN8jBxJB3twyzuePr3DPpEfqcFGB47hJdBacIXst9QqFZgVRl3GG4JQdwKDJb5jLq3p9+fWtB2wib0OFrj38e3Q+kQax14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ei1I0nAj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2ha6Z026942;
	Wed, 29 Jan 2025 05:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EuUFbz6MWAuzPiQlUN5eRDC2c+Sz2Yd2y0bTiLVfMXI=; b=Ei1I0nAjVKtCC+Rq
	BeFQ1n0+yKeq6LDoLp/vqgW6UWRQ0khJZVZJazxjsmeJg0OcieNERh2VNXvM7vfC
	YmQH0XhEfYAzp3CDUb9EoFlkppN1QG0SKR3MePCmYKE8JbNiJO8+CbQj7roPeyDO
	wRWbQNYW8SxdOqD4FtWe0MR9DAiJvhSMSq2xCo4K7DoXNMNlFFolNnOxblwTi3HX
	lLmrduYUPD2xctTsMgiX00fS8oD3+BhSFRtu4hqk25hT2r+PFEDt80NKJbR+XcPT
	uSQPajzk7KhMXlNs6T33X7cjOKOw9hW6R3E5hYvjl8QeTYVZHrSgDF43CkgglMG8
	0CPB3g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f54dh08d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:50:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T5oJpI028966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:50:19 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 21:50:17 -0800
Message-ID: <36787108-7a88-42d2-8e5b-0001ebf2a2d2@quicinc.com>
Date: Wed, 29 Jan 2025 11:20:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 7/9] wifi: ath12k: Add EHT MCS support in Extended Rx
 statistics
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan Mahalingam
	<quic_bmahalin@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-8-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127104738.4174862-8-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wg6JnVXl_CXV5ueXdPnpviimMx-Gd47r
X-Proofpoint-ORIG-GUID: Wg6JnVXl_CXV5ueXdPnpviimMx-Gd47r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=995
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290046



On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
> From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> 
> Currently, EHT MCS information is not populated. Therefore, add the EHT
> MCS counter array to the peer rate statistics and update the EHT MCS
> statistics from the status TLV data in the monitor Rx path. In the future,
> this information will be used in the peer extended Rx statistics dump.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h   | 2 ++
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 28db100cfac0..2c9c62cb1af5 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -357,6 +357,7 @@ struct ath12k_vif_iter {
>   #define HAL_RX_MAX_MCS_HT	31
>   #define HAL_RX_MAX_MCS_VHT	9
>   #define HAL_RX_MAX_MCS_HE	11
> +#define HAL_RX_MAX_MCS_BE	15
>   #define HAL_RX_MAX_NSS		8
>   #define HAL_RX_MAX_NUM_LEGACY_RATES 12
>   #define ATH12K_RX_RATE_TABLE_11AX_NUM	576
> @@ -366,6 +367,7 @@ struct ath12k_rx_peer_rate_stats {
>   	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
>   	u64 vht_mcs_count[HAL_RX_MAX_MCS_VHT + 1];
>   	u64 he_mcs_count[HAL_RX_MAX_MCS_HE + 1];
> +	u64 be_mcs_count[HAL_RX_MAX_MCS_BE + 1];
>   	u64 nss_count[HAL_RX_MAX_NSS];
>   	u64 bw_count[HAL_RX_BW_MAX];
>   	u64 gi_count[HAL_RX_GI_MAX];
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 6ba2f0fa39c1..dae430ee3c19 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -3059,6 +3059,12 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
>   		rx_stats->byte_stats.he_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
>   	}
>   
> +	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11BE &&
> +	    ppdu_info->mcs <= HAL_RX_MAX_MCS_BE) {
> +		rx_stats->pkt_stats.be_mcs_count[ppdu_info->mcs] += num_msdu;
> +		rx_stats->byte_stats.be_mcs_count[ppdu_info->mcs] += ppdu_info->mpdu_len;
> +	}
> +
>   	if ((ppdu_info->preamble_type == HAL_RX_PREAMBLE_11A ||
>   	     ppdu_info->preamble_type == HAL_RX_PREAMBLE_11B) &&
>   	     ppdu_info->rate < HAL_RX_LEGACY_RATE_INVALID) {

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

