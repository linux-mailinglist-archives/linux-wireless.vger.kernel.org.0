Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D14D3AAC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiCIT7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 14:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiCIT7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 14:59:16 -0500
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A4D52
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 11:58:15 -0800 (PST)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1nS2Rm-0000fe-7p; Wed, 09 Mar 2022 20:58:10 +0100
Date:   Wed, 9 Mar 2022 20:57:26 +0100
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: mt7921: Oops in mt76_dma_rx_fill
Message-ID: <20220309205726.35337cb7@barney>
In-Reply-To: <20220209170550.0a73ebe4@barney>
References: <20220209170550.0a73ebe4@barney>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ulM_q7thZS.d621.36F3Ek5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/ulM_q7thZS.d621.36F3Ek5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Does anybody have an idea why this driver crashes?

I tried to bisect it. But that turns out to be very hard as the
intermediate versions are all very unstable, too. For various reasons.
Therefore, I aborted my bisect attempt.

But if you have an idea what patch I could try, I'd be very happy to
do so.

--=20
Michael B=C3=BCsch
https://bues.ch/


On Wed, 9 Feb 2022 17:05:50 +0100
Michael B=C3=BCsch <m@bues.ch> wrote:

> Hi,
>=20
> on the latest stable 5.16.8 (df659ebe) the Mediatek WLAN driver
> crashes on my machine in a DMA function.
>=20
> Please excuse me for the crappy photos. The first one has been
> captured out of a video. Therefore it's partially interleaved with the
> predecessor frame.
>=20
> https://bues.ch/misc/mt7921/mt7921_oops1.jpg
> https://bues.ch/misc/mt7921/mt7921_oops2.jpg
>=20
> Most of the time the crash happens right during system boot.
>=20
> The stable kernel 5.15.y does not crash. (However, I frequently get
> connection interruptions. But I'm not sure whether that's related to
> the driver.)
>=20
> 03:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI
> Express Wireless Network Adapter
>=20
> 03:00.0 0280: 14c3:7961
>         Subsystem: 17aa:e0bc
>         Physical Slot: 0
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+ Status: Cap+ 66MHz- UDF-
> FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> INTx- Latency: 0, Cache Line Size: 32 bytes Interrupt: pin A routed
> to IRQ 94 IOMMU group: 11
>         Region 0: Memory at 670200000 (64-bit, prefetchable) [size=3D1M]
>         Region 2: Memory at 670300000 (64-bit, prefetchable)
> [size=3D16K] Region 4: Memory at 670304000 (64-bit, prefetchable)
> [size=3D4K] Capabilities: <access denied>
>         Kernel driver in use: mt7921e
>         Kernel modules: mt7921e
>=20
>=20



--Sig_/ulM_q7thZS.d621.36F3Ek5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmIpBqYACgkQ9TK+HZCN
iw6zVBAAlfvgNE3px/tRL0/tBOH5LX97YQxlAsS+4fNdkbnW1ESUfQW4AtNCFbtd
E+93BU/77AX3BIpNDVmdnbi3a53iBE1N4bu/UWssHeo2PRrYpK8LOKvgmo2SQ8+B
O887TPDxOGFqjS5pY7xtmzu8KpPGzIa58/qf5FYVCw1JJ/zU9Xhg9Fv+FOv8NSnv
w4lUBnQZfZROjJnSTyJNxyJSAvmU1rX5AIYD9doWwOeAr5ULX/InPHcsTlgNOQgL
OOsifnVrwvJjTqgaPWXETDPgHgvNcEgVseUhEntURH2VRJkLlAYP0D5tYl7a71Tt
WlcLr3Vfm4Wq35upWczvODD5zFXW6SSlbnrwvuf05KUi+hnmbKniaAjFJu1q9Oe0
f9+TRIQZ8FfJNmIi6DW51vybtzus7LO6gKfqdSXxtUGRlpUMXs31eLBKYI21Dgg3
b+8jE/E1+wcd6se1uMaJ2/6s4tlwg24hjfEQY7oEpCxYB6Il3kj6BApacx2PesaN
HXM4LlDYNQ70xrozgQeFUOuKYROhNrcOgVCHDug0c1kATsPUpbrifHx33/WfXX0h
rr1b5ejv+eY+EnmiuPLAZWsFhTH8UjLpFa0+XUm2zVXe+GSfg7Xdm9kxEoUiKAeV
Lg/XxLTa6nhfz+bGWxKFLcWGTdQL8oJc5OkdBgJJTIt/Eher4No=
=kBPn
-----END PGP SIGNATURE-----

--Sig_/ulM_q7thZS.d621.36F3Ek5--
