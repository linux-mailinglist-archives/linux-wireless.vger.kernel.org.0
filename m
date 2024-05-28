Return-Path: <linux-wireless+bounces-8212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286288D21E5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5A71F2208B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A8173338;
	Tue, 28 May 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YEAObYae"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385D173320
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914914; cv=none; b=FkpyXl9uECMAlvxZjKEU3T+IdYourGs/q0CTXv0aoh/GqZqN5Ayuswpuqg33KkFlbuXTdPXCpiYo4XBzFBNYA2UknIK5PsLxm9OQOEbtBVeMkyNzlGHOw8iOB8VLT9oxmYB9S6mIgYLFTCxO38yh6GuEiNPZEQX/R/O8eFJCiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914914; c=relaxed/simple;
	bh=p9/aLCDA3xXu4Hub/BwJlraemUY+wi80tV6KRp692L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s1drLjuKOY2U9VYHhFWHYMAQbDfsIO6JUuMvenkloM5mLttJZzK8M9wG8M+nJHNzAC2lVS+wu5+qlEYlTqY4mjmYoaXBr9QCrDcLzeeYi1amJD/uqT0XXxiqYGbf0Zl6aEjIOTjTtW13/jejQT6pRBhuo/pHFcgoSVaCIgGOaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YEAObYae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBiZrD021170;
	Tue, 28 May 2024 16:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Z3nnF0h5PaBzQZEJE8W5MQLXaDHDwtVuMYAdp1Ou+0=; b=YEAObYaeEgv/GAAi
	zIUW51JrpdKkYmfDgXNYYhb4xABKCtiVE70WVFW11n7ZzLDpzV0NyjLHx/KweQCl
	GcjS9mSfiot+i6BoIRNlQUPyGvpG74hVVJU6OkykvWCzEpAC/W82rBlNUm52i+E1
	JVxrM4EsWvZJOlIX37kQdXDhcod0Wrar375LX26NgXI8CGNd44VSKL0dGIuE8gPp
	lfr/fJP95R4y0q8pVTjKop1NsM6p1LmUnDisAiwC77qx3SpW2hU9b+A51ZrqjZGO
	w0u+4mmJePIY8YUSQMLwYuYlSzbc0bZsEYBXAD0+9bQmET1RuB3MYQ8r5LmuuPad
	eJNwMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0ppmv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:48:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SGmOXN025296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:48:24 GMT
Received: from [10.50.5.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 09:48:22 -0700
Message-ID: <1be3531d-b550-4b19-93bb-d41e93362e19@quicinc.com>
Date: Tue, 28 May 2024 22:18:18 +0530
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
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <87r0dm6vrn.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yTz42HeB_HVIkG87MgIGaF2oG3uR033S
X-Proofpoint-GUID: yTz42HeB_HVIkG87MgIGaF2oG3uR033S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=917 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280124



On 5/28/2024 4:36 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>>>> +static inline void
>>>> +ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf,
>>>> +						struct debug_htt_stats_req *stats_req)
>>>> +{
>>>> + const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv
>>>> *htt_stats_buf = tag_buf;
>>>> +	char *mode;
>>>> +	u8 j, hw_mode, i, str_buf_len;
>>>> +	u8 *buf = stats_req->buf;
>>>> +	u32 len = stats_req->buf_len;
>>>> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
>>>> +	u32 stats_value;
>>>> +	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
>>>> +	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
>>>> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
>>>> +
>>>> +	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
>>>> +
>>>> +	switch (hw_mode) {
>>>> +	case ATH12K_HTT_STATS_HWMODE_AC:
>>>> +		len += scnprintf(buf + len, buf_len - len,
>>>> +				 "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n");
>>>> +		mode = "ac";
>>>> +		break;
>>>> +	case ATH12K_HTT_STATS_HWMODE_AX:
>>>> +		mode = "ax";
>>>> +		break;
>>>> +	case ATH12K_HTT_STATS_HWMODE_BE:
>>>> +		mode = "be";
>>>> +		break;
>>>> +	default:
>>>> +		return;
>>>> +	}
>>>
>>> Why are we not adding "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" with
>>> ax and be modes?
>>>
>> Sorry for the delayed response. I was on OoO for a week.
> 
> No worries.
> 
>> We will receive this TLV for each hw modes. Since
>> "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n" is header and it would be
>> suffice to print it once, hence added it inside hw mode ac which will be
>> the first hw mode integrated inside the TLV.
> 
> I would have expected that we print that outside of
> ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(), before the function
> is called at all.
> 

Function itself will be called more than once. The overall HTT TLV will
be integrated with tag HTT_STATS_MU_PPDU_DIST_TAG (129) for all the hw
modes separately.

