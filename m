Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A716F8E8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 07:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfGVFbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 01:31:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57949 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726828AbfGVFbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 01:31:48 -0400
X-UUID: 464717b4aab84c9bbaa077f2461d53e3-20190722
X-UUID: 464717b4aab84c9bbaa077f2461d53e3-20190722
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1494925954; Mon, 22 Jul 2019 13:31:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 13:31:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 13:31:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 0/5] fix many checkpatch.pl warnings
Date:   Mon, 22 Jul 2019 13:31:10 +0800
Message-ID: <cover.1563772403.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D88AAD105EC9225DD30B2F9F5271DCFFB9D4DF55DF588392D29FB6F86391F2712000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This gathers many subsets to fix checkpatch.pl warnings.
I still keep some warnings there due to readability.
(The most of them are - networking block comments or 80 characters limit)

Ryder Lee (5):
  mt76: Add paragraphs to describe the config symbols fully
  mt76: mt7603: fix some checkpatch warnings
  mt76: mt7615: fix some checkpatch warnings
  mt76: mt76x02: fix some checkpatch warnings
  mt76: fix some checkpatch warnings

 drivers/net/wireless/mediatek/mt76/agg-rx.c   | 21 +++++----
 drivers/net/wireless/mediatek/mt76/dma.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 30 ++++++------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 46 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7603/Kconfig |  6 ++-
 .../wireless/mediatek/mt76/mt7603/beacon.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/dma.c   |  7 +--
 .../wireless/mediatek/mt76/mt7603/eeprom.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  7 +--
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/soc.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |  7 ++-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 -
 .../net/wireless/mediatek/mt76/mt76x0/Kconfig | 12 ++++-
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 23 ++++++----
 .../net/wireless/mediatek/mt76/mt76x0/phy.h   | 10 ++--
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  6 +--
 drivers/net/wireless/mediatek/mt76/mt76x02.h  | 25 +++++-----
 .../wireless/mediatek/mt76/mt76x02_beacon.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 16 +++----
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 13 +++---
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 11 +++--
 .../net/wireless/mediatek/mt76/mt76x02_phy.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt76x02_regs.h | 28 +++++------
 .../wireless/mediatek/mt76/mt76x02_trace.h    |  3 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 20 ++++----
 .../net/wireless/mediatek/mt76/mt76x2/Kconfig | 14 ++++--
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    | 10 ++--
 .../net/wireless/mediatek/mt76/mt76x2/mcu.h   |  3 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  1 -
 .../wireless/mediatek/mt76/mt76x2/pci_mcu.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   |  3 +-
 drivers/net/wireless/mediatek/mt76/trace.h    |  9 ++--
 drivers/net/wireless/mediatek/mt76/tx.c       | 18 ++++----
 drivers/net/wireless/mediatek/mt76/usb.c      | 31 +++++++------
 .../net/wireless/mediatek/mt76/usb_trace.h    | 11 +++--
 drivers/net/wireless/mediatek/mt76/util.h     |  4 +-
 46 files changed, 242 insertions(+), 202 deletions(-)

-- 
2.18.0

