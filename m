Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A887D17D345
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 11:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCHKp1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 06:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHKp1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 06:45:27 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B5720828;
        Sun,  8 Mar 2020 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583664326;
        bh=WGdDIBGuU3N8rWh1UPzFFG/pix8qDgCrcgHS/kJQE8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOJEH2mWFguJ8FkrUOvLs0oyla2C4PN1Dv+nQ7OA/sETftp748LDoO93WC6rYkQNU
         v6djolIeQDvrrkSFXEuEgRmkaalmCFEAa5tWiGM+woZUWRfpPr3qi9iiXVVZsWb9fj
         XlhfChC1SKfxzShGaDEI64qeaZ5llTZ93VDnIbTQ=
Date:   Sun, 8 Mar 2020 11:45:25 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: Re: [PATCH 0/6] mt7663u preparation series
Message-ID: <20200308104525.GB1579745@localhost.localdomain>
References: <cover.1582893136.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <cover.1582893136.git.lorenzo@kernel.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is the first series to rework mt7615 code for mt7663u
> driver integration.
> This series is based on "Introduce mt7663e support to mt7615 driver"
> https://patchwork.kernel.org/cover/11395095/

Please drop this series, I will post an updated version soon.

Regards,
Lorenzo

>=20
> Lorenzo Bianconi (6):
>   mt76: mt7615: introduce mt7663u support to mt7615_write_txwi
>   mt76: mt7615: introduce mt7615_mcu_fill_msg
>   mt76: mt7615: introduce mt7615_mcu_wait_response
>   mt76: mt7615: cleanup fw queue just for mmio devices
>   mt76: mt7615: introduce mt7615_init_device routine
>   mt76: mt7615: move mt7615_mac_wtbl_addr in mac.h
>=20
>  .../net/wireless/mediatek/mt76/mt7615/init.c  | 27 ++++----
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 17 +++--
>  .../net/wireless/mediatek/mt76/mt7615/mac.h   |  6 ++
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 62 ++++++++++++-------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +
>  5 files changed, 72 insertions(+), 43 deletions(-)
>=20
> --=20
> 2.24.1
>=20

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmTMwAAKCRA6cBh0uS2t
rDAcAQDXn6AlpQBPoMbj+kZvXu42yuoDVY9rXTeuMR8MYNpokAEAlX5FrJBj+wHm
8JVq+s4qiPVy2WtJxowivr/OAGF1rgM=
=2/IM
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
