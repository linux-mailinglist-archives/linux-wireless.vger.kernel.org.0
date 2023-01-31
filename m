Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA36828F4
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAaJgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjAaJgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B129173
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:36 -0800 (PST)
X-UUID: bd86c890a14a11ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rgBgoPIks5ILoAiAo1k2ULVWyeQf7aPW4gZTo3R8QaQ=;
        b=LboazErbLBZ6zK73z9R4fHtXfxlZUAC7mv5GuG+P+pDimiUc+bC6p25CDKt69R3Q13flvSpA/tJtV2p/ZkaVY0slFHIJWcYLBZmA/z5ZvcM1YrnGwLQe3mo2osF+uxVI7kAGQKo74P9ud+5UveQR73aQj3E5ErC1HT9YNoPZ3cE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:eb3e5d2b-aa46-4093-895f-9e2adb76a4e8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:6132758d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: bd86c890a14a11ed945fc101203acc17-20230131
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1947778696; Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:28 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 00/13] Add EHT support for mt7996
Date:   Tue, 31 Jan 2023 17:35:58 +0800
Message-ID: <20230131093611.30914-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds initial EHT support for mt7996 driver, which currently
covers features of EHT SU mode. More EHT features are work in progress
and will be introduced in further patches.

This series is based on the following series:
- wifi: mt76: mt7996: fix chainmask calculation in mt7996_set_antenna()
  https://patchwork.kernel.org/project/linux-wireless/patch/20221223101348.11504-1-shayne.chen@mediatek.com/

v2:
  - add eth param to mt76_ethtool_worker() to prevent from breaking HE stats

MeiChia Chiu (1):
  wifi: mt76: mt7996: add EHT beamforming support

Shayne Chen (12):
  wifi: mt76: add EHT phy type
  wifi: mt76: connac: add CMD_CBW_320MHZ
  wifi: mt76: connac: add helpers for EHT capability
  wifi: mt76: connac: add cmd id related to EHT support
  wifi: mt76: increase wcid size to 1088
  wifi: mt76: add EHT rate stats for ethtool
  wifi: mt76: mt7996: add variants support
  wifi: mt76: mt7996: add helpers for wtbl and interface limit
  wifi: mt76: mt7996: rework capability init
  wifi: mt76: mt7996: add EHT capability init
  wifi: mt76: mt7996: add support for EHT rate report
  wifi: mt76: mt7996: enable EHT support in firmware

 drivers/net/wireless/mediatek/mt76/mac80211.c |  11 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  13 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   2 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  46 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  12 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |   8 +-
 .../wireless/mediatek/mt76/mt7996/eeprom.c    |  27 ++
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 400 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  36 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 186 +++++++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  16 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  25 +-
 15 files changed, 603 insertions(+), 195 deletions(-)

-- 
2.25.1

