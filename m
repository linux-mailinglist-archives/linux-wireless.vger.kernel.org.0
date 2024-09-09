Return-Path: <linux-wireless+bounces-12688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F197213A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD41C22093
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84117C7BF;
	Mon,  9 Sep 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayrtnGS3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972017C9F9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903534; cv=none; b=J5qkqWFIiDaAH1hVeJ1i6kskqlvNN9LX65B9tT1MAo5tTtOlb9ne8FG1JmJMKr3CSrdn0T5uah7FdZ7P/7xw8VlbZbUzvF5k96UksVxxpt0BziAZYD43O/ouCJclyY6F1XJDGmYnodR/pgR3Fgv31KS38IM5VZ/gVqXmxf8i7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903534; c=relaxed/simple;
	bh=xfoDz5qKtIEpNoaCWSNXqIZ3ZclZWj2BssTRmUnU2I0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IKLmaxDTCnxGRrd/CL1WTTgpPd71m8Ce1AHdXbty+VV0h/BeYgXkzd7UJffUN7+zSt954C5jUBOuACIU2vYdPNG5Kxl0KXVUvTscue45hqpsMlNxodZJVPL4bejrNWZ6Sb95y6/Nc3N7nmuPOo/p1pP8dEhkGj/Nhc6mKNGaY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayrtnGS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19A0C4CEC5;
	Mon,  9 Sep 2024 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903533;
	bh=xfoDz5qKtIEpNoaCWSNXqIZ3ZclZWj2BssTRmUnU2I0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ayrtnGS3ksW5k5RfzJEKqiBXd/HB5yIxKgSykbRJmUsmAl1WQ5GV5LpcTMsXuLoGj
	 gJCaaVnOi6vFnfuiBCNhyELRQyFMORy/q8o9FCLoE/KeKZhsQTnoNDCl7TS9G7L3JJ
	 0/9xnq66lcl6n0yc6X6b6H3JDpBfAO48Mg8rdVr1qPh8hNPlKFBf8PPwnxs62GJunn
	 5fuWqy0dt/tnrNCt2kR1PhaNjq5BkOYRrMnnM3c4hSbhk60EOQ/VxgC0s9Mv9Z2qU5
	 tZQhPJmjYHw36FDvJovoB/ufjhW8NAnFkGiEWvKJD+K3F1NyjG7CEx6G8DJteiCFbB
	 N/DyrKSjPx/iA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: mt76 2024-09-06 v2
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <af5f43c3-915c-4db9-9b90-52f596a3de7e@nbd.name>
References: <af5f43c3-915c-4db9-9b90-52f596a3de7e@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172590353112.2257202.10003650493932392746.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 17:38:52 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> Here's an update for my pull request for 6.12. It fixes a compile
> error reported by the kernel test robot.
> 
> - Felix
> 
> The following changes since commit 43b7724487109368363bb5cda034b3f600278d14:
> 
>    Merge tag 'wireless-next-2024-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-09-04 17:20:14 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-09-06
> 
> for you to fetch changes up to 6bba05d651ef77f2c3f3c67b9ace093fee4e01e1:
> 
>    wifi: mt76: mt7925: replace chan config with extend txpower config for clc (2024-09-06 14:23:08 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.12
> 
> - fixes
> - mt7915 .sta_state support
> - mt7915 hardware restart improvements
> 
> ----------------------------------------------------------------
> Benjamin Lin (3):
>        wifi: mt76: connac: add IEEE 802.11 fragmentation support for mt7996
>        wifi: mt76: connac: add support for IEEE 802.11 fragmentation
>        wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation
> 
> Bjørn Mork (1):
>        wifi: mt76: mt7915: fix oops on non-dbdc mt7986
> 
> Chen Ni (1):
>        wifi: mt76: mt7925: convert comma to semicolon
> 
> Felix Fietkau (21):
>        wifi: mt76: mt7603: fix mixed declarations and code
>        wifi: mt76: mt7603: fix reading target power from eeprom
>        wifi: mt76: mt7603: initialize chainmask
>        wifi: mt76: fix mt76_get_rate
>        wifi: mt76: partially move channel change code to core
>        wifi: mt76: add separate tx scheduling queue for off-channel tx
>        wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
>        wifi: mt76: mt7915: allocate vif wcid in the same range as stations
>        wifi: mt76: connac: add support for passing connection state directly
>        wifi: mt76: change .sta_assoc callback to .sta_event
>        wifi: mt76: mt7915: use mac80211 .sta_state op
>        wifi: mt76: mt7915: set MT76_MCU_RESET early in mt7915_mac_full_reset
>        wifi: mt76: mt7915: retry mcu messages
>        wifi: mt76: mt7915: reset the device after MCU timeout
>        wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
>        wifi: mt76: connac: move mt7615_mcu_del_wtbl_all to connac
>        wifi: mt76: mt7915: improve hardware restart reliability
>        wifi: mt76: shrink mt76_queue_buf
>        wifi: mt76: mt7915: always query station rx rate from firmware
>        wifi: mt76: mt7996: fix uninitialized TLV data
>        wifi: mt76: mt7915: avoid long MCU command timeouts during SER
> 
> Gustavo A. R. Silva (1):
>        wifi: mt76: Avoid multiple -Wflex-array-member-not-at-end warnings
> 
> Howard Hsu (5):
>        wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
>        wifi: mt76: mt7996: set correct beamformee SS capability
>        wifi: mt76: mt7996: fix EHT beamforming capability check
>        wifi: mt76: mt7996: set correct value in beamforming mcu command for mt7992
>        wifi: mt76: mt7915: fix rx filter setting for bfee functionality
> 
> Ma Ke (4):
>        wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
>        wifi: mt76: mt7915: check devm_kasprintf() returned value
>        wifi: mt76: mt7921: Check devm_kasprintf() returned value
>        wifi: mt76: mt7615: check devm_kasprintf() returned value
> 
> Michael Lo (1):
>        wifi: mt76: mt7925: fix a potential association failure upon resuming
> 
> Michael-CY Lee (1):
>        wifi: mt76: mt7996: set IEEE80211_KEY_FLAG_GENERATE_MMIE for other ciphers
> 
> Ming Yen Hsieh (3):
>        wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
>        wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc
>        wifi: mt76: mt7925: replace chan config with extend txpower config for clc
> 
> Peter Chiu (5):
>        wifi: mt76: mt7996: use hweight16 to get correct tx antenna
>        wifi: mt76: mt7996: fix traffic delay when switching back to working channel
>        wifi: mt76: mt7996: fix wmm set of station interface to 3
>        wifi: mt76: mt7996: advertize beacon_int_min_gcd
>        wifi: mt76: connac: fix checksum offload fields of connac3 RXD
> 
> Rex Lu (1):
>        wifi: mt76: mt7996: fix handling mbss enable/disable
> 
>   drivers/net/wireless/mediatek/mt76/mac80211.c         |  66 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
>   drivers/net/wireless/mediatek/mt76/mcu.c              |  20 +++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76.h             |  25 ++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   4 ++--
>   drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c    |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   9 ++++++---
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  41 ++++++++++++++++----------------------
>   drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   5 +++--
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c      |   5 ++++-
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  27 +++++++------------------
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |  16 ++++-----------
>   drivers/net/wireless/mediatek/mt76/mt7615/mmio.c      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |   3 +--
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7615/testmode.c  |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h |   7 +++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |  11 +++++++++--
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  10 +++++++++-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  30 ++++++++++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  28 +++++++++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt76x0/main.c      |  21 +++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h    |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   5 +----
>   drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h    |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c  |  25 +++++++----------------
>   drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  |  25 +++++------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c      |   3 +++
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  37 +++++++++++++++++++++-------------
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c      | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  54 +++++++++++++++++++++++++++++++-------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   8 ++++----
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   6 ++++--
>   drivers/net/wireless/mediatek/mt76/mt7915/testmode.c  |   6 ++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   4 +++-
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  34 ++++++++++++++-----------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   5 +++--
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |   3 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   3 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   3 ++-
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |   5 ++---
>   drivers/net/wireless/mediatek/mt76/mt7925/main.c      |  36 ++++++++++++++++++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |  20 ++++++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |   5 +++--
>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |   4 +++-
>   drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt792x.h           |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c      |  89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |  17 ++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  37 ++++++++++++----------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       |  26 ++++++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
>   drivers/net/wireless/mediatek/mt76/tx.c               |  62 ++++++++++++++++++++++++++++++++++++---------------------
>   62 files changed, 624 insertions(+), 408 deletions(-)

Pulled, thanks.

abbd838c579e Merge tag 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/af5f43c3-915c-4db9-9b90-52f596a3de7e@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


