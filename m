Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5661E724
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 05:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEODbT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 23:31:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEODbT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 23:31:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B29C360A00; Wed, 15 May 2019 03:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557891078;
        bh=IOKYIGQpTlHEgOuel+XxeywSt8oDnC3PCxScc26wSv0=;
        h=From:To:Cc:Subject:Date:From;
        b=E4x+uuV5zn3JVj08eqUhUyFyVB5CPsy27gb5r+Uj4TVSHEAmNMIUmQGUEKI7plrS1
         KtKXcJiH0t3T+v9JGfa3nmxg4sDqSchPvmnM4X0TgKMUbwiWlQSD760P+qvNO2/xas
         +Xjc4NA3sNET7l24OZ4k+2bN584W9iy5RKUwnyAU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72E52607F4;
        Wed, 15 May 2019 03:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557891078;
        bh=IOKYIGQpTlHEgOuel+XxeywSt8oDnC3PCxScc26wSv0=;
        h=From:To:Cc:Subject:Date:From;
        b=E4x+uuV5zn3JVj08eqUhUyFyVB5CPsy27gb5r+Uj4TVSHEAmNMIUmQGUEKI7plrS1
         KtKXcJiH0t3T+v9JGfa3nmxg4sDqSchPvmnM4X0TgKMUbwiWlQSD760P+qvNO2/xas
         +Xjc4NA3sNET7l24OZ4k+2bN584W9iy5RKUwnyAU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72E52607F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: change firmware file name for UTF mode of SDIO/USB
Date:   Wed, 15 May 2019 11:30:47 +0800
Message-Id: <1557891047-16606-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware name for UTF mode of SDIO has changed from utf-2.bin to
utf-sdio-2.bin, so it need to change in ath10k, otherwise it will
fail for UTF mode.

After change the name in ath10k, it will success for UTF mode of
SDIO/USB.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/hw.h       |  2 ++
 drivers/net/wireless/ath/ath10k/testmode.c | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 7131499..d4fc13d 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -151,6 +151,8 @@ enum qca9377_chip_id_rev {
 #define ATH10K_FW_UTF_FILE		"utf.bin"
 #define ATH10K_FW_UTF_API2_FILE		"utf-2.bin"
 
+#define ATH10K_FW_UTF_FILE_BASE		"utf"
+
 /* includes also the null byte */
 #define ATH10K_FIRMWARE_MAGIC               "QCA-ATH10K"
 #define ATH10K_BOARD_MAGIC                  "QCA-ATH10K-BOARD"
diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 6433ff1..da9c596 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -174,8 +174,23 @@ static int ath10k_tm_fetch_firmware(struct ath10k *ar)
 {
 	struct ath10k_fw_components *utf_mode_fw;
 	int ret;
+	char fw_name[100];
+	int fw_api2 = 2;
+
+	switch (ar->hif.bus) {
+	case ATH10K_BUS_SDIO:
+	case ATH10K_BUS_USB:
+		scnprintf(fw_name, sizeof(fw_name), "%s-%s-%d.bin",
+			  ATH10K_FW_UTF_FILE_BASE, ath10k_bus_str(ar->hif.bus),
+			  fw_api2);
+		break;
+	default:
+		scnprintf(fw_name, sizeof(fw_name), "%s-%d.bin",
+			  ATH10K_FW_UTF_FILE_BASE, fw_api2);
+		break;
+	}
 
-	ret = ath10k_core_fetch_firmware_api_n(ar, ATH10K_FW_UTF_API2_FILE,
+	ret = ath10k_core_fetch_firmware_api_n(ar, fw_name,
 					       &ar->testmode.utf_mode_fw.fw_file);
 	if (ret == 0) {
 		ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "testmode using fw utf api 2");
-- 
1.9.1

