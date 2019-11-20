Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99311038D4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfKTLhf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 06:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfKTLhf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 06:37:35 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2669F20857;
        Wed, 20 Nov 2019 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574249854;
        bh=nbHC84ZDlcC/R2zoZ1BzeanN0qdpNKuurPfBIeJxVe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8fAdhUztMh3H/kPU7MdO0oz1cs670cIh/IfIbM6+WTZzSMpUn32YTqNQI7bGOc9N
         fLzgpeV1fF4FY0oOc1qOYsL8wb0oJxoRmMSJrjfBlX4tttL0SJktNwWKhhy/Hpqrye
         GXkt/1iemq0US8z/7sT2BY6EJEOQlb9VGjHSbIl8=
Date:   Wed, 20 Nov 2019 13:37:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: Re: [PATCH 1/3] mt76: mt76x02: fix coverage_class type
Message-ID: <20191120113723.GA21993@localhost.localdomain>
References: <cover.1573828743.git.lorenzo@kernel.org>
 <eefff3bdc564c6cf57fcdaa14e887838aff192cc.1573828743.git.lorenzo@kernel.org>
 <a6f5e59e-533a-644e-895c-e81440a7ca6e@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <a6f5e59e-533a-644e-895c-e81440a7ca6e@nbd.name>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2019-11-15 16:05, Lorenzo Bianconi wrote:
> > Fix coverage_class definition in mt76x02_dev data structure since
> > coverage_class can be negative to enable dynack (just supported by
> > ath9k)
> >=20
> > Fixes: 7bc04215a66b ("mt76: add driver code for MT76x2e")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I'd prefer a patch that sets the internal coverage_class field value to
> 0 for negative input values.

ack, I will do in v2

Regards,
Lorenzo

>=20
> - Felix

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdUlcAAKCRA6cBh0uS2t
rB2xAP4nbrNGoatkv4SAN3Cr1XlHBzNjQtNhs7Slxi9CF5xH4gEAjRzuICHik3Ds
V8YiNSNBe54THBUkapBh91jQ39On/AM=
=hgRF
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
