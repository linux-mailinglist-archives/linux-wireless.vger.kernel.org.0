Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376AF64C23F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 03:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiLNC2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 21:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLNC2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 21:28:21 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7A71EEDF
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 18:28:16 -0800 (PST)
X-UUID: 3139abf548d248a3b5d85a4d003f4ec6-20221214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QGUc/lRqRgjWi2rVlEjt4jIndjYYgAmh7BkUd/moSKY=;
        b=hjUGWs6/dJbq7V5JKtINoehyuBtitPJrTLkt1LfIDfg9zMHhsEbKe1NQv67LYpxrnHPeaDlbi1+9DCJWnmY98zdkf6Jr0svC+JLNJikiLdtrkWsDv7oVLOeVswtq72rUpJcrMLChZfnPd9sYMEt5Z3i9QlLkWWthFzBye82OsPo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:7309b372-f9df-4f84-a657-c67db676e492,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:7309b372-f9df-4f84-a657-c67db676e492,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:cbe08ad2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:2212141028143A2ZBL98,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3139abf548d248a3b5d85a4d003f4ec6-20221214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <howard-yh.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1219106080; Wed, 14 Dec 2022 10:28:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 14 Dec 2022 10:28:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 14 Dec 2022 10:28:11 +0800
From:   Howard Hsu <howard-yh.hsu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>
Subject: [PATCH v3 0/4] rework thermal protection
Date:   Wed, 14 Dec 2022 10:28:05 +0800
Message-ID: <20221214022809.32087-1-howard-yh.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Rework thermal protection with the following changes:
1. Send thermal fw commands only after mcu init done.
2. Firmware expects to disable thermal protect before reconfiguring thermal protect.
3. Send fw commands through mt7915_thermal_temp_store() to update firmware
temperature directly.
4. Add error messages for invalid setting.

Howard Hsu (4):
  wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only
    after init_work
  wifi: mt76: mt7915: rework mt7915_mcu_set_thermal_throttling
  wifi: mt76: mt7915: rework mt7915_thermal_temp_store()
  wifi: mt76: mt7915: add error message in
    mt7915_thermal_set_cur_throttle_state()

 .../net/wireless/mediatek/mt76/mt7915/init.c  | 32 +++++++----
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 11 ++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 54 +++++++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  6 +++
 4 files changed, 70 insertions(+), 33 deletions(-)

-- 
2.18.0

