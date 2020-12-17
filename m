Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B961B2DD805
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 19:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgLQSOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 13:14:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46156 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731465AbgLQSOL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 13:14:11 -0500
X-UUID: aea57221cf68497a80cc161d58647686-20201218
X-UUID: aea57221cf68497a80cc161d58647686-20201218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 381591907; Fri, 18 Dec 2020 02:13:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Dec 2020 02:13:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 02:13:20 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH -next v3 0/8] introduce mt7921e support
Date:   Fri, 18 Dec 2020 02:13:13 +0800
Message-ID: <cover.1608227863.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 66E4E9418E49B81874ED36765B42D89684E737952F514267B1C0BD3BDAFAB9682000:8
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

Sean Wang (8):
  mt76: mt7921: add module support
  mt76: mt7921: add MCU support
  mt76: mt7921: add MAC support
  mt76: mt7921: add DMA support
  mt76: mt7921: add EEPROM support
  mt76: mt7921: add ieee80211_ops
  mt76: mt7921: introduce mt7921e support
  mt76: mt7921: add debugfs support

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   10 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |    5 +
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  178 ++
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  356 +++
 .../wireless/mediatek/mt76/mt7921/eeprom.c    |  101 +
 .../wireless/mediatek/mt76/mt7921/eeprom.h    |   27 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  263 ++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1367 ++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  333 +++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  929 +++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 2391 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 1075 ++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  352 +++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  184 ++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  413 +++
 17 files changed, 7986 insertions(+)
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

