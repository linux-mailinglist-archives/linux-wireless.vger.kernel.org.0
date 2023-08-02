Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8B76C9F2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjHBJ4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjHBJ4H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 05:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01E1E4C
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 02:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D244618EA
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD135C433C8;
        Wed,  2 Aug 2023 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690970163;
        bh=ZIK89UWyE8uYI3zMfIs9N7bzRDJhVXADc/PTpqGlTHE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l4efKNQRqyfZ78KA3dAgkvEh6fhOjDB2HzWN/yBCbu7/Rnf2fBQVWRJ5P8u9s/gsH
         rCWSnAHNreccQ1bTi817XhNl2c3Mu/ZZKNVDuC6NWnoiHmwLwrGDXPEaM6N20C40Qs
         HfCLduGqMLaxGDLGGxIhQuB9l3zmVdo3RU/o6IwDolNs1lJ4VR9eXlpC5EhBO6piwp
         YlgOYE8KzvCpi+h0828LzJc95Pdw9J1UXMfytw86B9/fwDHS+BCPTRWSSsS4FOOp0x
         72asj4tAG7+GarE+9gZnDzyYNUmbmaAh8kGkeFMx/QfxnFOeMswvzIHE8yOZz7nb+G
         Yq0HGv4/iOPRA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: mt76 2023-07-31
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7b752ccb-42b0-94ca-5492-f3892a14f6b3@nbd.name>
References: <7b752ccb-42b0-94ca-5492-f3892a14f6b3@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169097016052.265879.13736690664719653238.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 09:56:02 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first request for 6.6
> 
> - Felix
> 
> The following changes since commit b2090d93d4b6f1c72a9793d5a171806b8468b7cb:
> 
>    wifi: brcmsmac: remove unused data type (2023-07-25 18:16:03 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-07-31
> 
> for you to fetch changes up to 6c0570bc21ec2073890aa252c8420ca7bec402e4:
> 
>    wifi: mt76: mt7915: fix power-limits while chan_switch (2023-07-31 10:56:28 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.6
> 
> * fixes
> * preparation for mt7925 support
> * mt7981 support
> 
> ----------------------------------------------------------------
> Alexander Couzens (1):
>        wifi: mt76: mt7915: add support for MT7981
> 
> Ben Greear (1):
>        wifi: mt76: mt7921: Support temp sensor
> 
> Bo Jiao (2):
>        wifi: mt76: mt7915: disable WFDMA Tx/Rx during SER recovery
>        wifi: mt76: mt7996: disable WFDMA Tx/Rx during SER recovery
> 
> Christian Marangi (2):
>        wifi: mt76: split get_of_eeprom in subfunction
>        wifi: mt76: add support for providing eeprom in nvmem cells
> 
> Daniel Golle (1):
>        dt-bindings: net: wireless: mt76: add bindings for MT7981
> 
> Deren Wu (3):
>        wifi: mt76: mt7921: do not support one stream on secondary antenna only
>        wifi: mt76: mt7921e: report tx retries/failed counts in tx free event
>        wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU
> 
> Felix Fietkau (4):
>        wifi: mt76: mt7915: fix capabilities in non-AP mode
>        wifi: mt76: mt7915: remove VHT160 capability on MT7915
>        wifi: mt76: mt7603: fix beacon interval after disabling a single vif
>        wifi: mt76: mt7603: fix tx filter/flush function
> 
> Howard Hsu (1):
>        wifi: mt76: mt7996: increase tx token size
> 
> Lin Ma (1):
>        wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH
> 
> Lorenzo Bianconi (49):
>        wifi: mt76: mt7921: remove macro duplication in regs.h
>        wifi: mt76: mt7915: move mib_stats structure in mt76.h
>        wifi: mt76: mt7996: rely on mib_stats shared definition
>        wifi: mt76: mt7921: rely on mib_stats shared definition
>        wifi: mt76: mt7921: make mt7921_mac_sta_poll static
>        mt76: mt7996: rely on mt76_sta_stats in mt76_wcid
>        wifi: mt76: mt7921: get rid of MT7921_RESET_TIMEOUT marco
>        wifi: mt76: mt7915: move sta_poll_list and sta_poll_lock in mt76_dev
>        wifi: mt76: mt7603: rely on shared sta_poll_list and sta_poll_lock
>        wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
>        wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
>        wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
>        wifi: mt76: mt7915: move poll_list in mt76_wcid
>        wifi: mt76: mt7603: rely on shared poll_list field
>        wifi: mt76: mt7615: rely on shared poll_list field
>        wifi: mt76: mt7996: rely on shared poll_list field
>        wifi: mt76: mt7921: rely on shared poll_list field
>        wifi: mt76: move ampdu_state in mt76_wcid
>        mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
>        wifi: mt76: move rate info in mt76_vif
>        wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h
>        wifi: mt76: connac: add connac3 mac library
>        wifi: mt76: mt7921: move common register definition in mt792x_regs.h
>        wifi: mt76: mt7921: convert acpisar and clc pointers to void
>        wifi: mt76: mt7921: rename mt7921_vif in mt792x_vif
>        wifi: mt76: mt7921: rename mt7921_sta in mt792x_sta
>        wifi: mt76: mt7921: rename mt7921_phy in mt792x_phy
>        wifi: mt76: mt7921: rename mt7921_dev in mt792x_dev
>        wifi: mt76: mt7921: rename mt7921_hif_ops in mt792x_hif_ops
>        wifi: mt76: mt792x: move shared structure definition in mt792x.h
>        wifi: mt76: mt7921: move mt792x_mutex_{acquire/release} in mt792x.h
>        wifi: mt76: mt7921: move mt792x_hw_dev in mt792x.h
>        wifi: mt76: mt792x: introduce mt792x-lib module
>        wifi: mt76: mt7921: move mac shared code in mt792x-lib module
>        wifi: mt76: mt7921: move dma shared code in mt792x-lib module
>        wifi: mt76: mt7921: move debugfs shared code in mt792x-lib module
>        wifi: mt76: mt7921: move init shared code in mt792x-lib module
>        wifi: mt76: mt792x: introduce mt792x_irq_map
>        wifi: mt76: mt792x: move more dma shared code in mt792x_dma
>        wifi: mt76: mt7921: move hif_ops macro in mt792x.h
>        wifi: mt76: mt7921: move shared runtime-pm code on mt792x-lib
>        wifi: mt76: mt7921: move runtime-pm pci code in mt792x-lib
>        wifi: mt76: mt7921: move acpi_sar code in mt792x-lib module
>        wifi: mt76: mt792x: introduce mt792x-usb module
>        wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module
>        wifi: mt76: mt76_connac3: move lmac queue enumeration in mt76_connac3_mac.h
>        wifi: mt76: mt792x: move MT7921_PM_TIMEOUT and MT7921_HW_SCAN_TIMEOUT in common code
>        wifi: mt76: mt7921: move mt7921_dma_init in pci.c
>        wifi: mt76: mt7921: move mt7921u_disconnect mt792x-lib
> 
> Matt Whitlock (1):
>        mt76: mt7921: don't assume adequate headroom for SDIO headers
> 
> MeiChia Chiu (1):
>        wifi: mt76: mt7996: add muru support
> 
> Ming Yen Hsieh (1):
>        wifi: mt76: mt7921: fix non-PSC channel scan fail
> 
> Peter Chiu (7):
>        wifi: mt76: mt7915: rework tx packets counting when WED is active
>        wifi: mt76: mt7915: rework tx bytes counting when WED is active
>        wifi: mt76: report non-binding skb tx rate when WED is active
>        wifi: mt76: connac: add support for dsp firmware download
>        wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
>        wifi: mt76: mt7996: enable VHT extended NSS BW feature
>        wifi: mt76: connac: add support to set ifs time by mcu command
> 
> Rafał Miłecki (1):
>        dt-bindings: mt76: support pointing to EEPROM using NVMEM cell
> 
> Rany Hany (1):
>        wifi: mt76: mt7915: fix command timeout in AP stop period
> 
> Ryder Lee (11):
>        wifi: mt76: mt7996: fix header translation logic
>        wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS support
>        wifi: mt76: mt7615: enable BSS_CHANGED_MU_GROUPS support
>        wifi: mt76: enable UNII-4 channel 177 support
>        wifi: mt76: mt7915: report tx retries/failed counts for non-WED path
>        wifi: mt76: mt7915: drop return in mt7915_sta_statistics
>        wifi: mt76: mt7996: drop return in mt7996_sta_statistics
>        wifi: mt76: add tx_nss histogram to ethtool stats
>        wifi: mt76: mt7915: accumulate mu-mimo ofdma muru stats
>        wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
>        wifi: mt76: mt7915: fix power-limits while chan_switch
> 
> Shayne Chen (1):
>        wifi: mt76: mt7996: move radio ctrl commands to proper functions
> 
> StanleyYP Wang (3):
>        wifi: mt76: mt7915: fix background radar event being blocked
>        wifi: mt76: mt7996: use correct phy for background radar event
>        wifi: mt76: mt7996: fix WA event ring size
> 
> Yuanjun Gong (1):
>        wifi: mt76: mt76x02: fix return value check in mt76x02_mac_process_rx
> 
>   Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml            |  13 +-
>   drivers/net/wireless/mediatek/mt76/Kconfig                                   |   8 ++
>   drivers/net/wireless/mediatek/mt76/Makefile                                  |  10 +-
>   drivers/net/wireless/mediatek/mt76/dma.c                                     |   6 +
>   drivers/net/wireless/mediatek/mt76/eeprom.c                                  |  87 ++++++++++---
>   drivers/net/wireless/mediatek/mt76/mac80211.c                                |   6 +
>   drivers/net/wireless/mediatek/mt76/mt76.h                                    | 106 ++++++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                           |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/init.c                             |   2 -
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c                              |  43 ++++---
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c                             |  25 ++--
>   drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h                           |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/regs.h                             |   7 +
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c                             |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.c                              |  31 ++---
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c                             |  49 +++++--
>   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                           |   4 -
>   drivers/net/wireless/mediatek/mt76/mt7615/regs.h                             |   9 ++
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h                             |  20 ++-
>   drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h                        |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c                        | 182 ++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h                        | 339 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                         | 106 +++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                         |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                             |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                            |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/Makefile                           |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/coredump.c                         |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                          | 128 +++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt7915/dma.c                              | 152 ++++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                           |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c                             |  19 ++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c                              | 194 +++++++++++-----------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.h                              |   7 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c                             | 233 +++++++++++++++++++++++++--------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                              | 151 ++++++++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                             |  47 ++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                           | 100 ++++----------
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h                             |  16 ++-
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c                              | 162 ++++++++++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7921/Kconfig                            |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/Makefile                           |   9 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h                         | 105 ---------------
>   drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c                          | 228 +++++---------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c                             | 343 +++++++++++-------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c                              | 554 +++++++++++-------------------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c                             | 806 +++++++++++++++++++++++++----------------------------------------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                              | 230 +++++++++++----------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                           | 359 +++++++--------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c                              | 225 ++++++++++++++++----------------
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                          |  34 ++---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c                          |  71 +---------
>   drivers/net/wireless/mediatek/mt76/mt7921/regs.h                             | 465 +-----------------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                             |  32 ++---
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c                         |   6 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c                         |  14 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/testmode.c                         |  10 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/trace.c                            |  12 --
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c                              | 205 ++++++++++++-----------------
>   drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c                          | 255 ------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt792x.h                                  | 367 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c}  | 128 +++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h                         | 105 +++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt792x_core.c                             | 844 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c                          | 168 ++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/{mt7921/dma.c => mt792x_dma.c}            | 336 +++++++++++++++++++++++++----------------------
>   drivers/net/wireless/mediatek/mt76/mt792x_mac.c                              | 385 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt792x_regs.h                             | 479 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt792x_trace.c                            |  14 ++
>   drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} |  16 +--
>   drivers/net/wireless/mediatek/mt76/mt792x_usb.c                              | 309 ++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c                          |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/dma.c                              |  83 +++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c                             |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c                              | 300 ++++++++----------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.h                              | 315 +--------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c                             | 114 +++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                              | 182 ++++++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                              |  17 +++
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                           |  94 ++------------
>   drivers/net/wireless/mediatek/mt76/mt7996/pci.c                              |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7996/regs.h                             |  21 ++-
>   drivers/net/wireless/mediatek/mt76/testmode.c                                |   1 +
>   drivers/net/wireless/mediatek/mt76/tx.c                                      |  16 ++-
>   84 files changed, 5752 insertions(+), 4827 deletions(-)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
>   delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
>   delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
>   delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x.h
>   rename drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c} (64%)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_core.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
>   rename drivers/net/wireless/mediatek/mt76/{mt7921/dma.c => mt792x_dma.c} (55%)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_regs.h
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_trace.c
>   rename drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} (68%)
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_usb.c

Pulled, thanks.

111d5c4797c0 Merge tag 'mt76-for-kvalo-2023-07-31' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7b752ccb-42b0-94ca-5492-f3892a14f6b3@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

