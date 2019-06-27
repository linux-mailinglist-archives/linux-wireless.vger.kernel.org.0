Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706D058A28
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0Srf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 14:47:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF0Srf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 14:47:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B62D76070D; Thu, 27 Jun 2019 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561661254;
        bh=FldDFuM+zrqioBxxDmOCZWXcYVFE1fZuoBm8rsdP6zw=;
        h=From:To:Cc:Subject:Date:From;
        b=J7AyuGtgE3HuS0xPYl44wyjfuF8vtqbPrrDFn/UFjlEwbWkjgE1u1Cp7+r2WehOuq
         OYI9NTQ1iDwhNy1mAutGMpCtS4adIdlo05zxWJUG+wWGx5xS6nEc6HIpX3TbJ5uhfO
         /9Ny/mt6oSe8OyYnnmhGgKs6gczjRYz5JKQDHgrI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 923E2602FE;
        Thu, 27 Jun 2019 18:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561661254;
        bh=FldDFuM+zrqioBxxDmOCZWXcYVFE1fZuoBm8rsdP6zw=;
        h=From:To:Cc:Subject:Date:From;
        b=J7AyuGtgE3HuS0xPYl44wyjfuF8vtqbPrrDFn/UFjlEwbWkjgE1u1Cp7+r2WehOuq
         OYI9NTQ1iDwhNy1mAutGMpCtS4adIdlo05zxWJUG+wWGx5xS6nEc6HIpX3TbJ5uhfO
         /9Ny/mt6oSe8OyYnnmhGgKs6gczjRYz5JKQDHgrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 923E2602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] ath10k: remove unnecessary 'out of memory' message
Date:   Thu, 27 Jun 2019 21:47:29 +0300
Message-Id: <1561661250-30528-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes checkpatch warning:

drivers/net/wireless/ath/ath10k/swap.c:110: Possible unnecessary 'out of memory' message

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/swap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/swap.c b/drivers/net/wireless/ath/ath10k/swap.c
index 4dddeee684b4..7198a386f2fb 100644
--- a/drivers/net/wireless/ath/ath10k/swap.c
+++ b/drivers/net/wireless/ath/ath10k/swap.c
@@ -106,10 +106,8 @@ ath10k_swap_code_seg_alloc(struct ath10k *ar, size_t swap_bin_len)
 
 	virt_addr = dma_alloc_coherent(ar->dev, swap_bin_len, &paddr,
 				       GFP_KERNEL);
-	if (!virt_addr) {
-		ath10k_err(ar, "failed to allocate dma coherent memory\n");
+	if (!virt_addr)
 		return NULL;
-	}
 
 	seg_info->seg_hw_info.bus_addr[0] = __cpu_to_le32(paddr);
 	seg_info->seg_hw_info.size = __cpu_to_le32(swap_bin_len);
-- 
2.7.4

