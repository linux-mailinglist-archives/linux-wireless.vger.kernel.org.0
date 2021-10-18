Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF67F432A2E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhJRXRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhJRXRm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB3C061745
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so43982819wrd.13
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbLM5Z3jD8SPQEozMJryUhBVooDo33aFTB2Os0auzZc=;
        b=hAIrENvHRnb4RSIeGT/YWT7oVggO3TgS+sD3kWQ/0yA+1biY1bh6snfeNIpAmdBmmI
         2WlL6CSXl3HxWwFJpCPICwkoY/Vyv68aa1khsfHcwcXFiCv6Ql84UDkHa/NTyZTyBGd1
         Hzk+LT3iAYZ9F29nfhP7jx1F5+6UtzEwUqUj5J++sefpeUIeVfYhz9beDSqj8pW/3ZdE
         x49l/OLkuGjxcr8J59p72kTPXqr30JJA9jWIb6uUNNQZEsuGge9NYJajTthIIxN1iylD
         Ws0sXHCxxezrcf6CwrFKgIJuMD1/Bx/6lJTItcMPKUI31M+2IbXoKLU33l2kGnevv9xy
         2Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbLM5Z3jD8SPQEozMJryUhBVooDo33aFTB2Os0auzZc=;
        b=LlMCvF6jRvqXsL2OC1UU+hQFPVNWEBxKG0pXTJ4htxCXMxDp/Jok5z9tqmulIPP/m5
         Rupz7Fa8ZKmHz6E579hLa7NGMUlzSNRI8WX3psS4HFmb1061rYsE/BsncpA5YX/yqh1m
         QaEWPQiDvP2I8oMgeP4IrZs94JxKRxUzKySDrJm2eA/dA6jVv5OdqOZsnLv5Wd1kKPCC
         EKSFBG0bVafQnG0sfYXJT3MJAmr/5I598EG4WrKPQw605FXl/s32I9ReRJiwG1COZBXV
         2HuHkeKJGbW/dlcyWTZ9RqhmeZVGDxkPU+XeG7WwJ8F96/InXVgPJVVeX1ty6OSon2s0
         kjxg==
X-Gm-Message-State: AOAM531tyGVLlsG0EDGU5imZracTqCNlIOLd92UYslZAOFTjE3BhnMK2
        sZsbZ14SzQIeqU3GxK7kh5r1eg==
X-Google-Smtp-Source: ABdhPJxeawc99BF6bii7izYsT+pg4cPUjx39WvlisOhOW36ApDogSAD62YcY3CD36Xz9rfvlCvY4Kg==
X-Received: by 2002:adf:bbc3:: with SMTP id z3mr40159667wrg.10.1634598929207;
        Mon, 18 Oct 2021 16:15:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm3685379wrr.15.2021.10.18.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:15:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 5/5] wcn36xx: Put DXE block into reset before freeing memory
Date:   Tue, 19 Oct 2021 00:17:22 +0100
Message-Id: <20211018231722.873525-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
References: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When deiniting the DXE hardware we should reset the block to ensure there
is no spurious DMA write transaction from the downstream WCNSS to upstream
MSM at a skbuff address we will have released.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index d4f5746d9b10a..cf85b0cd11be4 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1089,6 +1089,9 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 		wcn->tx_ack_skb = NULL;
 	}
 
+	/* Put the DXE block into reset before freeing memory */
+	wcn36xx_dxe_reset(wcn);
+
 	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_l_ch);
 	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_h_ch);
 
-- 
2.33.0

