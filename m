Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAA15AE626
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiIFLF0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 07:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiIFLFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 07:05:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394F45F211
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mD+gV0Q0C6/69LawiK1ujI5SAhzpI1hQJONYLnuFiis=;
        t=1662462322; x=1663671922; b=HPyO3EMtLKnJtgNZI5zIxXc2pT1E6CaPGMFzqLOG+4eAzEm
        k0WoktXdkNEq9ZbQ9p6h/Vwv8kNyigDAULimQxm2v0OCskZIs+YKokkXDd/yvCouZo2M0GvFqEOOZ
        3k0P2w300dgQ2Ttw8MBddIkBXbecKJShdBYfd3Y+ReMhEJaZy7H1TX18o0EJWpROuASK5zcqH0QVM
        ORs/IJFHL+djtMBNWBMUxRM6bugI7ZR86OkoJxnki72blPcQX42YBT56mEKD2sqeRRFBQG1A2mOqB
        5TjDethrTgZQfp1ra4jrhlYCBkRlmcLw/tLoI282iadXDPEze8X+anoaMjQGsDVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVWON-009PSt-2p;
        Tue, 06 Sep 2022 13:05:19 +0200
Message-ID: <b36799bc1129baebbb64032deeaae72e4ca1af7b.camel@sipsolutions.net>
Subject: Re: [PATCH 4/7] cfg80211: add NL command to set 6 GHz power mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 06 Sep 2022 13:05:19 +0200
In-Reply-To: <20220704102341.5692-5-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
         <20220704102341.5692-5-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>=20
> + * @NL80211_ATTR_6GHZ_REG_AP_POWER_MODE: Configure 6 GHz regulatory powe=
r mode
> + *	for access points. Referenced from &enum ieee80211_ap_reg_power.
> + *
> + * @NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE: Configure 6 GHz regulatory =
power
> + *	mode for clients. Referenced from &enum ieee80211_client_reg_power.

I don't really see a good reason to have two attributes for this, rather
than validating their value based on the iftype?

>  	err =3D __cfg80211_stop_ap(rdev, dev, link_id, notify);
> +
> +	if (wdev->reg_6ghz_pwr_configured)
> +		wdev->reg_6ghz_pwr_configured =3D false;

no need to check first

> +static int nl80211_set_6ghz_power_mode(struct sk_buff *skb,
> +				       struct genl_info *info)
> +{
> +	struct net_device *dev =3D info->user_ptr[1];
> +	struct wireless_dev *wdev =3D NULL;
> +	enum nl80211_iftype iftype =3D NL80211_IFTYPE_UNSPECIFIED;
> +	int ret =3D -EINVAL;
> +
> +	if (dev)
> +		wdev =3D dev->ieee80211_ptr;
> +
> +	if (wdev)
> +		iftype =3D wdev->iftype;

that's all pretty useless

> +	if (iftype !=3D NL80211_IFTYPE_AP &&
> +	    iftype !=3D NL80211_IFTYPE_STATION)
> +		return -EOPNOTSUPP;

you're going to return here anyway ...

Better to just simplify that and return if there's no wdev, and actually
you can enforce that anyway through the internal flags?? Not sure why
you do all this.

Btw, all of that probably also needs to be per *link* rather than per
*interface* now, with MLO?

> +	if (!info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE] &&
> +	    !info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE])
> +		return -EINVAL;
> +
> +	wdev_lock(wdev);
> +	if (wdev->reg_6ghz_pwr_configured) {
> +		wdev_unlock(wdev);
> +		return -EALREADY;
> +	}
> +
> +	if (iftype =3D=3D NL80211_IFTYPE_AP &&
> +	    info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE]) {
> +		wdev->ap_6ghz_power =3D
> +		  nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE]);
> +		ret =3D 0;
> +	}
> +
> +	if (iftype =3D=3D NL80211_IFTYPE_STATION &&
> +	    info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE]) {
> +		wdev->client_6ghz_power =3D
> +		  nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE]);
> +		ret =3D 0;
> +	}
> +
> +	if (!ret)
> +		wdev->reg_6ghz_pwr_configured =3D true;

and honestly that logic here with the two attributes is pretty
strange...

I'd even say you should remove the union in the wdev struct since you
only can have one of them at a time anyway

> +	{
> +		.cmd =3D NL80211_CMD_SET_6GHZ_POWER_MODE,
> +		.validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit =3D nl80211_set_6ghz_power_mode,
> +		.flags =3D GENL_UNS_ADMIN_PERM,
> +		.internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV),

if you have netdev then you have wdev too, later

> =20
> +	if (wdev->reg_6ghz_pwr_configured)
> +		wdev->reg_6ghz_pwr_configured =3D false;
>=20

No need for if

johannes
