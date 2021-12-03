Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C790467499
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351327AbhLCKSg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 05:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344816AbhLCKSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 05:18:35 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C90C06173E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 02:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NJvNgklxKypy1m7CZSYhbrsxcqhJCZ6URnlLVN2np20=; b=eKr2E9F8PbzGJnsDD+uhK27JtJ
        w9FFqYI4E0FRzqog0XREIDLFc2fyHp5rQ7x8ZpJgTiYovntE4Ux+B05CZ0teYNm4HINucROJhJDVY
        UBtyGspdyIpC7RVIny3gNFdEDHEEg8L1MJN1q9H7SHKG0USPxBgORfN3dCLJMTwX3cHM=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt5aw-0001Yw-8f
        for linux-wireless@vger.kernel.org; Fri, 03 Dec 2021 11:15:10 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: clear mcu error interrupt status on mt7663
Date:   Fri,  3 Dec 2021 11:15:08 +0100
Message-Id: <20211203101508.17720-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Should fix issues with error recovery

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 71719c787511..33f72f3657d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -135,6 +135,7 @@ static void mt7615_irq_tasklet(struct tasklet_struct *t)
 	if (is_mt7663(&dev->mt76)) {
 		mcu_int = mt76_rr(dev, MT_MCU2HOST_INT_STATUS);
 		mcu_int &= MT7663_MCU_CMD_ERROR_MASK;
+		mt76_wr(dev, MT_MCU2HOST_INT_STATUS, mcu_int);
 	} else {
 		mcu_int = mt76_rr(dev, MT_MCU_CMD);
 		mcu_int &= MT_MCU_CMD_ERROR_MASK;
-- 
2.30.1

