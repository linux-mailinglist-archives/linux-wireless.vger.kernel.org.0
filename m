Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C97409E4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjF1Hwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50406 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230499AbjF1Hwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:34 -0400
X-UUID: 6918c982158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/Oq5xoynfS7rW1FF6Umo1czO+RibBSaj30BY5Sfz4zI=;
        b=OgvMbsywz7NIf1z6Lga5nFOcL6Id6VKv8giQmHhDfVg5Mxs2r+5Z1DfyXUXRXJhP1POhZJlfQ0jjof/+CZcUcUwAzfYCk2eVjs61XSsaB0nyLp5lqkDx0kEKVISPrn7NbNKIlkBY2kfLKc2UVuk8XqvLYIW3DnkI8vUfzKAAn+w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:022a6962-7b33-42c9-8aea-75e2cf4ac8fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:62d05eda-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6918c982158211eeb20a276fd37b9834-20230628
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 347375755; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:13 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 00/16] mt76: introduce mt792x-lib support
Date:   Wed, 28 Jun 2023 15:05:46 +0800
Message-ID: <cover.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set includes the new module mt792x-lib support.

Move some common header/functions from mt7921 to mt792x and also rename prefix
to mt792x. The new module would integrate the common functionalities of mt76
station driver mt7921 and upcoming WiFi7 solution.

(This patch set is too big to review. I will post another series with
remaining patches)

Lorenzo Bianconi (16):
  wifi: mt76: mt7921: move common register definition in mt792x_regs.h
  wifi: mt76: mt7921: convert acpisar and clc pointers to void
  wifi: mt76: mt7921: rename mt7921_vif in mt792x_vif
  wifi: mt76: mt7921: rename mt7921_sta in mt792x_sta
  wifi: mt76: mt7921: rename mt7921_phy in mt792x_phy
  wifi: mt76: mt7921: rename mt7921_dev in mt792x_dev
  wifi: mt76: mt7921: rename mt7921_hif_ops in mt792x_hif_ops
  wifi: mt76: mt792x: move shared structure definition in mt792x.h
  wifi: mt76: mt7921: move mt792x_mutex_{acquire/release} in mt792x.h
  wifi: mt76: mt7921: move mt792x_hw_dev in mt792x.h
  wifi: mt76: mt792x: introduce mt792x-lib module
  wifi: mt76: mt7921: move mac shared code in mt792x-lib module
  wifi: mt76: mt7921: move dma shared code in mt792x-lib module
  wifi: mt76: mt7921: move debugfs shared code in mt792x-lib module
  wifi: mt76: mt7921: move init shared code in mt792x-lib module
  wifi: mt76: mt792x: introduce mt792x_irq_map

 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   5 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   2 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   4 +-
 .../wireless/mediatek/mt76/mt7921/acpi_sar.c  |  25 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   | 228 +----
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 127 +--
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 288 +------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 380 +--------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 787 ++++-------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 120 +--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 297 ++-----
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  97 ++-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  14 +-
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  12 +-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 464 +---------
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  26 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |   6 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  14 +-
 .../wireless/mediatek/mt76/mt7921/testmode.c  |   8 +-
 .../net/wireless/mediatek/mt76/mt7921/trace.c |  12 -
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  34 +-
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   |  16 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 275 ++++++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 792 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt792x_debugfs.c   | 168 ++++
 .../net/wireless/mediatek/mt76/mt792x_mac.c   | 313 +++++++
 .../net/wireless/mediatek/mt76/mt792x_regs.h  | 479 +++++++++++
 .../net/wireless/mediatek/mt76/mt792x_trace.c |  14 +
 .../{mt7921/mt7921_trace.h => mt792x_trace.h} |  16 +-
 30 files changed, 2611 insertions(+), 2416 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_core.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_trace.c
 rename drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} (68%)

-- 
2.18.0

