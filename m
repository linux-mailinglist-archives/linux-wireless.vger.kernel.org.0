Return-Path: <linux-wireless+bounces-2972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE180845FE1
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 19:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1C1F23836
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F612FB29;
	Thu,  1 Feb 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OP0HNziF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD17C6D0
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812137; cv=none; b=FTOIoHW0rNUfrF/DAkHRLAHLGq5mv9+QTr+vEreXT9hNju+hJl5f3nPsHrazYXTpYUz6hndAwuKq96ZfY70Zke2IkoEqCTFxpddPTzBv5ZC0x/voG1XIEhc8lJNOPum7S/YXOvYwy+8KGsKtJaEIYPCMZY/2bvP8L4airYQQD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812137; c=relaxed/simple;
	bh=QANjAiAoVt9IhYISZuxDeZeTodKH0j8t8wHAP5jA620=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ulBZslGnwheToD90PqylR8+AbZIK47GsK4ZoEQcjMlkGt+zMYVP2n3dWeIOgZttdN0W3ztUscb6OZiYsgSOJeOcjHUI5CnYNrbRdXzQxR2nHxfeJS2OFpnGwvP3h0mLdTFfM2My64UI/uAYRwrgpRoad1J2FVkQ/y/0Mf6ydIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OP0HNziF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411Af26V029719;
	Thu, 1 Feb 2024 18:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jpV/wJjP2ulgbk3dO9M8ZtNEeMsESVfaPjl1w/A+aX4=; b=OP
	0HNziFQRKAgC+41TUAkRHQb5tluP2e4TuRm6Vrpz8+XvoCyhx9xZz3RbIl4KnioC
	Ta1vgsvqJunq/4mpvOKkkc+YaDi+LTp24RAnz/BPipwyFuxq+8fCpwxFSZNVdzux
	MRQ+ZX+6FCUoF25UT0OYL0qfXOTH+9g5N6VPJr565LXf6IihoRGXyVaVpaqLjtWW
	tsEc6cyYjd4W8JajMPKm5xc56x9dfZB8yoxSRnxYxFT+XWo1+wAkeJEWxYozEyHd
	qMdZEDDurP7pgzStp8vlqeO9ZcATDXiPwaEj+fgo7daKXyszaPEOtbK+o4TJOvrG
	52DoDsfBOmcYAu4MxMLQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w06mnsr4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 18:28:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411ISAjM001719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 18:28:10 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 10:28:09 -0800
Message-ID: <39db19fd-c75b-4467-ad74-ce52a039a159@quicinc.com>
Date: Thu, 1 Feb 2024 10:28:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix unsolicited broadcast probe config
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Aloka Dixit
	<quic_alokad@quicinc.com>
References: <20240129195729.965b0740bf80.I6bc6f5236863f686c17d689be541b1dd2633c417@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129195729.965b0740bf80.I6bc6f5236863f686c17d689be541b1dd2633c417@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PKXVkY1nFXW5g5GTCcVyvf_j7CM-KHud
X-Proofpoint-ORIG-GUID: PKXVkY1nFXW5g5GTCcVyvf_j7CM-KHud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=947 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010142

On 1/29/2024 10:57 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There's a bug in ieee80211_set_unsol_bcast_probe_resp(), it tries
> to return BSS_CHANGED_UNSOL_BCAST_PROBE_RESP (which has the value
> 1<<31) in an int, which makes it negative and considered an error.
> Fix this by passing the changed flags to set separately.
> 
> Fixes: 3b1c256eb4ae ("wifi: mac80211: fixes in FILS discovery updates")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  net/mac80211/cfg.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 321698012e12..327682995c92 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -5,7 +5,7 @@
>   * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
>   * Copyright 2013-2015  Intel Mobile Communications GmbH
>   * Copyright (C) 2015-2017 Intel Deutschland GmbH
> - * Copyright (C) 2018-2022 Intel Corporation
> + * Copyright (C) 2018-2024 Intel Corporation
>   */
>  
>  #include <linux/ieee80211.h>
> @@ -987,7 +987,8 @@ static int
>  ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
>  				     struct cfg80211_unsol_bcast_probe_resp *params,
>  				     struct ieee80211_link_data *link,
> -				     struct ieee80211_bss_conf *link_conf)
> +				     struct ieee80211_bss_conf *link_conf,
> +				     u64 *changed)
>  {
>  	struct unsol_bcast_probe_resp_data *new, *old = NULL;
>  
> @@ -1011,7 +1012,8 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
>  		RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
>  	}
>  
> -	return BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
> +	*changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
> +	return 0;
>  }
>  
>  static int ieee80211_set_ftm_responder_params(
> @@ -1450,10 +1452,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>  
>  	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
>  						   &params->unsol_bcast_probe_resp,
> -						   link, link_conf);
> +						   link, link_conf, &changed);
>  	if (err < 0)
>  		goto error;
> -	changed |= err;
>  
>  	err = drv_start_ap(sdata->local, sdata, link_conf);
>  	if (err) {
> @@ -1525,10 +1526,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>  
>  	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
>  						   &params->unsol_bcast_probe_resp,
> -						   link, link_conf);
> +						   link, link_conf, &changed);
>  	if (err < 0)
>  		return err;
> -	changed |= err;
>  
>  	if (beacon->he_bss_color_valid &&
>  	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {


