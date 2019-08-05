Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3518681822
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfHEL10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 07:27:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53504 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEL1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 07:27:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so74384868wmj.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2019 04:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g9ICvr26mbLAHd/x9P0vgbjMHu74Y6hGM54l8mnbZLo=;
        b=dpDPkwGXeU52ufohsUGt0pB611xAfbLv4pQsp5n3CfKblDSw71uyKUzmUedH6W2bTX
         vAS/aL+aZu9Rzxjg5gfb5iNoVGOuwFiP2gXynDSh8kI8TrD5cP7COmbIz24xHeuMbZoN
         LpSNZxRfaZJFco4+cA2Bd7WNDtru8fCEIPC1M5UKr/f5T4rFEiw7oU0uLM9dBpeKrShG
         9GsFPi8Ia/8uH4gutBn8czVjyH3XcZCpvnC0a/3FCwI1YZDUt9/kmxoqK742+2WA7Ec9
         aojyS4pdydFi+x6diTaGPB7I8GT+ZcnFRDXMc071W4o/FkrT5ttrcjNgMAHqBOe15Ir0
         rn4w==
X-Gm-Message-State: APjAAAWkM9qDb0hZ0OqqIjJMwpDoEQBk0Yh3BsNVhN4o46wifdvO8zZj
        S/5RXMqSl0nY+p1QAzv6Lu2RcQ==
X-Google-Smtp-Source: APXvYqy8xsAxJz/aA9s2E3kbSFL+MNhGpwEDcL3hz4OdZyTzVdRPH0YyhU2Ryl57wRXHYpLXj4lC2Q==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr2842408wmk.14.1565004443354;
        Mon, 05 Aug 2019 04:27:23 -0700 (PDT)
Received: from localhost.localdomain ([151.66.59.187])
        by smtp.gmail.com with ESMTPSA id x18sm76155852wmi.12.2019.08.05.04.27.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 04:27:22 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:27:19 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190805112719.GA12280@localhost.localdomain>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
 <20190730145531.GA3813@localhost.localdomain>
 <20190731081957.GA4096@redhat.com>
 <20190731085147.GB4096@redhat.com>
 <20190731090927.GA3665@localhost.localdomain>
 <20190805100110.GA17889@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20190805100110.GA17889@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jul 31, 2019 at 11:09:27AM +0200, Lorenzo Bianconi wrote:
> > > On Wed, Jul 31, 2019 at 10:19:58AM +0200, Stanislaw Gruszka wrote:
> > > > On Tue, Jul 30, 2019 at 04:55:31PM +0200, Lorenzo Bianconi wrote:
> > > > > > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmi=
o.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > > > index 467b28379870..622251faa415 100644
> > > > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > > > @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_=
struct *napi, int budget)
> > > > > > > >  					       mt76.tx_napi);
> > > > > > > >  	int i;
> > > > > > > > =20
> > > > > > > > -	mt76x02_mac_poll_tx_status(dev, false);
> > > > > > > > +	mt76x02_mac_poll_tx_status(dev, true);
> > > > > > >=20
> > > > > > > I am not sure if we really need mt76x02_mac_poll_tx_status() =
here since we run
> > > > > > > it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). =
Anyway the only
> > > > > > > difference doing so is we do not run mt76x02_send_tx_status().
> > > > > >=20
> > > > > > I thought this is the problem, but it was my mistake during tes=
ting.
> > > > > > I tested the above change together with mt76_txq_schedule(dev, =
txq->ac)
> > > > > > change and get wrong impression it fixes the issue. But above c=
hange
> > > > > > alone does not help.
> > > > > >=20
> > > > > > I tried to add some locking to avoid parallel execution of mt76=
x02_poll_tx()
> > > > > > and mt76x02_tx_tasklet(), but it didn't help either. So far onl=
y patch
> > > > > > originally posted here make the problem gone.
> > > > >=20
> > > > > so, in order to be on the same page, if you comment out mt76x02_m=
ac_poll_tx_status()
> > > > > in mt76x02_poll_tx() the issue will still occur. The only to 'fix=
' it is to run
> > > > > mt76_txq_schedule_all() in mt76x02_poll_tx(), right?
> > > >=20
> > > > Yes.
> > >=20
> > > Err, no, I should read more cerfully. It is partiall revert of=20
> > > 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet") :=20
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wi=
reless/mediatek/mt76/tx.c
> > > index 5397827668b9..fefe0ee52584 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > > @@ -598,7 +598,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, =
struct ieee80211_txq *txq)
> > >         if (!test_bit(MT76_STATE_RUNNING, &dev->state))
> > >                 return;
> > > =20
> > > -       tasklet_schedule(&dev->tx_tasklet);
> > > +       mt76_txq_schedule(dev, txq->ac);
> > >  }
> > >  EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);
> >=20
> > reviewing the code I think:
> >=20
> > - we should not run mt76u_tx_tasklet() from mt76_wake_tx_queue() since =
we do
> >   not have tx_napi for usb and it will unnecessary go through tx queue =
checks.
> >   We should probably do in mt76_wake_tx_queue() something like:
> >=20
> >   if (is_mmio())
>=20
> Adding '&& !is_mt7630()' will solve the problem for MT7630E as well ...
>=20
> > 	  tasklet_schedule(&dev->tx_tasklet);
> >   else
> > 	  mt76_txq_schedule(dev, txq->ac);
> >=20
> >   Another solution would be add a status_tasklet that just goes through=
 the tx
> >   queues receiving the usb tx completion and it schedules the tx_tasklet
> >   What do you think?
> >=20
> > - I guess it does not fix the 76x0e issue but we should just schedule t=
x queues in
> >   mt76x02_tx_tasklet() (like it is done for mt7603 and mt7615) and move=
 status
> >   processing in mt76x02_poll_tx()
>=20
> ... but I think we have bug when do mt76_txq_schedule_all() in
> tx_tasklet, because we can schedule on queues that are stoped.
> So reverting 41634aa8d6db and then optimize by removing tx_tasklet
> for mmio and remove not needed mt76_txq_schedule_all() calls looks
> more reasoneble to me.

schedule a stopped queue seems not harmful at a first glance since we do not
copy pending skbs if we have not enough room in the dma ring. Maybe we can =
be
more conservative doing something like:

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireles=
s/mediatek/mt76/dma.c
index d8f61e540bfd..c6482155e5e4 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -346,6 +346,11 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_=
txq_id qid,
 		goto unmap;
=20
 	if (q->queued + (tx_info.nbuf + 1) / 2 >=3D q->ndesc - 1) {
+		if (!q->stopped) {
+			ieee80211_stop_queue(dev->hw,
+					     skb_get_queue_mapping(skb));
+			q->stopped =3D true;
+		}
 		ret =3D -ENOMEM;
 		goto unmap;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless=
/mediatek/mt76/tx.c
index 5397827668b9..bd2d34c4f326 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -495,6 +495,9 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_=
txq_id qid)
 	while (1) {
 		bool empty =3D false;
=20
+		if (hwq->stopped)
+			break;
+
 		if (sq->swq_queued >=3D 4)
 			break;

Does it fix the issue you are facing?

Regards,
Lorenzo

> =20
> Stanislaw=20

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXUgSlQAKCRA6cBh0uS2t
rAqSAQD1/WsaGVtvzYJA2YUyx1Z5C+RDknYJ4MfEk+uRsG235QEAr5lHPMcKFYJk
GelEnjBAlRIAq/ynz20lXyuQaEPkIg8=
=741R
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
