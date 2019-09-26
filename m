Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676E5BF4FC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfIZOYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 10:24:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIZOYd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 10:24:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9FF460BEE; Thu, 26 Sep 2019 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569507871;
        bh=GCODvtjbhDXDVVj83RHxr17KUIFLZZfOpgfXP2PVhBU=;
        h=From:To:Cc:Subject:Date:From;
        b=Pz1/FkEYiXOJkXQ2DFT38g0TpCCyZQue/M+cEDyz32iirIjvfd98kcRutEWhBd908
         lFWzAf7dY703q9UjbKVE5kCzp11UbNSInkM6u1PNYWoBrdCYGSkCImoDz0/3gGLYwb
         D3Gyb09nygMJJ9jnly5lKZ0mfXVNdXGdsnkrvnss=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41EAF609F3;
        Thu, 26 Sep 2019 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569507871;
        bh=GCODvtjbhDXDVVj83RHxr17KUIFLZZfOpgfXP2PVhBU=;
        h=From:To:Cc:Subject:Date:From;
        b=Pz1/FkEYiXOJkXQ2DFT38g0TpCCyZQue/M+cEDyz32iirIjvfd98kcRutEWhBd908
         lFWzAf7dY703q9UjbKVE5kCzp11UbNSInkM6u1PNYWoBrdCYGSkCImoDz0/3gGLYwb
         D3Gyb09nygMJJ9jnly5lKZ0mfXVNdXGdsnkrvnss=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41EAF609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH RFT] ath10k: add QCA9377 sdio hw_param item
Date:   Thu, 26 Sep 2019 17:24:27 +0300
Message-Id: <1569507867-19547-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Erik Stromdahl <erik.stromdahl@gmail.com>

Add hardware parameters for QCA9377 sdio devices, it's now properly supported.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---

I don't have any working QCA9377 SDIO hardware so I would appreciate any
test reports. This should apply cleanly to ath.git master branch (at least to
tag ath-201909230832):

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=master

 drivers/net/wireless/ath/ath10k/core.c | 27 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 36c62d66c19e..e5572d4b6ae9 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -539,6 +539,33 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 	},
 	{
+		.id = QCA9377_HW_1_1_DEV_VERSION,
+		.dev_id = QCA9377_1_0_DEVICE_ID,
+		.bus = ATH10K_BUS_SDIO,
+		.name = "qca9377 hw1.1 sdio",
+		.patch_load_addr = QCA9377_HW_1_0_PATCH_LOAD_ADDR,
+		.uart_pin = 19,
+		.otp_exe_param = 0,
+		.channel_counters_freq_hz = 88000,
+		.max_probe_resp_desc_thres = 0,
+		.cal_data_len = 8124,
+		.fw = {
+			.dir = QCA9377_HW_1_0_FW_DIR,
+			.board = QCA9377_HW_1_0_BOARD_DATA_FILE,
+			.board_size = QCA9377_BOARD_DATA_SZ,
+			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
+		},
+		.hw_ops = &qca6174_ops,
+		.hw_clk = qca6174_clk,
+		.target_cpu_freq = 176000000,
+		.decap_align_bytes = 4,
+		.n_cipher_suites = 8,
+		.num_peers = TARGET_QCA9377_HL_NUM_PEERS,
+		.ast_skid_limit = 0x10,
+		.num_wds_entries = 0x20,
+		.uart_pin_workaround = true,
+	},
+	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
 		.dev_id = 0,
 		.bus = ATH10K_BUS_AHB,
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 2ae57c1de7b5..ddb1d23ec6de 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -768,6 +768,9 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
 #define TARGET_HL_TLV_AST_SKID_LIMIT		16
 #define TARGET_HL_TLV_NUM_WDS_ENTRIES		2
 
+/* Target specific defines for QCA9377 high latency firmware */
+#define TARGET_QCA9377_HL_NUM_PEERS		15
+
 /* Diagnostic Window */
 #define CE_DIAG_PIPE	7
 
-- 
2.7.4

