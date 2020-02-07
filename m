Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18E155CDF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGR3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 12:29:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31357 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGR3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 12:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581096572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYsLnj6pxCbmXJ8pKWAi/BQk9bKglVJIk91anl+O7fk=;
        b=F4sr3UQIpi3o7qU3m2aVXC+fkfJ8gRCuGplteuxFZqyJZzhevihkOnh8QPAXM7QX46hqga
        W6mRDELWgU1T4s/AGhaeO08i85EUbxrFPB1jpEdzzdfMy86lSV3yLfQwJpnPls4y/WRh/V
        i/o9424A8kF50xjrohcKEHgDLb+6Rt4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-RQ8ADplfPqWD-pa8P152jQ-1; Fri, 07 Feb 2020 12:29:29 -0500
X-MC-Unique: RQ8ADplfPqWD-pa8P152jQ-1
Received: by mail-wr1-f69.google.com with SMTP id t6so1632120wru.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 09:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYsLnj6pxCbmXJ8pKWAi/BQk9bKglVJIk91anl+O7fk=;
        b=TWwb9yAGWwWEwi7RYnbYwaGqLOfNiK2iA4X5LTvdu00hpj4mMDw0TR+/cKE8HKAJxz
         KqL8kGf2ShQy/aiCHIIknYmq9RoaRiKXHMMV1Y8cM1D5nUwVyMQZbON7bK7ltb7RjuTN
         5bjCOCdYmB9Jc8VGy0ERBCvyW4Npx/PN2NuRdGklYXk/dc1ws86r/NgTk3CUKPgyS/uF
         SpKjHeP2slNMW4nvpvUWTiUbRrBCm0b/dDTQmlvd0HFrnRhtp99DJ+XkUNqn64xPw4hY
         1Jr1/gbTwZJdk1gHr263AFguUd/N0b0bsuSP13kR1qKvDNBXLzid2DBeyX0xtXQXeN/L
         fgaQ==
X-Gm-Message-State: APjAAAXQWB5CkdW3mSvkago/A8A9OrT3fjqL16i6jKEsc8XgWalD6328
        mPKdSdsjD+12oD/bT4KjISac7hou30JIbFCwr34AzHiM94e5wFH+cv67YIThR0qcy+dPZdpcE9+
        8YrqinJL2N5sRW6ORkseEPWDwAXI=
X-Received: by 2002:adf:ed09:: with SMTP id a9mr84660wro.350.1581096567782;
        Fri, 07 Feb 2020 09:29:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzN8KwkTazthR0emRCDY1zp+ceoLziI1OEqr57bihVFMi4aEiOMhso10oNHzM09i1V0nul6w==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr84645wro.350.1581096567608;
        Fri, 07 Feb 2020 09:29:27 -0800 (PST)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 133sm4433049wmd.5.2020.02.07.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 09:29:26 -0800 (PST)
Date:   Fri, 7 Feb 2020 18:29:24 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] mt76: reuse mt76_mcu in mt76u_mcu
Message-ID: <20200207172924.GB2538@localhost.localdomain>
References: <cover.1580945999.git.lorenzo@kernel.org>
 <9edce905c69623f50f64b0904e0657d1345b0ffe.1580945999.git.lorenzo@kernel.org>
 <3b5b64dd-8939-b730-5b2c-f720a8e1d001@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <3b5b64dd-8939-b730-5b2c-f720a8e1d001@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 07, Felix Fietkau wrote:
> On 2020-02-06 00:53, Lorenzo Bianconi wrote:
> > Introduce mt76_mcu data structure to contain common fields between
> > mt76u_mcu and mt76e_mcu.
> > Move mt76u_mcu at the beginning of mt76_usb in order to rely on mt76_mcu
> > to access mt76u_mcu common fields
> Why not move it to struct mt76_dev directly and out of the union?
> I think that would be cleaner, and you can also initialize its fields in
> mt76_alloc_device().

ack and I can maintain the usb specific fields (e.g mt76_reg_pair or burst)=
 in
mt76u_mcu. I will fix it in v2

Regards,
Lorenzo

>=20
> - Felix
>=20

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXj2ecQAKCRA6cBh0uS2t
rMsZAQCzIPAfCVDiCkk4hSKdvPUKF4uQBFb7fTQFsdoR0UQtywEAwd5yxQ7LO6n8
EkwrTFzWJVKIE4j0AhmmaKc9sGgvuwM=
=AyaW
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

