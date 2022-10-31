Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4933613B84
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Oct 2022 17:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiJaQkh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Oct 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiJaQka (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Oct 2022 12:40:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC02DF6
        for <linux-wireless@vger.kernel.org>; Mon, 31 Oct 2022 09:40:22 -0700 (PDT)
X-UUID: 15e785896a724b14971adeaefeb25f4b-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hlsAKWFXZ/9dbRG3H7ebgrS+7UFooxS66lZl8/6LpO4=;
        b=VxMMie01g/Yz9WofY3vRp+K2jCgTo7uTmqIli+D46kh3aScs0keuGbf1eyiq7qHqt8KZW/bfjz9MhwiOFqGKAhtmEKclt0+sobSVPOGoLz1+ncKMjPmOPrcEcVcGt4q9V7B8Wnl6AtlNgErrDbuIqRaGQIH991koNZIpHNnxwSY=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:1d5f6317-2b81-4a1a-96d5-5abe3006f820,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:1d5f6317-2b81-4a1a-96d5-5abe3006f820,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:eeee2390-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:221101004014INUKDQXL,BulkQuantity:0,Recheck:0,SF:28|16|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 15e785896a724b14971adeaefeb25f4b-20221101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 677325817; Tue, 01 Nov 2022 00:40:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 00:40:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 1 Nov 2022 00:40:11 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 00/10] Add driver for MediaTek Wi-Fi 7 devices
Date:   Tue, 1 Nov 2022 00:39:50 +0800
Message-ID: <20221031164000.17063-1-shayne.chen@mediatek.com>
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

Shayne Chen (10):
  wifi: mt76: extend aggr_stats for tri-band support
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
 drivers/net/wireless/mediatek/mt76/mt76.h     |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |    5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |    3 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   66 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   10 +-
 .../net/wireless/mediatek/mt76/mt7996/Kconfig |   12 +
 .../wireless/mediatek/mt76/mt7996/Makefile    |    6 +
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  829 ++++
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  360 ++
 .../wireless/mediatek/mt76/mt7996/eeprom.c    |  229 ++
 .../wireless/mediatek/mt76/mt7996/eeprom.h    |   75 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  816 ++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 2472 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  398 ++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 1327 +++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 3478 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  636 +++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  385 ++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  521 +++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  222 ++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  533 +++
 23 files changed, 12374 insertions(+), 13 deletions(-)
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

