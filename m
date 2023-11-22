Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0FB7F3C2B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 04:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjKVDHV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 22:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjKVDHS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 22:07:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420A1717
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 19:07:00 -0800 (PST)
X-UUID: 31151aec88e411eea33bb35ae8d461a2-20231122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DZevSJ76L4vjCaPRJ6tBPf9dQRqxUGEJwvXNdUtjq9k=;
        b=BlM/YeT1X4O3YXYK9Vl+U5L5lU/0DjgWO737iz4yamTumoO1ZfW3SJ0JD2gIp8dAIshnXRfxgSijUlNnZQwoXX8LbnNWjPgjUmZorJSBZ2XL06BDB7t4pHOGYuxGDnin6Qn8KbmY/8yh3m1lmyv7I2zqb2kFrpC1/bXVz/r4b78=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:aa74c201-46db-4008-abe1-2c0e0feb0b43,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:682aed72-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 31151aec88e411eea33bb35ae8d461a2-20231122
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <mingyen.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1535694921; Wed, 22 Nov 2023 11:06:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Nov 2023 11:06:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 22 Nov 2023 11:06:54 +0800
From:   Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo@kernel.org>
CC:     <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>,
        <Ryder.Lee@mediatek.com>, <Shayne.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
Subject: [PATCH v4 0/3] wifi:mt76: mt7921: fix issues for CLC
Date:   Wed, 22 Nov 2023 11:06:43 +0800
Message-ID: <20231122030646.31784-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>

The CLC is Country Location Control which is a feature to make sure
mt7921 series working properly in any country.

This patchset is used to fix issues caused by the added 6Ghz control.

---

Ming Yen Hsieh (3):
  wifi: mt76: mt7921: fix country count limitation for CLC
  wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
  wifi: mt76: mt7921: fix wrong 6Ghz power type

v2:
  - Convert wrong variable type to correct.
v3:
  - Due to the lack of patch version's subject-prefix in v2, v3
    is updated to include the patch version's subject-prefix.
v4:
  - Improve the format and readability of commit message.

 .../net/wireless/mediatek/mt76/mt7921/init.c  | 23 ++++++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 38 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 11 ++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 ++
 5 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.18.0

