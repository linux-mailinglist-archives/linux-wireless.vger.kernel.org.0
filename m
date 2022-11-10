Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFFE623EBF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 10:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKJJhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 04:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKJJhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 04:37:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B1667F7C
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 01:36:59 -0800 (PST)
X-UUID: 041aa6fc670a40868e6f1084b52f56ca-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ap/uZUa19gYgZAqa91nfpfnFpXg72cD/89ZSdgoCoZ4=;
        b=gVMSy4eJS0TwL3qe2UhrI3h7tbNcqTKOuAbbFy3kjfMPlh/UyW5xy2/klme3WGpOcYdDgYnRCbtYJiPUnLUySkKLOHocMENCe+i7DzKxk/+SY+OAddeQdubKqDSIJ5Aa/Ca7t5pguPVZQNlhlEmvVShXpQMBMl6JpJYv2ULxf4Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:0ccd6a54-cbcc-4c4e-bdea-59bce881d115,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:3d52e950-b7af-492d-8b40-b1032f90ce11,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 041aa6fc670a40868e6f1084b52f56ca-20221110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1142324615; Thu, 10 Nov 2022 17:36:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 17:36:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 17:36:50 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 0/9] Add driver for MediaTek Wi-Fi 7 devices
Date:   Thu, 10 Nov 2022 17:35:16 +0800
Message-ID: <20221110093525.29649-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds mt7996, a new mac80211 driver for MediaTek Wi-Fi 7
(802.11be) devices, which currently supports AP, station, mesh, and
monitor modes.

mt7996 first supports Filogic 680, which is a Wi-Fi 7 chipset supporting
concurrent tri-band operation at 6 GHz, 5 GHz, and 2.4 GHz with 4x4
antennas on each band. There are several variants that will be added in
upcoming patches. For more details, please refer to [1].

mt7996 supports only Wi-Fi 6E at the moment, whereas Wi-Fi 7 and its
specific features are work in progress. They will be introduced in
further patches.

The driver has had multiple developers listed in the series.

[1] https://corp.mediatek.com/news-events/press-releases/mediatek-announces-worlds-first-complete-wi-fi-7-platforms-for-access-points-and-clients

This series is based on the following series and patches:
- wifi: mt76: fix bandwidth 80MHz link fail in 6GHz band
  https://patchwork.kernel.org/project/linux-wireless/patch/85b5e8374fc9b86fb955060c1840f3b2a1d187e4.1666614616.git.deren.wu@mediatek.com/
- mt76: move aggr_stats array in mt76_phy
  https://patchwork.kernel.org/project/linux-wireless/cover/cover.1667427944.git.lorenzo@kernel.org/

v2:
- rebase on top of aggr_stats series to prevent from breaking other drivers
- clean up unused mcu commands
- fix some commands that haven't been changed to unified command format
- update fw path

Shayne Chen (9):
  wifi: mt76: connac: rework macros for unified command
  wifi: mt76: connac: update struct sta_rec_phy
  wifi: mt76: connac: rework fields for larger bandwidth support in
    sta_rec_bf
  wifi: mt76: connac: add more unified command IDs
  wifi: mt76: connac: introduce unified event table
  wifi: mt76: connac: add more bss info command tags
  wifi: mt76: connac: add more starec command tags
  wifi: mt76: connac: introduce helper for mt7996 chipset
  wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    3 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   69 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   10 +-
 .../net/wireless/mediatek/mt76/mt7996/Kconfig |   12 +
 .../wireless/mediatek/mt76/mt7996/Makefile    |    6 +
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  851 ++++
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  360 ++
 .../wireless/mediatek/mt76/mt7996/eeprom.c    |  229 ++
 .../wireless/mediatek/mt76/mt7996/eeprom.h    |   75 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  816 ++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 2468 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  398 ++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 1325 +++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 3428 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  662 ++++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  385 ++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  516 +++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  222 ++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  533 +++
 22 files changed, 12363 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/regs.h

-- 
2.25.1

