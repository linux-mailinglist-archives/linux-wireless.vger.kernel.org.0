Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B37429AC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfFLOoU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 10:44:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45997 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFLOoU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 10:44:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so17185029wre.12
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FYrEuv8MQ74EUJkot2A6mAEG87v0NEVeoYyBwUFans=;
        b=IqClxxIWDSMxUBeEpdHdQAcpEe+nki4GnHkUDqWIC48WNMr9ehid/4itmnRmSEqVG4
         3FAHS7TKfwVZQ2jUUABl/qoLD7y6vh81ajewASlenw/diLKzcChpp2xtwunM26dkJvVM
         22oKiuSmL28T7CkjkE0MRV1u0aezNAbN327pzugEL9BBcwsSeTEQExL/JzFbkl8B22HP
         Hkdf4dAT/zi6xItJzWmldSOLOsK3euFguV7kxqZm6tm8r7ymJQnVyNPYB2RQGWlzIfSH
         QeuUf7gravViJvC81PTR5On4Ac9HhPqgTonJYh/jSh1YyrYu2tZ7HMIh1MRVfQVlnKqb
         Bqkw==
X-Gm-Message-State: APjAAAVs17rATwrBixsA9pGS2/z9Ubr+S2PvJ/x9n4CqbIe6o+0/JhY2
        XVzFsEOdPCsHlAJpiKUleVKTnQ==
X-Google-Smtp-Source: APXvYqwLdNTYk+A/ZfPrNO1+NlG8rYQJ+yC3Ropy78fd4rRBFyQNioSR4CO6XFKYpKK3oX1BO+iVRA==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr1603044wrq.1.1560350658446;
        Wed, 12 Jun 2019 07:44:18 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id u2sm1711208wmc.3.2019.06.12.07.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:44:17 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:44:01 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612144400.GB7016@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
 <20190612125905.GB2600@redhat.com>
 <20190612142128.GA20760@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20190612142128.GA20760@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 12, Stanislaw Gruszka wrote:
> On Wed, Jun 12, 2019 at 02:59:05PM +0200, Stanislaw Gruszka wrote:
> > > > If max RX AMSDU size is 3839B I do not see reason why we allocate
> > > > MT_SG_MAX_SIZE=3D8 of MT_RX_BUF_SIZE=3D2k buffers for sg_en case.
> > > > I thought the reason is that max AMSDU size is 16kB so it fit into
> > > > 8 sg buffers of 2k.
> > > >=20
> > > > In other words, for me, looks like either
> > > > - we can not handle AMSDU for non sg case because we do not
> > > > allocate big enough buffer
> > >=20
> > > I think AMSDU is mandatory and we currently support it even for non-s=
g case
> > > (since max rx AMSDU is 3839B)
> > >=20
> > > > or
> > > > - we can just use one PAGE_SIZE buffer for rx and remove sg
> > > > buffers for rx completely=20
> > >=20
> > > using sg buffers we can support bigger rx AMSDU size in the future wi=
thout using
> > > huge buffers (e.g. we can try to use IEEE80211_MAX_MPDU_LEN_HT_7935 w=
ith
> > > mt76x2u)
> >=20
> > I think it would be simpler just to allocate 2 pages for 7935B .
>=20
> And if we could determine that there is no true need to use sg for rx,
> I think best approach here would be revert f8f527b16db5 in v5.2 to fix
> regression and remove rx sg in -next. That would make code simpler,
> allocate 4k instead 16k per packet, allow to use build_skb (4096 - 3839
> give enough space for shared info) and not use usb hcd bounce buffer.

I do not think we should drop sg support since:
- it allow us to rx huge amsdu frames (e.g. IEEE80211_MAX_MPDU_LEN_VHT_1145=
4)
  using multiple one page buffer. I think there will be new usb devices whe=
re we can
  increase amsdu size (we can increase it even on mt76x2u usb 3.0 devices)
- without SG we can't use build_skb() without copying a given size of the p=
acket since the
  space needed for skb_shared_info is 320B on a x86_64 device
- the fix for f8f527b16db5 has been already tested

Regards,
Lorenzo

>=20
> Stanislaw

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQEPrQAKCRA6cBh0uS2t
rOsrAP9ncxctwnS+SkoNt3XQXH1P7YGS44FS16P8nsI/muKvPgEAo1vAGOPkZGo3
+R0GtsLZaguY9gZYZkJiO5SC/qoa/AU=
=GEeO
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
