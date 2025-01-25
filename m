Return-Path: <linux-wireless+bounces-17936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27AA1C4DA
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 19:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A408C1886404
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF578F20;
	Sat, 25 Jan 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jL+EYSZ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA788494
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737828981; cv=none; b=plrsY8vGdP/V+dY/kKBxGActaZ9PjESU1VHb8v1219/NKeA+K4BTm+F9Xra331Odow0FJYmZO9xQVKNhYk3PmGKUJnJp+LyTcF493kWKUyQhSqjFR2UuFVlR7na2K3LqxDN30kU0o617FQMIkH7ZyciJefEYVsyGfXElrIX4Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737828981; c=relaxed/simple;
	bh=Z1zNj6htPJdHbG4iC3ZGsDBxH8DG+lUkQ/gwLcCXKVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LO+V6cPXJSuRUBKmEBXOxMTf4Iqy1IywzEQFbHyJZrvf8SXRnUm5a2jjMIV1e/jJr6//qyXh2joDcGKYa5XZAJtWgjRFaR7wXt4sEGRjpVR1rl2Ks7fmD86n11ZUc6D+HISEqNuJSaROGE1yX3X0TrDkaH6s0POYgXYEq2SQVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jL+EYSZ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PBWYwI009779
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 18:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2i2xeWg3R5GBSVEB5+8rekrvMBVDAi3hQD8Xh1ueFO8=; b=jL+EYSZ5TcoPoWK1
	IwdkpCTfNmAG+JtHM5VuFrz0b5DUU0x/gBiDRxDloIC+A5BqrgoOMxhB1CU7TbA+
	MjM96cpiqjSO+Z7ePVKKNhzTvmiErycpa96a25Ze2zmoMKqFDwjCz5n0V6j+0swV
	41BNyxLdwLYA4/j05qgwgPJbf37IwWG2iM/xSOxEg3o7TNZfyvbeXMWtoqUWHIAD
	6ceXZXqC+w3VzRuRpIjfrT/dYXLOaDIEN5HoFk7RniAMZFS6Ag5CHiVYGJ/o9qJL
	2Q78sIPZY13NPy/BSPd2nK4Q3/NB398v8iRpi5cQHxNyEZTnc/2hAexWTqLGYBYF
	V6DpMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cs4jrtye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 18:16:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so5782752a91.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 10:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737828974; x=1738433774;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2i2xeWg3R5GBSVEB5+8rekrvMBVDAi3hQD8Xh1ueFO8=;
        b=B4SBO1b7Q57/Xt/fquOwqAf+0d5TS1CrsZx4pLA4Q4Qv7oqH5Z/Ru92JUpcnmsjwUB
         aOZTk0JpYnmsPYcDwC8Wqvq6MLcpeOQ39Lb8kvOc66Z3VJSK7eY7tyr1fwf20LHQt8O3
         N5vQEOnGnGjY9KwoBN9ewh+djWHsPKaF033mryc2QMbhMhdHFJSnyAxjRA+CiIEKhfEX
         U+6ysB2EvNKwjCcvwumGQ1o0rN5RIh2ehRRxJX2e4R2SIMixmNZg3y1eT/jWzeGWFI2y
         6qBloHgZwIPlByTYuAYTI03dSHFTZj0/Gqq0mg+atlh/vSAhwEg/lSdxEpdL1EIm2rio
         xnGQ==
X-Gm-Message-State: AOJu0Yxv84YXaQ/k4RVRH9IQYZscMvAtIrNnKNDQty/YTuFjzYG82hGb
	SDg2gZOPor3N31qJyJK/XkDEIcD80k6i13NK71lJvrZtHaLE6burozjpouXWniiGR7rweHyjYgL
	i+MOVbVv8k+ZFpVbHtPPEDseysvFIxgrSzTZ8+xXmAncLoAX5s2N62VUqrqLpA6c2gw==
X-Gm-Gg: ASbGncvYPwzJSHyRkV1BvVNiadLDf1H6neFpa2JmcwezqlF1Hgu3Ks6BmmhHcuerH/l
	PPcqG1lB/A8/YsQmjdmnz9u7+I5tqy5bt0GN+0H1PFj8cfAiJN01w8aICa2urTfiVdav4LjSPV9
	q/KyU7clJkLYAlb1HYpALqV39zI9liHwF0CdTWss6JgxdSpWBkBqcItMCnyUY50eCHIZwZXbBHJ
	L+M8vp1oALKWxCezGCiVENyZ5nc1Ls6usIYho/kiQ/Re0kIls9GLgD/Yh0GOJzGPY9Ql82rdasd
	D8gya2f3VPvlvi4um4l2AxZcHxLI9A+eiazdXq8PDEQXCTfoGXb/0zjnox7IgshJmGc3w/aenQ=
	=
X-Received: by 2002:a17:90b:4ece:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2f782c50befmr44416816a91.5.1737828973978;
        Sat, 25 Jan 2025 10:16:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuUlocxSHJem8ZGdm7qzzzJxpC7hQ5Glct8AKuYKKLjsMA+cqdAfQczJfX9DFnrOJHHKw4yg==
X-Received: by 2002:a17:90b:4ece:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2f782c50befmr44416788a91.5.1737828973553;
        Sat, 25 Jan 2025 10:16:13 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496bbcdffsm3457646a12.64.2025.01.25.10.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 10:16:13 -0800 (PST)
Message-ID: <a39d5381-fd5f-4187-a715-0fedd010d03e@oss.qualcomm.com>
Date: Sat, 25 Jan 2025 10:16:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Add support for MLO Multicast handling
 in driver
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
 <20250109184932.1593157-3-quic_bmahalin@quicinc.com>
 <D7AA0SSICNT4.3GU5SHWIXWH94@gmail.com>
 <0e2feb8f-79dd-19af-3ad9-e61d3f25e9a6@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0e2feb8f-79dd-19af-3ad9-e61d3f25e9a6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fAjknhbf7cc-Kpjr_i2IydyYMU9zQPQG
X-Proofpoint-ORIG-GUID: fAjknhbf7cc-Kpjr_i2IydyYMU9zQPQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250136

On 1/24/2025 1:59 PM, Balamurugan Mahalingam wrote:
> On 1/24/2025 3:45 AM, Nicolas Escande wrote:
>> On Thu Jan 9, 2025 at 7:49 PM CET, Balamurugan Mahalingam wrote:
>> [...]
>>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
>>> index 76626d925adf..9d05fe7a870c 100644
>>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>>> @@ -217,7 +217,7 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
>>>   }
>>>   
>>>   int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>>> -		 struct sk_buff *skb)
>>> +		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
>>>   {
>>>   	struct ath12k_base *ab = ar->ab;
>>>   	struct ath12k_dp *dp = &ab->dp;
>>> @@ -290,13 +290,24 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>>>   		msdu_ext_desc = true;
>>>   	}
>>>   
>>> +	if (gsn_valid) {
>>> +		ti.meta_data_flags =
>>> +			u32_encode_bits(HTT_TCL_META_DATA_TYPE_GLOBAL_SEQ_NUM,
>>> +					HTT_TCL_META_DATA_TYPE) |
>>> +			u32_encode_bits(mcbc_gsn, HTT_TCL_META_DATA_GLOBAL_SEQ_NUM);
>>> +	}
>>> +
>> Hello,
>>
>> As ti is zeroed initilised isn't safer to do 'ti.meta_data_flags |='
>> instead of 'ti.meta_data_flags ='. This way if we add another flag in
>> meta_data_flag in the same func for another reason, we will have less risk of
>> overriding the said flags ?
>>
> 
> Hello Nicolas,
> In this case, this is an intentional reset of any previous residual 
> value in ti.meta_data_flags field.
> The meta_data_flags bit definition is different depending upon the 
> META_DATA_TYPE bit's value.

So in this case there can never be any conflicting information that came from
the assignment:
	ti.meta_data_flags = arvif->tcl_metadata;
??

Perhaps add a comment that states you are intentionally overriding the
information that came from arvif->tcl_metadata?

/jeff

> 
>>>   	ti.encap_type = ath12k_dp_tx_get_encap_type(arvif, skb);
>>>   	ti.addr_search_flags = arvif->hal_addr_search_flags;
>>>   	ti.search_type = arvif->search_type;
>>>   	ti.type = HAL_TCL_DESC_TYPE_BUFFER;
>>>   	ti.pkt_offset = 0;
>>>   	ti.lmac_id = ar->lmac_id;
>>> -	ti.vdev_id = arvif->vdev_id;
>>> +	if (gsn_valid)
>>> +		ti.vdev_id = arvif->vdev_id +
>>> +			     HTT_TX_MLO_MCAST_HOST_REINJECT_BASE_VDEV_ID;
>>> +	else
>>> +		ti.vdev_id = arvif->vdev_id;
>>>   	ti.bss_ast_hash = arvif->ast_hash;
>>>   	ti.bss_ast_idx = arvif->ast_idx;
>>>   	ti.dscp_tid_tbl_idx = 0;
> 


