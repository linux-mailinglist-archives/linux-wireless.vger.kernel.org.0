Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4551AFD7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 22:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiEDU6n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 16:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378414AbiEDU6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 16:58:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D6517D1
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aWamwzX0FkF0yS1OimhK3VkimwTMBgQYFS/tQnaDkFs=;
        t=1651697702; x=1652907302; b=dGpSWPjbYlHey7SVvBN9nzS0ICPiAUr1TqIXdXYQ70sqGXi
        7QNMV3Fh/HIVyU3kepQmhEGDEbwvUT/pM/LyyjmXE/vui9tHdaDiyhuzPjO/d7XdLIfgrsvX6UnZq
        HBMnzBPpNWHeO/q9SAFFlIThJpgsur1Pf09cFn3HewYSrYGmI0qFTg/xpssjTslnYHPUyO/hr1YB+
        hF8haA4ESYOZIh2wManDC5hU/V8oxm4Ul0SL1D5jkOWSqxQkTjzaIPy+Xljx1YLhf1Qd6Sf0V+Tq/
        N7pJTA5ZQFzfYF8/0LUQ399ghCCt9qbgsXDBtZvD6ltZJQ7MvpiqYKDa/r/PFwmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmM1U-002CYm-Dw;
        Wed, 04 May 2022 22:55:00 +0200
Message-ID: <cb419675d2ae276d9b4eac8ab5deafe62167051f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: Add support for sending more than two AKMs
 in crypto settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 22:54:59 +0200
In-Reply-To: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I don't know why, but this patch seems to cause memory corruption and
various issues when I run the hwsim tests.

I did make a few minor changes, but I think those were OK.


> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1112,7 +1112,7 @@ struct cfg80211_crypto_settings {
>  	int n_ciphers_pairwise;
>  	u32 ciphers_pairwise[NL80211_MAX_NR_CIPHER_SUITES];
>  	int n_akm_suites;
> -	u32 akm_suites[NL80211_MAX_NR_AKM_SUITES];
> +	u32 *akm_suites;

I made this const, that required a bit of juggling in the wext code, but
it's probably still better overall.

>  
> +	/*
> +	 * Maximum number of AKM suites allowed for NL80211_CMD_CONECT,
> +	 * NL80211_CMD_ASSOCIATE and NL80211_CMD_START_AP, must be at least
> +	 * NL80211_MAX_NR_AKM_SUITES to avoid issues with legacy userspace.
> +	 */
> +	if (WARN_ON(wiphy->max_num_akm_suites &&
> +		    wiphy->max_num_akm_suites < NL80211_MAX_NR_AKM_SUITES))
> +		return -EINVAL;

I made it so here if it's 0 we set it to NL80211_MAX_NR_AKM_SUITES, that
way we don't need to have all the questions about it being 0 later.

> +		if (nla_put_u16(msg, NL80211_ATTR_MAX_NUM_AKM_SUITES,
> +				rdev->wiphy.max_num_akm_suites ?
> +				rdev->wiphy.max_num_akm_suites :
> +				NL80211_MAX_NR_AKM_SUITES))
> +			goto nla_put_failure;

e.g. here, that was then without the ternary operator

> +		int max_num_akm_suites = NL80211_MAX_NR_AKM_SUITES;
>  
>  		data = nla_data(info->attrs[NL80211_ATTR_AKM_SUITES]);
>  		len = nla_len(info->attrs[NL80211_ATTR_AKM_SUITES]);
> @@ -10261,10 +10269,13 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
>  		if (len % sizeof(u32))
>  			return -EINVAL;
>  
> -		if (settings->n_akm_suites > NL80211_MAX_NR_AKM_SUITES)
> +		if (rdev->wiphy.max_num_akm_suites)
> +			max_num_akm_suites = rdev->wiphy.max_num_akm_suites;
> +
> +		if (settings->n_akm_suites > max_num_akm_suites)
>  			return -EINVAL;
>  
> -		memcpy(settings->akm_suites, data, len);
> +		settings->akm_suites = data;

and all that complexity also goes away

> +	if (connect->crypto.n_akm_suites) {
> +		wdev->conn->params.crypto.akm_suites =
> +			kcalloc(connect->crypto.n_akm_suites, sizeof(u32),
> +				GFP_KERNEL);
> +		if (!wdev->conn->params.crypto.akm_suites) {
> +			cfg80211_sme_free(wdev);
> +			return -ENOMEM;
> +		}
> +
> +		wdev->conn->params.crypto.n_akm_suites =
> +			connect->crypto.n_akm_suites;
> +		memcpy(wdev->conn->params.crypto.akm_suites,
> +		       connect->crypto.akm_suites,
> +		       sizeof(u32) * connect->crypto.n_akm_suites);

I made this use kmemdup(), I don't think it makes a big difference.

Anyway, it crashes. Perhaps an invalid free, because the middle of some
netlink packet is being freed or so?

Please check.

johannes
