Return-Path: <linux-wireless+bounces-518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D1807CC3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 01:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B802EB2104A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937F173;
	Thu,  7 Dec 2023 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h73upDiy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D4D1
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 16:07:27 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6MTlOL004790;
	Thu, 7 Dec 2023 00:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m8EY+hxPqYDNDst8AkzCtvWV0zDIKM4EMIlqkhupICE=;
 b=h73upDiylFawEdjAnLWNULa1txWewGBOyFfXOXf1U1xK7ThK2RuyA2YjlQh7yzOaaV1F
 CGxKHE/MPuzPL+GhplMfw30CuGrzEVdAAubRSz4upjqmJI8cFysI8P2XeOSKUiE6y5Rb
 dz4piUN8n4PL8gzVi3qydAaIshLasgMfI5cgIQiEC2BygMJ9d97g6o0U68DBk6jgPf6Q
 gYDrd6kjnBC/u15CsdScg1rVFibPWcti26Ws/zSxXqY/Z+bKAr3314yYDwn9lUdFfFmj
 ey3rgfwAEIkrN5NT0feIcLyZXk9/GEybrkWBiQBQFquS1N6d82BOspm7PfIzJjg/gGjS Tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdebbceh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 00:07:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B70751w010530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 00:07:05 GMT
Received: from [10.110.111.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 16:07:04 -0800
Message-ID: <50a6f31a-ef28-496c-acf4-0521034e43a1@quicinc.com>
Date: Wed, 6 Dec 2023 16:07:03 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Fix SMPS action frame ht cap check
Content-Language: en-US
To: Allen Ye <allen.ye@mediatek.com>, <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        "Money . Wang" <money.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Thomas Wu <quic_wthomas@quicinc.com>
References: <20231206024708.24831-1-allen.ye@mediatek.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231206024708.24831-1-allen.ye@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DqS6-M-qghFIKBsIm7_1WVBiDv5qIWx1
X-Proofpoint-GUID: DqS6-M-qghFIKBsIm7_1WVBiDv5qIWx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_21,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060178

On 12/5/2023 6:47 PM, Allen Ye wrote:
> From: "Allen.Ye" <allen.ye@mediatek.com>
> 
> Since there is no HT BSS in 6GHz, the HT Cap check would stop 6G HE/EHT
> BSS from processing the HT action frame for SM Power Save which can be
> also used in an HE BSS. Therefore, we remove the HT Cap check in 6GHz and
> add the HE check accordingly.
> 
> Signed-off-by: Money.Wang <money.wang@mediatek.com>
> Signed-off-by: Allen.Ye <allen.ye@mediatek.com>
> ---
>  net/mac80211/rx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 64352e4e6d00..f8cd14dc58ec 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -3482,7 +3482,8 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
>  	switch (mgmt->u.action.category) {
>  	case WLAN_CATEGORY_HT:
>  		/* reject HT action frames from stations not supporting HT */
> -		if (!rx->link_sta->pub->ht_cap.ht_supported)
> +		if (status->band != NL80211_BAND_6GHZ &&
> +		    !rx->link_sta->pub->ht_cap.ht_supported)

we had found the same issue and were preparing a patch that changed this to:
+		if (!rx->link_sta->pub->ht_cap.ht_supported &&
+		    !rx->link_sta->pub->he_cap.has_he)

I see you added the has_he check below, but curious if it is better to
do it here to short circuit the tests that follow

>  			goto invalid;
>  
>  		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
> @@ -3502,6 +3503,12 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
>  			enum ieee80211_smps_mode smps_mode;
>  			struct sta_opmode_info sta_opmode = {};
>  
> +			if (status->band == NL80211_BAND_6GHZ &&
> +			    rx->link_sta->pub->he_cap.has_he &&
> +			    !(rx->link_sta->pub->he_cap.he_cap_elem.mac_cap_info[5] &
> +			    IEEE80211_HE_MAC_CAP5_HE_DYNAMIC_SM_PS))
> +				goto invalid;
> +
>  			if (sdata->vif.type != NL80211_IFTYPE_AP &&
>  			    sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
>  				goto handled;


