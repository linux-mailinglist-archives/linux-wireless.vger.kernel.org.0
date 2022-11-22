Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4A063377C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 09:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiKVIwF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 03:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKVIwD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:03 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B62EF7F
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 00:52:01 -0800 (PST)
X-UUID: 79cba7add1f04b4ebe9f814a7d258424-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yauqpBX2S8mCdfVRXBU/hH7WgdxSH3iokDslKSp1jvE=;
        b=L5yhdohvV9HzujW+MuPucjfTgkau8z27IbrKv7LdAHqMZkypCCzzmearedOr0K09P0c5xJrEP59tKR0m8J1HgXbUIDGrdRdU8bhlzKQz3ChkA1/f63dRMebfccuVVvfZaFJlZaSlwbM8b71eI4XD/yX4zBEOnaGZnWUU3MhXg08=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.13,REQID:c1b507b7-c0e7-4b97-b102-49d7d4d8f566,IP:0,U
        RL:0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:195
X-CID-INFO: VERSION:1.1.13,REQID:c1b507b7-c0e7-4b97-b102-49d7d4d8f566,IP:0,URL
        :0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_US65DF41,ACTI
        ON:quarantine,TS:195
X-CID-META: VersionHash:d12e911,CLOUDID:11e0e5db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:2211221651591TNP7GIS,BulkQuantity:0,Recheck:0,SF:28|17|19|48|801,TC:
        nil,Content:3,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: 79cba7add1f04b4ebe9f814a7d258424-20221122
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 269665821; Tue, 22 Nov 2022 16:51:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 16:51:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 16:51:57 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH 0/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices
Date:   Tue, 22 Nov 2022 16:45:45 +0800
Message-ID: <20221122084554.9494-1-shayne.chen@mediatek.com>
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

Add MediaTek new mac80211 driver mt7996 for Wi-Fi 7 (802.11be) devices.
The driver first supports Filogic 680 PCI device, which is a Wi-Fi 7
chipset supporting concurrent tri-band operation at 6 GHz, 5 GHz, and
2.4 GHz with 4x4 antennas on each band.

Currently, mt7996 only supports tri-band HE or older mode.
EHT mode and more variants of Filogic 680 support will be introduced
in further patches.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Co-developed-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

----------------[commit message cut here]----------------

This series is based on the following series with fixes folded:
- https://patchwork.kernel.org/project/linux-wireless/cover/20221110093525.29649-1-shayne.chen@mediatek.com/

For easier review, the big patch has been splitted into multiple patches
per functionality. These patches will be folded into a single patch in
the final version.

Shayne Chen (9):
  wifi: mt76: mt7996: add PCI support
  wifi: mt76: mt7996: add DMA support
  wifi: mt76: mt7996: add MCU support
  wifi: mt76: mt7996: add EEPROM support
  wifi: mt76: mt7996: add MAC support
  wifi: mt76: mt7996: add ieee80211_ops
  wifi: mt76: mt7996: add debugfs support
  wifi: mt76: mt7996: add module support
  wifi: mt76: add mt7996 module support

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
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
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 3429 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |  662 ++++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  385 ++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  516 +++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  222 ++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  533 +++
 18 files changed, 12289 insertions(+)
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

