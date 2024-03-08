Return-Path: <linux-wireless+bounces-4500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31810876A13
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 18:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A341F21555
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3917745;
	Fri,  8 Mar 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MQWAfUpl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9CA3217
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919636; cv=none; b=G51kEBkYTT9ehQK3S0BEtY47b/vtxOceNKuHX97JKtD6q6NeuAe2qIG/zIxChPS+AIpA/xAXa1a1t+Tv4mCV8MCkZEercq4+CINspWxi0VytDcTw17yZON+iqfP+fNmZuEcmYezJbufFLKeYvWs2lzN+IE28gnj5enEk665JX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919636; c=relaxed/simple;
	bh=Hj8wb+9de1K4dcUoESzKFuYXKdIYwZDzn+i1vq/khQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KVLw3opEsLnGah8rwxmAu2rp0p+YoN1wss53rhicc1Gi6dAy1w6P2W2ysFmUMeeCCKILpfD/LX7hwHo2tE/3SZD78ph3OHNr/iU0Mtzo3OaWhqsElPRVIU8Vwj0E2dazDNxfSAViAFHrbtb1hvsC6OZVHin/ohLuh2POYgmaFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MQWAfUpl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428EDasb012920;
	Fri, 8 Mar 2024 17:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tAxJOHK/y8r3HpEc4iWNbFgEY/y83JJn47Cgt3l7pMs=; b=MQ
	WAfUpl1+5EU5R4Ewp7D7p2k3rzcA7JlcfNV2H0kdOBnQxBHqKEjJcBrB3+qJd22K
	Qi84NLMULhonM+P1McECg9+klYCHrKOlhaPwgb8kBTrq6zAg3p2oK/RU2xyRMpdz
	xci9/GRATgc2JxUTgjfv8XociGOMYI0KzHESUdto484ZpG5VwlBJ4pHsVpubXG4i
	ru2h8uSP3d5F7WZWg4jCObQFRy9FibD/4xJWBiTeFNl4t8XGv3/MJpbgxKKcQYKh
	QNq2WrLQIke1t/vjbiGSO8woL4TZEp2oVFgLU3F8Iz81g9TT2KB67dpCl0pr5n72
	TGTQ9pBfm1SCKmm44utA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr16y0uuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 17:40:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428HeVYf021955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 17:40:31 GMT
Received: from [10.110.115.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 8 Mar
 2024 09:40:31 -0800
Message-ID: <7ab9885b-5fb6-4686-b29b-d287e569293b@quicinc.com>
Date: Fri, 8 Mar 2024 09:40:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Improve bss-color configuration.
Content-Language: en-US
To: <greearb@candelatech.com>, <linux-wireless@vger.kernel.org>
References: <20240307181039.3219840-1-greearb@candelatech.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240307181039.3219840-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iFSaW9Q-KEOWyNI24LNInqOd7En7jAxA
X-Proofpoint-GUID: iFSaW9Q-KEOWyNI24LNInqOd7En7jAxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080141

On 3/7/2024 10:10 AM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Always tell driver to apply bss color settings if beacon indicates
> the bss coloring has been set.

why? please describe the problem you are fixing

> 
> And only enable bss coloring if beacon indicates bss color setting
> is valid and also enabled.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/cfg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 327682995c92..aaa62c05428c 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1314,7 +1314,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>  			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>  		changed |= BSS_CHANGED_HE_OBSS_PD;
>  
> -		if (params->beacon.he_bss_color.enabled)
> +		if (params->beacon.he_bss_color_valid)
>  			changed |= BSS_CHANGED_HE_BSS_COLOR;
>  	}
>  
> @@ -1494,6 +1494,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>  	int err;
>  	struct ieee80211_bss_conf *link_conf;
>  	u64 changed = 0;
> +	bool color_en;
>  
>  	lockdep_assert_wiphy(wiphy);
>  
> @@ -1530,9 +1531,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>  	if (err < 0)
>  		return err;
>  
> -	if (beacon->he_bss_color_valid &&
> -	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
> -		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
> +	color_en = beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
> +	if (color_en != link_conf->he_bss_color.enabled) {
> +		link_conf->he_bss_color.enabled = color_en;
>  		changed |= BSS_CHANGED_HE_BSS_COLOR;
>  	}
>  


