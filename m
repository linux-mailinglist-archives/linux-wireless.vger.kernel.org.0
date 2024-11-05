Return-Path: <linux-wireless+bounces-14944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A579D9BD966
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 00:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AA61C22610
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ACE216425;
	Tue,  5 Nov 2024 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mKSkcQIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AC383
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847818; cv=none; b=EbUMTwDh5MYBh39wCFqIQzd/8v6BUiDEqPkuUIgxoUAlihxCIRehFqgSaL/WzUZ77Y94mLBZLi9vPw1B9YcDtfZUeEsERWRUavUHS+eYcHM++qBgsNGXeleAgLtc0z+KvgkI8+kOZF+UasesFMtvcekoHGoKZZ6mQr3NXAoUZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847818; c=relaxed/simple;
	bh=9sq/4KcNG+f0bUVevNDj5q2aR12vLCcBrd1axa/cOB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hi7RPminYgYEz2/SavFzv5pp1HNjOxyEc9lAIgUly8me7fWyCT64I5+zbbvZ41ItC0okqU2NXJzIyTpEcMJ5Fw88gdRyvdKrnidSAtWB/BRsE+7b8lBC3cmEYhYeYgg1Zu1XnrbiFyNLKja5Sq9sUbO3sxhAlfl7nskjtuDctRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mKSkcQIt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5M0sO5001852;
	Tue, 5 Nov 2024 23:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Cx8iJ06J8a99P0RewGhkSiNy/moKPMQ9x3/vmuCFFs=; b=mKSkcQItQdljOZ+1
	0sheOnPkCvfGs+N1WA6o/KB/i8Y5HcHOs5w6E8TsDF0AyjlHaihIsMw36bdt2CiS
	mOE70O1bl9yFSRXIumlyb9Fx1ZqgdvQuRmqxu0EcHVX/vVUHoNIjJRMNzdVGIdiN
	l5uvzDFNtYqy9MME0o0aiJMmEMUD7vHsVklnd5P6+Nepi5GpHPlaya0R6A5CjhiQ
	jG+PubHD0QpLpdauw/covQvKV4OPXgMUM8LCJX7E0OfLBJ9/VhRjJitL0Ch/dF1z
	IpNaQIbQfrv9tIs+khwM5O3krwmwAP9k7e375ZbyVbM6VS2/0EtQHNBmOYpFEcLN
	i/pcOw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2s97hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 23:03:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5N3V9o011154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 23:03:31 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 5 Nov 2024
 15:03:30 -0800
Message-ID: <877144aa-cf5b-4077-8b4f-49d754a2cb02@quicinc.com>
Date: Tue, 5 Nov 2024 15:03:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: Support Transmit PER Rate Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20241105045406.2098436-1-quic_rdevanat@quicinc.com>
 <20241105045406.2098436-5-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241105045406.2098436-5-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wkRkUAz395gDBZe9tLxLe49YoJdv43NQ
X-Proofpoint-GUID: wkRkUAz395gDBZe9tLxLe49YoJdv43NQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411050179

On 11/4/2024 8:54 PM, Roopni Devanathan wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add support to request per rate stats through HTT stats type
> 40. These stats give information about rates of PPDUs and
> MPDUs for single user and for OFDMA and MUMIMO technologies
> corresponding to multiple users.
> 
> Sample output:
> -------------
> echo 40 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TX_PER_STATS:
> 
> PER_STATS_SU:
> 
> PER per BW:
> ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0
> ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0
> mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0
> mpdus_failed_su =  0:0 1:0 2:0 3:0 4:0
> 
> PER per NSS:
> ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> mpdus_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
> 
> PER per MCS:
> ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> mpdus_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
> .....
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 269 +++++++++++++++++-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  68 ++++-
>  2 files changed, 334 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 8f89ba2db8c7..e185d4971e79 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -48,6 +48,28 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
>  					footer);
>  }
>  
> +static const char *ath12k_htt_ax_tx_rx_ru_size_to_str(u8 ru_size)
> +{
> +	switch (ru_size) {
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_26:
> +		return "26";
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_52:
> +		return "52";
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_106:
> +		return "106";
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_242:
> +		return "242";
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_484:
> +		return "484";
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996:
> +		return "996";
> +	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996x2:
> +		return "996x2";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
>  static const char *ath12k_htt_be_tx_rx_ru_size_to_str(u8 ru_size)
>  {
>  	switch (ru_size) {
> @@ -88,6 +110,17 @@ static const char *ath12k_htt_be_tx_rx_ru_size_to_str(u8 ru_size)
>  	}
>  }
>  
> +static const char*
> +ath12k_tx_ru_size_to_str(enum ath12k_htt_stats_ru_type ru_type, u8 ru_size)
> +{
> +	if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY)
> +		return ath12k_htt_ax_tx_rx_ru_size_to_str(ru_size);
> +	else if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU)
> +		return ath12k_htt_be_tx_rx_ru_size_to_str(ru_size);
> +	else
> +		return "unknown";
> +}
> +
>  static void
>  htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
>  				struct debug_htt_stats_req *stats_req)
> @@ -2879,6 +2912,237 @@ ath12k_htt_print_soc_txrx_stats_common_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void
> +ath12k_htt_print_tx_per_rate_stats_tlv(const void *tag_buf, u16 tag_len,
> +				       struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_tx_per_rate_stats_tlv *stats_buf = tag_buf;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	const char *mode_prefix;
> +	int i;
> +	u32 ru_size_cnt = 0;
> +	u32 rc_mode;
> +	u32 ru_type;
> +
> +	if (tag_len < sizeof(*stats_buf))
> +		return;
> +
> +	rc_mode = le32_to_cpu(stats_buf->rc_mode);
> +	ru_type = le32_to_cpu(stats_buf->ru_type);
> +
> +	switch (rc_mode) {
> +	case ATH12K_HTT_STATS_RC_MODE_DLSU:
> +		len += scnprintf(buf + len, buf_len - len, "HTT_TX_PER_STATS:\n");
> +		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_SU:\n");
> +		mode_prefix = "su";
> +		break;
> +	case ATH12K_HTT_STATS_RC_MODE_DLMUMIMO:
> +		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_DL_MUMIMO:\n");
> +		mode_prefix = "mu";
> +		break;
> +	case ATH12K_HTT_STATS_RC_MODE_DLOFDMA:
> +		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_DL_OFDMA:\n");
> +		mode_prefix = "ofdma";
> +		if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY)
> +			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS;
> +		else if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU)
> +			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS;
> +		break;
> +	case ATH12K_HTT_STATS_RC_MODE_ULMUMIMO:
> +		len += scnprintf(buf + len, buf_len - len, "HTT_RX_PER_STATS:\n");
> +		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_UL_MUMIMO:\n");
> +		mode_prefix = "ulmu";
> +		break;
> +	case ATH12K_HTT_STATS_RC_MODE_ULOFDMA:
> +		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_UL_OFDMA:\n");
> +		mode_prefix = "ulofdma";
> +		if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY)
> +			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS;
> +		else if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU)
> +			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	len += scnprintf(buf + len, buf_len - len, "\nPER per BW:\n");
> +	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
> +	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
> +		len += scnprintf(buf + len, buf_len - len, "data_ppdus_%s = ",
> +				 mode_prefix);
> +	else
> +		len += scnprintf(buf + len, buf_len - len, "ppdus_tried_%s = ",
> +				 mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
> +				 le32_to_cpu(stats_buf->per_bw[i].ppdus_tried));
> +	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
> +			 le32_to_cpu(stats_buf->per_bw320.ppdus_tried));
> +
> +	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
> +	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
> +		len += scnprintf(buf + len, buf_len - len, "non_data_ppdus_%s = ",
> +				 mode_prefix);
> +	else
> +		len += scnprintf(buf + len, buf_len - len, "ppdus_ack_failed_%s = ",
> +				 mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
> +				 le32_to_cpu(stats_buf->per_bw[i].ppdus_ack_failed));
> +	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
> +			 le32_to_cpu(stats_buf->per_bw320.ppdus_ack_failed));
> +
> +	len += scnprintf(buf + len, buf_len - len, "mpdus_tried_%s = ", mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
> +				 le32_to_cpu(stats_buf->per_bw[i].mpdus_tried));
> +	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
> +			 le32_to_cpu(stats_buf->per_bw320.mpdus_tried));
> +
> +	len += scnprintf(buf + len, buf_len - len, "mpdus_failed_%s = ", mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u", i,
> +				 le32_to_cpu(stats_buf->per_bw[i].mpdus_failed));
> +	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
> +			 le32_to_cpu(stats_buf->per_bw320.mpdus_failed));
> +
> +	len += scnprintf(buf + len, buf_len - len, "\nPER per NSS:\n");
> +	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
> +	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
> +		len += scnprintf(buf + len, buf_len - len, "data_ppdus_%s = ",
> +				 mode_prefix);
> +	else
> +		len += scnprintf(buf + len, buf_len - len, "ppdus_tried_%s = ",
> +				 mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,

should this use i + 1 since index 0 is for NSS 1?

are there other counters that could use a similar change?

> +				 le32_to_cpu(stats_buf->per_nss[i].ppdus_tried));
> +	len += scnprintf(buf + len, buf_len - len, "\n");
> +
> +	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
> +	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
> +		len += scnprintf(buf + len, buf_len - len, "non_data_ppdus_%s = ",
> +				 mode_prefix);
> +	else
> +		len += scnprintf(buf + len, buf_len - len, "ppdus_ack_failed_%s = ",
> +				 mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,

here too?

> +				 le32_to_cpu(stats_buf->per_nss[i].ppdus_ack_failed));
> +	len += scnprintf(buf + len, buf_len - len, "\n");
> +
> +	len += scnprintf(buf + len, buf_len - len, "mpdus_tried_%s = ", mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,

here too?

> +				 le32_to_cpu(stats_buf->per_nss[i].mpdus_tried));
> +	len += scnprintf(buf + len, buf_len - len, "\n");
> +
> +	len += scnprintf(buf + len, buf_len - len, "mpdus_failed_%s = ", mode_prefix);
> +	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,

here too?

> +				 le32_to_cpu(stats_buf->per_nss[i].mpdus_failed));
> +	len += scnprintf(buf + len, buf_len - len, "\n");
> +


