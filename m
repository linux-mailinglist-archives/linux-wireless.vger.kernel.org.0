Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C14CE58E
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Mar 2022 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiCEPjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Mar 2022 10:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiCEPjm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Mar 2022 10:39:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA223BEF
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 07:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF4FB80C8D
        for <linux-wireless@vger.kernel.org>; Sat,  5 Mar 2022 15:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D2EC004E1;
        Sat,  5 Mar 2022 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646494728;
        bh=7ghIDG7930tgRqC4mgjloK/gSp+YSv4hNVjtC4qVZ9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNnG/gc0YH6gmEnlPgEgijojtim8ciwYZVSnRZ6oC7c2eiDgHHKxVqxxlgTFMQ5k7
         MvqMZJt+Lq+Ao1utthjPyrfV0Ghue62ojU2qWPgjCeP635LsaO+r3a6ClozSGwCeV2
         Z5l5nHihgCJKm79WHB2ouaR3g191g1VN+AT/ORycqX+p9rvxXzPnPZ4YysN5X8bCMr
         AG+51AcIHxGVytuJgKdwFw2D8TzhHUsTrmdmzebWTyVJCbCCmAisK4iPAjJ0E2pVTP
         Jban404sJDAHDjM+JQJ2/aDyqL3OYIbFGL+mHZo7y7yQ5raGDj+0tzwj3skh4OVdoQ
         Pj4wQep2Ln/YQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/9] mt76: usb: add req_type to ___mt76u_wr signature
Date:   Sat,  5 Mar 2022 16:38:12 +0100
Message-Id: <8e36680d6f280108d264a0166957f3f12b2c731f.1646494452.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646494452.git.lorenzo@kernel.org>
References: <cover.1646494452.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

