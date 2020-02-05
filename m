Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0F153C21
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 00:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBEXx3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 18:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEXx3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 18:53:29 -0500
Received: from localhost.lan (unknown [151.48.147.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9AD20672;
        Wed,  5 Feb 2020 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580946809;
        bh=75pGg25zQlqJAGaOEaJDaAbAlapyhumudLnxCz7BDzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASoSscm2CzGxp1gTPdTm+ieQH1+LU4LuqG9rYaKcWYqs/yqsbp67cell/xY4UMCyu
         ckNJDiuVt/hfsB0sV97Sidwq/EVobgpwApYA2hkj3H1JeLMdgXmcQJj+LTGbLgki/d
         fnl4o7YXeLTd7FCKcpH11BKx2LZVnf4VAi/4sUX0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: generalize mt76_mcu_get_response routine
Date:   Thu,  6 Feb 2020 00:53:10 +0100
Message-Id: <3b386467d4a0b160742a305a78f1ebeca760d365.1580945999.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1580945999.git.lorenzo@kernel.org>
References: <cover.1580945999.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_mcu in mt76_mcu_get_response routine in order to reuse it
in usb code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mcu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index a2936f8de915..644f396a58a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -24,7 +24,6 @@ mt76_mcu_msg_alloc(const void *data, int head_len,
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_msg_alloc);
 
-/* mmio */
 struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 				      unsigned long expires)
 {
@@ -34,11 +33,11 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 		return NULL;
 
 	timeout = expires - jiffies;
-	wait_event_timeout(dev->mmio.mcu.wait,
-			   (!skb_queue_empty(&dev->mmio.mcu.res_q) ||
+	wait_event_timeout(dev->mcu.wait,
+			   (!skb_queue_empty(&dev->mcu.res_q) ||
 			    test_bit(MT76_MCU_RESET, &dev->phy.state)),
 			   timeout);
-	return skb_dequeue(&dev->mmio.mcu.res_q);
+	return skb_dequeue(&dev->mcu.res_q);
 }
 EXPORT_SYMBOL_GPL(mt76_mcu_get_response);
 
-- 
2.21.1

