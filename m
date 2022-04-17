Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A753504835
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Apr 2022 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiDQPmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiDQPmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 11:42:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D812AE5
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 08:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44026B80CBA
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5237AC385A7;
        Sun, 17 Apr 2022 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650210003;
        bh=KSB0MYgWPf3L7rb8N4slf+2wJ6SHZh3ifjjYdBaOLKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTrAA/yD8EbYhun+aLbq9bMvvA2hBpuTRI3NF8a7JyNs56FYsUeNIQMx8jjVCl4cq
         cyQ06wcNsyLIeqjFFe6mxF6RoXgrWldQxNb9MjMVldjHKoY5ifCQUpr47T03mUdEBG
         fBEhZSWBg8oA+iF7in/2T7nC9IlqIbHgE6qqBdL4hXD8+j+PpxaMqEbjNXyjTkPU7T
         NZdm9foZXiqxyUKjmF6FdZGZ2B9i3CyFUjCYWfmqOyVdjcaIu81W+p4rKM9qpqkt+3
         XUsfXcYmaZtuD2uYEVbEIsfBQ7NgoemMPP5ZsqkKgQ1N4bNEbOFEr4moacBwmEEDTq
         92CTQ0KfvPGjw==
Date:   Sun, 17 Apr 2022 17:40:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com
Subject: Re: [PATCH 5/6] mt76: mt7915: enable radar background detection
Message-ID: <Ylw00A5YN0mybkCw@localhost.localdomain>
References: <cover.1641996493.git.lorenzo@kernel.org>
 <f97a4fe5bec70d8e5594c0f4d286b46b844939a5.1641996493.git.lorenzo@kernel.org>
 <70c4ecc0-cfc6-e924-6578-3314dca42d75@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c/qzhBrLScOgABlj"
Content-Disposition: inline
In-Reply-To: <70c4ecc0-cfc6-e924-6578-3314dca42d75@candelatech.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--c/qzhBrLScOgABlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 1/12/22 6:13 AM, Lorenzo Bianconi wrote:
> > Notify userland the hw supports background radar/CAC detection.
>=20
> So, what about someone like me using mtk7915 4x4 radio from asia-rf?  It
> has no extra RF chains afaik, and it is certainly broken when
> trying to use DFS channels on my system.

according to my understanding asia-rf card can be considered an outlier from
this point of view (mt7915 regular card should support a dedicated radar ch=
ain).
AFAIU there is no way to autodetect this feature (@Ryder correct?), so we c=
ould
add a module parameter (similar to dts one) to disable this feature. What do
you think?

Regards,
Lorenzo

>=20
> Maybe you need a positive check instead of negative check before
> enabling this feature?
>=20
> Thanks,
> Ben
>=20
> >=20
> > Tested-by: Owen Peng <owen.peng@mediatek.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers=
/net/wireless/mediatek/mt76/mt7915/init.c
> > index 5c1643963506..91c7ce60f296 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > @@ -309,6 +309,7 @@ static void
> >   mt7915_init_wiphy(struct ieee80211_hw *hw)
> >   {
> >   	struct mt7915_phy *phy =3D mt7915_hw_phy(hw);
> > +	struct mt76_dev *mdev =3D &phy->dev->mt76;
> >   	struct wiphy *wiphy =3D hw->wiphy;
> >   	struct mt7915_dev *dev =3D phy->dev;
> > @@ -337,6 +338,12 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
> >   	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
> >   	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
> > +	if (!mdev->dev->of_node ||
> > +	    !of_property_read_bool(mdev->dev->of_node,
> > +				   "mediatek,disable-radar-background"))
> > +		wiphy_ext_feature_set(wiphy,
> > +				      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
> > +
> >   	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
> >   	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
> >   	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
> >=20
>=20
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>=20

--c/qzhBrLScOgABlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYlw0zAAKCRA6cBh0uS2t
rHItAQCDgS4CZSkVBJ5X9lUPEQy4yW9kgFZq1KVpAXoSTCyRLAD+InDPFSPQtJ9u
O3CjwblkH2XGFhXtkCZLBuXNt9+1aAk=
=2Wj0
-----END PGP SIGNATURE-----

--c/qzhBrLScOgABlj--
