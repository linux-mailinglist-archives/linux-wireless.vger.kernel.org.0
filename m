Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED9361B97
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbhDPI2R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbhDPI2Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 04:28:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2FC061756
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H9NqjfY/ZznsdCuLt/3n0t60lEs59HN/314iPv4Hto0=; b=J71PEJjr/WeP96/4/FLszSinb0
        AHwMZUVDC3kAM0voyJzqX8M5W1gxZJqx7dK9yM8hI6jPBuj0RNIcFPpQckHJ5Ak8iRciRHEZV3v+2
        GbzCkdRvRVnY62mdhGikIg8DufustDPM8QZVtTqynVSwSK/fIzt2EYrEAbnTmS18ItMI=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lXJpM-0003tx-Uy
        for linux-wireless@vger.kernel.org; Fri, 16 Apr 2021 10:27:49 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7615: fix entering driver-own state on mt7663
Date:   Fri, 16 Apr 2021 10:27:45 +0200
Message-Id: <20210416082746.21825-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210416082746.21825-1-nbd@nbd.name>
References: <20210416082746.21825-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes hardware wakeup issues

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index eab490d07255..5f37255476e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -292,12 +292,20 @@ static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
 	u32 addr;
 	int err;
 
-	addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
+	if (is_mt7663(mdev)) {
+		/* Clear firmware own via N9 eint */
+		mt76_wr(dev, MT_PCIE_DOORBELL_PUSH, MT_CFG_LPCR_HOST_DRV_OWN);
+		mt76_poll(dev, MT_CONN_ON_MISC, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000);
+
+		addr = MT_CONN_HIF_ON_LPCTL;
+	} else {
+		addr = MT_CFG_LPCR_HOST;
+	}
+
 	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
 
 	mt7622_trigger_hif_int(dev, true);
 
-	addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
 	err = !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000);
 
 	mt7622_trigger_hif_int(dev, false);
-- 
2.30.1

