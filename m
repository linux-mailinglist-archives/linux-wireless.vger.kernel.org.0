Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC864C56E4
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiBZQxF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 11:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiBZQxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 11:53:05 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4C611144
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1645894348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLPL/6H4X8JcWElgBNuArS0y3HgdcFKjMdKjusklxFQ=;
        b=pDvXaF/ldZx3ONow1Fc8fd3uVwI5adOOJ+RxnUAqpHNHuzRZ4z79V4tk7Stq8dtWJAPqdD
        kK9narwgeqAzI0mMOwQGuG2S9yY2SfGOZmDjwEWo5fTqqnlceI397dI3GWnriR8i3mVsES
        A6v1G5io42NTd3HQtzHr9tXChI08pTE=
From:   Sven Eckelmann <sven@narfation.org>
To:     nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Cc:     sean.wang@mediatek.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] mt76: mt7921: fix up the monitor mode
Date:   Sat, 26 Feb 2022 17:52:24 +0100
Message-ID: <4323212.fGEXD0vb5m@ripper>
In-Reply-To: <c61deba952e23bcfa98e28778bc11af524ad2f1e.1645832790.git.objelf@gmail.com>
References: <c61deba952e23bcfa98e28778bc11af524ad2f1e.1645832790.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1807988.6yI58s65Oh"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1807988.6yI58s65Oh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Cc: sean.wang@mediatek.com, Soul.Huang@mediatek.com, YN.Chen@mediatek.com, Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com, km.lin@mediatek.com, jenhao.yang@mediatek.com, robin.chiu@mediatek.com, Eddie.Chen@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com, Eric.Liang@mediatek.com, Stella.Chang@mediatek.com, Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com, jemele@google.com, abhishekpandit@google.com, shawnku@google.com, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] mt76: mt7921: fix up the monitor mode
Date: Sat, 26 Feb 2022 17:52:24 +0100
Message-ID: <4323212.fGEXD0vb5m@ripper>
In-Reply-To: <c61deba952e23bcfa98e28778bc11af524ad2f1e.1645832790.git.objelf@gmail.com>
References: <c61deba952e23bcfa98e28778bc11af524ad2f1e.1645832790.git.objelf@gmail.com>

On Saturday, 26 February 2022 01:26:14 CET sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Properly set up the monitor mode the firmware can support to fix up
> RTS/CTS and beacon frames cannot be captured and forwarded to the host.
> 
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2: 1. add Tested-by tag
>     2. make mt76_connac_mcu_set_sniffer mt7921 specific
>     3. align the structure declartion
> ---

Tested-by: Sven Eckelmann <sven@narfation.org>

Tests were performed on

    mt7921e 0000:05:00.0: ASIC revision: 79610010
    mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20220110230855a
    mt7921e 0000:05:00.0: WM Firmware Version: ____010000, Build Time: 20220110230951

Thanks,
        Sven
--nextPart1807988.6yI58s65Oh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmIaWsgACgkQXYcKB8Em
e0aKrw//Vssi6/2O07yKa5Mz81cMImd530oXNbbubFtUBT7JHnA5nfqsiZbDyE2s
0oot4btSgkKhiqkMXiQiTb8p40yhZuEk9Tj7lm9ldo91RpQw9DIk3zAPZF5nrqNP
3UMuczn9qyzrvX9b+0cweVSavMtpd15JtxsbuWth2o+9iUuuonW3D9y0JRuQvXYq
ktg312fyfRV/VT/rZSipV53VKzSxA/vFb0Xw/9z2V+N8X3GgW9gOz8O4IToVNaTX
9SVBpHfvC7u7g5le905ibycredKmYdLTBB3PMAY6vLb2z1DEWiunkIBRlMyt0svN
C38NDCI2HAiVyrCDWC/xfobunpUKJI0cGwrqoL15GKhABta5oIdDfNmZ2Y3x3uy0
BjR6IKXvSMEVS/575Dyp6mCzBqMHVtN7QclG7CW3jTvAZEJLQqSL1rubgP2AD8gf
H6fGU6x8Ox/4Kmyl02pZOugzz+U9DqL23+IapvAh8UE54yF9uZWdg2ApvEUPyIh8
06E9AcC3wEfRbE6fYxO2tgsf3lRrtbA3FBU5eyd216RY+EgStHb94P6RfaEIp/5h
ukzypqCBG6Gn1460DpUkMfcX9Akr4R32X2XEBdQWFSBDymUjqj1fN6ONjB5/DkUJ
jEErzACmuPtOkEO2Xo2M8TKLVI7kZahdSoLUsuGA13sjBNRjpBQ=
=mdII
-----END PGP SIGNATURE-----

--nextPart1807988.6yI58s65Oh--



