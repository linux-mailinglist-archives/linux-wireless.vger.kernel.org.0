Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727341BA43
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfEMPlt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 11:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731426AbfEMPls (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 11:41:48 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850BF21473;
        Mon, 13 May 2019 15:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557762107;
        bh=TJyvFdiqmpWZeE8W+pdYHvE96zJWMqfvG934q1Ocfzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/XyLfmLnOAZfRBj7Aw3844x/9L8Uu4mlB+wki66t875kCbzaaj9vCFlpH3qWyxca
         EsGU+/yCb0/yFiCj0yiFDlBHGnmjzlJMmKsamS2p7j3FWR46lXS4SvA/FxMRqXh8R2
         lQCLhbcnnBOa8IndjKpObUZV+8e7cCYhCN9SEiKM=
Date:   Mon, 13 May 2019 17:41:37 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190513154135.GA13245@localhost.localdomain>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <87sgtiil7n.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <87sgtiil7n.fsf@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Introduce a knob in mt7603 debugfs in order to enable/disable
> >> > edcca processing
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>=20
> >> It's good to explain what edcca does and how the file is used supposed
> >> to be used. In other words, have a small introduction for the user.
> >
> > Hi Kalle,
> >
> > edcca is used for adjusting energy detect based on CCA thresholds.
> > The code was already there so I just reported the acronym.
>=20
> A lot of people read commit logs but not everyone (myself included) are
> familiar with mt76 internals so please try to explain the acronyms and
> the background of the patch. Also you should explain in the commit log
> _why_ you are adding the debugfs file, how it helps the user and how to
> use it.

sorry for not been so clear.
ED/CCA is used to control tx power according to the CCA MIB counters (e.g d=
o not
transmit if the channel busy time is higher than 90% for given amount of ti=
me
in a row).
As already done in commit 643749d4a82b ("mt76: mt76x02: disable ED/CCA by d=
efault"),
this patch adds the possibility to enable/disable the processing according =
to an
entry in the debugfs. The reason behind this patch is ED/CCA caused
instability in the past so it could be useful to disable it.

Regards,
Lorenzo

>=20
> --=20
> Kalle Valo

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNmQLAAKCRA6cBh0uS2t
rFzHAQDj6q1S9QhVujEEJ8DdTi99E6p2ffIM7bjOtBUgNdmWhQEA2WRinCSqVqnp
vqucYsr0Vtfgiipg6+PugcHYpGxQFwY=
=qII8
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
