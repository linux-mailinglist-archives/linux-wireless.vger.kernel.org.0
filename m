Return-Path: <linux-wireless+bounces-9509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD179156D8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34DA1F24288
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88266107A0;
	Mon, 24 Jun 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k650v+cV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DD2E400
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255574; cv=none; b=OfXWnpU3eT/hPkePUo6VRTRw6G3CER0eJNcfbVwvCpy6bNnuq1EISTzjs16kJYeLGE0T+y5+ljBOpzVGbLYwBU3E8CpVMumfMWa50LXQWXzjIVhKQ3AHbtmGQl+nB1VSRgWId/ByYqL75sYG0UlLU2rFdqd2bJzWIQTcceEskT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255574; c=relaxed/simple;
	bh=XU7B1CdSeFMkqkc4l48UUmxQF4hyAHJsSGCRMULJcwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TNG4DJmctAbNzMpAPXWoemFxbb83BDL64LJ+7bJKcWSGIVASpY9eEvsS/9nmVf0pV62Ke7KywAHAUylSX9nTK2g1eLpyVqQESOg+6XQzlEdnN86lg2K4f6DdsIzYRVfDvpf1Xj++ODcUkpN+mHzj6vnOYUwdp/EO/ZKWAdnbrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k650v+cV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIfu9f031942;
	Mon, 24 Jun 2024 18:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nXbQSEKJMV1FM7WRJTSkA9/meMDNNk/ON5rY7k6N7so=; b=k650v+cVSNqQntrr
	qYG3MUkK2KH11Rt2zfU5B0Gwem3HJY7DHAUv8gTs0icJjPcZkclMagVciE91z09r
	30a3fa2kGsM4qtq6R2u54kAUQFvCYmDKrdUmnemuGIE1rtZo1FvZICYVX7ajgKzC
	QuuW7f+IoOtWrBmEbCHJ/I24ItkTGFn9b+wCFfK//dLLpQExTjrbEjjGR3FOVwyu
	k5iH6tSh+2uY8jHtKwTrou11GqJ2WRejCUvLX89oKCyhfyc+O1ZTj6iBwfqDSM12
	E4+jXLRD7vMvr6CwwIfk489JCy/C2h/npb4yyy/mckI6uaFkyYWoiF3J6C81D57R
	lBWo8w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppv4e70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 18:59:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OIxQbE022974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 18:59:26 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 11:59:25 -0700
Message-ID: <741236ea-3f8e-4690-8719-f6207f2f3da6@quicinc.com>
Date: Mon, 24 Jun 2024 11:59:24 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] wifi: ath12k: Add support to parse requested
 stats_type
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240624043845.3502520-1-quic_rgnanase@quicinc.com>
 <20240624043845.3502520-4-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240624043845.3502520-4-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CyxXERlC5jdoX24MIOAdfcM99tR4vPyP
X-Proofpoint-ORIG-GUID: CyxXERlC5jdoX24MIOAdfcM99tR4vPyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406240151

On 6/23/2024 9:38 PM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add extended htt stats parser and print the corresponding TLVs associated
> with the requested htt_stats_type.
> Add support for TX PDEV related htt stats.
> 
> Sample output:
> --------------
> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> 
> HTT_TX_PDEV_STATS_CMN_TLV:
> mac_id = 0
> comp_delivered = 0
> self_triggers = 256
> hw_queued = 275
> hw_reaped = 275
> underrun = 241
> hw_paused = 0
> hw_flush = 0
> hw_filt = 1
> tx_abort = 0
> ppdu_ok = 246
> mpdu_requeued = 0
> tx_xretry = 0
> data_rc = 3
> mpdu_dropped_xretry = 0
> illegal_rate_phy_err = 0
> cont_xretry = 0
> tx_timeout = 0
> tx_time_dur_data = 0
> pdev_resets = 0
> phy_underrun = 0
> txop_ovf = 0
> seq_posted = 247
> seq_failed_queueing = 0
> seq_completed = 247
> seq_restarted = 0
> seq_txop_repost_stop = 0
> next_seq_cancel = 0
> dl_mu_mimo_seq_posted = 0
> dl_mu_ofdma_seq_posted = 0
> ul_mu_mimo_seq_posted = 0
> ul_mu_ofdma_seq_posted = 0
> mu_mimo_peer_blacklisted = 0
> seq_qdepth_repost_stop = 0
> seq_min_msdu_repost_stop = 0
> mu_seq_min_msdu_repost_stop = 0
> seq_switch_hw_paused = 0
> next_seq_posted_dsr = 0
> seq_posted_isr = 0
> seq_ctrl_cached = 0
> mpdu_count_tqm = 0
> msdu_count_tqm = 0
> mpdu_removed_tqm = 0
> msdu_removed_tqm = 0
> remove_mpdus_max_retries = 0
> mpdus_sw_flush = 0
> mpdus_hw_filter = 0
> mpdus_truncated = 0
> mpdus_ack_failed = 0
> mpdus_expired = 0
> mpdus_seq_hw_retry = 0
> ack_tlv_proc = 0
> coex_abort_mpdu_cnt_valid = 0
> coex_abort_mpdu_cnt = 5
> num_total_ppdus_tried_ota = 5
> num_data_ppdus_tried_ota = 0
> local_ctrl_mgmt_enqued = 247
> local_ctrl_mgmt_freed = 247
> local_data_enqued = 0
> local_data_freed = 0
> mpdu_tried = 0
> isr_wait_seq_posted = 0
> tx_active_dur_us_low = 0
> tx_active_dur_us_high = 0
> fes_offsets_err_cnt = 0
> 
> HTT_TX_PDEV_STATS_URRN_TLV:
> urrn_stats =  0:0, 1:241, 2:0
> 
> HTT_TX_PDEV_STATS_SIFS_TLV:
> sifs_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
> 
> HTT_TX_PDEV_STATS_FLUSH_TLV:
> flush_errs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
> 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0,
> 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0,
> 35:0, 36:0, 37:0, 38:0, 39:0, 40:0, 41:0, 42:0, 43:0, 44:0, 45:0, 46:0,
> 47:0, 48:0, 49:0, 50:0, 51:0, 52:0, 53:0, 54:0, 55:0, 56:0, 57:0, 58:0,
> 59:0, 60:0, 61:0, 62:0, 63:0, 64:0, 65:0, 66:0, 67:0, 68:0, 69:0, 70:0,
> 71:0, 72:0, 73:0, 74:0, 75:0, 76:0, 77:0, 78:0, 79:0, 80:0, 81:0, 82:0,
> 83:0, 84:0, 85:0, 86:0, 87:0, 88:0, 89:0, 90:0, 91:0, 92:0, 93:0, 94:0,
> 95:0, 96:0, 97:0, 98:0, 99:0, 100:0, 101:0, 102:0, 103:0, 104:0, 105:0,
> 106:0, 107:0, 108:0, 109:0, 110:0, 111:0, 112:0, 113:0, 114:0, 115:0,
> 116:0, 117:0, 118:0, 119:0, 120:0, 121:0, 122:0, 123:0, 124:0, 125:0,
> 126:0, 127:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 324 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 211 ++++++++++++
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
>  4 files changed, 545 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 9f44285caa58..11daa842ab55 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -9,6 +9,330 @@
>  #include "debug.h"
>  #include "debugfs_htt_stats.h"
>  #include "dp_tx.h"
> +#include "dp_rx.h"
> +
> +static u32
> +print_array_to_buf(u8 *buf, u32 offset, const char *header,
> +		   const __le32 *array, u32 array_len, char *newline)

newline should be const

but perhaps call it 'footer' to mirror the existing param 'header'

> +{
> +	int index = 0;
> +	u8 i;
> +
> +	if (header) {
> +		index += scnprintf(buf + offset,
> +				   ATH12K_HTT_STATS_BUF_SIZE - offset,
> +				   "%s = ", header);
> +	}
> +	for (i = 0; i < array_len; i++) {
> +		index += scnprintf(buf + offset + index,
> +				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> +				   " %u:%u,", i, le32_to_cpu(array[i]));
> +	}
> +	/* To overwrite the last trailing comma */
> +	index--;

let's go ahead and explicitly overwrite the comma here with:
	buf[offset + index] = '\0';
or
	*(buf + offset + index) = '\0';

i'm not sure which I prefer, pick which you prefer

i want to add that explicit overwrite since now you are introducing a new
'newline/footer' param. and i'm thinking that if header is optional, should
this be optional as well? maybe the below should be inside

	if (newline [or footer])

and hence we'd no longer guarantee that the trailing comma is overwritten by
this function, and hence why i think it should be done explicitly

> +	index += scnprintf(buf + offset + index,
> +			   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
> +			   "%s", newline);
> +	return index;
> +}
rest of the patch LGTM


