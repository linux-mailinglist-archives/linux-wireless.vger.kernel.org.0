Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B849DBDAC1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfIYJPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 05:15:41 -0400
Received: from mail.fedux.com.ar ([116.203.58.232]:59238 "EHLO
        mail.fedux.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfIYJP1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 05:15:27 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 05:15:26 EDT
Received: from kaoz-xps.fedux.com.ar (unknown [192.168.12.12])
        by mail.fedux.com.ar (Postfix) with ESMTP id 15D232911FB;
        Wed, 25 Sep 2019 11:08:59 +0200 (CEST)
Authentication-Results: mail.fedux.com.ar; dmarc=fail (p=none dis=none) header.from=fedux.com.ar
Authentication-Results: mail.fedux.com.ar; spf=fail smtp.mailfrom=fedux@fedux.com.ar
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedux.com.ar;
        s=default; t=1569402539;
        bh=LYXUhPYeCMrWz+2Di6NEBd2QtPIYlty7oxUM/DeccAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQImZaPgsvAFwLC1uRAlGpgyXJzeT5cWh1ISevBNKAtAP/JkYcnpG9RFHHUllCsfG
         8gk8y7g/KNUbIZ/3B3+6KMpjjMN9yvDqTwR8AJLoAg0VRhUMUxngH7odJAZs2ltUGt
         Hc8b3aO5QleyZaQRqtUdJo1WMc1vhTb+OfxDJDEE=
Received: by kaoz-xps.fedux.com.ar (Postfix, from userid 1000)
        id EBB4F140C0E; Wed, 25 Sep 2019 11:08:58 +0200 (CEST)
From:   Federico Cuello <fedux@fedux.com.ar>
To:     linux-wireless@vger.kernel.org
Cc:     wgong@codeaurora.org, Federico Cuello <fedux@fedux.com.ar>
Subject: [PATCH] ath10k: Fix ath10k_init_uart when uart_print is false
Date:   Wed, 25 Sep 2019 11:08:56 +0200
Message-Id: <20190925090856.6964-2-fedux@fedux.com.ar>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925090856.6964-1-fedux@fedux.com.ar>
References: <20190925090856.6964-1-fedux@fedux.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Patch 4504f0e5b5714d9d26b1a80bf1fc133c95830588 introduced a workaround
for a firmware UART pin configuration bug, but it caused uart_print to be
interpreted as true when it was false and uart_pin_workaround also false.

This patch corrects the exit condition when uart_print is false.

Signed-off-by: Federico Cuello <fedux@fedux.com.ar>
---
 drivers/net/wireless/ath/ath10k/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index dc45d16e8d21..dd1311910d6a 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2118,12 +2118,14 @@ static int ath10k_init_uart(struct ath10k *ar)
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
+				ath10k_warn(ar, "failed to set UART TX pin: %d", ret);
+				return ret;
+			}
 		}
 
 		return 0;
-- 
2.23.0

