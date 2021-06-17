Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321B03ABC56
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 21:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhFQTKp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFQTKp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 15:10:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45172C061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BzMbr1VGLhl2EWCSEqSY1+QNCfXNTbceWdDzZ9hAMEI=; b=G+wRYn8igscVmTsNdzVTTTjvC4
        ZOa20uLsxJB30mzuQ7UEnwbSpjsIQqHO7uatW7ly63gW/mk9qMvwaWdM/oa0ebGCI+02c7Vg6zy+v
        RTajdiMBrueQj6Qg1xGSn2M1Fn0INW/D8gio+QPP2UokWQhqh+5ShRFn1WF0IYL/jIUg=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ltxNR-0004Az-VW; Thu, 17 Jun 2021 21:08:34 +0200
Subject: Re: [PATCH 1/4] mac80211: check per vif offload_flags in Tx path
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <4718d8041f908cb3249ec68c59a6854919f00752.1623955182.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <18027bdb-19d7-f342-af35-ed304f730678@nbd.name>
Date:   Thu, 17 Jun 2021 21:08:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4718d8041f908cb3249ec68c59a6854919f00752.1623955182.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-17 20:53, Ryder Lee wrote:
> offload_flags has been introduced to indicate encap status of each interface.
> An interface can encap offload at runtime, or if it has some extra limitations
> it can simply override the flags, so it's more flexible to check offload_flags
> in Tx path.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  net/mac80211/tx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 0a4bc9e08637..8cb1289c704a 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3695,7 +3698,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>  	}
>  
>  	if (skb_has_frag_list(skb) &&
> -	    !ieee80211_hw_check(&local->hw, TX_FRAG_LIST)) {
> +	    (!ieee80211_hw_check(&local->hw, TX_FRAG_LIST) ||
> +	     vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)) {
>  		if (skb_linearize(skb)) {
>  			ieee80211_free_txskb(&local->hw, skb);
>  			goto begin;
I think this chunk should be dropped.

- Felix
