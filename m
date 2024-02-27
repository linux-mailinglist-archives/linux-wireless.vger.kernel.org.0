Return-Path: <linux-wireless+bounces-4102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F358699B3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCDB293BA8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E31420B3;
	Tue, 27 Feb 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYgJLlCd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04E13B289
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046015; cv=none; b=h2x8yYTyhCGJgB/AyF6z6bqwm0JYxFeRAqdYUFRGKInOfcB+eECAvYFRdQee4JGHPQn5qa0U+7VtvoExFMGflV0pjoerciFSBTQ4HD0QZqmUKSdsCqZMU6soFT+2dgy1/aUZtm6aMy1kNES9flovkWmTxLRPfnBFoIkIM1ZucX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046015; c=relaxed/simple;
	bh=0eFhz9wKLYt3BihAM3byuyxBI7ESA18tm+Ud7SfRSVE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=eEzq1F3kqSAS4S6M7Cfzr2zhZ9ZPWEF4VA684tUsbXqUP7T4o97JR9d1bVEz3T5umSLZKS80cRpg/U+O6PRZGrjikQ9aSjimRuzOQd2U2M6XIBp8mLehTkZMV0LbfbzOPlSl4wlLxYpWhEf71WJhgPW+RctIh4Jkf7xmK7mPK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYgJLlCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC7C433C7;
	Tue, 27 Feb 2024 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709046014;
	bh=0eFhz9wKLYt3BihAM3byuyxBI7ESA18tm+Ud7SfRSVE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SYgJLlCd2JncO08xDBuePimIrFrBzuvTp9Dn+K5VRSRMnyx2CHvTvgVIlsLy2f5sO
	 1cIL1fNrMNFhuwgDgzWxzonvO78YNT3p87npVJRDpMtgCG8Jqt5ZBK5mxJfggX0mwo
	 BljQ5Q4M/qzfr6fnlW1zwvYYXiBLZt90UBNlqjJ1Rak9oao3F+QukQYJy+Ly3dxa+2
	 v3cf/Hz3artC/pQr+lHalEd5HOAYzDax7APygF3KAtEUuATZuM2Zq4KleiWAvqhBGY
	 mEHO/R0qdsrXcMpRpXQKUptFJBwZLqCxkCqvbwfeN+sdqRP+mPAO205j/AoJmFtwJ5
	 lF87biLUJ1jPw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: mt76 2024-02-22
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <d70f8729-9f84-4fe6-9291-3dd50fe4321c@nbd.name>
References: <d70f8729-9f84-4fe6-9291-3dd50fe4321c@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170904601257.3524945.7168982077183341464.kvalo@kernel.org>
Date: Tue, 27 Feb 2024 15:00:14 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first request for 6.9
> 
> - Felix
> 
> The following changes since commit f3ec643947634bed41b97bd56b248f7c78498eab:
> 
>    wifi: wilc1000: revert reset line logic flip (2024-02-21 20:56:45 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-02-22
> 
> for you to fetch changes up to 8fa556045696fffd78fe5c3386c6e77d5a368098:
> 
>    dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981 (2024-02-22 09:55:19 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.9
> 
> * fixes
> * support for newer chips in the mt7915 driver
> * mt7996 improvements
> * page pool performance improvement
> 
> ----------------------------------------------------------------
> Benjamin Lin (3):
>        wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
>        wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands
>        wifi: mt76: mt7996: fix HIF_TXD_V2_1 value
> 
> Colin Ian King (1):
>        wifi: mt76: Remove redundant assignment to variable tidno
> 
> Dacio Romero (1):
>        wifi: mt76: mt76x2u: add netgear wdna3100v3 to device table
> 
> Deren Wu (5):
>        wifi: mt76: mt792xu: enable dmashdl support
>        wifi: mt76: mt7925: update PCIe DMA settings
>        wifi: mt76: mt7925: support temperature sensor
>        wifi: mt76: mt7921e: fix use-after-free in free_irq()
>        wifi: mt76: mt7925e: fix use-after-free in free_irq()
> 
> Felix Fietkau (1):
>        wifi: mt76: mt7915: fix error recovery with WED enabled
> 
> Gen Xu (1):
>        wifi: mt76: mt792x: fix ethtool warning
> 
> Hao Zhang (1):
>        wifi: mt76: mt7925: fix mcu query command fail
> 
> Howard Hsu (1):
>        wifi: mt76: mt7996: fix HE beamformer phy cap for station vif
> 
> Leon Yen (1):
>        wifi: mt76: mt7921: fix a potential association failure upon resuming
> 
> Lorenzo Bianconi (5):
>        wifi: mt76: mt7996: fix fw loading timeout
>        wifi: mt76: usb: create a dedicated queue for psd traffic
>        wifi: mt76: usb: store usb endpoint in mt76_queue
>        wifi: mt76: move wed common utilities in wed.c
>        wifi: mt76: set page_pool napi pointer for mmio devices
> 
> Michael Lo (1):
>        wifi: mt76: mt7921: fix suspend issue on MediaTek COB platform
> 
> Michael-CY Lee (1):
>        wifi: mt76: mt7996: mark GCMP IGTK unsupported
> 
> Ming Yen Hsieh (13):
>        wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
>        wifi: mt76: mt7925: fix wmm queue mapping
>        wifi: mt76: mt7925: fix fw download fail
>        wifi: mt76: mt7925: fix WoW failed in encrypted mode
>        wifi: mt76: mt7925: fix the wrong header translation config
>        wifi: mt76: mt7925: add support to set ifs time by mcu command
>        wifi: mt76: mt7925: fix the wrong data type for scan command
>        wifi: mt76: mt792x: add the illegal value check for mtcl table of acpi
>        wifi: mt76: mt7921: fix incorrect type conversion for CLC command
>        wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz channel config from ACPI
>        wifi: mt76: mt792x: update the country list of EU for ACPI SAR
>        wifi: mt76: mt7921: fix the unfinished command of regd_notifier before suspend
>        wifi: mt76: fix the issue of missing txpwr settings from ch153 to ch177
> 
> Peter Chiu (8):
>        wifi: mt76: disable HW AMSDU when using fixed rate
>        wifi: mt76: check txs format before getting skb by pid
>        wifi: mt76: mt7915: update mt798x_wmac_adie_patch_7976
>        dt-bindings: net: wireless: mt76: add interrupts description for MT7986
>        wifi: mt76: mt7996: check txs format before getting skb by pid
>        wifi: mt76: mt7996: fix TWT issues
>        wifi: mt76: mt7996: disable AMSDU for non-data frames
>        wifi: mt76: mt7996: remove TXS queue setting
> 
> Quan Zhou (1):
>        wifi: mt76: mt7925: add flow to avoid chip bt function fail
> 
> Rafał Miłecki (1):
>        dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981
> 
> Shayne Chen (3):
>        wifi: mt76: mt7915: add locking for accessing mapped registers
>        wifi: mt76: mt7996: add locking for accessing mapped registers
>        wifi: mt76: connac: set correct muar_idx for mt799x chipsets
> 
> StanleyYP Wang (1):
>        wifi: mt76: mt7996: fix efuse reading issue
> 
> rong.yan (1):
>        wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band
> 
>   Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |  33 ++++++++--
>   drivers/net/wireless/mediatek/mt76/Makefile                       |   2 +-
>   drivers/net/wireless/mediatek/mt76/agg-rx.c                       |   2 +-
>   drivers/net/wireless/mediatek/mt76/dma.c                          | 106 ++----------------------------
>   drivers/net/wireless/mediatek/mt76/dma.h                          |   9 ++-
>   drivers/net/wireless/mediatek/mt76/mac80211.c                     |  26 +++-----
>   drivers/net/wireless/mediatek/mt76/mmio.c                         | 107 ------------------------------
>   drivers/net/wireless/mediatek/mt76/mt76.h                         |  61 +++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |   5 ++
>   drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h             |   5 ++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |   4 ++
>   drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c             |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                   |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |   9 +--
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |  55 +++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c                   |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |   6 ++
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  13 ++++
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  13 ++++
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |   2 +
>   drivers/net/wireless/mediatek/mt76/mt7925/init.c                  |  56 ++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/main.c                  |  26 +++++++-
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                   | 212 +++++++++++++++++++++++++++++++++++++++--------------------
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                   |  94 ++++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c                   |   3 +
>   drivers/net/wireless/mediatek/mt76/mt792x.h                       |   2 +
>   drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c              |  38 ++++++-----
>   drivers/net/wireless/mediatek/mt76/mt792x_core.c                  |   1 +
>   drivers/net/wireless/mediatek/mt76/mt792x_dma.c                   |  15 ++++-
>   drivers/net/wireless/mediatek/mt76/mt792x_regs.h                  |   8 +++
>   drivers/net/wireless/mediatek/mt76/mt792x_usb.c                   |  74 ++++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt7996/dma.c                   |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c                  |  12 ++--
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c                   |  81 +++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c                  |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   |  32 +++++----
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                   |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                  |  74 +++++++++++++--------
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                |   6 +-
>   drivers/net/wireless/mediatek/mt76/usb.c                          |  52 ++++++++-------
>   drivers/net/wireless/mediatek/mt76/wed.c                          | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   49 files changed, 977 insertions(+), 527 deletions(-)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/wed.c

Pulled, thanks.

734940143fbd Merge tag 'mt76-for-kvalo-2024-02-22' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d70f8729-9f84-4fe6-9291-3dd50fe4321c@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


