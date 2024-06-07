Return-Path: <linux-wireless+bounces-8670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93C8FFF3D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482261F2A233
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04B15B577;
	Fri,  7 Jun 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K1WLyXVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4915B57D
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752141; cv=none; b=ir/7swN4ILkFQzwy49ntD2Zb3Gito2hjXZODFce4DrDNO4KfGKWYlBcwEyQIv1goVE3U50rsAjyI1aeDFfJpqtApoGVqz6bFtDZeG+MxTLz8Q5ft6y49ywBmOBDr+uERLBR2VHSQYW+bpkplyMDApJhUApv1cUKWHEvLhHMCpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752141; c=relaxed/simple;
	bh=Cqs94uHuNbE2MNix3WjHWScsDmatP2pJST5X5mIVANA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mHfVYc19TbZPsySUOWJb/DSLm/4DXR2EUFAlRPjjzpu5TUC7JdV5CUEeeSGAFXSMxyEOA19ARcRuWVDWHkgcIKSMIy4KR+wRH/So9vLKDDPcRIL8GpAEQT969U5yVCCizxifYckC0QXNgaLWkj/jC92V+9RqKODi0wk3aM7DYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K1WLyXVN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45711VvZ004023;
	Fri, 7 Jun 2024 09:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lYAGDi5z6n41xlWTm9z8djrbrvPo59873O1hucGZrr4=; b=K1WLyXVNrGCC1vLa
	jtVoN80h9gTQQTyD1Uhy0U98AsBC/N2UwjYxZ8kn41UfrILVCSAMyzhgeeAayrgd
	5hlCaNAlGjX8W6vgo2j67D3VY+f4TdXLku8IFU6KRSOciXqaO6CkiAJxG7thOS9Z
	ZzfnlT3EqKwBAGRjFArN/C4aRPXl/YOhzz0dDcDxdL2B966q3X2GJ98y75XSneRb
	GjpOao7W01J/eIvIn61MZQIEi1GtVtzAlW0G1XNxNokwtQvr7RQtEletTjlqVzZ+
	mYW12IPg3ZoRL7Vrztuy/wB2oCyzg2SgZuQ1muzp3jB16o/QBkdKLXQQ2ML/qe20
	SnI82A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjxxav05a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 09:22:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4579M9dW016432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 09:22:09 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 02:22:08 -0700
Message-ID: <13153c89-7f7c-21df-9a44-0db9ca1e6e28@quicinc.com>
Date: Fri, 7 Jun 2024 14:52:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for
 multi-radio
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qoJw3RjAtfmo1-ezXURoFXAxEuihR3f6
X-Proofpoint-GUID: qoJw3RjAtfmo1-ezXURoFXAxEuihR3f6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=627 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070067



On 6/6/2024 11:37 PM, Felix Fietkau wrote:

...

>   
> +static u32
> +__ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_chanctx_conf *conf;
> +	struct ieee80211_link_data *link;
> +	u32 mask = 0;
> +
> +	for_each_sdata_link(local, link) {
> +		conf = rcu_dereference(link->conf->chanctx_conf);
> +		if (!conf || conf->radio_idx < 0)
> +			continue;
> +
> +		mask |= BIT(conf->radio_idx);
> +	}
> +
> +	return mask;
> +}
> +
> +int ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev,
> +			     u32 *mask)
> +{
> +	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
> +
> +	*mask = __ieee80211_get_radio_mask(sdata);
> +
> +	return 0;
> +}
> +
> +static bool
> +ieee80211_sdata_uses_radio(struct ieee80211_sub_if_data *sdata, int radio_idx)
> +{
> +	if (radio_idx < 0)
> +		return true;
> +
> +	return __ieee80211_get_radio_mask(sdata) & BIT(radio_idx);
> +}
> +
> +static void
> +ieee80211_fill_ifcomb_params(struct ieee80211_local *local,
> +			     struct iface_combination_params *params,
> +			     const struct cfg80211_chan_def *chandef,
> +			     struct ieee80211_sub_if_data *sdata,
> +			     int radio_idx)
> +{
> +	struct ieee80211_sub_if_data *sdata_iter;
> +	struct ieee80211_chanctx *ctx;
> +
> +	list_for_each_entry(ctx, &local->chanctx_list, list) {
> +		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
> +			continue;
> +
> +		if (radio_idx >= 0 && ctx->conf.radio_idx != radio_idx)
> +			continue;
> +
> +		if (chandef &&
> +		    cfg80211_chandef_compatible(chandef, &ctx->conf.def))
> +			continue;
> +
> +		params->num_different_channels++;
> +
> +		params->radar_detect |=
> +			ieee80211_chanctx_radar_detect(local, ctx);
> +	}
> +
> +	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
> +		struct wireless_dev *wdev_iter;
> +
> +		wdev_iter = &sdata_iter->wdev;
> +
> +		if (sdata_iter == sdata ||
> +		    !ieee80211_sdata_running(sdata_iter) ||
> +		    cfg80211_iftype_allowed(local->hw.wiphy,
> +					    wdev_iter->iftype, 0, 1))
> +			continue;
> +
> +		if (!ieee80211_sdata_uses_radio(sdata_iter, radio_idx))
> +			continue;
> +
> +		params->iftype_num[wdev_iter->iftype]++;
> +	}
> +}
> +
>   int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>   				 const struct cfg80211_chan_def *chandef,
>   				 enum ieee80211_chanctx_mode chanmode,
> -				 u8 radar_detect)
> +				 u8 radar_detect, int radio_idx)
>   {
> +	bool shared = chanmode == IEEE80211_CHANCTX_SHARED;
>   	struct ieee80211_local *local = sdata->local;
> -	struct ieee80211_sub_if_data *sdata_iter;
>   	enum nl80211_iftype iftype = sdata->wdev.iftype;
>   	struct ieee80211_chanctx *ctx;
>   	int total = 1;
> @@ -3977,6 +4060,8 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>   	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
>   		params.iftype_num[iftype] = 1;
>   
> +	ieee80211_fill_ifcomb_params(local, &params, shared ? chandef : NULL,
> +				     sdata, radio_idx);
>   	list_for_each_entry(ctx, &local->chanctx_list, list) {
>   		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
>   			continue;
> @@ -3986,28 +4071,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
>   			params.num_different_channels++;
>   			continue;
>   		}
> -		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
> -		    cfg80211_chandef_compatible(chandef,
> -						&ctx->conf.def))
> -			continue;
>   		params.num_different_channels++;
>   	}
>   
> -	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
> -		struct wireless_dev *wdev_iter;
> -
> -		wdev_iter = &sdata_iter->wdev;
> -
> -		if (sdata_iter == sdata ||
> -		    !ieee80211_sdata_running(sdata_iter) ||
> -		    cfg80211_iftype_allowed(local->hw.wiphy,
> -					    wdev_iter->iftype, 0, 1))
> -			continue;
> -
> -		params.iftype_num[wdev_iter->iftype]++;
> -		total++;
> -	}
> -
>   	if (total == 1 && !params.radar_detect)
>   		return 0;

ieee80211_check_combinations() missed to update "params.radio", no ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

