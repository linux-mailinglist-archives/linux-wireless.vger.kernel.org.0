Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92DA22D2
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfH2Rxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 13:53:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2Rxy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 13:53:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ED8C6374A; Thu, 29 Aug 2019 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567101154;
        bh=bleuRIGGQXtxy2m1UO/Sr1VcKu3Nw/apzjxW1618aAo=;
        h=From:To:Cc:Subject:Date:From;
        b=RKYtsq1XdhjALRG6LQmlgMc7+KTI6L+EiHdtomuzrOMLW6XoFL68Do67kmpilPvGi
         E8JJXxXNU7c8xxrlNp7sn3fg2Gg+1zKNkOFM4CeXIl97QVbIo6t7ziKd5KgC9BBBYj
         1BP9nGgllqr91FcGudmFK/9+YqGPqTkYsnJIy1cg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD65B89988;
        Thu, 29 Aug 2019 02:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567046776;
        bh=bleuRIGGQXtxy2m1UO/Sr1VcKu3Nw/apzjxW1618aAo=;
        h=From:To:Cc:Subject:Date:From;
        b=K9BXqJolkVr+10nYEjo7UV8uqgeZyr2oaDE4MEgOOsBXwFi0+Vg3OY40HL0rIDbbI
         mNiufXPr0dIXAgaYTLGOSGhjpUmfHZ73fADOqbAiCvU/pyJucyqoZlPJRnhFtKZhbD
         0huRk1ohqrkSourfcyJyl6xVY66JUueONpUgvW0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD65B89988
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Thu, 29 Aug 2019 10:46:09 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] ath10k: fix latency issue for QCA988x
Date:   Thu, 29 Aug 2019 10:45:12 +0800
Message-Id: <1567046712-23057-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bad latency is found on QCA988x, the issue was introduced by
commit 4504f0e5b571 ("ath10k: sdio: workaround firmware UART
pin configuration bug"). If uart_pin_workaround is false, this
change will set uart pin even if uart_print is false.

Tested HW: QCA9880
Tested FW: 10.2.4-1.0-00037

Fixes: 4504f0e5b571 ("ath10k: sdio: workaround firmware UART pin configuration bug")
Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index dc45d16..383d4fa 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2118,12 +2118,15 @@ static int ath10k_init_uart(struct ath10k *ar)
 		return ret;
 	}
 
-	if (!uart_print && ar->hw_params.uart_pin_workaround) {
-		ret = ath10k_bmi_write32(ar, hi_dbg_uart_txpin,
-					 ar->hw_params.uart_pin);
-		if (ret) {
-			ath10k_warn(ar, "failed to set UART TX pin: %d", ret);
-			return ret;
+	if (!uart_print) {
+		if (ar->hw_params.uart_pin_workaround) {
+			ret = ath10k_bmi_write32(ar, hi_dbg_uart_txpin,
+						 ar->hw_params.uart_pin);
+			if (ret) {
+				ath10k_warn(ar, "failed to set UART TX pin: %d",
+					    ret);
+				return ret;
+			}
 		}
 
 		return 0;
-- 
1.9.1

