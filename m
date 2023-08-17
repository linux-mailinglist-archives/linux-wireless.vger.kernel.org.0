Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487477F0DC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbjHQHDa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbjHQHDP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 03:03:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C91FE3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=T2+FxTWwdi5RWVxM8+ao989FXfaywpiJgxLj/0bsE7k=;
        t=1692255793; x=1693465393; b=qXYq/x7KmmlGyoP5YeoUpe7k9s6wr834iGN2BwNBiiggdZ8
        /flCU3s5qtUdTjKidXYWMOYnpUbv7IWTCxjMS4dY38iI7UAB7pL/A1fhTlVfNlmQaJbKedx0yG/Vn
        fxAJcqoqihqwP5k4z3n+w7VuexmAMiM19wmhCzvh3g+ZKYHgZ9IliLt4/cT1kfINJieW5bg2x4jTQ
        sMn1JC0hSOImLyGtrKhr/VkNMsEpVoUQ5gy2GxYz/oZEvYH4mgA9stOJjyHytqz+Cpu+uwIE/0Weo
        TvYCIdaPFeX6CEVR0T82j4rllmcfdzdeLHDrHgg/VkUsLXT1OGcbhR7oABQ0/eLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWX28-00Cabg-2q;
        Thu, 17 Aug 2023 09:03:05 +0200
Message-ID: <d55de56e2cc69031f1588fc1db981f5bed640348.camel@sipsolutions.net>
Subject: Re: [RFC] wifi: mac80211: fix UBSAN warning caused by
 reorder_buf_filtered bits shift-out-of-bounds
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org
Date:   Thu, 17 Aug 2023 09:03:03 +0200
In-Reply-To: <20230817053215.51636-1-pkshih@realtek.com>
References: <20230817053215.51636-1-pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> I mark this as RFC, because I'm not sure if iwlwifi needs to extend
> ieee80211_mark_rx_ba_filtered_frames() to support mew hardware that
> hw.max_rx_aggregation_subframes is larger than 64.

Oh, good catch and question, but no. This firmware notification cannot
appear in newer devices, and in fact we don't use mac80211 reordering at
all for a long time (since RSS was introduced, basically) and should
probably prevent handling of this notification.

> If not, we can just
> add some conditions to avoid UBSAN warning like this patch. Otherwise,
> this RFC can't entirely resolve the problem.

Seems fine. I'd kind of probably not word it as "fix UBSAN" since really
it's just more along the lines of "warn if API is misused"? :)

> Since only old hardware with 64 or less RX aggregation frames uses
> ieee80211_mark_rx_ba_filtered_frames(), add a WARN_ONCE() and comment to
> note to avoid using this function if hardware capability is not suitable.
>=20
> Cc: <Stable@vger.kernel.org>

I don't really think this is stable material - if there's a driver
that's calling this when >64 frames is supported then it's a driver bug
that should be fixed, and if not then there's no bug?

> +++ b/net/mac80211/rx.c
> @@ -1083,7 +1083,8 @@ static inline bool ieee80211_rx_reorder_ready(struc=
t tid_ampdu_rx *tid_agg_rx,
>  	struct sk_buff *tail =3D skb_peek_tail(frames);
>  	struct ieee80211_rx_status *status;
> =20
> -	if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
> +	if (tid_agg_rx->reorder_buf_filtered &&
> +	    tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
>  		return true;

Or maybe no - this part is what you think should be=20

> =20
>  	if (!tail)
> @@ -1124,7 +1125,8 @@ static void ieee80211_release_reorder_frame(struct =
ieee80211_sub_if_data *sdata,
>  	}
> =20
>  no_frame:
> -	tid_agg_rx->reorder_buf_filtered &=3D ~BIT_ULL(index);
> +	if (tid_agg_rx->reorder_buf_filtered)
> +		tid_agg_rx->reorder_buf_filtered &=3D ~BIT_ULL(index);

And this.

> @@ -4281,6 +4284,11 @@ void ieee80211_mark_rx_ba_filtered_frames(struct i=
eee80211_sta *pubsta, u8 tid,
> =20
>  	sta =3D container_of(pubsta, struct sta_info, sta);
> =20
> +	local =3D sta->sdata->local;
> +	WARN_ONCE(local->hw.max_rx_aggregation_subframes > 64,
> +		  "RX BA marker can't support max_rx_aggregation_subframes %u > 64\n",
> +		  local->hw.max_rx_aggregation_subframes);
> +

From your description I was only thinking about this.


So yeah I guess it does make some sense to actually call it a fix - for
the parts about using the filtered value with >64 subframes supported
...

Looks fine to me then!

johannes
