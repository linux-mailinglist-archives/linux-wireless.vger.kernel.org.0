Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE81DE14B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgEVHva (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgEVHva (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:51:30 -0400
Received: from localhost (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8381F2072C;
        Fri, 22 May 2020 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590133890;
        bh=kZVVwPNpwgBB2xHIzTu7T93HsBn42X1TjQX+ms5kWtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYeetIZdgh0+MZOsx3dB6D7j28a0sndjuMd/lENS0YVrbPJRlipNxMQVeL9f9PePq
         tHwrhE3+x7a7hUzKRExJfeI6J9gqTCN/zGWRi7CwwFhHOi/eVWBNvWhY+qAOFqeQm5
         XKuxzUYyVfrFOMbw9cflNVdIggfLDIc+aw6sW66g=
Date:   Fri, 22 May 2020 09:51:24 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7915: fix possible NULL pointer dereference in
 mt7915_register_ext_phy
Message-ID: <20200522075124.GB4245@localhost.localdomain>
References: <a03171996da0aaaa0963a4704b6d59be818bd42f.1590132235.git.lorenzo@kernel.org>
 <20200522074522.GB22511@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20200522074522.GB22511@kadam>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On Fri, May 22, 2020 at 09:26:06AM +0200, Lorenzo Bianconi wrote:
> > Fix a NULL pointer dereference in mt7915_register_ext_phy since phy
> > data structure is allocated by mt76_alloc_phy routine
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Thanks!  Could you fix the same the bug in mt7615_register_ext_phy() as
> well?

Hi Dan,

I have already posted the fix here: https://patchwork.kernel.org/patch/1155=
3519/
The patch is already in Felix's tree.

Regards,
Lorenzo

>=20
> regards,
> dan carpenter
>=20

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXseEeAAKCRA6cBh0uS2t
rHCtAP0d3mXoL+KbRp6VdNWIEeL7Z4gyyPrNhsMMycJiaXGoYQEA1Hta7HqjRH8K
WxH5jXbFo31hWiSvEyfC6Ox5Avy2ywg=
=k+tk
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
