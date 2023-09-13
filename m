Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333279E741
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 13:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjIMLvY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 07:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjIMLvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 07:51:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5242E1BCA
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OXNscLCa3AoZyyZVG3v8revC7I7bPgbSYt9ISLXjM+s=;
        t=1694605862; x=1695815462; b=GEwYkhHr+Y/ymkdmZj7IdRRcnNXYMmYqW8b+Qj4tti5kGjM
        J2gq534FRrEo4t1RV+ZwDyA/vgJKqECIRTkIOCmW+F3+WmxVh6Vn2oFEdEf2E8ih0ONBKE0JSAjor
        k7FbYmeXXt2YvecqqJp2Lri4hVasjDVA5N7x2TLKqcoT6LeQnjz9BvLZgINitQVhFzwypfwN71ANT
        QIGEVi+SGaD9dEFsOX1dzIxejzMxeKt7pHY908E3VvNTrUo3nczSHw1jJE/xTqEztxp9YZMn0Vu8U
        /Uy6Chvi5EaQwdvqIosfI2949x0/7i6U7bXYwHbuRqBtPm9OL8+4nAnydDFxXLvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgOOZ-00Es0I-0x;
        Wed, 13 Sep 2023 13:50:59 +0200
Message-ID: <2258bae0344f44b9adff1e22125eeffb1c2fe64b.camel@sipsolutions.net>
Subject: Re: [PATCH v7 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bassem Dawood <bassem@morsemicro.com>,
        linux-wireless@vger.kernel.org
Cc:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        kernel test robot <lkp@intel.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Date:   Wed, 13 Sep 2023 13:50:58 +0200
In-Reply-To: <20230810093556.33800-1-bassem@morsemicro.com>
References: <20230810093556.33800-1-bassem@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-08-10 at 19:35 +1000, Bassem Dawood wrote:
> From: Kieran Frewen <kieran.frewen@morsemicro.com>
>=20
> Support variables to handle short beacon period and adding a
> separate tail/head for them. Also, add short beacon period,
> head and tail attributes for user configuration.

So I'm confused by this commit - maybe the commit log should have more
words ;-)

> +++ b/include/net/cfg80211.h
> @@ -1211,8 +1211,13 @@ struct cfg80211_rnr_elems {
>   *	or %NULL if not changed
>   * @tail: tail portion of beacon (after TIM IE)
>   *	or %NULL if not changed
> + * @short_head: head portion of short beacon or %NULL if not changed
> + * @short_tail: short tail portion of beacon (after TIM IE)
> + *	or %NULL if not changed
>   * @head_len: length of @head
>   * @tail_len: length of @tail
> + * @short_head_len: length of @short_head
> + * @short_tail_len: length of @short_tail
>   * @beacon_ies: extra information element(s) to add into Beacon frames o=
r %NULL
>   * @beacon_ies_len: length of beacon_ies in octets
>   * @proberesp_ies: extra information element(s) to add into Probe Respon=
se
> @@ -1241,6 +1246,7 @@ struct cfg80211_beacon_data {
>  	unsigned int link_id;
> =20
>  	const u8 *head, *tail;
> +	const u8 *short_head, *short_tail;

All of this makes me think that for S1G you need _both_ short and
regular beacons. Similar to what FILS discovery frames did elsewhere.
Which makes a lot of sense, I guess, though arguably we could go the
route that FILS did, with "fils_discovery" in struct
cfg80211_ap_settings. See also Aloka's recent commits, which now pass
the whole struct on updates, though I'm thinking we might change that
again:

https://lore.kernel.org/linux-wireless/1912863dcd17aa50b09d1ddfc889478eb323=
f901.camel@sipsolutions.net/T/#m86511f184d40ab36221f4ceae066900233ceb84e

However, then we have this:

> +++ b/net/wireless/nl80211.c
> @@ -230,13 +230,19 @@ static int validate_beacon_head(const struct nlattr=
 *attr,
>  	const struct element *elem;
>  	const struct ieee80211_mgmt *mgmt =3D (void *)data;
>  	unsigned int fixedlen, hdrlen;
> -	bool s1g_bcn;
> +	bool s1g_bcn =3D false;
> +	bool s1g_short_bcn =3D false;
> =20
>  	if (len < offsetofend(typeof(*mgmt), frame_control))
>  		goto err;
> =20
>  	s1g_bcn =3D ieee80211_is_s1g_beacon(mgmt->frame_control);
> -	if (s1g_bcn) {
> +	s1g_short_bcn =3D ieee80211_is_s1g_short_beacon(mgmt->frame_control);
> +	if (s1g_short_bcn) {
> +		fixedlen =3D offsetof(struct ieee80211_ext,
> +				    u.s1g_short_beacon.variable);
> +		hdrlen =3D offsetof(struct ieee80211_ext, u.s1g_short_beacon);
> +	} else if (s1g_bcn) {

which all makes it look like you can put a short beacon into
NL80211_ATTR_BEACON_HEAD, but that _shouldn't_ be true?

So maybe this was just a (bad) shortcut, and you really should refactor
this function into two (that can call some common code, of course) that
gets put into the policy?

Because detecting which kind of beacon you get passed rather than
validating that you get passed the right type isn't really validation,
I'd think?

Never mind that the=20

> 	if (len < offsetofend(typeof(*mgmt), frame_control))

check is probably somewhat wrong anyway? Or, well, no it's not wrong
because you're checking for 2 bytes anyway, but it reads wrong because
you're checking typeof(*mgmt) which is mgmt, not ext ...

Put some kind of comment/BUILD_BUG at least? But if it's split, maybe it
won't be needed, depends how you split it.

>  	if (attrs[NL80211_ATTR_BEACON_HEAD]) {
> +		struct ieee80211_mgmt *mgmt;
> +
>  		bcn->head =3D nla_data(attrs[NL80211_ATTR_BEACON_HEAD]);
>  		bcn->head_len =3D nla_len(attrs[NL80211_ATTR_BEACON_HEAD]);
>  		if (!bcn->head_len)
>  			return -EINVAL;
> +
> +		mgmt =3D (void *)bcn->head;
> +		if (ieee80211_is_s1g_beacon(mgmt->frame_control) && !is_s1g_band)
> +			return -EINVAL;
> +		else if (ieee80211_is_beacon(mgmt->frame_control) && is_s1g_band)
> +			return -EINVAL;

But then again ... here you _do_ allow an S1G beacon in the
NL80211_ATTR_BEACON_HEAD, so I'm even more confused ...

Hmm.

I guess maybe you have long and short beacons, but they're _both_ ext
format? Really the comments/commit messages/etc. could make all that
clearer for all those who are not intimately familiar with the S1G spec.

> @@ -5944,6 +6002,10 @@ static int nl80211_start_ap(struct sk_buff *skb, s=
truct genl_info *info)
>  		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
>  	params->dtim_period =3D
>  		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
> +	params->short_beacon_period =3D 1;
> +	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
> +		params->short_beacon_period =3D
> +			nla_get_u16(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);

Probably should reject that too on !s1g_band, and why is the default
value 1? Your documentation doesn't even say what unit it is:

> + * @NL80211_ATTR_SHORT_BEACON_PERIOD: (u16) period for S1G long beacon

(and it also talks about long beacon which is probably not right)

So I'd think it's also in TU, but then 1 doesn't make any sense...

> @@ -6237,7 +6284,8 @@ static int nl80211_set_beacon(struct sk_buff *skb, =
struct genl_info *info)
>  	if (!wdev->links[link_id].ap.beacon_interval)
>  		return -EINVAL;
> =20
> -	err =3D nl80211_parse_beacon(rdev, info->attrs, &params, info->extack);
> +	err =3D nl80211_parse_beacon(rdev, info->attrs, &params, info->extack,
> +		wdev->links[link_id].ap.chandef.chan->band =3D=3D NL80211_BAND_S1GHZ);

Unrelated, but somewhere in here I hope we don't allow S1G and MLO to
coexist ... :-)

(So link_id should always be 0 for S1G here.)

johannes
