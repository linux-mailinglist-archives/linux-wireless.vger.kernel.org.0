Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9017AB7B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfG3Ozh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 10:55:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54788 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfG3Ozg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 10:55:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so57445891wme.4
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 07:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1sJDXTmV+C/pQn3zEwd5+K3+3fFwlIHbmMaXyLLEoU=;
        b=YHP6SRBNF05iFW+SQn4DdFGXOpCxskXO4qHuhs7kB3HaKBg/3Gk5f7U/WWH7S24mGy
         Izkx6A+7JrRFPWcpwASV9jHwlWoPLjGiE5O4pWZfR9JxCYwhvJ8egBc3k0XOX8YWcMda
         sh/U49A97aZCfykZuvCfOGf8podyU3hRt7vuv8UTe6bjKsDRzB3/kFwwwRvC9JZzg1C3
         AnzfLcW9e9hlF5ZD7koKNbXkRUI0scDLUYl+yxOuv4XCl6HHYtcx8PomncN32Axm8YgM
         anGkwaxxxnrd7SdEArzGNpPy8ub8AM9jFUwJ9bOUKRtIj8Unxkf/rQY0szFY0EDaP+x5
         OrEQ==
X-Gm-Message-State: APjAAAUPob4RYAnp+EZrahZHvgoth8dHEcGzp0+p9dsbZH2iKo0tOkZp
        IGlXQ81i0RqPQ8VOhlqIItLX+Q==
X-Google-Smtp-Source: APXvYqw03pRaxRY8nMym1Nhe9des4c12IhjLogh1uS1mR3UOOfNCSBgPUV+Rn9EQiXdzWbVvTXkJ7A==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr20908028wmf.54.1564498534783;
        Tue, 30 Jul 2019 07:55:34 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id c30sm122953916wrb.15.2019.07.30.07.55.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 07:55:33 -0700 (PDT)
Date:   Tue, 30 Jul 2019 16:55:31 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190730145531.GA3813@localhost.localdomain>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20190730135450.GA2361@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jul 29, 2019 at 04:02:41PM +0200, Lorenzo Bianconi wrote:
> > > On Fri, Jul 26, 2019 at 02:10:56PM +0200, Stanislaw Gruszka wrote:
> > > > Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> > > > I can observe firmware hangs on MT7630E on station mode: tx stop
> > > > functioning after minor activity (rx keep working) and on module
> > > > unload device fail to stop with messages:
> > > >=20
> > > > [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> > > > [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
> > > >=20
> > > > Loading module again results in failure to associate with AP.
> > > > Only machine power off / power on cycle can make device work again.
> > > >=20
> > > > I have no idea why the commit caused F/W hangs. Most likely some pr=
oper
> > > > fix is needed of changing registers programming (or assuring proper=
 order
> > > > of actions), but so far I can not came up with any better fix than
> > > > a partial revert of 41634aa8d6db.
> > >=20
> > > The difference is that with 41634aa8d6db we can run mt76x02_poll_tx()
> > > and mt76x02_tx_tasklet() in parallel on 2 different CPUs. Without
> > > the commit, since tasklet is not scheduled from mt76_wake_tx_queue(),
> > > it does not happen.
> > >=20
> > > I'm not quite sure why, but MT7630E does not like when we poll tx sta=
tus
> > > on 2 cpus at once. Change like below:
> >=20
> > Hi Stanislaw,
>=20
> Hi
>=20
> > have you tried to look at the commit: 6fe533378795f87
> > ("mt76: mt76x02: remove irqsave/restore in locking for tx status fifo")?
> > Could it be a race between a registermap update and a stats load? (we a=
re using a
> > different lock now)
>=20
> This commit seems to be fine, reverting it did not solve the issue.

ack

>=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/driv=
ers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > index 467b28379870..622251faa415 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_struct *na=
pi, int budget)
> > >  					       mt76.tx_napi);
> > >  	int i;
> > > =20
> > > -	mt76x02_mac_poll_tx_status(dev, false);
> > > +	mt76x02_mac_poll_tx_status(dev, true);
> >=20
> > I am not sure if we really need mt76x02_mac_poll_tx_status() here since=
 we run
> > it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). Anyway the=
 only
> > difference doing so is we do not run mt76x02_send_tx_status().
>=20
> I thought this is the problem, but it was my mistake during testing.
> I tested the above change together with mt76_txq_schedule(dev, txq->ac)
> change and get wrong impression it fixes the issue. But above change
> alone does not help.
>=20
> I tried to add some locking to avoid parallel execution of mt76x02_poll_t=
x()
> and mt76x02_tx_tasklet(), but it didn't help either. So far only patch
> originally posted here make the problem gone.

so, in order to be on the same page, if you comment out mt76x02_mac_poll_tx=
_status()
in mt76x02_poll_tx() the issue will still occur. The only to 'fix' it is to=
 run
mt76_txq_schedule_all() in mt76x02_poll_tx(), right?

Lorenzo

>=20
> Stanislaw
>=20

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXUBaYAAKCRA6cBh0uS2t
rO2KAQCDocEQHgGZvT9V51w7ebBJQOHcjlj41h5EoRnSVZCtTQD9E3mZAC1jbXVJ
62flReqCqNuIptKMp+mq3MsFwbV2CgA=
=ARBa
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
