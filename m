Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92877E8AA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbjHPS0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbjHPS0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 14:26:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321A1986
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 11:26:13 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GHtlxJ026976;
        Wed, 16 Aug 2023 18:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=93WLB1VbHo332KPSiAEOWrZrg/RUpZ4lRnitvnwWxdc=;
 b=I7ZGhvIsGnmRrIKRqmsbfxeViz6JmkIAaA8rmPgGL9EzUrZp+hXG6vD9vjskL8lGCPGF
 droKcHHgKxf8SPh96ucHMjx91R/vg16Cht2QaDz7Yjiov/MIrZRolmal30a5Mr4i5/Ti
 6mphIdkcwR0gJNQZuJLrqX5umeFZEfFF1MffAZorMI/CYxuzMHJqUU0NOqCoMzG9C6Kc
 P3RBPPhEYU99q6PgdLss1dPp+0OVMPezQ2pLg4kIy+oD1DXRie0Hoa4jVSUN6G9kWFds
 TP88Tlggq2jti61QcZIp1tLcxM7h0I5isjhSWX1jf5dlob3TqLYFrr3dBltYR/USoYwn vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgf5uahdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:26:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37GIQ8v2005564
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:26:08 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 16 Aug
 2023 11:26:07 -0700
Message-ID: <032bb37a-31d7-4fe2-bc3b-e767474dd277@quicinc.com>
Date:   Wed, 16 Aug 2023 11:26:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: allow reg update by driver even if
 wiphy->regd is set
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20230421061312.13722-1-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230421061312.13722-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TbkUkx3bEIc3CPzNuLructQ-1-dK6Tm2
X-Proofpoint-GUID: TbkUkx3bEIc3CPzNuLructQ-1-dK6Tm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/20/2023 11:13 PM, Raj Kumar Bhagat wrote:
> Currently regulatory update by driver is not allowed when the
> wiphy->regd is already set and drivers_request->intersect is false.
> 
> During wiphy registration, some drivers (ath10k does this currently)
> first register the world regulatory to cfg80211 using
> wiphy_apply_custom_regulatory(). The driver then obtain the current
> operating country and tries to update the correct regulatory to
> cfg80211 using regulatory_hint().
> 
> But at this point, wiphy->regd is already set to world regulatory.
> Also, since this is the first request from driver after the world
> regulatory is set this will result in drivers_request->intersect
> set to false. In this condition the driver request regulatory is not
> allowed to update to cfg80211 in reg_set_rd_driver(). This restricts
> the device operation to the world regulatory.
> 
> This driver request to update the requlatory with current operating

nit: s/requlatory/regulatory/

> country is valid and should be updated to cfg80211. Hence allow
> regulatory update by driver even if the wiphy->regd is already set
> and driver_request->intersect is false.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   net/wireless/reg.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index 0d40d6af7e10..6cf0bc386f94 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -3833,7 +3833,7 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
>   {
>   	const struct ieee80211_regdomain *regd;
>   	const struct ieee80211_regdomain *intersected_rd = NULL;
> -	const struct ieee80211_regdomain *tmp;
> +	const struct ieee80211_regdomain *tmp = NULL;
>   	struct wiphy *request_wiphy;
>   
>   	if (is_world_regdom(rd->alpha2))
> @@ -3856,10 +3856,8 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
>   	if (!driver_request->intersect) {
>   		ASSERT_RTNL();
>   		wiphy_lock(request_wiphy);
> -		if (request_wiphy->regd) {
> -			wiphy_unlock(request_wiphy);
> -			return -EALREADY;
> -		}
> +		if (request_wiphy->regd)
> +			tmp = get_wiphy_regdom(request_wiphy);
>   
>   		regd = reg_copy_regd(rd);
>   		if (IS_ERR(regd)) {
> @@ -3868,6 +3866,7 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
>   		}
>   
>   		rcu_assign_pointer(request_wiphy->regd, regd);
> +		rcu_free_regdom(tmp);
>   		wiphy_unlock(request_wiphy);
>   		reset_regdomains(false, rd);
>   		return 0;

