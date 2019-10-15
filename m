Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06440D7A9E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfJOPyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 11:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbfJOPyu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 11:54:50 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51AA320854;
        Tue, 15 Oct 2019 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571154889;
        bh=qV3qVcv5wgEK1k3f7Pdtgc268eBae+4cUcU3ZpfTRpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nw5iMwHscj0uukZrCHQWtlGXdDG9h2MMvIl9aau4LGFUztBkc1NBdDFJrb9bWM7af
         xRusmfHCD3YSw6vXAjcgz9Y4NgOq5Fuvjl8CIe+UBpC+3wxfcIbelqLQ7tZzzsVvcs
         QmSUyYwzbz/59w3+zOmiqK+afmkJX/egIijd1Pb0=
Date:   Tue, 15 Oct 2019 17:54:44 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mt76: refactor cc_lock locking scheme
Message-ID: <20191015155444.GA10108@localhost.localdomain>
References: <252d75b5139a7acb4bdc28c8131e408c2483d8ac.1571151935.git.lorenzo@kernel.org>
 <20191015154250.GA18262@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20191015154250.GA18262@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Oct 15, 2019 at 05:16:43PM +0200, Lorenzo Bianconi wrote:
> > Read busy counters not holding cc_lock spinlock since usb read can't be
> > performed in interrupt context. Move cc_active and cc_rx counters out of
> > cc_lock since they are not modified in interrupt context.
> > Grab cc_lock updating cur_cc_bss_rx in mt76_airtime_report and do not
> > hold rx_lock in mt76_update_survey.
> <snip>
> > Fixes: 168aea24f4bb ("mt76: mt76x02u: enable survey support")
>=20
> I think problem was introduced currently in mt76 driver version
> that is not yet in mainline tree, so this is not right commit.
> On Linus' tree we still read registers outside of cc_lock section.

Hi Stanislaw,

yes, you are right. We should drop the Fixes tag. Thx

>=20
> void mt76x02_update_channel(struct mt76_dev *mdev)
> {
> 	...
>=20
>         busy =3D mt76_rr(dev, MT_CH_BUSY);
>         active =3D busy + mt76_rr(dev, MT_CH_IDLE);
>=20
>         spin_lock_bh(&dev->mt76.cc_lock);
>         state->cc_busy +=3D busy;
>         state->cc_active +=3D active;
>         spin_unlock_bh(&dev->mt76.cc_lock);
> }
>=20
> >  	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
> > -		spin_lock_bh(&dev->rx_lock);
> > -		spin_lock(&dev->cc_lock);
> > +		spin_lock_bh(&dev->cc_lock);
> >  		state->cc_bss_rx +=3D dev->cur_cc_bss_rx;
> >  		dev->cur_cc_bss_rx =3D 0;
> > -		spin_unlock(&dev->cc_lock);
> > -		spin_unlock_bh(&dev->rx_lock);
> > +		spin_unlock_bh(&dev->cc_lock);
>=20
> Why dev->rx_lock was needed before and is not needed now ?

Looking at the code I think rx_lock is not needed here since cur_cc_bss_rx =
is
updated without holding rx_lock in mt76_airtime_report() (we need cc_lock
there).

Regards,
Lorenzo

>=20
> Stanislaw

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXaXrwgAKCRA6cBh0uS2t
rJnHAP0VaasoiTFO8wo4O2OmEZQSZOixVxfWxbBK8q0JpBZLGQD+OS4p0VP3DVJ7
9gyj4r4tycdIqNpgNgQ6zHjPsHlZyAI=
=NMsX
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
