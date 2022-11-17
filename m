Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AEA62E29C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiKQRKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 12:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbiKQRKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 12:10:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF2D9E
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 09:09:58 -0800 (PST)
X-UUID: 360e9b5cde55410793fdabbdc88bd420-20221118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rY8/JCNCxGV6XsNclBP6t4jZ+yj7aG0gjOCHl/IH2jc=;
        b=ZrmupqGAJIzgqYhsqaCmq2MBrizfb0zearnBI+Ttgte229qTXhW7HEj391GEXD0lLzZEf+91bt7I49oWHzztrm2QAxxV3CJi1cISzvYtJfexregAOPxsZrCSCy47UmWRttvPS4hpbLL26vVFoSZ0Wd7OKcYHoBBChRNsvt6NRB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:7ac60ac9-b7cf-4168-a749-050675d9e233,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.13,REQID:7ac60ac9-b7cf-4168-a749-050675d9e233,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:d12e911,CLOUDID:543e7fdb-6ad4-42ff-91f3-18e0272db660,B
        ulkID:22111801095325BJGZON,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 360e9b5cde55410793fdabbdc88bd420-20221118
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 305728231; Fri, 18 Nov 2022 01:09:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 18 Nov 2022 01:09:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 18 Nov 2022 01:09:51 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: add missing MODULE_PARM_DESC
Date:   Fri, 18 Nov 2022 01:09:46 +0800
Message-ID: <02bd118d5ffff286c080d27fd7669095064cb75e.1668704608.git.ryder.lee@mediatek.com>
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

Add documentation for module_param so that they're visible with
modinfo command.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
index bb4b70401af5..d097a56dd33d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
@@ -9,6 +9,7 @@
 
 static bool coredump_memdump;
 module_param(coredump_memdump, bool, 0644);
+MODULE_PARM_DESC(coredump_memdump, "Optional ability to dump firmware memory");
 
 static const struct mt7915_mem_region mt7915_mem_regions[] = {
 	{
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3c840853a2c9..4f85bfb8baba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -12,6 +12,7 @@
 
 static bool wed_enable;
 module_param(wed_enable, bool, 0644);
+MODULE_PARM_DESC(wed_enable, "Enable Wireless Ethernet Dispatch support");
 
 static const u32 mt7915_reg[] = {
 	[INT_SOURCE_CSR]	= 0xd7010,
-- 
2.36.1

