Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8408C239DA6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHCDKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHCDKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36067C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so14104625wma.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5DLtbiyK3rd9edQe5gM8jvZmZ4OmlENPvYbGbm0j2Q=;
        b=K/c/7AYv8jxtEAqw4NRJLB9gp9r9K4vxkKvVMKLn3DAtS/TJMlAR5TgaZp8GpXhWCE
         I7ySMzZoM0eCF2G+K7PpRdTIUey55nTdPHtHVNJ218ahfD2tS9C7v1QlZYUPOdq4vnkT
         T19gY0G89Ww9F4XVNP/6JtC0K12nueY8Mi+Yg7OXG/RMk1joU4tU6DjhkD7cHG2Sorx4
         EAQ4xUm2GwWbi3gSVnZ86c7FVyydp2XG4n2mr3LHoyTHAgk3qCqqqZY4chzYBEoNFpcm
         jz69nnR/Njp5jbcHSOJavQIRpZp9d/ac1Ljhp6ZxB7Pw+jbBoohDNQvgm1U9HxNJNPu2
         zuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5DLtbiyK3rd9edQe5gM8jvZmZ4OmlENPvYbGbm0j2Q=;
        b=lwGjqGjTEwr1dEHkZB/iBipiZPnPW2nY1XnbHO2ofOcrX/0Ht+FEcVpRSbhwPCfVbH
         UdKFyinCPkE4yAPWhZaSOF5Lfnk4MzAynodFd2psVx0Qb238i4BEyhsXOF9+NjE1ov4f
         XFC7Jb8B4NINlQmzpTUQoQ7gTveFoj/5p+rpvPojXs2Db2bf2EfBNWa2QpjGxrSLPk8m
         kiMz2vxcubEiPfBxM49EyOTHer1tCKwQ+xeSK/xBJ09cQiggPnOQu5mf8mZco45oVAk+
         CcQbd7WfKCaZ5/92Uc4gQUSYB4l8ebjACFUoC+iOjfmEf4Nw8Ivi2Hz61chTcUkiEEaF
         mGJA==
X-Gm-Message-State: AOAM531gj7jsb8TjrslGbnL9lUM1ngSyWNFYcJ3sB6P9flejHyK4OFX/
        qjan9XtSSUurMFIG5ppWdltztg==
X-Google-Smtp-Source: ABdhPJzpClYtP+kjdzG8/Q0PUpuURcUNrRG2/ejg5Rc4PgtcqmXQ6TGz/TjG8R2DxaixrYTKp4jBcQ==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr13683939wmj.124.1596424251970;
        Sun, 02 Aug 2020 20:10:51 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:51 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 05/36] wcn36xx: Add 802.11ac HAL param bitfields
Date:   Mon,  3 Aug 2020 04:11:01 +0100
Message-Id: <20200803031132.1427063-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch enumerates four previously unused bits in
wcn36xx_hal_config_sta_params_v1 describing

- HT LDPC enable
- VHT LDPC enable
- VHT TX BF enable
- VHT MU Beamformee enable

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index aab5a58616fc..8df3184a348d 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1507,7 +1507,11 @@ struct wcn36xx_hal_config_sta_params_v1 {
 	u8 p2p;
 
 	/* Reserved to align next field on a dword boundary */
-	u8 reserved;
+	u8 ht_ldpc_enabled:1;
+	u8 vht_ldpc_enabled:1;
+	u8 vht_tx_bf_enabled:1;
+	u8 vht_tx_mu_beamformee_capable:1;
+	u8 reserved:4;
 
 	/* These rates are the intersection of peer and self capabilities. */
 	struct wcn36xx_hal_supported_rates supported_rates;
-- 
2.27.0

