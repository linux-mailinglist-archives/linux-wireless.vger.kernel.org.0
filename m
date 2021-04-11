Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5335B722
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhDKWI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 18:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKWI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 18:08:56 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21DC061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xwAdHBSzJx8Gi8nNWOcLQ0Vnpcfc3pCd7pir5QphRcs=; b=p2c2GBnDZXDIDhxgTkdk9ZfBlq
        k+b80iatjPUTBz5moAHBbC1i5I0zbnIXd3+zae2c0xagsYBkQ7eO2MhnQOINt1ygkib876nZRNNqV
        xkfJP7odH3E70Gz3GINhZ/7u4JSku5tEsN/VCl6jJHXCevQ+lklz/zIcVn7XZf+/4D40=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lViFr-0002m4-Pf; Mon, 12 Apr 2021 00:08:31 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-04-12
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <b5b4820b-f0be-3e9c-25f7-b45c60b66c3c@nbd.name>
Date:   Mon, 12 Apr 2021 00:08:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my my updated pull request for 5.13.
It replaces the previous ones and fixes a few more regressions.

- Felix

The following changes since commit fa9f5d0e0b45a06802f7cb3afed237be6066821e:

  iwlegacy: avoid -Wempty-body warning (2021-04-11 12:31:01 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-04-12

for you to fetch changes up to 0751f8b9394c8d957b269c41ee278ebd8074f015:

  mt76: mt7921: introduce MCU_EVENT_LP_INFO event parsing (2021-04-12 00:04:23 +0200)

----------------------------------------------------------------
mt76 patches for 5.13

* code cleanup
* mt7915/mt7615 decap offload support
* driver fixes
* mt7613 eeprom support
* MCU code unification
* threaded NAPI support
* new device IDs
* mt7921 device reset support
* rx timestamp support

----------------------------------------------------------------
Colin Ian King (1):
      mt76: mt7921: remove redundant check on type

David Bauer (1):
      mt76: mt76x0: disable GTK offloading

Eric Y.Y. Wong (1):
      mt76: mt76x0u: Add support for TP-Link T2UHP(UN) v1

Felix Fietkau (15):
      mt76: add support for 802.3 rx frames
      mt76: mt7915: add rx checksum offload support
      mt76: mt7915: add support for rx decapsulation offload
      mt76: mt7615: fix key set/delete issues
      mt76: mt7615: fix tx skb dma unmap
      mt76: mt7915: fix tx skb dma unmap
      mt76: use threaded NAPI
      mt76: mt7915: fix key set/delete issue
      mt76: mt7915: refresh repeater entry MAC address when setting BSSID
      mt76: mt7615: fix chip reset on MT7622 and MT7663e
      mt76: mt7615: limit firmware log message printk to buffer length
      mt76: mt7915: limit firmware log message printk to buffer length
      mt76: fix potential DMA mapping leak
      mt76: mt7921: remove 80+80 MHz support capabilities
      mt76: mt7615: always add rx header translation tlv when adding stations

Guobin Huang (1):
      mt76: mt7615: remove redundant dev_err call in mt7622_wmac_probe()

Jiapeng Chong (1):
      mt76: mt7921: remove unneeded semicolon

Lorenzo Bianconi (33):
      mt76: mt7915: enable hw rx-amsdu de-aggregation
      mt76: mt7921: enable random mac addr during scanning
      mt76: mt7921: removed unused definitions in mcu.h
      mt76: connac: always check return value from mt76_connac_mcu_alloc_wtbl_req
      mt76: mt7915: always check return value from mt7915_mcu_alloc_wtbl_req
      mt76: mt7615: fix memory leak in mt7615_coredump_work
      mt76: mt7921: fix aggr length histogram
      mt76: mt7915: fix aggr len debugfs node
      mt76: mt7921: fix stats register definitions
      mt76: mt7615: fix mib stats counter reporting to mac80211
      mt76: connac: fix kernel warning adding monitor interface
      mt76: check return value of mt76_txq_send_burst in mt76_txq_schedule_list
      mt76: mt7921: get rid of mt7921_sta_rc_update routine
      mt76: mt7921: check mcu returned values in mt7921_start
      mt76: mt7921: reduce mcu timeouts for suspend, offload and hif_ctrl msg
      mt76: introduce mcu_reset function pointer in mt76_mcu_ops structure
      mt76: mt7921: introduce mt7921_run_firmware utility routine.
      mt76: mt7921: introduce __mt7921_start utility routine
      mt76: dma: introduce mt76_dma_queue_reset routine
      mt76: dma: export mt76_dma_rx_cleanup routine
      mt76: mt7921: add wifi reset support
      mt76: mt7921: remove leftovers from dbdc configuration
      mt76: mt7921: remove duplicated macros in mcu.h
      mt76: mt7921: get rid of mt7921_mac_wtbl_lmac_addr
      mt76: connac: introduce mt76_sta_cmd_info data structure
      mt76: mt7921: properly configure rcpi adding a sta to the fw
      dt-bindings:net:wireless:ieee80211: txt to yaml conversion
      dt-bindings:net:wireless:mediatek,mt76: txt to yaml conversion
      mt76: mt7921: fix key set/delete issue
      mt76: mt7921: always wake the device in mt7921_remove_interface
      mt76: mt7921: rework mt7921_mcu_debug_msg_event routine
      mt76: mt7921: introduce MT_WFDMA_DUMMY_CR definition
      mt76: mt7921: introduce MCU_EVENT_LP_INFO event parsing

Nigel Christian (1):
      mt76: mt7921: remove unnecessary variable

Ryder Lee (32):
      mt76: always use WTBL_MAX_SIZE for tlv allocation
      mt76: use PCI_VENDOR_ID_MEDIATEK to avoid open coded
      mt76: mt7615: enable hw rx-amsdu de-aggregation
      mt76: mt7615: add rx checksum offload support
      mt76: mt7615: add support for rx decapsulation offload
      mt76: mt7615: fix TSF configuration
      mt76: mt7615: remove hdr->fw_ver check
      mt76: mt7915: fix mib stats counter reporting to mac80211
      mt76: mt7915: add missing capabilities for DBDC
      mt76: mt7615: fix CSA notification for DBDC
      mt76: mt7615: stop ext_phy queue when mac reset happens
      mt76: mt7915: fix CSA notification for DBDC
      mt76: mt7915: stop ext_phy queue when mac reset happens
      mt76: mt7915: fix PHY mode for DBDC
      mt76: mt7915: fix rxrate reporting
      mt76: mt7915: fix txrate reporting
      mt76: mt7915: check mcu returned values in mt7915_ops
      mt76: mt7615: check mcu returned values in mt7615_ops
      mt76: mt7615: add missing capabilities for DBDC
      mt76: mt7915: fix possible deadlock while mt7915_register_ext_phy()
      mt76: mt7615: only enable DFS test knobs for mt7615
      mt76: mt7615: cleanup mcu tx queue in mt7615_dma_reset()
      mt76: mt7622: trigger hif interrupt for system reset
      mt76: mt7615: keep mcu_add_bss_info enabled till interface removal
      mt76: mt7915: keep mcu_add_bss_info enabled till interface removal
      mt76: mt7915: cleanup mcu tx queue in mt7915_dma_reset()
      mt76: mt7615: fix .add_beacon_offload()
      mt76: mt7915: fix mt7915_mcu_add_beacon
      mt76: mt7915: add wifi subsystem reset
      mt76: report Rx timestamp
      mt76: mt7915: add mmio.c
      mt76: mt7615: add missing SPDX tag in mmio.c

Sander Vanheule (1):
      mt76: mt7615: support loading EEPROM for MT7613BE

Sean Wang (17):
      mt76: mt7921: fix suspend/resume sequence
      mt76: mt7921: fix memory leak in mt7921_coredump_work
      mt76: mt7921: switch to new api for hardware beacon filter
      mt76: connac: fix up the setting for ht40 mode in mt76_connac_mcu_uni_add_bss
      mt76: mt7921: fixup rx bitrate statistics
      mt76: mt7921: add flush operation
      mt76: connac: update sched_scan cmd usage
      mt76: mt7921: fix the base of PCIe interrupt
      mt76: mt7921: fix the base of the dynamic remap
      mt76: mt7663: fix when beacon filter is being applied
      mt76: mt7663s: make all of packets 4-bytes aligned in sdio tx aggregation
      mt76: mt7663s: fix the possible device hang in high traffic
      mt76: mt7921: fix inappropriate WoW setup with the missing ARP informaiton
      mt76: mt7921: fix the dwell time control
      mt76: mt7921: fix kernel crash when the firmware fails to download
      mt76: mt7921: fix the insmod hangs
      mt76: mt7921: reduce the data latency during hw scan

Shayne Chen (1):
      mt76: mt7915: fix txpower init for TSSI off chips

 Documentation/devicetree/bindings/net/wireless/ieee80211.txt      |  24 -----
 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml     |  45 ++++++++
 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt  |  78 --------------
 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 121 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/agg-rx.c                       |  19 ++--
 drivers/net/wireless/mediatek/mt76/dma.c                          |  55 ++++++----
 drivers/net/wireless/mediatek/mt76/mac80211.c                     |  74 ++++++++++++--
 drivers/net/wireless/mediatek/mt76/mcu.c                          |   4 +
 drivers/net/wireless/mediatek/mt76/mt76.h                         |  24 ++++-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c                  |   3 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |  33 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h                |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c                   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |  29 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |  28 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c                |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |  20 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   | 380 ++++++++++++++++++++++++--------------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h                   |   8 ++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                  | 166 ++++++++++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   | 103 ++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h                   |  34 ++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |   3 +
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |  24 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c                   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               | 168 ++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c             |  11 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c                   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |   5 +
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |  73 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  44 +++++---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c                   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c                 |   4 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c                   |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile                |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   | 110 +-------------------
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                |  19 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                  | 123 ++++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   | 163 ++++++++++++++++++-----------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   |  15 +++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                  | 124 +++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 248 ++++++++++++++++++++++++++------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |  14 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  | 152 +++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  87 ++--------------
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |  13 +--
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |  13 +++
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile                |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  12 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   | 470 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h                   |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                  | 208 +++++++++++++++++++++++--------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   | 157 ++++++++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  43 +-------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  29 ++++--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h          |  51 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  24 +++--
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |  37 +++++--
 drivers/net/wireless/mediatek/mt76/mt7921/trace.c                 |  12 +++
 drivers/net/wireless/mediatek/mt76/sdio.c                         |   3 +
 drivers/net/wireless/mediatek/mt76/tx.c                           |  15 ++-
 71 files changed, 2404 insertions(+), 1402 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
