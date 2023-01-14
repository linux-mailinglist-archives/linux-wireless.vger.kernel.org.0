Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2ED66A94B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jan 2023 05:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjANE5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 23:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjANE5R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 23:57:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F4935AC
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 20:57:12 -0800 (PST)
X-UUID: e3ac375293c711ed945fc101203acc17-20230114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3q8eUrFQGCvox/fCQJWQXBx4k/sv4dLG8kGb0Zo/4+Q=;
        b=Up0mH1Zwf+c+0EcNO6N2xtbU4tdlYqaaiMRv2V9n6WavO2IV7Q+6C1uOLJpGDPzkqSOumW1DGLc97uC8d64qWSeuZVlh6/ZAWxi17KYAzu9oZzy7Rwj3T5othniMLGzbPssFTphxTzJtl7QeZImraeq/RSWpIantBhfSQ4jM34Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:df60f65a-1add-4ac5-9922-77f67b415d21,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:543e81c,CLOUDID:660a3a8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: e3ac375293c711ed945fc101203acc17-20230114
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1340597885; Sat, 14 Jan 2023 12:57:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 14 Jan 2023 12:57:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 14 Jan 2023 12:57:03 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7921: reduce polling time in pmctrl
Date:   Sat, 14 Jan 2023 12:56:47 +0800
Message-ID: <09ec100ccffd791acba8ad0521e486e309ff4644.1673670759.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <4113f5787a4e15271698219c61367d5105109c92.1673670759.git.deren.wu@mediatek.com>
References: <4113f5787a4e15271698219c61367d5105109c92.1673670759.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Due to the polling tick is 10ms, the wake up flow in the status waiting
would cause more 10~20ms than the real HW response time. Reduce
tick-interval from 10ms to 1ms to get better network performance, such
as ping latency, in low power mode.

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 86340d3205c5..288caa728afc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -69,8 +69,8 @@ int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
 		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_CLR_OWN);
-		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
-				   PCIE_LPCR_HOST_OWN_SYNC, 0, 50))
+		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
+					PCIE_LPCR_HOST_OWN_SYNC, 0, 50, 1))
 			break;
 	}
 
@@ -110,8 +110,8 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev)
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
 		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
-		if (mt76_poll_msec(dev, MT_CONN_ON_LPCTL,
-				   PCIE_LPCR_HOST_OWN_SYNC, 4, 50))
+		if (mt76_poll_msec_tick(dev, MT_CONN_ON_LPCTL,
+					PCIE_LPCR_HOST_OWN_SYNC, 4, 50, 1))
 			break;
 	}
 
-- 
2.18.0

