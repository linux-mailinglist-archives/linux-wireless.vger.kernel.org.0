Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D77F1169
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 12:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjKTLMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 06:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjKTLMe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 06:12:34 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A49CA
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 03:12:26 -0800 (PST)
X-UUID: aa8538f8879511ee8051498923ad61e6-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BsSCm70mq5AoV9r7Z1lc9GCE2m40BM4QlABLaPUH+30=;
        b=n3EhlIYTCS10n3MOdmjyLZAp1oK31SUpMiDTPTNUQ+DYpSR6TQK5lsAdffneDDQCKEdfBow3reBX9UXF3j/bGGWWV6fdYbnJm/QtW0W2gG+jdnUQos6jlYXT3zGl0uAwQo5xjeu3osWA0wWrLe9ShBgQWU8F+99s2ZuTpx3eXWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:143e1cde-a780-4312-b791-c10adadcfe00,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:e68cbcfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa8538f8879511ee8051498923ad61e6-20231120
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <mingyen.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1993251843; Mon, 20 Nov 2023 19:12:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 19:12:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 19:12:14 +0800
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
Subject: [PATCH 0/3] wifi: mt76: mt7921: series with CLC patches
Date:   Mon, 20 Nov 2023 19:12:09 +0800
Message-ID: <20231120111212.4478-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.977900-8.000000
X-TMASE-MatchedRID: 4M8Lw78TDBAiTMmg/YMPl/mF8IFnUmgvvtVce6w5+K/kCKFvqJHeycGw
        54FJXlHCglNnMw5K+QHf/Q5fuxsUmuHXfiMoZowZA9lly13c/gFflOpBqBHTt2JkJOQVCIpwXaT
        Eoipb2i/i8zVgXoAltmHJPdY2OmlS0C1sQRfQzEHEQdG7H66TyN+E/XGDLHcMcEwR/lUrI4/IAQ
        yo5EcbTaUygT9zhjsMFBNIqkML13AuAU3sQBBsfa8dqR+7hPzjIoYkU2kqUYAkrkfkoD8DTS/Im
        xChdfO6jofsMjQaxVwyYjbiqIQ3CsykhtyXcigD6rVdgBjDT2oh1j2M6LiVMg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.977900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 08E8DD8199CB859747E7CEFA4FEED6DEC11740009BDF273A8FB543E727143A562000:8
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>

Sync internal mt7921 patches for CLC.

---

Ming Yen Hsieh (3):
  wifi: mt76: mt7921: fix country count limitation for CLC
  wifi: mt76: mt7921: fix CLC command timeout when suspend/resume
  wifi: mt76: mt7921: fix wrong 6Ghz power type

 .../net/wireless/mediatek/mt76/mt7921/init.c  | 23 ++++++++---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 38 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 11 ++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 ++
 5 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.18.0

