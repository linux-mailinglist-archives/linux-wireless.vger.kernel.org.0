Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816DC1B2B9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfEMJTM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 05:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfEMJTM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 05:19:12 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E957620989;
        Mon, 13 May 2019 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557739151;
        bh=yH69p5I1L3kzUlgk9xT0EtkDTEYQEKvrCr1JjK1EkuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7Iy7S13QdGr2Y8MyLpvlB3V1226HH+H+r1bTnEnz1o7OXvnbYpfXl5BI7J2WDKoS
         9EPrBkz43bj7pQM1OCt54EDcZnkLcDbpaMeJMUImYTLe6SjCJwXxYVjxLF+AYc70M7
         SuNyxF5nYtBkzmpyztwdfHnbY2UFG004fSi2MQ7s=
Date:   Mon, 13 May 2019 11:19:06 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/4] mt76: mt76x2: move mutex_lock inside
 mt76x2_set_channel
Message-ID: <20190513091905.GB3127@localhost.localdomain>
References: <cover.1557567465.git.lorenzo@kernel.org>
 <1527e88fc4a307aa218f515811f2f2c15786caec.1557567465.git.lorenzo@kernel.org>
 <20190513083755.GA13726@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20190513083755.GA13726@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, May 11, 2019 at 12:17:53PM +0200, Lorenzo Bianconi wrote:
> > This is a preliminary patch to run mt76x02_edcca_init atomically
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 16 ++++++++------
> >  .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 22 ++++++++++---------
> >  2 files changed, 21 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/dri=
vers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> > index e416eee6a306..3a1467326f4d 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> > @@ -54,14 +54,14 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct =
cfg80211_chan_def *chandef)
> >  	int ret;
> > =20
> >  	cancel_delayed_work_sync(&dev->cal_work);
>=20
> Since now you use mutex in mt76x2_phy_calibrate() you can remove =20
> cancel_delayed_work_sync() and drop other changes from this patch
> as releasing mutex just to acquire it in almost next step make
> no sense.

I agree with you, the only difference is in that way we will perform phy
calibration even during scanning. If the there are no
objections I will post a v3 removing cancel_delayed_work_sync and
reworking patch 3/4

Regards,
Lorenzo

>=20
> Stanislaw

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNk2hgAKCRA6cBh0uS2t
rD8kAQDx6KUtx9K08KPcxEk4sQWbAPN9EZFRouV8ehVuEz4OwAD+NlIOi6lJnGFO
azYB+pG1j6fJlAG/kmqJVvIwO1bWiQQ=
=enL+
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
