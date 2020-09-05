Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE525E756
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Sep 2020 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgIELsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Sep 2020 07:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgIELsB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Sep 2020 07:48:01 -0400
Received: from localhost (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2A82073B;
        Sat,  5 Sep 2020 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599306480;
        bh=PfNIJP6tSuXawSNPB0d0S0qvta+DrIm+UVq4WcMs+Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yyxii/kL/ud8Fip4aSni5uLyMyWZ+AKNix4yrpaT3IHk6h9K0VmLO5CY8Ii3JieyM
         lSwUIBz/1W3XwXRJUYVymeZRt+Zou0+FJhVjh06pjn92BxQbdi6RJhsHcp/zV1g8Mg
         qiUzXt65wF0fKi7bnzhFRliq5NsdMJZCbXL68VvU=
Date:   Sat, 5 Sep 2020 13:47:55 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: Re: [PATCH 1/7] mt76: mt7663s: do not use altx for ctl/mgmt traffic
Message-ID: <20200905114755.GA638275@lore-desk>
References: <cover.1599297449.git.lorenzo@kernel.org>
 <9cc863c3d8e9b36af2add3c42474f14adbdc2df1.1599297449.git.lorenzo@kernel.org>
 <e25120be-fef8-c42a-d889-a027fd211c85@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <e25120be-fef8-c42a-d889-a027fd211c85@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 05, Felix Fietkau wrote:
> On 2020-09-05 11:26, Lorenzo Bianconi wrote:
> > Since the sdio engine does not report quota for altx queue, move
> > ctl/mgmt traffic to standard data queues
> >=20
> > Tested-by: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Wouldn't this add powersave buffering to non-bufferable mgmt frames in
> AP mode?

Right, but sdio devices do not have a hw dma scheduler like pcie or usb
ones and just report the availale quota for new trasmission for data queues=
 only
AFAIU. Moreover AP support is not tested yet.

Regards,
Lorenzo

>=20
> - Felix

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX1N66QAKCRA6cBh0uS2t
rD3UAQCr4mBSMLoBolC3M76f5SENjxSBlgVLWISFtA+LgTEvXQD9E/NdIl1nWNre
ao/mAbWK5UAsYlez9eTqmTcKkO0N7Ak=
=fZ/E
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
