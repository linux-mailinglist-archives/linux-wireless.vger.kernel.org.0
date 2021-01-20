Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DC2FD9C0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 20:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392572AbhATTfW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 14:35:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48759 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392507AbhATTex (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 14:34:53 -0500
X-UUID: 14f9a480498f450ba828d7293d01eda2-20210121
X-UUID: 14f9a480498f450ba828d7293d01eda2-20210121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 69438910; Thu, 21 Jan 2021 03:33:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 03:33:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 03:33:53 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH -next v6 00/15] introduce mt7921e support
Date:   Thu, 21 Jan 2021 03:33:36 +0800
Message-ID: <cover.1611060302.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <objelf@gmail.com>

Introduce support for mt7921e 802.11ax (Wi-Fi 6) 2x2:2SS chipset.

v2:
- Mark the patch as -next

v3:
- Remove sw scan support
- Get rid of dbdc code
- Run mt7921_configure_filter hodling mt76 mutex
- Correct Txp programming in Txd
- Correct fw log to host command
- Correct eeprom offset definition
- Update rate adaption info report
- Remove unused code and fields in struture
- Split the previous driver into several patches for easy review

v4:
- introduce sched scan support
- introduce 802.11 PS support in sta mode
- introduce support for hardware beacon filter
- introduce beacon_loss mcu event
- introduce PM support
- refine sta_rec_phy and add sta_rec_ra_info
- remove incorrect mt7921_mcu_tx_config member
- fix erroneous endianness conversion in mt7921_tx_complete_skb()
- fix endianness warning in mt7921_get_wtbl_info()
- fix endianness warnings in mt7921_mcu_sta_tlv()
- remove unused code in mt7921_mcu_send_message
- remove scan with random mac until fw is ready
- channel domain is added for hw scan

v5:
- fix implicit conversion from enumeration type
- remove unused function declaration
- drop zero-length packet to avoid Tx hang
- fix MT_CIPHER_BIP_CMAC_128 setkey
- reset token when mac_reset happens
- create mac.h when mac support is added
- reorder the patch of adding module support
- move mac_work in mt76_core module
- move chainmask in mt76_phy
- rebase per moving mac_work in mt76_core module
- rebase per moving chainmask in mt76_phy

v6:
- use UNI_BSS_INFO_BCNFT and UNI_BSS_INFO_PS to carry out
  enabling hardware beacon filter and 802.11 power saving
  mode according to the MT7921 firmware

Lorenzo Bianconi (2):
  mt76: move mac_work in mt76_core module
  mt76: move chainmask in mt76_phy

Sean Wang (13):
  mt76: mt7921: add MAC support
  mt76: mt7921: add MCU support
  mt76: mt7921: add DMA support
  mt76: mt7921: add EEPROM support
  mt76: mt7921: add ieee80211_ops
  mt76: mt7921: introduce mt7921e support
  mt76: mt7921: add debugfs support
  mt76: mt7921: add module support
  mt76: mt7921: introduce schedule scan support
  mt76: mt7921: introduce 802.11 PS support in sta mode
  mt76: mt7921: introduce support for hardware beacon filter
  mt76: mt7921: introduce beacon_loss mcu event
  mt76: mt7921: introduce PM support

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |    5 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |   14 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |   10 +-
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |    2 -
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   16 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   27 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   15 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |    4 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |    5 -
 .../wireless/mediatek/mt76/mt7615/testmode.c  |    4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |    4 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |    2 -
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |   10 +-
 .../net/wireless/mediatek/mt76/mt76x02_phy.c  |    4 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |    6 +-
 .../net/wireless/mediatek/mt76/mt76x2/mcu.c   |    2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |    2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |    4 +-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |    2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |    2 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   17 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   31 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   11 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |    8 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |    3 -
 .../wireless/mediatek/mt76/mt7915/testmode.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   10 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |    5 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  178 +
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  356 ++
 .../wireless/mediatek/mt76/mt7921/eeprom.c    |  101 +
 .../wireless/mediatek/mt76/mt7921/eeprom.h    |   27 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  254 ++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1393 ++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  333 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 1051 ++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2983 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 1176 +++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  379 +++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  279 ++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  413 +++
 48 files changed, 9049 insertions(+), 115 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regs.h

--
2.25.1

