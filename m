Return-Path: <linux-wireless+bounces-16524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B303E9F5DAA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F087A1FD1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D1D14AD2B;
	Wed, 18 Dec 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MpIBZPgv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348114A4F0
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734494290; cv=none; b=GFuuFWn/1Ku2eh2m8y2M+N5KteOERXn29PClVng3pGSR9SB6ddisJvfrgappVOWQeSFfMuiQhx4pYOM7Rc4qigOp9pg1ANuusl+rBGSXRm1Av0BMFJBdpUwtOv25FoTJOOoSLuEegOcm1maMkbFsqIQCveO1fto69xmLgh6Ujmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734494290; c=relaxed/simple;
	bh=oxAbVprzHQDqUPGkIkf6gh/B+OV8BzAEDeEFHpEgXG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TOqKrBKTGrQqBcKNw/m7M2r0g7i8pkEQPx6/3xCerLEKvcWedBF28zTkjrsFsHSfVwI2WSM5wNUV7AVDqlj2Qq3tHGLZC1S2nF6OG5OQPgH9lIeB6XEcNJWkqIC/ONLW2M0jQBUwiGq0kzEn5Pjfh9ABcWoSnVzj71xeXAgkoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MpIBZPgv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHGkiuJ001203;
	Wed, 18 Dec 2024 03:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lPkb315wUC1h3VyCTdtP63P7dpCN8Lx4HKs8EyJM/m4=; b=MpIBZPgvs8MgiitM
	5QmNQJf3pT+tcc7r+bRBFAmkMhmDwB6uTPgjjBSL7/Xzsijt+9N4fz56BVSTGOnF
	HQvP546xyvqRxA9c9myMALqFkDgsRHkWmZPoZrJyzKLw4RwygIXK5V0WqN50onbT
	RzBV28/PN7tTt677VwQX166q1iBrbSlifgGXrBD0fy6UQHYOZsmfjQ7HcoG/jpyw
	QfeFEOi3J7+rgamoy9pactM49GB627PZKcAkTnX+WRM09gWBONE8orex+fx/4+/T
	0EWfzB+uaqdxcCM8GSH72jzRXGM4o7uAjfbXUlIzuXLX+2w1p2K2sTTwR1FyPW8c
	r29dLQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kd4asb4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:58:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BI3w23Q009692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:58:02 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 17 Dec
 2024 19:58:00 -0800
Message-ID: <10c22e95-77ca-4690-a48e-ce93d8d33696@quicinc.com>
Date: Wed, 18 Dec 2024 09:27:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] wifi: ath12k: Support pdev Puncture Stats
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rajat Soni
	<quic_rajson@quicinc.com>
References: <20241217055408.1293764-1-quic_rdevanat@quicinc.com>
 <20241217055408.1293764-3-quic_rdevanat@quicinc.com>
 <87ttb2l49a.fsf@kernel.org>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <87ttb2l49a.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gJTKZRPmDGs2NqlLwozuGw0QaeZ671_N
X-Proofpoint-GUID: gJTKZRPmDGs2NqlLwozuGw0QaeZ671_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180028



On 12/17/2024 8:56 PM, Kalle Valo wrote:
> Roopni Devanathan <quic_rdevanat@quicinc.com> writes:
> 
>> From: Rajat Soni <quic_rajson@quicinc.com>
>>
>> Add support to request pdev puncture stats from firmware through
>> HTT stats type 46. These stats give the count of number of
>> subbands used in different wifi standards.
>>
>> Sample output:
>> -------------
>> echo 46 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
>> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
>> HTT_PDEV_PUNCTURE_STATS_TLV:
>> mac_id = 0
>> tx_ofdm_su_last_used_pattern_mask = 0x00000001
>> tx_ofdm_su_num_subbands_used_cnt_01 = 217
>> tx_ofdm_su_num_subbands_used_cnt_02 = 0
>> tx_ofdm_su_num_subbands_used_cnt_03 = 0
>> .....
>>
>> HTT_PDEV_PUNCTURE_STATS_TLV:
>> mac_id = 0
>> tx_ax_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
>> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
>> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
>> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
>> .....
>>
>> HTT_PDEV_PUNCTURE_STATS_TLV:
>> mac_id = 0
>> tx_be_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
>> tx_be_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
>> tx_be_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
>> tx_be_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
>> .....
>>
>> HTT_PDEV_PUNCTURE_STATS_TLV:
>> mac_id = 0
>> rx_ax_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
>> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
>> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
>> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
>> .....
>>
>> HTT_PDEV_PUNCTURE_STATS_TLV:
>> mac_id = 0
>> rx_be_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
>> rx_be_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
>> rx_be_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
>> rx_be_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
>> .....
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> 
> [...]
> 
>> +static const char*
>> +ath12k_htt_get_punct_ppdu_type_str(enum ath12k_htt_stats_ppdu_type ppdu_type,
>> +				   struct debug_htt_stats_req *stats_req)
>> +{
>> +	const char *ppdu_type_str = "unknown";
>> +	u32 len = stats_req->buf_len;
>> +
>> +	switch (ppdu_type) {
>> +	case ATH12K_HTT_STATS_PPDU_TYPE_MODE_SU:
>> +		ppdu_type_str = "su";
>> +		break;
>> +	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_MIMO:
>> +		ppdu_type_str = "dl_mu_mimo";
>> +		break;
>> +	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_MIMO:
>> +		ppdu_type_str = "ul_mu_mimo";
>> +		break;
>> +	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_OFDMA:
>> +		ppdu_type_str = "dl_mu_ofdma";
>> +		break;
>> +	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_OFDMA:
>> +		ppdu_type_str = "ul_mu_ofdma";
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	stats_req->buf_len = len;
>> +	return ppdu_type_str;
>> +}
> 
> Also here I don't get why the len variable is needed. I would just
> simplify this and the previous function to:
> 
> static const char*
> ath12k_htt_get_punct_ppdu_type_str(enum ath12k_htt_stats_ppdu_type ppdu_type,
> 				   struct debug_htt_stats_req *stats_req)
> {
> 	switch (ppdu_type) {
> 	case ATH12K_HTT_STATS_PPDU_TYPE_MODE_SU:
> 		return "su";
> 	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_MIMO:
> 		return "dl_mu_mimo";
> 	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_MIMO:
> 		return "ul_mu_mimo";
> 	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_OFDMA:
> 		return "dl_mu_ofdma";
> 	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_OFDMA:
> 		return "ul_mu_ofdma";
> 	default:
> 		return "unknown";
> 	}
> 

Sure, Kalle. I'll simplify the function definitions and re-spin the next version.

