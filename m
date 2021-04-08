Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1D3582E9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhDHMLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHMLQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:11:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4ABC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:11:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTV1-008zai-An; Thu, 08 Apr 2021 14:11:03 +0200
Message-ID: <9b475ee0514083ee50c45098bae596fd6a579e89.camel@sipsolutions.net>
Subject: Re: [PATCH v9 3/4] mac80211: add multiple bssid/EMA support to
 beacon handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Thu, 08 Apr 2021 14:11:02 +0200
In-Reply-To: <20210310182604.8858-4-alokad@codeaurora.org> (sfid-20210310_192728_682248_F20E9FF1)
References: <20210310182604.8858-1-alokad@codeaurora.org>
         <20210310182604.8858-4-alokad@codeaurora.org>
         (sfid-20210310_192728_682248_F20E9FF1)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
> 
> +/**
> + * enum ieee80211_bcn_tmpl_ema - EMA beacon generation type
> + * @IEEE80211_BCN_EMA_NONE: don't generate an EMA beacon.
> + * @IEEE80211_BCN_EMA_NEXT: generate the next periodicity beacon.
> + * @IEEE80211_BCN_EMA_INDEX: generate beacon by periodicity index
> + *	if the value is >= this enum value.
> + */
> +enum ieee80211_bcn_tmpl_ema {
> +	IEEE80211_BCN_EMA_NONE	= -2,
> +	IEEE80211_BCN_EMA_NEXT	= -1,
> +	IEEE80211_BCN_EMA_INDEX	= 0,

Maybe call it _BASE instead of _INDEX, it's not really meant to be used
as is?

> +static u8 *ieee80211_copy_multiple_bssid_beacon(u8 *offset,
> +						struct cfg80211_multiple_bssid_data *dest,
> +						struct cfg80211_multiple_bssid_data *src)
> +{
> +	int i;
> +
> +	if (!dest || !src)
> +		return offset;
> +
> +	dest->cnt = src->cnt;
> +	for (i = 0; i < dest->cnt; i++) {
> +		dest->elems[i].len = src->elems[i].len;
> +		dest->elems[i].data = offset;
> +		memcpy(dest->elems[i].data, src->elems[i].data,
> +		       dest->elems[i].len);
> +		offset += dest->elems[i].len;
> +	}


Following my earlier question - here you just copy all the elements one
after another, as far as I can tell, so why did they need to be separate
in the first place? Might be a lot simpler everywhere if all of this was
just a single buffer, starting from the userspace API?


> @@ -4740,13 +4800,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
>  	struct ieee80211_chanctx_conf *chanctx_conf;
>  	int csa_off_base = 0;

> -	rcu_read_lock();
> -
>  	sdata = vif_to_sdata(vif);
>  	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);

OK, but ...

>  struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif,
>  					 u16 *tim_offset, u16 *tim_length)
>  {
>  	struct ieee80211_mutable_offsets offs = {};
> -	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false);
> +	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false,
> +						     IEEE80211_BCN_EMA_NONE);

You didn't add the protection everywhere.

johannes

