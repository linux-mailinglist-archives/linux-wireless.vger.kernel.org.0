Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15F46B1695
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 00:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCHXhR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 18:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCHXhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 18:37:15 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B0C9CFC9
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:37:06 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 69652C006A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 23:37:04 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EDBCD13C2B0
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:37:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EDBCD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678318624;
        bh=OHSh40wKEVWr8l7WqUs2ncuBDGGjwZcyECeYJ42RQ0U=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=BLJ1nE95Tu1JGNxrQE6vgwgkjdSSY9iu6AQEeMSf3erRfNQqkx/zfvaviPhV92g79
         Eetz7f9THJHFyy34tEI9bLdxOnkzGseu6uioqMr9H9PPCauOBCc5CRAZzuiVpVYZ+Y
         CRdqrMYKiaq2/1TI4WjNRRM5R3eW4Ftp0rLzc+uA=
Message-ID: <fb2c1994-3020-c3d4-0062-5f72018a9b0b@candelatech.com>
Date:   Wed, 8 Mar 2023 15:37:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] wireless: mac80211: fix ath10k wave-2 in 80mhz mode
 in config_bw logic.
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
References: <20230308232421.2672247-1-greearb@candelatech.com>
 <20230308232421.2672247-2-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20230308232421.2672247-2-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1678318625-oocQ13IRsTRv
X-MDID-O: us5;ut7;1678318625;oocQ13IRsTRv;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please ignore this one, I sent the wrong patch.

On 3/8/23 15:24, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> It was complaining about the 'DISABLE_HE' flag mismatch,
> so ensure that if ifmgd has DISABLE_HE set, then 'flags'
> also will have that flag set.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>   net/mac80211/mlme.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 0efca23be69b..52c8f2770757 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -505,6 +505,10 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
>   	    chandef.width != NL80211_CHAN_WIDTH_80P80)
>   		flags |= IEEE80211_CONN_DISABLE_80P80MHZ;
>   
> +	/* if ifmgd has HE disabled, then we cannot re-enable that here. */
> +	if (link->u.mgd.conn_flags & IEEE80211_STA_DISABLE_HE)
> +		flags |= IEEE80211_STA_DISABLE_HE;
> +
>   	if (cfg80211_chandef_identical(&chandef, &link->conf->chandef))
>   		return 0;
>   

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


