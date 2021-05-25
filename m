Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180F83905F8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhEYP6T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhEYP6S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 11:58:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E1C061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 08:56:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1900225wmc.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=j0+7eWS8tOIbvXWwCPY5Ai3hB4pdNmPhH6uzOnxCZPU=;
        b=ZbGHFTtLhXxnuZBwVOE2q7e2gds8NjnjMkja4nkof/64vtp5t183kRzJYVdKmUOmy4
         vyV9p/vlHfl0O0QTr/8KRud9A65XWrjPxY/1u5Nly1Wh9b5ap7gUg8xiopcvOaLl96wK
         Zpt+EZ4Epf81PrmZkdKa6uNrYfEc+EqwWo3Rv44TwB9Or+xichFy3Lqo1OQFGpaVqq2Z
         VmxNrI3MiqN3GxWUCyJMeIy0dil94D054jawuxEEE1C1TfS4/OIVptrPiETsoLPBFVM7
         W6QwoU85hapzraM2epzf+TmuSkYccrqkM0vfQ7Z8GuOCC6qH9r28oxtO+DFJWUyxY1KJ
         XRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j0+7eWS8tOIbvXWwCPY5Ai3hB4pdNmPhH6uzOnxCZPU=;
        b=EfdHOnhjiRYqNL3zrqmYhdf9t4j9Z9Nxghct+vqSHG1NU4xCcdyjZ1YAXDvSWFzU2z
         A/vkQ8sIMQYck5KgpiUMibFKHssZQcSvDr1u8cAn54hyeIssj7au64s3eP6q1RKDdqbQ
         0eDW+6e1enSM6VKhoBQckzQ1NaLLqr+O7x0GYvgOVt0jxz0O7DorvCTiwtXK9Dd38lgI
         l92x+S3RfJAzX5Q9iheOomNDUZSy7EPqUkYoIwBPkQRe4oD75slH+pD0LpEVioqB523k
         TDQIs9navs3Kj9fNZSAQMNAkITKSeC1GNXoMkZjyCODR5iQzIwzWLIFfdJyy0qLw4Ge3
         TguQ==
X-Gm-Message-State: AOAM5325yx4WrFj3Na3HLzyY1t5RDW0RpIfUaVbuU9jLeubDuLARG/2W
        AeIuGf+qdWUyYibRDI0RYow7ow==
X-Google-Smtp-Source: ABdhPJxYnAXtSLH14Y1b+PYqtQ8+wNnK0UH34SbyA9RXpnlmlNDm3B65Ljwyio7zXYbGrp7AoxtZXw==
X-Received: by 2002:a1c:2b83:: with SMTP id r125mr24501723wmr.77.1621958207461;
        Tue, 25 May 2021 08:56:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:d5ad:807c:5350:bb5a])
        by smtp.gmail.com with ESMTPSA id f188sm3042265wmf.24.2021.05.25.08.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 08:56:47 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] net: wireless: wcn36xx: Handle scan initialization error
Date:   Tue, 25 May 2021 18:05:39 +0200
Message-Id: <1621958739-5557-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case firmware is not able to initialize scanning, return
an error to skip scanning on the channel. Scan initialization
can fail, if e.g. the firmware is not able to submit the null
function packet with PS bit set.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index eaa38d3..c99c670 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -433,8 +433,11 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 			/* A scan is ongoing, do not change the operating
 			 * channel, but start a scan session on the channel.
 			 */
-			wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
-					      wcn->sw_scan_vif);
+			if (wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
+						  wcn->sw_scan_vif)) {
+				mutex_unlock(&wcn->conf_mutex);
+				return -EIO;
+			}
 			wcn36xx_smd_start_scan(wcn, ch);
 		} else {
 			wcn36xx_change_opchannel(wcn, ch);
-- 
2.7.4

