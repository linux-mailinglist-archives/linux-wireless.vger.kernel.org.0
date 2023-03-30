Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660016D0062
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjC3J7b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 05:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC3J7a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 05:59:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73868AB
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=E4gtpAoaVvsIp9VU3zuZpD24t4AgdNY4Zuean9+xAbI=;
        t=1680170369; x=1681379969; b=mPb3XQ6h4snbdeKGF4FtxbiCYwepEDTGLzoqfovfrrw/RdN
        cNcnKMzhBbm96qhKHxuNe6itvitk7ZrH/u2ND7SVQ86z9YUfdxZKQVF0bFl4vEB+2jJgBFLxrj5mt
        sluWoPYD9graTynvaC22tFE8lSg7Iii91u/3AKER0gz2DhwPfGi5OPElkbRtvX3T/ILGyON86ziyb
        zy1Jp8F8eD5/rQB7yj0r0P1XTOhlaV2R+K/evG9nf4oAdGSdQMiHUSbEGe3pnxqekYmKcGg4JH01s
        XKxo7o4mlp9MlSFtJ0zf/f8wyHKNl4cYFVZ8lZoUvUjUnJhRGzqM+CGk4+aoaSVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1php43-000ygx-0M;
        Thu, 30 Mar 2023 11:59:27 +0200
Message-ID: <1965b4e3e5df30d94d8526911f372c6f7ea5ce0c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/4] wifi: nl80211: update attributes netlink for S1G
 short beacon
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Thu, 30 Mar 2023 11:59:26 +0200
In-Reply-To: <20221116020700.3907453-3-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
         <20221116020700.3907453-3-gilad.itzkovitch@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-16 at 15:06 +1300, Gilad Itzkovitch wrote:
>=20
> + * @NL80211_ATTR_SHORT_BEACON_HEAD: portion of the short beacon before t=
he TIM IE.
> + * @NL80211_ATTR_SHORT_BEACON_TAIL: portion of the short beacon after th=
e TIM.

I would tend to say "TIM element" these days, since the spec changed
this, but I guess it doesn't matter much.

> + * @NL80211_BSS_SHORT_BEACON_PERIOD: S1G short beacon period in TUs
>   * @__NL80211_BSS_AFTER_LAST: internal
>   * @NL80211_BSS_MAX: highest BSS attribute
>   */
> @@ -4990,6 +5000,7 @@ enum nl80211_bss {
>  	NL80211_BSS_FREQUENCY_OFFSET,
>  	NL80211_BSS_MLO_LINK_ID,
>  	NL80211_BSS_MLD_ADDR,
> +	NL80211_BSS_SHORT_BEACON_PERIOD,

You don't use this.

> +++ b/net/wireless/nl80211.c
> @@ -231,12 +231,18 @@ static int validate_beacon_head(const struct nlattr=
 *attr,
>  	const struct ieee80211_mgmt *mgmt =3D (void *)data;
>  	unsigned int fixedlen, hdrlen;
>  	bool s1g_bcn;
> +	bool s1g_short_bcn;
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
>  		fixedlen =3D offsetof(struct ieee80211_ext,
>  				    u.s1g_beacon.variable);
>  		hdrlen =3D offsetof(struct ieee80211_ext, u.s1g_beacon);

Even the old code here had me worried a bit, and the new code doesn't
make this better - what if you try to set an S1G (short or not) beacon
when the interface isn't using S1G really?

> +	[NL80211_ATTR_SHORT_BEACON_PERIOD] =3D { .type =3D NLA_U16 },

You can add a better range validation here, and then you don't need the
extra validation in the code later.

> +	[NL80211_ATTR_SHORT_BEACON_HEAD] =3D
> +		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head,
> +				       IEEE80211_MAX_DATA_LEN),
> +	[NL80211_ATTR_SHORT_BEACON_TAIL] =3D
> +		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
> +				       IEEE80211_MAX_DATA_LEN),
> +

nit: unnecessary blank line

> +	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
> +		params->short_beacon_period =3D
> +			nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]) =3D=3D 0 ?
> +				1 : nla_get_u32(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);

i.e. you don't need the =3D=3D 0 check if you just reject =3D=3D 0.

Also, you're confusing the types - using NLA_U16 above but nla_get_u32()
here.

johannes

