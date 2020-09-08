Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FA261A59
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbgIHSez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbgIHScm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C866C0617A9
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so320422wmi.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/nry3NgBBjA9BLR7RzttfZX9dZbP5DRqQfPiOO3p9I=;
        b=HxjEjeDBpqabIpTm9g8TfVny9NUnL1Xihv2rOtm2tlJTyPEAHZBVpluoQb8Ak53QKY
         dUPcWsNWEqq2jYhMIvrxQUMq3awrNg//GzJolKw8l4WM+ju7sfe8qAzYZ1xkIQ/BlGc6
         DIsYmJxaxA3EW7RQHbi/MUpNvssNh0Pnh5p8WT4AuUmnVHzlr/3dLHpM3CDRd4NgPTwM
         HMZmgQ7pNw6CRAx3eQF4uFetr217Y5e2n65TMZNIQ9TZJQYQq3WyBKpPcjtkwkasSI0r
         CRoutRGFOfaDxRWWPnRmnvLwo/NAfZDNrnfkqmsS+uJdQDiw4kqR9jrAIbR0muESpqbY
         oktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/nry3NgBBjA9BLR7RzttfZX9dZbP5DRqQfPiOO3p9I=;
        b=hhDED9CKX36QGvsUjIlAhTU3GlSN7vmaB0Q0ZpJ9iApmZDQv7ZW8qzM280Oz1okgki
         5V2Gl3RzZq8n9e8HSNiQsgms/7QauIwHRmRLndC4w/EzChTsAXuUG8mNNiirfHxYm1+g
         JE5oupU/aAoob/6EDtH8uuxMoJc6cLUt1ZkgdE04oEZ/HUq80pOZJiTrhAdBNpGSdixk
         3u1bguBiA6HVs55LPK3M5Eb8r+ppiJhjHXDh8p0qk2VmdFi4BVW2p1S8gEdLw7SRyES6
         5f3SX+g/p0c9sBet3jYDvmwlZVqaO9U2nBrNussu379qIQWBOMkaJw9bByv3zLBtZiSl
         s28w==
X-Gm-Message-State: AOAM532WGTnhZU8BBdo0rsPnT+H0U5YL+m5ynQLq+zXntQlea4P39tfi
        EX869Jzen7Fki4CjJbRWv+CUPw==
X-Google-Smtp-Source: ABdhPJxyfLNWtypkQM07L2ohUM8yZ0qFlIZ175eNIR4rWUp3yi5HOjrtXz59ODWJWoYfNvPvF3f/mA==
X-Received: by 2002:a1c:6445:: with SMTP id y66mr445429wmb.12.1599589456130;
        Tue, 08 Sep 2020 11:24:16 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 6/7] wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
Date:   Tue,  8 Sep 2020 19:24:54 +0100
Message-Id: <20200908182455.2870345-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A previous patch added wcn36xx_smd_config_bss_v0() this patch converts the
version 0 data-path in wcn36xx_smd_config_bss() to use
wcn36xx_smd_config_bss_v0().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e603e2d3be16..fc922dd9ccde 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1707,9 +1707,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
 	} else {
-		PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
-
-		ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
 	}
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
-- 
2.27.0

