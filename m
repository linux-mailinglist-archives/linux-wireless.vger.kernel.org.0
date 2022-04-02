Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF14F0472
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Apr 2022 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiDBPi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Apr 2022 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357347AbiDBPiU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Apr 2022 11:38:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09E143C6F
        for <linux-wireless@vger.kernel.org>; Sat,  2 Apr 2022 08:36:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z12so9842604lfu.10
        for <linux-wireless@vger.kernel.org>; Sat, 02 Apr 2022 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTmv43jH0Iq3c4QiJ+kkvctk9uHUSzlLivy0WU5Wggg=;
        b=naqi4WqqB32+j9dHXl18mUWb1WCHP9yd6IQlkvYXDQVCWAtryaj3hASMowXWD8H9di
         FhyPON5z4qF/7zoB6SQj8zEPkBDVrP2gWKFefheqP05dwZPWR8p/I+7URpOS+JmcvgYl
         kjs1X7UH9KIzLp8uRF3mKMAxUa2/sFqOujlVDkd3JzYs32wScGNXLPraE4KEALfzgzJ1
         qTU+pL4dMwOdp1dANe/k4vbVUYtP9bYPGFUFOBKGkRB1nt73asN3XDbtvJzgm1VQ8X5j
         9xwVwMurOTgrkg46WB83hcJe7uaFu0wYP2EFyddVApT85+mZAhguAHUnYwMVNT+GuiwF
         McWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTmv43jH0Iq3c4QiJ+kkvctk9uHUSzlLivy0WU5Wggg=;
        b=zt7YQib1QCCLxRbrDe0kfPKHTdFs8k7rFsWnHVqqDug4UEOrIKuWVlbLix44Z6pC7j
         jOcscvRNuC/4wYpeY05aT0zxVLfj20JMOTOWtwoBQs4u6wvF+whWCMkRZDXmetQMixkk
         g+ICNWZ5LZhc0L/u0N69pF1B6So7U2JNjRa79SAFkd7pzwUguoJmDKf9sWFKIshQDXa1
         li7sAVHJ5PSu2mIayLF6L4Ttofh4IVf6YnOnVhJiO0ssNUtowMyF8TWgYR6qk7z0u8f9
         6mgnWz2Y8oVT3QBxXxJea9JVVo6rIishauy8WGKWnlQom5xUzoZoZC4EZkDOtq+nM8Am
         1o4g==
X-Gm-Message-State: AOAM530eCIimGV7esCoOU6kaxyruXIsAi8MTAtG4rRWL/cesF8jTU/o5
        mfSvp5XbIdf3kV4qfygqjTw=
X-Google-Smtp-Source: ABdhPJw/N2op2Uxi/kwz4LGjYFJh3Qqomck6LBPlozNwSrrNumk2iSuJopvVid2EZYAmC8bTzD+X1w==
X-Received: by 2002:a05:6512:151f:b0:44a:2508:1d01 with SMTP id bq31-20020a056512151f00b0044a25081d01mr17193123lfb.675.1648913786384;
        Sat, 02 Apr 2022 08:36:26 -0700 (PDT)
Received: from rsa-laptop.rossosh.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id z18-20020a2e3512000000b0024b12b5044csm52884ljz.89.2022.04.02.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 08:36:26 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 2/3] ath10k: turn rawmode into frame_mode
Date:   Sat,  2 Apr 2022 18:36:14 +0300
Message-Id: <20220402153615.9593-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
References: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Turn boolean rawmode module param into integer frame_mode param that
contains value from ath10k_hw_txrx_mode enum. As earlier the default
param value is non-RAW (native Wi-Fi) encapsulation. The param name
is selected to be consistent with the similar ath11k param.

This is a preparation step for upcoming encapsulation offloading
support.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 11 +++++++----
 drivers/net/wireless/ath/ath10k/core.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 2092bfd02cd1..b74b6f5a7178 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -33,9 +33,11 @@ EXPORT_SYMBOL(ath10k_debug_mask);
 static unsigned int ath10k_cryptmode_param;
 static bool uart_print;
 static bool skip_otp;
-static bool rawmode;
 static bool fw_diag_log;
 
+/* frame mode values are mapped as per enum ath10k_hw_txrx_mode */
+unsigned int ath10k_frame_mode = ATH10K_HW_TXRX_NATIVE_WIFI;
+
 unsigned long ath10k_coredump_mask = BIT(ATH10K_FW_CRASH_DUMP_REGISTERS) |
 				     BIT(ATH10K_FW_CRASH_DUMP_CE_DATA);
 
@@ -44,15 +46,16 @@ module_param_named(debug_mask, ath10k_debug_mask, uint, 0644);
 module_param_named(cryptmode, ath10k_cryptmode_param, uint, 0644);
 module_param(uart_print, bool, 0644);
 module_param(skip_otp, bool, 0644);
-module_param(rawmode, bool, 0644);
 module_param(fw_diag_log, bool, 0644);
+module_param_named(frame_mode, ath10k_frame_mode, uint, 0644);
 module_param_named(coredump_mask, ath10k_coredump_mask, ulong, 0444);
 
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 MODULE_PARM_DESC(uart_print, "Uart target debugging");
 MODULE_PARM_DESC(skip_otp, "Skip otp failure for calibration in testmode");
 MODULE_PARM_DESC(cryptmode, "Crypto mode: 0-hardware, 1-software");
-MODULE_PARM_DESC(rawmode, "Use raw 802.11 frame datapath");
+MODULE_PARM_DESC(frame_mode,
+		 "Datapath frame mode (0: raw, 1: native wifi (default))");
 MODULE_PARM_DESC(coredump_mask, "Bitfield of what to include in firmware crash file");
 MODULE_PARM_DESC(fw_diag_log, "Diag based fw log debugging");
 
@@ -2588,7 +2591,7 @@ static int ath10k_core_init_firmware_features(struct ath10k *ar)
 	ar->htt.max_num_amsdu = ATH10K_HTT_MAX_NUM_AMSDU_DEFAULT;
 	ar->htt.max_num_ampdu = ATH10K_HTT_MAX_NUM_AMPDU_DEFAULT;
 
-	if (rawmode) {
+	if (ath10k_frame_mode == ATH10K_HW_TXRX_RAW) {
 		if (!test_bit(ATH10K_FW_FEATURE_RAW_MODE_SUPPORT,
 			      fw_file->fw_features)) {
 			ath10k_err(ar, "rawmode = 1 requires support from firmware");
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 9f6680b3be0a..a27d450bbeb8 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1317,6 +1317,7 @@ static inline bool ath10k_peer_stats_enabled(struct ath10k *ar)
 	return false;
 }
 
+extern unsigned int ath10k_frame_mode;
 extern unsigned long ath10k_coredump_mask;
 
 void ath10k_core_napi_sync_disable(struct ath10k *ar);
-- 
2.34.1

