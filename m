Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B88721EBF1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 10:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGNIzo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 04:55:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgGNIzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 04:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594716942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eDJBgKDhcBlmkI3rsv4HEXtUZaQTNxj173l0hhdZrY=;
        b=P6v22+TdUfnnAUIN1m0kh+xu9+KhESOCNxhD6q01tQtusZGg3kyzdE/SqkRor90/cG+Vu5
        DEDV46VXqQW7JBsFN5V6HrPV+51uaDEOv9BEBQJ6iNtLumEK500zqdL0rgJ9OUCmxLPyNk
        I4g0VHjUSQWXZN2IYwhEPLoIKQfRL+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-5tmavrztODGYqH2xEu50RQ-1; Tue, 14 Jul 2020 04:55:40 -0400
X-MC-Unique: 5tmavrztODGYqH2xEu50RQ-1
Received: by mail-wm1-f72.google.com with SMTP id v6so2963366wmg.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2020 01:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eDJBgKDhcBlmkI3rsv4HEXtUZaQTNxj173l0hhdZrY=;
        b=T4WZ9GO1dz4BRdNui+BM4wwPF7HcTtsZYR3lBHO1xqSw9UVCBfNTaEztVuciATo4pY
         RjIG5NzXhURnqEuVvQMA3Y7wRJG6AvpF1rl4yy+fr1RfwEt3BhTdACcxmmmxCQqBkJG8
         e4MVFwnqHm3lnWYEqffHxPK2gJnrN/4rO1DRnifyC/E8667MaFubfLoq2UFYwhiQFIfk
         PAPT9T5NDls9/R0/jwzDjsXcaRUvSqKnahW0z6BXLQYerkxAXHGO9Zq5PI7xdFhYqRlM
         xKFscHJNf7ab18K3ZzyhjOFMKVBIQUnlFVKmvcjqdjg74/naBVIMWAx52VJAlVfIuq/l
         wzyg==
X-Gm-Message-State: AOAM531jc7LnvJ3cRc79f7G7Ip+JwgBQTE0iUhvEvViRWTFsHFa7z4M7
        unDM9cFlfv0DriYjWDFlS8ulIo/tUvD279fm6uPTE9qo9/ZvQX+9JiGoeOa5iKKkeonSEB+gToq
        P5N8R5wBAbEPFrKb7eaq6HQWiVQg=
X-Received: by 2002:adf:e684:: with SMTP id r4mr3966383wrm.68.1594716939567;
        Tue, 14 Jul 2020 01:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmzhp2xMydRagMaP/bL3Q/zNeMTxLdZ/CU9AiKBwVkjbSDa7rMgtbISb7InIIb1jg+FEFvOw==
X-Received: by 2002:adf:e684:: with SMTP id r4mr3966368wrm.68.1594716939378;
        Tue, 14 Jul 2020 01:55:39 -0700 (PDT)
Received: from localhost ([151.48.133.17])
        by smtp.gmail.com with ESMTPSA id r1sm27611127wrw.24.2020.07.14.01.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:55:38 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:55:35 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7615: always compile mt7615_mcu_set_bss_pm
Message-ID: <20200714085535.GA2174@localhost.localdomain>
References: <d486c81f9902961539574d50348cbd29fd53760e.1594203928.git.lorenzo@kernel.org>
 <87r1tecx08.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <87r1tecx08.fsf@tynnyri.adurom.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Move mt7615_mcu_set_bss_pm out of CONFIG_PM in order to fix the
> > following issue reported by kernel test robot
> >
> > ERROR: modpost: "mt7615_mcu_set_bss_pm"
> > [drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.ko] undefined!
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> What commit caused this? Should this go to v5.8?

Hi Kalle,

this is a fix for a commit in runtime-pm series
(https://patchwork.kernel.org/cover/11641171/). I posted a follow-up
patch and I did not put the fixes tag for this reason.
Next time I will add an explicit comment, sorry.

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXw1zBAAKCRA6cBh0uS2t
rM6wAQDxxKfeyHuckgr1DWVONG67fl3QtJktr6dDehLFkykY3wEA9zg2O06AGL4b
qz8AVgRb2vO2dQjk+OSsHvCHRHDuCQU=
=5KYp
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

