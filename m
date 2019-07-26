Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5C77A47
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2019 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfG0Pdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Jul 2019 11:33:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39363 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfG0Pdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Jul 2019 11:33:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so54253199ljh.6
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2019 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=49oLJJ+AruMxZza+E1It4S74V16tuu7g2iHchlBB91s=;
        b=hR9wzCfIH/UXxMDdaeSmQ9ZxFcJEYY/lQguDeP8mMD4FiREn6aEYIlMzLEWEjYsVks
         +2lymw5hvFyzL0ZuSqt0rXqy1QYgP7mAyqQ1WHSilvYDR33pPsfq+bT0Piilzu5kTa+b
         xFrgHVU5DMwePNYjYJs9q8CuxRGMrnUnzY++tDkGErLg+E6kKBGPt7EQtxjkSdQxkv6P
         8BtlHpBaWj5QWfsgHhR+GCFgAiLmOatVjXyvVQSlxxyE+ZNwjBICE/peAGJFL6L+Yi99
         4aNsI8vFMcYH25+g/m0Xtbdyyb095s7ZNUP5uZcnOUQ148xjd6Z5r8SzGTO9atlRazEc
         CwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49oLJJ+AruMxZza+E1It4S74V16tuu7g2iHchlBB91s=;
        b=CbpdM5ag4B0HIeTI/YpPCmjCuunYU3OYbUYuvAh3GcUVv71x1OsJt46i0c9523ytBK
         Wr9hTb28N6EVWJ7dho/l0jTRCH2VIbzIWw/kQTi+H4hTDYI0JboOq1TvXY2Xsoqo/Yr1
         qCLqXTZxxQbvu+/5/Xp1InYpX/F9l698e88/vhbitgVGusnmfV3z07y53i163IDqUvA/
         6w/f9xEGxTJE4c4qTWbJtuNYktzuQanqroOMh0D027fbWn+P5ttznUdA7bCc5SbD9rdv
         4Mbn/+Avm4nBg/Pe9JSj0I4pbL0LwQal5dJxUGsIhO5Tj//TmyeITz90aqdOCWQ+wyVI
         j2bA==
X-Gm-Message-State: APjAAAXsJN47OC1Od2g+clHzn31T1AvaK1s4xnmu947pv3dGhfUPQV5i
        645xpBHrz1tPbC045/fwtj0=
X-Google-Smtp-Source: APXvYqyiGEtxDeMU70XO2PYSsGQrs/d3FM37W5+VMUmHep55ym/SsgQYyvjUhdrw0V/HGAHhLOSphw==
X-Received: by 2002:a2e:b0ea:: with SMTP id h10mr8029179ljl.50.1564241618812;
        Sat, 27 Jul 2019 08:33:38 -0700 (PDT)
Received: from [192.168.100.6] ([109.252.54.73])
        by smtp.googlemail.com with ESMTPSA id t25sm9314235lfg.7.2019.07.27.08.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 08:33:38 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: use parallel_ops for genl
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20190726191621.5031-1-johannes@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <fe8ef214-5d02-da36-2680-6df3c683c154@gmail.com>
Date:   Thu, 25 Jul 2019 19:16:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726191621.5031-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 7/26/19 2:16 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Over time, we really need to get rid of all of our global locking.
> One of the things needed is to use parallel_ops. This isn't really
> the most important (RTNL is much more important) but OTOH we just
> keep adding uses of genl_family_attrbuf() now. Use .parallel_ops to
> disallow this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   net/wireless/nl80211.c | 112 +++++++++++++++++++++++++++++------------
>   1 file changed, 81 insertions(+), 31 deletions(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 10b57aa10227..59aefcd7ccb6 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -749,19 +749,29 @@ int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
>   	int err;
>   
>   	if (!cb->args[0]) {
> +		struct nlattr **attrbuf;
> +
> +		attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf),
> +				  GFP_KERNEL);
> +		if (!attrbuf)
> +			return -ENOMEM;
> +
>   		err = nlmsg_parse_deprecated(cb->nlh,
>   					     GENL_HDRLEN + nl80211_fam.hdrsize,
> -					     genl_family_attrbuf(&nl80211_fam),
> -					     nl80211_fam.maxattr,
> +					     attrbuf, nl80211_fam.maxattr,
>   					     nl80211_policy, NULL);
> -		if (err)
> +		if (err) {
> +			kfree(attrbuf);
>   			return err;
> +		}
>   
> -		*wdev = __cfg80211_wdev_from_attrs(
> -					sock_net(cb->skb->sk),
> -					genl_family_attrbuf(&nl80211_fam));
> -		if (IS_ERR(*wdev))
> +		*wdev = __cfg80211_wdev_from_attrs(sock_net(cb->skb->sk),
> +						   attrbuf);
> +		kfree(attrbuf);
> +		if (IS_ERR(*wdev)) {
> +			kfree(attrbuf);

Hmm, you just freed attrbuf above?

>   			return PTR_ERR(*wdev);
> +		}
>   		*rdev = wiphy_to_rdev((*wdev)->wiphy);
>   		/* 0 is the first index - add 1 to parse only once */
>   		cb->args[0] = (*rdev)->wiphy_idx + 1;

<snip>

> @@ -12846,24 +12880,32 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
>   		return 0;
>   	}
>   
> +	attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf), GFP_KERNEL);
> +	if (!attrbuf)
> +		return -ENOMEM;
> +
>   	err = nlmsg_parse_deprecated(cb->nlh,
>   				     GENL_HDRLEN + nl80211_fam.hdrsize,
>   				     attrbuf, nl80211_fam.maxattr,
>   				     nl80211_policy, NULL);
>   	if (err)
> -		return err;
> +		goto out;
>   
>   	if (!attrbuf[NL80211_ATTR_VENDOR_ID] ||
> -	    !attrbuf[NL80211_ATTR_VENDOR_SUBCMD])
> -		return -EINVAL;
> +	    !attrbuf[NL80211_ATTR_VENDOR_SUBCMD]) {
> +		err = -EINVAL;
> +		goto out;
> +	}

Might be nicer to just set err = -EINVAL before the if instead of using 
{} here

>   
>   	*wdev = __cfg80211_wdev_from_attrs(sock_net(skb->sk), attrbuf);
>   	if (IS_ERR(*wdev))
>   		*wdev = NULL;
>   
>   	*rdev = __cfg80211_rdev_from_attrs(sock_net(skb->sk), attrbuf);
> -	if (IS_ERR(*rdev))
> -		return PTR_ERR(*rdev);
> +	if (IS_ERR(*rdev)) {
> +		err = PTR_ERR(*rdev);
> +		goto out;
> +	}
>   
>   	vid = nla_get_u32(attrbuf[NL80211_ATTR_VENDOR_ID]);
>   	subcmd = nla_get_u32(attrbuf[NL80211_ATTR_VENDOR_SUBCMD]);
> @@ -12876,15 +12918,19 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
>   		if (vcmd->info.vendor_id != vid || vcmd->info.subcmd != subcmd)
>   			continue;
>   
> -		if (!vcmd->dumpit)
> -			return -EOPNOTSUPP;
> +		if (!vcmd->dumpit) {
> +			err = -EOPNOTSUPP;
> +			goto out;
> +		}

Same thing here, setting err = -EOPNOTSUPP before the for...

>   
>   		vcmd_idx = i;
>   		break;
>   	}
>   
> -	if (vcmd_idx < 0)
> -		return -EOPNOTSUPP;
> +	if (vcmd_idx < 0) {
> +		err = -EOPNOTSUPP;
> +		goto out;
> +	}
>   
>   	if (attrbuf[NL80211_ATTR_VENDOR_DATA]) {
>   		data = nla_data(attrbuf[NL80211_ATTR_VENDOR_DATA]);

<snip>

Otherwise LGTM.

Feel free to add: Reviewed-by: Denis Kenzior <denkenz@gmail.com>

Regards,
-Denis
