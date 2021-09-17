Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CCB410256
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhIRALL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 20:11:11 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:63455 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344052AbhIRALJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 20:11:09 -0400
X-UUID: 36ae9e92de59498fa64c8beec40ec143-20210917
X-UUID: 36ae9e92de59498fa64c8beec40ec143-20210917
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1205345477; Fri, 17 Sep 2021 17:09:44 -0700
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 16:59:42 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 18 Sep 2021 07:59:35 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH v2 00/16] Add MT7921 SDIO support
Date:   Sat, 18 Sep 2021 07:59:16 +0800
Message-ID: <cover.1631918993.git.objelf@gmail.com>
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

PART 1: patch 1-5, 8-9 and 12-14
These are preliminary patches for mt7921s driver to refactor and reuse the
current mt7921e driver as much as possible.

PART 2: patch 6-7, 10
These are preliminary patches for mt7921s driver to refactor and reuse the
current mt7663s driver as much as possible.

PART 3: patch 11 and 15-16
These are specific patches for mt7921s driver and reset mechanism in the
same framework where mt7921e have been supported.

The patchset are built and generated against the current mt76 tree plus
the extra pending patches [1] expected to be merged to mt76 tree soon to
help the review and merge process be easier.

The change list from v1 to v2
1. rework the whole driver according to the new patches added
   ("mt76: introduce __mt76_mcu_send_firmware routine"),
   ("mt76: not accounting the MCU header size in __mt76_mcu_send_firmware for mt7915/21") and
   ("mt76: sdio: move common code in mt76_sdio module")
2. drop pci_init.c and sdio_init.c by moving the related logic to pci.c and sdio.c, respectively.
3. cosmetics the patches like removing unnecessary new line and adding an extra space to fixed_map table.
4. fix typo in commit message

[1] The pending patch list prior to add MT7921 SDIO support

da0054ae6b1f mt76: mt7921s: add reset support
31c979d37209 mt76: mt7921: introduce mt7921s support
c8f8caad718f mt76: mt7921: refactor mt7921_mcu_send_message
f4bb6338d638 mt76: mt7921: rely on mcu_get_nic_capability
0bfd21e29498 mt76: connac: extend mcu_get_nic_capability
3b5f8d1815a4 mt76: sdio: extend sdio module to support CONNAC2
28669a9ceff5 mt76: sdio: move common code in mt76_sdio module
ad7ba2b9c6af mt76: mt7921: use physical addr to unify register access
a6aebd446a9a mt76: mt7921: make all event parser reusable between mt7921s and mt7921e
0c52f915f728 mt76: mt7663s: rely on mcu reg access utility
42112d6b7b1c mt76: connac: move mcu reg access utility routines in mt76_connac_lib module
23bf9455d505 mt76: mt7921: add MT7921_COMMON module
688be52542bb mt76: mt7921: refactor init.c to be bus independent
099a0527d05c mt76: mt7921: refactor mcu.c to be bus independent
378767d66e2b mt76: mt7921: refactor dma.c to be pcie specific
e15c4c1be3ea mt76: mt7921: refactor mac.c to be bus independent
b72eaca3c81b mt76: not accounting the MCU header size in __mt76_mcu_send_firmware for mt7915/21
870fe1bc5fc8 mt76: introduce __mt76_mcu_send_firmware routine
465a8a6e834f mt76: schedule status timeout at dma completion
4d3b6422fe5e mt76: substitute sk_buff_head status_list with spinlock_t status_lock
13d50c723b79 mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
ed46465dc741 mt76: introduce packet_id idr
b3568b1f391a mt76: mt7921: add 6GHz support
6605e1e5c2be mt76: add 6GHz support
1dcae1bad280 mt76: connac: enable hw amsdu @ 6GHz
88c34fb4fdef mt76: connac: add 6GHz support to mt76_connac_mcu_uni_add_bss
8bb780867211 mt76: connac: add 6GHz support to mt76_connac_mcu_sta_tlv
6e021ff24950 mt76: connac: set 6G phymode in single-sku support
21a96eed203d mt76: connac: add 6GHz support to mt76_connac_mcu_set_channel_domain
b70bae155a51 mt76: connac: enable 6GHz band for hw scan
92e29c77494c mt76: mt7921: remove mt7921_sta_stats
56ea41ec4ae3 mt76: mt7921: remove mcu rate reporting code
94b97e96549e mt76: mt7921: report tx rate directly from tx status
8dd12eb23009 mt76: mt7921: add support for tx status reporting
69328a635189 mt76: mt7921: start reworking tx rate reporting
b915a7d2b882 mt76: mt7921: update mib counters dumping phy stats
2a694a754e32 mt76: mt7921: always wake device if necessary in debugfs
067927a52e93 mt76: mt7921: move mt7921_queue_rx_skb to mac.c
a866733d977d mt76: mt7921: fix retrying release semaphore without end
8853d1b5b6bf mt76: mt7921: robustify hardware initialization flow

Lorenzo Bianconi (1):
  mt76: sdio: move common code in mt76_sdio module

Sean Wang (15):
  mt76: mt7921: refactor mac.c to be bus independent
  mt76: mt7921: refactor dma.c to be pcie specific
  mt76: mt7921: refactor mcu.c to be bus independent
  mt76: mt7921: refactor init.c to be bus independent
  mt76: mt7921: add MT7921_COMMON module
  mt76: connac: move mcu reg access utility routines in mt76_connac_lib
    module
  mt76: mt7663s: rely on mcu reg access utility
  mt76: mt7921: make all event parser reusable between mt7921s and
    mt7921e
  mt76: mt7921: use physical addr to unify register access
  mt76: sdio: extend sdio module to support CONNAC2
  mt76: connac: extend mcu_get_nic_capability
  mt76: mt7921: rely on mcu_get_nic_capability
  mt76: mt7921: refactor mt7921_mcu_send_message
  mt76: mt7921: introduce mt7921s support
  mt76: mt7921s: add reset support

 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  22 ++
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  28 --
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 -
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 282 +------------
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  11 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  93 +++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  18 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   8 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  38 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.c    | 101 -----
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  52 +--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 372 ++----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   4 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   7 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 138 ++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  94 ++++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  49 ++-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 346 ++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 115 ++++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  22 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 285 ++++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 220 +++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  | 135 +++++++
 drivers/net/wireless/mediatek/mt76/sdio.c     | 282 +++++++++++++
 .../mediatek/mt76/{mt7615 => }/sdio.h         |  50 ++-
 .../mediatek/mt76/{mt7615 => }/sdio_txrx.c    | 171 +++++---
 30 files changed, 1982 insertions(+), 991 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
 rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio.h (68%)
 rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio_txrx.c (59%)

--
2.25.1

