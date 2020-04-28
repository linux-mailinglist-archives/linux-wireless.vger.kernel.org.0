Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63E1BBF45
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgD1NZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 09:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgD1NZe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 09:25:34 -0400
Received: from localhost.localdomain (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D227206D7;
        Tue, 28 Apr 2020 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588080334;
        bh=0lPhBcb+aD0Kw3SuqJQeVHyaKLJFxq/Jb3qyvIBgodA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QR7WgnnrsxWTGO/yF5ghzpjUauLSJNIVJp/QfHK4MvzgxAeV2Laikz68WJTHQvEqb
         0thJDl5Gb749KuqdKcP8KUnd5O11H7x6hXPo2ay485XHJl32wrLVtQVbwZHGy+Y9ib
         qNS4fugxFaokl8N/w7xfSH1rnVNX12JRYO/0HrxU=
Date:   Tue, 28 Apr 2020 15:25:28 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7663: add the possibility to load firmware v2
Message-ID: <20200428132528.GA7716@localhost.localdomain>
References: <db72b648024aba3243ee3b7deceb548c9bc2bdf1.1587911939.git.lorenzo@kernel.org>
 <87ftcnj2be.fsf@tynnyri.adurom.net>
 <fd49291e-173e-20b0-ee67-c4f519ce8419@nbd.name>
 <87k11zlu0k.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <87k11zlu0k.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Felix Fietkau <nbd@nbd.name> writes:
>=20
> > On 2020-04-28 13:07, Kalle Valo wrote:
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >>> mt7663 firmware v2 is used for embedded devices since it has more com=
pleted
> >>> features in AP mode.
> >>> Add the capability to specify in mt7615 Kconfig which firmware load f=
irst
> >>> (v3 or v2) and fallback to the other one if the selected firmware fai=
ls
> >>> to load
> >>>
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>>  .../net/wireless/mediatek/mt76/mt7615/Kconfig | 13 +++++
> >>>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 50 ++++++++++++++++-=
--
> >>>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++-
> >>>  .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +
> >>>  .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +
> >>>  5 files changed, 65 insertions(+), 8 deletions(-)
> >>>

[...]

>=20
> > If you want to switch without recompiling, you can always just delete
> > the set of firmware files you don't want to use. The driver will fall
> > back to the other type.
>=20
> My problem here is the new Kconfig option and the way I see is that this
> feature doesn't justify the need of a new Kconfig option. A Kconfig
> option shouldn't change the driver behaviour, it should be more about
> enabling and disabling components and other compilation specific
> configuration.
>=20
> What about a module parameter? That would be much better and at least I
> can't think of a technical reason why it wouldn't work.

ack, I will post a v2 adding a kernel parameter and removing the kconfig en=
try

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXqguxQAKCRA6cBh0uS2t
rFbIAP9x3CzYmvVXxk/OEaW+OMnApbkfueCyHyDBaK0FAGDdkwD9GRbdJg8vZl6D
RGRj2Yw7+Z27ynFxFnq/B8ER2IBg+Qg=
=2hlt
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
