Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A1624CEB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 22:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiKJVZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 16:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiKJVYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FB606B9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 13:24:03 -0800 (PST)
X-UUID: 9cc1af037ecc4867bbe178ed611690fa-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=teuHkv5/WCHYN8cyBmqAA1uZzTp4W2Go4JgJtfwgek4=;
        b=IQkCP0M/AEG+qXKt8Anqd1ZrqbttO87kn8yQmOOfQL3OzMJ2TbZTfBUiVwXCZmpBqF/Nyu9n7sYxcaibfWeloOaDZS68t1XeYVGRjVd42XJ9ATbv179WfYp2iZ0/DxrFmiNe6D14KBSHde0ECZM7NmgUyWYBZrgrs+M6njEd/QA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:7304679b-5a59-4868-90aa-e02d46f996ea,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.12,REQID:7304679b-5a59-4868-90aa-e02d46f996ea,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:62cd327,CLOUDID:ff26ef85-088c-4756-8f76-577be701e693,B
        ulkID:221111052356N6NLJX1W,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 9cc1af037ecc4867bbe178ed611690fa-20221111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1999923225; Fri, 11 Nov 2022 05:23:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 11 Nov 2022 05:23:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 05:23:54 +0800
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
        <linux-mediatek@lists.infradead.org>,
        "Sean Wang" <objelf@gmail.com>
Subject: [PATCH v3 0/7] wifi: mt76: mt7921: introduce chanctx support
Date:   Fri, 11 Nov 2022 05:23:42 +0800
Message-ID: <cover.1668068326.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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

From: Sean Wang <objelf@gmail.com>

Update the driver to adapt the new firmware can have the capability to
manage the channel context scheduling on multiple roles running on the
device including Station, AP and P2P GC/GO mode (will be extended based
on the future patchset) to help users sharing the network with others
on a single device.

=== v2 ===
(at 1/7)
1. remove unneeded newline
2. squash this one with "wifi: mt76: connac: rely on
   mt76_connac_mcu_uni_set_chctx"

(at 3/7)
1. remove unneeded newline and use 'u8 rsv' instead of origin one

(at 4/7)
1. drop mt7921_mcu_bss_event that is unused any more

(at 6/7)
1. move mt7921_check_offload_capability prior to ieee80211_alloc_hw
   and decie what ieee80211_ops instance we should use by the
   firmware capability bit.

(at 7/7)
1. decide the feature by the firmware capability bit
2. decide the channel by the hardware value in
   mt7921_get_status_freq_info()

=== v3 ===

(at 6/7)
1. fix mt7921/usb.c:231:7: error: no member named 'ops' in
   'struct mt7921_dev'
2. fix mt7921/main.c:425:13: warning: variable 'err' set but not used
   [-Wunused-but-set-variable]
3. fix mt7921/init.c:173:9: warning: variable 'features' is used
   uninitialized whenever 'while' loop exits because its condition is false
   [-Wsometimes-uninitialized]

(at 7/7)
1. enhance the git message

Quan Zhou (1):
  wifi: mt76: mt7921: add unified ROC cmd/event support

Sean Wang (6):
  wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
  wifi: mt76: mt7921: add chanctx parameter to
    mt76_connac_mcu_uni_add_bss signature
  wifi: mt76: mt7921: drop ieee80211_[start, stop]_queues in driver
  wifi: mt76: connac: accept hw scan request at a time
  wifi: mt76: mt7921: introduce remain_on_channel support
  wifi: mt76: mt7921: introduce chanctx support

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 151 +++++-----
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  16 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  90 +++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  10 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 278 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 161 ++++++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  69 +++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  26 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  17 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  16 +-
 11 files changed, 717 insertions(+), 119 deletions(-)

-- 
2.25.1

