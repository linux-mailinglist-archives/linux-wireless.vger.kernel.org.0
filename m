Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C0432A25
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhJRXR0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:26 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:25617 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhJRXRY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:24 -0400
X-UUID: ba7b2c4935844d1f870cb24c76d56f96-20211018
X-UUID: ba7b2c4935844d1f870cb24c76d56f96-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1293493697; Mon, 18 Oct 2021 16:15:09 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 16:11:51 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 07:11:50 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH v5 00/17] Add MT7921 SDIO WiFi support
Date:   Tue, 19 Oct 2021 07:11:30 +0800
Message-ID: <cover.1634598341.git.objelf@gmail.com>
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

PART 1: patch 1-5, 8-9 and 13-15
These are preliminary patches for mt7921s driver to refactor and reuse the
current mt7921e driver as much as possible.

PART 2: patch 6-7, 10-11
These are preliminary patches for mt7921s driver to refactor and reuse the
current mt7663s driver as much as possible.

PART 3: patch 12 and 16-17
These are specific patches for mt7921s driver and reset mechanism in the
same framework where mt7921e have been supported. 

The patchset are built and generated against the current mt76 with the
tag mt76-for-kvalo-2021-10-12 plus the extra pending patches [1] expected to
be merged to mt76 tree soon to help the review and merge process be easier.

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

The change list from v3 to v4
1. change the title of coverletter
2. fix the git message in patch 14
3. rebase onto the mt76-for-kvalo-2021-10-12

The change list from v4 to v5
1. fix endianess warning in mt76_connac_mcu_parse_tx_resource
2. rework the driver with the the following additional patches
   a. mt76: sdio: introduce parse_irq callback
   b. mt76: sdio: export mt76s_alloc_rx_queue and mt76s_alloc_tx routines

[1] The pending patch list prior to add MT7921 SDIO support

dee0a13bcd6e mt76: mt7921: get rid of unused variable in mt7921_mac_tx_free
d56281936470 mt76: mt7921: get rid of unused variable in mt7921_tx_complete_skb
ef853b3f16ef mt76: connac: fix possible NULL pointer dereference in mt76_connac_get_phy_mode_v2
215246fecd9f mt76: mt7915: improve code readability for xmit-queue handler
9953a1186155 mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy
c7cf56ad8385 mt76: rely on phy pointer in mt76_register_debugfs_fops routine signature
43366b8cef53 mt76: mt7921: add MU EDCA cmd support
44c7f544a257 mt76: sdio: export mt76s_alloc_rx_queue and mt76s_alloc_tx routines

Lorenzo Bianconi (2):
  mt76: sdio: move common code in mt76_sdio module
  mt76: sdio: introduce parse_irq callback

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
 drivers/net/wireless/mediatek/mt76/mt76.h     |  24 ++
 .../wireless/mediatek/mt76/mt7615/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  28 --
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  18 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  | 288 ++------------
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  11 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  93 +++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |  18 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   8 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  38 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.c    | 101 -----
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  51 +--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 375 ++----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   4 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   8 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 135 ++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 107 ++++-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  48 ++-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   | 348 ++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   | 115 ++++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  22 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  | 317 +++++++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 220 ++++++++++
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  | 135 +++++++
 drivers/net/wireless/mediatek/mt76/sdio.c     | 282 +++++++++++++
 .../mediatek/mt76/{mt7615 => }/sdio.h         |  33 +-
 .../mediatek/mt76/{mt7615 => }/sdio_txrx.c    | 134 ++++---
 30 files changed, 1995 insertions(+), 990 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
 rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio.h (72%)
 rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio_txrx.c (67%)

-- 
2.25.1

