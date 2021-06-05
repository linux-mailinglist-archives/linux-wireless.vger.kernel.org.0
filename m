Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89BE39CA37
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFERew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Jun 2021 13:34:52 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41697 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFERev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Jun 2021 13:34:51 -0400
Received: by mail-wr1-f41.google.com with SMTP id h8so12481736wrz.8
        for <linux-wireless@vger.kernel.org>; Sat, 05 Jun 2021 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2I4qe28xHz443ZJOjbjuXHYaoVOQnlSqV81AqbJSsI=;
        b=Qw/VHqv44F9j/5r+l25fyyrsi6AJJzJijYwgne/GrKJVMSJK8LvPFAp4TAd+CpNHOC
         AsudxG1rNS3oDtZVYzx76zlHUBI4XNKFjlSN4oyazSUayEiBkfZpZ0KumlOaKZWzxd9l
         iSnOQhN6IVeZNtjVVMpSY9zGA6AlYMGvGzZeXZnn8yc6THIWepndLneWxEEWj0VciAEl
         Ej1HCkewGBbS7NfWso/dd8G5fZmEOZ6pOL2ciyZwXmeCAcVvr/8tSinAtv1IQ6xXVcAs
         Fbn2N5Xi9lHXcbIIw1rD6ytOUcYpNTVrNalIEvBZ03D6wOQoKQXqKnqHiwloEoxYyP7D
         8lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2I4qe28xHz443ZJOjbjuXHYaoVOQnlSqV81AqbJSsI=;
        b=g2N/s3YnusoY+BOzyxuPFK2WqsRLQINQS2GjxVqYW0N+j7q+16fgtx9zfPKxDPwf49
         V+FiE/2ky3sU7PRU/a7htCMQnOwzPaUIXSCRobzyxxZEg3w5L9SfS1kO9l94naxKHaLT
         qkvURGK2UqO9+WVd9tqVIURaIppIZcSCBDv4ddETnghtKJGqTOWmHHjDNVMqTYI0+Hi6
         WUsxjvYfq7g6nYajVyKIDE9mD5dqKtIxJsmPcrPMLaC2re/7n17jMIuvaI/TMMIaBwM/
         fCGGU47taFIEv62bNc9G0a6Vu47TCvVWXvYmGOtd4jTwjnhVChS4RiL4Dhd38rWAPOCU
         bSwQ==
X-Gm-Message-State: AOAM531BTjMhJLTroC5C8yRZeOvHmIrrcgbDTxDrAPGbE7joA5OTDAwt
        1AL7xmk4d/JK4VW7LuFXl05kewJAf6bb8gyw
X-Google-Smtp-Source: ABdhPJzgrHLD2960HxvygZ/u/jHa/QWSIkr8xirZ2oUWh/fTu0HDFmXxOEtttbXiD/Q/XNNDwyGfRA==
X-Received: by 2002:a5d:618f:: with SMTP id j15mr4208786wru.348.1622914322924;
        Sat, 05 Jun 2021 10:32:02 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g186sm2520660wme.6.2021.06.05.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 10:32:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH] wcn36xx: Move hal_buf allocation to devm_kmalloc in probe
Date:   Sat,  5 Jun 2021 18:33:47 +0100
Message-Id: <20210605173347.2266003-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now wcn->hal_buf is allocated in wcn36xx_start(). This is a problem
since we should have setup all of the buffers we required by the time
ieee80211_register_hw() is called.

struct ieee80211_ops callbacks may run prior to mac_start() and therefore
wcn->hal_buf must be initialized.

This is easily remediated by moving the allocation to probe() taking the
opportunity to tidy up freeing memory by using devm_kmalloc().

Fixes: 8e84c2582169 ('wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680
hardware')

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 84e117e0546c..2ccf7a8924a0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -296,23 +296,16 @@ static int wcn36xx_start(struct ieee80211_hw *hw)
 		goto out_free_dxe_pool;
 	}
 
-	wcn->hal_buf = kmalloc(WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
-	if (!wcn->hal_buf) {
-		wcn36xx_err("Failed to allocate smd buf\n");
-		ret = -ENOMEM;
-		goto out_free_dxe_ctl;
-	}
-
 	ret = wcn36xx_smd_load_nv(wcn);
 	if (ret) {
 		wcn36xx_err("Failed to push NV to chip\n");
-		goto out_free_smd_buf;
+		goto out_free_dxe_ctl;
 	}
 
 	ret = wcn36xx_smd_start(wcn);
 	if (ret) {
 		wcn36xx_err("Failed to start chip\n");
-		goto out_free_smd_buf;
+		goto out_free_dxe_ctl;
 	}
 
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
@@ -339,8 +332,6 @@ static int wcn36xx_start(struct ieee80211_hw *hw)
 
 out_smd_stop:
 	wcn36xx_smd_stop(wcn);
-out_free_smd_buf:
-	kfree(wcn->hal_buf);
 out_free_dxe_ctl:
 	wcn36xx_dxe_free_ctl_blks(wcn);
 out_free_dxe_pool:
@@ -375,8 +366,6 @@ static void wcn36xx_stop(struct ieee80211_hw *hw)
 
 	wcn36xx_dxe_free_mem_pools(wcn);
 	wcn36xx_dxe_free_ctl_blks(wcn);
-
-	kfree(wcn->hal_buf);
 }
 
 static void wcn36xx_change_ps(struct wcn36xx *wcn, bool enable)
@@ -1499,6 +1488,12 @@ static int wcn36xx_probe(struct platform_device *pdev)
 	mutex_init(&wcn->hal_mutex);
 	mutex_init(&wcn->scan_lock);
 
+	wcn->hal_buf = devm_kmalloc(wcn->dev, WCN36XX_HAL_BUF_SIZE, GFP_KERNEL);
+	if (!wcn->hal_buf) {
+		ret = -ENOMEM;
+		goto out_wq;
+	}
+
 	ret = dma_set_mask_and_coherent(wcn->dev, DMA_BIT_MASK(32));
 	if (ret < 0) {
 		wcn36xx_err("failed to set DMA mask: %d\n", ret);
-- 
2.30.1

