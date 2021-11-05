Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F14461D7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 11:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhKEKE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 06:04:59 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:48778 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232883AbhKEKE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 06:04:59 -0400
X-UUID: 8c5bbb419a004f5b9ae622348dd699a6-20211105
X-UUID: 8c5bbb419a004f5b9ae622348dd699a6-20211105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1323446366; Fri, 05 Nov 2021 18:02:16 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 5 Nov 2021 18:02:14 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Nov
 2021 18:02:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Nov 2021 18:02:12 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v2 00/11] add mt7916 support
Date:   Fri, 5 Nov 2021 18:01:59 +0800
Message-ID: <cover.1636105953.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

This adds support for mt7916 PCIe-based device, which shares the same
driver with MT7915. The maximum number of client connections is extended
to 512. mt7916 is capable of WIFI6@160MHz, simultaneous dual-band and
all WiFi6 R2 features.

Bo Jiao (11):
  mt76: mt7915: add mt7915_mmio_probe() as a common probing function
  mt76: mt7915: refine register definition
  mt76: mt7915: rework dma.c to adapt mt7916 changes
  mt76: mt7915: add firmware support for mt7916
  mt76: mt7915: rework eeprom.c to adapt mt7916 changes
  mt76: mt7915: enlarge wcid size to 544
  mt76: mt7915: add txfree event v3
  mt76: mt7915: update rx rate reporting for mt7916
  mt76: mt7915: update mt7915_chan_mib_offs for mt7916
  mt76: mt7915: add mt7916 calibrated data support
  mt76: mt7915: add device id for mt7916

 drivers/net/wireless/mediatek/mt76/dma.c      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   3 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 380 ++++++---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  87 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |   9 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  76 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 273 ++++---
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  98 ++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   8 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 757 ++++++++++++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  37 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 243 +-----
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 670 +++++++++++-----
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  58 +-
 17 files changed, 1908 insertions(+), 849 deletions(-)

-- 
2.18.0

