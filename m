Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6681E4D76BB
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiCMQYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiCMQYU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 12:24:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8C3DA48
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 09:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C29B80B9F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 16:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC81C340E8;
        Sun, 13 Mar 2022 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647188590;
        bh=kiAGpf+4zwJ+zHiQl7xLk7QVnsQZlXGbdf0DELrdgHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+f/UZTueDzDubnUGzT+VCCxDrqxdMwCMbzLEBZOAJv8EB7p3VF+cTtOAvdAwARIm
         AXZC+V2WT8zX/QNUBg1rSx2YWnmRYEVv2BYC/Mila1YLUAiEeeZ+vuNpZpyNZ49mCx
         nheqsZsRh4yz9mK2NEx7ksWgqET1r+2eZTGkmXNwuQqNZY2l/3abvRBTE9yOfe1we2
         tSj3Nv1xtsilvQH/IJfTfv5nw8mH5Y+9aQkRhYHNk4uIxsxmQVfnBkPtCRStNVhGUO
         HWHwEi3CS6B2PCPY5UVAcG1lA3at/qeQknFrH09i76oDhk4mPNpLorwB1g6EOukV8h
         BnXo15iVw/UlQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 1/9] mt76: usb: add req_type to ___mt76u_rr signature
Date:   Sun, 13 Mar 2022 17:22:33 +0100
Message-Id: <f7efc2f855e4756ae13accfc990e2af69a1fb3f0.1647188301.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647188301.git.lorenzo@kernel.org>
References: <cover.1647188301.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add usb support to mt7921 driver.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 0a7006c8959b..1b0435e0ea33 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -62,16 +62,15 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 }
 EXPORT_SYMBOL_GPL(mt76u_vendor_request);
 
-static u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u32 addr)
+static u32 ___mt76u_rr(struct mt76_dev *dev, u8 req, u8 req_type,
+		       u32 addr)
 {
 	struct mt76_usb *usb = &dev->usb;
 	u32 data = ~0;
 	int ret;
 
-	ret = __mt76u_vendor_request(dev, req,
-				     USB_DIR_IN | USB_TYPE_VENDOR,
-				     addr >> 16, addr, usb->data,
-				     sizeof(__le32));
+	ret = __mt76u_vendor_request(dev, req, req_type, addr >> 16,
+				     addr, usb->data, sizeof(__le32));
 	if (ret == sizeof(__le32))
 		data = get_unaligned_le32(usb->data);
 	trace_usb_reg_rr(dev, addr, data);
@@ -95,7 +94,8 @@ static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
 		break;
 	}
 
-	return ___mt76u_rr(dev, req, addr & ~MT_VEND_TYPE_MASK);
+	return ___mt76u_rr(dev, req, USB_DIR_IN | USB_TYPE_VENDOR,
+			   addr & ~MT_VEND_TYPE_MASK);
 }
 
 static u32 mt76u_rr(struct mt76_dev *dev, u32 addr)
@@ -114,7 +114,8 @@ static u32 mt76u_rr_ext(struct mt76_dev *dev, u32 addr)
 	u32 ret;
 
 	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT, addr);
+	ret = ___mt76u_rr(dev, MT_VEND_READ_EXT,
+			  USB_DIR_IN | USB_TYPE_VENDOR, addr);
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 
 	return ret;
@@ -177,7 +178,8 @@ static u32 mt76u_rmw_ext(struct mt76_dev *dev, u32 addr,
 			 u32 mask, u32 val)
 {
 	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT, addr) & ~mask;
+	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT,
+			   USB_DIR_IN | USB_TYPE_VENDOR, addr) & ~mask;
 	___mt76u_wr(dev, MT_VEND_WRITE_EXT, addr, val);
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 
-- 
2.35.1

