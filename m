Return-Path: <linux-wireless+bounces-698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E37880EF9B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33A528122A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72008745F0;
	Tue, 12 Dec 2023 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9JXi+V9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F2745E0
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 15:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A4FC433C7;
	Tue, 12 Dec 2023 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702393582;
	bh=pa9u8jcFRZdDizdWzItVU0IsNHbYo2jNpqF4wwfw5wA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b9JXi+V9x5WFJJt3j/mietfNLpBCpUA2XB3cncYplko76rsFa8DnlQCJ8UEh1xrkK
	 yDTr6/zfWBJnQ2+djF8e0y10p9fW1f7GVqFyDFUa9So2vjEZU4c3NMrIm8rrmDlFHE
	 +WwA38S+I2aVNDhaZyUAQvfyjzbP10vc1UEkg11pVwNkZ3k6KMX2vEUfTGMd1SlOCU
	 wQ+4VhvFK3RBUA/Wb1V6yoADi5EoUCJceXS4vZL5VbEKreN8sV3H+eru1PUUoKeBn9
	 g4/LaFmcYfHMBunudOgEgVpW0Sz2jy5bh4ldny3obTFNNrhdf2VjYLJZoCEkRUTcOO
	 4mRR8eOzdkcfw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: mt76 2023-12-06 v3
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <2de82252-7896-4fb7-9731-e5f0f9f1c724@nbd.name>
References: <2de82252-7896-4fb7-9731-e5f0f9f1c724@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239358013.306086.15182232057820419277.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 15:06:22 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's another updated version of my first request for 6.8.
> There was one more warning left to fix.
> 
> - Felix
> 
> The following changes since commit db7fac15eaf0f09d675730d7002edabe27fe9e1d:
> 
>    wifi: rtw89: mac: refine SER setting during WiFi CPU power on (2023-12-07 18:22:12 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-12-06
> 
> for you to fetch changes up to 10f2903147ed04784522ab841c20bb469bdd8681:
> 
>    wifi: mt76: mt7921: fix wrong 6Ghz power type (2023-12-11 13:11:53 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.8
> 
> * fixes
> * nvmem eeprom improvements
> * mt7996 eht improvements
> * mt7996 wed support
> * mt7996 36-bit DMA support
> 
> ----------------------------------------------------------------
> Allen Ye (2):
>        wifi: mt76: use chainmask for power delta calculation
>        wifi: mt76: connac: add beacon protection support for mt7996
> 
> Arnd Bergmann (1):
>        wifi: mt76: mt7996: fix mt7996_mcu_all_sta_info_event struct packing
> 
> Benjamin Lin (3):
>        wifi: mt76: mt7996: switch to mcu command for TX GI report
>        wifi: mt76: mt7996: add DMA support for mt7992
>        wifi: mt76: connac: add new definition of tx descriptor
> 
> Bo Jiao (1):
>        wifi: mt76: mt7996: add wed rx support
> 
> Christian Marangi (6):
>        wifi: mt76: fix broken precal loading from MTD for mt7915
>        wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
>        wifi: mt76: limit support of precal loading for mt7915 to MTD only
>        wifi: mt76: make mt76_get_of_eeprom static again
>        wifi: mt76: permit to use alternative cell name to eeprom NVMEM load
>        wifi: mt76: permit to load precal from NVMEM cell for mt7915
> 
> Howard Hsu (4):
>        wifi: mt76: mt7996: add TX statistics for EHT mode in debugfs
>        wifi: mt76: connac: add thermal protection support for mt7996
>        wifi: mt76: mt7996: add thermal sensor device support
>        wifi: mt76: connac: set fixed_bw bit in TX descriptor for fixed rate frames
> 
> Lorenzo Bianconi (13):
>        wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common code
>        wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
>        wifi: mt76: move mt76_net_setup_tc in common code
>        wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
>        wifi: mt76: introduce wed pointer in mt76_queue
>        wifi: mt76: increase MT_QFLAG_WED_TYPE size
>        wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
>        wifi: mt76: mt7996: use u16 for val field in mt7996_mcu_set_rro signature
>        wifi: mt76: move wed reset common code in mt76 module
>        wifi: mt76: mt7996: add wed reset support
>        wifi: mt76: mt7996: add wed rro delete session garbage collector
>        wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource fails in mt7915_mmio_wed_init()
>        wifi: mt76: mt7925: remove iftype from mt7925_init_eht_caps signature
> 
> MeiChia Chiu (2):
>        wifi: mt76: mt7996: fix rate usage of inband discovery frames
>        wifi: mt76: connac: fix EHT phy mode check
> 
> Ming Yen Hsieh (3):
>        wifi: mt76: mt7921: fix country count limitation for CLC
>        wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
>        wifi: mt76: mt7921: fix wrong 6Ghz power type
> 
> Peter Chiu (4):
>        wifi: mt76: mt7996: adjust WFDMA settings to improve performance
>        wifi: mt76: mt7996: handle IEEE80211_RC_SMPS_CHANGED
>        wifi: mt76: mt7996: align the format of fixed rate command
>        wifi: mt76: mt7996: rework ampdu params setting
> 
> Rong Yan (1):
>        wifi: mt76: mt7921: support 5.9/6GHz channel config in acpi
> 
> Ryder Lee (1):
>        wifi: mt76: add ability to explicitly forbid LED registration with DT
> 
> Sean Wang (1):
>        wifi: mt76: mt7921: reduce the size of MCU firmware download Rx queue
> 
> Shayne Chen (4):
>        wifi: mt76: mt7996: add support for variants with auxiliary RX path
>        wifi: mt76: change txpower init to per-phy
>        wifi: mt76: mt7996: add txpower setting support
>        wifi: mt76: mt7996: introduce mt7996_band_valid()
> 
> StanleyYP Wang (9):
>        wifi: mt76: connac: add beacon duplicate TX mode support for mt7996
>        wifi: mt76: mt7996: fix alignment of sta info event
>        wifi: mt76: mt7915: fix EEPROM offset of TSSI flag on MT7981
>        wifi: mt76: mt7915: also MT7981 is 3T3R but nss2 on 5 GHz band
>        wifi: mt76: connac: add firmware support for mt7992
>        wifi: mt76: mt7996: rework register offsets for mt7992
>        wifi: mt76: mt7996: support mt7992 eeprom loading
>        wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992
>        wifi: mt76: mt7996: add PCI IDs for mt7992
> 
> Sujuan Chen (3):
>        wifi: mt76: mt7996: add wed tx support
>        wifi: mt76: mt7996: fix the size of struct bss_rate_tlv
>        wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM
> 
> Uwe Kleine-König (1):
>        wifi: mt76: Convert to platform remove callback returning void
> 
> Wang Zhao (1):
>        wifi: mt76: mt7921s: fix workqueue problem causes STA association fail
> 
> Wu Yunchuan (1):
>        wifi: mt76: Remove unnecessary (void*) conversions
> 
> Yi-Chia Hsieh (1):
>        wifi: mt76: mt7996: fix uninitialized variable in parsing txfree
> 
>   drivers/net/wireless/mediatek/mt76/dma.c              | 258 +++++++++++++++++++++---------
>   drivers/net/wireless/mediatek/mt76/dma.h              |  54 +++++++
>   drivers/net/wireless/mediatek/mt76/eeprom.c           |  22 +--
>   drivers/net/wireless/mediatek/mt76/mac80211.c         |  60 +++++--
>   drivers/net/wireless/mediatek/mt76/mmio.c             | 108 +++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76.h             | 105 +++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   9 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/soc.c       |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/soc.c       |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   8 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  29 +++-
>   drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |  46 ++----
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  30 ++--
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  21 +--
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      | 118 +-------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c       |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c      |  23 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  38 ++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  17 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c  |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/main.c      |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt792x.h           |   6 +
>   drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c  |  53 +++++++
>   drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h  |   2 +
>   drivers/net/wireless/mediatek/mt76/mt792x_mac.c       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/dma.c       | 398 ++++++++++++++++++++++++++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    |  38 ++++-
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h    |   3 +
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c      | 520 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 219 +++++++++++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  89 +++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 642 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.h       | 249 +++++++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      | 295 ++++++++++++++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    | 160 +++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7996/pci.c       |  79 +++++++---
>   drivers/net/wireless/mediatek/mt76/mt7996/regs.h      | 182 +++++++++++++++++----
>   drivers/net/wireless/mediatek/mt76/sdio.c             |  18 ++-
>   57 files changed, 3266 insertions(+), 743 deletions(-)

Pulled, thanks.

379872288fd3 Merge tag 'mt76-for-kvalo-2023-12-06' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2de82252-7896-4fb7-9731-e5f0f9f1c724@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


