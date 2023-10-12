Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B577C6FDC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378910AbjJLN7C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379134AbjJLN7A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 09:59:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F6B7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 06:58:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E3CC433C7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697119138;
        bh=n9lHXN53vZx2EaEbEDyRkXMHxzo99KLDFNNHaa9eqtY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FixRC5cnfAywIatd6ZX8qeWr5xQ+ZtOT7LlVbLN8nUvPIqNgn6UK86/Mu8Nh8VDVH
         8CjTGNtHs6Hen++X+FM9dBwmYx4INDBniClAxYroud2RMU14i2CrMcLogYMwsKgonh
         dN5nbj29gNSAO1Gwcugimf/1jyp1Nes/eIDCN3XkLhuOKHzaYydaahvEMY6S5wDwKJ
         svVUZ8Ehz7FBRqm5Ct1rvdEKeui2LwRDTI/xP4cwdA1gngV9z9AY0KfAw2K4UDL3gB
         /hUAG5o+s2K8US1DZ7CA2K3h6qPMU31/8QRmcfXtukijs/DnWgY/DLPvuxLiWETZJd
         0b91K6Aoy8jOg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] wifi: ath9k_htc: fix format-truncation warning
Date:   Thu, 12 Oct 2023 16:58:54 +0300
Message-Id: <20231012135854.3473332-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012135854.3473332-1-kvalo@kernel.org>
References: <20231012135854.3473332-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On v6.6-rc4 with GCC 13.2 I see:

drivers/net/wireless/ath/ath9k/hif_usb.c:1223:42: warning: '.0.fw' directive output may be truncated writing 5 bytes into a region of size between 4 and 11 [-Wformat-truncation=]
drivers/net/wireless/ath/ath9k/hif_usb.c:1222:17: note: 'snprintf' output between 27 and 34 bytes into a destination of size 32

Fix it by increasing the size of the fw_name field to 64 bytes.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index 5985aa15ca93..b3e66b0485a5 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -126,7 +126,7 @@ struct hif_device_usb {
 	struct usb_anchor reg_in_submitted;
 	struct usb_anchor mgmt_submitted;
 	struct sk_buff *remain_skb;
-	char fw_name[32];
+	char fw_name[64];
 	int fw_minor_index;
 	int rx_remain_len;
 	int rx_pkt_len;
-- 
2.39.2

