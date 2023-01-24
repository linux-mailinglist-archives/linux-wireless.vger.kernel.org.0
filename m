Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799B0679B29
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jan 2023 15:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjAXOKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 09:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjAXOKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 09:10:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7A42BE8
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 06:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D27CCE1B18
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 14:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18523C433D2;
        Tue, 24 Jan 2023 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674569396;
        bh=sUSQ4rRR2voo2ldj3QiVRjuvbcztF53dx1O09U7qYPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgo/aXDqlADdG/gzPAmab7GsI6zR9KgqMek7O50kMuM/zJdMbYSeE8UKewm03SmzK
         5tE2VP4rYydyXZMVHS7KvjACOXM0z1ZmNHLN3zntM8ZBhyleuLe+pq6AK7ngOadHSS
         GhLgjr8Ei2DWAqLiwE6wBOWqHPKHhfUUaR6R1vo/i7wdTgRiGq7hp04Q5/FLeBy+tI
         hm6wulGlEHK6c3fX8FcXi+oNgb09o5rnkiCI2uBAKNDHo3vjzB8mN8CSbJkiWsWgy7
         khetK+M617cv/b3uSandB6U15su966EH88IW7dEwLTEtjjU7DM/P1Ppz3WAeT0kxdG
         tZuvLDsk8sF7w==
Date:   Tue, 24 Jan 2023 15:09:52 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
Message-ID: <Y8/msHegwheXGWze@lore-desk>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
 <20221226083328.29051-2-quic_ramess@quicinc.com>
 <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
 <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
 <Y8q5Z98S3pODD77W@lore-desk>
 <eac1cf31-518f-6542-24c6-69e6c059f3c9@green-communications.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UXJYoUx10BtVHe1a"
Content-Disposition: inline
In-Reply-To: <eac1cf31-518f-6542-24c6-69e6c059f3c9@green-communications.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--UXJYoUx10BtVHe1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On 20/01/2023 16:55, Lorenzo Bianconi wrote:
> > I agree, I think we can ratelimit netlink messages sent by the kernel to
> > userspace (e.g. to hostapd), I would say every 500ms is ok.
> > I guess we can move cfg80211_obss_color_collision_notify() in a dedicat=
ed
> > delayed_work so we can grab wdev mutex (cfg80211_obss_color_collision_n=
otify is
> > currently running in interrupt context).
> > To give an idea, what do you think about patch below? (please note it i=
s just
> > compiled tested so far).
>=20
> The patch does not work, the fix appears easy:
> > +void ieee80211_color_collision_detection_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *delayed_work =3D to_delayed_work(work);
> > +	struct ieee80211_link_data *link =3D
> > +		container_of(delayed_work, struct ieee80211_link_data,
> > +			     dfs_cac_timer_work);
>=20
> This should probably be color_collision_detect_work.

Yep, sorry. It is just a copy paste issue :)
I will share a new version.

Regards,
Lorenzo

>=20
> > +	struct ieee80211_sub_if_data *sdata =3D link->sdata;
> > +
> > +	sdata_lock(sdata);
>=20
> It crashed here, link is NULL.
>=20
> > +	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
> > +					     GFP_KERNEL);
> > +	sdata_unlock(sdata);
> > +}
> Will test the fixed version later.

--UXJYoUx10BtVHe1a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8/msAAKCRA6cBh0uS2t
rI7GAP9cHNQ2OD3bpQyWnbor78X4lca5ghTsqvOQwjII59oUEgD+KTMnOcxwvUEc
8TP1mK6SZYd9dKJyWpSRtiSoGN0PXQU=
=erja
-----END PGP SIGNATURE-----

--UXJYoUx10BtVHe1a--
