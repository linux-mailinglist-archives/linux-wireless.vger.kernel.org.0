Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141D57010D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiGKLrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiGKLrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 07:47:08 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931DD23BF4
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z2kMES+SGLSLF6MDUZSt5xeUrnNPsNwaxJa+2wfU5Jo=; b=WpGndAX+Z43lGXM+8/mzd9CJkO
        sf8mkc99z1XzYCq/tTqO98eRE7cBMc35slt5huUCYYxRv/sTj0xghsAHoYJX6p4Qhq7MphjsdKz4z
        h7554jqbhIbQ9iknkA/kyobhFNKB5ByLgsiQTGYKzm9KLQGgmiKqprX6Y8reqVFpnW0A=;
Received: from p200300daa706010035504eaa13556367.dip0.t-ipconnect.de ([2003:da:a706:100:3550:4eaa:1355:6367] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1oArr2-00014q-7b; Mon, 11 Jul 2022 13:45:32 +0200
Message-ID: <b85651ee-d469-aff9-e351-c65868be34f3@nbd.name>
Date:   Mon, 11 Jul 2022 13:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-07-11
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.20

- Felix

The following changes since commit 58b6259d820d63c2adf1c7541b54cce5a2ae6073:

   wifi: mac80211_hwsim: add back erroneously removed cast (2022-07-11 13:16:30 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-07-11

for you to fetch changes up to 454b768f9ba653d65968c1ef29d2d4aa477147ea:

   mt76: mt7921: Let PCI core handle power state and use pm_sleep_ptr() (2022-07-11 13:40:03 +0200)

----------------------------------------------------------------
mt76 patches for 5.20

- preparation for new chipset support
- fixes
- VHT/HE related improvements
- ACPI SAR support

----------------------------------------------------------------
Dan Carpenter (1):
       mt76: mt7915: fix endian bug in mt7915_rf_regval_set()

Deren Wu (9):
       mt76: add 6 GHz band support in mt76_sar_freq_ranges
       mt76: mt7921: introduce ACPI SAR support
       mt76: mt7921: introduce ACPI SAR config in tx power
       mt76: enable the VHT extended NSS BW feature
       mt76: mt7921: not support beacon offload disable command
       mt76: mt7921: fix command timeout in AP stop period
       mt76: mt7921s: fix possible sdio deadlock in command fail
       mt76: mt7921: fix aggregation subframes setting to HE max
       mt76: mt7921: enlarge maximum VHT MPDU length to 11454

Felix Fietkau (10):
       mt76: mt7915: add missing bh-disable around tx napi enable/schedule
       mt76: mt7615: add missing bh-disable around rx napi schedule
       mt76: mt7915: disable UL MU-MIMO for mt7915
       mt76: mt7615: add sta_rec with EXTRA_INFO_NEW for the first time only
       mt76: mt76x02: improve reliability of the beacon hang check
       mt76: allow receiving frames with invalid CCMP PN via monitor interfaces
       mt76: mt7615: fix throughput regression on DFS channels
       mt76: pass original queue id from __mt76_tx_queue_skb to the driver
       mt76: do not use skb_set_queue_mapping for internal purposes
       mt76: remove q->qid

Kai-Heng Feng (1):
       mt76: mt7921: Let PCI core handle power state and use pm_sleep_ptr()

Liang He (2):
       mediatek: mt76: mac80211: Fix missing of_node_put() in mt76_led_init()
       mediatek: mt76: eeprom: fix missing of_node_put() in mt76_find_power_limits_node()

Lorenzo Bianconi (40):
       mt76: mt7915: fix endianness in mt7915_rf_regval_get
       mt76: mt76x02u: fix possible memory leak in __mt76x02u_mcu_send_msg
       mt76: mt7921: add missing bh-disable around rx napi schedule
       mt76: mt7921: get rid of mt7921_mcu_exit
       mt76: connac: move shared fw structures in connac module
       mt76: mt7921: move fw toggle in mt7921_load_firmware
       mt76: connac: move mt76_connac2_load_ram in connac module
       mt76: connac: move mt76_connac2_load_patch in connac module
       mt76: mt7663: rely on mt76_connac2_fw_trailer
       mt76: mt7921: rely on mt76_dev in mt7921_mac_write_txwi signature
       mt76: mt7915: rely on mt76_dev in mt7915_mac_write_txwi signature
       mt76: connac: move mac connac2 defs in mt76_connac2_mac.h
       mt76: connac: move connac2_mac_write_txwi in mt76_connac module
       mt76: connac: move mt76_connac2_mac_add_txs_skb in connac module
       mt76: connac: move HE radiotap parsing in connac module
       mt76: connac: move mt76_connac2_reverse_frag0_hdr_trans in mt76-connac module
       mt76: connac: move mt76_connac2_mac_fill_rx_rate in connac module
       mt76: mt7921s: remove unnecessary goto in mt7921s_mcu_drv_pmctrl
       mt76: mt7615: do not update pm stats in case of error
       mt76: mt7921: do not update pm states in case of error
       mt76: mt7915: get rid of unnecessary new line in mt7915_mac_write_txwi
       mt76: connac: move mt76_connac_fw_txp in common module
       mt76: move mt7615_txp_ptr in mt76_connac module
       mt76: connac: move mt76_connac_tx_free in shared code
       mt76: connac: move mt76_connac_tx_complete_skb in shared code
       mt76: connac: move mt76_connac_write_hw_txp in shared code
       mt76: connac: move mt7615_txp_skb_unmap in common code
       mt76: mt7915: rely on mt76_connac_tx_free
       mt76: move mcu_txd/mcu_rxd structures in shared code
       mt76: move mt76_connac2_mcu_fill_message in mt76_connac module
       mt76: mt7915: do not copy ieee80211_ops pointer in mt7915_mmio_probe
       mt76: mt7921: make mt7921_pci_driver static
       mt76: connac: move tx initialization/cleanup in mt76_connac module
       mt76: add len parameter to __mt76_mcu_msg_alloc signature
       mt76: introduce MT_RXQ_BAND2 and MT_RXQ_BAND2_WA in mt76_rxq_id
       mt76: add phy_idx in mt76_rx_status
       mt76: introduce phys array in mt76_dev structure
       mt76: add phy_idx to mt76_wcid
       mt76: convert MT_TX_HW_QUEUE_EXT_PHY to MT_TX_HW_QUEUE_PHY
       mt76: get rid of mt76_wcid_hw routine

MeiChia Chiu (3):
       mt76: do not check the ccmp pn for ONLY_MONITOR frame
       mt76: mt7915: update the maximum size of beacon offload
       mt76: mt7915 add ht mpdu density

Peter Chiu (2):
       dt-bindings: net: wireless: mt76: add clock description for MT7986.
       mt76: mt7915: update mpdu density in 6g capability

Ryder Lee (2):
       mt76: mt7915: add more ethtool stats
       mt76: add DBDC rxq handlings into mac_reset_work

Sean Wang (4):
       mt76: mt7921: enable HW beacon filter not depending on PM flag
       mt76: mt7921: enable HW beacon filter in the initialization stage
       mt76: mt7921: reduce log severity levels for informative messages
       mt76: mt7921: reduce the mutex lock scope during reset

Shayne Chen (2):
       mt76: mt7915: fix incorrect testmode ipg on band 1 caused by wmm_idx
       mt76: mt7915: add sta_rec with EXTRA_INFO_NEW for the first time only

YN Chen (2):
       mt76: mt7921: add PATCH_FINISH_REQ cmd response handling
       mt76: mt7921s: fix firmware download random fail

  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |  13 ++
  drivers/net/wireless/mediatek/mt76/dma.c                          |  19 +--
  drivers/net/wireless/mediatek/mt76/eeprom.c                       |   5 +-
  drivers/net/wireless/mediatek/mt76/mac80211.c                     |  61 ++++++----
  drivers/net/wireless/mediatek/mt76/mcu.c                          |  10 +-
  drivers/net/wireless/mediatek/mt76/mt76.h                         |  85 ++++++-------
  drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   | 121 ++++++------------
  drivers/net/wireless/mediatek/mt76/mt7615/mac.h                   |  69 -----------
  drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |  25 +---
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |  75 ++++++------
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h                   |   3 -
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |  10 +-
  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               | 109 ++++-------------
  drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac.h                  | 116 ++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h             | 323 ++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              | 920 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              | 303 +++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              | 156 ++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c               |   6 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |  11 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   3 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |  69 +++++------
  drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  21 ++--
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   | 915 +++++++++++++++-------------------------------------------------------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   | 333 +-------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |  20 ++-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 403 +++++++++---------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |  51 ++------
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |  19 ++-
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  32 ++---
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |  24 ++--
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |  11 +-
  drivers/net/wireless/mediatek/mt76/mt7921/Makefile                |   1 +
  drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c              | 279 ++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h              |  93 ++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   |  21 +---
  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  13 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   | 716 ++++++----------------------------------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mac.h                   | 340 +--------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  | 120 +++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   | 418 +++++---------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  88 --------------
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  50 ++++----
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  34 ++----
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c               | 106 ++--------------
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c               |  17 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c              |  31 +++--
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c                   |  14 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c               |   4 +-
  drivers/net/wireless/mediatek/mt76/sdio.c                         |   8 +-
  drivers/net/wireless/mediatek/mt76/testmode.c                     |   9 +-
  drivers/net/wireless/mediatek/mt76/tx.c                           |  54 ++++----
  drivers/net/wireless/mediatek/mt76/usb.c                          |   7 +-
  61 files changed, 3005 insertions(+), 3794 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
