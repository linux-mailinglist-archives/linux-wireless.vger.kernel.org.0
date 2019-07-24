Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B340972ADF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfGXI6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 04:58:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbfGXI6h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 04:58:37 -0400
X-UUID: e8381f9a02a0430aa25df4429260a1cb-20190724
X-UUID: e8381f9a02a0430aa25df4429260a1cb-20190724
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 413447111; Wed, 24 Jul 2019 16:58:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 16:58:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 16:58:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 0/6] fix many checkpatch.pl warnings
Date:   Wed, 24 Jul 2019 16:58:14 +0800
Message-ID: <cover.1563944758.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7C89812366BFC7779EF08260026C24A6BF7E5EB1E49B9BC56618B305B907799A2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This gathers many subsets to fix checkpatch.pl warnings and switches
to use SPDX tags.

I still keep some warnings there due to readability. The most of them
are networking block comments or Macro argument reuse...

Changes since v1:
- fix misspellings.
- fix a header convention error.

Ryder Lee (6):
  mt76: Add paragraphs to describe the config symbols fully
  mt76: mt7603: fix some checkpatch warnings
  mt76: mt7615: fix some checkpatch warnings
  mt76: mt76x02: fix some checkpatch warnings
  mt76: fix some checkpatch warnings
  mt76: switch to SPDX tag instead of verbose boilerplate text

 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 34 ++++-------
 drivers/net/wireless/mediatek/mt76/debugfs.c  | 13 +---
 drivers/net/wireless/mediatek/mt76/dma.c      | 15 +----
 drivers/net/wireless/mediatek/mt76/dma.h      | 13 +---
 drivers/net/wireless/mediatek/mt76/eeprom.c   | 13 +---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 43 ++++++--------
 drivers/net/wireless/mediatek/mt76/mcu.c      | 13 +---
 drivers/net/wireless/mediatek/mt76/mmio.c     | 13 +---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 59 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7603/Kconfig |  6 +-
 .../wireless/mediatek/mt76/mt7603/beacon.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  7 ++-
 .../wireless/mediatek/mt76/mt7603/eeprom.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  7 ++-
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/soc.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  7 ++-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 -
 .../net/wireless/mediatek/mt76/mt76x0/Kconfig | 12 +++-
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   | 13 +---
 .../wireless/mediatek/mt76/mt76x0/pci_mcu.c   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 40 +++++++------
 .../net/wireless/mediatek/mt76/mt76x0/phy.h   | 10 ++--
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   | 16 ++---
 .../wireless/mediatek/mt76/mt76x0/usb_mcu.c   | 13 +---
 drivers/net/wireless/mediatek/mt76/mt76x02.h  | 38 +++++-------
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 17 +-----
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_dfs.h  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_dma.h  | 13 +---
 .../wireless/mediatek/mt76/mt76x02_eeprom.c   | 13 +---
 .../wireless/mediatek/mt76/mt76x02_eeprom.h   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 29 +++------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 26 +++-----
 .../net/wireless/mediatek/mt76/mt76x02_mcu.h  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 24 +++-----
 .../net/wireless/mediatek/mt76/mt76x02_phy.c  | 16 +----
 .../net/wireless/mediatek/mt76/mt76x02_phy.h  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_regs.h | 41 +++++--------
 .../wireless/mediatek/mt76/mt76x02_trace.c    | 13 +---
 .../wireless/mediatek/mt76/mt76x02_trace.h    | 16 +----
 .../net/wireless/mediatek/mt76/mt76x02_txrx.c | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_usb.h  | 13 +---
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 15 +----
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 33 ++++-------
 .../net/wireless/mediatek/mt76/mt76x2/Kconfig | 14 ++++-
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    | 23 +++-----
 .../wireless/mediatek/mt76/mt76x2/eeprom.h    | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/init.c  | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/mac.c   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/mac.h   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/mcu.c   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/mcu.h   | 16 +----
 .../wireless/mediatek/mt76/mt76x2/mt76x2.h    | 13 +---
 .../wireless/mediatek/mt76/mt76x2/mt76x2u.h   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   | 13 +---
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  | 14 +----
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 13 +---
 .../wireless/mediatek/mt76/mt76x2/pci_mcu.c   | 17 +-----
 .../wireless/mediatek/mt76/mt76x2/pci_phy.c   | 13 +---
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   | 18 ++----
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   | 13 +---
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  | 13 +---
 .../wireless/mediatek/mt76/mt76x2/usb_mac.c   | 13 +---
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 13 +---
 .../wireless/mediatek/mt76/mt76x2/usb_mcu.c   | 13 +---
 .../wireless/mediatek/mt76/mt76x2/usb_phy.c   | 13 +---
 drivers/net/wireless/mediatek/mt76/trace.c    | 13 +---
 drivers/net/wireless/mediatek/mt76/trace.h    | 22 ++-----
 drivers/net/wireless/mediatek/mt76/tx.c       | 31 ++++------
 drivers/net/wireless/mediatek/mt76/usb.c      | 44 ++++++--------
 .../net/wireless/mediatek/mt76/usb_trace.c    | 13 +---
 .../net/wireless/mediatek/mt76/usb_trace.h    | 24 +++-----
 drivers/net/wireless/mediatek/mt76/util.c     | 13 +---
 drivers/net/wireless/mediatek/mt76/util.h     |  4 +-
 86 files changed, 321 insertions(+), 971 deletions(-)

-- 
2.18.0

