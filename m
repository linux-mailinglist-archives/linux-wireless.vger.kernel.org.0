Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FC466BF8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 23:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhLBWRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 17:17:02 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40106 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhLBWRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 17:17:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A1B2CE2430
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 22:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A01C53FCC;
        Thu,  2 Dec 2021 22:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638483215;
        bh=A3raQgcb+4L8AD7EbGTwN4lEFvWI8rGV3Y+jJbN62ZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQ00CU7BoXkCTj19d0qfpwmwcaqBCHzBdPJrXMN3AE5QCtuD4zdM29JlicRbkLFPb
         3CzkXGlLAZ5R/RsFUIKRxH+nMll7Vjg0aGm+jzTWS0rNDMcXBqm7canP1SNugNgB9H
         uuN7BR8paFJ/9B7X/I+d/SQqCu8T7jeTE15tRBiizFxmRwfceWbskvlJ7aDxpi+pfB
         1MeCMV+qpfkRri9bA65ewI+7tggP8nxeaaERJ09VHeLbKDrRtxa4AGhwE/pHFmPld1
         4JlYP2gf5eZcf9iIZRTGo6gW6xrACPgWK8mzBaO+a3/9EraH6XHHhF0o4JDUb29Qse
         v9YNIAL8YYPqA==
Date:   Thu, 2 Dec 2021 23:13:31 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jan Fuchs <jf@simonwunderlich.de>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: mt76: MT7921K monitor mode not working
Message-ID: <YalFC7UlCPsCSZqE@lore-desk>
References: <7e156597-a206-b236-e4c8-d476614de7ef@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MoRz4FRtRneXt4LG"
Content-Disposition: inline
In-Reply-To: <7e156597-a206-b236-e4c8-d476614de7ef@simonwunderlich.de>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--MoRz4FRtRneXt4LG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,

Hi Jan,

>=20
> we are not able to obtain any packets when packet capturing with the
> Mediatek MT7921K in monitor mode on 2.4, 5 and 6 GHz.
> tcpdump will show you 0 recorded packets. When doing a "iw dev wls1 scan"=
 on
> a parallel running managed interface on the same phy, the packet capture
> will contain beacons and probe responses from the scan though.
> Can anyone confirm that?
>=20
> mt76 (https://github.com/openwrt/mt76/commits/master): commit
> 6fad970893dd26ef6e6c8344b958344254f6362a (HEAD -> master, origin/master,
> origin/HEAD)
> Kernel: 5.16.0-rc2-next-20211124+
> WM Firmware Version: ____010000, Build Time: 20211014150922

IIRC you need to disable runtime-pm and deep-sleep to proper enable monitor
mode:

echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/runtime-pm
echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/deep-sleep

Can you please give it whirl?

Regards,
Lorenzo

>=20
> Steps to reproduce:
> sudo iw dev wls1 del
> sudo iw phy phy0 interface add mon0 type monitor
> sudo ip link set dev mon0 up
> sudo iw dev mon0 set freq 6115
> sudo tcpdump -i mon0 -w 6g-capture.pcap
>=20
> Kinds regards, Jan
>=20

--MoRz4FRtRneXt4LG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYalFCwAKCRA6cBh0uS2t
rA9fAQCjuXbjvrk8usgB2jb4Xufp0ODoUjWxtaFKIaacNVV8hwEAo1cq+5rXGfHy
t2QTactR7cLbUSQIL1/MmaqsKzqCIAI=
=Gtqe
-----END PGP SIGNATURE-----

--MoRz4FRtRneXt4LG--
