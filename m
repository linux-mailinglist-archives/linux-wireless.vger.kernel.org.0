Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3E459488
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 19:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhKVSNo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 13:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239983AbhKVSNn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 13:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F84160C4A;
        Mon, 22 Nov 2021 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637604637;
        bh=PFN2CROc4S+afWA8sCWkdKWg1HgYXMCA/zlJA9iHrs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPd0ptLK+G0guUXtybwpp8xVuOuiDR48peevICOEHk5Hzoe5A5wR062lwESZDZG+n
         yHPIB5Z9slnNUKDLz37MRpZXxopFWcLW1a2ZSTXhImB3btYOfPBiFEvPWNzW4p3ALH
         WS5oNlJM1J0sfbihyKDvInBcg+aEpWqtmznk+8qPEeHtBQHGRMoja72D2KIcDdpx/w
         U6cQy37tRCjIm4ERn8Mg01HdiWPt8pRuu0vqWT2yvJqvyQoShIDwlA8S/3Mc3d0epk
         xzZ3D2kxFgn4y8hlLYZNcH84n+sPX7GFZSACnrMfYZ9j0W7W4f1FfVapZ2LvqM3s5/
         zk1j9RUNkaL7Q==
Date:   Mon, 22 Nov 2021 19:10:33 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7921s: fix the device cannot sleep deeply in
 suspend
Message-ID: <YZvdGdUYZIIp/LNU@lore-desk>
References: <YWcuGcFPGCtaPh+2@lore-desk--annotate>
 <1637601035-16521-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4xMxxhlRwqFq70N1"
Content-Disposition: inline
In-Reply-To: <1637601035-16521-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--4xMxxhlRwqFq70N1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >>
> >> <snip>
> >>
> >> >> >>
> >> >> >> -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
> >> >> >> -			if (!mt76s_txqs_empty(dev))
> >> >> >> -				continue;
> >> >> >> -			else
> >> >> >> -				wake_up(&sdio->wait);
> >> >> >> -		}
> >> >> >>	} while (nframes > 0);
> >> >> >>
> >> >> >> +	if (test_bit(MT76_MCU_RESET, &dev->phy.state) &&
> >> >> >> +	    mt76s_txqs_empty(dev))
> >> >> >> +		wake_up(&sdio->wait);
> >> >> >> +
> >> >>
> >> >> If doing so, mt76s_txqs_empty may not always be true because
> >> >> enqueuing packets to q_tx or MCU command to q_mcu simultanenously
> >> >> from the other contexts in different cpu is possible.
> >> >>
> >> >> It seemed to me we should check it for each iteration to guarantee
> >> >> that we can wake up the one that is waiting for the all the queues =
are empty at some time.
> >> >
> >> >IIUC what we are interested here is there are no queued frames into t=
he hw queues during suspend or reset, right?
> >>
> >> That is not completely true. Take the suspend procedure on mt7921s as =
an example.
> >>
> >> That should be "There are no queued frames into the hw queues right af=
ter mt76_connac_mcu_set_hif_suspend."
> >>
> >> The MCU data and WiFi are all handled in mt76s_txrx_worker so we
> >> should synchronize all of the Tx queues are all empty and then handle
> >> mt76_connac_mcu_set_hif_suspend to guarantee mt76_connac_mcu_set_hif_s=
uspend is the last one to access the SDIO bus and there is no frame that ac=
cesses SDIO bus afterhand.
> >
> >ack, correct, "there are no queued frames into the hw queues right after=
 mt76_connac_mcu_set_hif_suspend."
> >What I mean is we are not really checking there are no frames in the hw =
queue here, but mt76 sdio has processed all the frames, got my point? maybe=
 it is what we are looking for..
>=20
> It seemed to me there is no a way to check if no frames in the hw queue f=
or mt7921s
>=20
> I think we can discuss the topic "it is ok move the check out of the loop=
" with another patch in the future
>=20
> because it seemed not related to the patch.

sure, fine to me.

Regards,
Lorenzo

>=20
> >
> >Regards,
> >Lorenzo
> >
> >>
> >> >
> >> >>
> >> >> >>	/* enable interrupt */
> >> >> >>	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
> >> >> >>	sdio_release_host(sdio->func);
> >> >> >>
> >> >> >> Regards,
> >> >> >> Lorenzo
> >> >> >>
> >> >> >> > --
> >> >> >> > 2.25.1
> >> >> >> >
> >> >> >
> >> >> >
> >> >> >
> >> >>
> >> >

--4xMxxhlRwqFq70N1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZvdGQAKCRA6cBh0uS2t
rAOBAQDPXyiptC49D6WH6nCNkYxDwpmkEfAXXVJ/h4rf7kcNQAD/ZHfX0Vb/Rhvx
HMXd7wt5kW94R0MzviYqoDxnVz53sAY=
=kLhc
-----END PGP SIGNATURE-----

--4xMxxhlRwqFq70N1--
