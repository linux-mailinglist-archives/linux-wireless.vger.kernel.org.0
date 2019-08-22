Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484E399297
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbfHVLu6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 07:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731963AbfHVLu6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 07:50:58 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B710206BB;
        Thu, 22 Aug 2019 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566474657;
        bh=ZpNEbOgJShZJWPpo8GmJJxCD/DRqbqeYkhXl0nCik9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hItWpq4TKoBPK9QMdaJqp4jIg10wwPyU1zCuw996+jKCwjoDFW43m7b8XlKee9+tt
         qVkUwTuikKGb/8IRe6/uRSf1r2lmBXvS0HcHKaj2Mj4Qw3YlViwVL2vmjTipO105rb
         /lA+76D648Dj+tyxoPSy/OIPfbNJwAYgysNBwTIg=
Date:   Thu, 22 Aug 2019 13:50:52 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: remove empty flag in mt76_txq_schedule_list
Message-ID: <20190822115052.GC3350@localhost.localdomain>
References: <fb24ac317768ec71d16354ef6cd2a9c10931c75d.1566466668.git.lorenzo@kernel.org>
 <20190822103629.GA2368@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20190822103629.GA2368@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Aug 22, 2019 at 11:49:10AM +0200, Lorenzo Bianconi wrote:
> > Remove empty flag in mt76_txq_schedule_list and mt76_txq_send_burst
> > since we just need retry_q length to notify mac80211 to reschedule the
> > current tx queue
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/tx.c | 23 +++++++----------------
> >  1 file changed, 7 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wire=
less/mediatek/mt76/tx.c
> > index d7982aa83c11..51d69329ed06 100644
> > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > @@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
> > =20
> >  static int
> >  mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
> > -		    struct mt76_txq *mtxq, bool *empty)
> > +		    struct mt76_txq *mtxq)
> >  {
> >  	struct ieee80211_txq *txq =3D mtxq_to_txq(mtxq);
> >  	enum mt76_txq_id qid =3D mt76_txq_get_qid(txq);
> > @@ -392,16 +392,12 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct =
mt76_sw_queue *sq,
> >  	bool probe;
> >  	int idx;
> > =20
> > -	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags)) {
> > -		*empty =3D true;
> > +	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags))
> >  		return 0;
>=20
> This changes behaviour for station in PS state. If retry_q is not
> empty, now we will be rescheduling tx queue for STA in PS mode.
> Not sure if this is problem or not, though.

good point..looking at the code it seems not a issue since we will not actu=
ally
tx frames for PS stations. What do you think?

Regards,
Lorenzo

>=20
> Stanislaw

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXV6BmQAKCRA6cBh0uS2t
rAgTAQDDF4b12AqbqHym1wmVQSiuhh8+dj+1y0zAmx3O0B8YIAEAqdjsLQ8+wvz7
Hf5aFkca3O5E3X43BXxLJOGRjN9FpQQ=
=cIYo
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
