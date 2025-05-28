Return-Path: <linux-wireless+bounces-23477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C8AC6FEF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8715B9E7F07
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06328DEE1;
	Wed, 28 May 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8Gyemx6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A31B6D06
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454485; cv=none; b=ArN6cx/DCl1zdFDeTFXlfeOXlwFXft67e2a8cqRc/ipgKAV9n7OG3idi8OPoHtmr9uxylZNWmPXXPcdm1YtkyRnqtIli5xnU5S/uCJd855yk+/v5FXR7SeG1eZiJS43cLrgw45IfLF+WJmWpMvtxVHOeKCufh6Q3d8vHh+oPm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454485; c=relaxed/simple;
	bh=YN1R9GeDKPAs3P4xpVhJpwFsaUOT17ULrTuPwwiW8XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5GDktw1wQ2GussXIQ/ODuXHhLORkDp0m2+38/fCG+yNIzfXXE9WRLXuOEmXR1CoBwnsQ/Cm8kLNzEXxrSOefKM8gk41IyZK12wQgUMhsiGQvo80ebZpRsEZXwlsC7A2f3FJKeRqN9QowqVOSQotJxgv+agegrfaoTe5ZFTGJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8Gyemx6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SHTV4A022136
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L4R1ylBzhfNH7Bcj4NNRaz28200uGYphZIhzwb3ZnlU=; b=I8Gyemx6sXw8d7NO
	NUFg/G0Z9UXfbYdE28opnPU1HHm1lDdRzDHBWEUGU6y9FDZNdzNhahLUsXPqm5+5
	dj50T8+0JjLQPe3nq8tgf4UyvXDx+z3xPmg1cuEWVCQPr+xlo5OrnDPkPGCRUO7i
	dkWBqvvZcJhNVVLcyjrYeJwrsB2KWsvMjTdkAdedIM1q4o3fneLs3oQFaa3Wz2F/
	H1K7dNyKGLM2eMYy0LZJhbNyEO8yGOHEVIgLUbRRZwG2ezpkqeXt2WvNgJ910TPF
	CwPK5GDjVknJDbQrWoCRwxMcUr5VUMhNYrnlEMC+WtF1DV93LbFHt2UWD4thOrH5
	7X+BXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x6xc81f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:48:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74299055c3dso6878b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 10:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748454482; x=1749059282;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4R1ylBzhfNH7Bcj4NNRaz28200uGYphZIhzwb3ZnlU=;
        b=tvUuIgYxFGptLmA3J8EBDFmG42aE1b53afX6nwkW3ACdqer890SCBcT4kNHay+og7f
         wRcHj4ow+3uBGdOwSZwHoJ5cDmgOp/tcC3jyY95MrZvScLAKTB1zgAFfpDfI+oK7n9hq
         TSc4fgciP/kPBvbdjTFB3+AH+GO33BFU4b9jG0Gt6PTr+8R2eszgP2JC5F8tOurtc27o
         Hl4gtSexn2mIJST3eQ7wtk987EbKD1QMJErWVsqn7JTL4ZgvL/66wZPzNMoS/GJmQdUS
         wjsMEdW+sd8lLXfCoaMKMvKhvbma8Yrnn/xSap9UCSkeUx/n+LT6AT2dzhNBIiv1iMns
         SM+g==
X-Gm-Message-State: AOJu0YwDmTxKddZOcbTFsbM+Mi3ALXxmaJsh4ku8xf7iCtuvg2tQ36Zm
	IZ0GyNjYolpvh8S58RW6lTpr2X0KwostGhh4KNqCAVq0oMlxvyrP970S5ibr9wWSPd2pL1hgcgf
	u2yVuVS/dMOGeOYfoCQqOH2lXwehkoqhHTapJGUSG/Zv5NVr/mNSZtWLESwUF4JgC0vSElA==
X-Gm-Gg: ASbGncuGgKkEdYi5rRluyTxBAin0fPyX95moHM8ehKkEyc7ZAwg95KRrE5qQdhduYSz
	hJ6oQk0n/0ehX2IQfllKhTzsyWLh0Mty3MBdhKl1KzgwFK6Qge0wn5dJ7k1RUhwI+S17Wqkb8cZ
	vsLdBGMzSv/JO7z3m7agIVKfV9Siwa75dE/pOP2t9u499cvEM+2iq/gl+RrVwgks9GtTovxtT8n
	rWIM86IB8bvFmmX126IkRjm1lcHL4YNDYPLG94UjnI4g3qAk8UJk+HINK0JX/ZK2LLaP0LsaodL
	3ujKD322GUfXsr+Qtqjz2tailC2pVvl901dh2ZaeN+I5JCWYsWAHZiPYhxaTOuRpFGk=
X-Received: by 2002:a05:6a00:3a1e:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-745fdf77ab7mr27332489b3a.12.1748454481625;
        Wed, 28 May 2025 10:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6b2gE7y8u4tycjNo0k9VudSA4ccypZ+N3uMqtNF/s621+7sk/8GW6JVxWt1uvDakX1DPBEA==
X-Received: by 2002:a05:6a00:3a1e:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-745fdf77ab7mr27332462b3a.12.1748454481166;
        Wed, 28 May 2025 10:48:01 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746d6049ff4sm1504307b3a.72.2025.05.28.10.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 10:48:00 -0700 (PDT)
Message-ID: <223cec63-39f1-47d3-8488-e3a3fbbb35de@oss.qualcomm.com>
Date: Wed, 28 May 2025 10:47:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 1/3] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
 <20250522053326.4139256-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522053326.4139256-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1NCBTYWx0ZWRfXz6AhVHawSEVy
 uhfVwae2CGZTaEQLlr/J+y+JFfv0PKsdM+I+IbTZQcoS5XyF6Vpe0ANNptQpMR9qQVjNSGQOHxU
 EkVBImL8RmYk3JA0CS3C+H9kbDVeN/oPjpVBqvHsf8PofEp/UTPyGbek7GXBAwLa3JKNq7yDj6T
 EGY+pXA6Uf9i1luOaU0DWV4/AKlyIoltN5x1JH1yQoiqu+7CYkCqSvpnsxxQ5swVOJSyNrkkJAO
 Y/4Zwipk+UD8UVJPSv3gIpU6R2xoxF5pQ2kEeByu9vvrQ3J5m8wh7SOFJMrhf857LwbwPXTJ+UI
 3tU6wkG+BIob48oQTI6pDn2aUDRpSDKaHBjpW9TPWJjQKbrP3HFlPzckPB8n+aDIo5hM91YOI1C
 vDxBMRiId8CNNGPWAtSmShEnrQ3U5gc93alVmFeTvtp5SAInfHlu+s5n+v+BIVkAinnFZ/7N
X-Proofpoint-GUID: MOCzPruLdE29MtjikPJJZnfr0YpdwzGE
X-Proofpoint-ORIG-GUID: MOCzPruLdE29MtjikPJJZnfr0YpdwzGE
X-Authority-Analysis: v=2.4 cv=bupMBFai c=1 sm=1 tr=0 ts=68374c52 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=-3pVOwV6aIE-65dYeLoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280154

On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
...
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index fd5f79266471..4e8507649d15 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -854,6 +854,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
>  	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
>  	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
>  	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
> +	[NL80211_ATTR_WIPHY_RADIO_INDEX] = { .type = NLA_U8 },
>  };
>  
>  /* policy for the key attributes */
> @@ -3608,6 +3609,33 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
>  	return __nl80211_set_channel(rdev, netdev, info, link_id);
>  }
>  
> +static int nl80211_set_wiphy_radio(struct genl_info *info,
> +				   struct cfg80211_registered_device *rdev,
> +				   int radio_id)

refer to prior comment about s/radio_id/radio_idx/g

> +{
> +	u32 rts_threshold = 0, old_rts, changed = 0;
> +	int result;
> +
> +	if (!rdev->ops->set_wiphy_params)
> +		return -EOPNOTSUPP;
> +
> +	if (info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]) {
> +		rts_threshold = nla_get_u32(
> +				info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]);
> +		changed |= WIPHY_PARAM_RTS_THRESHOLD;
> +	}
> +
> +	old_rts = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
> +
> +	rdev->wiphy.radio_cfg[radio_id].rts_threshold = rts_threshold;
> +
> +	result = rdev_set_wiphy_params(rdev, radio_id, changed);
> +	if (result)
> +		rdev->wiphy.radio_cfg[radio_id].rts_threshold = old_rts;
> +
> +	return 0;
> +}
> +
>  static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct cfg80211_registered_device *rdev = NULL;
> @@ -3617,6 +3645,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *nl_txq_params;
>  	u32 changed;
>  	u8 retry_short = 0, retry_long = 0;
> +	int radio_id = -1;
>  	u32 frag_threshold = 0, rts_threshold = 0;
>  	u8 coverage_class = 0;
>  	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
> @@ -3670,6 +3699,19 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  	if (result)
>  		return result;
>  
> +	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
> +		/* Radio idx is not expected for non-multi radio wiphy */
> +		if (rdev->wiphy.n_radio <= 0)
> +			return -EINVAL;
> +
> +		radio_id = nla_get_u8(
> +				info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
> +		if (radio_id >= rdev->wiphy.n_radio)
> +			return -EINVAL;
> +		else
> +			return nl80211_set_wiphy_radio(info, rdev, radio_id);

nit: no need for else after return, so the above two lines should be just:

		return nl80211_set_wiphy_radio(info, rdev, radio_id);

> +	}
> +
>  	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
>  		struct ieee80211_txq_params txq_params;
>  		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
> @@ -3879,16 +3921,26 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  	if (changed) {
>  		u8 old_retry_short, old_retry_long;
>  		u32 old_frag_threshold, old_rts_threshold;
> -		u8 old_coverage_class;
> +		u8 old_coverage_class, i;
>  		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
> +		u32 *old_radio_rts_threshold;
>  
>  		if (!rdev->ops->set_wiphy_params)
>  			return -EOPNOTSUPP;
>  
> +		old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio,
> +						  sizeof(u32),
> +						  GFP_KERNEL);

can't n_radio be 0 for legacy drivers, and hence this will attempt to allocate
a zero-sized block of memory?

seems the allocation and references need to be guarded by:
		if (rdev->wiphy.n_radio)

> +		if (!old_radio_rts_threshold)
> +			return -ENOMEM;
> +
>  		old_retry_short = rdev->wiphy.retry_short;
>  		old_retry_long = rdev->wiphy.retry_long;
>  		old_frag_threshold = rdev->wiphy.frag_threshold;
>  		old_rts_threshold = rdev->wiphy.rts_threshold;
> +		for (i = 0 ; i < rdev->wiphy.n_radio; i++)
> +			old_radio_rts_threshold[i] =
> +				rdev->wiphy.radio_cfg[i].rts_threshold;
>  		old_coverage_class = rdev->wiphy.coverage_class;
>  		old_txq_limit = rdev->wiphy.txq_limit;
>  		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
> @@ -3900,8 +3952,12 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  			rdev->wiphy.retry_long = retry_long;
>  		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
>  			rdev->wiphy.frag_threshold = frag_threshold;
> -		if (changed & WIPHY_PARAM_RTS_THRESHOLD)
> +		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
>  			rdev->wiphy.rts_threshold = rts_threshold;
> +			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
> +				rdev->wiphy.radio_cfg[i].rts_threshold =
> +					rdev->wiphy.rts_threshold;
> +		}
>  		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
>  			rdev->wiphy.coverage_class = coverage_class;
>  		if (changed & WIPHY_PARAM_TXQ_LIMIT)
> @@ -3911,18 +3967,23 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>  		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
>  			rdev->wiphy.txq_quantum = txq_quantum;
>  
> -		result = rdev_set_wiphy_params(rdev, changed);
> +		result = rdev_set_wiphy_params(rdev, radio_id, changed);
>  		if (result) {
>  			rdev->wiphy.retry_short = old_retry_short;
>  			rdev->wiphy.retry_long = old_retry_long;
>  			rdev->wiphy.frag_threshold = old_frag_threshold;
>  			rdev->wiphy.rts_threshold = old_rts_threshold;
> +			for (i = 0 ; i < rdev->wiphy.n_radio; i++)
> +				rdev->wiphy.radio_cfg[i].rts_threshold =
> +					old_radio_rts_threshold[i];
>  			rdev->wiphy.coverage_class = old_coverage_class;
>  			rdev->wiphy.txq_limit = old_txq_limit;
>  			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
>  			rdev->wiphy.txq_quantum = old_txq_quantum;
> -			return result;
>  		}
> +
> +		kfree(old_radio_rts_threshold);
> +		return result;
>  	}
>  
>  	return 0;

