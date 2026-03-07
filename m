Return-Path: <linux-wireless+bounces-32709-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGP8Nf/Oq2lhhAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32709-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 08:08:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E722A8CC
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 08:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D63302BA7A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23805346760;
	Sat,  7 Mar 2026 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgqfRAcC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019017993
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772867325; cv=none; b=Hrmt4v3JSf04CRligvwxySDUNhtlLfyoFqp7f8xLJfdMSLpY8ImbP7VPzSoiKwTUePfYiMqj3DlMz4j8Af/aY/wYA4Ol0F4QXTkvivlyYK+Btaz0E8q9GUiOAqkYj+wX0n6FyhmOS8307XPN/02rLVA7KRrs8+VoTjtFM7/7J70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772867325; c=relaxed/simple;
	bh=+PW4vo+de0ZspckgLm9CKwYH4siMtdUDVAFkcNGdTis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKt9i31aoV44137v4fSlpt0qA+9UD+GwA6fkKkeVMuTF+yBs8LcVZlBkJePx0cAmCxto2Hawh6L8Uvhvxuf4b0B/bf2I8KfX1R8DhX1L+VtnUI8pSbU957DcmI5GAPCucvgWHW5iAyG7jHpoC6WlUA3LvG6nAuzub24kx8wajvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgqfRAcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3A3C19422
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772867324;
	bh=+PW4vo+de0ZspckgLm9CKwYH4siMtdUDVAFkcNGdTis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NgqfRAcCG6pYkr1mXkaBARHGF6rS0MADuHvkm6Fl7W1bUJoypY8UPBbhQS4bn5779
	 ru0VyK6I/lOLTk6Nkrw1oDd0U475cEAVv0hEa2U6YZzdOSX6DYgqp90cIho7vqoa3t
	 cTC3YEfpdb2kbm4rMMFg7y2FZLXvrJ7SW/D00OjE+csT3J+YNo61NwtQc8asy80nPg
	 6oZSQ/Y0A9dQu3wmjgIj7j15MnJhkHdGboaZ9uf7ct7W6ZXXdov0mQZGK3KA/yEK6y
	 nFDuV9dSdYnomVJ8njxp5HcqNa9tVW/ZrWzyyuwjjHpOJV2QQZr2eOKmzvIRfrYDhX
	 KFIJL87ts1ReA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3878de20527so134412761fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 23:08:44 -0800 (PST)
X-Gm-Message-State: AOJu0YzRREM/2MLyKpbDgytQVO3ghjisnhAGUgynffRDpuWZgRxfiIFQ
	+rfeIGTEaJvK2R5RUbNKA8kAUlPmA4LhiJm4icjLLEKorBi6GJR2kX1H0YsqQeZ8mugLG5idyjn
	CU9jgiJ0MJTI3nEFZSI5CG1jKzTMJEa8=
X-Received: by 2002:a05:6512:b08:b0:5a1:3f52:8601 with SMTP id
 2adb3069b0e04-5a13f528650mr1073576e87.47.1772867322919; Fri, 06 Mar 2026
 23:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
In-Reply-To: <20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 7 Mar 2026 01:08:31 -0600
X-Gmail-Original-Message-ID: <CAGp9Lzq1motdBxa9uk59Nhx0rxt4XJAp5OynpWVsB_sAm6Lx8Q@mail.gmail.com>
X-Gm-Features: AaiRm51FdRaT5F8eM2wYPfbZq4D4Kq301mf_pEP4qcp863zlhdRNAb0csgHWPYU
Message-ID: <CAGp9Lzq1motdBxa9uk59Nhx0rxt4XJAp5OynpWVsB_sAm6Lx8Q@mail.gmail.com>
Subject: Re: [PATCH 00/18] wifi: mt76: mt7925: add MT7927 (Filogic 380) support
To: Javier Tia <floss@jetm.me>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Deren Wu <deren.wu@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>, 
	George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, 
	Samu Toljamo <samu.toljamo@gmail.com>, Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>, 
	Chapuis Dario <chapuisdario4@gmail.com>, =?UTF-8?Q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>, 
	=?UTF-8?B?5byg5pet5ra1?= <Loong.0x00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 255E722A8CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32709-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org,lgic.pl,humeurlibre.fr];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.705];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

Hi Javier,

On Fri, Mar 6, 2026 at 6:33=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> This series adds support for the MediaTek MT7927 (Filogic 380) combo
> WiFi 7 + BT 5.4 module to the mt7925 driver. The MT7927 uses PCI ID
> 14c3:7927 (some hardware reports 14c3:6639) and shares the mt7925
> firmware interface but requires different DMA ring layout, IRQ mapping,
> chip initialization, and power management handling.
>
> Tested hardware:
> - ASUS ROG Crosshair X870E Hero (BT 0489:e13a, WiFi 14c3:6639)
> - ASUS ProArt X870E-Creator WiFi (BT 0489:e13a / 13d3:3588, WiFi 14c3:663=
9)
> - ASUS ROG Strix X870E-E (BT 0489:e13a, WiFi 14c3:7927)
> - Gigabyte X870E Aorus Master X3D (BT 0489:e10f, WiFi 14c3:7927)
> - Gigabyte Z790 AORUS MASTER X (BT 0489:e10f, WiFi 14c3:7927)
> - Lenovo Legion Pro 7 16ARX9 (BT 0489:e0fa, WiFi 14c3:7927)
> - TP-Link Archer TBE550E PCIe (BT 0489:e116, WiFi 14c3:7927)
> - EDUP EP-MT7927BE M.2 card (WiFi 14c3:7927)
> - Foxconn/Azurewave M.2 modules (WiFi 14c3:6639)
> - AMD RZ738 reference design (WiFi 14c3:0738)
>

Thanks for coordinating the work and delivering the driver.

> Tested on Arch Linux, CachyOS, EndeavourOS, Fedora (Bazzite), NixOS,
> openSUSE Tumbleweed, and Ubuntu across kernels 6.13-6.19.
>
> What works:
> - WiFi 7 with EHT 320MHz on 2.4/5/6 GHz bands
> - 320MHz data path verified at 841 Mbps (iperf3 -t30 -P8)
> - PCIe initialization with CBTOP remap and MT7927-specific DMA layout
> - Runtime power management and suspend/resume (S3)
> - DBDC (dual-band concurrent) mode
> - Explicit band_idx assignment for stable 5GHz/6GHz operation
> - ASPM disabled for MT7927 to prevent throughput collapse
>
> Known limitations (planned as follow-up series):
> - MLO (Multi-Link Operation): tested working on 5GHz+2.4GHz STR
>   (776 Mbps) but requires additional patches for link lifetime
>   and error handling. Sean Wang's series [1] addresses these;
>   MLO support will be submitted as a follow-up on top of that.
>
> [1] https://lore.kernel.org/linux-wireless/20260306232238.2039675-1-sean.=
wang@kernel.org/
> - TX retransmissions: elevated retry rate on all bands, firmware-side
>   rate adaptation issue not addressable in the driver.
>
> Patches 1-11 bring up the basic driver (chip ID, firmware, DMA, init,
> power management, 320MHz MCS, mac_reset guard, IRQ map, probe fix).
> Patch 12 advertises EHT 320MHz capabilities, guarded by is_mt7927().
> Patches 13-14 fix DMASHDL PM wake and disable ASPM.
> Patch 15 adds 320MHz bandwidth handling in RXV/TXS status reporting.
> Patch 16 fixes stale pointer comparisons in change_vif_links.
> Patch 17 assigns explicit band_idx for stable 5GHz/6GHz operation.
> Patch 18 adds the missing 320MHz case in bss_rlm_tlv() so firmware
> receives the correct bandwidth when associated to a 320MHz BSS.
>
> The WiFi firmware ships as part of the linux-firmware package
> (mediatek/mt6639/ directory - the firmware uses the mobile SoC codename).
>
> To: linux-wireless@vger.kernel.org
> To: Felix Fietkau <nbd@nbd.name>
> To: Lorenzo Bianconi <lorenzo@kernel.org>
> To: Ryder Lee <ryder.lee@mediatek.com>
> To: Shayne Chen <shayne.chen@mediatek.com>
> To: Sean Wang <sean.wang@mediatek.com>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> To: Deren Wu <deren.wu@mediatek.com>
> To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Tested-by: Marcin FM <marcin@lgic.pl>
> Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
> Tested-by: George Salukvadze <giosal90@gmail.com>
> Tested-by: Evgeny Kapusta <3193631@gmail.com>
> Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
> Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
> Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
> Tested-by: Thibaut Fran=C3=A7ois <tibo@humeurlibre.fr>
> Tested-by: =E5=BC=A0=E6=97=AD=E6=B6=B5 <Loong.0x00@gmail.com>
>
> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
> Javier Tia (18):
>       wifi: mt76: mt7925: add MT7927 chip ID helpers
>       wifi: mt76: mt7925: add MT7927 firmware paths and PCI device IDs
>       wifi: mt76: mt7925: add MT7927 CBTOP remap and chip initialization
>       wifi: mt76: mt7925: add MT7927 DMA ring layout, IRQ map, and prefet=
ch
>       wifi: mt76: mt7925: skip CLR_OWN in mt7925e_mcu_init for MT7927
>       wifi: mt76: mt7925: add MT7927 power management, DBDC, and CNM fixe=
s
>       wifi: mt76: mt7925: use irq_map fields instead of MT_INT_RX_DONE_AL=
L
>       wifi: mt76: mt7925: guard mac_reset against MT7927 DMA destruction
>       wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
>       wifi: mt76: mt7925: enable MT7927 runtime power management
>       wifi: mt76: mt7925: fix uninitialized is_mt7927_hw in probe
>       wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
>       wifi: mt76: mt7925: restore FW_DWLD_BYPASS_DMASHDL in MT7927 PM wak=
e path
>       wifi: mt76: mt7925: disable ASPM for MT7927 to fix throughput colla=
pse
>       wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
>       wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_lin=
ks
>       wifi: mt76: mt7925: fix MT7927 band_idx for stable 5GHz/6GHz operat=
ion
>       wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
>

The patchset should be ordered so that common changes (e.g., enabling
320 MHz support) are added first,
while chip-specific changes are introduced later (e.g.,
MT7927-specific IRQ, DMA, and hardware initialization sequences).
Before introducing chip-specific logic, try to make the functions
generic enough so that other chips can reuse them in the same way.
Checks such as is_mt7927 and duplicated function should only be added
if they cannot be avoided

The more code we can reuse across chips, the fewer maintenance
concerns there will be, and we can focus more effort on the
chip-specific parts.

Please reorganize the patchset order as follows:

1. Common patches that can be reused by other chipsets (now or in the
future) should come first we don't need to mention mt7927

"wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links"
"wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv"
"wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS"
"wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec"
"wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band"

Here we can add a helper like is_320MHz_supported() and then advertise
EHT 320MHz capabilities, but do not need to mention is_mt7927() yet.

2. Then introduce MT7927-related changes

wifi: mt76: mt7925: add MT7927 chip ID helpers
Keep the MCU part of "wifi: mt76: mt7925: add MT7927 firmware paths
and PCI device IDs" but leave enabling the PCI device table for the
last patch.

3. IRQ handling

Combine

wifi: mt76: mt7925: use irq_map fields instead of MT_INT_RX_DONE_ALL
the IRQ part of wifi: mt76: mt7925: add MT7927 DMA ring layout, IRQ
map, and prefetch
into one patch about irq_map handling, trying to reuse mt7925_irq as
much as possible.

4. DMA handling

Combine

the DMA part of "wifi: mt76: mt7925: add MT7927 DMA ring layout, IRQ
map, and prefetch"
"wifi: mt76: mt7925: restore FW_DWLD_BYPASS_DMASHDL in MT7927 PM wake path"
into one patch about DMA handling, trying to reuse mt7925_dma_init as
much as possible.

5. Hardware initialization

Combine

"wifi: mt76: mt7925: add MT7927 CBTOP remap and chip initialization"
"wifi: mt76: mt7925: fix uninitialized is_mt7927_hw in probe"
"wifi: mt76: mt7925: skip CLR_OWN in mt7925e_mcu_init for MT7927"
"wifi: mt76: mt7925: add MT7927 power management, DBDC, and CNM fixes"

into one or more patches focused on pure hardware initialization in
logical order. If the register definition is used by MT7927, add
MT7927_ as the prefix.

6. Band index fix

"wifi: mt76: mt7925: fix MT7927 band_idx for stable 5GHz/6GHz operation"
This is worth introducing helper functions and using them instead of
implementing the logic inline.

7. Low power support

Combine

"wifi: mt76: mt7925: enable MT7927 runtime power management"
"wifi: mt76: mt7925: disable ASPM for MT7927 to fix throughput collapse"

into one or more patches related to enabling or disabling low power support=
.

8. Final patch
The last patch should enable the MT7927 PCI device table.

>  drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   8 +-
>  drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  12 +
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   9 +
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  72 +++++-
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  59 ++++-
>  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  12 +
>  drivers/net/wireless/mediatek/mt76/mt7925/pci.c    | 248 +++++++++++++++=
+++++-
>  .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  13 +-
>  .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |  19 +-
>  drivers/net/wireless/mediatek/mt76/mt792x.h        |   6 +
>  drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  26 ++-
>  drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |  30 +++
>  12 files changed, 479 insertions(+), 35 deletions(-)
> ---
> base-commit: 97492c019da4b62df83255e968b23b81c0315530
> change-id: 20260305-mt7927-wifi-support-02f9738a3962
>
> Best regards,
> --
> Javier Tia <floss@jetm.me>
>
>

