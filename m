Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4F469646
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 14:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhLFNJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 08:09:03 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:54318 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbhLFNJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 08:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1638795932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pa+VJ+wikTbf6MgeFzyE0zOROss1WW8wxaJyS5P4RZA=;
        b=dPR2/FWhMboubWZcbOHpQH4K2157KD3z90KshvyFuAw5uRFkYmIvHBSVfs0mQfrPa/XAJz
        uRr4l9s3/XEcPjuH4GCJ/HhRsQC7xAa6tICQlYMWMc8Wxu8pOZI+39WBHqNPKp1sTD0Gne
        UarwYtCBo/Kk2Ct4EtArUwF4aYu32h4=
From:   Sven Eckelmann <sven@narfation.org>
To:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Cc:     nbd@nbd.name, jf@simonwunderlich.de,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Date:   Mon, 06 Dec 2021 14:05:29 +0100
Message-ID: <12706913.cppxkphV4n@ripper>
In-Reply-To: <1638579304-17794-1-git-send-email-sean.wang@mediatek.com>
References: <YapTmM3EztojTS9F@lore-desk--annotate> <1638579304-17794-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1859010.hE8cuYVgVO"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1859010.hE8cuYVgVO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: lorenzo.bianconi@redhat.com, sean.wang@mediatek.com
Cc: nbd@nbd.name, jf@simonwunderlich.de, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, Sean Wang <sean.wang@mediatek.com>
Subject: Re: mt76: MT7921K monitor mode not working
Date: Mon, 06 Dec 2021 14:05:29 +0100
Message-ID: <12706913.cppxkphV4n@ripper>
In-Reply-To: <1638579304-17794-1-git-send-email-sean.wang@mediatek.com>
References: <YapTmM3EztojTS9F@lore-desk--annotate> <1638579304-17794-1-git-send-email-sean.wang@mediatek.com>

On Saturday, 4 December 2021 01:55:04 CET sean.wang@mediatek.com wrote:
> >ack, I agree, but I guess the point here is what is the difference (from the fw pov) if you disable runtime-pm/deep-sleep before/after the vif is added. I guess it is supposed to be the same, right?
> 
> yes, it is supposed to be the same.

Two things which were noticed too:

First finding: If I run `iw dev mon0 del` after a non-working tcpdump dump 
session then I get following error messages before my complete system freezes:

    [  492.812050] mt7921e 0000:04:00.0: Message 40000002 (seq 14) timeout
    [  492.818587] mt7921e 0000:04:00.0: chip reset
    [  495.883934] mt7921e 0000:04:00.0: Message 00000046 (seq 15) timeout

Second one: We cannot see beacons on 2.4Ghz and 5GHz when runtime-pm + deep-
sleep is set to 0.



Regarding the initial problem: following works (when ignoring the missing 
beacons for now):

    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep
    iw dev wlp4s0 del
    iw phy0 interface add mon0 type monitor
    ip link set up dev mon0
    iw dev mon0 set channel 11
    tcpdump -ni mon0


What is often not working:

    iw dev wlp4s0 del
    iw phy0 interface add mon0 type monitor
    ip link set up dev mon0
    iw dev mon0 set channel 11
    tcpdump -ni mon0 &
    sleep 10
    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
    sleep 5
    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep


What I have seem to break sometimes (but cannot reproduce reliably):

    iw dev wlp4s0 del
    iw phy0 interface add mon0 type monitor
    ip link set up dev mon0
    iw dev mon0 set channel 11
    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/runtime-pm
    echo 0 > /sys/kernel/debug/ieee80211/phy0/mt76/deep-sleep
    tcpdump -ni mon0


The channel 11 is rather busy. It is for example also used for our community 
mesh network in the city center - so is rather easy for me to see that it is 
able to sniff traffic or not.

Kind regards,
	Sven
--nextPart1859010.hE8cuYVgVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGuCpkACgkQXYcKB8Em
e0Z14w//UtOZFgY8W6FRb+glxdb8vTGN+r0yyodeIZPNKZyoqaKNvOHTBPW1UxEg
EoFYmbnadse65iQjxWO0FBQC71jw6EdfjPgVc8gRDfjthnMFb9YXmhilYYkxwJ5p
cQWlNnsJUGph7MhQ16OzvpZhGWiDfY08S2av4j30GF6p7Oiis8udlYHep3/41JIr
l7q+3M7fH6MDzVSMVSxPYmUHtuhhADJiyzbhaAaAZWhRuAyDXb2NqZX48316bLSu
DyJ2N3C0tELJQ1Q6Tt1KDD17vwO/Edo2sl1Lr31apl54fvytRUus+kq7LUkVAX2v
Laq2LKlgh+eBNeHcUyrN8OoV/hkdbGEEIYWtDIaj55+XYflCybT2SAhEvZ7RFe3H
+2QG2FjQHAcWHjiFFgq4lVY6Dh2UANQgFaSzaSLYJxQJqEu4NplPjfN9zr2Auw0k
adNaExfemxqayH9u6GWfCZXnR5lu0BsAuXUqYm7OYwDKxYo5cVL0ss8fF0H8l1oN
Qf2QHGTJ633OwjcEAYRgdrbVLhOWspdYaWIKtv7Leo5yoKK7BCfBQoLl+tmU7443
w5pxWQz6PagLlS2FpLf1Vpf8lAlH6niO4JuTqyZPUgvL9pYjYYMTpQcF0Qxc01YJ
qtz8kFXbBaXAxgeDGjxfVSJyLbuHBbpqgNVlJZqErtisy8acZZc=
=IE/g
-----END PGP SIGNATURE-----

--nextPart1859010.hE8cuYVgVO--



