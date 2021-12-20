Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127647A7C3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 11:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhLTK3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 05:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLTK3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 05:29:16 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC53C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=uM+R8RCEWuEoBIeik750ihaDdq0td8wTGitK28fT+Zk=;
        t=1639996156; x=1641205756; b=McF8JYrlXWCgg1179Pi18komHc9vidBE7R7OejmQwswTu8G
        rhfjm+fGUuyYi35MhbPukT/+Vn0RZVIS1pWC1hWHesu5UZlTXpXvTS1qQC5eelw+J63k6ebNrP3f2
        sd6dboXe0HMLaT6OdDrXRUyUYMJaTNWhKd9RPlT/a4/uupB/K4TGagUlQL60PCFsseRpXLbXPSKTK
        RELhPkpzdlxRCqOZFpWpzjvthVE6LtFDqScwGnFC5ArWDmBNyoKP1Q2qg7u8qZhs9VJjPwIzqN+Ke
        tvbaJYwGjLTIo/vngBJb3ki75HjdYdoTeTuf4/Zo+0Mkudev/YhH8OYg9QRAJWnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzFur-00E3wx-SZ;
        Mon, 20 Dec 2021 11:29:13 +0100
Message-ID: <835682b648d506212da46653404b9ccaf7f35cb0.camel@sipsolutions.net>
Subject: Re: [RFC v2] mac80211: Mesh Fast xmit support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 20 Dec 2021 11:29:12 +0100
In-Reply-To: <1638667044-7031-1-git-send-email-quic_srirrama@quicinc.com>
References: <1638667044-7031-1-git-send-email-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2021-12-05 at 06:47 +0530, Sriram R wrote:
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 775dbb9..089fbb7 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -868,6 +868,8 @@ enum mac80211_tx_info_flags {
>   * @IEEE80211_TX_CTRL_DONT_REORDER: This frame should not be reordered
>   *	relative to other frames that have this flag set, independent
>   *	of their QoS TID or other priority field values.
> + * @IEEE80211_TX_CTRL_CHECK_FAST_MESH: During Mesh xmit, the header of this
> + *	frame can be cached for faster lookup later.
>   *
>   * These flags are used in tx_info->control.flags.
>   */
> @@ -881,6 +883,7 @@ enum mac80211_tx_control_flags {
>  	IEEE80211_TX_INTCFL_NEED_TXPROCESSING	= BIT(6),
>  	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
>  	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
> +	IEEE80211_TX_CTRL_CHECK_FAST_MESH	= BIT(9),

It would be nice if we could get away without this, and shouldn't it
anyway be an internal flag or so, not sure why the driver needs to know?


> +/**
> + * struct mesh_hdr_cache

should have a description there, if it's kernel-doc.

> + * @rhead: the rhashtable containing header cache entries
> + * @walk_head: linked list containing all cached header entries
> + * @walk_lock: lock protecting walk_head
> + * @size: number of entries in the header cache
> + */
> +struct mesh_hdr_cache {
> +	struct rhashtable rhead;
> +	struct hlist_head walk_head;
> +	/* protects header hlist */
> +	spinlock_t walk_lock;
> +	atomic_t size;
> +};

However, is it even worth keeping the few variables here in a separate
allocation?

Mesh might not even be the largest user of space in the interface union,
so perhaps inlining the struct makes sense?

> +static void mesh_hdr_cache_init(struct ieee80211_sub_if_data *sdata)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct mesh_hdr_cache *cache;
> +
> +	sdata->u.mesh.hdr_cache = NULL;
> +
> +	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT))
> +		return;
> +
> +	cache = kmalloc(sizeof(*cache), GFP_ATOMIC);

And if we keep this outside, surely that need not be GFP_ATOMIC?

> 
> +	spin_lock_bh(&cache->walk_lock);
> +	hlist_add_head(&mhdr->walk_list, &cache->walk_head);
> +	spin_unlock_bh(&cache->walk_lock);
> +
> +	atomic_inc(&cache->size);

There's no point in keeping cache->size as an atomic_t, you always
access it very near the spinlock. Better just move it under the
spinlock.

Also are you sure you don't have to put the rhashtable change under the
spinlock??


> @@ -425,6 +808,7 @@ struct mesh_path *mesh_path_add(struct ieee80211_sub_if_data *sdata,
>  						  mesh_rht_params);
>  	if (!mpath)
>  		hlist_add_head(&new_mpath->walk_list, &tbl->walk_head);
> +
>  	spin_unlock_bh(&tbl->walk_lock);

Unrelated change

> +	/* TODO reduce/combine multiple checks which aren't per packet */
> +	if (ifmsh->mshcfg.dot11MeshNolearn)
> +		return false;
> +
> +	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT))
> +		return false;
> +
> +	if (sdata->noack_map)
> +		return false;

Yeah, just don't create cache entries in those cases?

Saves memory (for the more interesting cases) too.

johannes
