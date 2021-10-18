Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CAC432A29
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhJRXRk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJRXRj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A6C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so44330351wrg.5
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpmskcKe71TPZGRhow7F3YV4IIOIX62OuOrpbY+RO7Q=;
        b=R95yIGBIOzovHsbuuEh0AlNoXkgJIQA4VIfFrsW3weOXNHUJwfVQouzYmwfQf0Q5/x
         bygwNk0rdMkS+2tulz7Vg5QO5Lfi20Hqz8Sa2oVlNxyXH0xoGbu689gPxWAzLhcVU/dm
         qQIYznUHCb0kdo5RI9RipcC8wBHy/WoqYqF0suHy/QlTrP9uZvGJBCD2NVeeApQy7czR
         qWApoy2Pwa70l6UzbKbDZDcqXUzYMd8toiNfZ6tLVcaDKCAHnzw4UB20rp/AHPiwyKRW
         6oiOED2MjtaddOLhIExzu97A1lOLnJjWWcT+d21ctVhr58D9vAP3D78DMFxDYY7OwsFH
         jtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpmskcKe71TPZGRhow7F3YV4IIOIX62OuOrpbY+RO7Q=;
        b=raBJYzwR3aBvxeoN+lMMUHk6gpf9hvvNDDVoeQ/t3OHRHzkyfXclt+vU+N/lBVCOZm
         lr/ZaGUxNg/Bt5P2TdvKIGJFYQrLt/C3WCwrcJFMICkHFSGYHujD0TOwEJj/RXQvhmX6
         +4B1sdBti8vFDVU9+RovvlxCS0Mt2dS7K8p5kLPifsP8XJDpEFOZpzGBHqQnjOSO5bbR
         vTAhvOj0I7Eo9RQFBNeUSs2/OSFQAhNUm+VGmLDUto5QE3zBDqjmTZxdoEKWFEyRVjvv
         BOzdOPwqqmWhpsqjNnWsB9UNwMkidfI3qAqreAvRPwGTDwdtRTqCnve9Cp6sUmHW6CQ2
         Z/Eg==
X-Gm-Message-State: AOAM531WJfNY/GW8CgnV0mUji/GIF4AIktPZYZT1d/T9vJN3iaMaesyI
        +yBHPX2mGP0dKRcTdToVw8B/vQLoT2MGHg==
X-Google-Smtp-Source: ABdhPJx1r3OMTiLboWwmBPOeu0pJnZVdfzRAJKBqBn3cU3xQwUspQoBubTB1j8aw/NpXBFvonebIaQ==
X-Received: by 2002:adf:9c11:: with SMTP id f17mr40305177wrc.147.1634598926119;
        Mon, 18 Oct 2021 16:15:26 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm3685379wrr.15.2021.10.18.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:15:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 2/5] wcn36xx: Fix DMA channel enable/disable cycle
Date:   Tue, 19 Oct 2021 00:17:19 +0100
Message-Id: <20211018231722.873525-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
References: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
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
index 6c43df4bc92c3..b832afedde76a 100644
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
@@ -939,7 +954,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_WQ_TX_L);
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_REG_CH_EN, &reg_data);
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_L);
 
 	/***************************************/
 	/* Init descriptors for TX HIGH channel */
@@ -963,9 +977,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
 	wcn36xx_dxe_read_register(wcn, WCN36XX_DXE_REG_CH_EN, &reg_data);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_TX_H);
-
 	/***************************************/
 	/* Init descriptors for RX LOW channel */
 	/***************************************/
@@ -975,7 +986,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		goto out_err_rxl_ch;
 	}
 
-
 	/* For RX we need to preallocated buffers */
 	wcn36xx_dxe_ch_alloc_skb(wcn, &wcn->dxe_rx_l_ch);
 
@@ -998,9 +1008,6 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 		WCN36XX_DXE_REG_CTL_RX_L,
 		WCN36XX_DXE_CH_DEFAULT_CTL_RX_L);
 
-	/* Enable channel interrupts */
-	wcn36xx_dxe_enable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
-
 	/***************************************/
 	/* Init descriptors for RX HIGH channel */
 	/***************************************/
@@ -1032,15 +1039,18 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
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
@@ -1057,6 +1067,12 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
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

