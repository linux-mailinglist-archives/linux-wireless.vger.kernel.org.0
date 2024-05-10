Return-Path: <linux-wireless+bounces-7493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5328C2AD2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD551F24030
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937093E48C;
	Fri, 10 May 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DS5gNVEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B810965
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370837; cv=none; b=m1Rz7z12QyT2hxkAttBqZeS5VBMpb1ZMQRy8R7ZPucRwgMGDL6dXtDK+EaIwGxoIf3Mtq9LGn+igMYQzfBFIxPTbQNHSKQGkfOr76syd88jgEh9xDr5RAk8qFu8PCpnh3OArYjkT8rCl8U2s1F5tT6vjdf85CCuhEk5fKwM6xHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370837; c=relaxed/simple;
	bh=p1VSeQLLHDYXaVkxsRsXHlpHW8A7D3/L/e/1hwNR0n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lBFadIAFj9TI1KgTIpD3pMBSrVkBhVWfUJIOyWWCku0U0fhP6EMuSd5kg3njgcm1dDL1gHROho/ZnqHsDF7aCbYTrzpJSE7rPTsxCyhAKiXGnmCYbohpwqPemTkEvIKFINq13r2hKMqtWF6Y5EvVu76s+AtCYcvZ4CbLRuwFQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DS5gNVEs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44AD0PHK019374;
	Fri, 10 May 2024 19:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RASB9x9nXqf7ph30ktK4/eJqgLO1cDJb+IuPoTSusHI=; b=DS
	5gNVEsr+da9q6wuW7tPayTp6xvePhe0YgrWZ4QCiQ6rdopi/vQX/F0oCcuQLo5Bb
	dzdlFPMcfch1W2EeHmw4o8x3gO7WgB9aIUd1lA4lsc2qPz5NOWhtWORwnz4EdTc9
	viZMMkdZvLJGO/ZyMGMOkHbf0CvNQVIMVsR4Prt1oEGoUofc3/W0+DHFffy0y4kB
	FgsVMdUQaFzA1sew8krKqntNwJCEDeRaYXejdZq0ZCcv7evrkPzCXeOtCZTgaZqs
	cJaTDDEEuBsXuee0MlCiG3bzQ1kT+/YgDZgIGQttlIHk70sZUBIImuYZE2lVkXzN
	VpJ/8VtaEBnrXG0vuOHQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w1jc0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:53:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AJrpi3020572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:53:51 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 12:53:51 -0700
Message-ID: <4f9c9092-2571-4d25-acee-79d87edda2e8@quicinc.com>
Date: Fri, 10 May 2024 12:53:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] wifi: ath12k: Add support to parse requested
 stats_type
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-5-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240510050806.514126-5-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lxgeVdcO_AxR_fbo7oa3hVXHJz0RIE1U
X-Proofpoint-GUID: lxgeVdcO_AxR_fbo7oa3hVXHJz0RIE1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100141

On 5/9/2024 10:08 PM, Ramya Gnanasekar wrote:
> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> 
> Add extended htt stats parser and print the corresponding TLVs associated
> with the requested htt_stats_type.
> Add support for TX PDEV related htt stats.
> 
> Sample output:
> -------------
> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
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
> urrn_stats =  0:0, 1:241, 2:0,
> 
> HTT_TX_PDEV_STATS_SIFS_TLV:
> sifs_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
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
> 126:0, 127:0,
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


