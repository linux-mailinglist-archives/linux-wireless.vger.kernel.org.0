Return-Path: <linux-wireless+bounces-13577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA92992537
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5943B215BC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1694815D5CF;
	Mon,  7 Oct 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HIj1CRWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088D15B130;
	Mon,  7 Oct 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284386; cv=none; b=UHhx0mD6FyAG8xWSslt53Qqsdn6Sv2SbDaK3e1YY4aocVY+H9rd2uSYPmk8sjDsWxA2kzMIrvphmG/2kaFIfFHM7lYRLJaqaLy2Nnj9Efqbyc/FP/8lEVI3QCB9tXIAGOmPAH+lT6s0znV7C3Wy4tomsf4HBgZm62mpC6QAxyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284386; c=relaxed/simple;
	bh=mtX51qEZRca3UuKZBd7V1kFyKvJf+7FHpPMVwKJgUm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tKVVx9SzhOkeIfG4/NYdgq7xX2BKID3m8W0UXnkB/6FGWMDvay4B7UPustsUhqirt5tcZNIRAi3gyQFYWM/izfjl9h/F0qut8lIJUBOrVlNn+cWL+f1xmDyOTz0N9Ii5ybbSlcgSg3DUgn9c8hxj9da9uH+j4vVgh1ODDVkR15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HIj1CRWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974TJFp020645;
	Mon, 7 Oct 2024 06:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uHfp8aMiuPWPdqDad8TMm0fShawjKs0JZ4jq/Zt1nw4=; b=HIj1CRWeFhsiSGKS
	mdGDNVKn8c/zrxxaXwfXakNqZJaucCypmfOg2sPOSnqH1FGmmqjA3XScpwxTy2fU
	2YDU48AuQYoNAdVX1rYpifAVnpj/L6izSjOosiTVD2xfagEEzCOIV07TzsvP+wr0
	OC8sZmLSjfDebNZG8lNCjAAl2wT6W4sqyVVqeUy0t/jrdWACLiOmlWWmxPIq2F6s
	0SXE+g9pay0CZUOJjEJfYR7kV5oOuu8fPFwLtSKLm7qvCcHME5G45nlv2VSdEg7B
	Vb0SBS4q6JpOhK2cR59ops7cZnDZwNg6S1P2WZ594N+EbP7C3Ss4IDQTji/YNm3e
	7J+gww==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xsnk8gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 06:59:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4976xVCC024335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Oct 2024 06:59:31 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 6 Oct 2024
 23:59:27 -0700
Message-ID: <831a7a48-2fed-c84c-dee5-8e74735309fb@quicinc.com>
Date: Mon, 7 Oct 2024 12:29:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] cfg80211: Remove unused cfg80211_background_cac_abort
Content-Language: en-US
To: <linux@treblig.org>, <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-wireless@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241006225303.121445-1-linux@treblig.org>
 <20241006225303.121445-2-linux@treblig.org>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20241006225303.121445-2-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3NxW-YabmgSM8csPwjp9T4DLcbwg3mCj
X-Proofpoint-ORIG-GUID: 3NxW-YabmgSM8csPwjp9T4DLcbwg3mCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070048



On 10/7/2024 4:23 AM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cfg80211_background_cac_abort() is unused.
> It got renamed from cfg80211_offchan_cac_abort by commit
> a95bfb876fa8 ("cfg80211: rename offchannel_chain structs to background_chain to avoid confusion with ETSI standard")
> 
> and that was originally added in commit
> 1507b1531981 ("cfg80211: move offchan_cac_event to a dedicated work")
> but never used.
> 
> To me it looks like the queue is still used (I see a queue_work
> in __cfg80211_radar_event), so I think it's just the wrapper that's
> unused.
> 
> Remove cfg80211_background_cac_abort.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   include/net/cfg80211.h | 9 ---------
>   net/wireless/mlme.c    | 8 --------
>   2 files changed, 17 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 69ec1eb41a09..fd843a519329 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -8752,15 +8752,6 @@ void cfg80211_cac_event(struct net_device *netdev,
>   			enum nl80211_radar_event event, gfp_t gfp,
>   			unsigned int link_id);
>   
> -/**
> - * cfg80211_background_cac_abort - Channel Availability Check offchan abort event
> - * @wiphy: the wiphy
> - *
> - * This function is called by the driver when a Channel Availability Check
> - * (CAC) is aborted by a offchannel dedicated chain.
> - */
> -void cfg80211_background_cac_abort(struct wiphy *wiphy);
> -
>   /**
>    * cfg80211_gtk_rekey_notify - notify userspace about driver rekeying
>    * @dev: network device
> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> index 4dac81854721..8ec236bbbc7c 100644
> --- a/net/wireless/mlme.c
> +++ b/net/wireless/mlme.c
> @@ -1226,14 +1226,6 @@ void cfg80211_background_cac_abort_wk(struct work_struct *work)
>   				      NL80211_RADAR_CAC_ABORTED);
>   }
>   
> -void cfg80211_background_cac_abort(struct wiphy *wiphy)
> -{
> -	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
> -
> -	queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
> -}
> -EXPORT_SYMBOL(cfg80211_background_cac_abort);
> -

We have an internal WIP ath driver implementation for background radar feature
calling this function to notify the background CAC abort state. There is definitely
real use case for this function.

Vasanth

