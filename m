Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4158203A3E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgFVPDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 11:03:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31280 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729356AbgFVPDV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 11:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592838199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7n13XnX5EtvU9U3tyIP6VXSt/rLc7ZQl9ZlUve1Qy8=;
        b=gsVzpJdiuXLGBxradHmhHbqIiJuVlfw+ZMwQzHOq1VyTLT0LmpS6JBK87QPPJvJUjKYU4X
        AQWnEnWpImyJzAVCCvz/IouVd32RhpXIAUwB8/Aq9xiXy9JVdaxu6VXJzfJtyoSKaqs8Cf
        GjC+wf8FqN2TQZavoLllxWXILqoaOgI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-WWryU0Z_MHOPUldBUySadQ-1; Mon, 22 Jun 2020 11:03:16 -0400
X-MC-Unique: WWryU0Z_MHOPUldBUySadQ-1
Received: by mail-wm1-f70.google.com with SMTP id o13so2541390wmh.9
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 08:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7n13XnX5EtvU9U3tyIP6VXSt/rLc7ZQl9ZlUve1Qy8=;
        b=KpCwfYQEpfyv4JSecEdqzk2+gS0MOXPafNOyRD01Vn0B8fM1fyDXCCuS/8HRSl+tOg
         Qgm/vYT/nbFvIct6ORqorED6aNyAsqBvGN7eL8BzsPp1HbQyhfKgJCh2FYC054ciTARm
         oA1E9rFZOk/5uv9bQjNaiecYT+3XfdGOoujq3S62ftJfer0Wu7OkOZQP5r3soLmqrdGA
         o43UeuWrmZCf4VBYJDMpD1Ye/CCnnWchFavvAYtyJhvLWVxcKSjVAvghYswFCckRze05
         FaqB5+mg4SnDnw7YSXAFsgkd/bUJLHXkvNhwy+N4vxA2hSRwxlh6mEeSRU7P0TimIi5j
         iA3w==
X-Gm-Message-State: AOAM533hFYvjR4eBR/oD2D8/msG2ssMj9dljWYiEQiaGDR5b5J3ZbqUz
        y5I1v1ZsB6ex1bi49Xryl8fK8Wb8T/o8d1+ZgaDFACEi3eMdl3kKqqjJBf4FLEBcEb8s4LMkKWL
        NAUELTo7KA9aJbqADwgHy77Qs2lY=
X-Received: by 2002:adf:f34e:: with SMTP id e14mr19488067wrp.299.1592838195698;
        Mon, 22 Jun 2020 08:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze+KN6tRTVKbl2LeQ4bCMfklda0kcIvadPGgXcXA2AdF77rGgVMNPI/MvIJjzLWJMdOomMcQ==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr19488040wrp.299.1592838195481;
        Mon, 22 Jun 2020 08:03:15 -0700 (PDT)
Received: from localhost ([151.48.138.186])
        by smtp.gmail.com with ESMTPSA id u20sm12343506wmc.44.2020.06.22.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:03:14 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:03:09 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        sean.wang@mediatek.com
Subject: Re: [PATCH v2 wireless-drivers] mt76: mt7663u: fix memory leaks in
 mt7663u_probe
Message-ID: <20200622150309.GC27892@localhost.localdomain>
References: <e4098f0c8a9ac51997de07f38c2bcdf7042d6db1.1592755166.git.lorenzo@kernel.org>
 <87sgenfagl.fsf@codeaurora.org>
 <20200622144018.GA27892@localhost.localdomain>
 <871rm7f8pt.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <871rm7f8pt.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Fix the two following memory leaks in mt7663u_probe:
> >> > 1- if device power-own times out, remove ieee80211 hw device.
> >> > 2- if mt76u queues allocation fails, remove pending urbs.
> >>=20
> >> One logical change per patch, please. If you have to create a list of
> >> changes in the commit log that's a good sign that you need to split the
> >> patch :)
> >
> > both of them are memory leaks in the error path of the same routine (mt=
7663u_probe()).
> > Do I need to split them even in this case? If so I am fine with it.
> > Do I need to send a v3?
>=20
> Oh, I didn't notice that they were in the same function. So I guess this
> sort of gray area and no need to send v3 because of this.

ack, I will take into account for the next time, thanks :)

Regards,
Lorenzo

>=20
> --=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvDIKwAKCRA6cBh0uS2t
rBkbAP4rdur8WkWRnPSw/yg+s853UMsI26t8OyyDJpAaub18ZwEAp78Il+r7Dh1F
DM86gZ/VfrzYNh3Q0cym8GDnP2Uc9Ao=
=pj1g
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

