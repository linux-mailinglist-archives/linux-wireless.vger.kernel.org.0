Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF7671904
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 11:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjARKf6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 05:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjARKfI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 05:35:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A6C381A
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 01:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DwNWU9H0jlFf7a3RNgRpbLKduCFaN8GBzI42VxtTjDo=;
        t=1674034815; x=1675244415; b=cdYYMYHzyqTHi/qq9rK+PvbMLyTsmZ72bpP0dtoz1fXuaC8
        wUt9e4mXNoJsJJll+OM6J/NKBBrt9v0vhEKTJeuXJNw0DKZJQWFkkfoxude2vPi76bthhaY5gxo4x
        WVBBsvNG8S9uIQKDsZCLZW134RfpSG79b04HhcLd4ifCWXllxkazGbazvegWn7QNohe6qsdz37yiZ
        AiSlzGAxExymLdlSDMSrHAzPOXkDEcZrwWeswZ6Xl0BFVts0+AiW8Sycc/G+mB2XqcWg3P5OqGtWL
        8wIFwlKi+62UQtmSZ79OZ6ClEAH0d9QKLQqCew92Y+L6HWy2MKs86yD2Z3JkmZgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI4vR-005XzM-08;
        Wed, 18 Jan 2023 10:40:09 +0100
Message-ID: <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael Lee <michael-cy.lee@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Wed, 18 Jan 2023 10:40:07 +0100
In-Reply-To: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
References: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So I've looked at this patch a few times, but it just confuses me ...

On Thu, 2022-12-22 at 17:13 +0800, Michael Lee wrote:
> When the link fails to use the channel, chandef's bandwidth will be=20
> downgraded without checking the control channel.
> The issue happens when the STA of an extender with limited channel=20
> context associates with a root AP operating on a different channel.
>=20
> Below is an example:
>=20
>     ______________           ________________
>    | RootAP(ch36) |         | Extender(ch44) |
>    |              | (ASSOC) |       AP       |
>    |      AP <-------------------- STA       |
>    |______________|         |________________|
>=20
> - RootAP is operating on channel 36, while Extender is operating
>   on channel 44

What does this matter? The extended is just a STA, no? Or are you saying
it's important that the extender has a concurrent AP interface that's on
channel 44?

And if you say "ch36" or "ch44" that's just the control channel (I
guess), but what's the actual complete channel configuration?

> - When associating with RootAP, Extender-STA downgrades the
>   chandef's bandwidth to be compatible with any channels on the phy

What do you mean by "on the phy" here? That's not mac80211 terminology,
so not sure.

> - Finally, chandef's bandwidth is downgraded to 20MHz and=20
>   the association fails
>=20
> In this patch, a control channel checking is added to avoid unnecessary
> bandwidth downgrading
>=20
> Signed-off-by: Michael Lee <michael-cy.lee@mediatek.com>
> ---
>  net/mac80211/mlme.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 0aee2392dd29..bc435e8508e2 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -4616,6 +4616,27 @@ ieee80211_verify_sta_he_mcs_support(struct ieee802=
11_sub_if_data *sdata,
>  	return false;
>  }
> =20
> +static bool
> +ieee80211_check_same_ctrl_channel(struct ieee80211_sub_if_data *sdata,
> +				  const struct cfg80211_chan_def *chandef)
> +{
> +	struct ieee80211_local *local =3D sdata->local;
> +	struct ieee80211_chanctx *ctx;
> +
> +	mutex_lock(&local->chanctx_mtx);
> +	list_for_each_entry(ctx, &local->chanctx_list, list) {
> +		if (ctx->replace_state =3D=3D IEEE80211_CHANCTX_WILL_BE_REPLACED)
> +			continue;
> +		if (ctx->mode =3D=3D IEEE80211_CHANCTX_EXCLUSIVE)
> +			continue;
> +		if (chandef->chan =3D=3D ctx->conf.def.chan)
> +			return true;
> +	}
> +
> +	mutex_unlock(&local->chanctx_mtx);
> +	return false;
> +}
> +
>  static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
>  				  struct ieee80211_link_data *link,
>  				  struct cfg80211_bss *cbss,
> @@ -4842,6 +4863,9 @@ static int ieee80211_prep_channel(struct ieee80211_=
sub_if_data *sdata,
>  	    chandef.width =3D=3D NL80211_CHAN_WIDTH_10)
>  		goto out;
> =20
> +	if (!ret || !ieee80211_check_same_ctrl_channel(sdata, &chandef))
> +		goto out;

Not sure I get how this is any different - you're describing a case
where "ret !=3D 0" (because if ret =3D=3D 0 nothing happens in the while
loop), so then you fail _anyway_? So what's the point?

johannes

