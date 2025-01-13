Return-Path: <linux-wireless+bounces-17411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D52A0B4E0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 11:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E8E1886036
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513D8F49;
	Mon, 13 Jan 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="L9OaVdRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B121ADDB
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736765705; cv=none; b=W37HjbjaVe55Y3r+LPXqiI4QXsh3v+NrzOkZWs8xYqf8HhIu3QK/9ws77qZ0e3RT6LRC9ss0wHwdQXhSgkTO/45zsVRWHIPHFkm9n2syleihSmSzDPEZrAZ5s5h7YSntG6Xlyc4Sz0DJTwuYcpPvnd4eWpW8P+avA2U3PReeXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736765705; c=relaxed/simple;
	bh=jCCm8zbajQYgaZUxWBEzKydbpGBLj5zW8EXmD1BX+3U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RSBfKCmv56H3yZPVR03NtqKyEGsk+6J8+f/EpSa9PWgbcEihe72mn1BzMO0jeA/LHAug/s5qILsu7Ftibbg9p3dGnabnPY7ie4anVVEuA3zRt97ApIQ+AFN5AGv0ckAhM0j2Y5SfLes8Sa5MFMo3Aj8DljV27F5OnFj6PVOe2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=L9OaVdRP; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CrgozwObEA9JUzz0xVRYxCyWYV+DmK9QTz2yPRSkxys=; b=L9OaVdRPGOnUqvtAf2KuOUfGpx
	Iz3+hBxYReFpgWgs30I9K8RXOtkYVoxDp0D3h7cxGldPzkLy/Q7HB4iNWlXiuOUbKmDXrqoWbCLJB
	oxmcFl32yePJetfpkgccWn49IfVId+Hc0GPjhksXqSKiUQpSgs3Eu1XfW7D+c5zIkaqc=;
Received: from p54ae9a10.dip0.t-ipconnect.de ([84.174.154.16] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tXHay-005ypB-1R;
	Mon, 13 Jan 2025 11:22:56 +0100
Message-ID: <6c05b939-5649-4a07-91b2-81791ae0ad80@nbd.name>
Date: Mon, 13 Jan 2025 11:22:56 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2025-01-13
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

Here's my pull request for 6.14.

- Felix

The following changes since commit 8221712a174ad83e36489c414c26619010f4e348:

   wifi: brcmfmac: Add missing Return: to function documentation (2025-01-10 15:14:00 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2025-01-13

for you to fetch changes up to 4d915d0d5cf04c7e36127303fb74b325f47839c0:

   wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain (2025-01-13 11:22:01 +0100)

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

Leon Yen (4):
       wifi: mt76: mt7921s: fix a potential firmware freeze during startup
       wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
       wifi: mt76: mt7921: introduce CSA support
       wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain

Michael Lo (2):
       wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.
       wifi: mt76: mt7925: config the dwell time by firmware

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

Peter Chiu (2):
       wifi: mt76: mt7915: fix register mapping
       wifi: mt76: mt7996: fix register mapping

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
  drivers/net/wireless/mediatek/mt76/channel.c          | 378 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/dma.c              |  22 +++-
  drivers/net/wireless/mediatek/mt76/mac80211.c         | 235 ++++++++++++++++++++++++++-----------
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
  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  38 +++---
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  79 +++++++------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 ++--
  drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |   3 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/phy.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  21 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  22 +++-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  26 ++---
  drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  79 +++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  34 +++++-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |   7 ++
  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   8 ++
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c       |  18 +--
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 136 +++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  30 ++++-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |   5 +
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   5 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  10 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7925/init.c      |  30 ++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |  28 ++---
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      | 126 ++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       | 236 +++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |  23 ++++
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |  33 ++++--
  drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |  20 +++-
  drivers/net/wireless/mediatek/mt76/mt792x.h           |  23 +++-
  drivers/net/wireless/mediatek/mt76/mt792x_core.c      |  48 +++++++-
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   | 150 ++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    | 214 +++++++++++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h    |   2 +
  drivers/net/wireless/mediatek/mt76/mt7996/init.c      | 346 ++++++++++++++++++++++++++++++++++++------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |  52 ++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      | 909 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 356 ++++++++++++++++++++++++++++++-------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    | 171 ++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h      |  12 ++
  drivers/net/wireless/mediatek/mt76/scan.c             | 168 ++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c        |   4 +
  drivers/net/wireless/mediatek/mt76/tx.c               |  33 +++---
  drivers/net/wireless/mediatek/mt76/usb.c              |   4 +-
  drivers/net/wireless/mediatek/mt76/util.c             |  10 +-
  70 files changed, 3186 insertions(+), 1262 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/channel.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/scan.c

