Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6842F1FA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbhJONRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhJONRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B07C061570
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso2378035wms.4
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fIgJBzQ+9WDIc4/3t3RLCBc0AqZncO8wqablVL8xJh8=;
        b=jqaE/kmlauY05WL5q3IpL/c2KwbmXazywzlqydwpMDBsjy0yfw6yWV8uBaFUOKBkLg
         JtWfMSAgj71dyn2IlLekP4Pgls6z3wWwFNonJ83ZdeNVvxOBoe2zo82MLPxdVGY8U7Ac
         D4DH92Y4O/PRraOX7Fmibkq6rC6jY3Qi8dbGNVAIx5ns+TRUuk8Iv2Ife3x7KVswvlow
         Le+j3IGbl6QYpzEmUWwpiQRMFkpnyTTlqdblbjfQGhZVyR0geebtovGoyoeLjVZ0+0pe
         REykH8HxD2JCYhGDkazOcbG32AVxchDNw2XprlOE1gjelORJ1C1DCsOTWOtnRk4id+vj
         vA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIgJBzQ+9WDIc4/3t3RLCBc0AqZncO8wqablVL8xJh8=;
        b=VnxIUqWg/V2NdPELy9u8x9SKrmNqt0x8vm5nTbEhH5RXcXealYuoZjEI2sQog5Hwtz
         ACYrvtBtd9V1BD6v2G7DW+2kLLUQd9RYRpKxCL8WEf9FcijZ59h9rCDYG0sRf0Ia+6jH
         1VhjfKxTK4ubqBLA46R+RBihJUwrIXZl7JfBeL1OS1sTvI80FUAyPR54f9xCPXIaTVa2
         bPt1aTX5qKl4aozXejMI/Qi26OzN14gtc4xb7UCp/yr6cF2Q/rFxt9iBpI4VMMszFANj
         Z8PfW81iIKM16KpTxU3G6qWC1K9GhRrrQzTTSzvF3ald5veKSGNPZerr+w8P1NNd6I5F
         lmCQ==
X-Gm-Message-State: AOAM531HliWfJW3pRQKAiSe2HULrjUN8W+os8f5nHteMLMnI8z6sKHEa
        LJhFAEiKs/dnb3IB6GIivo2sTw==
X-Google-Smtp-Source: ABdhPJxqEyLuQHS4lXBrCCpK3gDups+IJqnwpdcikaY1uMxOiI1HuLc9Y+F/c8DDnya13SO6fqwZEw==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr25657150wmj.39.1634303745310;
        Fri, 15 Oct 2021 06:15:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e8sm7091716wrg.48.2021.10.15.06.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:15:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 2/4] wcn36xx: Fix DXE/DMA channel enable/disable cycle
Date:   Fri, 15 Oct 2021 14:17:39 +0100
Message-Id: <20211015131741.2455824-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
References: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now we have a broken sequence where we enable DMA channel interrupts
which can be left enabled and never disabled if we hit an error path.

Worse still when we stop WCNSS, the DMA channel interrupt bits are left
intact. About the only saving grace here is that we do remember to disable
the WCNSS interrupt when doing the stop.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 4e898bde1bb8c..13e9a274fa26a 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -272,6 +272,21 @@ static int wcn36xx_dxe_enable_ch_int(struct wcn36xx *wcn, u16 wcn_ch)
 	return 0;
 }
 
+static void wcn36xx_dxe_disable_ch_int(struct wcn36xx *wcn, u16 wcn_ch)
+{
+	int reg_data = 0;
+
+	wcn36xx_dxe_read_register(wcn,
+				  WCN36XX_DXE_INT_MASK_REG,
+				  &reg_data);
+
+	reg_data &= ~wcn_ch;
+
+	wcn36xx_dxe_write_register(wcn,
+				   WCN36XX_DXE_INT_MASK_REG,
+				   (int)reg_data);
+}
+
 static int wcn36xx_dxe_fill_skb(struct device *dev,
 				struct wcn36xx_dxe_ctl *ctl,
 				gfp_t gfp)
@@ -892,7 +907,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_WQ_TX_L);
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_REG_CH_EN, &reg_data);
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_L);
 
 	/***************************************/
 	/* Init descriptors for TX HIGH channel */
@@ -916,9 +930,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_REG_CH_EN, &reg_data);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_H);
-
 	/***************************************/
 	/* Init descriptors for RX LOW channel */
 	/***************************************/
@@ -928,7 +939,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		goto out_err_rxl_ch;
 	}
 
-
 	/* For RX we need to preallocated buffers */
 	wcn36xx_dxe_ch_alloc_skb(wcn, &wcn->dxe_rx_l_ch);
 
@@ -951,9 +961,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_REG_CTL_RX_L,
 		WCN36XX_DXE_CH_DEFAULT_CTL_RX_L);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
-
 	/***************************************/
 	/* Init descriptors for RX HIGH channel */
 	/***************************************/
@@ -985,15 +992,18 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_REG_CTL_RX_H,
 		WCN36XX_DXE_CH_DEFAULT_CTL_RX_H);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_H);
-
 	ret = wcn36xx_dxe_request_irqs(wcn);
 	if (ret < 0)
 		goto out_err_irq;
 
 	timer_setup(&wcn->tx_ack_timer, wcn36xx_dxe_tx_timer, 0);
 
+	/* Enable channel interrupts */
+	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_L);
+	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_H);
+	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
+	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_H);
+
 	return 0;
 
 out_err_irq:
@@ -1010,6 +1020,12 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
 void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 {
+	/* Disable channel interrupts */
+	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_H);
+	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
+	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_H);
+	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_L);
+
 	free_irq(wcn->tx_irq, wcn);
 	free_irq(wcn->rx_irq, wcn);
 	del_timer(&wcn->tx_ack_timer);
-- 
2.33.0

