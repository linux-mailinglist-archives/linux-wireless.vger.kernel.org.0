Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B309576B794
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjHAOeM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjHAOeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:34:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CC1FDA
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:34:01 -0700 (PDT)
X-UUID: 6fae4e6e307811eeb20a276fd37b9834-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yIA+2vIzbKX+LVlxn9e4QPp6knbsnBKT0RZyRYqmwg0=;
        b=Y7MWv9oonDm4DiwaW7wwCJVdkIGk7F/+CumNv+FK+zk0Dr8xDStqFCcdcIFjdA4Z+V8ZiSjBZ/Nn2PHTkJlKi8fTyoUmX/QZwS0BliPGCwHkR1nsA/Tqvrft9IqDNsh/vf13tDIJdryn6e0WpxoWAM5FHb1J/eeWfNpFmak6sWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:2a5480a1-1630-4993-8eb2-02d92e7092e0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:521f08b4-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6fae4e6e307811eeb20a276fd37b9834-20230801
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 149975275; Tue, 01 Aug 2023 22:33:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:33:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:33:51 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 0/8] wifi: mt76: mt792x: add mt7925 support
Date:   Tue, 1 Aug 2023 22:30:24 +0800
Message-ID: <cover.1690863143.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch set adds more functionalities for mt7925 to reuse common layer,
connac and mt792x. This is a preliminary patch to add mt7925 chipset support.

Deren Wu (8):
  wifi: mt76: connac: introduce helper for mt7925 chipset
  wifi: mt76: mt792x: support mt7925 chip init
  wifi: mt76: connac: export functions for mt7925
  wifi: mt76: connac: add eht support for phy mode config
  wifi: mt76: connac: add eht support for tx power
  wifi: mt76: connac: add data field in struct tlv
  wifi: mt76: connac: add more unified command IDs
  wifi: mt76: connac: add more unified event IDs

 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  6 ++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 60 +++++++++++++------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 33 +++++++++-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  6 ++
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 49 ++++++++++-----
 7 files changed, 123 insertions(+), 36 deletions(-)

-- 
2.18.0

