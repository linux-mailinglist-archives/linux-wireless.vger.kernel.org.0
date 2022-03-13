Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE94D7550
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 13:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiCMMuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiCMMud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 08:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB276E792
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 05:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59485610E7
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 12:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587E3C340E8;
        Sun, 13 Mar 2022 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647175764;
        bh=7ghIDG7930tgRqC4mgjloK/gSp+YSv4hNVjtC4qVZ9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mohrq6g2y43BsaCcvkIqo/WEILKmShznMlZhwSVKaSukpr8UcPdoiOE9jasr43Mpg
         N701hsugiSNpHWEpbCPoiHKeSORi3UZcc0yQ/jGinOi852OPO/ojX0kc6RpKJ3vzyS
         5sqaNa5rQcVrOo4QdsLRJYA6v7kTDpie+dZZ87CPRAka0NXJ4fc0pUv2NnPYdUsPnY
         2DkGO/xOAm/1/mL6NzuVCuwhd0iYxX2gsF2FI1D6mORqmFCdmPdj2XNCo0ASKQaBpR
         LNMhLDopu3tpJuDziZKrfkXdrJpYkT7pgRoosSCxAr4eZwtjlB9QkBxWp1qzu78FgT
         /kZXo9aAfW/pQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/9] mt76: usb: add req_type to ___mt76u_wr signature
Date:   Sun, 13 Mar 2022 13:48:52 +0100
Message-Id: <241585dbdeabd1bd889e70d2e40897aceeead4e3.1647175554.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647175554.git.lorenzo@kernel.org>
References: <cover.1647175554.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/usb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 1b0435e0ea33..4b7a816f1b93 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -121,16 +121,14 @@ static u32 mt76u_rr_ext(struct mt76_dev *dev, u32 addr)
 	return ret;
 }
 
-static void ___mt76u_wr(struct mt76_dev *dev, u8 req,
+static void ___mt76u_wr(struct mt76_dev *dev, u8 req, u8 req_type,
 			u32 addr, u32 val)
 {
 	struct mt76_usb *usb = &dev->usb;
 
 	put_unaligned_le32(val, usb->data);
-	__mt76u_vendor_request(dev, req,
-			       USB_DIR_OUT | USB_TYPE_VENDOR,
-			       addr >> 16, addr, usb->data,
-			       sizeof(__le32));
+	__mt76u_vendor_request(dev, req, req_type, addr >> 16,
+			       addr, usb->data, sizeof(__le32));
 	trace_usb_reg_wr(dev, addr, val);
 }
 
@@ -146,7 +144,8 @@ static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 		req = MT_VEND_MULTI_WRITE;
 		break;
 	}
-	___mt76u_wr(dev, req, addr & ~MT_VEND_TYPE_MASK, val);
+	___mt76u_wr(dev, req, USB_DIR_OUT | USB_TYPE_VENDOR,
+		    addr & ~MT_VEND_TYPE_MASK, val);
 }
 
 static void mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
@@ -159,7 +158,8 @@ static void mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 static void mt76u_wr_ext(struct mt76_dev *dev, u32 addr, u32 val)
 {
 	mutex_lock(&dev->usb.usb_ctrl_mtx);
-	___mt76u_wr(dev, MT_VEND_WRITE_EXT, addr, val);
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | USB_TYPE_VENDOR, addr, val);
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 }
 
@@ -180,7 +180,8 @@ static u32 mt76u_rmw_ext(struct mt76_dev *dev, u32 addr,
 	mutex_lock(&dev->usb.usb_ctrl_mtx);
 	val |= ___mt76u_rr(dev, MT_VEND_READ_EXT,
 			   USB_DIR_IN | USB_TYPE_VENDOR, addr) & ~mask;
-	___mt76u_wr(dev, MT_VEND_WRITE_EXT, addr, val);
+	___mt76u_wr(dev, MT_VEND_WRITE_EXT,
+		    USB_DIR_OUT | USB_TYPE_VENDOR, addr, val);
 	mutex_unlock(&dev->usb.usb_ctrl_mtx);
 
 	return val;
-- 
2.35.1

