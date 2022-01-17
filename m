Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44349064A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiAQKzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 05:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbiAQKzg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 05:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642416935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3d9NbS5ogfyUH4BL7U2817o4vKpaUWvQHYEUemE7cKM=;
        b=BIqwlOw8kYbRMw+d3NnDJngtbSdG1bw8oCb6lfNoKYG6mMirBQoGb0kwG4IosSgpkzFfQs
        o1SQnofFCwoPaA+7uS2o4D1OT8C8Z6yD55KIakpgrkVMjWO+QrdJIMsCqw2oBF3o8zy894
        47aBW1rBdx1kPQ+UzMMQTq5cjCObwsI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-s7V5RFKLP6SVJcMvY6DnxQ-1; Mon, 17 Jan 2022 05:55:33 -0500
X-MC-Unique: s7V5RFKLP6SVJcMvY6DnxQ-1
Received: by mail-qv1-f70.google.com with SMTP id iu14-20020ad45cce000000b0041c061c13e1so4648550qvb.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 02:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3d9NbS5ogfyUH4BL7U2817o4vKpaUWvQHYEUemE7cKM=;
        b=AsX3y7a+eFvwvVezjkSikerbfO7V+2HM1umM2SBf77ukPul0jBeLfg6wIz1Q6dw9L4
         pbn/s6qCxdCDUkeX+Gky6x+tsOmhKHHJr1UaIYcoa2rdy1Uuw0uFC4NLm5sBE0TxPh9/
         VosPO0taTW5V/Q0LC3VhBz56BXVwh0LOtODwiod1jjsWRmvK18Za61OQHph0PemsA3uh
         rU0lHgxQbhAK19ZIGM4uqC1GwyKdpSSC6tatmVdXo4zFwYcf1nqVdawbdLjMH9DV9jpT
         PsZW2hesW82UR+wsMejouP39rsjZqfN+p7sYzf2u3uuKRrg6Do1nkjosJiS4imnGC/QV
         ssKw==
X-Gm-Message-State: AOAM531mxB6g7/e/JnJQOZ4zXTJ3yigsPbD5hO38LrPFKGjJoy0xboun
        OcyL+JtuJZ7kysBnTkPgdvPbGRr8gkrAOymbEaKXrmNh36zgWYqzYhYD+zSTXta1c3hbPe4UzDR
        rQvWqq/Ab1ZHzmK1cV+0eOCTsSpU=
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr13745318qki.700.1642416933197;
        Mon, 17 Jan 2022 02:55:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8oY1qY9rvtso4cTOToi5Joo4atTzACn8OQSAzUYZ/+nn+snTwGRo4KsP+rOqzdYA9P/f3mg==
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr13745311qki.700.1642416932993;
        Mon, 17 Jan 2022 02:55:32 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id v7sm8382057qkp.30.2022.01.17.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 02:55:32 -0800 (PST)
Date:   Mon, 17 Jan 2022 11:55:29 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH 2/5] mt76: connac: move common mac defs in
 mt76_connac_mac.h
Message-ID: <YeVLITuTeO2+0dnb@lore-desk>
References: <cover.1642336806.git.lorenzo@kernel.org>
 <39e05054ccb5fc9123bea06f45833348c5b08d4d.1642336806.git.lorenzo@kernel.org>
 <6ba09c09-9248-99b9-f16b-1a2421e16cac@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3fktQ7JeGKl4fQIP"
Content-Disposition: inline
In-Reply-To: <6ba09c09-9248-99b9-f16b-1a2421e16cac@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--3fktQ7JeGKl4fQIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2022-01-16 13:43, Lorenzo Bianconi wrote:
> > Move mac definitions shared between mt7921 and mt7915 in
> > mt76_connac_mac.h header.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   .../wireless/mediatek/mt76/mt76_connac_mac.h  | 292 +++++++++++++++++
> I think this should probably be put in mt76_connac2_mac.h or something li=
ke
> that. The definitions are different for 7663/7615 (connac v1), and they w=
ill
> probably be different again for newer chipset generations.
>=20
> Maybe we should reorganize the code to make it clear which parts are conn=
ac2
> specific.
>=20
> - Felix
>=20

ack. According to irc discussion with Ryder and Sean, I marked this series =
as
'superseded' in patchwork.
I guess we can keep patch 1/5: "mt76: connac: move mt76_connac_lmac_mapping=
 in
mt76-connac module".

Regards,
Lorenzo

--3fktQ7JeGKl4fQIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeVLIQAKCRA6cBh0uS2t
rMByAP40HQUrj3ONC4BkyERHzKbjmZ9wwRD6mRBmb9r4jipPdwEAr2zmaUIWGZFG
VNggM5ivK1yAmN1QJTHfn53N/9mVZg4=
=QtAq
-----END PGP SIGNATURE-----

--3fktQ7JeGKl4fQIP--

