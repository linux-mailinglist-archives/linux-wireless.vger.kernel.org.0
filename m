Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AEC340273
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 10:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCRJuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCRJts (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 05:49:48 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBFC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FJWtjYRVfEKbcPxUg6fh57NpfO7CulVOzZelzkU5/eM=; b=ld1LvsxL6zcEOq/4Gvyppe2bQ2
        BrCJeNT++Z1LRa41nHSvBsmR5hI69fGr8PDGwWK9QO6X1MVgIi/h6un1sGE96NHzLdKmCQxO2nYdH
        58y+3ABGGI0/XQDeVdzcVU2hiAneDXgsRs51xTy4aE90XUXDSJnRQqujAQwkQT+1H5zA=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lMpHm-0006d4-BI; Thu, 18 Mar 2021 10:49:46 +0100
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-03-18
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <352fe51c-6228-02b4-2eb3-5ab6c178327c@nbd.name>
Date:   Thu, 18 Mar 2021 10:49:45 +0100
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
It replaces the previous one and fixes a few regressions.

- Felix

The following changes since commit 13ce240a932fe9c809ec6e79ffc5a4d4ecf534ee:

  rtw88: 8822c: support FW crash dump when FW crash (2021-03-15 10:27:13 +0200)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-03-18

for you to fetch changes up to 1ee256de59aca1e16ba47b9d1c297eb92f905934:

  mt76: mt7921: remove duplicated macros in mcu.h (2021-03-18 10:45:18 +0100)

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

----------------------------------------------------------------
Colin Ian King (1):
      mt76: mt7921: remove redundant check on type

David Bauer (1):
      mt76: mt76x0: disable GTK offloading

Eric Y.Y. Wong (1):
      mt76: mt76x0u: Add support for TP-Link T2UHP(UN) v1

Felix Fietkau (7):
      mt76: add support for 802.3 rx frames
      mt76: mt7915: add rx checksum offload support
      mt76: mt7915: add support for rx decapsulation offload
      mt76: mt7615: fix key set/delete issues
      mt76: mt7615: fix tx skb dma unmap
      mt76: mt7915: fix tx skb dma unmap
      mt76: use threaded NAPI

Jiapeng Chong (1):
      mt76: mt7921: remove unneeded semicolon

Lorenzo Bianconi (23):
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

Nigel Christian (1):
      mt76: mt7921: remove unnecessary variable

Ryder Lee (20):
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

Sander Vanheule (1):
      mt76: mt7615: support loading EEPROM for MT7613BE

Sean Wang (12):
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

 drivers/net/wireless/mediatek/mt76/agg-rx.c           |  13 ++--
 drivers/net/wireless/mediatek/mt76/dma.c              |  53 ++++++++-----
 drivers/net/wireless/mediatek/mt76/mac80211.c         |  79 +++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mcu.c              |   4 +
 drivers/net/wireless/mediatek/mt76/mt76.h             |  21 +++++-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  16 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 195 +++++++++++++++++++++++++++++------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |   8 ++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      | 153 +++++++++++++++++++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |  70 +++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  34 +++------
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  19 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |   9 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c |  11 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   5 ++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  34 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  23 ++++--
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |   4 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  63 +++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c       | 103 +++++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h       |  15 ++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  90 +++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 188 ++++++++++++++++++++++++++++++---------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |  14 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  10 +--
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 397 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.h       |  10 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 143 +++++++++++++++++++++--------------
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  55 ++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |  42 -----------
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |  16 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  20 ++---
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h      |  31 +++++---
 drivers/net/wireless/mediatek/mt76/sdio.c             |   3 +
 drivers/net/wireless/mediatek/mt76/tx.c               |  15 ++--
 52 files changed, 1338 insertions(+), 688 deletions(-)
