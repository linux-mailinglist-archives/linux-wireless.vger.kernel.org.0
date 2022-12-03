Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6E6413F9
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 04:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLCDWo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 22:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiLCDWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 22:22:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5509F7A
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 19:22:36 -0800 (PST)
X-UUID: 621310b373df4458a468c18ccea0f619-20221203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=F3N+BXWVouR7PHRflmwklN0n51QgK3XV+XrOP4kaVCk=;
        b=ag9+AMTPWlSZ1l3aqzbiOYyHGEIT5lonwEVfMEthAp7zXliU7CKmU4dHc2Pf8e9PrIr8RVpUPIkACLXx65+S0hbP5B9pZiTqMP3SH9DGYT49logRN56S4A4opyrMT8PAzy//2TBHE++y5QhQoRzh0fYl5WDTmU/x9qsv5iY4teg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f116ad4c-9b3d-4cef-9cce-e88877434a03,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:4edc061f-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 621310b373df4458a468c18ccea0f619-20221203
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1000535550; Sat, 03 Dec 2022 11:22:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 3 Dec 2022 11:22:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 3 Dec 2022 11:22:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/4] wifi: mt76: mt7915: fix mt7915_rate_txpower_get() resource leaks
Date:   Sat, 3 Dec 2022 11:22:22 +0800
Message-ID: <ce05914d5a4d73cea21ef2c359f3a5bb7c61a86e.1670037462.git.ryder.lee@mediatek.com>
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

Coverity message: variable "buf" going out of scope leaks the storage.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527799 ("Resource leaks")
Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limit support")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index fb46c2c1784f..a7fdcd1f3d98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -996,7 +996,7 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 
 	ret = mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr));
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Txpower propagation path: TMAC -> TXV -> BBP */
 	len += scnprintf(buf + len, sz - len,
@@ -1047,6 +1047,8 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 			 mt76_get_field(dev, reg, MT_WF_PHY_TPC_POWER));
 
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+
+out:
 	kfree(buf);
 	return ret;
 }
-- 
2.18.0

