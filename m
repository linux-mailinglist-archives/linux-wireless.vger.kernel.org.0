Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712D91F2D0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfEOMHz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 08:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbfEOMHy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 08:07:54 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C196206BF;
        Wed, 15 May 2019 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557922072;
        bh=GDcd4I05oU8MRMQ9xdKxRbRq9ks/Azne8/FYte8Jo7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XluY5dnO42Sc5CEQT/7aDx8ni07/rsyVohVM0kiQwEGYEuS9KufTjaB+bqtyF/iAn
         eceQTLvH6gE0vxwSQLLtBMY1XfuKmHBKpqIqdHbAESk3PbqnXQToFH7HatAEvs5NIm
         wzJ1A/Zuhg6Imihk/qcRWxIijEDsgexDBBK9cZjM=
Date:   Wed, 15 May 2019 14:07:42 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515120741.GD30757@localhost.localdomain>
References: <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
 <20190515094354.GA30757@localhost.localdomain>
 <20190515095440.GB3407@redhat.com>
 <20190515100343.GB30757@localhost.localdomain>
 <20190515103309.GA15134@redhat.com>
 <20190515111348.GC30757@localhost.localdomain>
 <20190515114615.GB15134@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20190515114615.GB15134@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, May 15, 2019 at 01:13:49PM +0200, Lorenzo Bianconi wrote:
> > > On Wed, May 15, 2019 at 12:03:44PM +0200, Lorenzo Bianconi wrote:
> > > > > On Wed, May 15, 2019 at 11:43:55AM +0200, Lorenzo Bianconi wrote:
> > > > > > > On Mon, May 13, 2019 at 11:48:37AM +0200, Stanislaw Gruszka w=
rote:
> > > > > > > > On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi =
wrote:
> > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > > > > > >=20
> > > > > > > > > > > Introduce a knob in mt7603 debugfs in order to enable=
/disable
> > > > > > > > > > > edcca processing
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > > >=20
> > > > > > > > > > It's good to explain what edcca does and how the file i=
s used supposed
> > > > > > > > > > to be used. In other words, have a small introduction f=
or the user.
> > > > > > > > >=20
> > > > > > > > > Hi Kalle,
> > > > > > > > >=20
> > > > > > > > > edcca is used for adjusting energy detect based on CCA th=
resholds.
> > > > > > > > > The code was already there so I just reported the acronym.
> > > > > > > >=20
> > > > > > > > What for it is needed ?
> > > > > > >=20
> > > > > > > Care to comment why EDCCA is needed at all ?
> > > > > > >=20
> > > > > > > Taking that debugfs file that enable it is read-only, it look=
s like
> > > > > > > feature that nobody needs nor tests.
> > > > > >=20
> > > > > > already fixed in v2
> > > > > > https://patchwork.kernel.org/patch/10940645/
> > > > >=20
> > > > > I'm aware of this patch and other one for mt76x02. But so far in =
the
> > > > > sources EDCCA is disabled for mt76x02 without possibility to enab=
le it
> > > > > (and this permission file issue was pointed by Kalle during revie=
w, not
> > > > > by someone who want to test EDCCA). So again, what for EDCCA is n=
eeded ?
> > > >=20
> > > > As I have already written in a previous email, ED/CCA is used to co=
ntrol tx power
> > > > according to the CCA MIB counters (e.g do not transmit if the chann=
el busy time
> > > > is higher than 90% for given amount of time in a row). I guess it i=
s required
> > > > by ETSI regulatory.
> > > But what is user case for that, i.e. who need this (it wasn't impleme=
nted in
> > > mt76x2 since you added it on Dec 2018). What will happen if it will b=
e removed?
> > >=20
> > > > Regarding file permission for mt76x02 debugfs edcca node is a typo.
> > > Typo or not, effectively disable the feature and show nobody is
> > > testing it.
> > >=20
> > > The reason I'm asking is that seems EDCCA is the main reason to
> > > implement watchod for mt76x2, it wasn't necessary to have a watchdog
> > > as seems devices did not hung before EDCCA was added.
> >=20
> > IIRC I added the first watchdog implementation to fix tx hangs that occ=
ur
> > under heavy load even using FCC regulatory (so when EDCCA processing is
> > disabled)
>=20
> There was changes in various registers programming introduced by EDCCA
> support, even with EDCCA disabled. It's rally not convenient that
> watchdog and EDCCA are not related, since you added tx hung watchdog
> 2 weeks after adding EDCCA.
>=20
> You can look at this report:
> https://github.com/openwrt/mt76/issues/246
> Before mt76x2e worked without hungs & watchodg. Now, even with EDCCA
> disabled watchdog and HW restarts are required to fix hungs on runtime.

Tx hangs occur in very particular conditions (e.g 200Mbps bidirectional
traffic) and moreover they do not always occur so I am not convinced they
are always EDCCA related and so I am not confident to remove the watchdog

Lorenzo

>=20
> Stanislaw

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNwBBwAKCRA6cBh0uS2t
rF0UAQD1nZ3qXt/eJnZ4bWqby6AwdwGqu3jdWSbbBmQPZsa2UAD7B1uWUapF512H
9wmQyqw9EvL8zSLJKt0SMjFNOPKAbQ0=
=w8iT
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
