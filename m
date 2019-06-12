Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7A42244
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfFLKVk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 06:21:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43384 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfFLKVk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 06:21:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so6166791wru.10
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 03:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZgWxSPWlXejD04WeTmvWlz11dtlpiaCsl8iOQoe+2E=;
        b=PgrFtzz3DOCkwkL/mdL04J9P3NmFgRP8T6+ih29WxEdIjKwTKJq/tVoSp9Evw5T8ov
         lWicxoRyTjR9JYv/uhsq4pMRNdZbwybDSmha0PTr761i+NPOGHHKaOEz1Twd9rZjmt23
         /QfcMzCndK37J55mHDeUGwEfDDzOPWD1UpIPIj7ziqi/UL9ii3s1G2r5NPmpGRCuiYmP
         FiiGuCkfEzWn41czllPbp9P2+cE0WHqGMd+llAekxGHmU4qC0tZ4KndN2BioOFUTMXsd
         v/ROFqATroSKeQqPa2awxAXS7pVJynJdwIqkkcB5Y9AwcEcs1DOkdgTAtUoxi1KykM1Z
         o3XQ==
X-Gm-Message-State: APjAAAUIY0OWEmRNRtAJf/HNbP5zUzkglJYicASaBqy6nSFh4bpiG3jN
        fL/1QWKC9cG1oRb8QyeAhWuY2Q==
X-Google-Smtp-Source: APXvYqxrL5Svc/wtWpGIGy0K0QjVt8XwSXh2fzgyi1YSyd7fZVaAZezv8OaCLEK2f55Og1M37bijtg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr42104524wrt.84.1560334897838;
        Wed, 12 Jun 2019 03:21:37 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id c5sm5337151wma.19.2019.06.12.03.21.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:21:37 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:21:34 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mt76: usb: fix rx A-MSDU support
Message-ID: <20190612102133.GE8107@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
 <20190612085844.GA2965@redhat.com>
 <20190612094519.GC8107@localhost.localdomain>
 <20190612100014.GA4431@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20190612100014.GA4431@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 12, Stanislaw Gruszka wrote:
> On Wed, Jun 12, 2019 at 11:45:21AM +0200, Lorenzo Bianconi wrote:
> > > > +mt76u_build_rx_skb(u8 *data, int len, int buf_size,
> > > > +		   int *nsgs)
> > > > +{
> > > > +	int data_len =3D min(len, MT_SKB_HEAD_LEN);
>=20
> Oh, and this looks unneeded as well as for len < MT_SKB_HEAD_LEN=3D128
> we will go through fast path.

I guess if we remove data_len =3D min(len, MT_SKB_HEAD_LEN) and even *nsgs =
=3D 0 at
the end we are making some assumptions on the value of MT_SKB_HEAD_LEN and
buf_size. In the patch I just avoided them but maybe we can just assume that
MT_SKB_HEAD_LEN and buf_size will not changed in the future. What do you
think?

>=20
> > > mt7601u and iwlmvm just copy hdrlen + 8 and put the rest
> > > of the buffer in fragment, which supose to be more efficient,
> > > see comment in iwl_mvm_pass_packet_to_mac80211().
> >=20
> > Right here we copy 128B instead of 32 but I think it is good to have L3=
 and L4
> > header in the linear area of the skb since otherwise the stack will nee=
d to
> > align them
>=20
> Not sure if understand, I think aliment of L3 & L4 headers will be
> the same, assuming ieee80211 header is aligned the same in fragment
> buffer and in linear area. But if you think this is better to copy those
> to linear area I'm ok with that.

Sorry I have not been so clear. I mean in the stack before accessing a given
header we will run pskb_may_pull() that can end up copying the skb if there=
 is
not enough space in the skb->head

Regards,
Lorenzo

>=20
> Stanislaw

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQDSKgAKCRA6cBh0uS2t
rMHAAP4x05cvFjvHeUtq8ipwk5S1/icWVzngIQV/xQG7adVIXAEAtYK4SidBHBYA
hs1AEgOlhZ1dJOUkweoi8y30cWKE0gc=
=EqU9
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
