Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96A5BB030
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIPP2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIPP2o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 11:28:44 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA179AB40A
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=INFQFudAs4nKStIvoqPpyrmfJKCcgzNpJS8nKrPHAXI=; b=UZauaVTUjQf7I8eEFR9+GgT93J
        v6RGQVKGc8bpasEHdRbTIrQx1Tb9ECJQxEtYz7PPkMfzmkPdoXpa26ojvEQwqjLZSFHddf1IkBv8u
        VszX4gORiTsagIGyCxPqBTpI5nC0rLmoX4y6hiNZu/1iD7GVaujGKYo/VBVZvpfZHSV4=;
Received: from p200300daa7301d00800d35b6f1da0728.dip0.t-ipconnect.de ([2003:da:a730:1d00:800d:35b6:f1da:728] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oZDGh-005M3C-Jb; Fri, 16 Sep 2022 17:28:39 +0200
Message-ID: <3c9bf984-806e-d670-eefe-1a9d21d5974e@nbd.name>
Date:   Fri, 16 Sep 2022 17:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2] wifi: mac80211: fix decapsulation offload flag for WDS
 interface
Content-Language: en-US
To:     Howard Hsu <howard-yh.hsu@mediatek.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20220916142707.28478-1-howard-yh.hsu@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220916142707.28478-1-howard-yh.hsu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 16.09.22 16:27, Howard Hsu wrote:
> Rx decapsulation offload cannot be enabled on WDS interface since its
> offload_flags is not configured. Its offload_flags shall be configured
> by checking hardware information.
> 
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> ---
> v2:
>     - Configure offload_flags in ieee80211_check_fast_rx
>     - Update commit message
> ---
>   net/mac80211/rx.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index a57811372027..0d8cfe34b088 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4433,6 +4433,16 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
>   	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
>   		goto clear;
>   
> +	if (ieee80211_hw_check(&local->hw, SUPPORTS_RX_DECAP_OFFLOAD)) {
> +		sdata->vif.offload_flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
> +
> +		if (local->monitors &&
> +		    !ieee80211_hw_check(&local->hw, SUPPORTS_CONC_MON_RX_DECAP))
> +			sdata->vif.offload_flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
> +	} else {
> +		sdata->vif.offload_flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
> +	}
I don't think you should be messing with decap flags here.
Further down there's a piece of code that does:

     offload = assign &&
           (sdata->vif.offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED);

Please change the code so that it gets the sdata from sdata->bss and 
check sdata_bss->vif.offload_flags.

- Felix
