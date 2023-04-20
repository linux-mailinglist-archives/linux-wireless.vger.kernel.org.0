Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127F36E9521
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDTM4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDTM4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E876955A8
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F7D64958
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8C3C433D2;
        Thu, 20 Apr 2023 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681995410;
        bh=str9SYcH0nLRDP5O/NapdErCeAH0OjdhB7kQfREcCho=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=vQ1UxvlFQQJbmaG4LO2uLq2z5dEY/5TxlS1VvFRn+fIVccuSScMwx7oY1WTZfvQ3Z
         rOL+3kswcmZigwnTKLIK6ZD7QeNPamrVHu4bQuhI/Ao5XAIdK5XzQfDZGA8cnOkq8m
         tgL5K4LK5c/RMle3Hj4aLyDJUNA4nRltrS3Bz6DjRXgZxbLqq0VvMPdcXbutTYZZoh
         Wtyp89jbORogQjZTQyxIAsHpT95MgIyVeUHhcsIozD5nurBgxnQndI0T638zUD7T1G
         i0amDX7xziFTs5IIE6ivLHJasfHuuY8genr13CYrSFmZDJ3ErJ4gCFJkN2mtFbSYP3
         MX1TC8AkCfHyg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2023-04-18 v2
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <5df957fd-e67a-3549-8c78-1b4599365b7c@nbd.name>
References: <5df957fd-e67a-3549-8c78-1b4599365b7c@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168199540522.31131.16976755016088538294.kvalo@kernel.org>
Date:   Thu, 20 Apr 2023 12:56:50 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's an updated version of my first request for 6.4.
> It fixes an unused-but-set variable
> 
> - Felix
> 
> The following changes since commit f22c0bffe8d9528ace89a853c6065b79dcb88c43:
> 
>    wifi: rtw89: add support of concurrent mode (2023-04-17 12:49:52 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-04-18
> 
> for you to fetch changes up to 3b522cadedfe6e9e0e8193d7d4ab5aa8d0c73209:
> 
>    wifi: mt76: mt7996: fill txd by host driver (2023-04-19 10:09:43 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.4
> 
> - fixes
> - connac code unification
> - mt7921 p2p support
> - mt7996 mesh a-msdu support
> - mt7996 eht support
> - mt7996 coredump support
> 
> ----------------------------------------------------------------
> Bo Jiao (1):
>        wifi: mt76: mt7996: enable full system reset support
> 
> Dan Carpenter (1):
>        wifi: mt76: mt7915: unlock on error in mt7915_thermal_temp_store()
> 
> Deren Wu (3):
>        wifi: mt76: remove redundent MCU_UNI_CMD_* definitions
>        wifi: mt76: mt7921: fix wrong command to set STA channel
>        wifi: mt76: mt7921: fix PCI DMA hang after reboot
> 
> Felix Fietkau (4):
>        wifi: mt76: add missing locking to protect against concurrent rx/status calls
>        wifi: mt76: mt7615: increase eeprom size for mt7663
>        wifi: mt76: dma: use napi_build_skb
>        wifi: mt76: set NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 on supported drivers
> 
> Frank Wunderlich (1):
>        dt-bindings: mt76: add active-low property for led
> 
> Gustavo A. R. Silva (2):
>        wifi: mt76: Replace zero-length array with flexible-array member
>        wifi: mt76: mt7921: Replace fake flex-arrays with flexible-array members
> 
> Howard Hsu (1):
>        wifi: mt76: mt7915: rework init flow in mt7915_thermal_init()
> 
> Jiefeng Li (1):
>        wifi: mt76: mt7921: fix missing unwind goto in `mt7921u_probe`
> 
> Kang Chen (1):
>        wifi: mt76: handle failure of vzalloc in mt7615_coredump_work
> 
> Lorenz Brun (1):
>        wifi: mt76: mt7915: expose device tree match table
> 
> Lorenzo Bianconi (8):
>        wifi: mt76: mt7921: introduce mt7921_get_mac80211_ops utility routine
>        wifi: mt76: move irq_tasklet in mt76_dev struct
>        wifi: mt76: add mt76_connac_irq_enable utility routine
>        wifi: mt76: get rid of unused sta_ps callbacks
>        wifi: mt76: add mt76_connac_gen_ppe_thresh utility routine
>        wifi: mt76: mt7921: get rid of eeprom.h
>        wifi: mt76: move shared mac definitions in mt76_connac2_mac.h
>        wifi: mt76: move mcu_uni_event and mcu_reg_event in common code
> 
> Mario Limonciello (1):
>        wifi: mt76: mt7921e: Set memory space enable in PCI_COMMAND if unset
> 
> Ming Yen Hsieh (1):
>        wifi: mt76: fix 6GHz high channel not be scanned
> 
> Neil Chen (1):
>        wifi: mt76: mt7921: use driver flags rather than mac80211 flags to mcu
> 
> Peter Chiu (4):
>        wifi: mt76: drop the incorrect scatter and gather frame
>        wifi: mt76: mt7996: fix pointer calculation in ie countdown event
>        wifi: mt76: mt7996: init mpdu density cap
>        wifi: mt76: mt7996: remove mt7996_mcu_set_pm()
> 
> Quan Zhou (3):
>        wifi: mt76: mt7921e: fix probe timeout after reboot
>        wifi: mt76: mt7921e: improve reliability of dma reset
>        wifi: mt76: mt7921e: stop chip reset worker in unregister hook
> 
> Reese Russell (1):
>        wifi: mt76: mt7921: add Netgear AXE3000 (A8000) support
> 
> Ryder Lee (15):
>        wifi: mt76: mt7996: fix radiotap bitfield
>        wifi: mt76: dynamic channel bandwidth changes in AP mode
>        wifi: mt76: connac: refresh tx session timer for WED device
>        wifi: mt76: mt7915: remove mt7915_mcu_beacon_check_caps()
>        wifi: mt76: mt7996: remove mt7996_mcu_beacon_check_caps()
>        wifi: mt76: mt7915: drop redundant prefix of mt7915_txpower_puts()
>        wifi: mt76: mt7996: add full system reset knobs into debugfs
>        wifi: mt76: mt7996: enable coredump support
>        wifi: mt76: connac: fix txd multicast rate setting
>        wifi: mt76: connac: add nss calculation into mt76_connac2_mac_tx_rate_val()
>        wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support
>        wifi: mt76: mt7996: enable BSS_CHANGED_MCAST_RATE support
>        wifi: mt76: mt7996: enable configured beacon tx rate
>        wifi: mt76: mt7996: enable mesh HW amsdu/de-amsdu support
>        wifi: mt76: mt7996: fill txd by host driver
> 
> Sean Wang (2):
>        wifi: mt76: mt7921: enable p2p support
>        mt76: mt7921: fix kernel panic by accessing unallocated eeprom.data
> 
> Shayne Chen (3):
>        wifi: mt76: mt7996: add eht rx rate support
>        wifi: mt76: mt7996: let non-bufferable MMPDUs use correct hw queue
>        wifi: mt76: mt7996: remove unused eeprom band selection
> 
> StanleyYP Wang (1):
>        wifi: mt76: mt7996: fix eeprom tx path bitfields
> 
> Sujuan Chen (1):
>        wifi: mt76: mt7915: add dev->hif2 support for mt7916 WED device
> 
> Yang Li (1):
>        wifi: mt76: mt7996: Remove unneeded semicolon
> 
>   Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |   5 ++
>   drivers/net/wireless/mediatek/mt76/dma.c                          |  10 ++-
>   drivers/net/wireless/mediatek/mt76/dma.h                          |   1 +
>   drivers/net/wireless/mediatek/mt76/mac80211.c                     |  17 +++--
>   drivers/net/wireless/mediatek/mt76/mt76.h                         |  19 +++--
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c                |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h                |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |  18 ++---
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.h                   |  12 ----
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |  11 +--
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.h                   |  11 ---
>   drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |  11 ++-
>   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |  11 +--
>   drivers/net/wireless/mediatek/mt76/mt7615/pci.c                   |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                  |   1 -
>   drivers/net/wireless/mediatek/mt76/mt7615/usb.c                   |   1 -
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |  21 ++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h             |  22 ++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |  78 +++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |  21 ++++--
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  19 +++--
>   drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  36 +++++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |  10 ++-
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  35 +++------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   |  33 +--------
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   1 -
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 115 +++++-------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |  17 +++--
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  18 +----
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c                   |   2 +
>   drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h              |  10 +--
>   drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               |   1 -
>   drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   |  50 +++++++------
>   drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h                |  30 --------
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  43 +++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |  18 +++--
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.h                   |  53 --------------
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  42 +++++------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |  31 ++------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  11 ---
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  23 +++---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  64 ++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c               |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |  23 +-----
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c              |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c              |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c                   |  27 ++-----
>   drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c               |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/Kconfig                 |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7996/Makefile                |   2 +
>   drivers/net/wireless/mediatek/mt76/mt7996/coredump.c              | 268 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/coredump.h              |  97 +++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c               | 149 +++++++++++++++++++++++++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7996/dma.c                   |  64 +++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c                |   4 --
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h                |   9 ++-
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c                  |  72 +++++++++++--------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c                   | 501 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.h                   |  62 ++++++----------
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c                  |  78 ++++++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   | 222 +++++++++++++++++----------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                   |  30 ++++----
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                  |  23 +++---
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                |  76 ++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7996/regs.h                  |  51 +++++++++++++-
>   drivers/net/wireless/mediatek/mt76/tx.c                           |   4 ++
>   72 files changed, 1710 insertions(+), 1028 deletions(-)
>   delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
>   delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/coredump.h

Pulled, thanks.

d2a158d113cb Merge tag 'mt76-for-kvalo-2023-04-18' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/5df957fd-e67a-3549-8c78-1b4599365b7c@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

