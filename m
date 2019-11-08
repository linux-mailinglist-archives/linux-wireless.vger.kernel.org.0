Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E560F42F8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 10:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHJTY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 04:19:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHJTY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 04:19:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5649D608FC; Fri,  8 Nov 2019 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573204763;
        bh=Xdtrd5ExGt8TcI/4Utf+Rt7j4WlQOyN8ohb9PVQej8o=;
        h=From:To:Cc:Subject:Date:From;
        b=Rr9GUsldGz8/1r+icia//2Y/37zNLhvBlmqYetGMaZ8x84I1NmsMFSY8jr58FgZqi
         Uos8dtaKNrKfvRENvGtnb1ggDmPoyqKSeDA9hpIMUXoKP9XG3JRwBvP4w55J0l2Ebt
         Y0EQ4jBq65oRqECXVcmjSE/fFkGEVUIurJAUkj/Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE5DF60588;
        Fri,  8 Nov 2019 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573204763;
        bh=Xdtrd5ExGt8TcI/4Utf+Rt7j4WlQOyN8ohb9PVQej8o=;
        h=From:To:Cc:Subject:Date:From;
        b=Rr9GUsldGz8/1r+icia//2Y/37zNLhvBlmqYetGMaZ8x84I1NmsMFSY8jr58FgZqi
         Uos8dtaKNrKfvRENvGtnb1ggDmPoyqKSeDA9hpIMUXoKP9XG3JRwBvP4w55J0l2Ebt
         Y0EQ4jBq65oRqECXVcmjSE/fFkGEVUIurJAUkj/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE5DF60588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: enable firmware log by default for sdio
Date:   Fri,  8 Nov 2019 17:19:14 +0800
Message-Id: <20191108091914.16785-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On SDIO chips the firmware log does not impact performance. To make it
easier to debug firmware problems keep it enabled on the firmware.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 36c62d66c19e..25b484580944 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -713,18 +713,6 @@ static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
 	if (ret)
 		return ret;
 
-	/* Explicitly set fwlog prints to zero as target may turn it on
-	 * based on scratch registers.
-	 */
-	ret = ath10k_bmi_read32(ar, hi_option_flag, &param);
-	if (ret)
-		return ret;
-
-	param |= HI_OPTION_DISABLE_DBGLOG;
-	ret = ath10k_bmi_write32(ar, hi_option_flag, param);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.23.0

