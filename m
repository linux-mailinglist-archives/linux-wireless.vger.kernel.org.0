Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027943C57A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404509AbfFKH4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 03:56:30 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36842 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403815AbfFKH4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 03:56:30 -0400
Received: by mail-wm1-f54.google.com with SMTP id u8so1748898wmm.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2019 00:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BH0xS2IUPRB4/YXEafxiu4sK2eakrXkI+FZB/yCu8K4=;
        b=AKDgNLbl2ihawVBxkJiutREqruEpJx7P/Y5Bjl08hOMSE1iEhu3aOsesoGQSuP1PtY
         ++bXfcctQwbqSbcRbES4aTEnWMF8yg6rURSYXeC5bC9fMuHMyESIB+UwLrcm5cYoUByv
         ZiniRyW8ic7E4qGSV0S+4O5d878gP66BopTCBislDSwzs46WNaLW0eECZtHdbcuoxTrw
         RZs6p8na1q6SwTnJ0+1EtTfQ5y2TA7xf7sUllbpnhntClBTMYujN6ZJoLNr6AjsxLrp0
         HEqS8q+5810RHtvXOU7ZfgKDiLKDybgaaXrGjaDYZCSVQ7aYqveqepVLmDBwYXmHcjlB
         ZQZw==
X-Gm-Message-State: APjAAAXm2AxaBQlK/en1f3J8UZDTwdVle3vzHBFq+A7HUpO6zAn56zrx
        W+JI50d9rGBgtb2E3aA+Kaq7qA==
X-Google-Smtp-Source: APXvYqwdco/WgidskQsztVsi6z0qHGNqfa0AxAyYFq3K44yXfRhGvM/BadYxiIVdeYNiPvubsq1gZQ==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr16283578wma.41.1560239787607;
        Tue, 11 Jun 2019 00:56:27 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id u13sm15674688wrq.62.2019.06.11.00.56.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 00:56:27 -0700 (PDT)
Date:   Tue, 11 Jun 2019 09:56:24 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: Re: [PATCH 1/2] mt76: mt7615: init per-channel target power
Message-ID: <20190611075623.GA3091@localhost.localdomain>
References: <cover.1560234876.git.lorenzo@kernel.org>
 <ade300b855949dcbe0a278e363415bd56b2e1299.1560234877.git.lorenzo@kernel.org>
 <3556594.76tU91ddA5@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <3556594.76tU91ddA5@bentobox>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tuesday, 11 June 2019 08:38:52 CEST Lorenzo Bianconi wrote:
> > +               switch (n_chains) {
> > +               case 4:
> > +                       target_power +=3D 6;
> > +                       break;
> > +               case 3:
> > +                       target_power +=3D 4;
> > +                       break;
> > +               case 2:
> > +                       target_power +=3D 3;
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
>=20
> Any reason why you use different value for 3 chains than ath9k? Following=
=20
> values are used in ath9k:
>=20
> * 1 chain: 0 dB
> * 2 chains: 3 dB (max combined gain ~3.010299956639812 dB)
> * 3 chains: 5 dB (max combined gain ~4.771212547196624 dB)

Hi Sven,

I just rounded down the values, but we can use 5db (in this case we need to=
 fix
it even in mt76_get_power(), so I will do it in a different patch)

Regards,
Lorenzo

> * 4 chains: not supported (max combined gain 6.020599913279624 dB)
>=20
> Here are the definitions from ath9k (values are saved in .5 dB steps)
>=20
>     drivers/net/wireless/ath/ath9k/eeprom.h:#define POWER_CORRECTION_FOR_=
TWO_CHAIN          6  /* 10*log10(2)*2 */
>     drivers/net/wireless/ath/ath9k/eeprom.h:#define POWER_CORRECTION_FOR_=
THREE_CHAIN        10 /* 10*log10(3)*2 */
>=20
> Kind regards,
> 	Sven



--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXP9epAAKCRA6cBh0uS2t
rDXPAP4pZ7vUcobJhIskAId9K6En7k46IcTRktvEpTxHwI0NOgEAr4sY3igEDBiY
Bbo+CvCvLwA9aQItZ7964BIboDMHTQg=
=kTax
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
