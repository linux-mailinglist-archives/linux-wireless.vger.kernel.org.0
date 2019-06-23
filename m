Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFB4FDF7
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jun 2019 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFWUZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jun 2019 16:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfFWUZu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jun 2019 16:25:50 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476A0206BA;
        Sun, 23 Jun 2019 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561321550;
        bh=RjBLGJHfT47z8RzOmxU5J+Hvch8cvFgDtYFuBqpKkzw=;
        h=From:To:Cc:Subject:Date:From;
        b=S3eouUc5bweVoq/v4zLUQjKwirE/rmHRMZGKTVnxA1/SotDb6DMh6NQv57073qzkL
         tSY5vlzCqxU0jjJfWikmo4DHKv3Z4YS00x/AuYxc93wXxi96lIJVHYIs0hYET2006Q
         9x6it+g3kiGqwLpNYyUSPm4LDG9kdvN8XR29tEkg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76u: get rid of {out,in}_max_packet
Date:   Sun, 23 Jun 2019 22:25:39 +0200
Message-Id: <6b649fcb88cc22a5a29199e701ec48865102a573.1561321281.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove {out,in}_max_packet from mt76_usb data structure since
they just track last usb endpoint and they are not actually used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 2 --
 drivers/net/wireless/mediatek/mt76/usb.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 27f5dfb8c77f..2c107817610c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -397,9 +397,7 @@ struct mt76_usb {
 	struct delayed_work stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
-	u16 out_max_packet;
 	u8 in_ep[__MT_EP_IN_MAX];
-	u16 in_max_packet;
 	bool sg_en;
 
 	struct mt76u_mcu {
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index ecc1aa59f5c1..fb87ce7fbdf6 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -267,12 +267,10 @@ mt76u_set_endpoints(struct usb_interface *intf,
 		if (usb_endpoint_is_bulk_in(ep_desc) &&
 		    in_ep < __MT_EP_IN_MAX) {
 			usb->in_ep[in_ep] = usb_endpoint_num(ep_desc);
-			usb->in_max_packet = usb_endpoint_maxp(ep_desc);
 			in_ep++;
 		} else if (usb_endpoint_is_bulk_out(ep_desc) &&
 			   out_ep < __MT_EP_OUT_MAX) {
 			usb->out_ep[out_ep] = usb_endpoint_num(ep_desc);
-			usb->out_max_packet = usb_endpoint_maxp(ep_desc);
 			out_ep++;
 		}
 	}
-- 
2.21.0

