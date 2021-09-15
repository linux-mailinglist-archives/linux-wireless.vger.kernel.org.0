Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A5940BCFF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhIOBQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:16:30 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:7170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhIOBQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:16:29 -0400
X-UUID: 6a69c263c0374afc8b77e40fc9395c2b-20210914
X-UUID: 6a69c263c0374afc8b77e40fc9395c2b-20210914
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 209439151; Tue, 14 Sep 2021 18:15:06 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:14:53 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:14:51 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH v1 00/16] Add MT7921 SDIO support
Date:   Wed, 15 Sep 2021 09:14:33 +0800
Message-ID: <cover.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <objelf@gmail.com>

The patchset adds the SDIO support to the MT7921 driver, basically are
made up of 3 parts.

PART 1: patch 1-5, 9, 10 and 12-14
These are preliminary patches for mt7921s driver to refactor and reuse the
current mt7921e driver as much as possible.

PART 2: patch 6-8
These are preliminary patches for mt7921s driver to refactor and reuse the
current mt7663s driver as much as possible.

PART 3: patch 11 and 15-16
These are specific patches for mt7921s driver and reset mechanism in the
same framework where mt7921e have been supported. 

The patchset are built and generated against the current mt76 tree plus
the extra pending patches [1] expected to be merged to mt76 tree soon to
help the review and merge process be easier.

[1] The pending patch list prior to add MT7921 SDIO support

bc8238b1d71b mt76: mt7921s: add reset support
e1aa6be18238 mt76: mt7921: introduce mt7921s support
917c58fea5ae mt76: mt7921: refactor mt7921_mcu_send_message
6cc82d84bde6 mt76: mt7921: rely on mcu_get_nic_capability
c2ffb6abccee mt76: connac: extend mcu_get_nic_capability
b1c9fdc84dc4 mt76: connac: extend mt76_connac_sdio module to support CONNAC2
d251c19578f1 mt76: mt7921: use physical addr to unify register access
faf43c5f538a mt76: mt7921: make all event parser resuable between mt7921s and mt7921e
4d7725450ead mt76: mt7663s: rely on mt76_connac_sdio common library
85e99d7c663c mt76: connac: move sdio utility routines in mt76_connac_sdio module
bc35b5486170 mt76: connac: move mcu reg access utility routines in mt76_connac_lib module
fec36e88c44b mt76: mt7921: add MT7921_COMMON module
210a8cd3ab66 mt76: mt7921: refactor init.c to be bus independent
37519dafa027 mt76: mt7921: refactor mcu.c to be bus independent
aa4827ded213 mt76: mt7921: refactor dma.c to be pcie specific
f0d66c706432 mt76: mt7921: refactor mac.c to be bus independent
39ac94bb3154 mt76: schedule status timeout at dma completion
3e9f849d0fa4 mt76: substitute sk_buff_head status_list with spinlock_t status_lock
f739888cbc9a mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
7282f018bbd5 mt76: introduce packet_id idr
f067947571dc mt76: mt7921: add 6GHz support
2a29c573f44a mt76: add 6GHz support
ba4e1c352d91 mt76: connac: enable hw amsdu @ 6GHz
ed3294b6241b mt76: connac: add 6GHz support to mt76_connac_mcu_uni_add_bss
ad7d31a50d49 mt76: connac: add 6GHz support to mt76_connac_mcu_sta_tlv
017ba00f2c14 mt76: connac: set 6G phymode in single-sku support
9516ab381214 mt76: connac: add 6GHz support to mt76_connac_mcu_set_channel_domain
1afbef896fdd mt76: connac: enable 6GHz band for hw scan
527c23367b96 mt76: mt7921: remove mt7921_sta_stats
efb4fe718da9 mt76: mt7921: remove mcu rate reporting code
2950bd783385 mt76: mt7921: report tx rate directly from tx status
dd82125f72a4 mt76: mt7921: add support for tx status reporting
c0937116aefd mt76: mt7921: start reworking tx rate reporting
914640e9777d mt76: mt7921: update mib counters dumping phy stats
4d8d84d63bd3 mt76: mt7921: always wake device if necessary in debugfs
67a7fa715caf mt76: mt7921: move mt7921_queue_rx_skb to mac.c
8011d3c37132 mt76: mt7921: fix retrying release semaphore without end
50c452b6ad50 mt76: mt7921: robustify hardware initialization flow
9c19de7d8b1d (nbd/mt76) mt76: mt7615: checkpatch cleanup

Sean Wang (16):
  mt76: mt7921: refactor mac.c to be bus independent
  mt76: mt7921: refactor dma.c to be pcie specific
  mt76: mt7921: refactor mcu.c to be bus independent
  mt76: mt7921: refactor init.c to be bus independent
  mt76: mt7921: add MT7921_COMMON module
  mt76: connac: move mcu reg access utility routines in mt76_connac_lib
    module
  mt76: connac: move sdio utility routines in mt76_connac_sdio module
  mt76: mt7663s: rely on mt76_connac_sdio common library
  mt76: mt7921: make all event parser resuable between mt7921s and
    mt7921e
  mt76: mt7921: use physical addr to unify register access
  mt76: connac: extend mt76_connac_sdio module to support CONNAC2
  mt76: connac: extend mcu_get_nic_capability
  mt76: mt7921: rely on mcu_get_nic_capability
  mt76: mt7921: refactor mt7921_mcu_send_message
  mt76: mt7921: introduce mt7921s support
  mt76: mt7921s: add reset support

 drivers/net/wireless/mediatek/mt76/Kconfig    |   5 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +
 drivers/net/wireless/mediatek/mt76/mcu.c      |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   4 +
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |   2 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  28 --
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 -
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 310 ++-------------
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   9 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  93 +++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   3 +
 .../wireless/mediatek/mt76/mt76_connac_sdio.c | 363 +++++++++++++++++
 .../{mt7615/sdio.h => mt76_connac_sdio.h}     |  81 +++-
 .../sdio_txrx.c => mt76_connac_sdio_txrx.c}   | 177 ++++++---
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  19 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   8 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  35 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.c    | 101 -----
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  52 +--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 364 ++----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   4 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   7 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 131 ++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  92 ++++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  20 +-
 .../wireless/mediatek/mt76/mt7921/pci_init.c  |  26 ++
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 347 +++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 115 ++++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  22 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 262 +++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_init.c |  23 ++
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 202 ++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  | 133 +++++++
 .../wireless/mediatek/mt76/mt7921/testmode.c  |   2 +-
 36 files changed, 2069 insertions(+), 1007 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
 rename drivers/net/wireless/mediatek/mt76/{mt7615/sdio.h => mt76_connac_sdio.h} (51%)
 rename drivers/net/wireless/mediatek/mt76/{mt7615/sdio_txrx.c => mt76_connac_sdio_txrx.c} (58%)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c

-- 
2.25.1

