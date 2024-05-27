Return-Path: <linux-wireless+bounces-8084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B38CFD3A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0971B280DA7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76B13AD39;
	Mon, 27 May 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KEgLBtaU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4D13AA5C
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802756; cv=none; b=Xq3iZl1JMil4AHyReJQC4N2z8oLEI+3GZaBJzX497vfdslMJngKLyrJpE6XIaCEg/CjYNDuj+5kT0lIE7pk9Mm8bIZOrXQObVvyAgTs4QxLQlAU6DOea/7e2wkU3jpXMnKxGdDOYY+gKofpYCJp8sZmQxt1ZYk2OadjcZY/6YLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802756; c=relaxed/simple;
	bh=e6qPFIaZbuys4BGZXQK1xWyWEZjnq5yGXCQaAwTTbR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SN4LTz4I2XVlhtiFtW2Vd4SIeplkF9M1QZiczrmY1b8vNA5XLn20SARW76cceR3s2eis+R1sWY2qHLbyknQhc0ww4YeV8bXLdDI6g4wknU8hCi2HL+f3XvTdiBXarMRGKwGpuQSv6WJw6qHSHsiT9Yjn6PrUdSSTCcFV+59nHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KEgLBtaU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R172pq021242;
	Mon, 27 May 2024 09:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwpoCRMzJ8WKNrv7RLuaRsOpeZ9XD9qzNw8j3DzhOfo=; b=KEgLBtaUKZegRYun
	56lM6sVqD1pzoucvLnqn8T/50IzJ+/lhstMOtq+q55fOuAkIaUdoW1ozf/HgPOPw
	pmBMmSz1rkm1s45ra4WiTGHujMiji9PIagRtmT7E1fbF4Ssr4X4AqRTtgojXaFPI
	DMxCbTmxMI/sB4dZeNv57ujgbsXyFgzmu2cReDeXXli18ZZh2WOnvr58vLy7dtYk
	32U9C52ZYAEcF7y5ufgJRHXM6WZ0b3W8eDJeustPCpTOn0nwpvaK9UxSNjZe/Vda
	MLSNio/LfsbshyOScOEZql8h1BGmzva37GpnM/YVKAta5NUfABkDq0Ht/EZ1a6gY
	/XI/UA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yj36ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 09:39:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44R9d6mr008857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 09:39:06 GMT
Received: from [10.152.203.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 02:39:04 -0700
Message-ID: <024e2594-309a-4549-9c69-d527717c5dd4@quicinc.com>
Date: Mon, 27 May 2024 15:08:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] wifi: ath12k: Dump additional Tx PDEV HTT stats
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-6-quic_rgnanase@quicinc.com>
 <87le43d26u.fsf@kernel.org>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <87le43d26u.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4bduNSIneAtzH_cuIE_e4_Y8NZHDDCOx
X-Proofpoint-ORIG-GUID: 4bduNSIneAtzH_cuIE_e4_Y8NZHDDCOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270077



On 5/21/2024 1:30 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> Support to dump additional Tx PDEV stats through HTT stats debugfs.
>> Following stats dump are supported:
>>         1. PDEV control path stat to dump Tx management frame count
>>         2. Tx PDEV SIFS histogram stats
>>         3. Tx MU MIMO PPDU stats for 802.11ac, 802.11ax and 802.11be
>>
>> Sample Output:
>> --------------
>> echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
>> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
>> HTT_TX_PDEV_STATS_CMN_TLV:
>> mac_id = 0
>> comp_delivered = 0
>> self_triggers = 13
>> ......
>> ......
>> HTT_TX_PDEV_STATS_CTRL_PATH_TX_STATS:
>> fw_tx_mgmt_subtype =  0:1, 1:0, 2:0, 3:0, 4:38, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:1, 12:0, 13:7, 14:0, 15:0,
>>
>> HTT_TX_PDEV_STATS_SIFS_HIST_TLV:
>> sifs_hist_status =  0:237, 1:185, 2:1, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>>
>> HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:
>> ac_mu_mimo_num_seq_posted_nr4 = 0
>> ac_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ac_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ac_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
>>
>> ac_mu_mimo_num_seq_posted_nr8 = 0
>> ac_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ac_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ac_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
>>
>> ax_mu_mimo_num_seq_posted_nr4 = 0
>> ax_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ax_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ax_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
>>
>> ax_mu_mimo_num_seq_posted_nr8 = 0
>> ax_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ax_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> ax_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
>>
>> be_mu_mimo_num_seq_posted_nr4 = 0
>> be_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> be_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> be_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
>>
>> be_mu_mimo_num_seq_posted_nr8 = 0
>> be_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> be_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
>> be_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> 
> [...]
> 
>> +static inline void
>> +ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf,
>> +						struct debug_htt_stats_req *stats_req)
>> +{
>> +	const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv *htt_stats_buf = tag_buf;
>> +	char *mode;
>> +	u8 j, hw_mode, i, str_buf_len;
>> +	u8 *buf = stats_req->buf;
>> +	u32 len = stats_req->buf_len;
>> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
>> +	u32 stats_value;
>> +	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
>> +	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
>> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
>> +
>> +	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
>> +
>> +	switch (hw_mode) {
>> +	case ATH12K_HTT_STATS_HWMODE_AC:
>> +		len += scnprintf(buf + len, buf_len - len,
>> +				 "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n");
>> +		mode = "ac";
>> +		break;
>> +	case ATH12K_HTT_STATS_HWMODE_AX:
>> +		mode = "ax";
>> +		break;
>> +	case ATH12K_HTT_STATS_HWMODE_BE:
>> +		mode = "be";
>> +		break;
>> +	default:
>> +		return;
>> +	}
> 
> Why are we not adding "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" with
> ax and be modes?
> 
Sorry for the delayed response. I was on OoO for a week.
We will receive this TLV for each hw modes. Since
"HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" is header and it would be
suffice to print it once, hence added it inside hw mode ac which will be
the first hw mode integrated inside the TLV.

