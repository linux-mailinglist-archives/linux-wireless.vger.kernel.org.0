Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4976158A29
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF0Srh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 14:47:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF0Srh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 14:47:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 05BE760A33; Thu, 27 Jun 2019 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561661256;
        bh=Kq6FBv6Nm4vL0IwYrFuMpMy2BKfnvvnrBzXSCzlQ3jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOMRTkbqy4j+2p6cCJXPP5n2U0W/ehkS3+hhf5wXe7SFM8IhfxT98PX0pxAxSXt72
         0ZarRr0jlemRYLwiXEYU6ADM3kddWgM5GLXuYqz3fT0Cg7FdTIZXZLYPHeWog/5Lww
         FqjKVfgBDDKUmx/LYCrOniWJPLH4v25yUdhMcuDE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D6F1E602FE;
        Thu, 27 Jun 2019 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561661255;
        bh=Kq6FBv6Nm4vL0IwYrFuMpMy2BKfnvvnrBzXSCzlQ3jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n586mFQZlK6Xba1dijJzicVIGEe/NIHdRAejPNLB8+yh7DSp8A086YR0SQUQC3rZR
         ec4hktnD8gDax+Ve6K4Dlh6xVJ5Z6TOCJNpbFmhadEUNmfx5isA84cvPhu/dUGWmjj
         lkk2zHYwypVF0DC82XAWM2qx5o8ycDLainYkIIns=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6F1E602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: pci: remove unnecessary casts
Date:   Thu, 27 Jun 2019 21:47:30 +0300
Message-Id: <1561661250-30528-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561661250-30528-1-git-send-email-kvalo@codeaurora.org>
References: <1561661250-30528-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes checkpatch warnings:

drivers/net/wireless/ath/ath10k/pci.c:926: unnecessary cast may hide bugs, see http://c-faq.com/malloc/ma
drivers/net/wireless/ath/ath10k/pci.c:1072: unnecessary cast may hide bugs, see http://c-faq.com/malloc/m

While at it, also remove unnecessary initialisation of data_buf variable in both cases.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/pci.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 80bcb2ef5926..a0b4d265c6eb 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -909,7 +909,7 @@ static int ath10k_pci_diag_read_mem(struct ath10k *ar, u32 address, void *data,
 	/* Host buffer address in CE space */
 	u32 ce_data;
 	dma_addr_t ce_data_base = 0;
-	void *data_buf = NULL;
+	void *data_buf;
 	int i;
 
 	mutex_lock(&ar_pci->ce_diag_mutex);
@@ -923,10 +923,8 @@ static int ath10k_pci_diag_read_mem(struct ath10k *ar, u32 address, void *data,
 	 */
 	alloc_nbytes = min_t(unsigned int, nbytes, DIAG_TRANSFER_LIMIT);
 
-	data_buf = (unsigned char *)dma_alloc_coherent(ar->dev, alloc_nbytes,
-						       &ce_data_base,
-						       GFP_ATOMIC);
-
+	data_buf = dma_alloc_coherent(ar->dev, alloc_nbytes, &ce_data_base,
+				      GFP_ATOMIC);
 	if (!data_buf) {
 		ret = -ENOMEM;
 		goto done;
@@ -1054,7 +1052,7 @@ int ath10k_pci_diag_write_mem(struct ath10k *ar, u32 address,
 	u32 *buf;
 	unsigned int completed_nbytes, alloc_nbytes, remaining_bytes;
 	struct ath10k_ce_pipe *ce_diag;
-	void *data_buf = NULL;
+	void *data_buf;
 	dma_addr_t ce_data_base = 0;
 	int i;
 
@@ -1069,10 +1067,8 @@ int ath10k_pci_diag_write_mem(struct ath10k *ar, u32 address,
 	 */
 	alloc_nbytes = min_t(unsigned int, nbytes, DIAG_TRANSFER_LIMIT);
 
-	data_buf = (unsigned char *)dma_alloc_coherent(ar->dev,
-						       alloc_nbytes,
-						       &ce_data_base,
-						       GFP_ATOMIC);
+	data_buf = dma_alloc_coherent(ar->dev, alloc_nbytes, &ce_data_base,
+				      GFP_ATOMIC);
 	if (!data_buf) {
 		ret = -ENOMEM;
 		goto done;
-- 
2.7.4

