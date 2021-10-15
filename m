Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81342F1FC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhJONR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbhJONR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0DC061570
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t2so26487766wrb.8
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gmGyGZOX0tnnXnf/J6ROMaBVuBmbeJjJwd98SH6/w8=;
        b=swD8uv4xh5lHBS/mXNWezLGFNq5/+jbSkjnBi3SmewcfhfUNU6KBN8YZrf5y6P9oiG
         G9EqyKhBORWixMtktl3MD79UYQZfoP6fkdLOg5pYZHtJvTPynDjiabCD6dj6X6APxsY/
         HOtexPglLxjkaaHuntyBwWEKbrXAlUZuLPuA5Kd58QTwkmSP59if6TPCoGu/6PXV61FU
         i9KintPLyAis9oqHqNBdcrzYglqklDPRnOtAO61YWH2ELneLblnYcka9NcBUbJY5MhMK
         aYBCQhRetRZgdH0imwVJI7mnoaRuiVboC5W49e4kwUOYjo2OLGPm0rHZePbW+BUkwWHF
         VqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gmGyGZOX0tnnXnf/J6ROMaBVuBmbeJjJwd98SH6/w8=;
        b=M52c1UnpQJg/DKEOzvVvEO/2Fwtq8/oaHRdpx1dmtX1vUM14UdCXMKbCj/6xYcCCm6
         g53PFhxzlRzs8IhfwgKWtHhN6HSKfO6PvfMFV3uaFjkYOydJ1m0SlZF+WwBZDsCiwwC1
         xpA9tKGuX2FrMeUckZ3vKInIWc9uuLC43M7l/QgOWAUMOJMQnP5lMsaoOCuTL8j+KxBS
         C98DbaFOdAJw8SRtStfkfmzBGg3s7I9HFZMgrg9fpsBNKd+1+DX7A/QUqqDnwbUkps1R
         EPI2u48hvdNZU1+UE06a6DHijOq9CxxLkEx3zdm5D0sPfqZzuqifSGIuO29fbcPaRl8M
         qaaA==
X-Gm-Message-State: AOAM532l7Tgt6heWNEXM68R/MQJQ5t+cImokCoYGZcTABmTevLDFZHSP
        5WeqfScoVityBHpOYNhyIrtjMw==
X-Google-Smtp-Source: ABdhPJyxlNG5jcJ++CYVtKUg8kPWkHNgfsbTh2jiUAlU0PLgY50IBN/LOpXMNmmXirHBiXBuCPXAQA==
X-Received: by 2002:adf:9c02:: with SMTP id f2mr14507888wrc.329.1634303747566;
        Fri, 15 Oct 2021 06:15:47 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e8sm7091716wrg.48.2021.10.15.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:15:47 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 4/4] wcn36xx: Put DXE block into reset before freeing memory
Date:   Fri, 15 Oct 2021 14:17:41 +0100
Message-Id: <20211015131741.2455824-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
References: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When deiniting the DXE hardware we should reset the block to ensure there
is no spurious DMA write transaction from the downstream WCNSS to upstream
MSM at a skbuff address we will have released.

This is actually a pretty serious bug. Immediately after the reset we
release skbs, skbs which are from the perspective of the WCNSS DXE still
valid addresses for DMA.

Without first placing the DXE block into reset, it is possible for an
upstream DMA transaction to write to skbs we have freed.

We have seen some backtraces from usage in testing on 50k+ devices which
indicates an invalid RX of an APs beacon to unmapped memory.

The logical conclusion is that an RX transaction happened to a region of
memory that was previously valid but was subsequently released.

The only time such a window of opportunity exists is when we have
deallocated the skbs attached to the DMA BDs in other words after doing
wcn36xx_stop().

If we free the skbs on the DMA channel, we need to make sure we have
quiesced potential DMA on that channel prior to freeing.

This patch should eliminate that error.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index e89002502869a..56f605c23f36c 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -1020,6 +1020,8 @@ int wcn36xx_dxe_init(struct wcn36xx *wcn)
 
 void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
 {
+	int reg_data = 0;
+
 	/* Disable channel interrupts */
 	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_H);
 	wcn36xx_dxe_disable_ch_int(wcn, WCN36XX_INT_MASK_CHAN_RX_L);
@@ -1035,6 +1037,10 @@ void wcn36xx_dxe_deinit(struct wcn36xx *wcn)
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

