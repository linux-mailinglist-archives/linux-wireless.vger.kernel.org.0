Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35EA651C00
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 08:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiLTHzw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 02:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiLTHzt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 02:55:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D22DE2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 23:55:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o12so11603352pjo.4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 23:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lUH7ICleRb/CYwKzbaXCdf221Goq9bYxBGSvWpk034=;
        b=m5nTnrA9JUKHMNfFob+CNWz9Y5A1kA/3Jg6cLD2QsBzePMwiGtry/ONhtt0M6DLHQp
         nDTdgG2QLz7YZjToSy+z02blQQO/SSdch1ihyHDei1Ao12BSLtsQM0JaN95eblZG12ss
         2eoqXXhHY7PGgAznQJ9xkaJaha4nQFcP00W2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lUH7ICleRb/CYwKzbaXCdf221Goq9bYxBGSvWpk034=;
        b=UxMsLMyFGy7jDq6M2onIjv5JK2xm2nsuXKRJls90Af7x4DwLibnBs3/+pTyyNKFo35
         tpw6Ie1lmpOZSRFUOchbIj+z+XbS7CMkk32VLbwwRp5lpf3vSQtQBol9bjZ9Lr4v9719
         75OGllo4ev+l5sy9Did3YGQoo0SGIh98Nt1aoyEFoIScgXMeMhnm39u9Yk8jAu7C5crV
         FTmwDGsfc5GEPx+6OQeNpN8+TrXwKmHtvnhhpvFqzQWUwgmEEojhwMmawQ4pXOnzUyto
         jxVs+iFzxKRz9I17jq5eGNn1wF+AS1MF1REkHQT/rV2IJ8C3XSwgY+spZR7jEnfzKe03
         a3ZQ==
X-Gm-Message-State: AFqh2kqJoGFCGAnMJ2n5QynJJKqAUqSH9eaRfmsB3046cFf4Ee79Z3RR
        h2r7cJ0cYELXtu+lLah3yzt1Sw==
X-Google-Smtp-Source: AMrXdXuRYKUKejxanv4Te75F99BbTwv5kTv7YHUdJwG87aH6dXGAIybbLVj7i9Do71YO5LR1lUMflw==
X-Received: by 2002:a05:6a20:9e05:b0:b2:18da:1515 with SMTP id ms5-20020a056a209e0500b000b218da1515mr3509202pzb.20.1671522947919;
        Mon, 19 Dec 2022 23:55:47 -0800 (PST)
Received: from kuabhs-cdev.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id u31-20020a63235f000000b00488b8ad57bfsm5124215pgm.54.2022.12.19.23.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:55:47 -0800 (PST)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@kernel.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kuabhs@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] ath10k: snoc: enable threaded napi on WCN3990
Date:   Tue, 20 Dec 2022 07:55:06 +0000
Message-Id: <20221220075215.1.Ic12e347e0d61a618124b742614e82bbd5d770173@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NAPI poll can be done in threaded context along with soft irq
context. Threaded context can be scheduled efficiently, thus
creating less of bottleneck during Rx processing. This patch is
to enable threaded NAPI on ath10k driver.

Based on testing, it was observed that on WCN3990, the CPU0 reaches
100% utilization when napi runs in softirq context. At the same
time the other CPUs are at low consumption percentage. This
does not allow device to reach its maximum throughput potential.
After enabling threaded napi, CPU load is balanced across all CPUs
and following improvments were observed:
- UDP_RX increase by ~22-25%
- TCP_RX increase by ~15%

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 drivers/net/wireless/ath/ath10k/core.c | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5eb131ab916fd..ee4b6ba508c81 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -100,6 +100,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -140,6 +141,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -181,6 +183,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -217,6 +220,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -257,6 +261,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -297,6 +302,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -337,6 +343,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -381,6 +388,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -427,6 +435,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -480,6 +489,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -530,6 +540,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -570,6 +581,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -612,6 +624,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -645,6 +658,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
@@ -692,6 +706,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = false,
 		.use_fw_tx_credits = true,
 		.delay_unmap_buffer = false,
+		.enable_threaded_napi = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -725,6 +740,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_restart_disconnect = true,
 		.use_fw_tx_credits = false,
 		.delay_unmap_buffer = true,
+		.enable_threaded_napi = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 9643031a4427a..adf3076b96503 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -639,6 +639,8 @@ struct ath10k_hw_params {
 	bool use_fw_tx_credits;
 
 	bool delay_unmap_buffer;
+
+	bool enable_threaded_napi;
 };
 
 struct htt_resp;
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index cfcb759a87dea..b94150fb6ef06 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -927,6 +927,9 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 
+	if (ar->hw_params.enable_threaded_napi)
+		dev_set_threaded(&ar->napi_dev, true);
+
 	ath10k_core_napi_enable(ar);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
-- 
2.39.0.314.g84b9a713c41-goog

