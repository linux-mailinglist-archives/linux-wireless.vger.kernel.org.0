Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1220E502
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgF2Vba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 17:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgF2SlR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:17 -0400
Received: from localhost (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90F6233A2;
        Mon, 29 Jun 2020 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593422364;
        bh=m/iiSCx+pGoofNGY4QOfyGseGMXlhswPQHcWfiNnN1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Usm1byau/LGXrbc+GPk/jIjDZmdUrcv8x9RdyrjH6gxci18C9D1RYnlMhtGAgpGmB
         ZkH3qW6Fz/VH2SXisHf3cfCflRvtLJLSHIkZRntHi9b94NQ64PO0SHSstfeGQTRnHO
         90wlGnrhqr4afzFIyg0Xwib8uVJjttPQTmRk0Ecs=
Date:   Mon, 29 Jun 2020 11:19:19 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     James <bjlockie@lockie.ca>
Cc:     Mathy Vanhoef <vanhoefm@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Alfa AWUS036ACM (Mediatek MT7612U) AP problem
Message-ID: <20200629091919.GA10533@localhost.localdomain>
References: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
 <CAFXAJYwgRPAbY4i8XHNGzcyJg-11BwOSdDS6098eh_CEzxeEUQ@mail.gmail.com>
 <9c44f87b-eaa5-afcb-b830-30b2b36232d5@lockie.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <9c44f87b-eaa5-afcb-b830-30b2b36232d5@lockie.ca>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Kernel 5.4.48 is better so far:
> Uptime
> 1d 18h 6m 32s
> It sounds like it is only a matter of time since you have the problem on a
> later kernel.
> I did get rid of a cable and use a powered USB 3 hub.

Can you please try to load the mt76_usb module with disable_usb_sg=1?

Regards,
Lorenzo

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvmyFAAKCRA6cBh0uS2t
rDD0AP42HhxaAH9pCerPqWpGh3U0BFZ/9lXFQ37KN5dovIoy+wD9HcZcyReJehE8
QnbS0LF1sMcRpoFLoKw1uBPI2sjEJgg=
=XI/x
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
