Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7372039BD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgFVOk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:40:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27778 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729108AbgFVOk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592836826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p7/u6DsX1IxTZY65XNqBIXWoiFmVQX6mSSNOxGWI0NA=;
        b=BRF+SWcKS4u7L17zl+MK4TccZQ7hFDZ3O5Xeoqb9xO8rOBo3/DtyS2gmI+Ck/rsuqZ4EKU
        PwprIHzjZ7Es2r3dKkQbqWR+mfH4EeUr2eu25S04uqhkh2Z+VD05tHfB+OWebFRa03mCXd
        Q7FGIO4fPT1z3hjnuXKCzqUFTR3Nu1c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-tD7pKS7DOb6Xi4s7bgjn0A-1; Mon, 22 Jun 2020 10:40:23 -0400
X-MC-Unique: tD7pKS7DOb6Xi4s7bgjn0A-1
Received: by mail-wr1-f69.google.com with SMTP id p9so10928175wrx.10
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 07:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p7/u6DsX1IxTZY65XNqBIXWoiFmVQX6mSSNOxGWI0NA=;
        b=SbqrP/fElp7SFrwOmWhwaTgE6vWYkY3eKnvM99KDfI37NV+qu7UnD8etXQndzf4xd/
         hBTZktC0gSDJvk8Nsmse+ebxYWsEoBBuR+sCgvriMeGeM2jQhDvEat9AWl5zVh0Yu0M2
         FmRsafqia53EAjQmj9qD+g8GV8kQFAnlll4Q5S3+wBDWYSuUL1woq86oD4TG4eYLi3Ps
         p93fmq4oQ2OFHeaDkKLPPO1RWfVfyK+tG/nT3ZdXLNw9SF1M7LXm5kF5yDV97xAUAb50
         mM6oRLgVEuhUtCjR8RX0pZp4vJ+r3X/jldY1A7f7MXiDJWpoG1fzCC+V+doUm1cHk7UX
         SY4w==
X-Gm-Message-State: AOAM533iBqA9HM7KLxjugMWJuGAHByD9XuHuiJIr+sWJWApgYGL87FgQ
        t/m6patOCO6At7kN5qznlaphZmsdg9gprklZlAJA5tqmKUhlSzT8/m4sXddnhHrjUtMuPPdkDHm
        iwib/mcHb1RLwttx+mKe2/Rd6hAM=
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr3051358wmf.0.1592836822817;
        Mon, 22 Jun 2020 07:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8f1nbOtvYWjErSUnihnlgOXBYPQeRkPkSmuZMOCLXq4HRC/Z96otnUhJD5nCUs6U2J/wQtQ==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr3051339wmf.0.1592836822579;
        Mon, 22 Jun 2020 07:40:22 -0700 (PDT)
Received: from localhost ([151.48.138.186])
        by smtp.gmail.com with ESMTPSA id 65sm13678445wre.6.2020.06.22.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:40:21 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:40:18 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        sean.wang@mediatek.com
Subject: Re: [PATCH v2 wireless-drivers] mt76: mt7663u: fix memory leaks in
 mt7663u_probe
Message-ID: <20200622144018.GA27892@localhost.localdomain>
References: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
 <87sgenfagl.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <87sgenfagl.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Fix the two following memory leaks in mt7663u_probe:
> > 1- if device power-own times out, remove ieee80211 hw device.
> > 2- if mt76u queues allocation fails, remove pending urbs.
>=20
> One logical change per patch, please. If you have to create a list of
> changes in the commit log that's a good sign that you need to split the
> patch :)

Hi Kalle,

both of them are memory leaks in the error path of the same routine (mt7663=
u_probe()).
Do I need to split them even in this case? If so I am fine with it.
Do I need to send a v3?

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvDCzwAKCRA6cBh0uS2t
rHkwAPsHrCfE2AgvIE6+LItQ05AnU+pGh+j2Xos70Fw6MKn9RAEAssTsUOWWgXef
pn2HpnaIDaEqjwTsr8WMMUHp0AT6MAI=
=gwGv
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

