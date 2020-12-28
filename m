Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5F2E67AF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633518AbgL1Q2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633508AbgL1Q2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCBFC061793
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d26so11721130wrb.12
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61/IO/ybk77sJ5G1Q4pxAhHWdP2licw/COCpz/eNPLI=;
        b=ohwfsIY91vM7KCpWo6qaIHvnnIEVW3ex02xQKCE0YWnD2g0f4y4fUHm3Ju3H/T2h7i
         PD7oGMW+5AHto7R1zbs0rGu3oV3P+f/Gn/RdCocp9jHIn/5OZik2dD6/0S6kC1ha7wHp
         k2951AzIgZs3f5+QdOH1wgKQsLXb+wWdwIV61arjejbVWnNJgBN2x73sFbCa9lbE8Ihu
         Z5CPXc3P9aQwZTu5+W5CE2xZ0e/FzaBUM+p8bx6vU/Gj1sAu4ljdElFCm+qkp6P9MqBi
         00vy7szTobHGI4ZLvsFrabclDQjqc0tYpM6lPfuL07i62sWZ1OAvOFUByRxMVG4Q1qjK
         SvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61/IO/ybk77sJ5G1Q4pxAhHWdP2licw/COCpz/eNPLI=;
        b=jTR+Ehp+pyfHVyIObyqTwm8Yz2G+PBs9tEflt3nhXFdNGodWOlr9LJfoBUL4ardWOx
         zlNe2RztOaW8KzaKOLzMJ1cxCRe6KwzOBKGllwKLCo7+bdi4mddS32WnbF7fHi54m5KV
         62DwR++e3TJv2ck/VKed4P/k7r+8oOwQcrdPj32GvnRmI0SOcHW5SLLrR7XSRsGe4NUa
         brDN8y9hvTwNxV6AkOzmn27q9oDITNMNcXmbiIv3u3CqZOmNgj9qX1cZTZ0n9toPqJBQ
         o7IqBn/Xooxrr5WtGth65tFqn0+8ORsqaGLs3LV+pYmH+7P5lghz0Puj9r0R2l30eZfR
         tEtw==
X-Gm-Message-State: AOAM53101Z1uF8t7viqsaqlxieyVmQy3CdpKrDbCfGYkw1ITNwz/ZXSe
        r06FP0AYl6bgttYwCFgH/Mi38A==
X-Google-Smtp-Source: ABdhPJwcuusV/T4OoKNxTFSYLQFR6ywxdVgMUTVLSH+Y5KvpI7Rr8Lv3nLWoWccVQy5Vpfe/D7fOpw==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr51861229wru.407.1609172851213;
        Mon, 28 Dec 2020 08:27:31 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:30 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 01/13] wcn36xx: Return result of set_power_params in suspend
Date:   Mon, 28 Dec 2020 16:28:27 +0000
Message-Id: <20201228162839.369156-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wcn36xx_smd_set_power_params() can return an error. For the purposes of
entering into suspend we need the suspend() function to trap and report
errors up the stack.

First step in this process is reporting the existing result code for
wcn36xx_smd_set_power_params().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 5867bd9c2f64..a863a90232c9 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1091,12 +1091,14 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
 static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 {
 	struct wcn36xx *wcn = hw->priv;
+	int ret;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	wcn36xx_smd_set_power_params(wcn, true);
-	return 0;
+	ret = wcn36xx_smd_set_power_params(wcn, true);
+
+	return ret;
 }
 
 static int wcn36xx_resume(struct ieee80211_hw *hw)
-- 
2.29.2

