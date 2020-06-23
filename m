Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99F2061E8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 23:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbgFWUwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 16:52:13 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45670 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393070AbgFWUv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 16:51:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592945518; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ZmkXUlY8cyLxTT+878JrMSAsx3hdPOgukBaH7B1+iGk=;
 b=GMEmsSyg04YFyYK7LBJJlLebiHvIfIvJq4uci4eX/A9TSwXHJwNURuuuqs0Ges2yp4ilu17j
 dtLxsDp8PsYGNpvVGfYU/JsC9MIJ7KL1dHuCA2ixWJO2hqrUVzRzqV/G5R/jIWZSHNfwZYFZ
 xdAd3hnoyJxETjv1nQP20txB5MM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ef26b6dbfb34e631c7ede23 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 20:51:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF086C43395; Tue, 23 Jun 2020 20:51:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37D3CC433C6;
        Tue, 23 Jun 2020 20:51:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Jun 2020 13:51:55 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] mac80211: avoid bss color setting in non-he mode
In-Reply-To: <1592383348-19266-1-git-send-email-ppranees@codeaurora.org>
References: <1592383348-19266-1-git-send-email-ppranees@codeaurora.org>
Message-ID: <11461228fd45ffeb89cbd5e532d6386d@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-17 01:42, P Praneesh wrote:
> Adding bss-color configuration for HE mode alone.
> Earlier we have enabled it by default, irrespective
> of capabilities. But bss-color feature is only for
> HE mode. Hence avoiding this by adding bss-color flag
> only for HE mode.
> 
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> ---
>  net/mac80211/cfg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 548a384..2c5847d 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -992,8 +992,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy,
> struct net_device *dev,
>  		      BSS_CHANGED_P2P_PS |
>  		      BSS_CHANGED_TXPOWER |
>  		      BSS_CHANGED_TWT |
> -		      BSS_CHANGED_HE_OBSS_PD |
> -		      BSS_CHANGED_HE_BSS_COLOR;
> +		      BSS_CHANGED_HE_OBSS_PD;
> 
Why not other HE flags?

>  	int i, err;
>  	int prev_beacon_int;
> 
> @@ -1019,6 +1018,7 @@ static int ieee80211_start_ap(struct wiphy
> *wiphy, struct net_device *dev,
>  		sdata->vif.bss_conf.frame_time_rts_th =
>  			le32_get_bits(params->he_oper->he_oper_params,
>  			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
> +		changed |= BSS_CHANGED_HE_BSS_COLOR;
> 
Praneesh,

I see that BSS color is not disabled when NL80211_ATTR_HE_BSS_COLOR is 
not set.
I think this must be fixed in cfg80211.

-Rajkumar
