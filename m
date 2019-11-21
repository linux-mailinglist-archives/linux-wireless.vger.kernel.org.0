Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105B9104D18
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 09:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUIB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 03:01:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33824 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbfKUIBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 03:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574323314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5rMLUA9VMnp/a6Jugkzpeb6MSB60S08+t0RvQkBchg=;
        b=K4/61/RzaV1ORXHQRuCBKO7A95cgE/SHWWaTTn3oZC2ReWY0OlW1WeSvy4R7jmR1e3UWqY
        3d3ov9dvB8FBdwCAdbGMHSbzyc0MuZBrzt3OgD7Xya0FKGn6HUX6dIKkGibEAfYcChd7+I
        DjyUXGLwqQLbDmtaHplz2SCy0bR3f2c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-vkuBFe8cOyK2iXuGO4sKlQ-1; Thu, 21 Nov 2019 03:01:52 -0500
X-MC-Unique: vkuBFe8cOyK2iXuGO4sKlQ-1
Received: by mail-wr1-f70.google.com with SMTP id p1so536071wrw.8
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 00:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sw/1GbhPCX5QDjPBsGrbCGsMgJoHFoYBHXlTMBw3yqU=;
        b=I0cfrFnWfNjoXXAUtFp2MpeCQgKMykFQMsBJZWB0OHD+JiLk7wLNXLvMPK6qnW7L8x
         UzNoqEINBDPykk5i7YiH5pCAXgZsP7I5kGA+aPDLUvXCVFGEFtK5TXcpn05f39xFfWkh
         CyJPcYP7HFvzOLkR7PiqdgPsLuL43KgqkV+DqbWwBpCJ7Q1bvibdOle3q3a5q0iPMW8d
         nydmj5sXeNLIuz55T60rNqybGrcu0NgKd9r4p2zmRO2wzDVhSEKEPhaWOeBbbkb6FwXH
         B7LOHo08zAUS/NhC1e2D5ZyLu0foC7gKS1qUB2DRhO+eg6ZiZ/k0fh4JGCT9wS3E914J
         RWCQ==
X-Gm-Message-State: APjAAAU2fPt+cHEYQFxxBKkZxxGD9TCcFQFRCD5l+kXHY/q6eS4TJDfT
        z1jtGCmYaHJA5Butx3ZRtjKk4aLxPuZGoanewdUUvht7+md/nFL+0CJqW4aRYbx8mqXxLUhKaja
        AKwaz/Lj9ZGVeTo0A3gvpK+nDc1U=
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr8849081wrp.5.1574323311411;
        Thu, 21 Nov 2019 00:01:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxypj0XzxqJ9b53x8QfTA/AlIrHBhS/jiChWysdaDJ9sdwngVHTc8JM19qop4T7fq5j3tTACA==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr8849018wrp.5.1574323310903;
        Thu, 21 Nov 2019 00:01:50 -0800 (PST)
Received: from localhost.localdomain ([77.139.212.74])
        by smtp.gmail.com with ESMTPSA id k4sm2125669wmk.26.2019.11.21.00.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 00:01:50 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:01:46 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: Re: [PATCH v2 3/3] mt76: mt7615: add set_coverage class support
Message-ID: <20191121080146.GA2720@localhost.localdomain>
References: <cover.1574253996.git.lorenzo@kernel.org>
 <7c9088415ce08fd8b71eda9b53a4a213865886aa.1574253996.git.lorenzo@kernel.org>
 <0101016e8cbff2f0-f543727d-0d42-45d5-a536-64e5545d4946-000000@us-west-2.amazonses.com>
 <20191121074452.GA2299@localhost.localdomain>
 <0101016e8cf84124-8768f5ae-dcbe-4941-abf9-e950e6e7cf34-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
In-Reply-To: <0101016e8cf84124-8768f5ae-dcbe-4941-abf9-e950e6e7cf34-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Add the capability to configure actimeout for mt7615 driver. Moreove=
r
> >>=20
> >> acktimeout?
> >
> > Hi Kalle,
> >
> > yes, it suppposed to be acktimeout
> >
> >>=20
> >> > configure slottime according to the value provided by mac80211
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>=20
> >> [...]
> >>=20
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> >> > @@ -60,6 +60,47 @@ void mt7615_mac_reset_counters(struct mt7615_dev =
*dev)
> >> >  =09mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR=
);
> >> >  }
> >> > =20
> >> > +/* XXX: DBDC support */
> >> > +void mt7615_mac_set_timing(struct mt7615_dev *dev)
> >>=20
> >> Should this be "FIXME:"? Thought don't remember what style is used in
> >> mt76.
> >
> > actually for DBDC we used TODO.
>=20
> Even better.
>=20
> > Should I resend?
>=20
> No strong feelings from me, just wanted to point out while reviewing the
> pathces. Up to Felix :)

ack, both ways are fine for me.

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdZEZwAKCRA6cBh0uS2t
rBKGAP45zEjv+sk7kkOLrR2mXLSxsswbsC+5vq7zIXY4qwLhdAD/ZfPAxR8PDjp4
b/MqepFjeXmQTSw3zM2Zslydqz36egU=
=xzIt
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

