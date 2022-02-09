Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC44AEA2C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 07:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiBIGQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 01:16:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbiBIGME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 01:12:04 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730BC08EDC7
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 22:12:06 -0800 (PST)
X-UUID: da93700e5ee143a794b88f1d5ab52253-20220209
X-UUID: da93700e5ee143a794b88f1d5ab52253-20220209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1216009190; Wed, 09 Feb 2022 14:12:03 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Feb 2022 14:12:01 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Feb
 2022 14:11:59 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 9 Feb 2022 14:11:59 +0800
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
Subject: [PATCH v4 0/3] add mt7986 support
Date:   Wed, 9 Feb 2022 14:11:54 +0800
Message-ID: <cover.1644386694.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

This adds support for MT7986 SoC which integrated multi-band
4x4 WiFi 6/6E.
Detailed link: https://www.mediatek.com/products/mediatek-filogic-830

Bo Jiao (2):
  mt76: mt7915: add support for MT7986
  mt76: mt7915: introduce band_idx in mt7915_phy

Peter Chiu (1):
  dt-bindings: net: wireless: mt76: document bindings for MT7986

 .../bindings/net/wireless/mediatek,mt76.yaml  |   33 +-
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
 19 files changed, 2003 insertions(+), 238 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/soc.c

-- 
2.18.0

