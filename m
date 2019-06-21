Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7A4E1A2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2019 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFUIJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jun 2019 04:09:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41807 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfFUIJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jun 2019 04:09:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so5592217wrm.8
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2019 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oq59un5lj/AlrIjGN63oN8THCrEhVvI42GR1gm3ZxFo=;
        b=LFf2iwXm/QVLpxBz77LfnalmSkT/iAHeDCVMwjcDw1YboP1d843pRdzT2dBDsq/NJg
         J8YGmLhVaIUsBF/xWgNvLTB2fl1l87Y7uQbWWs4kxLdXPLtJzj0vs8R0nNdAaTSDtZRG
         n5Zbj0gJdeh98BrE1Yt7/CuzmE83XF6Jg8VIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oq59un5lj/AlrIjGN63oN8THCrEhVvI42GR1gm3ZxFo=;
        b=s+0tcJBfsmft1OXcvDAi6uV9YlgRlhz2A6Y6B7MZxQKYVB6D3u7Wl2cQhXvZin+xiY
         p42Ht6S+mmWvVUmbcAqL7rY5bIJfpIwhQgn16VwrLhvCjtWMB3oXVa/mN5W7bNlsoVwq
         cyCqERQBJzZOmKX5BxN/pD7QDLoYX9yE5w16M6RChJO+AD8yvoXcehvGafevzbNOKZ9x
         Uw3FvS6x9mKHc1dDnu6xqxNhyxatYfQwFmwBX+9iKgPC4k3nKaAlt1tTTbYS0jJRxgKF
         LWWA7UTk13zYSX08IJpdn1vcHqKYxVy5a7kPM34iDDmWs7O92YuP3lJp914p4O1n/6zy
         79AA==
X-Gm-Message-State: APjAAAWDPJl5USPYeRjlFYUixR94b21dPAREcic4SsCU+YvoQcX4fxUu
        Yd54uuAJTwpJt6ll8TZZOAjdGm+TQBrieeVK5skBnsPwCpG0YDQtM2KAXlkyjYBy7bQRvWq2UKY
        OgRdhf0Zyc4AwI7QnhI8DrrFuFXGMrzc9Ho5vp04rp+3ksiv6jMU2r6vFFGpBZO4ahIxBWNPi+d
        9U3/9f5t9fHuInaQ==
X-Google-Smtp-Source: APXvYqwEyBXdRT6KmpDK53NnqmOxwFbDx0caYhTqRUIjR+9jeToitQBeAAkEaK6qd0E+qcgwoHogUw==
X-Received: by 2002:adf:f909:: with SMTP id b9mr64124396wrr.119.1561104546648;
        Fri, 21 Jun 2019 01:09:06 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id v18sm2085832wrd.51.2019.06.21.01.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:09:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] nl80211: Limit certain commands to interface owner
To:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190620220749.10071-1-denkenz@gmail.com>
 <20190620220749.10071-2-denkenz@gmail.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <11852f40-67e5-9122-7d82-077bdd0b014a@broadcom.com>
Date:   Fri, 21 Jun 2019 10:09:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620220749.10071-2-denkenz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/21/2019 12:07 AM, Denis Kenzior wrote:
> If the wdev object has been created (via NEW_INTERFACE) with
> SOCKET_OWNER attribute set, then limit certain commands only to the
> process that created that wdev.
> 
> This can be used to make sure no other process on the system interferes
> by sending unwanted scans, action frames or any other funny business.

The flag is a good addition opposed to having handlers deal with it. 
However, earlier motivation for SOCKET_OWNER use was about netlink 
multicast being unreliable, which I can agree to. However, avoiding 
"funny business" is a different thing. Our testing infrastructure is 
doing all kind of funny business. Guess we will need to refrain from 
using any user-space wireless tools that use the SOCKET_OWNER attribute, 
but how do we know? Somehow I suspect iwd is one to avoid ;-) I have yet 
to give iwd a spin, but this SOCKET_OWNER strategy kept me from it. 
Maybe iwd could have a developer option which disables the use of the 
SOCKET_OWNER attribute.

Regards,
Arend

> This patch introduces a new internal flag, and checks that flag in the
> pre_doit hook.
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> ---
>   net/wireless/nl80211.c | 80 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 61 insertions(+), 19 deletions(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index ff760ba83449..26bab9560c0f 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -13587,6 +13587,7 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
>   #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
>   					 NL80211_FLAG_CHECK_NETDEV_UP)
>   #define NL80211_FLAG_CLEAR_SKB		0x20
> +#define NL80211_FLAG_OWNER_ONLY		0x40
>   
>   static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   			    struct genl_info *info)
> @@ -13595,6 +13596,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   	struct wireless_dev *wdev;
>   	struct net_device *dev;
>   	bool rtnl = ops->internal_flags & NL80211_FLAG_NEED_RTNL;
> +	int ret;
>   
>   	if (rtnl)
>   		rtnl_lock();
> @@ -13602,10 +13604,10 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   	if (ops->internal_flags & NL80211_FLAG_NEED_WIPHY) {
>   		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
>   		if (IS_ERR(rdev)) {
> -			if (rtnl)
> -				rtnl_unlock();
> -			return PTR_ERR(rdev);
> +			ret = PTR_ERR(rdev);
> +			goto done;
>   		}
> +
>   		info->user_ptr[0] = rdev;
>   	} else if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV ||
>   		   ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
> @@ -13614,32 +13616,33 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   		wdev = __cfg80211_wdev_from_attrs(genl_info_net(info),
>   						  info->attrs);
>   		if (IS_ERR(wdev)) {
> -			if (rtnl)
> -				rtnl_unlock();
> -			return PTR_ERR(wdev);
> +			ret = PTR_ERR(wdev);
> +			goto done;
>   		}
>   
>   		dev = wdev->netdev;
>   		rdev = wiphy_to_rdev(wdev->wiphy);
>   
> +		ret = -EINVAL;
>   		if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV) {
> -			if (!dev) {
> -				if (rtnl)
> -					rtnl_unlock();
> -				return -EINVAL;
> -			}
> +			if (!dev)
> +				goto done;
>   
>   			info->user_ptr[1] = dev;
>   		} else {
>   			info->user_ptr[1] = wdev;
>   		}
>   
> +		ret = -ENETDOWN;
>   		if (ops->internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
> -		    !wdev_running(wdev)) {
> -			if (rtnl)
> -				rtnl_unlock();
> -			return -ENETDOWN;
> -		}
> +		    !wdev_running(wdev))
> +			goto done;
> +
> +		ret = -EPERM;
> +		if (ops->internal_flags & NL80211_FLAG_OWNER_ONLY &&
> +		    wdev->owner_nlportid &&
> +		    wdev->owner_nlportid != info->snd_portid)
> +			goto done;
>   
>   		if (dev)
>   			dev_hold(dev);
> @@ -13647,7 +13650,13 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   		info->user_ptr[0] = rdev;
>   	}
>   
> -	return 0;
> +	ret = 0;
> +
> +done:
> +	if (rtnl && !ret)
> +		rtnl_unlock();
> +
> +	return ret;
>   }
>   
>   static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
> @@ -13712,7 +13721,8 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_set_interface,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV |
> -				  NL80211_FLAG_NEED_RTNL,
> +				  NL80211_FLAG_NEED_RTNL |
> +				  NL80211_FLAG_OWNER_ONLY,
>   	},
>   	{
>   		.cmd = NL80211_CMD_NEW_INTERFACE,
> @@ -13728,7 +13738,8 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_del_interface,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV |
> -				  NL80211_FLAG_NEED_RTNL,
> +				  NL80211_FLAG_NEED_RTNL |
> +				  NL80211_FLAG_OWNER_ONLY,
>   	},
>   	{
>   		.cmd = NL80211_CMD_GET_KEY,
> @@ -13745,6 +13756,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
>   				  NL80211_FLAG_NEED_RTNL |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
>   	{
> @@ -13754,6 +13766,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
>   				  NL80211_FLAG_NEED_RTNL |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
>   	{
> @@ -13762,6 +13775,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_del_key,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13778,6 +13792,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.doit = nl80211_start_ap,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13786,6 +13801,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.doit = nl80211_stop_ap,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13802,6 +13818,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_set_station,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13810,6 +13827,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_new_station,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13818,6 +13836,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_del_station,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13921,6 +13940,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_trigger_scan,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13929,6 +13949,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_abort_scan,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13942,6 +13963,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_start_sched_scan,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13950,6 +13972,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_stop_sched_scan,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13958,6 +13981,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_authenticate,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
> @@ -13967,6 +13991,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_associate,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
> @@ -13976,6 +14001,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_deauthenticate,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13984,6 +14010,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_disassociate,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -13992,6 +14019,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_join_ibss,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14000,6 +14028,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_leave_ibss,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   #ifdef CONFIG_NL80211_TESTMODE
> @@ -14019,6 +14048,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_connect,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
> @@ -14028,6 +14058,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_update_connect_params,
>   		.flags = GENL_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
> @@ -14037,6 +14068,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_disconnect,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14083,6 +14115,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_remain_on_channel,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14091,6 +14124,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_cancel_remain_on_channel,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14115,6 +14149,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_tx_mgmt,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14123,6 +14158,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_tx_mgmt_cancel_wait,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14147,6 +14183,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_set_cqm,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14221,6 +14258,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_set_rekey_data,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL |
>   				  NL80211_FLAG_CLEAR_SKB,
>   	},
> @@ -14278,6 +14316,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_start_p2p_device,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14286,6 +14325,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_stop_p2p_device,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14371,6 +14411,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_crit_protocol_start,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> @@ -14379,6 +14420,7 @@ static const struct genl_ops nl80211_ops[] = {
>   		.doit = nl80211_crit_protocol_stop,
>   		.flags = GENL_UNS_ADMIN_PERM,
>   		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
> +				  NL80211_FLAG_OWNER_ONLY |
>   				  NL80211_FLAG_NEED_RTNL,
>   	},
>   	{
> 
