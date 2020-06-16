Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB341FC0B6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 23:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFPVN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 17:13:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39137 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbgFPVN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 17:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592342004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSzFkwURLVeW2opiRMpP25mHAWNktDQUA6Jwol8j1DE=;
        b=dtKmHCQPYNQYGmfN3mQ3KgHQKbTiRvXGBcOaSkU385229DSKK6bDKhXd5jEiZASpIl0R/L
        Qr0djgpyrN+TdJnoqwaLU88clfOvulXmyit3KXwkCSvvx8Z1vccX15xLa1iga6Fy4kgkL5
        uHboB4XziaRj8/lr8TrN1dX4ckkmun4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-_z09KlLJPEeg4xHiMFnktg-1; Tue, 16 Jun 2020 17:13:22 -0400
X-MC-Unique: _z09KlLJPEeg4xHiMFnktg-1
Received: by mail-wm1-f72.google.com with SMTP id x6so82377wmj.9
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2020 14:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eSzFkwURLVeW2opiRMpP25mHAWNktDQUA6Jwol8j1DE=;
        b=tJ1Y9NwIU6m85s5ROJbwsWHlYxFRPNPFu9rVrkBLCflft4IJP6tCHADAHTvxDeYdrP
         lhjTkcBRzm/qxFsmG3a/VCibspEt3FN4PJutQJFJl3/rBS4vsEKU7Lo578bv8kVmeq9d
         khc4n1gmTmXDrDm685wMybmXAM6FHXEX8kSbhsKpZgGYLxKlktbxSUrE6FqQhhlcnR6P
         afUIK/XSzcwO9arfbRxY149v0j+S8EAHSMTYjyvL5aq4qnHv+h/Puy9a5s56zBDSYJPw
         dd1340+zh0FuHRn4stKLzpxZphRl+aW4T+CrpaL+RMUlslsMCZ8mbCkGH0pc8ZpdBSYD
         325g==
X-Gm-Message-State: AOAM533RcOp9dypUTRo1NSmN8R73EJigIWEtcNa00deDtXiPhSykLLk/
        s809+QqmHKtVpT5XjGXOxoM/uqg2yIkMksrhKIMC0qhWa7h7jmMXXjLrA3hCPtM5IyCWvZOTGvo
        cMtefTbJfbUWu3q3s+ideq+/DlyM=
X-Received: by 2002:adf:82ab:: with SMTP id 40mr4728962wrc.85.1592342001441;
        Tue, 16 Jun 2020 14:13:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/qi++d55UA+IwKBiZUUaY0o68WCq/wUWthnInfPt1DBbyhEHxviYjhjajoKfGjP0RSvNaNg==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr4728937wrc.85.1592342001092;
        Tue, 16 Jun 2020 14:13:21 -0700 (PDT)
Received: from localhost ([151.48.140.182])
        by smtp.gmail.com with ESMTPSA id j5sm31290775wrq.39.2020.06.16.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 14:13:20 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:13:16 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] mt76: mt7615: cleanup codes
Message-ID: <20200616211316.GA440740@lore-desk.lan>
References: <0cb7ad2a49010a540baca21cd19c43540534b141.1592204310.git.ryder.lee@mediatek.com>
 <d38bed5a-a035-4e87-aaf3-12031d55de50@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <d38bed5a-a035-4e87-aaf3-12031d55de50@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2020-06-15 09:01, Ryder Lee wrote:
> > Cleanup indentation, mixed licenses and change some functions' type as =
void.
> >=20
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Please separate code cleanup from license changes, and make sure you get
> an ACK from all people involved with the code that you change the
> license for.
> I'm fine with the license change, but I'm not sure if any code was
> copied from mt7601u. At least Lorenzo also needs to ack this.

I am fine with license change. IIRC I used mt7601u as reference but I did n=
ot
copied the code. Adding Jakub in cc.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> - Felix
>=20

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXuk16QAKCRA6cBh0uS2t
rCCZAPsFZ4V26kvFngFmmf11RZdpgKh+ntCuT34dhbHrXUA3XwD/Rz8q2Zc1ZvjU
F+WBrfJVMhFPw+CGfPXwRfHBlu7tTwc=
=D7Zw
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

