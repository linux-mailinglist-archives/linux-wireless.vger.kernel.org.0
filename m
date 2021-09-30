Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C920341E517
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350696AbhI3Xvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 19:51:53 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:33710 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350540AbhI3Xvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 19:51:52 -0400
X-UUID: fe6823a1b6b647b4a6ff659c1377dd4f-20210930
X-UUID: fe6823a1b6b647b4a6ff659c1377dd4f-20210930
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 348854362; Thu, 30 Sep 2021 16:50:06 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Sep 2021 16:48:07 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Oct 2021 07:48:05 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH v3 00/16] Add MT7921 SDIO support
Date:   Fri, 1 Oct 2021 07:47:47 +0800
Message-ID: <cover.1632961096.git.objelf@gmail.com>
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
3. cosmetics the patches like removing unnecessary new line, adding an extra space to fixed_map table and so on ...
4. fix typo in commit message

The change list from v2 to v3
1. rebase onto the latest mt76 branch
2. update per Lorenzo comments on v2
3. fix scheduling while atomic in mt7921_mac_sta_poll for mt7921s driver

[1] The pending patch list prior to add MT7921 SDIO support

3061ff518086 mt76: mt7921s: add reset support
5de5d96f85ed mt76: mt7921: introduce mt7921s support
f0571612eebe mt76: mt7921: refactor mt7921_mcu_send_message
689fcdcd2972 mt76: mt7921: rely on mcu_get_nic_capability
861f6162e2e5 mt76: connac: extend mcu_get_nic_capability
a28c493784ce mt76: sdio: extend sdio module to support CONNAC2
972627da893a mt76: sdio: move common code in mt76_sdio module
fd9ce3e4ead6 mt76: mt7921: use physical addr to unify register access
b90b1edd1f01 mt76: mt7921: make all event parser reusable between mt7921s and mt7921e
85361034e054 mt76: mt7663s: rely on mcu reg access utility
e9ad71f627da mt76: connac: move mcu reg access utility routines in mt76_connac_lib module
f4a4f2080162 mt76: mt7921: add MT7921_COMMON module
29b7682b7659 mt76: mt7921: refactor init.c to be bus independent
b597ab756ae0 mt76: mt7921: refactor mcu.c to be bus independent
8c608c4b4569 mt76: mt7921: refactor dma.c to be pcie specific
dd9b17ee1198 mt76: mt7921: refactor mac.c to be bus independent
2c3e24c98655 mt76: not accounting the MCU header size in __mt76_mcu_send_firmware for mt7915/21
527fd6d0a36b mt76: introduce __mt76_mcu_send_firmware routine
bd16dcf4677d mt76: schedule status timeout at dma completion
f9a99765d094 mt76: substitute sk_buff_head status_list with spinlock_t status_lock
7ba08a841137 mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
77a501a1505d mt76: introduce packet_id idr
801aa83b77ef mt76: mt7921: add 6GHz support
672b8f7e615c mt76: add 6GHz support
53da9785a0c2 mt76: connac: enable hw amsdu @ 6GHz
d9bcbcb8f6a5 mt76: connac: add 6GHz support to mt76_connac_mcu_uni_add_bss
4c6b738139a1 mt76: connac: add 6GHz support to mt76_connac_mcu_sta_tlv
a02b7de86d78 mt76: connac: set 6G phymode in single-sku support
9c0db900b17f mt76: connac: add 6GHz support to mt76_connac_mcu_set_channel_domain
188dea0151a7 mt76: connac: enable 6GHz band for hw scan

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
 drivers/net/wireless/mediatek/mt76/mt76.h     |  22 +
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
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  51 +--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 381 ++----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   4 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   8 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 135 ++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  94 ++++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  48 ++-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 354 ++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 115 ++++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  22 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 285 +++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 220 ++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  | 135 +++++++
 drivers/net/wireless/mediatek/mt76/sdio.c     | 282 +++++++++++++
 .../mediatek/mt76/{mt7615 => }/sdio.h         |  50 ++-
 .../mediatek/mt76/{mt7615 => }/sdio_txrx.c    | 171 +++++---
 30 files changed, 1987 insertions(+), 999 deletions(-)
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

