Return-Path: <linux-wireless+bounces-29287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F75BC80FA2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 15:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE6314E5585
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AE30F7F9;
	Mon, 24 Nov 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="cM8CD5Mx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77F3074AA
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994095; cv=none; b=MabCkwnaisbP6Av5VNiZWFMW/o9vbn5YbY4CdLN0TZsUvkNYZS5tiIiQDzqDczF0Ffm71KteOLpmE6B6Jasq7eXlQ/OZNoAFDJVurgEQ+RThEWyYU8ERSwyeRXIda1Ut/vg+HUuklUbOw3pfEJkT/jnM7ux77z73bS5xwPIr+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994095; c=relaxed/simple;
	bh=wivdRMik1BWALHAhjLnrG4/IqMrb4E01n+wXF9l6UiA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=sQt464LPAs3wtKO+Dr+JQzn1UEWwqjRc4Qgs02auJf9D4nrvKhMsgz+acPH9hQu1kaqqxRHj9TsNH+YJBaKJgRPesfOGbh8BKw209ISCgwk8+CGjOTG+sm0HXF4cHp54Z6Hvq+qZpXqH1x0aGbx2T5HqGkE7RSfIErlwkwQzads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cM8CD5Mx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fL8B2QYpV43NoZ52b4WAeKzuuyEnvO20HgNGDCh+Fpw=; b=cM8CD5MxxHtjD/n+6H0RNrDI8l
	Le3j0r0SSYDZqRzgNlvoyx1D2hs7w7ZLQcEd1Lwz5XlsIbTa0fjplb4toAyKwEdUd3N0CWV9qnbNd
	0IjP/RxyndW7Ld4dWg6qsura/+L/TYdAiL2ONYS4ze22otozA1h1rp+0tBuIKuRfaP9w=;
Received: from [2001:9e8:14a2:2b01:b4d6:e9eb:1477:888f] (helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vNXRU-0097nz-0c;
	Mon, 24 Nov 2025 15:21:24 +0100
Message-ID: <6b6d1033-dddf-4cc9-b240-93da7f8b8773@nbd.name>
Date: Mon, 24 Nov 2025 15:21:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-next 2025-11-24
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's my mt76 pull request for 6.19

- Felix

The following changes since commit a8e5a110c0c38e08e5dd66356cd1156e91cf88e1:

   wifi: brcmfmac: Add DMI nvram filename quirk for Acer A1 840 tablet (2025-11-24 13:07:11 +0100)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2025-11-24

for you to fetch changes up to 53d1548612670aa8b5d89745116cc33d9d172863:

   mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add() (2025-11-24 15:01:54 +0100)

----------------------------------------------------------------
mt76 patches for 6.19

- relicense to BSD-3-Clause-Clear
- fixes
- support WED on devices which exceed 32-bit DMA
- airoha NPU support
- mt7925 regd improvements
- more mt7996 MLO work

----------------------------------------------------------------
Alok Tiwari (1):
       wifi: mt76: mt7996: fix typos in comments

Caleb James DeLisle (1):
       wifi: mt76: mmio_*_copy fix byte order and alignment

Fedor Pchelkin (2):
       Revert "wifi: mt76: mt792x: improve monitor interface handling"
       wifi: mt76: adjust BSS conf pointer handling

Felix Fietkau (3):
       wifi: mt76: mt7996: fix null pointer deref in mt7996_conf_tx()
       wifi: mt76: fix license/copyright of util.h
       wifi: mt76: relicense to BSD-3-Clause-Clear

Howard Hsu (1):
       wifi: mt76: mt7996: fix implicit beamforming support for mt7992

Jack Kao (1):
       wifi: mt76: mt7925: cqm rssi low/high event notify

Lorenzo Bianconi (14):
       wifi: mt76: mt7996: Remove unnecessary link_id checks in mt7996_tx
       wifi: mt76: wed: use proper wed reference in mt76 wed driver callabacks
       wifi: mt76: mt7996: Remove useless check in mt7996_msdu_page_get_from_cache()
       wifi: mt76: Move Q_READ/Q_WRITE definitions in dma.h
       wifi: mt76: Add mt76_dev pointer in mt76_queue struct.
       wifi: mt76: Add the capability to set TX token start ID
       wifi: mt76: Introduce the NPU generic layer
       wifi: mt76: mt7996: Add NPU offload support to MT7996 driver
       wifi: mt76: mt7996: grab mt76 mutex in mt7996_mac_sta_event()
       wifi: mt76: mt7996: move mt7996_update_beacons under mt76 mutex
       wifi: mt76: Move mt76_abort_scan out of mt76_reset_device()
       wifi: mt76: mt7996: skip deflink accounting for offchannel links
       wifi: mt76: mt7996: skip ieee80211_iter_keys() on scanning link remove
       wifi: mt76: mt7996: Add missing locking in mt7996_mac_sta_rc_work()

Marco Crivellari (1):
       wifi: mt76: replace use of system_wq with system_percpu_wq

Mario Limonciello (AMD) (1):
       wifi: mt76: Strip whitespace from build ddate

Michael Lo (1):
       wifi: mt76: mt7925: ensure the 6GHz A-MPDU density cap from the hardware.

Ming Yen Hsieh (6):
       wifi: mt76: mt7925: refactor regulatory domain handling to regd.[ch]
       wifi: mt76: mt7925: refactor CLC support check flow
       wifi: mt76: mt7925: refactor regulatory notifier flow
       wifi: mt76: mt7925: improve EHT capability control in regulatory flow
       wifi: mt76: mt7925: add auto regdomain switch support
       wifi: mt76: mt7925: disable auto regd changes after user set

Peter Chiu (2):
       wifi: mt76: use GFP_DMA32 for page_pool buffer allocation
       wifi: mt76: mt7996: no need to wait ACK event for SDO command

Quan Zhou (1):
       wifi: mt76: mt792x: fix wifi init fail by setting MCU_RUNNING after CLC load

Rob Herring (Arm) (1):
       wifi: mt76: Use of_reserved_mem_region_to_resource() for "memory-region"

Shayne Chen (10):
       wifi: mt76: mt7915: add bf backoff limit table support
       wifi: mt76: mt7996: support fixed rate for link station
       wifi: mt76: mt7996: fix several fields in mt7996_mcu_bss_basic_tlv()
       wifi: mt76: mt7996: fix teardown command for an MLD peer
       wifi: mt76: mt7996: set link_valid field when initializing wcid
       wifi: mt76: mt7996: use correct link_id when filling TXD and TXP
       wifi: mt76: mt7996: fix MLD group index assignment
       wifi: mt76: mt7996: fix MLO set key and group key issues
       wifi: mt76: mt7996: fix using wrong phy to start in mt7996_mac_restart()
       wifi: mt76: mt7996: fix EMI rings for RRO

StanleyYP Wang (1):
       wifi: mt76: mt7996: fix max nss value when getting rx chainmask

Sven Eckelmann (Plasma Cloud) (3):
       wifi: mt76: Fix DTS power-limits on little endian systems
       dt-bindings: net: wireless: mt76: Document power-limits country property
       dt-bindings: net: wireless: mt76: introduce backoff limit properties

Thorsten Blum (1):
       wifi: mt76: connac: Replace memcpy + hard-coded size with strscpy

Zilin Guan (1):
       mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()

  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |  66 ++++++++
  drivers/net/wireless/mediatek/mt76/Kconfig                        |   6 +-
  drivers/net/wireless/mediatek/mt76/Makefile                       |   3 +-
  drivers/net/wireless/mediatek/mt76/agg-rx.c                       |   2 +-
  drivers/net/wireless/mediatek/mt76/channel.c                      |   2 +-
  drivers/net/wireless/mediatek/mt76/debugfs.c                      |   6 +-
  drivers/net/wireless/mediatek/mt76/dma.c                          |  75 +++++----
  drivers/net/wireless/mediatek/mt76/dma.h                          |  69 ++++++++-
  drivers/net/wireless/mediatek/mt76/eeprom.c                       |  77 +++++++---
  drivers/net/wireless/mediatek/mt76/mac80211.c                     |  10 +-
  drivers/net/wireless/mediatek/mt76/mcu.c                          |   2 +-
  drivers/net/wireless/mediatek/mt76/mmio.c                         |  14 +-
  drivers/net/wireless/mediatek/mt76/mt76.h                         | 159 +++++++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7603/Kconfig                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/Makefile                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/core.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/dma.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/init.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mac.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/main.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mcu.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/pci.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/soc.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/Kconfig                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/Makefile                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h          |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/pci.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/soc.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/trace.c                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/usb.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h             |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c             |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h             |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |  21 +--
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |  10 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |   4 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02.h                      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_dma.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_phy.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_phy.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_regs.h                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_trace.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_trace.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_usb.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c             |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_util.c                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/Makefile                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/init.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/mac.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/mac.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/phy.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/Makefile                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/coredump.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/coredump.h              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  76 +++++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 184 ++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |   8 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  11 +-
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c                   |  23 ++-
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.h              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/Kconfig                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/Makefile                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/testmode.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/Kconfig                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/Makefile                |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/init.c                  | 152 +------------------
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c                   |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mac.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/main.c                  |  40 ++---
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                   |  99 +++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                   |  10 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                |  11 +-
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c                   |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/regd.c                  | 265 ++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7925/regd.h                  |  19 +++
  drivers/net/wireless/mediatek/mt76/mt7925/regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/testmode.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/usb.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x.h                       |   4 +-
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_core.c                  |   3 +-
  drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_dma.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_trace.c                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_trace.h                 |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_usb.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/Kconfig                 |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7996/Makefile                |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7996/coredump.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/coredump.h              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c               |  74 +++++----
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c                   |  33 ++--
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h                |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/init.c                  |  34 ++++-
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c                   |  62 ++++++--
  drivers/net/wireless/mediatek/mt76/mt7996/mac.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/main.c                  | 153 ++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   |  78 ++++++----
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                  |  16 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                |  38 ++++-
  drivers/net/wireless/mediatek/mt76/mt7996/npu.c                   | 352 +++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c                   |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h                  |   2 +-
  drivers/net/wireless/mediatek/mt76/npu.c                          | 501 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/pci.c                          |   2 +-
  drivers/net/wireless/mediatek/mt76/scan.c                         |   2 +-
  drivers/net/wireless/mediatek/mt76/sdio.c                         |   2 +-
  drivers/net/wireless/mediatek/mt76/sdio.h                         |   2 +-
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c                    |   2 +-
  drivers/net/wireless/mediatek/mt76/testmode.c                     |   2 +-
  drivers/net/wireless/mediatek/mt76/testmode.h                     |   2 +-
  drivers/net/wireless/mediatek/mt76/trace.c                        |   2 +-
  drivers/net/wireless/mediatek/mt76/trace.h                        |   2 +-
  drivers/net/wireless/mediatek/mt76/tx.c                           |   8 +-
  drivers/net/wireless/mediatek/mt76/usb.c                          |   2 +-
  drivers/net/wireless/mediatek/mt76/usb_trace.c                    |   2 +-
  drivers/net/wireless/mediatek/mt76/usb_trace.h                    |   2 +-
  drivers/net/wireless/mediatek/mt76/util.c                         |   2 +-
  drivers/net/wireless/mediatek/mt76/util.h                         |   3 +-
  drivers/net/wireless/mediatek/mt76/wed.c                          |  12 +-
  include/linux/soc/airoha/airoha_offload.h                         |   1 +
  include/linux/soc/mediatek/mtk_wed.h                              |   1 +
  218 files changed, 2504 insertions(+), 683 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regd.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/npu.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/npu.c

