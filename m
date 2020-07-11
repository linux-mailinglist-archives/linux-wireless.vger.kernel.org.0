Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564521C244
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2020 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGKEf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jul 2020 00:35:27 -0400
Received: from mout01.posteo.de ([185.67.36.65]:59486 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgGKEf0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jul 2020 00:35:26 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7AC3416005C
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2020 06:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1594442124; bh=0ctE+bpyS5tnIfYE4wskqtGvHRlRDTGqPaJ9OIOnNDs=;
        h=From:To:Cc:Subject:Date:From;
        b=iw9hzNEqM378iP/dgqv3UEMUY8UKvKbO8PGhpKn/vCH/gAGiBnLhl9F2UUImhQWXx
         lzGvjm4NeQxMZSyI7LCtj9auKjKc2Sefj1sloddDstVfrO9BEkdicf/J026++wGCq1
         GFVB5OQthsM9QHIxfpg2loi76RSvemF7wANCPmpJ0Cr/1R3rptC/BW5t0Lua4KDhVK
         Oxy6KXi3QZEYrFOeHD3aGh53ptIwG3Dy5R0RoWoGYQRw+hfGRWhSqoFiFdmYQ84xAM
         zzOACfNMs1F240J4FOdlzD6mOZ3tbIIj14LFRF1EXuVkdS4ZLSunP4QbXek/5aIwIF
         1Fse7GagYQnzw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4B3cXV2fc9z6tmH;
        Sat, 11 Jul 2020 06:35:22 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, jaegerskuepper@freenet.de,
        hqjagain@gmail.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kuba@kernel.org,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 1/1] ath9k: Fix regression with Atheros 9271
Date:   Sat, 11 Jul 2020 05:33:24 +0100
Message-Id: <20200711043324.8079-1-shiftee@posteo.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fix allows ath9k_htc modules to connect to WLAN once again.

Fixes: 2bbcaaee1fcb (ath9k: Fix general protection fault in
ath9k_hif_usb_rx_cb )

https://bugzilla.kernel.org/show_bug.cgi?id=208251

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 4ed21dad6a8e..3f563e02d17d 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -733,11 +733,13 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 			return;
 		}
 
+		rx_buf->skb = nskb;
+
 		usb_fill_int_urb(urb, hif_dev->udev,
 				 usb_rcvintpipe(hif_dev->udev,
 						 USB_REG_IN_PIPE),
 				 nskb->data, MAX_REG_IN_BUF_SIZE,
-				 ath9k_hif_usb_reg_in_cb, nskb, 1);
+				 ath9k_hif_usb_reg_in_cb, rx_buf, 1);
 	}
 
 resubmit:
-- 
2.25.1

