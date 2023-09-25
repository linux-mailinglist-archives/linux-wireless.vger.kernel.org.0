Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5C7AD2C4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjIYILH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjIYILG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51FA2
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 01:11:00 -0700 (PDT)
X-UUID: 0c6020845b7b11eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=R3Bb1nrCF1oV2g5dOdB8Ph18kjGirLPr99ocUJVK3jc=;
        b=AjlUCFoBaYe0qBHheMsleGdvlwOYHcpcfX1ig6AfbeWtR1txEOEACr7z+vTsa7s0QLeNLTt6vN/kLXk78wh2X0yeq3RZIPAeot3mmWCfg2zJJjs9HbLGBGRtoOlrrcvhsWdVH2S/Mm85psYPk/mWRtsrlO1Scc40EuFd4LLjLyQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2df31e63-fd30-47d3-a915-561ed0197d9a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:e7475714-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0c6020845b7b11eea33bb35ae8d461a2-20230925
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 258683809; Mon, 25 Sep 2023 16:10:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 16:10:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 16:10:52 +0800
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
Subject: [PATCH 0/6] support per-device regulatory settings
Date:   Mon, 25 Sep 2023 16:10:32 +0800
Message-ID: <cover.1695627867.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.009000-8.000000
X-TMASE-MatchedRID: fVi3P7wwuziT7j3lOi4TQ7bQFsbjObJeCt59Uh3p/NWyjjoaU0ns0J1I
        RllGCL0aKI5Q2HQKDwWgMg/vVFp1mGqJrgOBmG6qQpxiLlDD9FVMkOX0UoduuQCGaccd4ae9DYJ
        QbNnE3Z3jCeE5v4lH5IAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGozzTLFRnsvHlhAaNCcqjMgsGG
        Ct/FhJQrc4q1dzctJNG5BUnwnZfeA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.009000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 41D8B72AC835A29244D3F47E4EC5040FEDDCF452D07E210D104A326BF9B670462000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
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

