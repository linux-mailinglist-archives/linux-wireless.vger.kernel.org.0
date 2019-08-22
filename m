Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1769941B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbfHVMoi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 08:44:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbfHVMoh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 08:44:37 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5576465F40
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2019 12:44:36 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k15so3134769wrw.18
        for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2019 05:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LIA8LN5z1mrBIPf3/Fd+Z8/FG0/7ikHtG0+JTaBAUxI=;
        b=buLuxylgwdJ1V0D19tRyTi6jkxNUCgePuXZ1I8d5j7iopK5CKcqH1JhA6HKDTGYq+S
         vt7Zfe6FuR83CDKi3oZquxksH8lb7fYnuMOoiH4Ns4xBH7BZw4Cp6LeYmNky90LDTl1e
         vEm9Xz0TZqMKDeTRF6MuTxzkUzvR4Y1Kd0udeoILxpqm0TUCBCmWfz6OYrYMGhr7Dund
         8wXtu04I+XPrBnyFWHu+R2Z3rw0tRgJ8Oq2Z0u1FJmdo6bVGGlHpoeJi/C6dparz/V4b
         K1EGX5gVZ3BW4TonqJhLKo9uq/xNLUj6s37D/I6sITfv842qZF78aDGst9jD1BFpV3zh
         l94A==
X-Gm-Message-State: APjAAAWKnjqs5gLCvs3pYAdHfrNPdzaFQQxcoOraf4M+eqBW+4kCJNQF
        B8eFF/4qp0ljjwDV30ov6o+G67untCIJSTf8Kn4WkMZEhu9SjRpKVrKQkg4YDDzN36MQH/josza
        +hgwzSxMyHzX8ZEsNuV4PxWilkUo=
X-Received: by 2002:adf:fe12:: with SMTP id n18mr46827715wrr.105.1566477875055;
        Thu, 22 Aug 2019 05:44:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyf9SDp4EpHFtl9ZW0l3wuQ/BkjySGxh8byn8eLTL0sVJc2I5FIFRFvkOoGtPtn8scjOUB6eg==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr46827682wrr.105.1566477874761;
        Thu, 22 Aug 2019 05:44:34 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id g14sm50030392wrb.38.2019.08.22.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 05:44:33 -0700 (PDT)
Date:   Thu, 22 Aug 2019 14:44:31 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: remove empty flag in mt76_txq_schedule_list
Message-ID: <20190822124431.GA30214@localhost.localdomain>
References: <fb24ac317768ec71d16354ef6cd2a9c10931c75d.1566466668.git.lorenzo@kernel.org>
 <20190822103629.GA2368@redhat.com>
 <20190822115052.GC3350@localhost.localdomain>
 <20190822123757.GA28300@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20190822123757.GA28300@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Aug 22, 2019 at 01:50:52PM +0200, Lorenzo Bianconi wrote:
> > > On Thu, Aug 22, 2019 at 11:49:10AM +0200, Lorenzo Bianconi wrote:
> > > > Remove empty flag in mt76_txq_schedule_list and mt76_txq_send_burst
> > > > since we just need retry_q length to notify mac80211 to reschedule =
the
> > > > current tx queue
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/net/wireless/mediatek/mt76/tx.c | 23 +++++++--------------=
--
> > > >  1 file changed, 7 insertions(+), 16 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/=
wireless/mediatek/mt76/tx.c
> > > > index d7982aa83c11..51d69329ed06 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > > > @@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
> > > > =20
> > > >  static int
> > > >  mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
> > > > -		    struct mt76_txq *mtxq, bool *empty)
> > > > +		    struct mt76_txq *mtxq)
> > > >  {
> > > >  	struct ieee80211_txq *txq =3D mtxq_to_txq(mtxq);
> > > >  	enum mt76_txq_id qid =3D mt76_txq_get_qid(txq);
> > > > @@ -392,16 +392,12 @@ mt76_txq_send_burst(struct mt76_dev *dev, str=
uct mt76_sw_queue *sq,
> > > >  	bool probe;
> > > >  	int idx;
> > > > =20
> > > > -	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags)) {
> > > > -		*empty =3D true;
> > > > +	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags))
> > > >  		return 0;
> > >=20
> > > This changes behaviour for station in PS state. If retry_q is not
> > > empty, now we will be rescheduling tx queue for STA in PS mode.
> > > Not sure if this is problem or not, though.
> >=20
> > good point..looking at the code it seems not a issue since we will not =
actually
> > tx frames for PS stations. What do you think?
>=20
> I do not see how changing this could possibly break things, but it=20
> was explicitly added by below commit, with changelog sugesting it is
> needed:
>=20
> commit d225581df3147060bc99e931b11f7cf2dcb1b2ca
> Author: Felix Fietkau <nbd@nbd.name>
> Date:   Mon Jan 21 17:33:38 2019 +0100
>=20
>     mt76: avoid scheduling tx queues for powersave stations
>    =20
>     In case a tx queue wake call arrives after a client has transitioned =
to
>     powersave, make sure that the queue is not kept active until the clie=
nt
>     has left powersave mode
>=20
> Stanislaw

This is exactly what I am saying, we need the 'if block' in mt76_txq_send_b=
urst
in order to avoid scheduling tx queue for station in powersave but the empty
flag seems not necessary.

Regards,
Lorenzo

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXV6OLAAKCRA6cBh0uS2t
rBU7AP9kRLC912Sar+8cIVVd/j5xiLRE3ajEh/pKDTXnLcyDtQEAh+6M7e2DHiPz
A5W9FwVsBzK/mNP1i4pWuyjSpMb31AM=
=/wlK
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
