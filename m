Return-Path: <linux-wireless+bounces-24567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B3AEA454
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAA11C43BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EF1E008B;
	Thu, 26 Jun 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIRHNqra"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D978F2F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958424; cv=none; b=Z82H8vO+BiAmphxUHY1q8/vxXPQfZhu/oH9PnEc5G2SuBfVO3w+m4nQ2sKOCEKjfKEqAWHK50YTJH5VzvOFE36E3em/3fDAEXAtnFmMrj5BhkeBqdLAz9vphsa0Ar5Znk4e1yR0nCFICIdmFpBBg8ugXIKok1TMqrCv8s6D5Cr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958424; c=relaxed/simple;
	bh=yNaJo5vCQWaeAa9ZjAe14l3Vb9hvpNdtBsOt9++GcAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbkTMxA1XvRmVMMUt4xul44+vTQz/vjyWqqSwTUjVIv7b7/f2nbHmIcmbTJQtJ2h8dGLaOro3mwKQea8RKT+FepqY48nqZ1dJmtpI3eycsiuwnIcZ1mhFyFkNE2neanru7Jy4aoe9EaZLECL6RUISdnEc6efyuyDCSqCxf5wP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIRHNqra; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9l8VP022397
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jggvEgShZvAn4Cqf9psRUvQ3PIp0OoDumXSKGW91EpY=; b=mIRHNqraNfzYkw9y
	hipHivzgbFIQmR+d/0WzOeg/3Ka2aAID5ZYudGMd3QFe38mVp9aY2SWnQPMEYzjd
	yo9s7iuu9CrIenkNZnpITOa7LgIj0EML7SlC9k+8ha4A0R3S4q/PAx27F5pvd3hc
	23e1iGSOkp3HPW246J3mVEuLqw0/2X8I9Vx5hbh1TVXSOkgHfWkfZBeJqdke592f
	oT1h3O97PAOm49CLxGgB8fi4WG1cCbOFlzb+FooPo13vUEZ/MVzIwFZWQOPJDzSF
	yMiMI56vHxrEMSWiTtAxqCSpNUZ9p2mAZ7tZAH5AZuHvws2OaoPLnj+SDtGD4Bqk
	zr1CQw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx2e4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 17:20:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so1079188a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750958420; x=1751563220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jggvEgShZvAn4Cqf9psRUvQ3PIp0OoDumXSKGW91EpY=;
        b=fZQPX4l1DrTTAh8SZLqxu/eeG0K0/T0tm/o6QMP34b75SDOdD0GOExHqCPtyr6VBup
         ZfCXbgZIhRbf+6TKZzNAyJRaSU+kSv08P0gEjU2UWOnwPvABMxfgIFNAJm/RQBllKm3x
         Gy2gm5vgHLwueNwDfM0e1o5mhdwGwcFXH3UR1DI1BqlOi5YAWPow3VfdnHU5ZOJ5Tude
         tvCrZsmshbvf2dPwKcbaAJoUugJR5vSIdrzOz9IsbnEHaR4Rno2En3a3piu3KibvCqXB
         DbO5gN469NHqOh9weQyAqPOUhsgx28lmuByuyl3Y8sxYRm3LgvBrEj9C9IWgvoTfnTw5
         mpdg==
X-Gm-Message-State: AOJu0Yx5SgDlfEVnuJf4fjPyQaehOlrMEOsgkqWtkLtGKpl9L11c09eu
	6ADOlnZF1Xe3j2xk51QkVDPNTFkUG2f3a179xwu1CelHDMolm86R9HyCmpx9+vS462UkAquaEWv
	SuTNfz/XORhFr0llKhtZqQisITT7xxfwSnzvpQsL1tSt/Cv76ZBbJGEgYLmTJj1vIpf973w==
X-Gm-Gg: ASbGncvZQeuSjGdSIJn6azmZDWqczmu0sKHBFt9L1Eofsk+3s6mHl8brxeN2X/1zaWR
	KJt3LzaCw89SchyID4fu1AJjEqoatkFhEJzI/yD0qzK/U+1GJcPLLfXAChjlkTwNnVQhOjlu6xN
	3iRLIplf07CSeFC4lXp6i9ub9DFYwrLPUJfMa+avDJcCbqdhyTcnjj6LOFlr1+baThSrftHG4FN
	tK00zveGNQPtcYCzZR5AFSHg9CKWiSTyJJ/Uh063VnfsmJYIP0OUbJJ01GGOxdmGkfiUzp7MV3g
	yyYL2aX74lm+OD31Xswsga2KwV2/tDtbisDJrt3GkBKnuN2uWjQBomgnnRWtJBsRNl7x5ko=
X-Received: by 2002:a17:90a:e7c5:b0:312:1ae9:1525 with SMTP id 98e67ed59e1d1-315f2618a33mr11268614a91.8.1750958419545;
        Thu, 26 Jun 2025 10:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3eHVSMgHc2c7xL29VM30acVIpsENwZIoithz9s6fOc8gnX2qHmSZt/Ved6xEHjnhTvaEj5w==
X-Received: by 2002:a17:90a:e7c5:b0:312:1ae9:1525 with SMTP id 98e67ed59e1d1-315f2618a33mr11268578a91.8.1750958419038;
        Thu, 26 Jun 2025 10:20:19 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.255.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c1392241sm295257a91.7.2025.06.26.10.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:20:18 -0700 (PDT)
Message-ID: <6b32c871-0d18-4cdd-e097-97fc2e7bdf28@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 22:50:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Add support for transmit
 histogram stats
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Saleemuddin Shaik <quic_saleemud@quicinc.com>
References: <20250617112139.865788-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250617112139.865788-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EwzOfFQuk7PL7RDvoVpLwPkvkU5em6gJ
X-Proofpoint-ORIG-GUID: EwzOfFQuk7PL7RDvoVpLwPkvkU5em6gJ
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685d8155 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=/xG1ZwzdjF5UbGEDupzz2A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=RlH2pxoSYRL9L7z1OqAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE0OCBTYWx0ZWRfXwbqYrccfW11h
 VirGIyarMjziI+BRZvdTQ94/AfJOLMFZML1wlXF8abGnaxEytn49MTQEk2nzoICpU+/yx2aI9WL
 /9meRmMteXFV0EQ1uS+kzAs2ouAiNc3KcwnCuMZKNdo7YjkDyrlR0gHWENyqrGa02RKU9he80Ds
 4qyBjHdIsW9i1Y+Fed0fPe6iKrlPOecS2qtdAkHwrnhG6txCRqn92er1Arp/CNNIqinICZQK5Ii
 OfYBZwhFlseAFMAFhVU9b4+aBMvWUZj8XP/JL1o5inuEguvVuQSfBCU5U5LcHsqxErUc8ityzGz
 RBP8tTGoG4T0oiICLGmGjtyESJv0hsD2qD9Wh4fPrHnh5TFCLgweiVSSikpTWjPGtCqsswrjv/P
 Nc8XMwOXKKeZ5wZd7nPOHmze6G4WVEBUIplar2gX3OvoZVmnjhDvEreG2jfIARduRuy0ebV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260148



On 6/17/2025 4:51 PM, Roopni Devanathan wrote:
> From: Saleemuddin Shaik <quic_saleemud@quicinc.com>
> 
> Add support for transmit histogram stats under HTT stats type 9. These
> stats give information about drop count, MCS drop rate, histogram
> count, etc.
> 
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 does not support tag
> HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG(144), currently.
> 
> Sample output:
> echo 9 > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats
> ...
> low_latency_rate_cnt =  0
> su_burst_rate_drop_cnt = 0
> su_burst_rate_drop_fail_cnt = 0
> rate_retry_mcs_drop_cnt = 0
> 
> PER_HISTOGRAM_STATS
> mcs_drop_rate =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
> per_histogram_count =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
> 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0,
> 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0,
> 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0, 38:0, 39:0, 40:0,
> 41:0, 42:0, 43:0, 44:0, 45:0, 46:0, 47:0, 48:0, 49:0, 50:0,
> 51:0, 52:0, 53:0, 54:0, 55:0, 56:0, 57:0, 58:0, 59:0, 60:0,
> 61:0, 62:0, 63:0, 64:0, 65:0, 66:0, 67:0, 68:0, 69:0, 70:0,
> 71:0, 72:0, 73:0, 74:0, 75:0, 76:0, 77:0, 78:0, 79:0, 80:0,
> 81:0, 82:0, 83:0, 84:0, 85:0, 86:0, 87:0, 88:0, 89:0, 90:0,
> 91:0, 92:0, 93:0, 94:0, 95:0, 96:0, 97:0, 98:0, 99:0, 100:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Saleemuddin Shaik <quic_saleemud@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
> v2:
>   - Removed 'inline' keyword from function definition to resolve wifibot
>     error.
> ---
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 36 ++++++++++++++++++-
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 16 +++++++++
>   2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index aeaf970339d4..0da6c91dd314 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -4720,7 +4720,38 @@ ath12k_htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
>   	len += print_array_to_buf(buf, len, "tx_pream", htt_stats_buf->tx_pream,
>   				  ATH12K_HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
>   	len += print_array_to_buf(buf, len, "tx_dcm", htt_stats_buf->tx_dcm,
> -				  ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n");
> +				  ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n\n");
> +
> +	stats_req->buf_len = len;
> +}
> +
> +static void
> +ath12k_htt_print_histogram_stats_tlv(const void *tag_buf, u16 tag_len,
> +				     struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_tx_histogram_stats_tlv *stats_buf = tag_buf;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u32 len = stats_req->buf_len;
> +	u8 *buf = stats_req->buf;
> +
> +	if (tag_len < sizeof(*stats_buf))
> +		return;
> +
> +	len += scnprintf(buf + len, buf_len - len, "low_latency_rate_cnt =  %u\n",
> +			 le32_to_cpu(stats_buf->low_latency_rate_cnt));
> +	len += scnprintf(buf + len, buf_len - len, "su_burst_rate_drop_cnt = %u\n",
> +			 le32_to_cpu(stats_buf->su_burst_rate_drop_cnt));
> +	len += scnprintf(buf + len, buf_len - len, "su_burst_rate_drop_fail_cnt = %u\n",
> +			 le32_to_cpu(stats_buf->su_burst_rate_drop_fail_cnt));
> +	len += scnprintf(buf + len, buf_len - len, "rate_retry_mcs_drop_cnt = %u\n",
> +			 le32_to_cpu(stats_buf->rate_retry_mcs_drop_cnt));
> +
> +	len += scnprintf(buf + len, buf_len - len, "\nPER_HISTOGRAM_STATS\n");
> +	len += print_array_to_buf(buf, len, "mcs_drop_rate", stats_buf->mcs_drop_rate,
> +				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS, "\n");
> +	len += print_array_to_buf(buf, len, "per_histogram_count",
> +				  stats_buf->per_histogram_cnt,
> +				  ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS, "\n\n");
>   
>   	stats_req->buf_len = len;
>   }
> @@ -5277,6 +5308,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
>   	case HTT_STATS_TX_PDEV_RATE_STATS_TAG:
>   		ath12k_htt_print_tx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
>   		break;
> +	case HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG:
> +		ath12k_htt_print_histogram_stats_tlv(tag_buf, len, stats_req);
> +		break;
>   	case HTT_STATS_RX_PDEV_RATE_STATS_TAG:
>   		ath12k_htt_print_rx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
>   		break;
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> index c2a02cf8a38b..5fc5d8c00355 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> @@ -237,6 +237,7 @@ enum ath12k_dbg_htt_tlv_tag {
>   	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
>   	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
>   	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
> +	HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG		= 144,
>   	HTT_STATS_TXBF_OFDMA_AX_NDPA_STATS_TAG		= 147,
>   	HTT_STATS_TXBF_OFDMA_AX_NDP_STATS_TAG		= 148,
>   	HTT_STATS_TXBF_OFDMA_AX_BRP_STATS_TAG		= 149,
> @@ -418,6 +419,12 @@ struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv {
>   #define ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS   2
>   #define ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS  2
>   #define ATH12K_HTT_TX_PDEV_STATS_NUM_11AX_TRIGGER_TYPES   6
> +#define ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS	  101
> +
> +#define ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS \
> +	(ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS + \
> +	 ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS + \
> +	 ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS)
>   
>   struct ath12k_htt_tx_pdev_rate_stats_tlv {
>   	__le32 mac_id_word;
> @@ -472,6 +479,15 @@ struct ath12k_htt_tx_pdev_rate_stats_tlv {
>   	__le32 tx_bw_320mhz;
>   };
>   
> +struct ath12k_htt_tx_histogram_stats_tlv {
> +	__le32 rate_retry_mcs_drop_cnt;
> +	__le32 mcs_drop_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS];
> +	__le32 per_histogram_cnt[ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS];
> +	__le32 low_latency_rate_cnt;
> +	__le32 su_burst_rate_drop_cnt;
> +	__le32 su_burst_rate_drop_fail_cnt;
> +};

Since this strcuture represents the message format used between host and firmware, pls add 
__packed annotation even though it may not have any effect in this case.

Vasanth

Vasanth

