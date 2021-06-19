Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0270A3ADA00
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhFSMjB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 08:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234112AbhFSMjB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 08:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624106210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUfC5e8Q8yPtHqzv3GrsV4cF/leHgif5ynQm/ztqXzE=;
        b=MxEBNShKmIHmBpglYLl0/dmCFCwY4MChIcKyZNKTZXzT3zhNSKYgr7Rf4M7JimUmmEdhtH
        yTm5Yisr6jR3KJF5Xqe2kWSzLKhnaR2UUO6gwD8NMtIbXrggIasaIDLIIn1hBEwvP94Fnz
        AMam60cqG/qo74vnn8xWX+mFOmUZ2PE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-voERBgKsMbKYvBH1E67ckw-1; Sat, 19 Jun 2021 08:36:46 -0400
X-MC-Unique: voERBgKsMbKYvBH1E67ckw-1
Received: by mail-ed1-f71.google.com with SMTP id u26-20020a05640207dab02903935beb5c71so4878016edy.3
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jun 2021 05:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aUfC5e8Q8yPtHqzv3GrsV4cF/leHgif5ynQm/ztqXzE=;
        b=sLswouZCqBqVm9lwej6TThVtnNJZfcD/a4vVL5Ya40gtZOi0xwFXtvH1qyUPtJh031
         J7oMlKWt+d+olMtPaATJecyWNv9hRn2wKJmlDfFKtLbBBcgo1Gw63JVFnqtMVcxBnkJs
         1GOm4/7UZctHcOQ9+BKjfTcqMQTEb77HcypK7dBp+yREjLF18+5i+zX1iMapAYz+PXnL
         gO40bXlOxN/hQcq0ND41egKjAePdKheBXEofnX+bqCTXs00oQy64Rt+m0dbnZmVwrtDw
         HK8qgnnZNutEieoxgo1h205Wo0pFA+NLzSY457Z8EytebEpd0wW15P7cKZeszlNNVFIT
         j7xA==
X-Gm-Message-State: AOAM5331UGZSTohZVYl/7lgQPA5p0CafOnTmWdA+qBB8YMIf5eA8iu+A
        N+VmyOhPRv8JQwC2APFTDZ53jDyxboLMHmIDNx/ax9rlPn2ncvx3NYuvxzcQd51L/LUgAKqudT2
        svvawipvjC8VwdL7XhSuH3fpzb3I=
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr15658160ejc.389.1624106205407;
        Sat, 19 Jun 2021 05:36:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWOlQEfNtxrHCiLPKIp/QpNvvyc/9NwptE5AmsuEoldyDP282+zjgC+CKvSgJJ8nKbvtLHHA==
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr15658152ejc.389.1624106205247;
        Sat, 19 Jun 2021 05:36:45 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id r17sm7590944edt.33.2021.06.19.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:36:44 -0700 (PDT)
Date:   Sat, 19 Jun 2021 14:36:41 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: allow chip reset during device restart
Message-ID: <YM3k2dm2HcW/J+FJ@lore-desk>
References: <96d84ef577cb558969a56ed42e68769eac0d3a1c.1624012209.git.lorenzo@kernel.org>
 <874kduktao.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hYRt0vSG9dtgb5Li"
Content-Disposition: inline
In-Reply-To: <874kduktao.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--hYRt0vSG9dtgb5Li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Disable chip full reset just during device probing but allow
> > it during hw restart.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > @@ -160,7 +160,8 @@ struct mt7921_dev {
> >  	u16 chainmask;
> > =20
> >  	struct work_struct reset_work;
> > -	bool hw_full_reset;
> > +	bool hw_full_reset:1;
> > +	bool hw_init_done:1;
>=20
> Is there a specific reason why you use bitfields in a boolean? Looks
> strange to me.

Hi Kalle,

nope, there is no specific reason, I have just reused the same approach use=
d in
mt76_queue_entry for skip_buf{0,1}.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--hYRt0vSG9dtgb5Li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYM3k1gAKCRA6cBh0uS2t
rL9ZAP0RLCCGd9vcS14J9RFTCaZxP5E3xz6XpmsAmyFCr4KNOQD/ecC4qNoXECnY
4kh5y88j3i7DPqazG71Iw0vi98bEBwE=
=nkOW
-----END PGP SIGNATURE-----

--hYRt0vSG9dtgb5Li--

