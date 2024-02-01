Return-Path: <linux-wireless+bounces-2975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C2846006
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 19:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC401C24122
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4093A1B7;
	Thu,  1 Feb 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HRfxQ8/8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BB12FB0E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812505; cv=none; b=pfxAubvDMa6bk82qZYRIu7AKPiTPn5k42J0TFKZiXo7SOkUW7+4kmQ/P64GDy60ohP0z71eFxM5WAryIzUQb9AGs66f7R2AIeEsfMxcWi6T2bY5CJpwnmjdejuYf6Fsg/fP/org/eNiPPCh5uIRkeu4OYOHVgAntwFDlqnF64OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812505; c=relaxed/simple;
	bh=r2FSee9H8E7x0ofwojV/6eC3+fnBSsnGlYVHLvC2re4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n7A7UoEOeDUJJUdtJ1L5Nw76eB7BVauKaGXb/dAWhLLM32v2zAbjbhQwL/0BKKzNxZl5esCQ11Yl0Hub3+oH7vM9+C/QKemgzaJDco7g4UNm9q23OAbroXaHlRltO46KFtgVZDEv5hJPrqx7zIzOAW2yuomlcodD5Lax0azM/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HRfxQ8/8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411IYw9Y018467;
	Thu, 1 Feb 2024 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oxXP5Y1FwhwScyynwzduuJ1A+HkJt9JkcKS8cVcGhCc=; b=HR
	fxQ8/8jYlNwVwc2QMt128AlzY2jVTJY7eDfrWdCHZc+Q3CNinI+PxsLZ/P0jB3Yt
	ImUFZA+36cKprMI//49iUyLRbcUmn9YjW9XhpbgBV7xDeQkjjM8j1ALnQEluldtL
	xbJIIc9rJ+SfGI+73IybEc2Tr3kJThrL4xtvxVBuCC7iOkmXOrh8mmJ6z3bgMvao
	YlTZkZHnaSJ9ma5NQ/iEQgyyncqFaizci3p6Jy9OSmGypOi0O9kZ2DrrnRRn/sOn
	ynWSW/R4lR9cTIea0iFiJ51C8RY5xcM0UUGiJbjR+nXsvRP3Bu5OX+zvb7Cm2UAA
	wHASnbcWFdsekK7d3hmQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w09q694rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 18:34:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411IYv4V006091
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 18:34:57 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 10:34:56 -0800
Message-ID: <143fa5d0-f509-431b-94d6-6c1759d3152d@quicinc.com>
Date: Thu, 1 Feb 2024 10:34:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211_hwsim: add control to skip beacons
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20240129200001.a267383709e6.I36f427d17c3478a7df46e205716f5ebc9b35a918@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240129200001.a267383709e6.I36f427d17c3478a7df46e205716f5ebc9b35a918@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mViIKi47LIf0Dm4z0WPKnVi-xQnhQjRW
X-Proofpoint-GUID: mViIKi47LIf0Dm4z0WPKnVi-xQnhQjRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010144

On 1/29/2024 11:00 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> To test certain beacon loss scenarios it can be useful to
> simply not send a couple of beacons. Add a simple debugfs
> file (per vif) to skip sending the beacons. They're still
> fully prepared etc. so their DTIM count etc. will appear
> as if they were simply corrupt over the air or otherwise
> not received.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index 62a5839f5385..59ec6aa5ac26 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -213,6 +213,7 @@ static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
>  
>  struct hwsim_vif_priv {
>  	u32 magic;
> +	u32 skip_beacons;
>  	u8 bssid[ETH_ALEN];
>  	bool assoc;
>  	bool bcn_en;
> @@ -2128,6 +2129,16 @@ static int mac80211_hwsim_add_interface(struct ieee80211_hw *hw,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_MAC80211_DEBUGFS
> +static void mac80211_hwsim_vif_add_debugfs(struct ieee80211_hw *hw,
> +					   struct ieee80211_vif *vif)
> +{
> +	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
> +
> +	debugfs_create_u32("skip_beacons", 0600, vif->debugfs_dir,
> +			   &vp->skip_beacons);
> +}
> +#endif
>  
>  static int mac80211_hwsim_change_interface(struct ieee80211_hw *hw,
>  					   struct ieee80211_vif *vif,
> @@ -2193,12 +2204,19 @@ static void __mac80211_hwsim_beacon_tx(struct ieee80211_bss_conf *link_conf,
>  				       struct ieee80211_vif *vif,
>  				       struct sk_buff *skb)
>  {
> +	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
>  	struct ieee80211_tx_info *info;
>  	struct ieee80211_rate *txrate;
>  	struct ieee80211_mgmt *mgmt;
>  	/* TODO: get MCS */
>  	int bitrate = 100;
>  
> +	if (vp->skip_beacons) {
> +		vp->skip_beacons--;
> +		dev_kfree_skb(skb);
> +		return;
> +	}
> +
>  	info = IEEE80211_SKB_CB(skb);
>  	if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
>  		ieee80211_get_tx_rates(vif, NULL, skb,
> @@ -3857,6 +3875,13 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
>  	return err;
>  }
>  
> +#ifdef CONFIG_MAC80211_DEBUGFS
> +#define HWSIM_DEBUGFS_OPS					\
> +	.vif_add_debugfs = mac80211_hwsim_vif_add_debugfs,
> +#else
> +#define HWSIM_DEBUGFS_OPS
> +#endif
> +
>  #define HWSIM_COMMON_OPS					\
>  	.tx = mac80211_hwsim_tx,				\
>  	.wake_tx_queue = ieee80211_handle_wake_tx_queue,	\
> @@ -3881,7 +3906,8 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
>  	.get_et_stats = mac80211_hwsim_get_et_stats,		\
>  	.get_et_strings = mac80211_hwsim_get_et_strings,	\
>  	.start_pmsr = mac80211_hwsim_start_pmsr,		\
> -	.abort_pmsr = mac80211_hwsim_abort_pmsr,
> +	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
> +	HWSIM_DEBUGFS_OPS
>  
>  #define HWSIM_NON_MLO_OPS					\
>  	.sta_add = mac80211_hwsim_sta_add,			\


