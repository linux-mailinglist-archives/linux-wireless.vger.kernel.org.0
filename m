Return-Path: <linux-wireless+bounces-17557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A2A12746
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D3B7A22A8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2378145B3E;
	Wed, 15 Jan 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKE48Sh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11D24A7DF
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954523; cv=none; b=fbRXNWyMPffgobOqU1/z3oQBuHZIrnAiJWMyHlBk6ngR82xBm/RR3ttvj+sc8shkfZBL3ObUkVJPJ7/sdhycWi8YCBlVUiJvFBe+DO/D8BQ/pvCU+zT6wAFTjeXtCYqGbZFJ1DdZqyPuj8cL5Ixq/sj7ElX1EBdi5Obk/gfRyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954523; c=relaxed/simple;
	bh=ojr+wHHFlQGAfLraomMD0ZKzzyq2EKrLk1vLtSQpH/E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ZB2RarPh73mUnmTLPjQBhOC2o5i2UmVtdtKM9epXk0Lvg+g8bBqH8UaRUZY6Qqrh+jFJyFYjr34OaWoDBfe3Dq7kIgz+ZARA0FPx8iQttpt65jApngTfrbC3TB7uy3KwmQ7HwpEDvfUFsFVAObTM9PhZylru8POLSz4nsl5W2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKE48Sh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7054FC4CED1;
	Wed, 15 Jan 2025 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736954523;
	bh=ojr+wHHFlQGAfLraomMD0ZKzzyq2EKrLk1vLtSQpH/E=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IKE48Sh3rZ2o0tZs7V4t1WfA2TSiu/w6YFB1f/mEJoHlBseWXxJsE6z/Hiau++tYg
	 uzsLI2o//Aq7fPoH6do+As/nrXP68EozQptvw34JbEIbt7FOgKeHs06M6YW+fWlDYd
	 wEMKjqC7WId4Jfie/f6FZPda9yoWtKxsG3aqJxFstT8lva6IEYyHsKTmxLYAYbzefx
	 HTCpe25kT9K/JIm+qTgMQWBIL2Cs7VWm1MjM+EsjRoOp/f8sLfBOaz/LzU9jXY4SsO
	 wLzIwYIXtA8wJPG4HUjdrM/UXZw4SbsfnA+oQSkxYHTbvfIlI368f5qa3pgnG+uAlV
	 jjxEqtSIgTR+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2025-01-14
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <c8b5e95a-fcae-47e2-b48a-236b62d6ca04@nbd.name>
References: <c8b5e95a-fcae-47e2-b48a-236b62d6ca04@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173695452061.512722.5709138048540674501.kvalo@kernel.org>
Date: Wed, 15 Jan 2025 15:22:02 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> Here's another updated version of my pull request for 6.14.
> It fixes a chanctx related regression and adds more mt7996 fixes.
> 
> - Felix
> 
> The following changes since commit 8221712a174ad83e36489c414c26619010f4e348:
> 
>    wifi: brcmfmac: Add missing Return: to function documentation (2025-01-10 15:14:00 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2025-01-14
> 
> for you to fetch changes up to ad4c9a8a980336450631dce8cc0799f9a8de1914:
> 
>    wifi: mt76: mt7996: add implicit beamforming support for mt7992 (2025-01-14 13:42:30 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.14
> 
> - mlo fixes for mt792x
> - single wiphy multiband support for mt7996
> - mt7915 stability fixes
> 
> ----------------------------------------------------------------
> Allan Wang (2):
>        wifi: mt76: introduce mt792x_config_mac_addr_list routine
>        wifi: mt76: mt7921: add rfkill_poll for hardware rfkill
> 
> Ben Greear (2):
>        wifi: mt76: mt7996: Add eht radiotap tlv
>        wifi: mt76: Fix EHT NSS radiotap reporting.
> 
> Benjamin Lin (2):
>        wifi: mt76: mt7996: fix incorrect indexing of MIB FW event
>        wifi: mt76: mt7996: fix definition of tx descriptor
> 
> Chad Monroe (2):
>        wifi: mt76: mt7915: exclude tx backoff time from airtime
>        wifi: mt76: mt7996: exclude tx backoff time from airtime
> 
> Charles Han (1):
>        wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links
> 
> Christophe JAILLET (1):
>        wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()
> 
> Dan Carpenter (1):
>        wifi: mt76: mt7925: fix off by one in mt7925_load_clc()
> 
> Eric-SY Chang (1):
>        wifi: mt76: mt7925: fix wrong band_idx setting when enable sniffer mode
> 
> Felix Fietkau (37):
>        wifi: mt76: remove mt76_calculate_default_rate()
>        wifi: mt76: mt7996: remove phy->monitor_vif
>        wifi: mt76: mt7915: fix slot time for 5/6GHz
>        wifi: mt76: mt7915: fix eifs value on older chipsets
>        wifi: mt76: mt7996: fix rx filter setting for bfee functionality
>        wifi: mt76: mt7915: reduce the number of command retries
>        wifi: mt76: mt7915: decrease timeout for commonly issued MCU commands
>        wifi: mt76: only enable tx worker after setting the channel
>        wifi: mt76: mt7915: ensure that only one sta entry is active per mac address
>        wifi: mt76: mt7915: hold dev->mutex while interacting with the thermal state
>        wifi: mt76: mt7915: firmware restart on devices with a second pcie link
>        wifi: mt76: mt7915: fix omac index assignment after hardware reset
>        wifi: mt76: mt7996: use mac80211 .sta_state op
>        wifi: mt76: do not add wcid entries to sta poll list during MCU reset
>        wifi: mt76: add code for emulating hardware scanning
>        wifi: mt76: add support for allocating a phy without hw
>        wifi: mt76: rename struct mt76_vif to mt76_vif_link
>        wifi: mt76: add vif link specific data structure
>        wifi: mt76: mt7996: split link specific data from struct mt7996_vif
>        wifi: mt76: initialize more wcid fields mt76_wcid_init
>        wifi: mt76: add chanctx functions for multi-channel phy support
>        wifi: mt76: remove dev->wcid_phy_mask
>        wifi: mt76: add multi-radio support to a few core hw ops
>        wifi: mt76: add multi-radio support to tx scheduling
>        wifi: mt76: add multi-radio support to scanning code
>        wifi: mt76: add multi-radio remain_on_channel functions
>        wifi: mt76: mt7996: use emulated hardware scan support
>        wifi: mt76: mt7996: pass wcid to mt7996_mcu_sta_hdr_trans_tlv
>        wifi: mt76: mt7996: prepare mt7996_mcu_add_dev/bss_info for MLO support
>        wifi: mt76: mt7996: prepare mt7996_mcu_add_beacon for MLO support
>        wifi: mt76: mt7996: prepare mt7996_mcu_set_tx for MLO support
>        wifi: mt76: mt7996: prepare mt7996_mcu_set_timing for MLO support
>        wifi: mt76: connac: prepare mt76_connac_mcu_sta_basic_tlv for MLO support
>        wifi: mt76: mt7996: prepare mt7996_mcu_update_bss_color for MLO support
>        wifi: mt76: mt7996: move all debugfs files to the primary phy
>        wifi: mt76: mt7996: switch to single multi-radio wiphy
>        wifi: mt76: mt7996: fix monitor mode
> 
> Hao Zhang (1):
>        wifi: mt76: mt792x: add P2P_DEVICE support
> 
> Howard Hsu (4):
>        wifi: mt76: mt7996: fix the capability of reception of EHT MU PPDU
>        wifi: mt76: mt7996: fix HE Phy capability
>        wifi: mt76: connac: adjust phy capabilities based on band constraints
>        wifi: mt76: mt7996: add implicit beamforming support for mt7992
> 
> Leon Yen (4):
>        wifi: mt76: mt7921s: fix a potential firmware freeze during startup
>        wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
>        wifi: mt76: mt7921: introduce CSA support
>        wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain
> 
> Michael Lo (2):
>        wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.
>        wifi: mt76: mt7925: config the dwell time by firmware
> 
> Michael-CY Lee (1):
>        wifi: mt76: mt7996: fix beacon command during disabling
> 
> Ming Yen Hsieh (15):
>        wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
>        wifi: mt76: mt7925: fix the invalid ip address for arp offload
>        wifi: mt76: mt7925: Fix incorrect MLD address in bss_mld_tlv for MLO support
>        wifi: mt76: mt7925: Fix incorrect WCID assignment for MLO
>        wifi: mt76: mt7925: fix wrong parameter for related cmd of chan info
>        wifi: mt76: mt7925: Enhance mt7925_mac_link_bss_add to support MLO
>        wifi: mt76: Enhance mt7925_mac_link_sta_add to support MLO
>        wifi: mt76: mt7925: Update mt7925_mcu_sta_update for BC in ASSOC state
>        wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
>        wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
>        wifi: mt76: mt7925: Update secondary link PS flow
>        wifi: mt76: mt7925: Init secondary link PM state
>        wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO
>        wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
>        wifi: mt76: mt7925: Properly handle responses for commands with events
> 
> Nick Morrow (1):
>        wifi: mt76: mt7921u: Add VID/PID for TP-Link TXE50UH
> 
> Nicolas Cavallari (1):
>        wifi: mt76: mt7915: Fix mesh scan on MT7916 DBDC
> 
> Peter Chiu (4):
>        wifi: mt76: mt7915: fix register mapping
>        wifi: mt76: mt7996: fix register mapping
>        wifi: mt76: mt7996: add max mpdu len capability
>        wifi: mt76: mt7996: fix ldpc setting
> 
> Quan Zhou (6):
>        wifi: mt76: mt7921: fix a potential scan no APs
>        wifi: mt76: do not hold queue lock during initial rx buffer alloc
>        wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
>        wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
>        wifi: mt76: mt7925: add handler to hif suspend/resume event
>        wifi: mt76: mt7925e: fix too long of wifi resume time
> 
> Sean Wang (1):
>        wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO
> 
> Shayne Chen (4):
>        wifi: mt76: mt7996: extend flexibility of mt7996_mcu_get_eeprom()
>        wifi: mt76: mt7996: add support for more variants
>        wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916
>        wifi: mt76: connac: rework connac helpers
> 
> Shen Lichuan (1):
>        wifi: mt76: mt7615: Convert comma to semicolon
> 
> StanleyYP Wang (1):
>        wifi: mt76: mt7996: set correct background radar capability
> 
> WangYuli (1):
>        wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
> 
> Zhang Kunbo (1):
>        wifi: mt76: mt7925: replace zero-length array with flexible-array member
> 
> allan.wang (1):
>        wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment
> 
> xueqin Luo (2):
>        wifi: mt76: mt7996: fix overflows seen when writing limit attributes
>        wifi: mt76: mt7915: fix overflows seen when writing limit attributes
> 
>   drivers/net/wireless/mediatek/mt76/Makefile           |   2 +-
>   drivers/net/wireless/mediatek/mt76/channel.c          | 406 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/dma.c              |  22 +++-
>   drivers/net/wireless/mediatek/mt76/mac80211.c         | 238 ++++++++++++++++++++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt76.h             | 152 ++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   9 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c      |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.c       |  14 +--
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  11 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |   8 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c   |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c   |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  45 ++++---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  79 +++++++------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 ++--
>   drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt76x2/phy.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  21 +++-
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  24 +++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  26 ++---
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  79 +++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  34 +++++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |   7 ++
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   8 ++
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c       |  18 +--
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 138 ++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  30 ++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |   5 +
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   5 +
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  10 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/init.c      |  30 ++++-
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |  28 ++---
>   drivers/net/wireless/mediatek/mt76/mt7925/main.c      | 130 ++++++++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       | 236 +++++++++++++++++++++++++------------
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |  23 ++++
>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |  33 ++++--
>   drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |  20 +++-
>   drivers/net/wireless/mediatek/mt76/mt792x.h           |  23 +++-
>   drivers/net/wireless/mediatek/mt76/mt792x_core.c      |  48 +++++++-
>   drivers/net/wireless/mediatek/mt76/mt792x_mac.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   | 150 ++++++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    | 214 ++++++++++++++++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h    |   2 +
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c      | 408 ++++++++++++++++++++++++++++++++++++++++++---------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |  57 ++++-----
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c      | 907 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 504 ++++++++++++++++++++++++++++++++++++++++++++----------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    | 177 +++++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7996/regs.h      |  12 ++
>   drivers/net/wireless/mediatek/mt76/scan.c             | 168 ++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/sdio_txrx.c        |   4 +
>   drivers/net/wireless/mediatek/mt76/tx.c               |  33 +++---
>   drivers/net/wireless/mediatek/mt76/usb.c              |   4 +-
>   drivers/net/wireless/mediatek/mt76/util.c             |  10 +-
>   70 files changed, 3366 insertions(+), 1349 deletions(-)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/channel.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/scan.c

Pulled, thanks.

48b5bccf4d56 Merge tag 'mt76-for-kvalo-2025-01-14' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c8b5e95a-fcae-47e2-b48a-236b62d6ca04@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


