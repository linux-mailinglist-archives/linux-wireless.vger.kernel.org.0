Return-Path: <linux-wireless+bounces-7606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C197C8C486D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322811F239B8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118D1C69E;
	Mon, 13 May 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R+z5Zek6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AA80BE3
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633364; cv=none; b=X9CLRzW+ZuHy0LAL/txrSNVvsvDmlfEt/8SPLhQeYEmECpe8fXUYKaXvuYCBPB7Mn0/DEIgPolpg2wqwuh3oZaHY8vZfp8y4zsELltm1veMX0J+VQplDTSB/M2EWeZ6UBUi4l5DxGuCM1M+cXq4GzdoPel/jgWsT8FT+446Clo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633364; c=relaxed/simple;
	bh=o1UbK0oSv3FoQZj33uXuettiDgc4x627tgAlG8jXyWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DHOUP+/WaoVPtxxNWqUtBoEcP/P6QgHqJI1oqNKirrgg6yyi9qQT9ltkne+cZt7vl/9RJgee/bjPZUd3Y2HhRyekeCKJfZgm4gGZuIGTR6gDc5mjgFv+Gy48dJXBbWeg64sxfgLJHhjdkPXN1YhPO0LThQUal5w1EyYxwCFNoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R+z5Zek6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8uOE027896;
	Mon, 13 May 2024 20:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jd5G1vS7OgrCj4/8/GUWYn+CSWnQv8/Ka0YoKgujAcs=; b=R+
	z5Zek6v5YvFkKfKCFtFOXfvXBBg0miWvTtt/R2RRtaixoex1uKghUDiIqDYzI0Sx
	PDE1sNzNfKYuHxWItNrQYtgWLnwXKoqNBZ9EDckvvK03naOMOZoYuAAvhpOYfFtA
	BzI0SuR+6u1dtnXNvVQv5x/hb8mdyKKMEB0kRqeLTyCWxb/0UemmCdVvr2d5fL9N
	rAzmOXlt1BG0TDcE+jOiYiXCdkacvf87DRnmc2+rbn80BvCceIiPESmFMwy8Fdq2
	osZDdGObaz93YUn17/vBIeyxmlctH3R3aimkTHvw4L52PZ5HG+3yP5AagoqEitMG
	eg6wubR0ui/TDZZ5KlDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1y9mcnm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:49:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKnFln026969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:49:15 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:49:14 -0700
Message-ID: <3b7be076-9aa6-4f21-b9dc-7ee04cf26ce7@quicinc.com>
Date: Mon, 13 May 2024 13:49:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-2-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ew-ubF6pmNfGnbv4ah-CYDJHCW4f7JTW
X-Proofpoint-ORIG-GUID: ew-ubF6pmNfGnbv4ah-CYDJHCW4f7JTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130142

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
> to pass EHT MU-MIMO configurations from user space to driver.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  include/net/mac80211.h | 4 ++++
>  net/mac80211/cfg.c     | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index cafc664ee531..d7b6f75bc920 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -701,6 +701,9 @@ struct ieee80211_fils_discovery {
>   *	beamformee
>   * @eht_mu_beamformer: in AP-mode, does this BSS enable operation as an EHT MU
>   *	beamformer
> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP) or transmission

suggest you reformat to fit in 80 columns
(we allow code to exceed 80 columns when it improves readability, but comments
should almost never exceed 80 columns)

> + *	(non-AP STA) of an EHT TB PPDU on an RU that spans the entire PPDU
> + *	bandwidth
>   */
>  struct ieee80211_bss_conf {
>  	struct ieee80211_vif *vif;
> @@ -793,6 +796,7 @@ struct ieee80211_bss_conf {
>  	bool eht_su_beamformer;
>  	bool eht_su_beamformee;
>  	bool eht_mu_beamformer;
> +	bool eht_80mhz_full_bw_ul_mumimo;
>  };
>  
>  /**
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index b08e5d7687e3..96b2f31f0c8a 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1379,6 +1379,11 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>  				(IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
>  				 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
>  				 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ);
> +		link_conf->eht_80mhz_full_bw_ul_mumimo =
> +			params->eht_cap->fixed.phy_cap_info[7] &
> +				(IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_80MHZ |
> +				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_160MHZ |
> +				 IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ);
>  	} else {
>  		link_conf->eht_su_beamformer = false;
>  		link_conf->eht_su_beamformee = false;


