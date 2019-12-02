Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1010E78D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLBJVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 04:21:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbfLBJVO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 04:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575278473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8tHTHI6nrXl7SdC3B6eIMVsqKCmgWklPBfWKnzPFAM=;
        b=INXM8wBFJ5XunO/jEsC16Z5HI3QAmw9Br4vnxONxaUiHL6Nm4+PMAUYRWDThmcISVWgaau
        m7+Mv7yszhzU5ABoerm/gZc7vvshle5Ih35ZMnU6M06HQ6vAC4wO1nM1a0+b5C/WAD40N1
        hTVmmDYXAsPJFIqgvTEN0X0XieM0YTU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-UtCNKLsmP42aQraLXDJTSA-1; Mon, 02 Dec 2019 04:21:10 -0500
X-MC-Unique: UtCNKLsmP42aQraLXDJTSA-1
Received: by mail-wm1-f71.google.com with SMTP id n4so1918408wmd.7
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2019 01:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtF6yYbdKhKrK08AMrpk7b9Ad/8HH+rS+w+yrl5IScI=;
        b=bn0oVHxicHklk3nizZb2lPb3mdx/JTr0xzzaK4MUUG+8gYy1AEfzxYz1Ky85Kq+1Fk
         EEEZ4WBxKmfSODnb+hIflBNudv/WbVnVLVZ859wMWpWbtETwpxl5kIMoUVUU2J4JxM2S
         mnu9pWyfGvPys4lF3Xlr7uWgblXmv7wRlEdh3rLObPpr8hwYNCpp/oclZhlDjP4zS0ux
         3WoMkxxNDc5LSPeaPWIeTSKjCejbKPvYvmhWC4DjVkGrHj3FLIbYXX3XgMGe50wV6R3u
         cgRMwxBxx6SGTQnjmMMOsl9iVs1o4nbhQ6O5dE8azBImxwJ8mBKvqpIw5RDqzDuR68at
         xRsA==
X-Gm-Message-State: APjAAAVIrVe9sasr5Oi04G7dSb6uQW0n3ZNGDQOX+t4o3bySCpwna4sc
        jD3XfdyEuiLehWuPShlWx63Tsw0z6ha9YniAgSzNuyqbE+TFlffv9xkNiE502h8bT98+B5tz5hS
        p/KvYk8VzXAl/fefesedwG9dM364=
X-Received: by 2002:a5d:6350:: with SMTP id b16mr4225326wrw.132.1575278468947;
        Mon, 02 Dec 2019 01:21:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwH3TWy4d+usSG+H94gO0732fpYM/dp6X7UQXQG8fT5QEJTFOpQ60Dk4IP4sy1acFknCRx95w==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr4225296wrw.132.1575278468706;
        Mon, 02 Dec 2019 01:21:08 -0800 (PST)
Received: from localhost.localdomain ([77.139.212.74])
        by smtp.gmail.com with ESMTPSA id x10sm38364930wrp.58.2019.12.02.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 01:21:07 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:21:03 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org,
        kevin.patrick.schmidt@googlemail.com, paweldembicki@gmail.com,
        freifunk@adrianschmutzler.de, nbd@nbd.name
Subject: Re: [PATCH] mt76: mt76x0: fix default mac address overwrite
Message-ID: <20191202092103.GA2323@localhost.localdomain>
References: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
 <20191201091439.GA5150@localhost.localdomain>
 <0101016ec5e5b1ef-b4e11580-7984-4edc-94ef-5656419b4d26-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
In-Reply-To: <0101016ec5e5b1ef-b4e11580-7984-4edc-94ef-5656419b4d26-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 02, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Current implementation always use default eeprom mac address to
> >> configure device registers even if it is updated using
> >> mt76_eeprom_override. Fix it initializing macaddr filed of mt76_dev da=
ta
> >> structure with eeprom mac address and running mt76_eeprom_override
> >> before mt76x02_mac_setaddr
> >>=20
> >> Fixes: d1bc9bf2072c ("mt76: mt76x0: eeprom: add support for MAC addres=
s from OF")
> >> Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
> >> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >
> > Hi Kalle,
> >
> > since the commit d1bc9bf2072c is already in Linus's tree and multiple u=
sers
> > reported regression due this commit, could you please apply this patch =
in
> > wireless-drivers tree?
>=20
> Ok, I assigned this to me in patchwork and I'll queue this for v5.5.

Thx.

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeTXfAAKCRA6cBh0uS2t
rEBJAP4pHpKa72Vf+52iV59m8V2ojFb+oNND4jwXjp3+bhBrlAD9HKKoWKmVtNt4
TtEMZm8/9tSvDD4JCbKU/9CNwYJtfgw=
=ifWH
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

