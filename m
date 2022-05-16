Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A3527C53
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 05:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiEPDZv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 23:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiEPDZn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 23:25:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F64B4BD
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:41 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y19so16578637ljd.4
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iz4SrPxA+XQFoQwUknrCDAQupMGnQdDbuR8sbrlu8Sk=;
        b=E9sTIR/NkKpMWMm8b61H890gxiQAAOvHvyGGvEtwwK4OUvMrKiV/g2WahU2lqyxh6S
         DNnBycVxK9AdpySmFHaj6TVqHirdm+gIrPsIne4otZcffQkgtkYkSWvCyjGQd/Ok7zrU
         bVVjyHMHezvHduZZNMAYxQcLH9mRRFzL8QkDQQymJyaut6yP4jyfktzDqcC6+3MD5HQx
         uuI7629O8qwAYJ/hq62a1qfgw9r1lnrAwZlUfPHAcFJu4Ff1Gu3cM1GJhRu3C3cSQIgp
         bLiKfo+G1YBbxbVrmriCIQvfG5TY3hUxka1Hhv6sEp3YD6Y3MapFoOOsTWCKrRhICwmI
         L4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iz4SrPxA+XQFoQwUknrCDAQupMGnQdDbuR8sbrlu8Sk=;
        b=iEnwWQbUSOhzP58uqh0D26UWszxGU90yFckwtrJVVyOCLcTM9yPAlqI6cxQDjuvWYy
         J7PDBLNlV6oOpoID225shyXq6XFVI/XVPA24H1V3pem9MoVlHa3COl/OO2V/4Xhia5LY
         Ma5d5qXBO72kk+KXC2vAj9MVEfLwIyRuDjFimsiddw3a+g7VYI2LSzV6YBlCUyy9Vt2E
         O6hkaoPUALWA1yw9/DxkU3W0GZGsiZuEB4uxDS6idInLgeIr3eesPxJ/q7hZIA109Cmk
         FYZuOpUr048MdnvXn2gM3QFK8jCNcMr9v0zSy5Y01AsrPDsgdbkcg6AxY6eNkIsC3DnM
         5SQQ==
X-Gm-Message-State: AOAM532aRxG0qNpC4i0Hxj8E9XITAptpzZMhLdG4NAahOvMtGEipDo4L
        R/NoTrYydO/wzXb5B0O6ntw=
X-Google-Smtp-Source: ABdhPJxLBIUV2OSo4dC6VScWL0j68jvayrqqU1GRP6x8JTvhrMkt6ZtaMueRSRvOQiW16ndrqzj3FA==
X-Received: by 2002:a2e:87cb:0:b0:24f:81c:8940 with SMTP id v11-20020a2e87cb000000b0024f081c8940mr10389608ljj.423.1652671539752;
        Sun, 15 May 2022 20:25:39 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id q18-20020a2e9152000000b0024f3d1daee5sm1337251ljg.109.2022.05.15.20.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:25:39 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Old=C5=99ich=20Jedli=C4=8Dka?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
Subject: [PATCH 3/4] ath10k: turn rawmode into frame_mode
Date:   Mon, 16 May 2022 06:25:18 +0300
Message-Id: <20220516032519.29831-4-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
References: <20220516032519.29831-1-ryazanov.s.a@gmail.com>
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

Changes since RFC:
 * changed position in series: #2 -> #3
 * rebased on top of latest ath-next

 drivers/net/wireless/ath/ath10k/core.c | 11 +++++++----
 drivers/net/wireless/ath/ath10k/core.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 688177453b07..5654387acb4b 100644
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
 
@@ -2599,7 +2602,7 @@ static int ath10k_core_init_firmware_features(struct ath10k *ar)
 	ar->htt.max_num_amsdu = ATH10K_HTT_MAX_NUM_AMSDU_DEFAULT;
 	ar->htt.max_num_ampdu = ATH10K_HTT_MAX_NUM_AMPDU_DEFAULT;
 
-	if (rawmode) {
+	if (ath10k_frame_mode == ATH10K_HW_TXRX_RAW) {
 		if (!test_bit(ATH10K_FW_FEATURE_RAW_MODE_SUPPORT,
 			      fw_file->fw_features)) {
 			ath10k_err(ar, "rawmode = 1 requires support from firmware");
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 8bfabbcfdb14..d70d7d088a2b 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1314,6 +1314,7 @@ static inline bool ath10k_peer_stats_enabled(struct ath10k *ar)
 	return false;
 }
 
+extern unsigned int ath10k_frame_mode;
 extern unsigned long ath10k_coredump_mask;
 
 void ath10k_core_napi_sync_disable(struct ath10k *ar);
-- 
2.35.1

