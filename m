Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9E7BCA2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGaJJd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 05:09:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43717 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGaJJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 05:09:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so68767698wru.10
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2019 02:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YM+CIM7uGp1stO08UEaOKbKjqzqdE3xsnpc8PsiREjI=;
        b=mdb1JD7Sz7wZSwt6xJONeKp5rK5lqOg6FXVtdTlYBz7Ey85lJM/MP/Xl3wztGoX3C8
         IK2dvm1iupY3rDjOyLQUv3hUitiSP/u7B5zZrYWi1AH0DSXcJ1xK3UJxCuIdcRxdb3wB
         MLMVXHvKahrGLCGh4F2avcYlfLBjxb6HDbyMZ6fJHmmR5TUez4V0V6e1HgwbGJ7AuK7W
         6mSHiO1uHucUmrouG/JGAgS0adcL6rVe2LPU8ngMpQ1Irxfw3UCVcXQFQIWGTY1gWDZM
         hQyf/Bv04GyGqk6TyMDA6n2eX8R9DpR9bEHlvSu5GqbN87mfvpgdA6mGLdXmnVQepj/5
         Uw/A==
X-Gm-Message-State: APjAAAXqgXqsxgttaxmMxa+UEEVqjHjL6j0/zjPZlTRaPGLL+fMufxfV
        pwcgQ5wzU5MLghUDKmpuTvfY1A==
X-Google-Smtp-Source: APXvYqy+kmvCib9oA+2nf5zR1qRW9SnmvF5ooLSTBDUxmijbg0zDdLUqPT5sb6W8MMBUDyOy66WYiQ==
X-Received: by 2002:adf:f883:: with SMTP id u3mr132269567wrp.0.1564564170816;
        Wed, 31 Jul 2019 02:09:30 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id d10sm78985417wro.18.2019.07.31.02.09.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 02:09:30 -0700 (PDT)
Date:   Wed, 31 Jul 2019 11:09:27 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190731090927.GA3665@localhost.localdomain>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
 <20190730145531.GA3813@localhost.localdomain>
 <20190731081957.GA4096@redhat.com>
 <20190731085147.GB4096@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190731085147.GB4096@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jul 31, 2019 at 10:19:58AM +0200, Stanislaw Gruszka wrote:
> > On Tue, Jul 30, 2019 at 04:55:31PM +0200, Lorenzo Bianconi wrote:
> > > > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c =
b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > index 467b28379870..622251faa415 100644
> > > > > > --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > > > @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_stru=
ct *napi, int budget)
> > > > > >  					       mt76.tx_napi);
> > > > > >  	int i;
> > > > > > =20
> > > > > > -	mt76x02_mac_poll_tx_status(dev, false);
> > > > > > +	mt76x02_mac_poll_tx_status(dev, true);
> > > > >=20
> > > > > I am not sure if we really need mt76x02_mac_poll_tx_status() here=
 since we run
> > > > > it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). Anyw=
ay the only
> > > > > difference doing so is we do not run mt76x02_send_tx_status().
> > > >=20
> > > > I thought this is the problem, but it was my mistake during testing.
> > > > I tested the above change together with mt76_txq_schedule(dev, txq-=
>ac)
> > > > change and get wrong impression it fixes the issue. But above change
> > > > alone does not help.
> > > >=20
> > > > I tried to add some locking to avoid parallel execution of mt76x02_=
poll_tx()
> > > > and mt76x02_tx_tasklet(), but it didn't help either. So far only pa=
tch
> > > > originally posted here make the problem gone.
> > >=20
> > > so, in order to be on the same page, if you comment out mt76x02_mac_p=
oll_tx_status()
> > > in mt76x02_poll_tx() the issue will still occur. The only to 'fix' it=
 is to run
> > > mt76_txq_schedule_all() in mt76x02_poll_tx(), right?
> >=20
> > Yes.
>=20
> Err, no, I should read more cerfully. It is partiall revert of=20
> 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet") :=20
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wirele=
ss/mediatek/mt76/tx.c
> index 5397827668b9..fefe0ee52584 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -598,7 +598,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, stru=
ct ieee80211_txq *txq)
>         if (!test_bit(MT76_STATE_RUNNING, &dev->state))
>                 return;
> =20
> -       tasklet_schedule(&dev->tx_tasklet);
> +       mt76_txq_schedule(dev, txq->ac);
>  }
>  EXPORT_SYMBOL_GPL(mt76_wake_tx_queue);

reviewing the code I think:

- we should not run mt76u_tx_tasklet() from mt76_wake_tx_queue() since we do
  not have tx_napi for usb and it will unnecessary go through tx queue chec=
ks.
  We should probably do in mt76_wake_tx_queue() something like:

  if (is_mmio())
	  tasklet_schedule(&dev->tx_tasklet);
  else
	  mt76_txq_schedule(dev, txq->ac);

  Another solution would be add a status_tasklet that just goes through the=
 tx
  queues receiving the usb tx completion and it schedules the tx_tasklet
  What do you think?

- I guess it does not fix the 76x0e issue but we should just schedule tx qu=
eues in
  mt76x02_tx_tasklet() (like it is done for mt7603 and mt7615) and move sta=
tus
  processing in mt76x02_poll_tx()

Regards,
Lorenzo

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXUFaxAAKCRA6cBh0uS2t
rNLYAP9OoaaXQgkBSpI62pORGz3pQXEfjcsl62jkamhrgxi+7gD/b3CTaUBf5mxr
YryJphtOYP6IYtFfQf54/Gmx2V7WoQw=
=nCX3
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
