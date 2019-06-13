Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9A443AD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbfFMQbN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbfFMI0p (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 04:26:45 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DF420851;
        Thu, 13 Jun 2019 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560414404;
        bh=TyDVCmgc3SYGGIORpTEAsOPhVDoacFF4Wox3U8f5sAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4V+Zg0qL8m43mXTaXndhOJU1uxfbJAjatlz+YLyYjg8ImrA0ClYinyTWhobs6ktM
         HSSCa3BFgA6DYcCTzsgB1gyzQMAvWm+8SJNic6hwLdAHD6oXwib4ig1wBik9NcOilE
         9jj63g602dOPb0aY8149NATi2bHulg+F+o8hxRDQ=
Date:   Thu, 13 Jun 2019 10:26:38 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190613082637.GA18296@localhost.localdomain>
References: <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
 <20190612125905.GB2600@redhat.com>
 <20190612142128.GA20760@redhat.com>
 <20190612144400.GB7016@localhost.localdomain>
 <20190613075108.GA24650@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20190613075108.GA24650@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> I looked at intel wifi drivers and this is handled by amsdu_size module
> parameter, supported values are 4k, 8k and 12k. RX allocation size and
> proper values in vht_cap & ht_cap are set accordingly. Assuming (some)
> mt76 HW and FW can handle bigger AMSDUs I think we should do similar
> thing.
>=20
> Otherwise looks for me, we just waste memory and have not needed code
> for no true reason.=20
>=20
> >   space needed for skb_shared_info is 320B on a x86_64 device
>=20
> Uhh, I haven't expected that sk_shared_info() is that big, so indeed buil=
d_skb
> could not used and 128B copy fallback will be necessary.

Hi Stanislaw,

reviewing the original patch I think we can't trigger any IOMMU bug since t=
he
usb buffer length is actually 2048 and not 2048 + skb_shared_info_size:

in mt76u_fill_rx_sg()
data_size =3D SKB_WITH_OVERHEAD(q->buf_size);

q->buf_size =3D MT_BUF_WITH_OVERHEAD(MT_RX_BUF_SIZE);

where MT_BUF_WITH_OVERHEAD is
((x) + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

anyway we can even set
q->buf_size =3D PAGE_SIZE
data_size =3D rounddown(SKB_WITH_OVERHEAD(q->buf_size), usb_endpoint_maxp())

Regards,
Lorenzo

>=20
>=20
> Stanislaw

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQIIugAKCRA6cBh0uS2t
rH2sAP90gOZWOnR6IKKmB20j1seTa79tBMorqgYyxJNJlIR+nwEA1XzC10Pds4Sc
eo0IpeZfBLgWAVjZeXmo0VLcE/9/UQk=
=oBw3
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
