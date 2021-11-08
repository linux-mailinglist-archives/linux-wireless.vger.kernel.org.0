Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6000C447D41
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhKHKGq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 05:06:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235023AbhKHKGp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 05:06:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B3F60E93;
        Mon,  8 Nov 2021 10:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636365841;
        bh=Y+T5bsMnbbzQB6m0GMxegklQ7JIROxGKD2d37xWQezs=;
        h=From:To:Cc:Subject:Date:From;
        b=YRF32TyWxFHnTJQYT4hCBEpmAf4yr+1skHfmSSEGUQmS9LPFFZ1uLz7vwaU5Fh9lK
         KMu74FGYWyc1Bn5Lrckm7B3JqXUvy+MWzJMfUK9ryypadbdU0ayHj5m3oK0caBPww4
         9Hc+ol9IXlps4hWFVopWMv7tU7Z/AJ7e1sdNLSfpw1IaQCvS2ei9BKYN/cF8GJxdT9
         qwUnI2dzZdUzYQCIfSLxQhZkh6PbDmzg4KMzoRL8Ck4kJm3aN+Xy+BL3RlgVlhY1bC
         OW8ruB4met74YoxEL1uGIgb/XehcVTGPvSrUEFZ4AsOJHoMBWV5Do4N+nsTItTnW60
         75P0PxdZIlEgA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: debugfs: fix queue reporting for mt76-usb
Date:   Mon,  8 Nov 2021 11:03:52 +0100
Message-Id: <8bd28bd456ba06057ecea0f32b2e89981df77aca.1636365714.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix number of rx-queued frames reported by mt76_usb driver.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2d8be76c1674 ("mt76: debugfs: improve queue node readability")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index b8bcf22a07fd..47e9911ee9fe 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -82,7 +82,7 @@ static int mt76_rx_queues_read(struct seq_file *s, void *data)
 
 		queued = mt76_is_usb(dev) ? q->ndesc - q->queued : q->queued;
 		seq_printf(s, " %9d | %9d | %9d | %9d |\n",
-			   i, q->queued, q->head, q->tail);
+			   i, queued, q->head, q->tail);
 	}
 
 	return 0;
-- 
2.31.1

