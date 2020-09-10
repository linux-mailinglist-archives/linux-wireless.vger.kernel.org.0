Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72819264F2E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIJThi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbgIJPn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:43:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B40C061798
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so7024891wrn.13
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wpHFXT43hTfOLrdx99kEARdkSVehiZDUWZ0k5+bAcM=;
        b=evEgOTzgaaH6t8OrC3OfLOrvtmjvvtWy6/oM6kpfQZFueL4RDlMs/NaNMf46+bZmji
         BHWyrDr15M1vvd5h/mt6thxXPuAeX8FKslzAGvLv6f523ZSH3aM5vaoZ7vYZm3olM0Na
         F2/J0wlidFiQZH+2a/ym0wNxkk+ZHgu1nal2TwQzRgSvD+3CAJeq3je22NnkcbrRN9N1
         fOlJUFfH+ceujS+6q0xe26LRWmPXOk1BVPSZCxHvZeC/YUvBeVJ0L8JP5bVMMdXg4cjm
         evAGlZPFCo2hJiFn/hIqycA2bXWmXsZsHn3ylPbbPab2oHuW2uF5NxEue+vyeg25nl3H
         er7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wpHFXT43hTfOLrdx99kEARdkSVehiZDUWZ0k5+bAcM=;
        b=ZxYHTLWgvWVBz97C+JhOfkNzwjCct/gEf/tQLwo0aWwveQqU3ODQWGUfexm3XQnKaf
         GpWkElE4iSymRFNoGgssRMJ6dlNZtGeR3men4lyRtzSREfodCNYmfyHgMM6005pcUp57
         gAnQFvM/l6587RxP0EL8mNCs+QRY0WQkbIEDC9UXSdjZOmjwZBQMwsy6MjA5ilkSsb4t
         cvESfUgVadHpOU/bXEl7bvU3y+UtSAexDx6KLUIf1fz8OSmLpAsJnM6W8JJASgWlYJvm
         bXWe6hwLAlcAu2Bp+cpMNyo34nRS2EQHJXJZe0gEPP46/mySELnIXVTSm5IBtGogR91f
         lXgg==
X-Gm-Message-State: AOAM5337uMEtUs96lbn7QqkhFPM+QNdu6zXCKXtA/bPRrsE9NHFV+TcF
        lZ0wuLmFSUOaydGBV06cLFD4Jg==
X-Google-Smtp-Source: ABdhPJzNUxBT9htfbVVzU6xcr26+bo403u2r16FXCbiC1iD+pO3xoxBV4V9NeEAnrAai1rROkANWHQ==
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr9470628wru.7.1599750307766;
        Thu, 10 Sep 2020 08:05:07 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 3/7] wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
Date:   Thu, 10 Sep 2020 16:05:48 +0100
Message-Id: <20200910150552.2178882-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toggling the LDPC enabled bit is possible only via the extended V1
data-structure. This function provides a means of setting the default
depending on chip-type.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index bf584ac382cb..e926bbaec220 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -208,6 +208,17 @@ void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
+void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
+void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		sta_params->ht_ldpc_enabled = 1;
+	else
+		sta_params->ht_ldpc_enabled = 0;
+}
+
 static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
-- 
2.27.0

