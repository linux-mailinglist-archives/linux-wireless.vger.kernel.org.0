Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40404328BE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJRVGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 17:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJRVGu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 17:06:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C9560FC3;
        Mon, 18 Oct 2021 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634591078;
        bh=VNh+iLTefjYB1dJLM3/f3OT4eYSLkDnSvr5ru6WGQ1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtxJeqFTHZ/ZM69DYb3iT0XfAc62YXmpvfVCVmX0tPMmpm469lNJC5uxzezknFjou
         hjTKjYRFepfW9HCN7MjCMOM1SC7AsfV+vxxa9eRTHf5ko9+Y9FlJ8M6TcarwxonWMg
         jr/suTyGpHfn7weQEI7BLYKZ3GgP68twwUaUR9ZnO/lUG7HM3VskTonoLvoYIvcmfz
         9R5T+4sWelAlR6Gz9qACKZgOBhSUTETKN6/1PlNk2VtqX+1RcVf61VhTcQymObrPN1
         R+oZYlvzhwE9KF/kfc80Tl3TdT8MtoUlXE8/5IuTaq1yb9dfXM4Z7pF4h+iip+GHr8
         9frR1vkS1MCJQ==
Date:   Mon, 18 Oct 2021 23:04:34 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: Re: [PATCH 00/10] mt76: ethtool stats features and fixes
Message-ID: <YW3hYr1Q6OlOAlhb@lore-desk>
References: <cover.1634558817.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+iAae6AE78u2m0wg"
Content-Disposition: inline
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--+iAae6AE78u2m0wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> - mt7921: add ethtool support similar to mt7915 driver
> - mt7915: some ethtool fixes

Hi Felix,

please drop this series, I will post v2 addressing some bits.

Regards,
Lorenzo

>=20
> Lorenzo Bianconi (10):
>   mt76: move mt76_sta_stats in mt76.h
>   mt76: mt7921: add sta stats accounting in mt7921_mac_add_txs_skb
>   mt76: mt7921: add some more MIB counters
>   mt76: mt7921: introduce stats reporting through ethtool
>   mt76: mt7921: move tx amsdu stats in mib_stats
>   mt76: move mt76_ethtool_worker_info in mt76 module
>   mt76: mt7921: add per-vif counters in ethtool
>   mt76: mt7915: run mt7915_get_et_stats holding mt76 mutex
>   mt76: mt7915: do not overwrite all mib counters in mt7915_get_stats
>   mt76: mt7915: move tx amsdu stats in mib_stats
>=20
>  drivers/net/wireless/mediatek/mt76/mac80211.c |  28 +++
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  17 ++
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   |  24 +--
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   |  11 +-
>  .../net/wireless/mediatek/mt76/mt7915/main.c  |  59 ++----
>  .../wireless/mediatek/mt76/mt7915/mt7915.h    |  13 +-
>  .../wireless/mediatek/mt76/mt7921/debugfs.c   |  27 ++-
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   |  49 ++++-
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 169 +++++++++++++++++-
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  22 +++
>  .../net/wireless/mediatek/mt76/mt7921/regs.h  |  28 +++
>  11 files changed, 363 insertions(+), 84 deletions(-)
>=20
> --=20
> 2.31.1
>=20

--+iAae6AE78u2m0wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYW3hYgAKCRA6cBh0uS2t
rIe/AQDQ67jQKh33IzDEAyVsshjguDeAvQXKaz0GMHmWMvYEswD9Fz1ySAIBThD4
4Tcr1jvINRIEgkZKVXDMO5S/CmWJZw0=
=ZOf2
-----END PGP SIGNATURE-----

--+iAae6AE78u2m0wg--
