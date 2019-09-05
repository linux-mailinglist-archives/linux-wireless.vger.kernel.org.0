Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2EAA909
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 18:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbfIEQdG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 12:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbfIEQdG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 12:33:06 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3624F207E0;
        Thu,  5 Sep 2019 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567701186;
        bh=q1s0RaKk4zugfY9Ia+Mvs5FsJqMqplq4LQp9gKF161E=;
        h=From:To:Cc:Subject:Date:From;
        b=UZsipGlmDg9kk0bojTUqHc3oRyrs8n/Myu5S/K0PKVAfS0l/tiQRyQx5HBm21FOHk
         EgnJTSXOM+0OmelkJfsE4W+0G6r8OAuwiwrlMWo0but3TbtvIwBF3pSkmVcuGQqn8K
         /61lh4G0pG2wqOn/syc2lt+KqcKQW6gJumehOZow=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: usb: add lockdep_assert_held in __mt76u_vendor_request
Date:   Thu,  5 Sep 2019 18:32:58 +0200
Message-Id: <ac42b8b5c2a924417df020d817a7cea4ddd7c1a7.1567701052.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce lockdep_assert_held macro in __mt76u_vendor_request routine
and remove comments regarding usb_ctrl_mtx lock

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 20c6fe510e9d..cac058fc41ef 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -15,7 +15,6 @@ static bool disable_usb_sg;
 module_param_named(disable_usb_sg, disable_usb_sg, bool, 0644);
 MODULE_PARM_DESC(disable_usb_sg, "Disable usb scatter-gather support");
 
-/* should be called with usb_ctrl_mtx locked */
 static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 				  u8 req_type, u16 val, u16 offset,
 				  void *buf, size_t len)
@@ -24,6 +23,8 @@ static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 	unsigned int pipe;
 	int i, ret;
 
+	lockdep_assert_held(&dev->usb.usb_ctrl_mtx);
+
 	pipe = (req_type & USB_DIR_IN) ? usb_rcvctrlpipe(udev, 0)
 				       : usb_sndctrlpipe(udev, 0);
 	for (i = 0; i < MT_VEND_REQ_MAX_RETRY; i++) {
@@ -60,7 +61,6 @@ int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 }
 EXPORT_SYMBOL_GPL(mt76u_vendor_request);
 
-/* should be called with usb_ctrl_mtx locked */
 static u32 __mt76u_rr(struct mt76_dev *dev, u32 addr)
 {
 	struct mt76_usb *usb = &dev->usb;
@@ -103,7 +103,6 @@ static u32 mt76u_rr(struct mt76_dev *dev, u32 addr)
 	return ret;
 }
 
-/* should be called with usb_ctrl_mtx locked */
 static void __mt76u_wr(struct mt76_dev *dev, u32 addr, u32 val)
 {
 	struct mt76_usb *usb = &dev->usb;
-- 
2.21.0

