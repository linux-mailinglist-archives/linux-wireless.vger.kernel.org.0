Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4284E240130
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Aug 2020 05:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHJDc7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Aug 2020 23:32:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14091 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgHJDc7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Aug 2020 23:32:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597030378; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9ToRi3X43ma7zp4dGFKPAZzqhX+zZrYoUfM8wvtxM1w=;
 b=GxZBT6pIQOih1l7YE0QNcyucsGvOF6nNy7s4f/t72uz+ztALgsDCSWnnxUiy83hs2AFCGfKH
 +UYNjNyy3MN3tfFhpE8n8DNVS4HU01krABxZGwbXpnavu4Jshw5JrN/gfxiHx6gUOEXgqgPZ
 fLenhhGHsiSiu1Zlm+YacR26zV8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f30bfeac85a1092b05a08c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 03:32:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 306B2C433C6; Mon, 10 Aug 2020 03:32:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B93F8C433C9;
        Mon, 10 Aug 2020 03:32:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 09 Aug 2020 20:32:57 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] nl80211: fix NL80211_ATTR_HE_6GHZ_CAPABILITY usage
In-Reply-To: <20200805153516.310cef625955.I0abc04dc8abb2c7c005c88ef8fa2d0e3c9fb95c4@changeid>
References: <20200805153516.310cef625955.I0abc04dc8abb2c7c005c88ef8fa2d0e3c9fb95c4@changeid>
Message-ID: <fc6a6a11da040dbb85cb7c41201b2736@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-05 06:35, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In nl80211_set_station(), we check NL80211_ATTR_HE_6GHZ_CAPABILITY
> and then use NL80211_ATTR_HE_CAPABILITY, which is clearly wrong.
> Fix this to use NL80211_ATTR_HE_6GHZ_CAPABILITY as well.
> 
> Fixes: 43e64bf301fd ("cfg80211: handle 6 GHz capability of new 
> station")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/wireless/nl80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 19281d0c8c9d..bfda09d24146 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -6008,7 +6008,7 @@ static int nl80211_set_station(struct sk_buff
> *skb, struct genl_info *info)
> 
>  	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
>  		params.he_6ghz_capa =
> -			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
> +			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
> 
Thanks for the fix :). Must have overlooked.

-Rajkumar
