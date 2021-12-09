Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A256446E9B2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 15:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhLIORU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 09:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231946AbhLIORT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 09:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639059225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1S6rtyY8u3x7vV4s9QhxQiYkWds801oT9UBXiBzvq8=;
        b=BC4Dq4dfioIzbAtWiaNKOL2Zfx3MntoC3gcKhOO9m0ShVVcV6JR64tqOWnAR0xgK97bj2Y
        wS/W4MYdX4RK23Pv5qnqyhS2kIt1kPdv02S1k0g5Q8FjdCP0Me79OrLZrw6pftCel8xAqA
        yUnGRFwrzwvWvqVDV+K2K7SpII58mPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-qpOe_0QqNkWS_oT4wZJU3A-1; Thu, 09 Dec 2021 09:13:44 -0500
X-MC-Unique: qpOe_0QqNkWS_oT4wZJU3A-1
Received: by mail-wm1-f69.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so2551271wmb.4
        for <linux-wireless@vger.kernel.org>; Thu, 09 Dec 2021 06:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T1S6rtyY8u3x7vV4s9QhxQiYkWds801oT9UBXiBzvq8=;
        b=flPDoQEaVIjPwPEbh+H2mf7Ff71fbA75zIGfM0UvEmOfnBh0NVXoGmvO/kVDKE9//p
         LWLq8TVG/92IsvSJC3aJahlHaD/Ab5zrDJTerig75mlqGVVnOa7aWM4ang8WnDWPtdoR
         6UkpquL9JqBL5EVQ5MGAMuSHfTnMLlf/f7kcGRzyzVk8eHWt3jrCSxRqRx5SiQ4nL/av
         IwCDgFSbGDfLtZrsTQKcCgr9VwbYa2pCAf6CYz2ZJ8heRYXDpUIIgEW55IlQDACbxbZA
         gMmDJvpelP3/7SOXWh0YRiWt/MCiZDRFJqx/j1QGGmuLwEjLOsPCaZtSYQGM9YtskWXx
         ThBQ==
X-Gm-Message-State: AOAM5305SnA+mnSWXKT2Fhz2Oxah5HhNDP532ppR66LnbOw/GkRKEDMs
        v3J1/a/JPvYYjXqmhWSfmBCgsHJrf7ZfIb4NFlGHrt0TXni+dd3JSjz73k+SxkdOfYZch/HDGbe
        BJaWKAyfC/Kb/60tM52ToI5Q6uNw=
X-Received: by 2002:a5d:5147:: with SMTP id u7mr6759848wrt.233.1639059222919;
        Thu, 09 Dec 2021 06:13:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxs0t32qLpqOAfF7JuE4spcBzfo3UmhJ71TMoONwX1ETI4ah//+LMIcCd8EGICtAe5qnDS5Gw==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr6759814wrt.233.1639059222708;
        Thu, 09 Dec 2021 06:13:42 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id s8sm6179183wra.9.2021.12.09.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 06:13:42 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:13:40 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>, Deren Wu <Deren.Wu@mediatek.com>,
        Mark-YW Chen <Mark-YW.Chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>, jemele@google.com,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jf@simonwunderlich.de
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Message-ID: <YbIPFIaya1vKF6bM@lore-desk>
References: <67f30cd5235e2065e6c20cfb4662e4ac72ef6395.1639037336.git.deren.wu@mediatek.com>
 <2314855.OJx0zA1Pyt@ripper>
 <3841963.FhVex8QpIh@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjkU6hzf6ZLTHJOB"
Content-Disposition: inline
In-Reply-To: <3841963.FhVex8QpIh@ripper>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--zjkU6hzf6ZLTHJOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thursday, 9 December 2021 10:21:02 CET Sven Eckelmann wrote:
> > Tested-by: Sven Eckelmann <sven@narfation.org>
>=20
> I would like to retract this again because it seems like the firmware is =
now=20
> hanging all the time when the default runtime-pm/deep-sleep settings are =
used.
>=20
>     [  521.553436] mt7921e 0000:05:00.0: Message 40000002 (seq 12) timeout
>     [  521.559884] mt7921e 0000:05:00.0: chip reset
>     [  521.661983] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build=
 Time: 20211129210838a
>     [  521.661983]=20
>     [  521.684088] mt7921e 0000:05:00.0: WM Firmware Version: ____010000,=
 Build Time: 20211129210917
>     [  521.723561] mt7921e 0000:05:00.0: Firmware init done
>=20
> This doesn't seem to happen that often when I perform a
>=20
>    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
>    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep
>=20
> before setting up the interfaces.
>=20
> But even then, on the first "ip link set up dev mon0" (not only for mon0 =
-=20
> also for wlan0/...) it will crash with:
>=20
>=20
>     [  806.731357] mt7921e 0000:05:00.0: Message 00000046 (seq 4) timeout
>     [  806.737730] mt7921e 0000:05:00.0: chip reset
> RTNETLINK answers: Connection timed out
>     [  806.867666] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build=
 Time: 20211129210838a
>     [  806.867666]=20
>     [  806.888441] mt7921e 0000:05:00.0: WM Firmware Version: ____010000,=
 Build Time: 20211129210917
>     [  806.928204] mt7921e 0000:05:00.0: Firmware init done
>=20
> But when I then set up the device again then it seems to work. This is th=
e=20
> case for monitor and managed interfaces.
>=20
> I've used commit 678071ef7029 ("mt76: mt7615: clear mcu error interrupt s=
tatus=20
> on mt7663") in mt76.git for this.=20

does it occur with an older fw?

Regards,
Lorenzo

>=20
> Kind regards,
> 	Sven



--zjkU6hzf6ZLTHJOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYbIPFAAKCRA6cBh0uS2t
rKx+AP9d7SOcOblztzxdRBXT0mu90H/4HHELZ2txXKAjgURt8AEAivSXJ/gYEtQg
Cx4dhBOmhYnSfz4fMWpM3Q9cyw1WiwQ=
=2F7f
-----END PGP SIGNATURE-----

--zjkU6hzf6ZLTHJOB--

