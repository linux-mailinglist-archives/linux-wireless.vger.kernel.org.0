Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFED1E2304
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgEZNhz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgEZNhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 09:37:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2754FC03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 06:37:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdZmC-003Ru1-Pm; Tue, 26 May 2020 15:37:52 +0200
Message-ID: <f3cf96426f9532904c9f256d963e7915aa399a90.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] nl80211: add control port tx status method
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 May 2020 15:37:51 +0200
In-Reply-To: <20200508144202.7678-3-markus.theil@tu-ilmenau.de> (sfid-20200508_164230_875169_22AD02AA)
References: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
         <20200508144202.7678-3-markus.theil@tu-ilmenau.de>
         (sfid-20200508_164230_875169_22AD02AA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>  	struct idr ack_status_frames;
>  	spinlock_t ack_status_lock;
>  
> +	u64 ctrl_port_cookie_counter;

We have a u64 for other things (remain-on-channel), perhaps should just
share? It's not going to overflow even if shared ...

>  	/* disable bottom halves when entering the Tx path */
>  	local_bh_disable();
> -	__ieee80211_subif_start_xmit(skb, dev, flags, 0);
> +	__ieee80211_subif_start_xmit(skb, dev, flags, 0, NULL);

This is a little awkward, any way to avoid that? Probably not ...

> +static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
>  				   struct sk_buff *skb,
> -				   u32 *info_flags)
> +				   u32 *info_flags,
> +				   bool use_socket,
> +				   u64 *cookie)
>  {
> -	struct sk_buff *ack_skb = skb_clone_sk(skb);
> +	struct sk_buff *ack_skb;
>  	u16 info_id = 0;
>  
> +	if (use_socket)

You can check skb->sk and not need the additional parameter.

>  	if (unlikely(!multicast && skb->sk &&
>  		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
> -		info_id = ieee80211_store_ack_skb(local, skb, &info_flags);
> +		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
> +						  true, NULL);
> +
> +	if (unlikely(!multicast && ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
> +		info_id = ieee80211_store_ack_skb(local, skb, &info_flags,
> +						  false, cookie);

I think this should be rolled into one condition, since you no longer
need the true/false if you check skb->sk. And 'cookie' is already NULL
in those other cases so you can pass it unconditionally.

> @@ -2765,8 +2795,9 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
>  	if (skb_shared(skb)) {
>  		struct sk_buff *tmp_skb = skb;
>  
> -		/* can't happen -- skb is a clone if info_id != 0 */
> -		WARN_ON(info_id);
> +		if (!(ctrl_flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
> +			/* can't happen -- skb is a clone if info_id != 0 */
> +			WARN_ON(info_id);

This I don't understand, but if it really is needed then you should
adjust the comment and roll it into a single WARN_ON().

Also, please put all the remaining mac80211 changes into one patch - I
already put all the other changes in.

johannes

