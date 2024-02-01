Return-Path: <linux-wireless+bounces-2973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59076845FF2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 19:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8021C23147
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD112FB1E;
	Thu,  1 Feb 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bEDddMxr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAF3A1B7
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812267; cv=none; b=GmrpPhOs7RGMMLja8iOpUeL5s7zuBWrwpGhyCSPiRbcyQu/dH/mGeFYvEhki67UwG+7/TyC9gGE3OE+MPBhtAEVix7KGUA1DTYMQ66j2eWs/lcTfASjd2FLW/DivIttdTUG52W9BOA4B0k7WTflTdWMQr1TMTFVaxYVyrTn9Ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812267; c=relaxed/simple;
	bh=d7yQUq7IJi46heNKViPGy0wAZmjjtKj/OF9++BTNujg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MTxASO1Q+uX6V036LFgahAWYSxvwqOXNU9SYFkQqiHmANhrCsNh8okpi3W/o7bmsJhnE8OxXTKIpRUvEtNPJFoi3b7tknDcQhL2cg6+uaozKz8g8/fjk+0NQtGGyGrjLdc5VzByqBlb4njtEMmy62aeffgcfq4Mr7CREqG2nfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bEDddMxr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411CNl5i008947;
	Thu, 1 Feb 2024 18:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i/r3z0u37v4kOMDLXW9WEK0C6WQ5SlVn6CQrSXPhRBw=; b=bE
	DddMxrLEBWH+YYn2rToBCKCv/DZchGm4l8MXnCao8rEP7kQv/4zPQl6+zSY8CWtV
	H5Fjm1xlxl2ulss2oR8wORjYdRykUpqLy7Cifvd9nkuMhJTMX4GY+4Vn4ruoZ52y
	GhxNOeFMTzBcqelGGdChF+Ljyi8E6ejwQsu45la/1BuX3wwfKIrVDCV2QJkEVaV6
	+TWIgrAyc47sXMJr4uMRX6soa+X44AqBn+aZicjiTEj3IWmMeRFqkXztt4UZXwZw
	Ium8ff5CUwwFZI5+x0bgmNZ7E6lY8aMXZfC2+TcT5cQB8uZFfVpCtbLJYEUKMD2O
	bYBLS2kUrmKH3UUVbSKQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b1qrxrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 18:30:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411IUusH004756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 18:30:56 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 10:30:55 -0800
Message-ID: <3c20903a-11b1-4258-8b8d-e34394943640@quicinc.com>
Date: Thu, 1 Feb 2024 10:30:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: clean up FILS discovery change flags
 handling
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20240129195739.e340a7d5e7c6.I1dfcca32d43dce903494a2c474844491682671b4@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129195739.e340a7d5e7c6.I1dfcca32d43dce903494a2c474844491682671b4@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N1xh_g9x8ai9XRezy_6m0skpG_ejoZwA
X-Proofpoint-GUID: N1xh_g9x8ai9XRezy_6m0skpG_ejoZwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=889 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010142

On 1/29/2024 10:57 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> It doesn't make sense to return BSS change flags in an int, as
> they're a bigger type. For this particular function it still
> works OK, but clean it up to avoid future errors (or copying
> this code in a broken way.)
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  net/mac80211/cfg.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index e006d59087e7..8f647e28e354 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -952,7 +952,8 @@ ieee80211_set_probe_resp(struct ieee80211_sub_if_data *sdata,
>  static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
>  					struct cfg80211_fils_discovery *params,
>  					struct ieee80211_link_data *link,
> -					struct ieee80211_bss_conf *link_conf)
> +					struct ieee80211_bss_conf *link_conf,
> +					u64 *changed)
>  {
>  	struct fils_discovery_data *new, *old = NULL;
>  	struct ieee80211_fils_discovery *fd;
> @@ -979,7 +980,8 @@ static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data *sdata,
>  		RCU_INIT_POINTER(link->u.ap.fils_discovery, NULL);
>  	}
>  
> -	return BSS_CHANGED_FILS_DISCOVERY;
> +	*changed |= BSS_CHANGED_FILS_DISCOVERY;
> +	return 0;
>  }
>  
>  static int
> @@ -1441,10 +1443,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>  		goto error;
>  
>  	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery,
> -					   link, link_conf);
> +					   link, link_conf, &changed);
>  	if (err < 0)
>  		goto error;
> -	changed |= err;
>  
>  	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
>  						   &params->unsol_bcast_probe_resp,
> @@ -1516,10 +1517,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>  		return err;
>  
>  	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery,
> -					   link, link_conf);
> +					   link, link_conf, &changed);
>  	if (err < 0)
>  		return err;
> -	changed |= err;
>  
>  	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
>  						   &params->unsol_bcast_probe_resp,


