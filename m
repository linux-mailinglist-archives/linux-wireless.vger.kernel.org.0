Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E0729CBD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbjFIOYu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbjFIOYs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519630F2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427C6616E0
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA99C433EF;
        Fri,  9 Jun 2023 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320685;
        bh=jIN69rmyKd1i+FPpiYUgL+PYo8ShEjVnI6dEfceWgYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA+kUS/9jDAmdoDDrAwqDV9BG53cJ/gxwZYmrqnOE014Pd/FmEKq28gd4EHvS1vJ0
         2mIh6hBbD/MDwIV08DEMwMdbJJOOATqFbQ1qjcF/fTakYtsjcvx6p37TukRg5x3MmO
         JTusRy/JtJBS4ndvrOGcWia7kAxpuWbfnhOCFUDknJ6s5dI3a/FZmlnTn9PtHiM611
         Q3KJ1q7kgh5/yda+mUsU39bR2A3xERCcc9Wv0rRsprjhgamb23AszLyCgHPhBG0GEr
         xzhEet9Qa3yU1RyXRssf9Sy9FHKwdAp3YgOWC6UHbLU3fTAfMVppCRQLdOS4T4hWNb
         ZQM8ontT/W80A==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/15] wifi: ath11k: print debug level in debug messages
Date:   Fri,  9 Jun 2023 17:24:27 +0300
Message-Id: <20230609142440.24643-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

To make it easier understand the context of a debug message print the debug
level before the actual message. An example:

[21867.231900] ath11k_pci 0000:06:00.0: wmi processed regulatory ext channel list

The tracepoint call is not modified, it's better to userspace print the debug
level if needed.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debug.c |  2 +-
 drivers/net/wireless/ath/ath11k/debug.h | 42 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 958d87429062..f5c8a34c8802 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -66,7 +66,7 @@ void __ath11k_dbg(struct ath11k_base *ab, enum ath11k_debug_mask mask,
 	vaf.va = &args;
 
 	if (ath11k_debug_mask & mask)
-		dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
+		dev_printk(KERN_DEBUG, ab->dev, "%s %pV", ath11k_dbg_str(mask), &vaf);
 
 	trace_ath11k_log_dbg(ab, mask, &vaf);
 
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 0a9418c36bf4..2dd84d8ed5a5 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -28,6 +28,48 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_DP_RX	= 0x00004000,
 };
 
+static inline const char *ath11k_dbg_str(enum ath11k_debug_mask mask)
+{
+	switch (mask) {
+	case ATH11K_DBG_AHB:
+		return "ahb";
+	case ATH11K_DBG_WMI:
+		return "wmi";
+	case ATH11K_DBG_HTC:
+		return "htc";
+	case ATH11K_DBG_DP_HTT:
+		return "dp_htt";
+	case ATH11K_DBG_MAC:
+		return "mac";
+	case ATH11K_DBG_BOOT:
+		return "boot";
+	case ATH11K_DBG_QMI:
+		return "qmi";
+	case ATH11K_DBG_DATA:
+		return "data";
+	case ATH11K_DBG_MGMT:
+		return "mgmt";
+	case ATH11K_DBG_REG:
+		return "reg";
+	case ATH11K_DBG_TESTMODE:
+		return "testmode";
+	case ATH11k_DBG_HAL:
+		return "hal";
+	case ATH11K_DBG_PCI:
+		return "pci";
+	case ATH11K_DBG_DP_TX:
+		return "dp_tx";
+	case ATH11K_DBG_DP_RX:
+		return "dp_rx";
+
+	/* no default handler to allow compiler to check that the
+	 * enum is fully handled
+	 */
+	}
+
+	return "<?>";
+}
+
 __printf(2, 3) void ath11k_info(struct ath11k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath11k_err(struct ath11k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...);
-- 
2.30.2

