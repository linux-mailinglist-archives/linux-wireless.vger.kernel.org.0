Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1920AFF7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgFZKoV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgFZKoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 06:44:21 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE1C08C5C1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 03:44:21 -0700 (PDT)
Received: from [2a04:4540:1402:3b00:296f:a5a1:dad9:1355]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jolqF-0000Yi-3S; Fri, 26 Jun 2020 12:44:19 +0200
Subject: Re: [PATCH 2/2] nl80211: fix memory leak when parsing
 NL80211_ATTR_HE_BSS_COLOR
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <iwlwifi.20200626124931.871ba5b31eee.I97340172d92164ee92f3c803fe20a8a6e97714e1@changeid>
 <iwlwifi.20200626124931.7ad2a3eb894f.I60905fb70bd20389a3b170db515a07275e31845e@changeid>
From:   John Crispin <john@phrozen.org>
Message-ID: <ec0f216f-4c01-a808-1eb4-96acefa17f4f@phrozen.org>
Date:   Fri, 26 Jun 2020 12:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20200626124931.7ad2a3eb894f.I60905fb70bd20389a3b170db515a07275e31845e@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 26.06.20 11:49, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>
> If there is an error when parsing the NL80211_ATTR_HE_BSS_COLOR
> attribute, we return immediately without freeing param.acl.  Fit it by
> using goto out instead of returning immediately.
>
> Fixes: 5c5e52d1bb96 ("nl80211: add handling for BSS color")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Acked-by: John Crispin <john@phrozen.org>

Thanks !

> ---
>   net/wireless/nl80211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index f31698fd4a7e..0e07fb8585fb 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -5025,7 +5025,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>   					info->attrs[NL80211_ATTR_HE_BSS_COLOR],
>   					&params.he_bss_color);
>   		if (err)
> -			return err;
> +			goto out;
>   	}
>   
>   	nl80211_calculate_ap_params(&params);
