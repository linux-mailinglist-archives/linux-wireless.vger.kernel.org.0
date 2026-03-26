Return-Path: <linux-wireless+bounces-33916-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNhbG5DKxGlP3wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33916-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:56:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D982332F883
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D070B301D4DE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E62BE053;
	Thu, 26 Mar 2026 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJcVmmmJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52666145FE0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504588; cv=none; b=iL5XSMY7LyBEB94KQmIPNjCkETwCcF11DhLF6J4spG872O+ofubgtcqJfcTNjY5ShMRqMwe9U1b+IzKC8skzYACTkl/MiA7jVKSwQVmw19v6o/195WqEhyzQiUGzdrkBMoKhApifdNjBDkDMa0PqsWHbIFVOHP9J38csnklk120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504588; c=relaxed/simple;
	bh=GSGBiV6pimsYFcaUTsHEze3oEMK+9eMZdVzhhnNbZkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFd4HOsl10htYe0dHGe7Y/pCpdZ/SgzmyyGHWwDw6Zob9juLxWL3MnNCATT6IdzwO91Ep8FcyDyKrLj6EOSqqWRuQNrYQwUdNAEmCZ56j3NL7rptGqQbxE5yBm6QVjZALEAr4LDCbxvqUz5dEfvgSK3nzFABM2mQ7Dx36PPOeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJcVmmmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF10C2BCC7
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774504588;
	bh=GSGBiV6pimsYFcaUTsHEze3oEMK+9eMZdVzhhnNbZkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YJcVmmmJDJ4WHG4F7QFG+0uNjTfB48rZRuKUKvMKAXXtAWJtRZxCGmfOcY9p8h0n7
	 y6DtIKE2xMd9TzHUoKCg+6CV4FihIqsm8cu/ZPEImcDsNspHV7BzLatYeAh+/WRXDT
	 goYo2+7ScyNFrWpAIBF1DvCRDCLlq9Xcn3Eci+cZC1TSxh0Sx99Jt+J+ODBeL0z0tY
	 4rq5R6MiZ78+4wKBp/6qI2igG/PAvFx17NC4TBdKfHVvVpP1Gmuj5jPpyMnT+uxFLi
	 9Js/CSnTgOWqvgkDviOevcEzbQw4A6/TbX9kDHDbt2wHnPMy4aLZi7L0UrTQIGRGv/
	 9lRRCERCYBN5w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a32d36396so4077971fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 22:56:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFhpdx1S3iyeA5rCZGtSSidALTE61egZ+v8zG4SHpmSaObjLFBOns96zJ66MqV6YJU+WJ+cEOB564MYH7o2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMj5zumuZE1JfG6mmW0i1nw+kt+LkmLGiNTU0uP59l5YgBRqO
	ifmsLaf5ewoBDjHMFnMMAJzpwsqZcZEAyRYDxxsEkMmEXl4m8bHIK2Sr5IGY0J6GATTkPibHzHo
	i/OpHoz2nQcGKyfslzLp+p2EQqUxWX7w=
X-Received: by 2002:a2e:800f:0:b0:389:e3ad:40b7 with SMTP id
 38308e7fff4ca-38c6537b4a4mr1146961fa.2.1774504586085; Wed, 25 Mar 2026
 22:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 26 Mar 2026 00:56:16 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzo1XPR7=Gwi_Qr9ZC=g4ec+zGg_eUdh8yBgUdi=qiHMag@mail.gmail.com>
X-Gm-Features: AQROBzCgBXUtbhG8iRwtdKRawqSwIZWXpTZoHZD06hGoEDbZC2YT7tVUlmNXhZc
Message-ID: <CAGp9Lzo1XPR7=Gwi_Qr9ZC=g4ec+zGg_eUdh8yBgUdi=qiHMag@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] This series adds support for the MediaTek MT7927
 (Filogic 380) combo
To: Javier Tia <floss@jetm.me>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu <deren.wu@mediatek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>, 
	George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, 
	Samu Toljamo <samu.toljamo@gmail.com>, Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>, 
	Chapuis Dario <chapuisdario4@gmail.com>, =?UTF-8?Q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>, 
	=?UTF-8?B?5byg5pet5ra1?= <Loong.0x00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33916-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lgic.pl,humeurlibre.fr];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.820];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,jetm.me:email]
X-Rspamd-Queue-Id: D982332F883
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi, Javier

Sorry for the late reply. This version already looks better than v1
overall, and the patch order is cleaner. I still think a few areas
could be refined further, as this would also be a good opportunity to
refactor the code a bit so mt7927 support fits more naturally and
future chips are easier to handle as well.

On Wed, Mar 25, 2026 at 5:11=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> WiFi 7 + BT 5.4 module to the mt7925 driver. The MT7927 uses PCI ID
> 14c3:7927 (some hardware reports 14c3:6639) and shares the mt7925
> firmware interface but requires different DMA ring layout, IRQ mapping,
> chip initialization, and power management handling.
>
> Tested hardware:
> - ASUS ROG Crosshair X870E Hero (BT 0489:e13a, WiFi 14c3:6639)
> - ASUS ProArt X870E-Creator WiFi (BT 0489:e13a / 13d3:3588, WiFi 14c3:663=
9)
> - ASUS ROG Strix X870-I (WiFi 14c3:7927)
> - ASUS ROG Strix X870-F Gaming WiFi (BT 0489:e13a, WiFi 14c3:7927)
> - ASUS ROG Strix X870E-E (BT 13d3:3588, WiFi 14c3:7927)
> - Gigabyte X870E Aorus Master X3D (BT 0489:e10f, WiFi 14c3:7927)
> - Gigabyte Z790 AORUS MASTER X (BT 0489:e10f, WiFi 14c3:7927)
> - Gigabyte Z790 AORUS ELITE X WiFi7 (BT 0489:e10f, WiFi 14c3:7927)
> - MSI MEG X870E ACE MAX (BT 0489:e110, WiFi 14c3:7927)
> - Lenovo Legion Pro 7 16ARX9 (BT 0489:e0fa, WiFi 14c3:7927)
> - Lenovo Legion Pro 7 16AFR10H (BT 0489:e0fa, WiFi 14c3:7927)
> - TP-Link Archer TBE550E PCIe (BT 0489:e116, WiFi 14c3:7927)
> - EDUP EP-MT7927BE M.2 card (WiFi 14c3:7927)
> - Foxconn/Azurewave M.2 modules (WiFi 14c3:6639)
> - AMD RZ738 reference design (WiFi 14c3:0738)
>
> Tested on Arch Linux, CachyOS, EndeavourOS, Fedora (Bazzite), NixOS,
> openSUSE Tumbleweed, and Ubuntu across kernels 6.13-6.19.
>
> What works:
> - WiFi 7 with EHT 320MHz on 2.4/5/6 GHz bands
> - 320MHz data path verified at 841 Mbps (iperf3 -t30 -P8)
> - PCIe initialization with CBTOP remap and MT7927-specific DMA layout
> - System suspend/resume (S3)
> - DBDC (dual-band concurrent) mode
> - Explicit band_idx assignment for stable 5GHz/6GHz operation
> - ASPM and runtime PM disabled for MT7927 (see below)
>
> Known limitations (planned as follow-up series):
> - Runtime PM: disabled for MT7927 because the combo chip shares a
>   CONNINFRA power domain between WiFi (PCIe) and BT (USB).
>   SET_OWN/CLR_OWN transitions on the LPCTL register crash the BT
>   firmware, requiring a full power cycle to recover. PM enablement
>   will be addressed once safe power state transitions are determined.
> - mac_reset returns -EOPNOTSUPP (DMA recovery not yet implemented)
> - MLO (Multi-Link Operation): tested working on 5GHz+2.4GHz STR
>   (776 Mbps) but requires additional patches for link lifetime
>   and error handling. Sean Wang's series [1] addresses these;
>   MLO support will be submitted as a follow-up on top of that.
> - TX retransmissions: elevated retry rate on all bands, firmware-side
>   rate adaptation issue not addressable in the driver.
>
> [1] https://lore.kernel.org/linux-wireless/20260306232238.2039675-1-sean.=
wang@kernel.org/
>
> Patches 1-5 add generic 320MHz EHT support (no MT7927 references).
> Patches 6-7 introduce MT7927 chip ID helpers and firmware paths.
> Patch 8 adds per-chip IRQ map handling.

This part patch 1-8 looks good overall. My only concern was a possible
regression on mt7925, but now that the incorrect mt7925 320 MHz
support has been fixed  in the version, this should be fine.

> Patch 9 introduces mt792x_dma_config struct for chip-specific DMA.
> Patch 10 combines CBTOP remap, chip init, DBDC, CNM, and mac_reset.
> Patch 11 adds mt7925_band_idx() helper for stable 5/6 GHz operation.

I am still thinking a bit more about patches 9-11. My current
preference is to introduce the generic layer first, and then migrate
the mt7925 and mt7927-specific parts on top of it.
I will handle this part on my side, since I want to carefully compare
the vendor driver with your changes first, and make sure the mt7925
side is solid before moving the mt7927-related changes forward. For
the mt7927-related work, I will make sure your contribution, as well
as the work from the other volunteers, is properly preserved when I
carry this forward.

> Patch 12 disables ASPM and runtime PM for MT7927.
> Patch 13 enables the MT7927 PCI device table entries.
>
> The WiFi firmware path and filename in linux-firmware have not been
> finalized yet. The driver currently requests mediatek/mt6639/ (the
> mobile SoC codename), but this may change based on the linux-firmware
> review.

Similar to the BT side, I would prefer to have a dedicated Linux
firmware for mt7927 WiFi. I am not sure yet whether the current
changes will work seamlessly with that, so we can revisit it later and
see what further adjustments are needed.

>
> Changes since v2 (suggested by Sean Wang):
> - Fixed is_320mhz_supported() to check for MT7927 only, not the
>   entire mt7925 family. MT7925 does not support 320MHz (patch 5).
> - Dropped phy_cap_info[7] 320MHz additions (NON_OFDMA_UL_MU_MIMO
>   and MU_BEAMFORMER) to keep capabilities conservative (patch 5).
> - Disabled runtime PM for MT7927 (patch 12). The combo chip shares a
>   CONNINFRA power domain between WiFi and BT; SET_OWN/CLR_OWN
>   transitions crash BT firmware. Discovered via user reports of BT
>   lockups after enabling power_save=3D1 (Reported-by: Nitin Gurram).
> - Added tested hardware: MSI MEG X870E ACE MAX, Gigabyte Z790 AORUS
>   ELITE X WiFi7, Lenovo Legion Pro 7 16AFR10H.
>
> Changes since v1 (suggested by Sean Wang):
> - Reorganized from 18 patches into 13 across 8 logical groups
> - Common 320MHz patches first, chip-specific changes later
> - Introduced mt792x_dma_config struct to reuse mt7925_dma_init()
>   instead of duplicating as mt7927_dma_init()
> - Replaced is_mt7927() with is_320mhz_supported() in common patches
> - Added mt7925_band_idx() helper replacing scattered if/else patterns
> - Renamed MT7927-specific registers with MT7927_ prefix
> - Added PCI ID 0x0738 for AMD RZ738 hardware
> - Moved GLO_CFG_EXT1 register address into dma_config struct to
>   eliminate is_mt7927() from shared mt792x_dma.c
>
> Link to v2: https://lore.kernel.org/linux-wireless/20260319-mt7927-wifi-s=
upport-v2-v2-0-d627a7fad70d@jetm.me/
> Link to v1: https://lore.kernel.org/linux-wireless/20260306-mt7927-wifi-s=
upport-v1-0-c77e7445511d@jetm.me/
>
> Assisted-by: Claude (Anthropic)
> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
> Javier Tia (13):
>       wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_lin=
ks
>       wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
>       wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
>       wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
>       wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
>       wifi: mt76: mt7925: add MT7927 chip ID helpers
>       wifi: mt76: mt7925: add MT7927 firmware paths
>       wifi: mt76: mt7925: use irq_map for chip-specific interrupt handlin=
g
>       wifi: mt76: mt7925: add chip-specific DMA configuration
>       wifi: mt76: mt7925: add MT7927 hardware initialization
>       wifi: mt76: mt7925: fix band_idx for stable 5GHz/6GHz operation
>       wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927
>       wifi: mt76: mt7925: enable MT7927 PCI device IDs
>
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h   |  13 +-
>  drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  19 +-
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   9 +
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  61 ++++-
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  55 +++-
>  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   7 +
>  drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 277 +++++++++++++++=
++++--
>  .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  14 +-
>  .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |  20 +-
>  drivers/net/wireless/mediatek/mt76/mt792x.h        |  27 ++
>  drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  68 ++---
>  drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  33 +++
>  12 files changed, 528 insertions(+), 75 deletions(-)
> ---
> base-commit: 9ac76f3d0bb2940db3a9684d596b9c8f301ef315
> change-id: 20260319-mt7927-wifi-support-v2-e89d779b28f4
>
> Best regards,
> --
> Javier Tia <floss@jetm.me>
>
>

