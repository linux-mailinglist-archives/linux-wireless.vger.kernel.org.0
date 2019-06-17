Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2F47B2B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfFQHhi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 03:37:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHhi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 03:37:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B9F2360A50; Mon, 17 Jun 2019 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560757057;
        bh=0ap3a4SLVczt2FkdufVfl3Dnq7zaOb7m88tDOOwzid0=;
        h=From:To:Cc:Subject:Date:From;
        b=TVev6Blm0RQEe62//2RK6SCoCEaAkDkyB9I8+aZaMujaAKe/gf3r9qODH2xhRkaur
         7b+z7pVjpRaoUFv65oh6V/p4ceBmFVPvOxyww3XVvSEYB94V42tMPwlNC8Is30B8JG
         mY0Zh2eQls9VaI0qdDcbfP53jUUKRThN+6za85Bw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost.localdomain (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 893166020A;
        Mon, 17 Jun 2019 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560757057;
        bh=0ap3a4SLVczt2FkdufVfl3Dnq7zaOb7m88tDOOwzid0=;
        h=From:To:Cc:Subject:Date:From;
        b=TVev6Blm0RQEe62//2RK6SCoCEaAkDkyB9I8+aZaMujaAKe/gf3r9qODH2xhRkaur
         7b+z7pVjpRaoUFv65oh6V/p4ceBmFVPvOxyww3XVvSEYB94V42tMPwlNC8Is30B8JG
         mY0Zh2eQls9VaI0qdDcbfP53jUUKRThN+6za85Bw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 893166020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: add new hw_ops for sdio chip
Date:   Mon, 17 Jun 2019 15:37:28 +0800
Message-Id: <1560757048-19223-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It report error message while suspend/resume test.
dmesg log:
[  150.749962] ath10k_sdio mmc1:0001:1: hif read32 not supported
[  150.755728] ath10k_sdio mmc1:0001:1: failed to set coverage class: expected integer microsecond value in register

Reason is sdio chip does not support set_coverage_class as well as
pcie chip, remove the set_coverage_class handler will avoid it.

callstack of the error message:
OUTLINED_FUNCTION_6+0xc/0x14 [ath10k_core]
ath10k_mac_op_set_coverage_class+0x2c/0x40 [ath10k_core]
ieee80211_reconfig+0x5d0/0x108c [mac80211]
ieee80211_resume+0x34/0x6c [mac80211]
wiphy_resume+0xbc/0x13c [cfg80211]
dpm_run_callback+0xa4/0x168
device_resume+0x1d4/0x200
async_resume+0x1c/0x34
async_run_entry_fn+0x48/0xf8
process_one_work+0x178/0x2f8
worker_thread+0x1d8/0x2cc
kthread+0x11c/0x12c
ret_from_fork+0x10/0x18

the error log will not happen after this patch applied.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 drivers/net/wireless/ath/ath10k/hw.c   | 4 ++++
 drivers/net/wireless/ath/ath10k/hw.h   | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 76504bc..3c6d921 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -101,7 +101,7 @@
 			.board_size = QCA6174_BOARD_DATA_SZ,
 			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
 		},
-		.hw_ops = &qca6174_ops,
+		.hw_ops = &qca6174_sdio_ops,
 		.hw_clk = qca6174_clk,
 		.target_cpu_freq = 176000000,
 		.decap_align_bytes = 4,
diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index ad082b7..a6a38c9 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -1153,6 +1153,10 @@ static bool ath10k_qca99x0_rx_desc_msdu_limit_error(struct htt_rx_desc *rxd)
 	.is_rssi_enable = ath10k_htt_tx_rssi_enable,
 };
 
+const struct ath10k_hw_ops qca6174_sdio_ops = {
+	.enable_pll_clk = ath10k_hw_qca6174_enable_pll_clock,
+};
+
 const struct ath10k_hw_ops wcn3990_ops = {
 	.tx_data_rssi_pad_bytes = ath10k_get_htt_tx_data_rssi_pad,
 	.is_rssi_enable = ath10k_htt_tx_rssi_enable_wcn3990,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 54c01f1..3a6f87e 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -626,6 +626,7 @@ struct ath10k_hw_ops {
 extern const struct ath10k_hw_ops qca988x_ops;
 extern const struct ath10k_hw_ops qca99x0_ops;
 extern const struct ath10k_hw_ops qca6174_ops;
+extern const struct ath10k_hw_ops qca6174_sdio_ops;
 extern const struct ath10k_hw_ops wcn3990_ops;
 
 extern const struct ath10k_hw_clk_params qca6174_clk[];
-- 
1.9.1

