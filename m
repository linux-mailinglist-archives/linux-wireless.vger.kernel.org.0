Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE99F155CC0
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGRW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 12:22:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727012AbgBGRW1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 12:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581096145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxWNv6iA6gWQL1mJMZPg00oBxiFGslEj8XYJ4RCtALA=;
        b=ZREWH0hXYGJ/JFvIPq+sS91+55cp0E4544vssZTQ1TW4rsl/s5eB2jsFkcWAsilAl4gvSM
        k8kICNvhyllzyPHrahNTXi9by8q9+1VM9M/kx/7n70CbltAF95/nuDDX7WN0PaAv71aCnB
        HuZewVNGNIULNa17jdCM1JurxDTzEbU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-5lY_XQbYN0OsaummTck8eQ-1; Fri, 07 Feb 2020 12:22:23 -0500
X-MC-Unique: 5lY_XQbYN0OsaummTck8eQ-1
Received: by mail-wr1-f72.google.com with SMTP id n23so1591767wra.20
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 09:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZxWNv6iA6gWQL1mJMZPg00oBxiFGslEj8XYJ4RCtALA=;
        b=ebCSbqD11/8nE3ebry8UCAticOxDwsROnm/fLM+3uPPFOcpbOX7w+pOZLdU154m4E+
         a7hAYVKlDMZ7DHcb0FsYd9ZDb0osrPAEkSnwDHAwL/ROt7UjpS28+XgAU9xc/n30DB4s
         qMrvvdeavIbXrl3ywz3Ozjkhj2z2f+k/CI3c3cJkCWGnbic7rKbTYFBly+l3dga8IC1S
         CWkNEJ3ttR4+zoFpEQDGgcCyh+nu7+YIzN1KhVOMAVU6G2tP/bPF9pKqnt4glIcqDm30
         R3SRwZYjYH9kU5XoHehTepqseP/GsjuuQebvG7qeBigkCFIdjL+9icD6aDuiyU/VxQ+F
         OmjQ==
X-Gm-Message-State: APjAAAUtfhaMLamzOzIVN7mjj4Wk+zrT4ypwrzljitMYSNApe6hoBN2a
        QXKhWh3FEwuW3e7CnoY5xq/rQWTjJeAByM3r1L49oMzhrGrm4QAxXCSL7yETpEJD3W5uZTbc0Hf
        TN2rMz0YngGkvwbTOzlLI5DJa+i0=
X-Received: by 2002:a1c:e246:: with SMTP id z67mr5666959wmg.52.1581096142326;
        Fri, 07 Feb 2020 09:22:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxa997EoT4KYl1POAVXlDfDP1Xs7t1I1SEL5rp/nCmFe6bC4UGcMauDcv1mnWpvRMkhNuc8IQ==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr5666947wmg.52.1581096142066;
        Fri, 07 Feb 2020 09:22:22 -0800 (PST)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id j5sm4266332wrw.24.2020.02.07.09.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 09:22:21 -0800 (PST)
Date:   Fri, 7 Feb 2020 18:22:18 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] mt76: generalize mt76_mcu_rx_event routine
Message-ID: <20200207172218.GA2538@localhost.localdomain>
References: <cover.1580945999.git.lorenzo@kernel.org>
 <0b2e476900157cd99417328e661e71a6ffedcb6a.1580945999.git.lorenzo@kernel.org>
 <9206f86a-8bd5-1f43-482d-8027e1a60d42@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <9206f86a-8bd5-1f43-482d-8027e1a60d42@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 07, Felix Fietkau wrote:
> On 2020-02-06 00:53, Lorenzo Bianconi wrote:
> > Rely on mt76_mcu in mt76_mcu_rx_event signature in order to reuse
> > it in usb code
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mcu.c          | 8 +++++---
> >  drivers/net/wireless/mediatek/mt76/mt76.h         | 2 +-
> >  drivers/net/wireless/mediatek/mt76/mt7603/dma.c   | 4 ++--
> >  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c   | 2 +-
> >  drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c | 3 +--
> >  5 files changed, 10 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wir=
eless/mediatek/mt76/mcu.c
> > index b0fb0830c9e1..a2936f8de915 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mcu.c
> > @@ -42,9 +42,11 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_de=
v *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(mt76_mcu_get_response);
> > =20
> > -void mt76_mcu_rx_event(struct mt76_dev *dev, struct sk_buff *skb)
> > +void mt76_mcu_rx_event(void *data, struct sk_buff *skb)
> Why the void* pointer if we have the mcu struct in a common place in
> struct mt76_dev anyway?

ack, I will fix it in v2

Regards,
Lorenzo

>=20
> - Felix
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXj2cxwAKCRA6cBh0uS2t
rK6WAP0cZtEBPWs3aE8QTcFqTouZh98U2CEsPhCam2OTGhH8IwEAonWeJZ7FArgG
RtjtPMGdbMrulxhH8hqso2TZcu36YQQ=
=/K1J
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

