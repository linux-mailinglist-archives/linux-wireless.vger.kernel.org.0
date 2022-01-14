Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D298C48E2B5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 03:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiANCxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 21:53:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43070 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236093AbiANCxi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 21:53:38 -0500
X-UUID: a4243c93a9de4da9831f4d9b2407e028-20220114
X-UUID: a4243c93a9de4da9831f4d9b2407e028-20220114
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 658998260; Fri, 14 Jan 2022 10:53:34 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Jan 2022 10:53:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Jan
 2022 10:53:26 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 14 Jan 2022 10:53:26 +0800
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
Subject: [PATCH v3 0/4] add mt7986 support
Date:   Fri, 14 Jan 2022 10:53:19 +0800
Message-ID: <cover.1642128031.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

This adds support for MT7986 SoC which integrated multi-band
4x4 WiFi 6/6E.
Detailed link: https://www.mediatek.com/products/mediatek-filogic-830

Bo Jiao (3):
  mt76: redefine mt76_for_each_q_rx to adapt mt7986 changes
  mt76: mt7915: add support for MT7986
  mt76: mt7915: introduce band_idx in mt7915_phy

Peter Chiu (1):
  dt-bindings: net: wireless: mt76: document bindings for MT7986

 .../bindings/net/wireless/mediatek,mt76.yaml  |   31 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |    4 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    6 +-
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |   10 +
 .../wireless/mediatek/mt76/mt7915/Makefile    |    1 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |    8 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |   28 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |   85 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |   13 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   54 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  209 +--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   21 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   81 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  125 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   44 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  277 +++-
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 1201 +++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/testmode.c  |   35 +-
 drivers/net/wireless/mediatek/mt76/testmode.c |    5 +-
 20 files changed, 2003 insertions(+), 240 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/soc.c

-- 
2.18.0

