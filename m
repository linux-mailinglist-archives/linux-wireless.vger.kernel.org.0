Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAA6076D8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiJUMXA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJUMW7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:22:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128ED76950
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0IBrwq7RADQTvQv+afgXSTWn99wrDKxxDQ5b1/unnus=;
        t=1666354977; x=1667564577; b=JZ44iKftBA3vAu+6J2gBrYc1JyjaTgKjyIvu67geR92fZMU
        yfcl2nETyotObV6sjvRDpplxL06rNYsZ2kLBReok7KdnBM4CVe65ff7oYjtmQlCWUOt+2XWtZySv2
        E3jmNBafPpxMn8rZNLsg67ymvwANbJ+OIB/GRxnvSidOBtUSJVofITqcg1UQveydHDvc3THENIJEv
        rsn/TGtc/rQiXOscqPmSA5surbKH/TCevdMVM5jhic1Uf3j4x4tfkKk36He6UGoRN7rh83ARVNjbr
        g+yGpDQosIVUQA6CqslgV/SnVwqsPVAYfWEvkUqxv9cVLi1Z7r9xnejDWKA/90LA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olr38-00Cr76-2K;
        Fri, 21 Oct 2022 14:22:54 +0200
Message-ID: <cca0f1a361400e71f41027e3f5e9a2c9353c008f.camel@sipsolutions.net>
Subject: Re: [RFC 3/4] wifi: cfg80211/mac80211: extend iface comb
 advertisement for multi-hardware dev
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 21 Oct 2022 14:22:53 +0200
In-Reply-To: <20220920100518.19705-4-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
         <20220920100518.19705-4-quic_vthiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
>=20
> +struct ieee80211_iface_per_hw {
> +	u8 hw_chans_idx;
> +	const struct ieee80211_iface_limit *limits;
> +	u32 num_different_channels;
> +	u16 max_interfaces;
> +	u8 n_limits;
> +};

nit: moving hw_chans_idx last would get rid of all the padding :)


> + *    Drivers advertising per-hardware interface combination should also
> + *    advertise a sub-set of capabilities using existing interface mainl=
y for
> + *    maintaining compatibility with the user space which is not aware o=
f the
> + *    new per-hardware advertisement.
> + *
> + *    Sub-set interface combination advertised in the existing infrastru=
cture:
> + *    Allow #STA <=3D 1, #AP <=3D 1, channels =3D 1, total 2
> + *
> + *    .. code-block:: c
> + *
> + *	struct ieee80211_iface_limit limits4[] =3D {
> + *		{ .max =3D 1, .types =3D BIT(NL80211_IFTYPE_STATION), },
> + *		{ .max =3D 1, .types =3D BIT(NL80211_IFTYPE_AP), },
> + *	};
> + *	struct ieee80211_iface_limit limits5_2ghz[] =3D {
> + *		{ .max =3D 1, .types =3D BIT(NL80211_IFTYPE_STATION), },
> + *		{ .max =3D 1, .types =3D BIT(NL80211_IFTYPE_AP), },
> + *	};
> + *	struct ieee80211_iface_limit limits5_5ghz[] =3D {
> + *		{ .max =3D 1, .types =3D BIT(NL80211_IFTYPE_STATION), },
> + *		{ .max =3D 2, .types =3D BIT(NL80211_IFTYPE_AP), },
> + *	};

Where does the limits4/limits5 naming come from? The number of
interfaces I guess? To me that wasn't so clear, maybe it makes more
sense to name them

	limits_overall,
	limits_2ghz, and
	limits_5ghz

respectively?

(yeah, obviously I know this is just an example)

> +/**
> + * cfg80211_hw_chans_includes_dfs - check if per-hardware channel includ=
es DFS
> + *	@chans: hardware channel list

prefer space instead of tab I think?

> + * Please note the channel is checked against the entire range of DFS
> + * freq in 5 GHz irrespective of regulatory configurations.

Not sure what you mean by this? Is that different somehow from what we
did before?

> +++ b/net/mac80211/main.c
> @@ -933,6 +933,45 @@ static int ieee80211_init_cipher_suites(struct ieee8=
0211_local *local)
>  	return 0;
>  }
> =20
> +static int
> +ieee80211_check_per_hw_iface_comb(struct ieee80211_local *local,
> +				  const struct ieee80211_iface_combination *c)
> +{

Why is this in mac80211? Wouldn't such a check apply equally to any non-
mac80211 driver?

> +	int h, l;
> +	u32 hw_idx_bm =3D 0;
> +
> +	if (!local->use_chanctx)
> +		return -EINVAL;

Maybe mac80211 has this extra check, and can keep it, but

> +
> +	for (h =3D 0; h < c->n_hw_list; h++) {
> +		const struct ieee80211_iface_per_hw *hl;
> +		const struct ieee80211_chans_per_hw *chans;
> +
> +		hl =3D &c->iface_hw_list[h];
> +
> +		if (hl->hw_chans_idx >=3D local->hw.wiphy->num_hw)
> +			return -EINVAL;
> +
> +		chans =3D local->hw.wiphy->hw_chans[hl->hw_chans_idx];
> +		if (c->radar_detect_widths &&
> +		    cfg80211_hw_chans_includes_dfs(chans) &&
> +		    hl->num_different_channels > 1)
> +			return -EINVAL;
> +
> +		for (l =3D 0; l < hl->n_limits; l++)
> +			if ((hl->limits[l].types & BIT(NL80211_IFTYPE_ADHOC)) &&
> +			    hl->limits[l].max > 1)
> +				return -EINVAL;
> +
> +		if (hw_idx_bm & BIT(h))
> +			return -EINVAL;
> +
> +		hw_idx_bm |=3D BIT(h);

this pretty much seems applicable to do in cfg80211?

> @@ -1035,6 +1074,21 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  		}
>  	}
> =20
> +	for (i =3D 0; i < local->hw.wiphy->n_iface_combinations; i++) {
> +		const struct ieee80211_iface_combination *comb;
> +
> +		comb =3D &local->hw.wiphy->iface_combinations[i];
> +
> +		if (comb->n_hw_list && !local->hw.wiphy->num_hw)
> +			return -EINVAL;
> +
> +		if (!comb->n_hw_list)
> +			continue;
> +
> +		if (ieee80211_check_per_hw_iface_comb(local, comb))
> +			return -EINVAL;
> +	}

and this then, of course.

> +++ b/net/wireless/core.c
> @@ -563,10 +563,126 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_o=
ps *ops, int sizeof_priv,
>  }
>  EXPORT_SYMBOL(wiphy_new_nm);
> =20
> +static int
> +wiphy_verify_comb_limit(struct wiphy *wiphy,
> +			const struct ieee80211_iface_limit *limits,
> +			u8 n_limits, u32 bcn_int_min_gcd, u32 *iface_cnt,
> +			u16 *all_iftypes)

oh wait, you did it twice?

is there anything that mac80211 adds extra?

>  static int wiphy_verify_combinations(struct wiphy *wiphy)
>  {
>  	const struct ieee80211_iface_combination *c;
> -	int i, j;
> +	int i;
> +	int ret;
> =20
>  	for (i =3D 0; i < wiphy->n_iface_combinations; i++) {
>  		u32 cnt =3D 0;
> @@ -593,54 +709,11 @@ static int wiphy_verify_combinations(struct wiphy *=
wiphy)
>  		if (WARN_ON(!c->n_limits))
>  			return -EINVAL;
> =20
> -		for (j =3D 0; j < c->n_limits; j++) {
> -			u16 types =3D c->limits[j].types;
>=20
[...]
> +		ret =3D wiphy_verify_comb_limit(wiphy, c->limits, c->n_limits,
> +					      c->beacon_int_min_gcd,
> +					      &cnt, &all_iftypes);


Might be nice to break out this refactoring to a separate patch (and
feel free to send it right away as PATCH, it's kind of worthwhile
anyway), I think? Unless I missed something that changed here, but then
it'd be even more worthwhile so I see it ;-)

> +bool
> +cfg80211_hw_chans_includes_dfs(const struct ieee80211_chans_per_hw *chan=
s)
> +{

[...]
> +EXPORT_SYMBOL(cfg80211_hw_chans_includes_dfs);

Since it's exported - who would use it and for what?

johannes
