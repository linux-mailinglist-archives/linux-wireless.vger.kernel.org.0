Return-Path: <linux-wireless+bounces-8364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC638D6963
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 21:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51CAB230C5
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4167F7D1;
	Fri, 31 May 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AwgksA/V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9B4653C
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182338; cv=none; b=E3VsmHEJcRxQtMVJ75LY6w2VN5HcfqwhHDLaJbIzPx3f8Wu/WuwANV0a0Ywhl5ceK3jDsgNRJ1SJV3VH+sjqk7ytpNtRe7oAdKNI/841Ff7S/YxJsoX0L3KA7HN/qlQ3+zAs0ozvfaDWevI/wFwFX8zvv6tzKRPaKLtNUIfz7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182338; c=relaxed/simple;
	bh=Ida8TV2HW019Kd6RFReqXmpNCWuaxiF2r/Pkfi4/kj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DRhhNSAa1Yx0Inmodr++OrPRjNLGzd9O048+T0egsKYFFW8fNsRqtSu0G9yTxGEabiI/TXBh0D3csuWP6Ddl3xcn4xGENXOi1mprun8pB7oItiHnh4y+8JpAONsbLoIR4kWCXIiBNH1uKGqhD1ZTp2ZDhJbAF2VtNTDBw0N64Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AwgksA/V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VDPsX1015796;
	Fri, 31 May 2024 19:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2gNxGBxGKAzI5XV8OQJa+mNrftg32BPwCFaSdRN+I1c=; b=AwgksA/Vooc74sSV
	LkTbI8dNNrGqYx3wAh8rCZqKX28Bs3vaTTovAy3lqxY6PDyHweDow0BvFK9ImpxD
	PCVCLorlswKYRhYLQwXt2Da1I9k4ou2pKWKA6+I1g4KcLdr2rdmhBm3CDo0rTeuB
	Ftpw5v+lQyj2qYcLbamfOHLEuF+yRTcfVb5NtGbz9wMFttigEdxURWv3riJkkNVh
	OaN58P6KmLhTIYxgy19ynO50W+F9LOhSZVUg/ELx46tnHhpYmVPcT3LaVzxp9ffH
	VGSy7kIeYZTwZXK5gL9CV+eW4hC48rcpTtENSOSQ8/tlZU4hDTAfCw0gSZMQaWbc
	6XX1pg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws7p2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 19:05:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VJ5Qb5009035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 19:05:26 GMT
Received: from [10.216.33.242] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 12:05:24 -0700
Message-ID: <4f186ad2-bc4f-4ad9-8af9-631b9d66ffce@quicinc.com>
Date: Sat, 1 Jun 2024 00:35:19 +0530
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
 <024e2594-309a-4549-9c69-d527717c5dd4@quicinc.com>
 <87r0dm6vrn.fsf@kernel.org>
 <1be3531d-b550-4b19-93bb-d41e93362e19@quicinc.com>
 <87plt1vp3d.fsf@kernel.org>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <87plt1vp3d.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y_82XfywWkcPGmNloAn6z2hhjiEL20vO
X-Proofpoint-GUID: y_82XfywWkcPGmNloAn6z2hhjiEL20vO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=866
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310145


On 5/31/2024 11:30 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> On 5/28/2024 4:36 PM, Kalle Valo wrote:
>>> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
>>>
>>>>>> +static inline void
>>>>>> +ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf,
>>>>>> +						struct debug_htt_stats_req *stats_req)
>>>>>> +{
>>>>>> + const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv
>>>>>> *htt_stats_buf = tag_buf;
>>>>>> +	char *mode;
>>>>>> +	u8 j, hw_mode, i, str_buf_len;
>>>>>> +	u8 *buf = stats_req->buf;
>>>>>> +	u32 len = stats_req->buf_len;
>>>>>> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
>>>>>> +	u32 stats_value;
>>>>>> +	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
>>>>>> +	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
>>>>>> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
>>>>>> +
>>>>>> +	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
>>>>>> +
>>>>>> +	switch (hw_mode) {
>>>>>> +	case ATH12K_HTT_STATS_HWMODE_AC:
>>>>>> +		len += scnprintf(buf + len, buf_len - len,
>>>>>> +				 "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n");
>>>>>> +		mode = "ac";
>>>>>> +		break;
>>>>>> +	case ATH12K_HTT_STATS_HWMODE_AX:
>>>>>> +		mode = "ax";
>>>>>> +		break;
>>>>>> +	case ATH12K_HTT_STATS_HWMODE_BE:
>>>>>> +		mode = "be";
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		return;
>>>>>> +	}
>>>>>
>>>>> Why are we not adding "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" with
>>>>> ax and be modes?
>>>>>
>>>> Sorry for the delayed response. I was on OoO for a week.
>>>
>>> No worries.
>>>
>>>> We will receive this TLV for each hw modes. Since
>>>> "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" is header and it would be
>>>> suffice to print it once, hence added it inside hw mode ac which will be
>>>> the first hw mode integrated inside the TLV.
>>>
>>> I would have expected that we print that outside of
>>> ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(), before the function
>>> is called at all.
>>>
>>
>> Function itself will be called more than once.
> 
> Sure, I got that. But I still think it is not really good design to
> print it like that.
> 
> Maybe the output could be something like below? Or print the mode
> separate in the first line?
> 
> HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:
> 
> ac_mu_mimo_num_seq_posted_nr4 = 0
> ac_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> ac_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> ac_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
> 
> ....
> 
> HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:
> 
> ax_mu_mimo_num_seq_posted_nr4 = 0
> ax_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> ax_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> ax_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
> 
> ax_mu_mimo_num_seq_posted_nr8 = 0
> ax_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> ax_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> ax_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,
> 

Sure Kalle. I understand. Will change like below and re-spin with all
the comments addressed:

HTT_TX_PDEV_AC_MU_PPDU_DISTRIBUTION_STATS:
ac_mu_mimo_num_seq_posted_nr4 = 0
ac_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0,
5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0,
5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0,
7:0, 8:0,

......
......
HTT_TX_PDEV_AX_MU_PPDU_DISTRIBUTION_STATS:
ax_mu_mimo_num_seq_posted_nr4 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0,
5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0,
5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0,
7:0, 8:0,

......
......

