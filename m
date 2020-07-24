Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E946D22C2E7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 12:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgGXKPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgGXKPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 06:15:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD2C0619E4
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t142so1394988wmt.4
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xOOjQJESRtYt2KufOtjIRxHNZwgGy+9IHcMsoZIrghI=;
        b=rkDDKscMOyVNcs2gFEAVvnX0wv/PljueUqLwXnis0CGjRvXdVHnshtPaKz0FSVRVvD
         ZHJWW6GSf/reU/djVc5KUYqe5IkhOjHGb4l2Srneo3pHEcoJXy/nGzV2DPeMV9WXwQnq
         N/zXaLD8T8N8x97Yya6UMm1IbQ6VkeO+AuPsXCXlzX/X7sLY4y5CP1XVwunzkgYWx9JO
         iS4mdZE1f9iudpvA3KKW5z4IzZCIKGoCXuhqboxyBMGg5AtaomMGjaanCYO6oQuMT1Vb
         oLX6RvVuq+DJM44dr94V7rL5XtZhqzizLB7Y+yvYzzCqaLQwd4LfHdQlbjtekcdGef5R
         /32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xOOjQJESRtYt2KufOtjIRxHNZwgGy+9IHcMsoZIrghI=;
        b=ZBBrf4qpWSCevI/OIlkP24uwuFKzvJDqytR+Lzq7yU46o2sHJTDs8cSawRGRIlYGHg
         ZmW88OEcSVdMxYzxFe5YzhsWQeoTUrENU0Lygb1EcKNmuOtqxpaEB7q4SFVECjd6mmSS
         vyH3e5mkhyflOVfmm8wMvEjRJMb2yJLzgdvB5LVbxq+pYc0zun4LPoY+/Gt3bNeBMjLK
         mY9HHkwMxZIG9ehzoW0OqJWy0MN6/MnQsg1ehA1N6zhK+C71jbtA3ikqmCyJ1UJOtIlZ
         Y5/ILiY6SWtcsTxR68FBqkJBgzDzjXZUFKmvYLWGoexe8/mc0dW9h7Jq+gCB078vigA5
         U70A==
X-Gm-Message-State: AOAM532PIwuAdOExBD3C0NxG5WsjyxaUYzZzVCGc8SqRypE9s3Io/tKl
        a5iCGZZfAEfU2Vv7f31VKZz+/g==
X-Google-Smtp-Source: ABdhPJxXN5wp6qm73HC7GcGKHnv4qnkwMuJY7iiIz8tsUZ/S4sckHi4wiSWdL8oyNtqT6uVTLrDGDQ==
X-Received: by 2002:a1c:7ecb:: with SMTP id z194mr7594250wmc.12.1595585732200;
        Fri, 24 Jul 2020 03:15:32 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id d18sm774714wrj.8.2020.07.24.03.15.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 03:15:31 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 3/6] wcn36xx: Increase number of TX retries
Date:   Fri, 24 Jul 2020 12:20:49 +0200
Message-Id: <1595586052-16081-4-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase the short/long retry limit to 15 in order to impove TX
robustness in noisy/busy environment. 15 is the default value
defined in the downstream driver. Observed number of ack timeout
is reduced with this change.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 59f9f53..908cc6c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -45,8 +45,8 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
 	WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
 	WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
-	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 6),
-	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 6),
+	WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
+	WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
 	WCN36XX_CFG_VAL(FRAGMENTATION_THRESHOLD, 8000),
 	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ZERO, 5),
 	WCN36XX_CFG_VAL(DYNAMIC_THRESHOLD_ONE, 10),
-- 
2.7.4

