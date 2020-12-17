Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF272DD111
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgLQMEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 07:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbgLQMEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 07:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608206595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Afc5DNVCTmHu6ou3VmVI5+a7NzkL4f43wyROhABnoYs=;
        b=IliIgMggOGJswRz7zgFQxMEDv73JRDuEJ+EjFLkqfoSK97kptd8IIeY7uKyJOEtkyriO8G
        cmaropgDSSTJ4BcUVuJSmkQRFMmIOOfMph6symNcBh1lCcKRzbemtL5UvYSrv01joJ6xyG
        RYivAgZZgREROCzHzYO1TaMwZQTwvcU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-IqiVC2Y5NWOWG1KYVWbLDg-1; Thu, 17 Dec 2020 07:03:12 -0500
X-MC-Unique: IqiVC2Y5NWOWG1KYVWbLDg-1
Received: by mail-ej1-f71.google.com with SMTP id 2so8512985ejv.4
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 04:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Afc5DNVCTmHu6ou3VmVI5+a7NzkL4f43wyROhABnoYs=;
        b=r0MMDCOHS3LKrs/VElITorxcbmE4xeTk3VJtWwHjNVQkRyv8qXOD+JVgYmlC07fyCW
         cko3XeO59xeQjJBH7MRDKpu5QJMfFs8t+UQdSxycZmq5TuBZ82g6Pqvjukq+Yk7KCNKH
         NUOopixiT9l/F2Zq19BoW20fh/LsZa0nwRrKbUYs9MVdIOd1XMBwhDPHw8OAeUOil5XX
         YEoVDw9xw27QDMO6aFZNx9Zb5ZM9lBpgj3WRSOfQf8DYQ+/O0s3w9gKm/PVDijEj61+E
         Q/4pq9THm7V12+7EzlWVBTB9fTi4qmmr1e3MTHgOy2v1jiXfa/1TdFTBNWbt0b5c8D1L
         OtwQ==
X-Gm-Message-State: AOAM530u7tQQIbBilPTNPsvuOdGRi4nB9TRe4jOpuNj4LwEXyHQPo9pk
        JQZTzT7ZdwlXU28dRWsQMaNsF2Gg5FTBDR9CODQUgB4MrM/DGhMLFQs2m1odIwvNsvGUvHOildS
        oifOFb109sYmlsIZVzelg/GqU02o=
X-Received: by 2002:a17:906:b309:: with SMTP id n9mr12636096ejz.365.1608206591610;
        Thu, 17 Dec 2020 04:03:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDEfZGZY8RthLQuYsTsIyTlMxyzY35v+PQ321aIwKXbS+GZIuiiWa6u29YbdYFQKJtAEvaAQ==
X-Received: by 2002:a17:906:b309:: with SMTP id n9mr12636085ejz.365.1608206591459;
        Thu, 17 Dec 2020 04:03:11 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id k3sm10088667eds.87.2020.12.17.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 04:03:10 -0800 (PST)
Date:   Thu, 17 Dec 2020 13:03:07 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     nbd@nbd.name, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2] remove wake queue tx logic for usb/sdio
Message-ID: <20201217120307.GB16606@lore-desk>
References: <cover.1607164041.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <cover.1607164041.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Similar to mmio, remove queue wake logic for sdio and usb code path
>=20
> Lorenzo Bianconi (2):
>   mt76: usb: remove wake logic in mt76u_status_worker
>   mt76: sdio: remove wake logic in mt76s_process_tx_queue
>=20
>  drivers/net/wireless/mediatek/mt76/sdio.c | 15 +++------------
>  drivers/net/wireless/mediatek/mt76/usb.c  |  7 -------
>  2 files changed, 3 insertions(+), 19 deletions(-)
>=20

Hi Felix,

do you think we can take this series in wireless-driver or do you prefer it
goes through your tree?

Regards,
Lorenzo

> --=20
> 2.28.0
>=20

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9tI+QAKCRA6cBh0uS2t
rPNeAQCd62XF2rqM82H19DjrmEtCPrsRlysizojzA0k236JYOQD/Rk6ppAwNelOz
hPs0gDGYTge4g/0H0DWbduWNv3JAKQ0=
=mj57
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

