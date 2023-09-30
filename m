Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449AC7B3D9B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Sep 2023 04:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjI3CZk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 22:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjI3CZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 22:25:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1281B3
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 19:25:31 -0700 (PDT)
X-UUID: 9a6fba2c5f3811ee8051498923ad61e6-20230930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dLx30+l8wXNWnXJVQ+9TCbsEPqDxvrdIJ6mAOGtQKWg=;
        b=rS6P+9Vp5bKSKhXL8kO/wQdVN6t5Gfa0cSM7kHd3QgPTVLqD0qd2LZLm4vUj+XnV3fxusL0FTVJVWPP1tUaCD0Xv8YPDvWlq4YxA3H4azaKjMQPIN8WUNSXTk27gqH32Wavc1MyGvQlPdcDMGN4VWcDsHUJ1iQoS2SzzYrawKkk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f85409a7-9e01-44ec-923b-3406f10668b3,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:ae709dc3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9a6fba2c5f3811ee8051498923ad61e6-20230930
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1594798567; Sat, 30 Sep 2023 10:25:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 30 Sep 2023 10:25:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 30 Sep 2023 10:25:19 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 0/6] wifi: mt76: mt7921: support per-device regulatory settings
Date:   Sat, 30 Sep 2023 10:25:04 +0800
Message-ID: <cover.1696039301.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some platform vendors need to apply their own regualtory settings and the
vendor-specific data would be written in dts or acpi. This patch set adds
the functionalities to handle this per-device 5.9/6GHz channel
configurations.

---
v2:
  * 6th patch in v1 is shown in wireless patchwork, resend this series to
    make the reivew easier
  * add preifx "wifi: mt76: mt7921:" in the title of cover letter

Deren Wu (1):
  wifi: mt76: mt7921: move connac nic capability handling to mt7921

Ming Yen Hsieh (4):
  wifi: mt76: mt7921: enable set txpower for UNII-4
  wifi: mt76: mt7921: add 6GHz power type support for clc
  wifi: mt76: mt7921: get regulatory information from the clc event
  wifi: mt76: mt7921: update the channel usage when the regd domain
    changed

rong.yan (1):
  wifi: mt76: mt7921: support 5.9/6GHz channel config in acpi

 drivers/net/wireless/mediatek/mt76/eeprom.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   5 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 122 +-------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  51 ++++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  34 ++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 157 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  13 ++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  19 +++
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  |  53 ++++++
 .../wireless/mediatek/mt76/mt792x_acpi_sar.h  |   2 +
 12 files changed, 336 insertions(+), 130 deletions(-)

-- 
2.18.0

