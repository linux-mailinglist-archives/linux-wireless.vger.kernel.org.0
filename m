Return-Path: <linux-wireless+bounces-2971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD31845FBA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339BA291F16
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9B12FB1B;
	Thu,  1 Feb 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UKj1+9Lv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97A7428A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811699; cv=none; b=aPMi5lfeAvnwkNE3Gfga1rawOYVdB5dDZXvMvOgW8fKy6B2Aq6u45kLqsybMfUeBjktCzqHZ/Io/KRcY12mmjyeM0GCWKnmRNca2i7C1JWmFWKsX/5CSefuSWlgomthdp2LXSu2ZqrM5ZlhbXZE0paki//O6TP00BWgie7XY5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811699; c=relaxed/simple;
	bh=NGI/ELzng3jIIkGxNs4kwcQn99TRMHrTqHnI3dE6Tbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IanYVehKv1z7xjNxlWHGg8eK/08RHKeQzYaLN6CxIOLD7+Qv2Q8u0eMuPFU+Svv+mHJVUMI3JK+W1e+bwTEx0Fepbv3OqziaBlnC82Hli+lYh5EhemSd5zbr156vZfpV969LjLDX2taJr46Y0YWl3g0Lha/8wAmosVj6k+jgnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UKj1+9Lv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4116Q2SP017218;
	Thu, 1 Feb 2024 18:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9QbPK55qOwnCFgat/5tt4TIiRg6DuX327D3VZLO3Ze8=; b=UK
	j1+9LvHUF1nCkFv/HY2h8D+fKBIbrkcqMSMmdlfQwnfaO5biuCnVWzRx5o6uByIw
	LXeq7vUVnVxBEfxhs9ClWbrisIUk4t9ORHNhALEy+wBF5lTunhjP77jo88W8lKyJ
	AT9F5wC+9jTaRDZYp8VpFt5kmgC23HG9mt3XQLTnuCoYk01K1Zf5hzJ7qAXyOssb
	MNedHvep/5phh1f0hUZlUTl+HxqYR8RY6R3fm04lnlGBpR3n/xKtWWqDaYRcoqwr
	kvPi4U2Pnzlyb1LHXhRk/sQirtKqEpEvHCDiYECIBrApV5Rx7AaTp+lvA9lnIm81
	6aA3j7l4bz4VX/7/qGBA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0619hu11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 18:21:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411ILU1h024482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 18:21:30 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 10:21:29 -0800
Message-ID: <acffd9a8-062a-4deb-a996-03fd71d3e357@quicinc.com>
Date: Thu, 1 Feb 2024 10:21:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: trace SMPS requests from driver
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20240129195435.b20d2ead2013.I8213e65c274451d523a3397519ac578c3ed2df4d@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129195435.b20d2ead2013.I8213e65c274451d523a3397519ac578c3ed2df4d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i2PxTZG38B6-TQBLwpV0Xph7tsSosUEf
X-Proofpoint-ORIG-GUID: i2PxTZG38B6-TQBLwpV0Xph7tsSosUEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=725 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010141

On 1/29/2024 10:54 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Even if there are a lot of possible ways drivers might
> call this, at least knowing when they do and with what
> settings can be useful. Add tracing for it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/ht.c    |  4 +++-
>  net/mac80211/trace.h | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
> index cfe2653ed47f..c3330aea4da3 100644
> --- a/net/mac80211/ht.c
> +++ b/net/mac80211/ht.c
> @@ -9,7 +9,7 @@
>   * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>   * Copyright 2007-2010, Intel Corporation
>   * Copyright 2017	Intel Deutschland GmbH
> - * Copyright(c) 2020-2023 Intel Corporation
> + * Copyright(c) 2020-2024 Intel Corporation
>   */
>  
>  #include <linux/ieee80211.h>
> @@ -603,6 +603,8 @@ void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
>  	if (WARN_ON(!link))
>  		goto out;
>  
> +	trace_api_request_smps(sdata->local, sdata, link, smps_mode);
> +
>  	if (link->u.mgd.driver_smps_mode == smps_mode)
>  		goto out;
>  
> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
> index 2d0d969f0c3d..806e762aa546 100644
> --- a/net/mac80211/trace.h
> +++ b/net/mac80211/trace.h
> @@ -2,7 +2,7 @@
>  /*
>   * Portions of this file
>   * Copyright(c) 2016-2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2023 Intel Corporation
> + * Copyright (C) 2018 - 2024 Intel Corporation
>   */
>  
>  #if !defined(__MAC80211_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
> @@ -3058,6 +3058,35 @@ TRACE_EVENT(api_radar_detected,
>  	)
>  );
>  
> +TRACE_EVENT(api_request_smps,
> +	TP_PROTO(struct ieee80211_local *local,
> +		 struct ieee80211_sub_if_data *sdata,
> +		 struct ieee80211_link_data *link,
> +		 enum ieee80211_smps_mode smps_mode),
> +
> +	TP_ARGS(local, sdata, link, smps_mode),
> +
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		VIF_ENTRY
> +		__field(int, link_id)
> +		__field(u32, smps_mode)
> +	),
> +
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		VIF_ASSIGN;
> +		__entry->link_id =
> +			ieee80211_vif_is_mld(&sdata->vif) ? link->link_id : -1;

why go to this trouble?
why not just print the link_id that was passed into
ieee80211_request_smps()? just so non-MLD will give -1 instead of 0?
seems all of the other existing trace functions just print the link_id
that was provided


> +		__entry->smps_mode = smps_mode;
> +	),
> +
> +	TP_printk(
> +		LOCAL_PR_FMT " " VIF_PR_FMT " link:%d, smps_mode:%d",
> +		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, __entry->smps_mode
> +	)
> +);
> +
>  /*
>   * Tracing for internal functions
>   * (which may also be called in response to driver calls)


