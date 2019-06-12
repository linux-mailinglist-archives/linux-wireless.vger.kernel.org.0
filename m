Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0A42909
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 16:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439788AbfFLO1r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 10:27:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55944 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439772AbfFLO1r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so6788084wmj.5
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 07:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d8gfMoCdaL0F8v742YQvQN66e6m2Zpd9bYlkTemgt6o=;
        b=m+0ekzLKrGf+5pxthWReMbmIbwM5KUdVBCSDXdZpp9VW/9P/49jN5+OKb7dcBue+k1
         GBeb4y3ZvluWsHRvnDeRKiJ0DqfJC3SpiJ4PDZsZ/4CUYb7mkX6+lehTbILdhT+hf7K9
         hHZGrR2eALUvbuPtsmKsueJYM1Er08vs78gNOe0YtQPwfeAtcDHbBtpZT4DpVzbS0ttX
         MX5A9vqshnYQGTYiV9gWoWFBfg/Jk1ScKWrjStBdiFeKPTv9CKP5Sw1UZBqLytEEi7Er
         pVsr00ohpvpdzmlGr6FD8Ed6/77MztXtrpvFttWMVKkETAslFdAXdkyXIb7yLIUdFUus
         7WJA==
X-Gm-Message-State: APjAAAUBsCyTvWLyJb9riBck4HRJIwmXCoZ1YgeD6qbc1eu+L4JoY09t
        nYh/1KGatr7+vjiImYbClCCRww==
X-Google-Smtp-Source: APXvYqwinxBY/FOqpwfWKEqLjLmLIHZxjGxDYzfh9yE2AGAghleZouF/fR9+uW1/ghsdxrq9X6aw2g==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr21397392wmi.144.1560349665259;
        Wed, 12 Jun 2019 07:27:45 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id a2sm251928wmj.9.2019.06.12.07.27.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:27:44 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:27:42 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612142741.GA7016@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
 <20190612125905.GB2600@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20190612125905.GB2600@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jun 12, 2019 at 02:28:48PM +0200, Lorenzo Bianconi wrote:

[...]

> >=20
> > using sg buffers we can support bigger rx AMSDU size in the future with=
out using
> > huge buffers (e.g. we can try to use IEEE80211_MAX_MPDU_LEN_HT_7935 with
> > mt76x2u)
>=20
> I think it would be simpler just to allocate 2 pages for 7935B .
>=20

We should avoid increasing buffer size to more than PAGE_SIZE for
performance reasons. As suggested by Felix what about of setting buf_size to
PAGE_SIZE for both sg and non-sg cases and for sg setting usb data size to

SKB_WITH_OVERHEAD(q->buf_size) & (usb_endpoint_maxp() - 1);

Regards,
Lorenzo

> Stanislaw=20

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQEL2gAKCRA6cBh0uS2t
rKlXAP0eY6stl9ffOWcHHio+rCSut6qlxjbWpQNgaow0Nrdf4AD/aUK/8nfaCr1j
w/Qj3lElof3FjIeNbkbl2Po9bgM13Aw=
=uzuA
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
