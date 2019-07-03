Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEA5EF55
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGCW71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 18:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCW71 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 18:59:27 -0400
Received: from localhost.localdomain (unknown [151.66.63.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FB421852;
        Wed,  3 Jul 2019 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562194766;
        bh=tK0bwoh0DZW3O8b2Evp1fkNVQ+2DsqhKOGe4Q8PuKws=;
        h=From:To:Cc:Subject:Date:From;
        b=nCqtx2Bb59Y9806MHSctLiQ5Imd4v5wuhLdQueTC3DlTeaHrkAbkZ2AH1vJfjUPvS
         c1SY9FyJALGM+6fLVuuPmBjsELXvBHGgHQTq8lqspbYKKwBm7AFdXBm4HH+9G8KJoi
         BQUR5RG5hiXSAS2EnaNt5nGfEiHwYHmXoUYSSKCY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76u: fix typo in mt76u_fill_rx_sg
Date:   Thu,  4 Jul 2019 00:59:19 +0200
Message-Id: <d1e4f6fbda5044fa99920ec34cfee145fdb78240.1562194654.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix typo setting urb->transfer_buffer_length in mt76u_fill_rx_sg

Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 87ecbe290f99..5be584ca7497 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -309,7 +309,7 @@ mt76u_fill_rx_sg(struct mt76_dev *dev, struct mt76_queue *q, struct urb *urb,
 	}
 
 	urb->num_sgs = max_t(int, i, urb->num_sgs);
-	urb->transfer_buffer_length = urb->num_sgs * q->buf_size,
+	urb->transfer_buffer_length = urb->num_sgs * q->buf_size;
 	sg_init_marker(urb->sg, urb->num_sgs);
 
 	return i ? : -ENOMEM;
-- 
2.21.0

