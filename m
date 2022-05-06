Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0951DF0E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391849AbiEFS01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 14:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFS0Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 14:26:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545141336
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651861361; x=1683397361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LGpizcIJePSgIwnKi0Laowa5jtVpDAjNR2kHYWCtPGs=;
  b=SMKOXNxn7cgcEVZLxFptD8+p6kqO5m52WHgcMEr7SYbCb+lnjBtuLQMg
   +dw2jtqkXhP9oYwZosg+vQpFTpK4r2FU5Ae7/h/wgp1u0zinWM7+cltWV
   UaAert+R3+QyW5kTW2HrvfaKHjlwM+a9wvI/xFNd+MKGqfLdjEboBBeCk
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 May 2022 11:22:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:22:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 11:22:40 -0700
Received: from [10.110.125.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 11:22:38 -0700
Message-ID: <5235cf9e-ad4c-3557-e1ee-d4ece1187652@quicinc.com>
Date:   Fri, 6 May 2022 11:22:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] nl80211: process additional attributes in
 NL80211_CMD_SET_BEACON
Content-Language: en-US
To:     Aloka Dixit <quic_alokad@quicinc.com>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220505173449.4424-1-quic_alokad@quicinc.com>
 <20220505173449.4424-2-quic_alokad@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220505173449.4424-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/5/2022 10:34 AM, Aloka Dixit wrote:
> FILS discovery and unsolicited broadcast probe response transmissions
> are configured as part of NL80211_CMD_START_AP, however both stop
> after userspace issues NL80211_CMD_SET_BEACON command as these
> attributes are not processed as part of this command.
> Add the missing implementation.
> 
> Modify the local variable in nl80211_set_beacon() and input parameter
> to rdev_change_beacon() from type struct cfg80211_beacon_data to
> type struct cfg80211_ap_settings to support the new processing.
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
> v1:
> https://patchwork.kernel.org/project/linux-wireless/patch/20210120005229.32582-2-alokad@codeaurora.org/
> 
>   include/net/cfg80211.h  |  2 +-
>   net/wireless/nl80211.c  | 24 ++++++++++++++++---
>   net/wireless/rdev-ops.h |  2 +-
>   net/wireless/trace.h    | 52 +++++++++++++++++++++++------------------
>   4 files changed, 52 insertions(+), 28 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 68713388b617..b388e5c9beb8 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4195,7 +4195,7 @@ struct cfg80211_ops {
>   	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
>   			    struct cfg80211_ap_settings *settings);
>   	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
> -				 struct cfg80211_beacon_data *info);
> +				 struct cfg80211_ap_settings *info);
>   	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev);
>   
>   
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 945ed87d12e0..ee94ad8cd619 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5799,9 +5799,11 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
>   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
>   	struct net_device *dev = info->user_ptr[1];
>   	struct wireless_dev *wdev = dev->ieee80211_ptr;
> -	struct cfg80211_beacon_data params;
> +	struct cfg80211_ap_settings params;
>   	int err;
>   
> +	memset(&params, 0, sizeof(params));
> +

is adding an = {} initializer preferable?

>   	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
>   	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
>   		return -EOPNOTSUPP;
> @@ -5812,16 +5814,32 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
>   	if (!wdev->beacon_interval)
>   		return -EINVAL;
>   
> -	err = nl80211_parse_beacon(rdev, info->attrs, &params);
> +	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
>   	if (err)
>   		goto out;
>   
> +	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
> +		err = nl80211_parse_fils_discovery(rdev,
> +						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
> +						   &params);
> +		if (err)
> +			goto out;
> +	}
> +
> +	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
> +		err = nl80211_parse_unsol_bcast_probe_resp(
> +				rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
> +				&params);
> +		if (err)
> +			goto out;
> +	}
> +

would adding a local variable 'attr' make the code more readable?
	attr = info->attrs[NL80211_ATTR_{foo}];
	if (attr) {
		err = nl80211_parse_{foo}(rdev, attr, &params);

>   	wdev_lock(wdev);
>   	err = rdev_change_beacon(rdev, dev, &params);
>   	wdev_unlock(wdev);
>   
>   out:
> -	kfree(params.mbssid_ies);
> +	kfree(params.beacon.mbssid_ies);
>   	return err;
>   }
[...snip...]
