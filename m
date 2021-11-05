Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7C44634A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 13:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhKEMWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhKEMWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 08:22:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A31C06120A
        for <linux-wireless@vger.kernel.org>; Fri,  5 Nov 2021 05:19:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r8so13386688wra.7
        for <linux-wireless@vger.kernel.org>; Fri, 05 Nov 2021 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38elbz2IR5fkB4VA0CiF9D0wL/2ZT5UdV8oyiOM2Qtw=;
        b=YLomm2FyDoSu9WMwGvizOLEjxt6utFt36oVByjGL6G0ZnccmJkoY+tbP3I6ufpw6XK
         oJFKLAO/X+MCjBnDriw6tE8jge2w7dt8F/0ljvZ2wwUrvNm6xlEDAUP0NSF8+VVJhFsz
         MG8IDpCZC+7IMBN6VA+WoiEt1h/WYO45tTol200KHlvQrpfAnFlFday0dfCm0esL/vnC
         AfV49oNtF7Hs3WfY46pabYdoCkCkUYcAvN6Xeu2VbSJechsswrGpnvAK5qhvKBCkK50u
         epoyv0Dbme9aJ1LOWtRxoXijrnT/oku6XaUHfJISY6Z1Vu6sUTvWPlIA79yvPkpVUKXL
         l//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38elbz2IR5fkB4VA0CiF9D0wL/2ZT5UdV8oyiOM2Qtw=;
        b=eHk/f3GxtBGm3/u5zWgOXz8nhl9NXq2DQq8Ouj9aY7ynqQTCASyCy1r0TlRds9acbJ
         Er+nYa5wE7eXD9DrgpeatopiCTo8/ni1W6lg94JSq3AdX9KzSzXOZwfySAGgx39hTggC
         Ul7wUMPWHj3BObGTeRxEeN3QmsNx4iC2DW8/Wfmi31fTZPqKju9G4Q9Y2oICZSkKnewv
         IxGgSTBvqxkOrOvBId0JO3opMdSdg+ExVfw4lfvnXEvRykJKF66OkDzA3Jhg5G/gCwu7
         iK081ZWlmMV9l5Trql8eGKZBlxQHHuNzeFm93+DZiG6gh0ClxVX5mWweRboaJmawFAdP
         nm2A==
X-Gm-Message-State: AOAM531TXVh+S5EG6kS/uCQX7fBTX7y0PWkGvk9LkC6TDnwRbe9kWKLU
        D7b7KzS4gnhdG+U7Yp/gkQEKMg==
X-Google-Smtp-Source: ABdhPJyUy/2kTmn7qjTbCcm7W10lj+MiO62QVIh+WhAE5bQoCEMxZzRkpBMjJsdeAk3WP6O66G20Mg==
X-Received: by 2002:adf:ce0e:: with SMTP id p14mr52434993wrn.423.1636114796154;
        Fri, 05 Nov 2021 05:19:56 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q84sm13961796wme.3.2021.11.05.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 05:19:55 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        johannes@sipsolutions.net, bryan.odonoghue@linaro.org
Subject: [PATCH v3 3/3] wcn36xx: Put DXE block into reset before freeing memory
Date:   Fri,  5 Nov 2021 12:21:52 +0000
Message-Id: <20211105122152.1580542-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211105122152.1580542-1-bryan.odonoghue@linaro.org>
References: <20211105122152.1580542-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index d6c951f7dec3b..4e9e13941c8f4 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1044,6 +1044,8 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
 void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 {
+	int reg_data = 0;
+
 	/* Disable channel interrupts */
 	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_H);
 	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
@@ -1059,6 +1061,10 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 		wcn->tx_ack_skb = NULL;
 	}
 
+	/* Put the DXE block into reset before freeing memory */
+	reg_data = WCN36XX_DXE_REG_RESET;
+	wcn36xx_dxe_write_register(wcn, WCN36XX_DXE_REG_CSR_RESET, reg_data);
+
 	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_l_ch);
 	wcn36xx_dxe_ch_free_skbs(wcn, &wcn->dxe_rx_h_ch);
 
-- 
2.33.0

