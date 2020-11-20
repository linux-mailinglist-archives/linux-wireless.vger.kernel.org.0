Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69772BA039
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 03:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKTCNH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 21:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKTCNH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 21:13:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DC2C0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 18:13:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x13so1964844wmj.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 18:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BSPoG1Zi+TALCvJRKxCUtKA+N0pqJkuPFY0LmJPJy0=;
        b=C/c7ppoOFuQqVYtomLTN/r31dQxxwc7OihdLBhHy2ogjn7pWrOyd2elRJ4cnpUuZ5K
         B0PoF1tdAKqAq3eJUQLYrGszaEw8ZKJ7/ewgACFyugjm+0DZTLu7Pa6Bu0P4rSsKbxxW
         Yxb9o9XeQFcG3uGHWBkdx0Dgtup79MxkiKDNh6lJ6mJjaCGmOGOzA2+QS7uTeBG1Y6wU
         1ArUneRxLwc4gfCAfCTJMW8Z2Q0SKEiYICPfjkxl/LJh9XBdyskASO7Q+BL9SEnsizQh
         BAaRgLbElnZYQkaT5daGcCnnhvyXeOXpxEyhYnOclUxHacT9rlMEXqh5yR8fKvyw48wQ
         HOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BSPoG1Zi+TALCvJRKxCUtKA+N0pqJkuPFY0LmJPJy0=;
        b=r+ms/Vfnx55mx/M+sKusc+CkrAf/doCvbJFNGlyXDZcEEMLCLX7zPTN+fYFE8SaG59
         Vwa6uS4DzgrgazL1Q6jNmBfqhVCP3WQjw/EQ0NdHD4sd23d8LGZQrD8LKaDfWGgDO+R5
         cnYkDRTHselLtd2D36Ld+xX7vdXsKMRhHHKltct/tQkekPVBuqYFLs1AyqjiF56Jc62T
         Tk9lpmMn7TpdYzwruNiYAyDpOWpEgqTwpqIlcBTVS12iZVA61niss2pRWfbclbLpRwwZ
         nO0lhTdOfO6jYUMdwr3RvI48jevJyfs6ef5QXzv2kowXqmCBs+ALqTngmnAv2BM6RgGC
         JmQw==
X-Gm-Message-State: AOAM5305y4uBE6LlqAAPvGpSOUsS0zCL2TlXGmiRUbMjwKjmmiQeE60L
        4Dxhkp5epqshkahiumhu24WkSFae1mKnzA==
X-Google-Smtp-Source: ABdhPJwkqGHxlzKgA+JWhc7m4MrLINE2p2y6JL5ODsqrhs9OAMQJoo8W11xDZJEe4ifCfan/Uek2rg==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr7158472wmh.2.1605838384588;
        Thu, 19 Nov 2020 18:13:04 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c187sm2918261wmd.23.2020.11.19.18.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 18:13:04 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org, benl@squareup.com
Subject: [PATCH] wcn36xx: Send NULL data packet when exiting BMPS
Date:   Fri, 20 Nov 2020 02:14:03 +0000
Message-Id: <20201120021403.2646574-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
References: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit updates the BMPS exit path to be consistent with downstream in
terms of exiting BMPS mode. Downstream sets the flag to send a NULL data
frame to the host on exiting BMPS.

This will tell the AP to send any queued frames to the STA immediately.
Verified the relevant bit toggle in wireshark.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 8ff1eda8f942..acf533fae46a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2176,6 +2176,7 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_EXIT_BMPS_REQ);
 
 	msg_body.bss_index = vif_priv->bss_index;
+	msg_body.send_data_null = 1;
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
-- 
2.28.0

