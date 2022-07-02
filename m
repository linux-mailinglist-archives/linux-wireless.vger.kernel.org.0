Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315F056410E
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGBPdM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiGBPdM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 11:33:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A265F7
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 08:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FB97B8018A
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 15:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B2AC341C8;
        Sat,  2 Jul 2022 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656775988;
        bh=iAvfsN+YBR+z8SQ4h5GtALiwDDgw9UFzJKT63BH5U8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WabNUw7HgyXuenkECa0M/qTj9bGq0RDbXQZeYAVrBVunESfQGYMV3j3l+V54tCTZX
         m/XdTXPORb68OyiLiuVIQdVExeqjswOh04UJMD19jxSnKfixnS44/LJLoJANIBK9H5
         ipsWVOke/xzrtL/e6jmtDd0BNpD4FKlXZ7FPNYYTIMjLTYSA/H0J8sm+a3DiDbpqzX
         rio/hQh2vjm+BJr1pazm5CEaecAYPDviP6GrNUXd/8O1vMKWLn57xj9O8m3NMaNCZJ
         RWOIfmsX2xQcljYcn/T43cdasDfbg3S4rC9ZeW8MSBZ9nm/f0zLjgcvbtE22meC7SL
         KSOB1r4YUWYdg==
Date:   Sat, 2 Jul 2022 17:33:04 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, evelyn.tsai@mediatek.com,
        sean.wang@mediatek.com, Bo Jiao <bo.jiao@mediatek.com>
Subject: Re: [PATCH 0/5] mt76: add the capability to support more than two
 phys
Message-ID: <YsBlMLr3rMe288tA@lore-desk>
References: <cover.1656624320.git.lorenzo@kernel.org>
 <4b135d37fc8b9a9ee3a8674126c76c1c45b02054.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fRVNAhNphsrrTQ7C"
Content-Disposition: inline
In-Reply-To: <4b135d37fc8b9a9ee3a8674126c76c1c45b02054.camel@mediatek.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--fRVNAhNphsrrTQ7C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2022-06-30 at 23:41 +0200, Lorenzo Bianconi wrote:
> > Introduce the capability to support more than two mt76_phys.
> > This is a preliminary series to add mt7990 support.
> >=20
> > Lorenzo Bianconi (5):
> >   mt76: add phy_idx in mt76_rx_status
> >   mt76: introduce phys array in mt76_dev structure
> >   mt76: add phy_idx to mt76_wcid
> >   mt76: convert MT_TX_HW_QUEUE_EXT_PHY to MT_TX_HW_QUEUE_PHY
> >   mt76: get rid of mt76_wcid_hw routine
> >=20
> >  drivers/net/wireless/mediatek/mt76/dma.c      |  9 ++-
> >  drivers/net/wireless/mediatek/mt76/mac80211.c | 27 ++++----
> >  drivers/net/wireless/mediatek/mt76/mt76.h     | 67 ++++++++++-------
> > --
> >  .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +-
> >  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 44 ++++++------
> >  .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
> >  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 32 +++++----
> >  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
> >  .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 15 +++--
> >  .../wireless/mediatek/mt76/mt76_connac_mac.c  | 12 ++--
> >  .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
> >  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 ++++---
> >  .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +-
> >  .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++----
> >  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
> >  .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +-
> >  drivers/net/wireless/mediatek/mt76/testmode.c |  5 +-
> >  drivers/net/wireless/mediatek/mt76/tx.c       | 48 +++++++------
> >  18 files changed, 174 insertions(+), 157 deletions(-)
>=20
> I think this series should add Bo's SOB as he finished the initial
> work.

sure, I am fine with it.
@Felix: do I need to repost or are you taking care of it?

Regards,
Lorenzo

>=20
> Ryder
>=20

--fRVNAhNphsrrTQ7C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYsBlMAAKCRA6cBh0uS2t
rG3HAP0cuUDPCYxxSKPM4ZGtrRCXJFFAnQIgchbWkHNX9tk6qAD9HHJMqwy3aRUE
RDqLi++7QGb3k9IfIXoyJtDR6zB4FAw=
=D4fq
-----END PGP SIGNATURE-----

--fRVNAhNphsrrTQ7C--
