Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC3645369
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 06:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLGFZg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 00:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLGFZf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 00:25:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0854B0E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 21:25:33 -0800 (PST)
X-UUID: ccbee714f3d649e786a159324d6aa70e-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oO5PI/Fj9lDxvpBZ4+z2h1v1CjMaqqoCf03Q8Z/fPUM=;
        b=YH0Z8ZX3oNcEBWzI3SU6DGBNFsSpdrGyLXuy4FC+FRAddQGr1mZWaoj1NhJdAvPEw0uutaiclP12seMAm1BcYOzaiYaaXnxcuL3x9+3w3Wq3E/iWWboVpHPEmU9FZu2DjtD7ckq1597jeLhQP95Z/zqLm+w5dmqA4WyIzS1nAg0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ae4e6d6b-c629-49b4-aff3-5185165a4906,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.14,REQID:ae4e6d6b-c629-49b4-aff3-5185165a4906,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:dcaaed0,CLOUDID:d04edfd1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:221207132531B0OZMGNO,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ccbee714f3d649e786a159324d6aa70e-20221207
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 865106028; Wed, 07 Dec 2022 13:25:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:25:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 13:25:28 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v2 0/3] wifi: mt76: mt7915: rework thermal protection
Date:   Wed, 7 Dec 2022 13:24:57 +0800
Message-ID: <20221207052500.10855-1-howard-yh.hsu@mediatek.com>
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

*** BLURB HERE ***

Howard Hsu (3):
  wifi: mt76: mt7915: rework mt7915_thermal_set_cur_throttle_state()
  wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only
    after init_work
  wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling()

 .../net/wireless/mediatek/mt76/mt7915/init.c  | 21 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 +++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 +++++++++--------
 3 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.18.0

