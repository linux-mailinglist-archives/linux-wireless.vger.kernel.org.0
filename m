Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3949B78D5B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfG2OCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 10:02:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32780 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfG2OCr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 10:02:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so62097241wru.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 07:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pCeySVcd9irdcsuxwJvRRn19Bi/KYheGgWZi+MxW/qQ=;
        b=nwFeWkJ/fPCG/x8NxWqTxxekGVQXCiioYf7ZZcSa5wE73x6rW/dAwSyDQv9LWPxKP/
         hS1X37VV7LVLs6NChhZFd/mHJ8lzLqZgypUpFc/JGOSXgl3YRBk2tvAWuXlVGRZIT7KB
         rveyJ7oJjli2YpcLThHHTOupVwGS+1Qa3ihlH5VcQtbaeilROMkTuI6ARn9ZjXNnHNwV
         NfAphAkJca8rjre0se0Twas047IuFArUslfbUClDx/i7FmMR1YhukoQbqP5gVbYYu+KO
         9bAXy+d0y7SgKTSKuBUisT+rbhhdQpiOIk3NwDnXjhaUoJCTWbp/VzIXpzRRjSf48RVb
         StKg==
X-Gm-Message-State: APjAAAXUfIso8FSdpuw9+1KCS/Ob2XFVQp3BVCL+HZRy8P78107UKcMD
        3MdCz323TTQoxF2Zk8IZStlApg==
X-Google-Smtp-Source: APXvYqyHByAgKo39HAGbtHxDJUje1yxvr2wrTn93fD3tBwAHHpBy0YNXhwdHZ6XwAQ0ObZdsWNKCZQ==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr30522188wrn.198.1564408964838;
        Mon, 29 Jul 2019 07:02:44 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id x20sm140771044wrg.10.2019.07.29.07.02.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:02:43 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:02:41 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190729140241.GC4030@localhost.localdomain>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20190729125351.GA3086@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jul 26, 2019 at 02:10:56PM +0200, Stanislaw Gruszka wrote:
> > Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> > I can observe firmware hangs on MT7630E on station mode: tx stop
> > functioning after minor activity (rx keep working) and on module
> > unload device fail to stop with messages:
> >=20
> > [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> > [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
> >=20
> > Loading module again results in failure to associate with AP.
> > Only machine power off / power on cycle can make device work again.
> >=20
> > I have no idea why the commit caused F/W hangs. Most likely some proper
> > fix is needed of changing registers programming (or assuring proper ord=
er
> > of actions), but so far I can not came up with any better fix than
> > a partial revert of 41634aa8d6db.
>=20
> The difference is that with 41634aa8d6db we can run mt76x02_poll_tx()
> and mt76x02_tx_tasklet() in parallel on 2 different CPUs. Without
> the commit, since tasklet is not scheduled from mt76_wake_tx_queue(),
> it does not happen.
>=20
> I'm not quite sure why, but MT7630E does not like when we poll tx status
> on 2 cpus at once. Change like below:

Hi Stanislaw,

have you tried to look at the commit: 6fe533378795f87
("mt76: mt76x02: remove irqsave/restore in locking for tx status fifo")?
Could it be a race between a registermap update and a stats load? (we are u=
sing a
different lock now)

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_mmio.c
> index 467b28379870..622251faa415 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, =
int budget)
>  					       mt76.tx_napi);
>  	int i;
> =20
> -	mt76x02_mac_poll_tx_status(dev, false);
> +	mt76x02_mac_poll_tx_status(dev, true);

I am not sure if we really need mt76x02_mac_poll_tx_status() here since we =
run
it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). Anyway the only
difference doing so is we do not run mt76x02_send_tx_status().

Regards,
Lorenzo

> =20
>  	for (i =3D MT_TXQ_MCU; i >=3D 0; i--)
>  		mt76_queue_tx_cleanup(dev, i, false);
>=20
> is sufficient to avoid the hangs.
>=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wire=
less/mediatek/mt76/tx.c
> > index 5397827668b9..fefe0ee52584 100644
> > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > @@ -598,7 +598,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, st=
ruct ieee80211_txq *txq)
> >  	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
> >  		return;
> > =20
> > -	tasklet_schedule(&dev->tx_tasklet);
> > +	mt76_txq_schedule(dev, txq->ac);
>=20
> However I'm not sure if change to tasklet_schedule() is indeed correct,
> since on tasklet we schedule all queues, hence queues that could
> possibly be still blocked? And on mt76_wake_tx_queue() we schedule only
> one queue.
>=20
> Stanislaw

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXT78fgAKCRA6cBh0uS2t
rFc2AP9LE1jf3WlAsOcYg5jJ1Tb7ZAz9858mGF9nLeFEeBNEpgD9Fdwb4l2JA1Tw
nhaNEKVMI8sGax2iNc1Jaz4GtqOjRws=
=FAOY
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
