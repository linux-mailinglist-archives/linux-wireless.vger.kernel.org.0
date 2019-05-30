Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBE2F954
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 11:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfE3JXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 05:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfE3JXf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 05:23:35 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1531F25453;
        Thu, 30 May 2019 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559208214;
        bh=IE04O3KslegYN/4uvQDIhYykQThQ58ofU6amTsaWMRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spzgl13dBBfPrt4mqLKjQd2qraLBBLc6WGPzJHG/XkgUnO/gXrd4zXMHwGpY0A266
         wJDLUCVcEBaKdwQWdUmKc73CUev21c6KQNmgVaJLm4JCmZiORnNePLuMCSoxkNuSwi
         kes1SjlRnJah/IjRZFcOloeRFm7I1WkIobfx1Vqo=
Date:   Thu, 30 May 2019 11:23:29 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: usb: fix buffer allocation for
 scatter-gather capable devices
Message-ID: <20190530092327.GA2626@localhost.localdomain>
References: <f1f5b9f564e374174a9a2bbae29f4b72fd4c6ddd.1559163190.git.lorenzo@kernel.org>
 <87zhn4pmjv.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <87zhn4pmjv.fsf@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Partially revert commit f8f527b16db5 ("mt76: usb: use EP max packet
> > aligned buffer sizes for rx") since it breaks A-MSDU support.
> > When A-MSDU is enable the device can receive frames up to
> > q->buf_size but they will be discarded in mt76u_process_rx_entry
> > since there is no enough room for skb_shared_info.
> > Fix it by introducing q->data_size and take info account
> > skb_shared_info size in q->buf_size
> > Moreover increase buffer size even for legacy mode (scatter-gather not
> > available)
> >
> > Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes=
 for rx")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Felix, can I take this directly to wireless-drivers?

Hi Kalle,

please hold on with this patch, I will post a new one with a different
approach based on what Felix has suggested me

Regards,
Lorenzo

>=20
> --=20
> Kalle Valo

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXO+hDQAKCRA6cBh0uS2t
rEKlAQCFNuSIfShTbovgUwhu/mlbTOIQ0J8MD8ofWspekLiEJgEA2i66n5IeWO7N
2NSGtjKNP2WGT27ntNXHB6i9Fp8i6AM=
=V8W1
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
