Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F99446347
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 13:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhKEMWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKEMWf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 08:22:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5132C061205
        for <linux-wireless@vger.kernel.org>; Fri,  5 Nov 2021 05:19:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b12so13425357wrh.4
        for <linux-wireless@vger.kernel.org>; Fri, 05 Nov 2021 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ur1wrD2sIGIWoNcxmqfpjNRNAupi4pVF4IMCI+xTzz8=;
        b=mdJwVfnKjKOGLKJboaz2Qs1lQzjp2XaxaHiSXLgeazk57B7GmQic+bL1DUi6/LBFiR
         QsrXrAG30I+egL/jpoHm7xptSbWw0QnIh/evV0Hf9rfezJ5sp+i+nAxbPoVfZFH4mWMs
         bbWuVwqezWhPS1lmbqKnNhBjeg/GrsLv7W1xGB31eEHlcXo75r3EfffoMmz6KdOUmIpg
         842jK3rUXnvxk9E1pWnCPgBdJmAFC95eEe7potCAN33t0zliiGnf6M0hxqAAs34IL4qy
         fegGGxXC/oUSHdEi16mZIpczpT4mxP+7wJyohDtySOgCSDAj3kuQwao1Kaad22TJSgVz
         YIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ur1wrD2sIGIWoNcxmqfpjNRNAupi4pVF4IMCI+xTzz8=;
        b=QPSSA0Bp10Zjh7xL4oaPuA2aMivNUnZYLyMOhXKb1mQsgPkbXgt7Hy+dZwGx+zN5Bo
         ilgfSDWxu/XU8BmazE06Hl1IE0l2YX6eE+3I6AVNH29vsCBE5F3g5mwA3Wd2fiXqKivD
         zEOBZ+1duQzakLTWon6mk5/t73nGntlEfgdn8JJLbBVG9ilRB1Auiy8WjbxHWJSwHe+B
         xX6pwsHBEM0zfoT/pTyMjUq3Y3Nrx0pKhWziUbPqN69fQuzRvt6PdaZ9qI3+0UiwBcTA
         v+fXxyjoca3Pa1aiXKC/Ceq6h1ocAXCmn0Q1XDPuXqFj7ec2C+uMN8Ywzt/ZqiIJSnL5
         4tJQ==
X-Gm-Message-State: AOAM531cdfyRV6bywWRjsqwk9rLk0OTvphLpuPW+1MvCyNZVh8DV1uQ8
        4zFhIblALIVIifWza8gun5mqyA==
X-Google-Smtp-Source: ABdhPJw+GcM3Z3Yc9rMcIpQ8AWH8llWUm+tlLfSgRuAVrTWSa29CCiWlkJGFQFsx6c7bFIvDqM6X6A==
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr53593561wrz.404.1636114794299;
        Fri, 05 Nov 2021 05:19:54 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q84sm13961796wme.3.2021.11.05.05.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 05:19:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        johannes@sipsolutions.net, bryan.odonoghue@linaro.org
Subject: [PATCH v3 1/3] wcn36xx: Fix DMA channel enable/disable cycle
Date:   Fri,  5 Nov 2021 12:21:50 +0000
Message-Id: <20211105122152.1580542-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105122152.1580542-1-bryan.odonoghue@linaro.org>
References: <20211105122152.1580542-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now we have a broken sequence where we enable DMA channel interrupts
which can be left enabled and never disabled if we hit an error path.

Worse still when we unload the driver, the DMA channel interrupt bits are
left intact. About the only saving grace here is that we do remember to
disable the wcnss interrupt when unload the driver.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index fd627c9f3d409..d6c621518c7b8 100644
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
@@ -916,7 +931,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_WQ_TX_L);
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_REG_CH_EN, &reg_data);
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_L);
 
 	/***************************************/
 	/* Init descriptors for TX HIGH channel */
@@ -940,9 +954,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_REG_CH_EN, &reg_data);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_H);
-
 	/***************************************/
 	/* Init descriptors for RX LOW channel */
 	/***************************************/
@@ -952,7 +963,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		goto out_err_rxl_ch;
 	}
 
-
 	/* For RX we need to preallocated buffers */
 	wcn36xx_dxe_ch_alloc_skb(wcn, &wcn->dxe_rx_l_ch);
 
@@ -975,9 +985,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_REG_CTL_RX_L,
 		WCN36XX_DXE_CH_DEFAULT_CTL_RX_L);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
-
 	/***************************************/
 	/* Init descriptors for RX HIGH channel */
 	/***************************************/
@@ -1009,15 +1016,18 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
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
@@ -1034,6 +1044,12 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
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

