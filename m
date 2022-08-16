Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB0594F12
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 05:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiHPDdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 23:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiHPDdD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 23:33:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CFC4DB2A
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 17:03:58 -0700 (PDT)
X-UUID: 889af7f08d64410099eff1c47d739df2-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Lm1AQw3YFZZlPESa4lMip8VKuSZLiDNwaOiCz0WcwXc=;
        b=VSMCgO+btMY61zeH/VpbLm4auohuvGrujdCKitxz9eO3x+Nshw6ofTbjExF22agvHe0G/t4KUxbUj0gMgJ3zRmfp7N9mi1oiG+oGlt1AFa+p6d8QOF2am5ghGRC+fRbRpaUVSBfVh+zNV2fdaXc2yJX3UEWnVfjXBhAF8He8BaU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:cc6e036f-225e-4fd3-adee-574d5cc95595,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:ef1163fd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 889af7f08d64410099eff1c47d739df2-20220816
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 227099095; Tue, 16 Aug 2022 08:03:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 08:03:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 08:03:53 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>
Subject: [PATCH 0/9] wifi: mt76: mt7921: introduce chanctx support
Date:   Tue, 16 Aug 2022 08:03:38 +0800
Message-ID: <cover.1660606893.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <objelf@gmail.com>

The patchset introduces chanctx support to enable the capability
on the newer firmware to manage the channel context scheduling on multiple 
roles running on the device including Station, AP, and P2P GC/GO mode
(will be extended based on the patchset in the future) to help users share
the network with others on a single device.
 
The things to be noted is that
1) The newer firmware is able to support the channel chanctx up to 2
interfaces simultaneously running on the different channels.

2) Before the driver is going sent out the management frames, the driver
has to get the privilege from the firmware to acquire the current channel
context for the frame until the frame handshake is completed and then get
the privilege back to the firmware.

3) The patchset has to rely on
("mt76: mt7921: fix the firmware version report")
("mt76: mt7921: add mt7921_mutex_acquire at mt7921_[start, stop]_ap")

Quan Zhou (1):
  wifi: mt76: mt7921: add unified ROC cmd/event support

Sean Wang (8):
  wifi: mac80211: allow enabling chanctx until hw registration
  wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
  wifi: mt76: connac: rely on mt76_connac_mcu_uni_set_chctx
  wifi: mt76: mt7921: add chanctx parameter to
    mt76_connac_mcu_uni_add_bss signature
  wifi: mt76: mt7921: drop ieee80211_[start, stop]_queues in driver
  wifi: mt76: connac: accept hw scan request at a time
  wifi: mt76: mt7921: introduce remain_on_channel support
  wifi: mt76: mt7921: introduce chanctx support

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 152 ++++++------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  16 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  74 +++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 225 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 151 +++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  54 +++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  13 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |   1 +
 net/mac80211/main.c                           |   8 +
 12 files changed, 620 insertions(+), 89 deletions(-)

-- 
2.25.1

