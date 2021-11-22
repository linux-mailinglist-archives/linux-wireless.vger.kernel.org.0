Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA96458CB6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbhKVKwh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 05:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239383AbhKVKwe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 05:52:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6AEE60241;
        Mon, 22 Nov 2021 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637578168;
        bh=6IZt0vZBL703Wzm5h/gihPzq2vaEooHapA9/mKWYmto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUg/HxIaQdbcsRjngKrP/1yIJGL5oZ4Yg/2elYJtMTcd+Mloc9O8fmVK9ibcWU5Ca
         Jm7hrS6LQqxIUggVJlT4B/fK/a9I1InOOKHFwd62VbJsCUnvwEvF0FkJQqCX5nCqG3
         A7fgeu7GbuYdM6NgTMjZ9YgfEZ5AiIKdQlZ3sibG1b+ZLLPmiPe6yf7sImNNHOhA1T
         aR9KQr33r90mDGwcs5ka14BFijbJXIEb37K62nBKxFivTyTKyOPCGj+COpuV+c5wSU
         dH/D8q1RjGOTqeuW3Z6qkDduwR60z7aXmtRVVvkMaBATn8lXzn1I+kddG4kewSGsiY
         N0gYFNKqHUs8A==
Date:   Mon, 22 Nov 2021 11:49:24 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7921s: fix the device cannot sleep deeply in
 suspend
Message-ID: <YZt1tEk0rS4evYtP@lore-desk>
References: <YZq9cBbzwtvzEKyN@lore-desk--annotate>
 <1637552808-24472-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvgaRyxRn9W6Ups7"
Content-Disposition: inline
In-Reply-To: <1637552808-24472-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--XvgaRyxRn9W6Ups7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
>=20
> <snip>
>=20
> >> >>
> >> >> -		if (test_bit(MT76_MCU_RESET, &dev->phy.state)) {
> >> >> -			if (!mt76s_txqs_empty(dev))
> >> >> -				continue;
> >> >> -			else
> >> >> -				wake_up(&sdio->wait);
> >> >> -		}
> >> >>	} while (nframes > 0);
> >> >>
> >> >> +	if (test_bit(MT76_MCU_RESET, &dev->phy.state) &&
> >> >> +	    mt76s_txqs_empty(dev))
> >> >> +		wake_up(&sdio->wait);
> >> >> +
> >>
> >> If doing so, mt76s_txqs_empty may not always be true because enqueuing
> >> packets to q_tx or MCU command to q_mcu simultanenously from the other
> >> contexts in different cpu is possible.
> >>
> >> It seemed to me we should check it for each iteration to guarantee
> >> that we can wake up the one that is waiting for the all the queues are=
 empty at some time.
> >
> >IIUC what we are interested here is there are no queued frames into the =
hw queues during suspend or reset, right?
>=20
> That is not completely true. Take the suspend procedure on mt7921s as an =
example.
>=20
> That should be "There are no queued frames into the hw queues right after=
 mt76_connac_mcu_set_hif_suspend."
>=20
> The MCU data and WiFi are all handled in mt76s_txrx_worker so we should s=
ynchronize all of
> the Tx queues are all empty and then handle mt76_connac_mcu_set_hif_suspe=
nd to guarantee
> mt76_connac_mcu_set_hif_suspend is the last one to access the SDIO bus an=
d there is no frame that accesses SDIO bus afterhand.

ack, correct, "there are no queued frames into the hw queues right after
mt76_connac_mcu_set_hif_suspend."
What I mean is we are not really checking there are no frames in the hw que=
ue
here, but mt76 sdio has processed all the frames, got my point? maybe it is
what we are looking for..

Regards,
Lorenzo

>=20
> >
> >>
> >> >>	/* enable interrupt */
> >> >>	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
> >> >>	sdio_release_host(sdio->func);
> >> >>
> >> >> Regards,
> >> >> Lorenzo
> >> >>
> >> >> > --
> >> >> > 2.25.1
> >> >> >
> >> >
> >> >
> >> >
> >>
> >

--XvgaRyxRn9W6Ups7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZt1tAAKCRA6cBh0uS2t
rIgUAP9cH8ze/XEp+miz+xtPvfgGccW2FQqPeK59A5pUSznO9gEAjWdLGp0yUamR
m6kdq55y2RuFs7kd51MVV7DfrxldHww=
=oCiO
-----END PGP SIGNATURE-----

--XvgaRyxRn9W6Ups7--
