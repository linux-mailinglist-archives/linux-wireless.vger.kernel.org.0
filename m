Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7C697621
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBOGKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 01:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOGKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 01:10:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED502B09C
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 22:10:33 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F5TfOI001083;
        Wed, 15 Feb 2023 06:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ph674t8Thsb1W2q6VcgUiJFfR3InJ5WSRNKHIqMC3UA=;
 b=BTBdQL7wPs9ALxxAvOqDLHreG7Y48bTISQowUYz9YUV4sQCHFLKw2WdbDO1VIrRADh5h
 KGk5pRaL+RepZ7G/NAVd9rC+ymqf3Nq7jK1Me8MUDhdvz+NTsK1XI8S8jv7UPr/c/jPb
 kpIacseRVKmsJGABEnPKF48wTv+Q2jSALyabZ9+yqZfxZGCB+k37DPaEF9PVqgJ1WU/0
 RvHb85eD+dmh0bnkaKbLhpqGgQ10Qf1cB/u0gavIFEogd3JrvUG+GhtO7CHelFTphZy3
 /nmWm+QFknjs0yFF3qYwbvpYbjBSGpmhoye6D2+YXPgTefg/NSrm0NLUFKSmz2ZOeDzD eQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrprs0du2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 06:10:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F6AICx005294
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 06:10:18 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 22:10:17 -0800
Message-ID: <bcaf5a88-76f3-c4ed-0fca-2c131d392f82@quicinc.com>
Date:   Wed, 15 Feb 2023 14:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] wifi: cfg80211: call reg_notifier for self managed
 wiphy from driver hint
Content-Language: en-US
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230201070327.27578-1-quic_wgong@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20230201070327.27578-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dUEOYKataLanhLkIcm-BFRMJqSmy7jS1
X-Proofpoint-ORIG-GUID: dUEOYKataLanhLkIcm-BFRMJqSmy7jS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150055
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/1/2023 3:03 PM, Wen Gong wrote:
> Currently the regulatory driver does not call the regulatory callback
> reg_notifier for self managed wiphys. Sometimes driver needs cfg80211
> to calculate the info of ieee80211_channel such as flags and power,
> and driver needs to get the info of ieee80211_channel after hint of
> driver, but driver does not know when calculation of the info of
> ieee80211_channel become finished, so add notify to driver in
> reg_process_self_managed_hint() from cfg80211 is a good way, then
> driver could get the correct info in callback of reg_notifier.
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
> v3: use hole for BIT(24) which delete by commit 585b6e1304dc ("wifi: cfg80211: remove support for static WEP")
Hi Johannes,

I see you have merged v2 to wireless-next.git and this v3's state is reject.
So do you mean we should not keep hole BIT 24 in enum wiphy_flags from 
now as well as
hole 11/12 in commit 8e8b41f9d8c8/ca986ad9bcd3?

If that, then backport this patch will be more complex, because the 
backport kernel already have
WIPHY_FLAG_HAS_STATIC_WEP= BIT(24), then firstly the backport kernel 
need backport other
patch(585b6e1304dc ("wifi: cfg80211: remove support for static WEP")) 
which is not really needed.
>
> v2:
>     1. add flag WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER
>     2. change to use reg_call_notifier()
>
>   include/net/cfg80211.h | 4 ++++
>   net/wireless/reg.c     | 3 +++
>   2 files changed, 7 insertions(+)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 1f8f827290a2..ef96fc5b060d 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4682,6 +4682,8 @@ struct cfg80211_ops {
>    *	in order to not have them reachable in normal drivers, until we have
>    *	complete feature/interface combinations/etc. advertisement. No driver
>    *	should set this flag for now.
> + * @WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER: The device could handle reg notify for
> + *	NL80211_REGDOM_SET_BY_DRIVER.
>    */
>   enum wiphy_flags {
>   	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
> @@ -4707,6 +4709,8 @@ enum wiphy_flags {
>   	WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL	= BIT(21),
>   	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
>   	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
> +	/* use hole at 24 */
> +	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(25),
>   };
>   
>   /**
> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
> index 4f3f31244e8b..cb35c8e9ced7 100644
> --- a/net/wireless/reg.c
> +++ b/net/wireless/reg.c
> @@ -3198,6 +3198,9 @@ static void reg_process_self_managed_hint(struct wiphy *wiphy)
>   	request.alpha2[1] = regd->alpha2[1];
>   	request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
>   
> +	if (wiphy->flags & WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER)
> +		reg_call_notifier(wiphy, &request);
> +
>   	nl80211_send_wiphy_reg_change_event(&request);
>   }
>   
>
> base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
> prerequisite-patch-id: e365a8f3f2dda71872409315b416797c771a6c51
