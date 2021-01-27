Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165F1306465
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhA0Tnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 14:43:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49633 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344686AbhA0TjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 14:39:23 -0500
X-UUID: adf8f7751fe442e0a703979c54496f6f-20210128
X-UUID: adf8f7751fe442e0a703979c54496f6f-20210128
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1691694604; Thu, 28 Jan 2021 03:34:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 03:33:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 03:33:58 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH -next v8 00/20]introduce mt7921e support
Date:   Thu, 28 Jan 2021 03:33:37 +0800
Message-ID: <cover.1611774181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A7AE99663C5CA7AE56A75F43AC166F097F35AEFEA1EA60DF175845760528C1162000:8
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

v7:
- remove the merged patches
- rebase onto the series mt76: introduce mt76_connac common module
	https://patchwork.kernel.org/project/linux-wireless/list/?series=418597
- rely on mt76_connac_mcu common library
- rely on mt76_connac_mcu module for sched_scan and hw_scan
- rely on mt76_connac_mcu module for suspend and WoW support
- introduce regdomain notifier support
- enable MSI interrupts
- introduce Runtime PM support
- add coredump support
- add sta statistics
- disable Rx header translation on default
- set nss to 2 on default

v8:
- fold mt76: mt7921: add sta statistics into
       mt76: mt7921: add ieee80211_ops and
       mt76: mt7921: add module support into
       mt76: mt7921: introduce mt7921e support
  according to Ryder's review

Lorenzo Bianconi (6):
  mt76: mt7921: rely on mt76_connac_mcu common library
  mt76: mt7921: rely on mt76_connac_mcu module for sched_scan and
    hw_scan
  mt76: mt7921: rely on mt76_connac_mcu module for suspend and WoW
    support
  mt76: mt7921: introduce regdomain notifier support
  mt76: mt7921: enable MSI interrupts
  mt76: mt7663: introduce coredump support

Sean Wang (14):
  mt76: mt7921: add MAC support
  mt76: mt7921: add MCU support
  mt76: mt7921: add DMA support
  mt76: mt7921: add EEPROM support
  mt76: mt7921: add ieee80211_ops
  mt76: mt7921: introduce mt7921e support
  mt76: mt7921: add debugfs support
  mt76: mt7921: introduce schedule scan support
  mt76: mt7921: introduce 802.11 PS support in sta mode
  mt76: mt7921: introduce support for hardware beacon filter
  mt76: mt7921: introduce beacon_loss mcu event
  mt76: mt7921: introduce PM support
  mt76: mt7921: introduce Runtime PM support
  mt76: mt7921: add coredump support

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |    1 +
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |   17 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |    2 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   43 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |    5 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |    1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |    4 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   14 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  370 +++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   25 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   11 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |    5 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  250 +++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  356 ++++
 .../wireless/mediatek/mt76/mt7921/eeprom.c    |  100 ++
 .../wireless/mediatek/mt76/mt7921/eeprom.h    |   27 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  282 +++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1516 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  333 ++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 1161 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 1308 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  434 +++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  342 ++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  292 ++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  419 +++++
 27 files changed, 7310 insertions(+), 10 deletions(-)
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

