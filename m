Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65542F7DF7
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 15:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAOOS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 09:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAOOS4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 09:18:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23EE4224F9;
        Fri, 15 Jan 2021 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610720295;
        bh=xa8p3PJAJu0pUbyR6rmmLrS6ZjVHRVdf31M3+hGgSto=;
        h=From:To:Cc:Subject:Date:From;
        b=DmKU3OqQAEC4fH6Pc4KeNJaLqVjKA/Wc2B0GpvXMbIWJHcvJ2wSEugrlh/ikoFMXH
         LHRQJv0FbTggZtWhzXmyO0pMkrQHEDGhv84gBiwxjRBIwo9Gr0Tb8+2Rqt4LVdZuR/
         rkcW19NA/P7dpxf58c5vkZCa7dVDJQc9HnRsrAQEvWo6yDrLDY9l5L6k8S2ZmeGxWu
         xTIczPA3B1xcw3wFm3ohHklDAR+hUjKMo68Wz44fo+IGE8qx2w3VFiUAcxlDPI0f2z
         N8js4NXqXMOljth7u2b1zhQDedLxytVsSrdYyBZGnIYC+q35tLuzO+pd+SL+iiywFB
         TgLL7zLEhFVaw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: usb: process URBs with status EPROTO properly
Date:   Fri, 15 Jan 2021 15:18:02 +0100
Message-Id: <5b1218ba5ed84b5a3f9f3018e3e1433fcb5310d1.1610719959.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to commit '0e40dbd56d67 ("mt7601u: process URBs in status EPROTO
properly")', do no schedule rx_worker for urb marked with status set
-EPROTO

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index b95d093728b9..30bc54e98c58 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -612,6 +612,7 @@ static void mt76u_complete_rx(struct urb *urb)
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 	case -ENOENT:
+	case -EPROTO:
 		return;
 	default:
 		dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
-- 
2.29.2

