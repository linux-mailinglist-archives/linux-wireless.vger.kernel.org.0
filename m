Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEF256473
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgH2Di7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgH2Dih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732DAC06123C
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so861046wrm.9
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N19y8kE9YeS2Ow4HV/sGzCGkQdJHD/4e5dDKui+iRUE=;
        b=yepbCAl1pABiRrbEhw8HL5Fd8y8urACMv1Icyc6Nod2qle0Svzqp8ruh0DgZ1/cx1H
         unsYimJT49O92Bipn9tETk0McJHP6HUBH5TZM+v4Puw0zHN0OkZ+z6WlD9JiU4yc4KVq
         ixlJjKUcCaDffhaPpGWsf/4HD2anBH35FOJJpbhZbaC6BX9NfblR3752aw4KuPY3wLpf
         bm2woP7iOfVYgb7vMuV/F+vb9HmwUIJjiWImp4zP5dcMCJ9JZQqrHZdqHZChReHQqhOa
         e9cwJ6o3kSJSCyRegoEBZMURzMd9jz2NNZUfh9ez8sj5/+0tsVOF36ijH0JH+R/82shD
         r1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N19y8kE9YeS2Ow4HV/sGzCGkQdJHD/4e5dDKui+iRUE=;
        b=U5l/8bYn9YMHkZlMzjh+GWoQNUvAiYw2D1kbyFawCK5M7rcUX7vFVBvXxBs5X5rtm6
         0IpIpra5dJixbBbIVvpby/hGVa5nhr4I5TUPXpIsGayuZcJOzjYmx3exzuyz+9bCPvfT
         GQO+9p98G8FtUnh8x+TVtDH8+CHQQQfwLVWTRqByZkwMwRMIQBlrQVzd261TTiZnwbiD
         6AsAj3bqUHNukbc5hFEHsncgV9rik3E5v8s+4F5bhSvGlaVJJg86U6SsbUFeOU2eBE+M
         zmZ1Mu4h9SIUp6gApUd9nqdu/a5wXnKVXCcSb2dS3tO7knTSC/c+IV7LCjzBfq2A0qc+
         fU7g==
X-Gm-Message-State: AOAM5332nXjwr+EbhsGeD9eqf7ZdCDNMYQuz5YSgOLAVMz+pVizVqdLm
        0XoLYk2pL+pIjYPBr59TI3YG7w==
X-Google-Smtp-Source: ABdhPJwDCVid4jB1XBLc/5dRgTznllPWmc7r6Z4RAApTOd+g8Zm3/pJVctNaxXr4/3n0yAJe0Ono/w==
X-Received: by 2002:adf:8b8c:: with SMTP id o12mr1661873wra.353.1598672315173;
        Fri, 28 Aug 2020 20:38:35 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:34 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 12/12] wcn36xx: Convert to VHT parameter structure on wcn3680
Date:   Sat, 29 Aug 2020 04:39:08 +0100
Message-Id: <20200829033908.2167689-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to send VHT parameters to wcn3680 we need to pass the extended V1
parameter structures to the firmware. These commands need to have the
version number set to 1.

This patch makes the conversion. The conversion consists of

1. Setting the version number for wcn3680 or leaving it at 0 otherwise
2. Setting the sizeo of the packet header lower for wcn3620 and wcn3660

Once done all three chips can continue to use the same code to pass
parameters to their respective firmware. In the case of the wcn3680 the
passed structures will be slightly larger to accommodate communication of
VHT descriptors.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index d9bbbdc8d013..97fb47a8bc1a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1317,7 +1317,12 @@ static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_sta_req_msg_v1 msg_body;
 	struct wcn36xx_hal_config_sta_params_v1 *sta = &msg_body.sta_params;
 
-	INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		INIT_HAL_MSG_V1(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+	} else {
+		INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+		msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
+	}
 
 	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->sta_params,
 				      &msg_body.sta_params);
@@ -1388,7 +1393,12 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	if (!msg_body)
 		return -ENOMEM;
 
-	INIT_HAL_MSG((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		INIT_HAL_MSG_V1((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
+	} else {
+		INIT_HAL_MSG((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
+		msg_body->header.len -= WCN36XX_DIFF_BSS_PARAMS_V1_NOVHT;
+	}
 
 	bss = &msg_body->bss_params;
 	sta = &bss->sta;
-- 
2.27.0

