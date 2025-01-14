Return-Path: <linux-wireless+bounces-17493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2EA10710
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24D318858B0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1A230272;
	Tue, 14 Jan 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GXCYusla"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFA236A78
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858865; cv=none; b=QtZT3+kIo1jb+orczXvwB1yI198TnDvk9EMJrS1BJ8KISxdwQfBjcOaN5Rx3EB58j0uX2P79aG7IHh2xvlO1822GUhQh8e0fIU9b3OnVbSheLIzXcn+wtFZqK9dXx1lPugbkVfagKwFPNLbkki1wC+88Q0xnILegRQ6082TmOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858865; c=relaxed/simple;
	bh=aGiWZUMeXR3G8ntUdHILe2FhoAjyRfwPwM6DbTsx+ZQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=WKGbwhjBmQyo02VqzN979Cd4n/GwEYLJsWJa6XFR/msmnC/nSMWz+pab9cf7WqxYBRwBQooLYbPPX0sZ8RViuYwngkeeElPaTvkwBKhUNRs62jDdf2YrFzF4iQwZvsvu68gXtkklFYNyA7rCEj6NmqEfOG5oodBdsIz7ZtnqoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GXCYusla; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Pvm02f5jMvou0ie9VL8r3gWwzwzdnsVt2aPNuxmVwc8=; b=GXCYuslaG17LpniFbhMtH3uPz8
	RQa2PHSf1qZbPd5jmlVBXGKqTHLTgrSkyyfmp4snCgrEhU4ILRaPxqpIiHlMWS2dGcH2XfunW/uzv
	XDYCZ87peS2ipVL45hl8tCezpsMECFsYJbVsK64ryjkfg/9BggT+bzDE+Te/OZ+Cy8EM=;
Received: from p54ae9a10.dip0.t-ipconnect.de ([84.174.154.16] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tXgKa-006fxl-2C;
	Tue, 14 Jan 2025 13:47:40 +0100
Message-ID: <c8b5e95a-fcae-47e2-b48a-236b62d6ca04@nbd.name>
Date: Tue, 14 Jan 2025 13:47:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2025-01-14
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
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

Hi Kalle,

Here's another updated version of my pull request for 6.14.
It fixes a chanctx related regression and adds more mt7996 fixes.

- Felix

The following changes since commit 8221712a174ad83e36489c414c26619010f4e348:

   wifi: brcmfmac: Add missing Return: to function documentation (2025-01-10 15:14:00 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2025-01-14

for you to fetch changes up to ad4c9a8a980336450631dce8cc0799f9a8de1914:

   wifi: mt76: mt7996: add implicit beamforming support for mt7992 (2025-01-14 13:42:30 +0100)

----------------------------------------------------------------
mt76 patches for 6.14

- mlo fixes for mt792x
- single wiphy multiband support for mt7996
- mt7915 stability fixes

----------------------------------------------------------------
Allan Wang (2):
       wifi: mt76: introduce mt792x_config_mac_addr_list routine
       wifi: mt76: mt7921: add rfkill_poll for hardware rfkill

Ben Greear (2):
       wifi: mt76: mt7996: Add eht radiotap tlv
       wifi: mt76: Fix EHT NSS radiotap reporting.

Benjamin Lin (2):
       wifi: mt76: mt7996: fix incorrect indexing of MIB FW event
       wifi: mt76: mt7996: fix definition of tx descriptor

Chad Monroe (2):
       wifi: mt76: mt7915: exclude tx backoff time from airtime
       wifi: mt76: mt7996: exclude tx backoff time from airtime

Charles Han (1):
       wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links

Christophe JAILLET (1):
       wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()

Dan Carpenter (1):
       wifi: mt76: mt7925: fix off by one in mt7925_load_clc()

Eric-SY Chang (1):
       wifi: mt76: mt7925: fix wrong band_idx setting when enable sniffer mode

Felix Fietkau (37):
       wifi: mt76: remove mt76_calculate_default_rate()
       wifi: mt76: mt7996: remove phy->monitor_vif
       wifi: mt76: mt7915: fix slot time for 5/6GHz
       wifi: mt76: mt7915: fix eifs value on older chipsets
       wifi: mt76: mt7996: fix rx filter setting for bfee functionality
       wifi: mt76: mt7915: reduce the number of command retries
       wifi: mt76: mt7915: decrease timeout for commonly issued MCU commands
       wifi: mt76: only enable tx worker after setting the channel
       wifi: mt76: mt7915: ensure that only one sta entry is active per mac address
       wifi: mt76: mt7915: hold dev->mutex while interacting with the thermal state
       wifi: mt76: mt7915: firmware restart on devices with a second pcie link
       wifi: mt76: mt7915: fix omac index assignment after hardware reset
       wifi: mt76: mt7996: use mac80211 .sta_state op
       wifi: mt76: do not add wcid entries to sta poll list during MCU reset
       wifi: mt76: add code for emulating hardware scanning
       wifi: mt76: add support for allocating a phy without hw
       wifi: mt76: rename struct mt76_vif to mt76_vif_link
       wifi: mt76: add vif link specific data structure
       wifi: mt76: mt7996: split link specific data from struct mt7996_vif
       wifi: mt76: initialize more wcid fields mt76_wcid_init
       wifi: mt76: add chanctx functions for multi-channel phy support
       wifi: mt76: remove dev->wcid_phy_mask
       wifi: mt76: add multi-radio support to a few core hw ops
       wifi: mt76: add multi-radio support to tx scheduling
       wifi: mt76: add multi-radio support to scanning code
       wifi: mt76: add multi-radio remain_on_channel functions
       wifi: mt76: mt7996: use emulated hardware scan support
       wifi: mt76: mt7996: pass wcid to mt7996_mcu_sta_hdr_trans_tlv
       wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_info for MLO support
       wifi: mt76: mt7996: prepare mt7996_mcu_add_beacon for MLO support
       wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for MLO support
       wifi: mt76: mt7996: prepare mt7996_mcu_set_timing for MLO support
       wifi: mt76: connac: prepare mt76_connac_mcu_sta_basic_tlv for MLO support
       wifi: mt76: mt7996: prepare mt7996_mcu_update_bss_color for MLO support
       wifi: mt76: mt7996: move all debugfs files to the primary phy
       wifi: mt76: mt7996: switch to single multi-radio wiphy
       wifi: mt76: mt7996: fix monitor mode

Hao Zhang (1):
       wifi: mt76: mt792x: add P2P_DEVICE support

Howard Hsu (4):
       wifi: mt76: mt7996: fix the capability of reception of EHT MU PPDU
       wifi: mt76: mt7996: fix HE Phy capability
       wifi: mt76: connac: adjust phy capabilities based on band constraints
       wifi: mt76: mt7996: add implicit beamforming support for mt7992

Leon Yen (4):
       wifi: mt76: mt7921s: fix a potential firmware freeze during startup
       wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
       wifi: mt76: mt7921: introduce CSA support
       wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain

Michael Lo (2):
       wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.
       wifi: mt76: mt7925: config the dwell time by firmware

Michael-CY Lee (1):
       wifi: mt76: mt7996: fix beacon command during disabling

Ming Yen Hsieh (15):
       wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
       wifi: mt76: mt7925: fix the invalid ip address for arp offload
       wifi: mt76: mt7925: Fix incorrect MLD address in bss_mld_tlv for MLO support
       wifi: mt76: mt7925: Fix incorrect WCID assignment for MLO
       wifi: mt76: mt7925: fix wrong parameter for related cmd of chan info
       wifi: mt76: mt7925: Enhance mt7925_mac_link_bss_add to support MLO
       wifi: mt76: Enhance mt7925_mac_link_sta_add to support MLO
       wifi: mt76: mt7925: Update mt7925_mcu_sta_update for BC in ASSOC state
       wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
       wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
       wifi: mt76: mt7925: Update secondary link PS flow
       wifi: mt76: mt7925: Init secondary link PM state
       wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO
       wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
       wifi: mt76: mt7925: Properly handle responses for commands with events

Nick Morrow (1):
       wifi: mt76: mt7921u: Add VID/PID for TP-Link TXE50UH

Nicolas Cavallari (1):
       wifi: mt76: mt7915: Fix mesh scan on MT7916 DBDC

Peter Chiu (4):
       wifi: mt76: mt7915: fix register mapping
       wifi: mt76: mt7996: fix register mapping
       wifi: mt76: mt7996: add max mpdu len capability
       wifi: mt76: mt7996: fix ldpc setting

Quan Zhou (6):
       wifi: mt76: mt7921: fix a potential scan no APs
       wifi: mt76: do not hold queue lock during initial rx buffer alloc
       wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
       wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
       wifi: mt76: mt7925: add handler to hif suspend/resume event
       wifi: mt76: mt7925e: fix too long of wifi resume time

Sean Wang (1):
       wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO

Shayne Chen (4):
       wifi: mt76: mt7996: extend flexibility of mt7996_mcu_get_eeprom()
       wifi: mt76: mt7996: add support for more variants
       wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916
       wifi: mt76: connac: rework connac helpers

Shen Lichuan (1):
       wifi: mt76: mt7615: Convert comma to semicolon

StanleyYP Wang (1):
       wifi: mt76: mt7996: set correct background radar capability

WangYuli (1):
       wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO

Zhang Kunbo (1):
       wifi: mt76: mt7925: replace zero-length array with flexible-array member

allan.wang (1):
       wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment

xueqin Luo (2):
       wifi: mt76: mt7996: fix overflows seen when writing limit attributes
       wifi: mt76: mt7915: fix overflows seen when writing limit attributes

  drivers/net/wireless/mediatek/mt76/Makefile           |   2 +-
  drivers/net/wireless/mediatek/mt76/channel.c          | 406 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/dma.c              |  22 +++-
  drivers/net/wireless/mediatek/mt76/mac80211.c         | 238 ++++++++++++++++++++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt76.h             | 152 ++++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7603/main.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c       |  14 +--
  drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  11 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |   8 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  45 ++++---
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  79 +++++++------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 ++--
  drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |   3 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/phy.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  21 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  24 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  26 ++---
  drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  79 +++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  34 +++++-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |   7 ++
  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   8 ++
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c       |  18 +--
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 138 ++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  30 ++++-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |   5 +
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   5 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  10 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7925/init.c      |  30 ++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |  28 ++---
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      | 130 ++++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       | 236 +++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |  23 ++++
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |  33 ++++--
  drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |  20 +++-
  drivers/net/wireless/mediatek/mt76/mt792x.h           |  23 +++-
  drivers/net/wireless/mediatek/mt76/mt792x_core.c      |  48 +++++++-
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   | 150 ++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    | 214 ++++++++++++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h    |   2 +
  drivers/net/wireless/mediatek/mt76/mt7996/init.c      | 408 ++++++++++++++++++++++++++++++++++++++++++---------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |  57 ++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      | 907 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 504 ++++++++++++++++++++++++++++++++++++++++++++----------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    | 177 +++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h      |  12 ++
  drivers/net/wireless/mediatek/mt76/scan.c             | 168 ++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c        |   4 +
  drivers/net/wireless/mediatek/mt76/tx.c               |  33 +++---
  drivers/net/wireless/mediatek/mt76/usb.c              |   4 +-
  drivers/net/wireless/mediatek/mt76/util.c             |  10 +-
  70 files changed, 3366 insertions(+), 1349 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/channel.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/scan.c

