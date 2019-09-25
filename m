Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F073BE159
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439544AbfIYPaP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 11:30:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfIYPaP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 11:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86EB3ACA5;
        Wed, 25 Sep 2019 15:30:12 +0000 (UTC)
Message-ID: <43fb5fe1de317d65a4edf592f88ea150c6e3b8cc.camel@suse.de>
Subject: Re: [PATCH 00/11] of: Fix DMA configuration for non-DT masters
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        etnaviv@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, xen-devel@lists.xenproject.org,
        Dan Williams <dan.j.williams@intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Date:   Wed, 25 Sep 2019 17:30:10 +0200
In-Reply-To: <e404c65b-5a66-6f91-5b38-8bf89a7697b2@arm.com>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
         <CAL_Jsq+v+svTyna7UzQdRVqfNc5Z_bgWzxNRXv7-Wqv3NwDu2g@mail.gmail.com>
         <d1a31a2ec8eb2f226b1fb41f6c24ffb47c3bf7c7.camel@suse.de>
         <e404c65b-5a66-6f91-5b38-8bf89a7697b2@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Jc6/4bVbm9VDLL08SmH3"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-Jc6/4bVbm9VDLL08SmH3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-09-25 at 16:09 +0100, Robin Murphy wrote:
> On 25/09/2019 15:52, Nicolas Saenz Julienne wrote:
> > On Tue, 2019-09-24 at 16:59 -0500, Rob Herring wrote:
> > > On Tue, Sep 24, 2019 at 1:12 PM Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de> wrote:
> > > > Hi All,
> > > > this series tries to address one of the issues blocking us from
> > > > upstreaming Broadcom's STB PCIe controller[1]. Namely, the fact tha=
t
> > > > devices not represented in DT which sit behind a PCI bus fail to ge=
t the
> > > > bus' DMA addressing constraints.
> > > >=20
> > > > This is due to the fact that of_dma_configure() assumes it's receiv=
ing a
> > > > DT node representing the device being configured, as opposed to the=
 PCIe
> > > > bridge node we currently pass. This causes the code to directly jum=
p
> > > > into PCI's parent node when checking for 'dma-ranges' and misses
> > > > whatever was set there.
> > > >=20
> > > > To address this I create a new API in OF - inspired from Robin Murp=
hys
> > > > original proposal[2] - which accepts a bus DT node as it's input in
> > > > order to configure a device's DMA constraints. The changes go deep =
into
> > > > of/address.c's implementation, as a device being having a DT node
> > > > assumption was pretty strong.
> > > >=20
> > > > On top of this work, I also cleaned up of_dma_configure() removing =
its
> > > > redundant arguments and creating an alternative function for the sp=
ecial
> > > > cases
> > > > not applicable to either the above case or the default usage.
> > > >=20
> > > > IMO the resulting functions are more explicit. They will probably
> > > > surface some hacky usages that can be properly fixed as I show with=
 the
> > > > DT fixes on the Layerscape platform.
> > > >=20
> > > > This was also tested on a Raspberry Pi 4 with a custom PCIe driver =
and
> > > > on a Seattle AMD board.
> > >=20
> > > Humm, I've been working on this issue too. Looks similar though yours
> > > has a lot more churn and there's some other bugs I've found.
> >=20
> > That's good news, and yes now that I see it, some stuff on my series is
> > overly
> > complicated. Specially around of_translate_*().
> >=20
> > On top of that, you removed in of_dma_get_range():
> >=20
> > -	/*
> > -	 * At least empty ranges has to be defined for parent node if
> > -	 * DMA is supported
> > -	 */
> > -	if (!ranges)
> > -		break;
> >=20
> > Which I assumed was bound to the standard and makes things easier.
> >=20
> > > Can you test out this branch[1]. I don't have any h/w needing this,
> > > but wrote a unittest and tested with modified QEMU.
> >=20
> > I reviewed everything, I did find a minor issue, see the patch attached=
.
>=20
> WRT that patch, the original intent of "force_dma" was purely to=20
> consider a device DMA-capable regardless of the presence of=20
> "dma-ranges". Expecting of_dma_configure() to do anything for a non-OF=
=20
> device has always been bogus - magic paravirt devices which appear out=
=20
> of nowhere and expect to be treated as genuine DMA masters are a=20
> separate problem that we haven't really approached yet.

I agree it's clearly abusing the function. I have no problem with the behav=
iour
change if it's OK with you.

Robin, have you looked into supporting multiple dma-ranges? It's the next t=
hing
we need for BCM STB's PCIe. I'll have a go at it myself if nothing is in th=
e
works already.

Regards,
Nicolas


--=-Jc6/4bVbm9VDLL08SmH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2LiAIACgkQlfZmHno8
x/7J7Af+NrtcYkM0WphLDC8n2KXI1Rofej10z7b8lAcPZvn586CNcayUtga34+e3
jMIOwHl9qzzFJrgAT9FoyDjkcJ0gfVWKSzQYB798pTOVEND7LdUsHH0ZNqNqf4YM
yRmNNvCpZi+i83aeetAQjPoMUeDjKU0dMCX7oEzfvlrmxi4YRx59jcOfIbaqr2Hg
SGipuOc97V/so7VcwvypG9xeYU/zTeZ0wFoQzT7X4OdEUp4uBAgHoeou4kez1gSy
27EmZX8DU3l7YbWTM5SBP13uDcQ0I2y25cjjy55r4gBm+zQYdGCuh3oHbdOvyws/
xjAYrC9sFk3+VCjuPTn9CTbfyDqZ8A==
=9rW4
-----END PGP SIGNATURE-----

--=-Jc6/4bVbm9VDLL08SmH3--

