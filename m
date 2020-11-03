Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F562A44E6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 13:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgKCMQm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 07:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgKCMQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 07:16:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08843C0617A6
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 04:16:41 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k18so12551011wmj.5
        for <linux-wireless@vger.kernel.org>; Tue, 03 Nov 2020 04:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlmuRyRTsccQs11337/cNvBJ75DEr7vPuxm5KWIHi20=;
        b=HHy0mndQwujeOhiq71ViwLo1ljXcsNpMOf4lVqk7taZR2mz/fYRUPcYcta2AnF9VhT
         GNCNVZpcor4YukSqyJuRfzX4nadfkOBsfoHIIo35uG91+I0Rl/U75YNq4hup1iatiJdI
         TTH+XyxgT6oR4QudVLR0TADFXEthmKWyCM2nK4aBhX8U/wy34rIdMdO9FLRGyQ0Jj93e
         FAWVHpWqYPJFopI+oAhG1b9aOP9GGJI7HH+w8Ub7BOi9QA3VkOqMRwW4w8UdiXCkjTww
         /RGcsV9C4ScAle3/7Mq8Z7Tb7Wo5BM7EmnEgDBu9e7IIrpZaT5ydVeP9nVO42b5vBZ+7
         KcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlmuRyRTsccQs11337/cNvBJ75DEr7vPuxm5KWIHi20=;
        b=aTNi8dI6ITdrAR/Sg2q8IGJZkfS0tvyrSRSEGPyWTDrWvkfdoDApkro9AkTtyAx0M6
         Qx1uaKdHxieR/jd7exgMlWfxVYdtFU4LLpTQq0AYNvFT1bO3Ep7HFSbGWjIzrex/mdcJ
         /aT9vRJmzeUqIt4XP5BXi65ZIia94+/Ks3cGpb/jSEc0FFM8QbYm0Mkyd2Y8aGAxEwHu
         eEdMROuug7tmBkCQw+Y0lk7A1MfycHnkvPClSO1LSkesIa0SA6pC6gb15KAlSQiXqOB3
         N3qdbYGJSjuHF0ot3b/NC1kY7gN5leOCtJftRDTIQww9RpBXIWtRCj6PK6MXY7+4aM4C
         JnRg==
X-Gm-Message-State: AOAM533tbCJfZg3DyGvt5xwi69AuMdcE47UQH3NaSxwdiHpYPEJh7Ebc
        vRMfrVY2sW1ueVPmdpWt+TkvNA==
X-Google-Smtp-Source: ABdhPJx6BZp9a/RMWVolQpA1tVInIu+8wj4IVPiMgKjERw9a9I4+DxyTUfc8Bb+GpDEVeeispgzk+Q==
X-Received: by 2002:a1c:6643:: with SMTP id a64mr3426219wmc.142.1604405799770;
        Tue, 03 Nov 2020 04:16:39 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z6sm2678210wmi.1.2020.11.03.04.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:16:39 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 1/3] wcn36xx: Set LINK_FAIL_TX_CNT to 1000 on all wcn36xx
Date:   Tue,  3 Nov 2020 12:17:33 +0000
Message-Id: <20201103121735.291324-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103121735.291324-1-bryan.odonoghue@linaro.org>
References: <20201103121735.291324-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware parameter LINK_FAIL_TX_CNT maps to the prima configuration
file parameter gLinkFailTxCnt and is described as:

quote: " If within gLinkFailTimeout period(values is mentioned in msec) if
         FW doesn't receive acks for gLinkFailTxCnt number of packets, then
         link will be disconnected."

The downstream description sets a minimum value of 1000 a maximum value of
60000 and a default value of 6000, however it appears that unless we
actually set this value deliberately firmware defaults it to 0.

Setting this value to non-zero results in the firmware doing link
monitoring. The working example from downstream paradoxically sets the
value to 200, here we opt to set the value to the minimum stipulated in the
configuration file 1000.

In conjunction with ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR); this
change effects offload of link monitoring to the firmware.

Tested with:
'CNSS-PR-2-0-1-2-c1-74-130449-3' wcn3620
'CNSS-PR-2-0-1-2-c1-00083'       wcn3680

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 766400f7b61c..8ff1eda8f942 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -78,6 +78,7 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
 	WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
 	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
+	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
 };
 
 static struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
@@ -162,7 +163,7 @@ static struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
 	WCN36XX_CFG_VAL(ENABLE_RTSCTS_HTVHT, 0),
 	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_WLAN_LEN, 30000),
 	WCN36XX_CFG_VAL(BTC_STATIC_OPP_WLAN_IDLE_BT_LEN, 120000),
-	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 200),
+	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 1000),
 	WCN36XX_CFG_VAL(TOGGLE_ARP_BDRATES, 0),
 	WCN36XX_CFG_VAL(OPTIMIZE_CA_EVENT, 0),
 	WCN36XX_CFG_VAL(EXT_SCAN_CONC_MODE, 0),
-- 
2.28.0

