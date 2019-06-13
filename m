Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E283E43EC4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfFMPwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 11:52:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45393 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFMJGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 05:06:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so19837994wre.12
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 02:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXO70GY2JHL7zJ2nQ1TsWFC1oLm37Fk2XN3R6UPvBEE=;
        b=jaJtcRasSpXtj2fj1jPqWPztK0jd7LNNh3qqruNeMKzw/4bPCmTy7krY+CqKwl61iQ
         QBRVFRjQvB6iS6vY1+Z3jw1VFTmPuYnBeARVPMCTK8nsqSL4HhIUPdBT4XqjmUem0Szo
         2AnrqKS8sIpAStsGgWDqK5n5e0xXWDO0Vw+m2JiZUw94tGHvhX/0CcKHfJhnjKsW5q0V
         wkXsXHQpx0TAf3uRNl3rtaPJAofVDNt3zTGtcpRi9QLG4uKV6dKMsygC2RS3JuiwPPvT
         VhPw0U6RFJZXr9YCnabO9HFVzams41KDi1cPaMgRnnPsF6Kzw353nIOT2Nds3dHjqZgH
         rjrg==
X-Gm-Message-State: APjAAAV++Gk64UAk6vQ+J8PoMSW1NjxrTRFK8BuZdNA1LEtHx7cK6YBw
        HmtaEtQrBeqRj6OLNiDsK6tdcQ==
X-Google-Smtp-Source: APXvYqz5D9cLCCkrbj/MftW8qmH2ChhqzWVKlyj2b9TlQkWDe4knMhHKH56X6dMAA18X8WQU8rQppA==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr45186709wrp.223.1560416802770;
        Thu, 13 Jun 2019 02:06:42 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id c11sm1483298wrs.97.2019.06.13.02.06.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 02:06:42 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:06:39 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190613090638.GC18296@localhost.localdomain>
References: <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
 <20190612125905.GB2600@redhat.com>
 <20190612142128.GA20760@redhat.com>
 <20190612144400.GB7016@localhost.localdomain>
 <20190613075108.GA24650@redhat.com>
 <20190613082637.GA18296@localhost.localdomain>
 <20190613090201.GA2753@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20190613090201.GA2753@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi
>=20
> On Thu, Jun 13, 2019 at 10:26:38AM +0200, Lorenzo Bianconi wrote:
> > [...]
> >=20
> > > I looked at intel wifi drivers and this is handled by amsdu_size modu=
le
> > > parameter, supported values are 4k, 8k and 12k. RX allocation size and
> > > proper values in vht_cap & ht_cap are set accordingly. Assuming (some)
> > > mt76 HW and FW can handle bigger AMSDUs I think we should do similar
> > > thing.
> > >=20
> > > Otherwise looks for me, we just waste memory and have not needed code
> > > for no true reason.=20
> > >=20
> > > >   space needed for skb_shared_info is 320B on a x86_64 device
> > >=20
> > > Uhh, I haven't expected that sk_shared_info() is that big, so indeed =
build_skb
> > > could not used and 128B copy fallback will be necessary.
> >=20
> > Hi Stanislaw,
> >=20
> > reviewing the original patch I think we can't trigger any IOMMU bug sin=
ce the
> > usb buffer length is actually 2048 and not 2048 + skb_shared_info_size:
>=20
> I'm concerned about alignment and crossing pages boundaries. If you
> allocate via page_frag_alloc() buffers, except first one, will have
> 'not natural' alignment and every second will be spanned across
> two pages.

ack, so I think the second approach will be safer (using roundup instead of
rounddown :))

Regards,
Lorenzo

>=20
> Stanislaw
>=20

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQISHAAKCRA6cBh0uS2t
rOlXAP9SxlZVLBMxBP5RoPprBvpEh/Z/NvZeSoQbHx5MkSs8YgEA1pxyIqFG6ruz
gqqDeg3MbB7ic9gPVlE28a1OW9+IIgo=
=Jj3W
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
