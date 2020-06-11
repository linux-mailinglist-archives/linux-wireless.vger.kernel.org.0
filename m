Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608041F60CD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgFKEYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 00:24:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54740 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgFKEYN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 00:24:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591849453; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uEduP/dbpA3q/oyY+EmlbL01GEvEHC+k0tph2bP58/Q=;
 b=XLk3XAlmRZnk6I4qhxxCoVyEoJp8luThmKGgIRwJsU4yyE5bmiBi4SIVzG5euJvE87leNsHC
 ybtrK/cp2OCDxxDN/sp9p9M5IXYfme7uPb0TAZiMVkSNSeIpdKZRQdOGjEJgQYei5TqqM0rH
 XzuYI8pauq0g2eI3UOH7NhJp9bs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ee1b1e2356bcc26ab101c6a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 04:24:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B24FCC43391; Thu, 11 Jun 2020 04:24:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB02DC433C6;
        Thu, 11 Jun 2020 04:24:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jun 2020 21:24:00 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 02/12] nl80211: add attributes for multiple bssid related
 settings
In-Reply-To: <20200604070952.15481-3-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
 <20200604070952.15481-3-john@phrozen.org>
Message-ID: <8cc57539ad26d2cf49ef347cd65471ea@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-04 00:09, John Crispin wrote:
> When we start a multiple bssid AP we need to pass the index and number 
> of
> peers aswell to the kernel. This info needs to be propagated to the
> driver.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  include/net/cfg80211.h       | 12 ++++++++++++
>  include/uapi/linux/nl80211.h |  7 +++++++
>  net/wireless/nl80211.c       | 15 +++++++++++++++
>  3 files changed, 34 insertions(+)
> 
[...]
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 3b502514944c..58ce67bc31da 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -667,6 +667,8 @@ const struct nla_policy 
> nl80211_policy[NUM_NL80211_ATTR] = {
>  					NL80211_MULTIPLE_BSSID_LEGACY,
>  					NL80211_MULTIPLE_BSSID_NON_TRANSMITTED),
>  	[NL80211_ATTR_MULTI_BSSID_PARENT] = { .type = NLA_U32 },
> +	[NL80211_ATTR_MULTI_BSSID_INDEX] = { .type = NLA_U32 },
> +	[NL80211_ATTR_MULTI_BSSID_COUNT] = { .type = NLA_U32 },
>  };
> 
>  /* policy for the key attributes */
> @@ -4996,6 +4998,11 @@ static int nl80211_start_ap(struct sk_buff
> *skb, struct genl_info *info)
>  	    !info->attrs[NL80211_ATTR_BEACON_HEAD])
>  		return -EINVAL;
> 
> +	if (wdev->multi_bssid_mode == NL80211_MULTIPLE_BSSID_NON_TRANSMITTED 
> &&
> +	    (!info->attrs[NL80211_ATTR_MULTI_BSSID_INDEX] ||
> +	     !info->attrs[NL80211_ATTR_MULTI_BSSID_COUNT]))
> +		return -EINVAL;
> +
>  	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
>  	if (err)
>  		return err;
> @@ -5150,6 +5157,14 @@ static int nl80211_start_ap(struct sk_buff
> *skb, struct genl_info *info)
>  			return err;
>  	}
> 
> +	if (info->attrs[NL80211_ATTR_MULTI_BSSID_INDEX])
> +		params.multi_bssid.index = nla_get_u32(
> +				info->attrs[NL80211_ATTR_MULTI_BSSID_INDEX]);
> +
> +	if (info->attrs[NL80211_ATTR_MULTI_BSSID_COUNT])
> +		params.multi_bssid.count = nla_get_u32(
> +				info->attrs[NL80211_ATTR_MULTI_BSSID_COUNT]);
> +
John,

Does the count include transmitting and non-transmitting APs? Or just 
child-node counts.
Are you expecting start_ap() for all non-trasmitting AP as well? Hope 
this count can be
set only for parent AP?

-Rajkumar
