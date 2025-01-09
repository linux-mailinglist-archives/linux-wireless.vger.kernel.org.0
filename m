Return-Path: <linux-wireless+bounces-17201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F25A069C8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E1A188898E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD07184;
	Thu,  9 Jan 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ke4RvN0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD405173
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736381431; cv=none; b=TPfwOkJeELSHNmlF0kYXT6pmG+1/+MSrdQbyRD2p8ABV+n3Hsj5+Iw0EFo8tguUBqOsGkq2iNRkOHDin6l9RYMxS27jsOIezmZJd6DtCnLEijWObvjE+k9YRiCKaN0n3nwvgJg9jkeS+pxMHvOVQS5Dd8zaflMzO2JUy4vnehds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736381431; c=relaxed/simple;
	bh=VsYUy+4ESWvQdVMaiVNRp/lRRbETC6fs3YnKb9FTMbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN+Xt675YWSFJEFha07bgJO7EV0pvoFQTFqQGIMmTJSca4LqPW4HFsPQCtOx7HHi/Czhj4RF21XAW+G48MKss8BxwBXbKOYGRerctWgzR8iqGus4sP/2/AZa7fyot9ueXJZhXysBP84+HCy63J0rdUlgz129msW92Y48OumCFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ke4RvN0s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Bkfvq005017
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2025 00:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ba7HI/jM8rZpmkbPTrPg6SIPkRARvnf8AKvi7+JEDdU=; b=ke4RvN0sQiFn+ott
	qnU3l8peF5b7jKKFOXa7kZL+zyzlnOIvqGY4Y0siA9ljl4fxg2yPPkXYoz4qwgaa
	NoRDviqAc8QsgPxyHqunTn+jq8SGU7DUv+eZ2IPgZ8SIY98u2YEMxuL4/Hglvrxp
	MMfHgHHs+xb2Ko9HKrPftMv85eeHvXK7Tbe61zUHEIt2pc655h41BVsM+rfbPgjn
	2FQEcR/HPArGUDEJDpFv4Yfg7jhuWGwLIC+JrTWbj6zuJ0UU8X1CJDNUD5yjLpyH
	YTb/kYUkakfc3Nx3YuhuM7uB+vBB8XHVBTn+kDqV+EEhxk/WZzzKp6oxvz/LT8P9
	AibZuw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441pkut29j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 00:10:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee5616e986so849184a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 16:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736381427; x=1736986227;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba7HI/jM8rZpmkbPTrPg6SIPkRARvnf8AKvi7+JEDdU=;
        b=PHOIKKlC0l6QN+WCaHNcztOySJiUbxk1M14VZNT8SfTTSnSMDfF/f0dPHSiR6K1Zm0
         VGcqZQVGJhAHa8mRL4yZ1QnzpbeNmlAT5HP6TbtIDKbUE6y3CdFo8Q7jzjhdYmMq7Ee1
         kgCwCtgzbpMiAPBr0YB49ltvdXqIda8aoA/+rIxhYSLBekASWmY5K5bO26l59PK/psz5
         oMcUlVqdyuIeYF1H8/wREUbAzmTkh2XHagl2wqWDv+M8t8aiO6hijUW2AfzzTHb48Hr8
         0zTTqI1whs0SfxtWoqoXXwg2NQjIYPVIUUP1Ju4LM6NWgAjMgbXChwn5WU3qtw3letMN
         EPeA==
X-Gm-Message-State: AOJu0Yy/HtZJj+73qQEqmoVSPA+J4vN2ypskaVcy2X5WmmNyBh/QQsS9
	eeVI60Bzdc6qPaB5x3NgFkky69L2+KasaKPqWUSqvMcXXJPLiUrOHUbFdIxGmwV5CWc49wusWxo
	8+wVTpEj3vNbEvgRlm6xSiwQ839+ayyqrHjb5bD4hYBiFOsvv6VZlqBdYGdhcIMcXMA==
X-Gm-Gg: ASbGncteaF/YFnQ4UYQ1qWnyVPtNS8raVcvnzGRuN+aNTSaEmsmdKtXRy+R024/1RYy
	Ur6TsKUhQpxMCjuw4kK8WcGzNQHxfb44e/1bLYXMU1S4dxrrSw3SmUKd9GodeSX521daakacUYL
	0Lx71OtvahWyXYYR0ZboP/NWJP8AzCRktifgzlylwm5G15FWkB4bNOB/cKWRAC2e3GBpRSE/HXA
	ygcNLXM/kSYBKQcKe/shsVoQ0H5iusFnjGkrZOjnR1v0t/cK8hGz1dbezSwVVJqu5/1f52sPl4l
	GOef5/3FcaHQEDhs+vEBOpV8Zl0zsnsQycIAxaaqfjAxoHLdsA==
X-Received: by 2002:a17:90b:2d43:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2f5490ed82dmr6093932a91.31.1736381426970;
        Wed, 08 Jan 2025 16:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG257rW6woA0u5VA9WO8H9R1W8kuwA4htpYgI6PBYgyMAsBt0qQtS6PoWpZZVLCaf9p4zXbmg==
X-Received: by 2002:a17:90b:2d43:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2f5490ed82dmr6093903a91.31.1736381426557;
        Wed, 08 Jan 2025 16:10:26 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f559412d2esm6077a91.20.2025.01.08.16.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 16:10:26 -0800 (PST)
Message-ID: <9ef1c2ee-beae-423c-8e48-59227b78beee@oss.qualcomm.com>
Date: Wed, 8 Jan 2025 16:10:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Add Support to Parse TPC Event from
 Firmware
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
References: <20241220203638.2082002-1-quic_rdevanat@quicinc.com>
 <20241220203638.2082002-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241220203638.2082002-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: taamrX2tna64l9h63xb1H9c6R4kpKHhp
X-Proofpoint-ORIG-GUID: taamrX2tna64l9h63xb1H9c6R4kpKHhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080198

On 12/20/2024 12:36 PM, Roopni Devanathan wrote:
...
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 562b0615ed06..93c4c2344b44 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -7404,6 +7404,382 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
>  	kfree(tb);
>  }
>  
> +static int ath12k_wmi_tpc_stats_copy_buffer(struct ath12k_base *ab,
> +					    const void *ptr, u16 tag, u16 len,
> +					    struct wmi_tpc_stats_info *tpc_stats)
> +{
> +	u32 len1, len2, len3, len4;
> +	s16 *dst_ptr;
> +	s8 *dst_ptr_ctl;
> +
> +	len1 = le32_to_cpu(tpc_stats->max_reg_allowed_power.tpc_reg_pwr.reg_array_len);
> +	len2 = le32_to_cpu(tpc_stats->rates_array1.tpc_rates_array.rate_array_len);
> +	len3 = le32_to_cpu(tpc_stats->rates_array2.tpc_rates_array.rate_array_len);
> +	len4 = le32_to_cpu(tpc_stats->ctl_array.tpc_ctl_pwr.ctl_array_len);
> +
> +	switch (le32_to_cpu(tpc_stats->event_count)) {

drivers/net/wireless/ath/ath12k/wmi.c:7434:17: warning: cast to restricted __le32

note the tpc_stats event_count is defined as u32, not __le32

...

> +static void ath12k_process_tpc_stats(struct ath12k_base *ab,
> +				     struct sk_buff *skb)
> +{
> +	struct ath12k_wmi_pdev_tpc_stats_event_fixed_params *fixed_param;
> +	struct wmi_tpc_stats_info *tpc_stats;
> +	const struct wmi_tlv *tlv;
> +	void *ptr = skb->data;
> +	struct ath12k *ar;
> +	u16 tlv_tag;
> +	u32 event_count;
> +	int ret;
> +

...

> +	}
> +	tpc_stats->pdev_id = fixed_param->pdev_id;
> +	tpc_stats->end_of_event = fixed_param->end_of_event;
> +	tpc_stats->event_count = fixed_param->event_count;

drivers/net/wireless/ath/ath12k/wmi.c:7773:28: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wmi.c:7773:28:    expected unsigned int [usertype] pdev_id
drivers/net/wireless/ath/ath12k/wmi.c:7773:28:    got restricted __le32 [usertype] pdev_id
drivers/net/wireless/ath/ath12k/wmi.c:7774:33: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wmi.c:7774:33:    expected unsigned int [usertype] end_of_event
drivers/net/wireless/ath/ath12k/wmi.c:7774:33:    got restricted __le32 [usertype] end_of_event
drivers/net/wireless/ath/ath12k/wmi.c:7775:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath12k/wmi.c:7775:32:    expected unsigned int [usertype] event_count
drivers/net/wireless/ath/ath12k/wmi.c:7775:32:    got restricted __le32 [usertype] event_count

These all need le32_to_cpu()

...

> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index b6a197389277..5193f4a7fed1 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h

...

> +struct wmi_tpc_stats_info {
> +	u32 pdev_id;
> +	u32 event_count;
> +	u32 end_of_event;
> +	u32 tlvs_rcvd;
> +	struct wmi_max_reg_power_allowed_params max_reg_allowed_power;
> +	struct wmi_tpc_rates_array_params rates_array1;
> +	struct wmi_tpc_rates_array_params rates_array2;
> +	struct wmi_tpc_config_params tpc_config;
> +	struct wmi_tpc_ctl_pwr_table_params ctl_array;
> +};


