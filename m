Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD70E69464D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 13:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBMMun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjBMMui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 07:50:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D866581
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 04:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DA35B811E3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 12:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F28BC433EF;
        Mon, 13 Feb 2023 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676292630;
        bh=MCSO/nueBPuHxyz8OQPtPtpfBjbBBel2tb0C42HXiHw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HMDmek1/7ea7RU5JzQtRBv3BuBTTwiyIJVk1AhN4P3teHWskCmNua8GN1CiX8/A1K
         zFgLrLugKyPQA6AzoGa/l0M5BBxXo9XVLVE4fEvV+FWwAB4wXRNS0lwCKnIg9ogVw/
         dMRXtMZ4Eu/cX5phycJL2JPnOiLUTclhfru4d8NzDw93jGbbSPEc8N+A3JYCq98fuJ
         3jFUISYi9y/u5OXX2eWP6F5rdTpqaQ/obQpox73hw3yRUHYXoxAAdi5KYhqFqsjQpE
         0Uwr+gobew9pTHJkipXD7BHsGVNY5bGSAFCSU+8+QVRY65h76Zz5oTBTKmE6fOzmrr
         8So7OVSQ9difg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2023-02-03
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <a5085d68-c786-abc1-e7f1-ccf48acec6a8@nbd.name>
References: <a5085d68-c786-abc1-e7f1-ccf48acec6a8@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167629262805.12830.15583291281791586351.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 12:50:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's a replacement for my first request for 6.3
> 
> - Felix
> 
> The following changes since commit 8065c0e13f9875f597920a2af47e5dc2940a9c4f:
> 
>    Merge branch 'yt8531-support' (2023-02-03 09:34:51 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-02-03
> 
> for you to fetch changes up to 518c5d778e985441a7e8c82c696dd38c002c44f0:
> 
>    wifi: mt76: support ww power config in dts node (2023-02-03 14:51:37 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.3
> 
> - fixes
> - mt7996 cleanups
> - switch to page pool allocator
> - mt7996 eht support
> - WED reset support
> 
> ----------------------------------------------------------------
> Aaron Ma (1):
>        wifi: mt76: mt7921: fix error code of return in mt7921_acpi_read
> 
> Chuanhong Guo (1):
>        wifi: mt76: mt7921u: add support for Comfast CF-952AX
> 
> Deren Wu (7):
>        wifi: mt76: mt7921: fix channel switch fail in monitor mode
>        wifi: mt76: mt7921: add ack signal support
>        wifi: mt76: mt7921: fix invalid remain_on_channel duration
>        wifi: mt76: add flexible polling wait-interval support
>        wifi: mt76: mt7921: reduce polling time in pmctrl
>        wifi: mt76: add memory barrier to SDIO queue kick
>        wifi: mt76: support ww power config in dts node
> 
> Felix Fietkau (1):
>        wifi: mt76: mt7921: fix deadlock in mt7921_abort_roc
> 
> Howard Hsu (4):
>        wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work
>        wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling
>        wifi: mt76: mt7915: rework mt7915_thermal_temp_store()
>        wifi: mt76: mt7915: add error message in mt7915_thermal_set_cur_throttle_state()
> 
> Lorenzo Bianconi (22):
>        wifi: mt76: introduce mt76_queue_is_wed_rx utility routine
>        wifi: mt76: mt7915: fix memory leak in mt7915_mcu_exit
>        wifi: mt76: mt7996: fix memory leak in mt7996_mcu_exit
>        wifi: mt76: dma: free rx_head in mt76_dma_rx_cleanup
>        wifi: mt76: dma: fix memory leak running mt76_dma_tx_cleanup
>        wifi: mt76: mt7915: avoid mcu_restart function pointer
>        wifi: mt76: mt7603: avoid mcu_restart function pointer
>        wifi: mt76: mt7615: avoid mcu_restart function pointer
>        wifi: mt76: mt7921: avoid mcu_restart function pointer
>        wifi: mt76: fix switch default case in mt7996_reverse_frag0_hdr_trans
>        wifi: mt76: mt7915: fix memory leak in mt7915_mmio_wed_init_rx_buf
>        wifi: mt76: switch to page_pool allocator
>        wifi: mt76: enable page_pool stats
>        wifi: mt76: mt7996: rely on mt76_connac2_mac_tx_rate_val
>        wifi: mt76: mt7996: rely on mt76_connac_txp_common structure
>        wifi: mt76: mt7996: rely on mt76_connac_txp_skb_unmap
>        wifi: mt76: mt7996: rely on mt76_connac_tx_complete_skb
>        wifi: mt76: mt7996: avoid mcu_restart function pointer
>        wifi: mt76: remove __mt76_mcu_restart macro
>        wifi: mt76: mt7915: add mt7915 wed reset callbacks
>        wifi: mt76: mt7915: complete wed reset support
>        wifi: mt76: mt76x0u: report firmware version through ethtool
> 
> MeiChia Chiu (2):
>        wifi: mt76: mt7915: remove BW160 and BW80+80 support
>        wifi: mt76: mt7996: add EHT beamforming support
> 
> Neil Chen (1):
>        wifi: mt76: mt7921: fix rx filter incorrect by drv/fw inconsistent
> 
> Peter Chiu (2):
>        wifi: mt76: mt7915: set sku initial value to zero
>        wifi: mt76: mt7915: wed: enable red per-band token drop
> 
> Ryder Lee (1):
>        wifi: mt76: mt7915: fix WED TxS reporting
> 
> Shayne Chen (17):
>        wifi: mt76: mt7915: add chip id condition in mt7915_check_eeprom()
>        wifi: mt76: mt7996: fix chainmask calculation in mt7996_set_antenna()
>        wifi: mt76: mt7996: update register for CFEND_RATE
>        wifi: mt76: mt7996: do not hardcode vht beamform cap
>        wifi: mt76: connac: fix POWER_CTRL command name typo
>        wifi: mt76: add EHT phy type
>        wifi: mt76: connac: add CMD_CBW_320MHZ
>        wifi: mt76: connac: add helpers for EHT capability
>        wifi: mt76: connac: add cmd id related to EHT support
>        wifi: mt76: increase wcid size to 1088
>        wifi: mt76: add EHT rate stats for ethtool
>        wifi: mt76: mt7996: add variants support
>        wifi: mt76: mt7996: add helpers for wtbl and interface limit
>        wifi: mt76: mt7996: rework capability init
>        wifi: mt76: mt7996: add EHT capability init
>        wifi: mt76: mt7996: add support for EHT rate report
>        wifi: mt76: mt7996: enable EHT support in firmware
> 
> Sujuan Chen (3):
>        wifi: mt76: mt7915: release rxwi in mt7915_wed_release_rx_buf
>        wifi: mt76: dma: add reset to mt76_dma_wed_setup signature
>        wifi: mt76: dma: reset wed queues in mt76_dma_rx_reset
> 
>   drivers/net/wireless/mediatek/mt76/Kconfig           |   1 +
>   drivers/net/wireless/mediatek/mt76/dma.c             | 118 ++++++++++++++++++++++--------------------
>   drivers/net/wireless/mediatek/mt76/dma.h             |   1 +
>   drivers/net/wireless/mediatek/mt76/eeprom.c          |   1 +
>   drivers/net/wireless/mediatek/mt76/mac80211.c        |  68 ++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt76.h            |  55 ++++++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7603/mcu.c      |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |   3 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c |   1 -
>   drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c  |   1 -
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h     |   5 ++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |   7 +--
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  46 +++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  16 +++++-
>   drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c  |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7915/dma.c      |  45 ++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c     |  70 +++++++++++--------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  12 +++--
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  39 ++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 112 +++++++++++++++++++++++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |  96 +++++++++++++++++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   7 +++
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c      |   2 +
>   drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c |   7 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  11 +++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  15 ++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 116 ++++++++++++++++++-----------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 106 ++++++++++++++++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   9 ++++
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c  |   9 ++--
>   drivers/net/wireless/mediatek/mt76/mt7921/regs.h     |   8 +++
>   drivers/net/wireless/mediatek/mt76/mt7921/testmode.c |   1 -
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c      |   4 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c  |   8 +--
>   drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c   |  27 ++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/init.c     | 402 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 149 +++++++++++++++++++----------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.h      |  24 ---------
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c     |  17 ++++--
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 234 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
>   drivers/net/wireless/mediatek/mt76/mt7996/mcu.h      |  16 ++++++
>   drivers/net/wireless/mediatek/mt76/mt7996/mmio.c     |   5 +-
>   drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h   |  26 +++++++---
>   drivers/net/wireless/mediatek/mt76/mt7996/regs.h     |  15 +++---
>   drivers/net/wireless/mediatek/mt76/sdio.c            |   4 ++
>   drivers/net/wireless/mediatek/mt76/usb.c             |  42 ++++++++-------
>   drivers/net/wireless/mediatek/mt76/util.c            |  10 ++--
>   49 files changed, 1335 insertions(+), 646 deletions(-)

Pulled, thanks.

f18bd6f53946 Merge tag 'mt76-for-kvalo-2023-02-03' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/a5085d68-c786-abc1-e7f1-ccf48acec6a8@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

