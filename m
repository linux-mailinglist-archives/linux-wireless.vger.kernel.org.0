Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27F79D7F7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjILRvH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjILRvC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 13:51:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C210F7
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 10:50:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CBxYnT029964;
        Tue, 12 Sep 2023 17:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z8oZ5eOW3uFOxNkMjnpR0NZJF+cDIfU9cdj1K1zB3bQ=;
 b=UbXZB8aXgz7T4CjU4khIhC7X1DmZ82gzXnrX+8H+vwNlZuix8TqHuGaw82n+e6iO1M/P
 vYc4VJ4qZEwUFHmgV0oV1WUIYf7xCE0EunQ9tw9q9pGwY27aoZmaPhI7c/VcRZde6etl
 ionYhXMs5VzfmheBB2OvGHs1ET2aoBZgA2DjFjAOM7T0bpA1064UaN+s+YItD4y6f7eR
 YLAEU6cvXZk7MQh1jtAoh4T/AR9nMNc+RffELbPbYo11Kj9AgoZKzBddH8f1/qZ5nah7
 vE8m8DDcSBflJNE8tuS+RAlVWdxOwn/e3r6V5TyWR89oKj3RhETocz4wBqARreIfFAz7 Ew== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2qkj95ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 17:50:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CHolw5002314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 17:50:47 GMT
Received: from [10.111.183.71] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 10:50:47 -0700
Message-ID: <a1dfbfbc-8bd0-47a5-80ff-ebf32f51d4ed@quicinc.com>
Date:   Tue, 12 Sep 2023 10:50:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: cfg80211: export DFS CAC time and usable
 state helper functions
Content-Language: en-US
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
References: <20230912051857.2284-1-quic_adisi@quicinc.com>
 <20230912051857.2284-2-quic_adisi@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230912051857.2284-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 468LIKMUMIIDNUvun7PbFy4lu2e_q0f9
X-Proofpoint-GUID: 468LIKMUMIIDNUvun7PbFy4lu2e_q0f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120151
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/11/2023 10:18 PM, Aditya Kumar Singh wrote:
> cfg80211 has cfg80211_chandef_dfs_usable() function to know whether
> at least one channel in the chandef is in usable state or not. Also,
> cfg80211_chandef_dfs_cac_time() function is there which tells the CAC
> time required for the given chandef.
> 
> Make these two functions visible to drivers by exporting their symbol
> to global list of kernel symbols.
> 
> Lower level drivers can make use of these two functions to be aware
> if CAC is required on the given chandef and for how long. For example
> drivers which maintains the CAC state internally can make use of these.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   include/net/cfg80211.h | 24 ++++++++++++++++++++++++
>   net/wireless/chan.c    |  2 ++
>   net/wireless/core.h    | 17 -----------------
>   3 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 3a4b684f89bf..92072a0f0ea6 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -953,6 +953,30 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
>   				  const struct cfg80211_chan_def *chandef,
>   				  enum nl80211_iftype iftype);
>   
> +/**
> + * cfg80211_chandef_dfs_usable - checks if chandef is DFS usable and we
> + *				 can/need start CAC on such channel
> + * @wiphy: the wiphy to validate against
> + * @chandef: the channel definition to check
> + *
> + * Return: true if all channels available and at least
> + *	   one channel requires CAC (NL80211_DFS_USABLE)
> + */
> +bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
> +				 const struct cfg80211_chan_def *chandef);
> +
> +/**
> + * cfg80211_chandef_dfs_cac_time - get the DFS CAC time (in ms) for given
> + *				   channel definition
> + * @wiphy: the wiphy to validate against
> + * @chandef: the channel definition to check
> + *
> + * Returns: DFS CAC time (in ms) which applies for this channel definition
> + */
> +unsigned int
> +cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
> +			      const struct cfg80211_chan_def *chandef);
> +
>   /**
>    * nl80211_send_chandef - sends the channel definition.
>    * @msg: the msg to send channel definition
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index 0b7e81db383d..a78a6183d11e 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c
> @@ -666,6 +666,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
>   
>   	return (r1 + r2 > 0);
>   }
> +EXPORT_SYMBOL(cfg80211_chandef_dfs_usable);
>   
>   /*
>    * Checks if center frequency of chan falls with in the bandwidth
> @@ -965,6 +966,7 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
>   
>   	return max(t1, t2);
>   }
> +EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
>   
>   static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
>   					u32 center_freq, u32 bandwidth,
> diff --git a/net/wireless/core.h b/net/wireless/core.h
> index 507d184b8b40..cc4eb3906c0c 100644
> --- a/net/wireless/core.h
> +++ b/net/wireless/core.h
> @@ -469,29 +469,12 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev);
>   
>   extern struct work_struct cfg80211_disconnect_work;
>   
> -/**
> - * cfg80211_chandef_dfs_usable - checks if chandef is DFS usable
> - * @wiphy: the wiphy to validate against
> - * @chandef: the channel definition to check
> - *
> - * Checks if chandef is usable and we can/need start CAC on such channel.
> - *
> - * Return: true if all channels available and at least
> - *	   one channel requires CAC (NL80211_DFS_USABLE)
> - */
> -bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
> -				 const struct cfg80211_chan_def *chandef);
> -
>   void cfg80211_set_dfs_state(struct wiphy *wiphy,
>   			    const struct cfg80211_chan_def *chandef,
>   			    enum nl80211_dfs_state dfs_state);
>   
>   void cfg80211_dfs_channels_update_work(struct work_struct *work);
>   
> -unsigned int
> -cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
> -			      const struct cfg80211_chan_def *chandef);
> -
>   void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
>   
>   int

