Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F65234837C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 22:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhCXVRI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 17:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237868AbhCXVRG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 17:17:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3812A61A09;
        Wed, 24 Mar 2021 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616620625;
        bh=JhO04tpUAm8DFbhtbi3Ovib9GLxsW0SZeQI/BlnBX4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHQ0+wl4lctTQkq/OkZyk9eLY7WjGxWbp8jsY7CI4IiIbV03H2OUhao5ah5wC1evM
         jWH+ouWgsiMERCse5ZtUx3sGdyjVxN/MRwxlr3GU7Cr2ekZOnZJIWefp+5hFcEZJyM
         2FMzIPZIiEhYBKyPJvLNn/j0t4PV0a04AhORIAij9hPklkGwimYHtOvVHnvQ4/Ohm/
         9b5xklTxiJXj1wCqF/PtjdXz2AvAo34hmzQne92st9Y1m/ci2QJNaappMhykYXTLMn
         PCVGu36miaKWBQRlZWIWj1bsyZl7kXFMSL74J8Z8MjZ3YM5e255qnZhDXu5jbBR4F2
         V3b/CR2F5ReVg==
Date:   Wed, 24 Mar 2021 22:17:00 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org,
        devicetree@vger.kernel.org, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings:net:wireless:ieee80211: txt to yaml
 conversion
Message-ID: <YFusTJwU2OS+H+RB@lore-desk>
References: <cover.1615752835.git.lorenzo@kernel.org>
 <3dca0518c14e3a8e563933c903de0d62429a3667.1615752835.git.lorenzo@kernel.org>
 <dbde688c9525fa2b9c1386fc95828b1851531f13.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3LlWVdCVevEXBkhF"
Content-Disposition: inline
In-Reply-To: <dbde688c9525fa2b9c1386fc95828b1851531f13.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--3LlWVdCVevEXBkhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 2021-03-14 at 21:21 +0100, Lorenzo Bianconi wrote:
> >=20
> > +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/wireless/ieee80211.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common IEEE 802.11 Binding
> > +
> > +maintainers:
> > +  - Johannes Berg <johannes@sipsolutions.net>
>=20
> Heh, now I realize why I got CC'ed on these patches.
>=20
> I'm not sure that's really all that appropriate? I may be the wireless
> stack maintainer, but I really don't know much about DT, and so I'm not
> convinced that this entry helps anyone...

ack, I will add myself as maintainer (but I am not an expert as well :))

Regards,
Lorenzo

>=20
> johannes
>=20

--3LlWVdCVevEXBkhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYFusSgAKCRA6cBh0uS2t
rOksAQC/dR9t9aUIB0pBed+D1EvUKOdUKQns3KCWSBRzQP2piQEA3vnNbDI9hdle
6b3+Do2fDHhMY3APKlZSPYHdMXgIRgQ=
=Ko7x
-----END PGP SIGNATURE-----

--3LlWVdCVevEXBkhF--
