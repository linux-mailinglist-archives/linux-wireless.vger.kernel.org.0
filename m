Return-Path: <linux-wireless+bounces-658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AA80C92B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 13:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE52281E3E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2739862;
	Mon, 11 Dec 2023 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZAdEGocP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686B9B
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 04:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nAACNHelc3tMGEPpWRP36sdW7WPU1MWol1N4wKQgfCE=; b=ZAdEGocPSVAV6G7zT1m2yrPlmn
	CJq2jZOS3f48zJ+NL6VAtao4set3WJM62oggnq5DX4XmL2SkULrIvkgiGC2l9xDe34Xt/2Qnuqxw8
	0ystNd3eLnIGXGEzZsy9PZhheadvDyOMqQnCqSaYb8VHEpxKwmsGpuVMtlEmIZclnJkg=;
Received: from tmo-084-115.customers.d1-online.com ([80.187.84.115] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rCfAd-00BNI5-EE; Mon, 11 Dec 2023 13:13:59 +0100
Message-ID: <2de82252-7896-4fb7-9731-e5f0f9f1c724@nbd.name>
Date: Mon, 11 Dec 2023 13:13:58 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2023-12-06 v3
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
Content-Transfer-Encoding: 8bit

Hi Kalle,

here's another updated version of my first request for 6.8.
There was one more warning left to fix.

- Felix

The following changes since commit db7fac15eaf0f09d675730d7002edabe27fe9e1d:

   wifi: rtw89: mac: refine SER setting during WiFi CPU power on (2023-12-07 18:22:12 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-12-06

for you to fetch changes up to 10f2903147ed04784522ab841c20bb469bdd8681:

   wifi: mt76: mt7921: fix wrong 6Ghz power type (2023-12-11 13:11:53 +0100)

----------------------------------------------------------------
mt76 patches for 6.8

* fixes
* nvmem eeprom improvements
* mt7996 eht improvements
* mt7996 wed support
* mt7996 36-bit DMA support

----------------------------------------------------------------
Allen Ye (2):
       wifi: mt76: use chainmask for power delta calculation
       wifi: mt76: connac: add beacon protection support for mt7996

Arnd Bergmann (1):
       wifi: mt76: mt7996: fix mt7996_mcu_all_sta_info_event struct packing

Benjamin Lin (3):
       wifi: mt76: mt7996: switch to mcu command for TX GI report
       wifi: mt76: mt7996: add DMA support for mt7992
       wifi: mt76: connac: add new definition of tx descriptor

Bo Jiao (1):
       wifi: mt76: mt7996: add wed rx support

Christian Marangi (6):
       wifi: mt76: fix broken precal loading from MTD for mt7915
       wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
       wifi: mt76: limit support of precal loading for mt7915 to MTD only
       wifi: mt76: make mt76_get_of_eeprom static again
       wifi: mt76: permit to use alternative cell name to eeprom NVMEM load
       wifi: mt76: permit to load precal from NVMEM cell for mt7915

Howard Hsu (4):
       wifi: mt76: mt7996: add TX statistics for EHT mode in debugfs
       wifi: mt76: connac: add thermal protection support for mt7996
       wifi: mt76: mt7996: add thermal sensor device support
       wifi: mt76: connac: set fixed_bw bit in TX descriptor for fixed rate frames

Lorenzo Bianconi (13):
       wifi: mt76: mmio: move mt76_mmio_wed_{init,release}_rx_buf in common code
       wifi: mt76: move mt76_mmio_wed_offload_{enable,disable} in common code
       wifi: mt76: move mt76_net_setup_tc in common code
       wifi: mt76: introduce mt76_queue_is_wed_tx_free utility routine
       wifi: mt76: introduce wed pointer in mt76_queue
       wifi: mt76: increase MT_QFLAG_WED_TYPE size
       wifi: mt76: dma: introduce __mt76_dma_queue_reset utility routine
       wifi: mt76: mt7996: use u16 for val field in mt7996_mcu_set_rro signature
       wifi: mt76: move wed reset common code in mt76 module
       wifi: mt76: mt7996: add wed reset support
       wifi: mt76: mt7996: add wed rro delete session garbage collector
       wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource fails in mt7915_mmio_wed_init()
       wifi: mt76: mt7925: remove iftype from mt7925_init_eht_caps signature

MeiChia Chiu (2):
       wifi: mt76: mt7996: fix rate usage of inband discovery frames
       wifi: mt76: connac: fix EHT phy mode check

Ming Yen Hsieh (3):
       wifi: mt76: mt7921: fix country count limitation for CLC
       wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
       wifi: mt76: mt7921: fix wrong 6Ghz power type

Peter Chiu (4):
       wifi: mt76: mt7996: adjust WFDMA settings to improve performance
       wifi: mt76: mt7996: handle IEEE80211_RC_SMPS_CHANGED
       wifi: mt76: mt7996: align the format of fixed rate command
       wifi: mt76: mt7996: rework ampdu params setting

Rong Yan (1):
       wifi: mt76: mt7921: support 5.9/6GHz channel config in acpi

Ryder Lee (1):
       wifi: mt76: add ability to explicitly forbid LED registration with DT

Sean Wang (1):
       wifi: mt76: mt7921: reduce the size of MCU firmware download Rx queue

Shayne Chen (4):
       wifi: mt76: mt7996: add support for variants with auxiliary RX path
       wifi: mt76: change txpower init to per-phy
       wifi: mt76: mt7996: add txpower setting support
       wifi: mt76: mt7996: introduce mt7996_band_valid()

StanleyYP Wang (9):
       wifi: mt76: connac: add beacon duplicate TX mode support for mt7996
       wifi: mt76: mt7996: fix alignment of sta info event
       wifi: mt76: mt7915: fix EEPROM offset of TSSI flag on MT7981
       wifi: mt76: mt7915: also MT7981 is 3T3R but nss2 on 5 GHz band
       wifi: mt76: connac: add firmware support for mt7992
       wifi: mt76: mt7996: rework register offsets for mt7992
       wifi: mt76: mt7996: support mt7992 eeprom loading
       wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992
       wifi: mt76: mt7996: add PCI IDs for mt7992

Sujuan Chen (3):
       wifi: mt76: mt7996: add wed tx support
       wifi: mt76: mt7996: fix the size of struct bss_rate_tlv
       wifi: mt76: mt7996: set DMA mask to 36 bits for boards with more than 4GB of RAM

Uwe Kleine-König (1):
       wifi: mt76: Convert to platform remove callback returning void

Wang Zhao (1):
       wifi: mt76: mt7921s: fix workqueue problem causes STA association fail

Wu Yunchuan (1):
       wifi: mt76: Remove unnecessary (void*) conversions

Yi-Chia Hsieh (1):
       wifi: mt76: mt7996: fix uninitialized variable in parsing txfree

  drivers/net/wireless/mediatek/mt76/dma.c              | 258 +++++++++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/dma.h              |  54 +++++++
  drivers/net/wireless/mediatek/mt76/eeprom.c           |  22 +--
  drivers/net/wireless/mediatek/mt76/mac80211.c         |  60 +++++--
  drivers/net/wireless/mediatek/mt76/mmio.c             | 108 +++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76.h             | 105 +++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7603/soc.c       |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/soc.c       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   8 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |   7 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  29 +++-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |  46 ++----
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  30 ++--
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  21 +--
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      | 118 +-------------
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c       |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |  23 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  38 ++++-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  17 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c  |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x.h           |   6 +
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c  |  53 +++++++
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h  |   2 +
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c       | 398 ++++++++++++++++++++++++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    |  38 ++++-
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h    |   3 +
  drivers/net/wireless/mediatek/mt76/mt7996/init.c      | 520 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 219 +++++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  89 +++++++++--
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 642 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h       | 249 +++++++++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      | 295 ++++++++++++++++++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    | 160 +++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c       |  79 +++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h      | 182 +++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/sdio.c             |  18 ++-
  57 files changed, 3266 insertions(+), 743 deletions(-)

