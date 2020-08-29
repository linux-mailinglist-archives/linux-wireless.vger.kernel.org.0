Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD53256489
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgH2Dj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgH2DjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AB3C061233
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so871528wmh.4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekFwZ3tqG/cjjafUdGzV3N2Ok6t/LpyXp5TP4+r/16o=;
        b=IqMioRpdWZULzAUKwVdGCIMzABsFMMvRg7pRXEbXMLPNMrbMlIi939TB7/720BcLJQ
         sxAmR/bwCgQkCcUZLMum5LDkWs0aqLPTiB0ynbfPp0WLVqZddgN2WXgG0Hdk/PWfybba
         I9GLeKhk8rTvi+LWhg4U1KauEMa/YNlNE+eEGpOt/OIZ86cP1gitlU11gdhOm4pIZkCL
         /wZICmXCpmWOWtxz52SHzgoBYKo4C05Z9ybB6f9xC3nAfihgbMvQaHJJhpM5xrExArQr
         KXirN3j5Pvgu8IwVl7nrBbAxF1UXVSMQxCi5mLJMQ1HkSzx3GJYYORBZMbI0QL11uxPz
         lHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekFwZ3tqG/cjjafUdGzV3N2Ok6t/LpyXp5TP4+r/16o=;
        b=M+B4iZcLaJuPsUKXSVD9zCYVdqo5NcztSsAmldhoUu/TFvoSQUaf7qbv+SVq1d/MEK
         c84NEijFV2oyRUE1AlgLbJmbSVTJIZyvVmi1zCXLiG7u1LOGve4feo6c1B+HP9edbRTR
         d7AeGz/80bYWWINDEKNJQr25GK6b7L2ExqSKsIFLTkYUKtZ5Z9K4SSsdsxH6Iswfor9M
         AAAdwcS2JuV/M6ovtciAd6DhJknQUEZN4B8e2cPGSutMiUiPg+uU4v1lnaIdLMgKKID3
         /RufZmPxThWwKelRhQ0rqYkkK2mBvW13SYnuvFD9R1VlCRwrdbFvbQYN0RRNU0rCKGOR
         fIcQ==
X-Gm-Message-State: AOAM5326YC5tXqU30+KWSMdlisxPkH5kpx1JnUqFf+V5aX7OpuvZx3xq
        x8AlrMk2McEDywr8i+DW9Uc45w==
X-Google-Smtp-Source: ABdhPJzTAQ6dzRT2n6aFGRldjLY4Z+gEXPbkXzWlihBxcPQEoA6+pabR49S3/YOh09G6+Lufq/BPoA==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr1498720wmc.22.1598672359760;
        Fri, 28 Aug 2020 20:39:19 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v3sm1735083wmh.6.2020.08.28.20.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:19 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 4/4] wcn36xx: Latch VHT specific BSS parameters to firmware
Date:   Sat, 29 Aug 2020 04:40:02 +0100
Message-Id: <20200829034002.2167878-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829034002.2167878-1-bryan.odonoghue@linaro.org>
References: <20200829034002.2167878-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit makes use of wcn36xx_smd_set_bss_vht_params() to extract VHT
parameters from the 80211_sta structure and latch appropriate bits in the
bss_params_v1 structure for transmission to the wcnss firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3785931d3df6..c9a765013719 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1691,6 +1691,8 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	bss->tx_mgmt_power = bss_v0.tx_mgmt_power;
 	bss->max_tx_power = bss_v0.max_tx_power;
 
+	wcn36xx_smd_set_bss_vht_params(vif, sta_80211, bss);
+
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
-- 
2.27.0

