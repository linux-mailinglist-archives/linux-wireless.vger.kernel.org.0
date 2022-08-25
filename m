Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EC5A18ED
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiHYSmj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiHYSmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 14:42:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3478C460
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ns0r/7+N5c7+Pc6XkSNv8jQEQfXT4KB6Y3fTCqHo8Hg=;
        t=1661452956; x=1662662556; b=Mp+XhuuAUrzR6gNI8lJncDeUr2sOuKuaHCBwVVs+rYUJvyc
        mu2jIppSaRtQ0hsd00g/A9PiSIKGGTm1BGZ1FkVUzxUtV7HiLpijoDpHy0GYbvw+A+UvOs11GS/zM
        0os2vDHeP5+XY1/rAQz7+o10OZqJpA9z65FwWlokRpEhk4TbXQtIZSduLn+uatthaFcLji+WDGFQq
        N7oCFZtVD1IsLm3Qwy4EDFxQJ7RTvGki6BAkIEWRX9ekmjQu/kBv3tDOhfeEfKhhJRu4po3H4GmfR
        ktMyfIdYNyGiJZeI3fmRFMir5//HIGnLv/VMthGBE5gXmp/GapTviV6/M5/aSrqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRHoH-00H9ar-2I;
        Thu, 25 Aug 2022 20:42:33 +0200
Message-ID: <6fa6b1b62f6a1bc945708cca9e27136f1737386f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] mac80211: Support POWERED_ADDR_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 25 Aug 2022 20:42:32 +0200
In-Reply-To: <1cdf35f95aca2a65d0d738544fb04079125b9581.camel@gmail.com>
References: <20220811231338.563794-1-prestwoj@gmail.com>
         <20220811231338.563794-3-prestwoj@gmail.com>
         <e898282f0766bdf0bd9cbb92d2a3551ff28cdf6b.camel@sipsolutions.net>
         <1cdf35f95aca2a65d0d738544fb04079125b9581.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
=C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (live)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0drv_remove_interface(local, sdata);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D eth_mac_addr(=
dev, sa);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (live)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D drv_add_interface(local, sdata);
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D 0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
> > >=20
> >=20
> > I still don't like the (lack of) error checking here. As far as I know,
> > eth_mac_addr() can very happily fail if the passed address is invalid,
> > so we really shouldn't overwrite the ret value by drv_add_interface().
>=20
> Ah yes, that was an oversight. I assume we do want to add_interface
> even if eth_mac_addr fails though.

Right.

> So my only question is about the
> return from drv_add_interface(). Is this unlikely to fail? If so would
> just a WARN_ON be sufficient and return the value from eth_mac_addr()?

Hm, yeah, I guess it really ought to not fail here.

> So something like:
>=20
> 	if (live)
> 		drv_remove_interface(local, sdata);
> 	ret =3D eth_mac_addr(dev, sa);
> 	if (ret =3D=3D 0)
> 		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
>=20
> 	if (live)
> 		WARN_ON(drv_add_interface(local, sdata));
>=20
> 	return ret;

Seems reasonable. We could do something like

  err =3D drv_add_interface(...);
  if (err) {
     dev_close(...);
     ret =3D ret ?: err;
  }

or something, but not sure that's worth it, it really shouldn't fail at
this point.

But I guess we could leave setting NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA
to the driver if we think it'd be less risky that way?

johannes
