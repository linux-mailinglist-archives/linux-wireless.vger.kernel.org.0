Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206C79654E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfHTPuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbfHTPuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F1C161BE1; Tue, 20 Aug 2019 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316208;
        bh=JOqOoA4bOu7jnD9piM95YrBFvG5mZ+/CneK6MIQl0so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNrf4W7snd8eVKEuViMCBdvlHQ69OckTxM3lRpv9m9PE8OW56i8Ujei85aMJ6sf2U
         LVxzAWqRYhoLKTK/Qa/JlY5RPPonk75DNtICOG8x+JUvsoWr4euAHJQ9VcQihQtUBa
         zzHNXcH+faIpGJMLd8OYFNhflnaW5e9u3Eyou4nM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35D1161516;
        Tue, 20 Aug 2019 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316181;
        bh=JOqOoA4bOu7jnD9piM95YrBFvG5mZ+/CneK6MIQl0so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGJxBg0hm+aZO6fkyyXS4nIgy88Po9G3/yWrjxzHQEcCTn7fpbfd3TghhUKpDBNEG
         +Zw4vqP5u2zpUm5YaiLfocnPf378mFpkbmss31mOkGJop57lxAiCqfH2kGAZbwYKrO
         amoaC8Jndd3bwXRoLwrZ553mUkwXL8O4twJVx8nY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35D1161516
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 30/49] ath11k: add hw.h
Date:   Tue, 20 Aug 2019 18:47:56 +0300
Message-Id: <1566316095-27507-31-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/hw.h | 127 +++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
new file mode 100644
index 000000000000..f510d9d9263c
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_HW_H
+#define ATH11K_HW_H
+
+/* Target configuration defines */
+
+/* Num VDEVS per radio */
+#define TARGET_NUM_VDEVS	(16 + 1)
+
+#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
+
+/* Num of peers for Single Radio mode */
+#define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
+
+/* Num of peers for DBS */
+#define TARGET_NUM_PEERS_DBS		(2 * TARGET_NUM_PEERS_PDEV)
+
+/* Num of peers for DBS_SBS */
+#define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
+
+/* Max num of stations (per radio) */
+#define TARGET_NUM_STATIONS	512
+
+#define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
+#define TARGET_NUM_PEER_KEYS	2
+#define TARGET_NUM_TIDS(x)	(2 * TARGET_NUM_PEERS(x) + \
+				 4 * TARGET_NUM_VDEVS + 8)
+
+#define TARGET_AST_SKID_LIMIT	16
+#define TARGET_NUM_OFFLD_PEERS	4
+#define TARGET_NUM_OFFLD_REORDER_BUFFS 4
+
+#define TARGET_TX_CHAIN_MASK	(BIT(0) | BIT(1) | BIT(2) | BIT(4))
+#define TARGET_RX_CHAIN_MASK	(BIT(0) | BIT(1) | BIT(2) | BIT(4))
+#define TARGET_RX_TIMEOUT_LO_PRI	100
+#define TARGET_RX_TIMEOUT_HI_PRI	40
+
+#define TARGET_DECAP_MODE_RAW		0
+#define TARGET_DECAP_MODE_NATIVE_WIFI	1
+#define TARGET_DECAP_MODE_ETH		2
+
+#define TARGET_SCAN_MAX_PENDING_REQS	4
+#define TARGET_BMISS_OFFLOAD_MAX_VDEV	3
+#define TARGET_ROAM_OFFLOAD_MAX_VDEV	3
+#define TARGET_ROAM_OFFLOAD_MAX_AP_PROFILES	8
+#define TARGET_GTK_OFFLOAD_MAX_VDEV	3
+#define TARGET_NUM_MCAST_GROUPS		12
+#define TARGET_NUM_MCAST_TABLE_ELEMS	64
+#define TARGET_MCAST2UCAST_MODE		2
+#define TARGET_TX_DBG_LOG_SIZE		1024
+#define TARGET_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
+#define TARGET_VOW_CONFIG		0
+#define TARGET_NUM_MSDU_DESC		(2500)
+#define TARGET_MAX_FRAG_ENTRIES		6
+#define TARGET_MAX_BCN_OFFLD		16
+#define TARGET_NUM_WDS_ENTRIES		32
+#define TARGET_DMA_BURST_SIZE		1
+#define TARGET_RX_BATCHMODE		1
+
+#define ATH11K_HW_MAX_QUEUES		4
+
+#define ATH11k_HW_RATECODE_CCK_SHORT_PREAM_MASK  0x4
+
+#define ATH11K_FW_DIR			"ath11k"
+
+/* IPQ8074 definitions */
+#define IPQ8074_FW_DIR			"IPQ8074"
+#define IPQ8074_MAX_BOARD_DATA_SZ	(256 * 1024)
+#define IPQ8074_MAX_CAL_DATA_SZ		IPQ8074_MAX_BOARD_DATA_SZ
+
+#define ATH11K_BOARD_MAGIC		"QCA-ATH11K-BOARD"
+#define ATH11K_BOARD_API2_FILE		"board-2.bin"
+#define ATH11K_DEFAULT_BOARD_FILE	"bdwlan.bin"
+#define ATH11K_DEFAULT_CAL_FILE		"caldata.bin"
+
+enum ath11k_hw_rate_cck {
+	ATH11K_HW_RATE_CCK_LP_11M = 0,
+	ATH11K_HW_RATE_CCK_LP_5_5M,
+	ATH11K_HW_RATE_CCK_LP_2M,
+	ATH11K_HW_RATE_CCK_LP_1M,
+	ATH11K_HW_RATE_CCK_SP_11M,
+	ATH11K_HW_RATE_CCK_SP_5_5M,
+	ATH11K_HW_RATE_CCK_SP_2M,
+};
+
+enum ath11k_hw_rate_ofdm {
+	ATH11K_HW_RATE_OFDM_48M = 0,
+	ATH11K_HW_RATE_OFDM_24M,
+	ATH11K_HW_RATE_OFDM_12M,
+	ATH11K_HW_RATE_OFDM_6M,
+	ATH11K_HW_RATE_OFDM_54M,
+	ATH11K_HW_RATE_OFDM_36M,
+	ATH11K_HW_RATE_OFDM_18M,
+	ATH11K_HW_RATE_OFDM_9M,
+};
+
+struct ath11k_hw_params {
+	const char *name;
+	struct {
+		const char *dir;
+		size_t board_size;
+		size_t cal_size;
+	} fw;
+};
+
+struct ath11k_fw_ie {
+	__le32 id;
+	__le32 len;
+	u8 data[0];
+};
+
+enum ath11k_bd_ie_board_type {
+	ATH11K_BD_IE_BOARD_NAME = 0,
+	ATH11K_BD_IE_BOARD_DATA = 1,
+};
+
+enum ath11k_bd_ie_type {
+	/* contains sub IEs of enum ath11k_bd_ie_board_type */
+	ATH11K_BD_IE_BOARD = 0,
+	ATH11K_BD_IE_BOARD_EXT = 1,
+};
+
+#endif

