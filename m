Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B007E80B2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbjKJSRY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbjKJSQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8C28135
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A57C433C8;
        Fri, 10 Nov 2023 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611730;
        bh=hptKbYz04+x5Rr0maSkv69QvScaY06HUThEK/G5dIhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkMo7EG6iUws0M/o6eo67UcGSSC6caRinXQ6YCAQIeTAjUdzj/soIs7A00vEsswei
         Uz/eA64OKT6OWdFUiYd7UnU211hCMV65JQ7yG/A3Oze90Fxlfau00+KR1j7ZVgW9I2
         cutec7332I9fLZAvWwAXxK81C3Tq7rGL5yIIw/13E0quEN6Wq0OCiYWWWUKUwLXDJt
         qFG4eaApzDzE0dpRhvw3DMdyOICKrbvEiYmrQ5JJPeuJ0sBWQtgIbV/aLFkNVPhFZK
         Aj+E0Ts36sj/gKYP57gKjgM7aNhK78Pk8RwoD1DBDk/68H7Sf8jYpI5kS8ttPPjsgc
         rHN3ObEhPfFDA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 4/8] wifi: ath11k: remove MHI LOOPBACK channels
Date:   Fri, 10 Nov 2023 12:21:58 +0200
Message-Id: <20231110102202.3168243-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110102202.3168243-1-kvalo@kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <quic_bqiang@quicinc.com>

There is no driver to match these two channels, so
remove them. This fixes warnings from MHI subsystem during suspend:

mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 28 ---------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index afeabd6ecc67..d4fe1d1c86e4 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -21,34 +21,6 @@
 #define RDDM_DUMP_SIZE	0x420000
 
 static struct mhi_channel_config ath11k_mhi_channels_qca6390[] = {
-	{
-		.num = 0,
-		.name = "LOOPBACK",
-		.num_elements = 32,
-		.event_ring = 0,
-		.dir = DMA_TO_DEVICE,
-		.ee_mask = 0x4,
-		.pollcfg = 0,
-		.doorbell = MHI_DB_BRST_DISABLE,
-		.lpm_notify = false,
-		.offload_channel = false,
-		.doorbell_mode_switch = false,
-		.auto_queue = false,
-	},
-	{
-		.num = 1,
-		.name = "LOOPBACK",
-		.num_elements = 32,
-		.event_ring = 0,
-		.dir = DMA_FROM_DEVICE,
-		.ee_mask = 0x4,
-		.pollcfg = 0,
-		.doorbell = MHI_DB_BRST_DISABLE,
-		.lpm_notify = false,
-		.offload_channel = false,
-		.doorbell_mode_switch = false,
-		.auto_queue = false,
-	},
 	{
 		.num = 20,
 		.name = "IPCR",
-- 
2.39.2

