Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15A479EB6A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbjIMOoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbjIMOoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:44:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98999B
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:44:30 -0700 (PDT)
X-UUID: 072dceee524411eea33bb35ae8d461a2-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vHEByuk51dnpxNwwwDU41FxzBnDpRcDHW0NnBFYDvHc=;
        b=rIfKHEZSr0E7jEz+20J6dNyccSAp5c0mnXY9tSV3onGBgt4NRf93WXZfidDpyn6LHJieuh8CKJo6Dq5hGkuEFldT4DOqSICCZhohvWwbmex6NfmTAScQFBBchmeaxY8hO/2kEjHFqSQKvJUPmlZi6wefuOlrKyRFMXQ8lA+FAoA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:61265f88-323c-4b0a-a15b-a78facded9b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:16f4cbbe-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 072dceee524411eea33bb35ae8d461a2-20230913
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2130540337; Wed, 13 Sep 2023 22:44:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 22:44:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 22:44:21 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>,
        "Hao Zhang" <hao.zhang@mediatek.com>,
        Leon Yen <leon.yen@mediatek.com>,
        "Mingyen Hsieh" <mingyen.hsieh@mediatek.com>,
        Nelson Yu <nelson.yu@mediatek.com>,
        "Quan Zhou" <quan.zhou@mediatek.com>,
        Rong Yan <rong.yan@mediatek.com>
Subject: [PATCH v2 00/17] Add support for Mediatek Wi-Fi7 driver mt7925
Date:   Wed, 13 Sep 2023 22:43:28 +0800
Message-ID: <cover.1694595134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.407600-8.000000
X-TMASE-MatchedRID: tpf4JaSfocrGHadaRuAOvxv+r1s9z1a0Ct59Uh3p/NXo5/9VDsD0gA5x
        vr++qx3rYE8U75Rh/1qJ1uwZVAc3Y4uLXAHXNQlQXy2tkK+taSRAq6/y5AEOOhP6Y8Vsp9y7njM
        loJas2eeokhRcXx575036XrknL01IpXtZdNwHfyBc/msUC5wFQfaS52LUPfcSWSw/UjSfbBKijR
        a5rWHxdpu69huUx6EElW/4DesQXwfyHo8NfWdGk57tR0mnRAg12qBSQHAh8phnerzbhugqsuL25
        OtF/N4ANJnt9TW/xwZX/sAhRmSCr6o77AcuQhw7ngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIXzYx
        eQR1DvuajNrVmsKo4oovTOQcfOkE4ORErmbOWN8jUSx53AbF5PAEic5b778O
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.407600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5622A462BE50EE960569BDB43610539A9D4F188B3032D0496AAE0AFCEDAE8EF52000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds mt7925, a new mac80211 driver for MediaTek Wi-Fi 7
(802.11be) device Filogic 360, which can support Station, AP, P2P, and
monitor modes. Filogic 360 supports max 4096-QAM/160MHz radio operation at 6 GHz,
5 GHz, or 2.4 GHz with 2x2 antennas. This chip supports PCIe and USB bus type.

mt7925 supports Wi-Fi 6E and EHT rate with single link only at this moment,
whereas Wi-Fi 7 and its specific features are working in progress. They will be
introduced in further patches.

The driver is build tested by Intel's kernel test robot with both GCC and Clang
with several architecture. Sparse reports no warnings.

There are multiple authors, they are listed in alphabetical order below.

Co-developed-by: Hao Zhang <hao.zhang@mediatek.com>
Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Nelson Yu <nelson.yu@mediatek.com>
Signed-off-by: Nelson Yu <nelson.yu@mediatek.com>
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Co-developed-by: Rong Yan <rong.yan@mediatek.com>
Signed-off-by: Rong Yan <rong.yan@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>

----------------[commit message cut here]----------------

This patch set is based on preceding series "wifi: mt76: mt792x: add mt7925 support"
https://patchwork.kernel.org/project/linux-wireless/cover/cover.1690863143.git.deren.wu@mediatek.com/

v2:
- add patchwork link for preceding series
- rebase on top of staging tree and apply fixes for following new patches
  * 586baa51d755 ("wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb")
  * 29b8fc6742a1 ("wifi: mt76: fix race condition related to checking tx queue fill status")
  * e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer with sparse")

Deren Wu (17):
  wifi: mt76: mt7925: add Kconfig
  wifi: mt76: mt7925: add Makefile
  wifi: mt76: mt7925: add mt7925.h
  wifi: mt76: mt7925: add regs.h
  wifi: mt76: mt7925: add mcu.c
  wifi: mt76: mt7925: add mcu.h
  wifi: mt76: mt7925: add mac.c
  wifi: mt76: mt7925: add mac.h
  wifi: mt76: mt7925: add main.c
  wifi: mt76: mt7925: add init.c
  wifi: mt76: mt7925: add pci_mcu.c
  wifi: mt76: mt7925: add pci_mac.c
  wifi: mt76: mt7925: add pci.c
  wifi: mt76: mt7925: add usb.c
  wifi: mt76: mt7925: add debugfs.c
  wifi: mt76: add mt7925 to Makefile
  wifi: mt76: add mt7925 to Kconfig

 drivers/net/wireless/mediatek/mt76/Kconfig    |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile   |    1 +
 .../net/wireless/mediatek/mt76/mt7925/Kconfig |   30 +
 .../wireless/mediatek/mt76/mt7925/Makefile    |    9 +
 .../wireless/mediatek/mt76/mt7925/debugfs.c   |  319 ++
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  235 ++
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 1452 ++++++++
 .../net/wireless/mediatek/mt76/mt7925/mac.h   |   23 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 1471 ++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 3174 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  537 +++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  325 ++
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  586 +++
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  151 +
 .../wireless/mediatek/mt76/mt7925/pci_mcu.c   |   53 +
 .../net/wireless/mediatek/mt76/mt7925/regs.h  |   92 +
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |  340 ++
 17 files changed, 8799 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/usb.c

-- 
2.18.0

