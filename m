Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3C952E838
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiETJEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 05:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiETJEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 05:04:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26AEAD2A
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 02:04:03 -0700 (PDT)
X-UUID: ea964a35bced48f48ed0769782e46feb-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4b16dcb3-f01e-4278-935c-4b2e86aa4e7f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:d114ff79-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: ea964a35bced48f48ed0769782e46feb-20220520
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1607449350; Fri, 20 May 2022 17:03:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 17:03:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 17:03:57 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 0/3] introduce ACPI SAR support
Date:   Fri, 20 May 2022 17:03:36 +0800
Message-ID: <cover.1653032296.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Introduce ACPI SAR support for mt7921 serials.

Changes since v1:
- replace BIOS with ACPI
- replace "6G" with "6 GHz" in patch subject
- remove unnecessary function export

Deren Wu (3):
  mt76: add 6 GHz band support in mt76_sar_freq_ranges
  mt76: mt7921: introduce ACPI SAR support
  mt76: mt7921: introduce ACPI SAR config in tx power

 drivers/net/wireless/mediatek/mt76/mac80211.c |   6 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   1 +
 .../wireless/mediatek/mt76/mt7921/acpi_sar.c  | 279 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/acpi_sar.h  |  93 ++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  31 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  22 ++
 7 files changed, 426 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h

-- 
2.18.0

