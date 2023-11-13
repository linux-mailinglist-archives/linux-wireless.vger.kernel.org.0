Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A637E96E3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 08:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjKMHHX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 02:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjKMHHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 02:07:21 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C310E6
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 23:07:18 -0800 (PST)
X-UUID: 464b232c81f311ee8051498923ad61e6-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jXEkGXbCtbIOJZL0eBlMntvmSAcsoRmhqUeWr+79ffA=;
        b=XUkbZMQquQ+UcjQ0rsZtqx1BfbopKgFNSP+OKvRTJo439sxf5Wc5z61C2GE+urv1FPNHUnQEI908WP7J+bF0xZM9STNgXFvNuDRZhWMjHJ5HqexDrkQRi2HF5YoKMzoUhczmeScfKCQAM/gji62gks3FdHANU3r2TEQNq0oWsuA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:eef2f62f-8036-4aba-af1f-41da03d87a9b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:c8d35295-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 464b232c81f311ee8051498923ad61e6-20231113
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 36710698; Mon, 13 Nov 2023 15:07:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 15:07:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 15:07:13 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 0/8] Add MT7992 support
Date:   Mon, 13 Nov 2023 15:06:11 +0800
Message-ID: <20231113070619.19964-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.991100-8.000000
X-TMASE-MatchedRID: kSL0NBRKvPcReJdaDf25josKNaNh88CQsf4f4CxxueRcKZwALwMGs4AX
        rQfh62buh/90MLI5dilYk91062MLlxqXhvBXA7wbpN8sp+Lj7S2uiRuR9mCaureKIZi8OZjkZvo
        +mFW19mDuzcUA0q2gBaBVvEjzNBpCHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgW3IYlFO6bAPz8mx
        h8UlOgf4GAyHU6rIh/EaXigxqt+eBmmpZSqWPzmMm15M0FklN1jR3SUzToIMOFoaBrz1hy1aF0b
        WWhkpVEwZBgUyJVEbl6Fw8/PpTMRaVvmiAyeA2kc5MSfkiJFI5p3LlElBHTlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.991100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9A30C7B4BEA3F2AC459A9BEC0AAE65AAE7B50DBC6A8ADE8B0145ECE5779372942000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for MT7992 (Filogic 660) PCI Wi-Fi device, which
is a Wi-Fi 7 chipset supporting concurrent dual-band operation on 2.4 GHz
and 5 GHz.

Benjamin Lin (2):
  wifi: mt76: mt7996: add DMA support for mt7992
  wifi: mt76: connac: add new definition of tx descriptor

Shayne Chen (1):
  wifi: mt76: mt7996: introduce mt7996_band_valid()

StanleyYP Wang (5):
  wifi: mt76: connac: add firmware support for mt7992
  wifi: mt76: mt7996: rework register offsets for mt7992
  wifi: mt76: mt7996: support mt7992 eeprom loading
  wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992
  wifi: mt76: mt7996: add PCI IDs for mt7992

 .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 ++
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 72 +++++++++++----
 .../wireless/mediatek/mt76/mt7996/eeprom.c    | 18 +++-
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 42 +++++----
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  7 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 38 +++++---
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 59 ++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 33 +++++--
 .../net/wireless/mediatek/mt76/mt7996/pci.c   | 12 ++-
 .../net/wireless/mediatek/mt76/mt7996/regs.h  | 90 +++++++++++++------
 12 files changed, 294 insertions(+), 86 deletions(-)

-- 
2.39.2

