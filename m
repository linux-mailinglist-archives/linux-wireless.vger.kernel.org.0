Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3784F15F347
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 19:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392954AbgBNSKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 13:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730423AbgBNPxs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482DF24682;
        Fri, 14 Feb 2020 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695628;
        bh=JjKT3jkmYWo+VH1cMi7pE58cT6ZhUpPjOMoPMHW4uHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FhuiIjco4N+5ZuPxRhGmx8o6gilIjYrSxkKZF/SqikkkN99viJ9O/YBGFh+HfTu3B
         V2btztxG6euX+L/I2O3IdYowgXWsIMHdpjUqY5j+luW7bs3mRAoS0OCc8rWg128x02
         F2zU816KADIDPfnYchavOKLcMqKUo1VUqjo5ssIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phong Tran <tranmanphong@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 226/542] b43legacy: Fix -Wcast-function-type
Date:   Fri, 14 Feb 2020 10:43:38 -0500
Message-Id: <20200214154854.6746-226-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

[ Upstream commit 475eec112e4267232d10f4afe2f939a241692b6c ]

correct usage prototype of callback in tasklet_init().
Report by https://github.com/KSPP/linux/issues/20

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43legacy/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 4325e91736eb3..8b6b657c4b85b 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -1275,8 +1275,9 @@ static void handle_irq_ucode_debug(struct b43legacy_wldev *dev)
 }
 
 /* Interrupt handler bottom-half */
-static void b43legacy_interrupt_tasklet(struct b43legacy_wldev *dev)
+static void b43legacy_interrupt_tasklet(unsigned long data)
 {
+	struct b43legacy_wldev *dev = (struct b43legacy_wldev *)data;
 	u32 reason;
 	u32 dma_reason[ARRAY_SIZE(dev->dma_reason)];
 	u32 merged_dma_reason = 0;
@@ -3741,7 +3742,7 @@ static int b43legacy_one_core_attach(struct ssb_device *dev,
 	b43legacy_set_status(wldev, B43legacy_STAT_UNINIT);
 	wldev->bad_frames_preempt = modparam_bad_frames_preempt;
 	tasklet_init(&wldev->isr_tasklet,
-		     (void (*)(unsigned long))b43legacy_interrupt_tasklet,
+		     b43legacy_interrupt_tasklet,
 		     (unsigned long)wldev);
 	if (modparam_pio)
 		wldev->__using_pio = true;
-- 
2.20.1

