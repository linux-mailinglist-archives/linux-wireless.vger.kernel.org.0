Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE332239DB1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHCDLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgHCDLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7388AC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so8893017wmi.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrOV8j+dZUEpzVBAQmMgPqqjv//xk+FxMjpzH66IHaA=;
        b=qUj2SUbTycO2jZzjVCBEYnhjccDnQvme9JfD/u6FXYbQp54kMGQxwwDayznHIwgYzR
         GwZd/1dn3WUyz0p3t0ivQXEg/hXv1VGLx27U3TSPQlWaLV95GU+iGiwKyvQhamX1mG6B
         ggLI7wMIfq2ui19PrGUoO09V1daNJ4Fs6mzST1nL/wmT7VxCp9i6Plthac3X89I8cegE
         bWviszeCgHO94OUQFoVM9n95/WlpMv2BX6ejjhdN+Da2lPVAe9szLjRjA1dx1U/Xg4NZ
         DFUaI+E+kkO3TuSBnm9F8qExsD6GU+R2exmhgKWLfCFo4yoAFYR2zezJgdJ9XheHLjV+
         Kuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrOV8j+dZUEpzVBAQmMgPqqjv//xk+FxMjpzH66IHaA=;
        b=YM47gzNng1bdqeSn2KJJjRwf5xk9lqog7cRuQik6BfSLrijkKpXYoJZIMgPdC7sr7G
         9fxOnGiN8v8UUG3LCwNJSwUpQphEgFj3Upq5lN/iOa5hDNV1j+WggP1fasnItZcDpNfA
         uAMdVhEyq7XTjbnGcLkpOCcXvBIGy4bW22fhV8zO+s2QhTwoTk2P3vRTzPHOXD330oD8
         CEo/HSz6+nof7flJTCUHzUuhMq6NQeSEbkCo8SF5+U/KxMfR+C/AB66uI2Sl7/bYWWqd
         Wzy+zQe1uZTFNe+UvY4EsrG5oSpxSjBvG40sbU+s7cW6htjds2CygJwovsLySNcoE3NZ
         POBg==
X-Gm-Message-State: AOAM530v1B4fYtpfaNYHfp0Lpdjll+DepyZiO+mAzM67AgAwILROJ4U+
        PnTaJI+OTl1+jHXsG6HMWwPbY95wX/c=
X-Google-Smtp-Source: ABdhPJyOPm9oYLKHrYbOiFcZPBJPeG4IaBYuR5EDldFKRQMphE/DHTTcVPfDv98ejXBeH2IFHZQkHw==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr13516636wml.48.1596424265268;
        Sun, 02 Aug 2020 20:11:05 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 17/36] wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
Date:   Mon,  3 Aug 2020 04:11:13 +0100
Message-Id: <20200803031132.1427063-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_set_bss_vht_params(). The job of this function
is to decide if the BSS is VHT capable and if so set the appropriate bit
in the BSS parameter structure for passing to the firmware.

VHT Channel width set is not set since we don't support 160MHz.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 8bb24fe9bde3..ab9f0361aec4 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -145,6 +145,15 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
+static void
+wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct wcn36xx_hal_config_bss_params_v1 *bss)
+{
+	if (sta && sta->vht_cap.vht_supported)
+		bss->vht_capable = 1;
+}
+
 static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

