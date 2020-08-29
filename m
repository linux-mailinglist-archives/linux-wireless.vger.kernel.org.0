Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B517F25646B
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH2Dip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgH2DiZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE6C061233
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so859566wrn.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqDt11mrhmiC3IjI/UjDrW3b5x9edV6yQCJKabdElZ4=;
        b=Bwwm4eygLWjAmmtikit2YuIr/6cNiQeVC3PE7wt6HWj4QyY/skq+bv6NJY1COURw7N
         iV6dIQGzFXnuo6enxxIfu2gwMHUIlrIlPLH/QCRVx2ZwjPVWbZjYoEqNQD7xm7u9HeDC
         xPEaMw5HOnvBs71OAOdIqvVqijCXywiaPljSR/A1HjDB90u5PhlSZx59/Gj6vCp9+KOD
         mulfAj8MHQ82v00Oc8ZNESviG7joVGHmoku7ztOKxUiqK4SaqqHTXxp0lhZj9L1Wt5/y
         MK89fRPM1/WnXhyuWHMclqPTzP19TDxEPGxtkDjfxUWcvBI8/OmQL/yxbpmN4y3xUA8Q
         /T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqDt11mrhmiC3IjI/UjDrW3b5x9edV6yQCJKabdElZ4=;
        b=opHEbBCjAA0lxAidywpsMVl9vfKBfoS8TtA0E7NCsq0PPcDbM74m5M46+OYXUCbQ64
         iMtCjUK9XahOEW8UcvFMFsXzhu++J4jT+CE3pf5tsod5dLdE7kb+2U8IOVEEZpQfLe63
         Ox/SOi+r9DWIYPKq+4xvzVpaheu6Sw43MvLIqD57DtDWUR/pScbV57G4IG3OAbKdPMFW
         6U+Lh6XiacKW5+dmQm+/EPx3EedvZcSQ0Rb2H2/XLV8hr3sAitS/VpC29fioQpBLzWCQ
         +U81GV+2ngyolCu8DJNS12r/8vSQmSzlkzjp1ysMBFNTbfrM2o5reiMfxpEliER2r/8o
         WDxQ==
X-Gm-Message-State: AOAM530n+M7mj5ZXzK6gwihHNDUmr6U9xwNXr9HJy3vZPjBasAwVu7jo
        CwxVa1we7Ktt4qwzOUxW3aaW2A==
X-Google-Smtp-Source: ABdhPJyVnzToKikFTB2/QFxGZl8CHMU3ZqrkLCq4ZhVES3IO/49nlw6cJb6rPfOshDLBeKVtGabDoA==
X-Received: by 2002:adf:c983:: with SMTP id f3mr1675278wrh.348.1598672303342;
        Fri, 28 Aug 2020 20:38:23 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 01/12] wcn36xx: Add VHT fields to parameter data structures
Date:   Sat, 29 Aug 2020 04:38:57 +0100
Message-Id: <20200829033908.2167689-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to pass VHT parameters to wcn3680 we need to use a super-set of
the V1 data-structures with additional VHT parameters tacked on.

This patch adds the additional fields to the STA and BSS parameter
structures with some utility macros to make calculation of the structure
size easier.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 573799274a02..3cceeaf0136f 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1592,9 +1592,15 @@ struct wcn36xx_hal_config_sta_params_v1 {
 	u8 reserved:4;
 
 	/* These rates are the intersection of peer and self capabilities. */
-	struct wcn36xx_hal_supported_rates supported_rates;
+	struct wcn36xx_hal_supported_rates_v1 supported_rates;
+
+	u8 vht_capable;
+	u8 vht_tx_channel_width_set;
+
 } __packed;
 
+#define WCN36XX_DIFF_STA_PARAMS_V1_NOVHT 10
+
 struct wcn36xx_hal_config_sta_req_msg_v1 {
 	struct wcn36xx_hal_msg_header header;
 	struct wcn36xx_hal_config_sta_params_v1 sta_params;
@@ -2015,8 +2021,14 @@ struct wcn36xx_hal_config_bss_params_v1 {
 	 *  "STA context"
 	 */
 	struct wcn36xx_hal_config_sta_params_v1 sta;
+
+	u8 vht_capable;
+	u8 vht_tx_channel_width_set;
+
 } __packed;
 
+#define WCN36XX_DIFF_BSS_PARAMS_V1_NOVHT (WCN36XX_DIFF_STA_PARAMS_V1_NOVHT + 2)
+
 struct wcn36xx_hal_config_bss_req_msg_v1 {
 	struct wcn36xx_hal_msg_header header;
 	struct wcn36xx_hal_config_bss_params_v1 bss_params;
-- 
2.27.0

