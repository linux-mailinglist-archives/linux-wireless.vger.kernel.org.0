Return-Path: <linux-wireless+bounces-7139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5408BAABB
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30BB1C211B6
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31814F9E8;
	Fri,  3 May 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tygRSkFv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C314E2F2
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732182; cv=none; b=ABAtnihurQ3hq5fmm8EVRVtOdHNOOcAwuh8QJf3egJv7lMFuQvg13958LZmiZ69itgG+txAk99bxgDvnE23qtvY/KCsv6bMCLT/ledrDAJ77S6eEMO/qAtcck+GAKLGqsqwVOBrux/YWhpOtt+JPIfPFXFOiBRXIPl251XYXlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732182; c=relaxed/simple;
	bh=4tCkE7jnZxrS9Pxv4+wAAumijIsnT9J9Zo2ReTwHoys=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ntdV8FpUk+fpImp/E1Yps7bAmIFxifB8aawnNuO6iis0302kJqcqz3otPCo8sCjgdBJxn/cBf/w6ibiiyp3d4xBf68CG84lwD1fc+9rWeNN/XbC71gjpotFVsHU+z+dg1uhCAmm9+uLsbeqhqSDy54EsCiCm6oq4/9YidjekKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tygRSkFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1462EC116B1;
	Fri,  3 May 2024 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714732181;
	bh=4tCkE7jnZxrS9Pxv4+wAAumijIsnT9J9Zo2ReTwHoys=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=tygRSkFvNjDI0wToiQBMjAwachyqa5lXyRgGNuo6cdORIpdAGYqyJYP+4xUGOfpmV
	 cB+kv72n8MAF2Zewz2/EegS1kHu/CfXnHYolRGbCHIocfZaRk3Qs1Xrv9rCHx6aTOe
	 2Jz+sGlLBYLj8tkKDw6fuFMp7Qd67O9ogVYjYtfnVHx7P6nXAf2cgTrUQoMn+ogVlK
	 8NtaqPvfFVMEU7u697j5y7v8WqE2tSQtL/ifXRp4iXdE1euhdkVA8+DNfoqqQkSTMN
	 neH/kHqpQQnYmPYw69mOwablClkmBz73MeTKwGjAtywgT4CoI6Wyj7/1fQ5GEHjpWC
	 iaIaaHynVzsGw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2024-05-02
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <cca7fa77-17d0-46ff-98e3-db8b7cd8505c@nbd.name>
References: <cca7fa77-17d0-46ff-98e3-db8b7cd8505c@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171473217902.1244166.14622795930388987247.kvalo@kernel.org>
Date: Fri,  3 May 2024 10:29:40 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first request for 6.10
> 
> - Felix
> 
> The following changes since commit 8886b6d681f28d838cb30ace8ce73f8b96bc927d:
> 
>    wifi: qtnfmac: Remove generic .ndo_get_stats64 (2024-05-02 10:20:04 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-05-02
> 
> for you to fetch changes up to 59f4c57306bae62f66356556cfbdd40444683c09:
> 
>    wifi: mt76: enable spectrum management (2024-05-02 12:47:05 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.10
> 
> - fixes
> - mt7603 stability improvements
> - mt7921 LED control
> - mt7925 EHT radiotap support
> 
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>        wifi: mt76: mt7915: Remove unused of_gpio.h
> 
> Ben Greear (1):
>        wifi: mt76: mt7915: add missing chanctx ops
> 
> Bo Jiao (1):
>        wifi: mt76: mt7915: only set MT76_MCU_RESET for the main phy
> 
> Chad Monroe (1):
>        wifi: mt76: mt7996: fix size of txpower MCU command
> 
> Deren Wu (2):
>        wifi: mt76: mt7921: introduce mt7920 PCIe support
>        wifi: mt76: mt7925: add EHT radiotap support in monitor mode
> 
> Felix Fietkau (10):
>        wifi: mt76: mt7915: initialize rssi on adding stations
>        wifi: mt76: replace skb_put with skb_put_zero
>        wifi: mt76: fix tx packet loss when scanning on DBDC
>        wifi: mt76: mt7996: only set MT76_MCU_RESET for the main phy
>        wifi: mt76: mt7915: add fallback in case of missing precal data
>        wifi: mt76: mt7603: fix tx queue of loopback packets
>        wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset
>        wifi: mt76: connac: use muar idx 0xe for non-mt799x as well
>        wifi: mt76: make const arrays in functions static
>        wifi: mt76: enable spectrum management
> 
> Hao Zhang (1):
>        wifi: mt76: mt7921e: add LED control support
> 
> Henry Yen (2):
>        wifi: mt76: mt7915: fix bogus Tx/Rx airtime duration values
>        wifi: mt76: mt7996: fix non-main BSS no beacon issue for MBSS scenario
> 
> Howard Hsu (4):
>        wifi: mt76: mt7915: fix HE PHY capabilities IE for station mode
>        wifi: mt76: connac: enable HW CSO module for mt7996
>        wifi: mt76: mt7996: fix potential memory leakage when reading chip temperature
>        wifi: mt76: connac: enable critical packet mode support for mt7992
> 
> Leon Yen (1):
>        wifi: mt76: mt7921s: fix potential hung tasks during chip recovery
> 
> Lorenzo Bianconi (2):
>        wifi: mt76: mt7996: fix uninitialized variable in mt7996_irq_tasklet()
>        wifi: mt76: sdio: move mcu queue size check inside critical section
> 
> MeiChia Chiu (1):
>        wifi: mt76: mt7915: add support for disabling in-band discovery
> 
> Michael-CY Lee (1):
>        wifi: mt76: mt7996: let upper layer handle MGMT frame protection
> 
> Ming Yen Hsieh (1):
>        wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command
> 
> Muhammad Usama Anjum (1):
>        wifi: mt76: connac: check for null before dereferencing
> 
> Peter Chiu (3):
>        wifi: mt76: mt7915: fix mcu command format for mt7915 tx stats
>        wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration
>        wifi: mt76: mt7996: set RCPI value in rate control command
> 
> Rong Yan (1):
>        wifi: mt76: mt7921: cqm rssi low/high event notify
> 
> Shayne Chen (2):
>        wifi: mt76: mt7996: disable rx header translation for BMC entry
>        wifi: mt76: connac: use peer address for station BMC entry
> 
> StanleyYP Wang (1):
>        wifi: mt76: mt7996: add sanity checks for background radar trigger
> 
>   drivers/net/wireless/mediatek/mt76/dma.c              |   5 +++--
>   drivers/net/wireless/mediatek/mt76/mac80211.c         |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76.h             |   4 ++--
>   drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |  46 ++++++++++++++++++++++++++++-------------
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h      |  10 ++++++++-
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c |  85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |  22 ++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  22 +++++++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  15 ++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  29 ++++++++++++++------------
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |  47 +++++++++++++++++++++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  10 ++++++---
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  15 +++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  10 ++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   4 ++++
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c       |   1 -
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c       |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  32 ++++++++++++++++++++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   6 ++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  19 ++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c   |   2 --
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c  |   2 --
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |  15 ++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |   4 ++--
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt792x.h           |   7 +++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   |   5 +++++
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |   8 ++------
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  34 ++++++++++++++++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       |  69 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |   4 +++-
>   drivers/net/wireless/mediatek/mt76/sdio.c             |  17 ++++++++++------
>   drivers/net/wireless/mediatek/mt76/testmode.c         |   2 +-
>   drivers/net/wireless/mediatek/mt76/tx.c               |   2 +-
>   drivers/net/wireless/mediatek/mt76/usb.c              |   3 ++-
>   39 files changed, 656 insertions(+), 145 deletions(-)

Pulled, thanks.

d08aeb97cea7 Merge tag 'mt76-for-kvalo-2024-05-02' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/cca7fa77-17d0-46ff-98e3-db8b7cd8505c@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


