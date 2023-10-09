Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBEF7BD390
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 08:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjJIGg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 02:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjJIGgz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 02:36:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D3A3
        for <linux-wireless@vger.kernel.org>; Sun,  8 Oct 2023 23:36:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6D3C433C8;
        Mon,  9 Oct 2023 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696833413;
        bh=oBOlYhoa5cs9KicNc2d6tgcf7t47W5pda+evHA5NzYQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=L8fm0tz0MSE5kFg41ugwXGIwGPyKO9K+lVlEzKc6JkEho3Z0VlR6yfaxf3heXiXtv
         gkWoPVAG1FU/jU1Kb4Gh2r5ylkZgR5qMFSxuvXKblWYLf5TFgnF5hRtfgpYBHrygj/
         vlgL0ncMKbPEJ0LvFYfznI1s/FZtHEKkpgL/6JggZhlwS6IPknMJXNEzrr/nc+q3lC
         5CkA8pZA+vBJvasaXb2s8bPsWwuQErXY+VjLOlqOIuR+Stk1Fb2V03nwe62ndoV4SB
         Hrk7rNaxlo9p31iho2Jvk9XUG4JjPOs2G7Gal4iAQgPZ7UX+QaL1zZSieZHnfXT2Gx
         QmHD+oqCARE2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2023-09-30
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <a5a2baaa-0db4-403e-9ebd-a7ff089675b4@nbd.name>
References: <a5a2baaa-0db4-403e-9ebd-a7ff089675b4@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169683341028.1982716.2423233333583552254.kvalo@kernel.org>
Date:   Mon,  9 Oct 2023 06:36:52 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first request for 6.7
> 
> - Felix
> 
> The following changes since commit aa75cc029e053627743fba2cde8a73519abe8421:
> 
>    wifi: mac80211: add back SPDX identifier (2023-09-29 23:21:33 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-09-30
> 
> for you to fetch changes up to bd94d501c0c99753497f8396e96738a560bac10e:
> 
>    wifi: mt76: Annotate struct mt76_rx_tid with __counted_by (2023-09-30 20:19:43 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.7
> 
> * mt7603/mt7628 stability improvements
> * fixes
> * new driver for mt7925
> 
> ----------------------------------------------------------------
> Allen Ye (1):
>        wifi: mt76: check sta rx control frame to multibss capability
> 
> Benjamin Lin (1):
>        wifi: mt76: mt7996: remove periodic MPDU TXS request
> 
> Bo Jiao (1):
>        wifi: mt76: fix potential memory leak of beacon commands
> 
> Chank Chen (1):
>        wifi: mt76: connac: add MBSSID support for mt7996
> 
> Deren Wu (10):
>        wifi: mt76: connac: introduce helper for mt7925 chipset
>        wifi: mt76: mt792x: support mt7925 chip init
>        wifi: mt76: connac: export functions for mt7925
>        wifi: mt76: connac: add eht support for phy mode config
>        wifi: mt76: connac: add eht support for tx power
>        wifi: mt76: connac: add data field in struct tlv
>        wifi: mt76: connac: add more unified command IDs
>        wifi: mt76: connac: add more unified event IDs
>        wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips
>        wifi: mt76: mt7921: move connac nic capability handling to mt7921
> 
> Dmitry Antipov (2):
>        wifi: mt76: add DMA mapping error check in mt76_alloc_txwi()
>        wifi: mt76: fix clang-specific fortify warnings
> 
> Felix Fietkau (9):
>        wifi: mt76: mt7603: rework/fix rx pse hang check
>        wifi: mt76: mt7603: improve watchdog reset reliablity
>        wifi: mt76: mt7603: improve stuck beacon handling
>        wifi: mt76: mt7603: add missing register initialization for MT7628
>        wifi: mt76: mt7603: disable A-MSDU tx support on MT7628
>        wifi: mt76: fix race condition related to checking tx queue fill status
>        wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb
>        wifi: mt76: mt7915: fix monitor mode issues
>        wifi: mt76: mt7915 add tc offloading support
> 
> Howard Hsu (3):
>        wifi: mt76: mt7996: fix beamform mcu cmd configuration
>        wifi: mt76: mt7996: fix beamformee ss subfield in EHT PHY cap
>        wifi: mt76: mt7996: support more options for mt7996_set_bitrate_mask()
> 
> Ingo Rohloff (1):
>        wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi Redmibook 15 Pro (2023)
> 
> Jen-Hao Cheng (1):
>        wifi: mt76: mt7996: support per-band LED control
> 
> Jinjie Ruan (2):
>        wifi: mt76: Use PTR_ERR_OR_ZERO() to simplify code
>        wifi: mt76: Drop unnecessary error check for debugfs_create_dir()
> 
> Johannes Berg (1):
>        wifi: mt76: use atomic iface iteration for pre-TBTT work
> 
> Kees Cook (1):
>        wifi: mt76: Annotate struct mt76_rx_tid with __counted_by
> 
> Lorenzo Bianconi (2):
>        wifi: mt76: mt792x: move mt7921_skb_add_usb_sdio_hdr in mt792x module
>        wifi: mt76: mt792x: move some common usb code in mt792x module
> 
> MeiChia Chiu (2):
>        wifi: mt76: update beacon size limitation
>        wifi: mt76: mt7915: fix beamforming availability check
> 
> Ming Yen Hsieh (4):
>        wifi: mt76: mt7921: enable set txpower for UNII-4
>        wifi: mt76: mt7921: add 6GHz power type support for clc
>        wifi: mt76: mt7921: get regulatory information from the clc event
>        wifi: mt76: mt7921: update the channel usage when the regd domain changed
> 
> Peter Chiu (6):
>        wifi: mt76: mt7996: set correct wcid in txp
>        wifi: mt76: mt7996: fix wmm queue mapping
>        wifi: mt76: mt7996: fix rx rate report for CBW320-2
>        wifi: mt76: mt7996: fix TWT command format
>        wifi: mt76: check vif type before reporting cca and csa
>        wifi: mt76: mt7915: update mpdu density capability
> 
> Sean Wang (4):
>        wifi: mt76: move struct ieee80211_chanctx_conf up to struct mt76_vif
>        wifi: mt76: mt7921: fix the wrong rate pickup for the chanctx driver
>        wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver
>        wifi: mt76: reduce spin_lock_bh held up in mt76_dma_rx_cleanup
> 
> Shayne Chen (2):
>        wifi: mt76: mt7996: only set vif teardown cmds at remove interface
>        wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison
> 
> StanleyYP Wang (1):
>        wifi: mt76: get rid of false alamrs of tx emission issues
> 
> Yi-Chia Hsieh (3):
>        wifi: mt76: mt7996: get tx_retries and tx_failed from txfree
>        wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic
>        wifi: mt76: mt7996: enable PPDU-TxS to host
> 
>   drivers/net/wireless/mediatek/mt76/Kconfig            |    1 +
>   drivers/net/wireless/mediatek/mt76/Makefile           |    1 +
>   drivers/net/wireless/mediatek/mt76/debugfs.c          |    2 -
>   drivers/net/wireless/mediatek/mt76/dma.c              |   14 +-
>   drivers/net/wireless/mediatek/mt76/eeprom.c           |    7 +-
>   drivers/net/wireless/mediatek/mt76/mac80211.c         |   62 ++-
>   drivers/net/wireless/mediatek/mt76/mt76.h             |   36 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |   76 +++-
>   drivers/net/wireless/mediatek/mt76/mt7603/core.c      |    2 +
>   drivers/net/wireless/mediatek/mt76/mt7603/init.c      |    8 +
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   52 +--
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c      |    4 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/regs.h      |    5 +
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c      |    5 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c      |    4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c   |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h      |    6 +
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |   18 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |   28 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  191 +++------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |   60 ++-
>   drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c   |    8 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   11 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   13 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |    4 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c      |   24 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c      |   53 ++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |   79 ++--
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   18 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |    4 +
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |    1 +
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c       |    5 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   54 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c       |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c      |   69 ++--
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  155 ++++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |   13 +
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   18 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |    2 +
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c   |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c  |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   12 +-
>   drivers/net/wireless/mediatek/mt76/mt7925/Kconfig     |   30 ++
>   drivers/net/wireless/mediatek/mt76/mt7925/Makefile    |    9 +
>   drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c   |  319 +++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/init.c      |  235 +++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.c       | 1452 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/mac.h       |   23 ++
>   drivers/net/wireless/mediatek/mt76/mt7925/main.c      | 1454 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       | 3174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |  537 ++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |  309 ++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |  586 ++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c   |  148 +++++++
>   drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c   |   53 +++
>   drivers/net/wireless/mediatek/mt76/mt7925/regs.h      |   92 +++++
>   drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |  332 +++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt792x.h           |   38 +-
>   drivers/net/wireless/mediatek/mt76/mt792x_core.c      |   30 +-
>   drivers/net/wireless/mediatek/mt76/mt792x_dma.c       |   49 ++-
>   drivers/net/wireless/mediatek/mt76/mt792x_usb.c       |    9 +
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c      |   50 ++-
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |  111 +++--
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c      |   65 +--
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       |  359 ++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.h       |   37 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/regs.h      |    8 +
>   drivers/net/wireless/mediatek/mt76/tx.c               |  108 ++++-
>   include/linux/pci_ids.h                               |    2 +
>   72 files changed, 10198 insertions(+), 560 deletions(-)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Makefile
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/init.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/main.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regs.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/usb.c

Pulled, thanks.

089482a06b74 Merge tag 'mt76-for-kvalo-2023-09-30' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/a5a2baaa-0db4-403e-9ebd-a7ff089675b4@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

