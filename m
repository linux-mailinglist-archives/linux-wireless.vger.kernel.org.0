Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C145239DA2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgHCDKu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgHCDKt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9FC061756
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so14104551wma.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sW+j/XKYMsqDf8PANCMztexlMqz8lIFr2FXWlhrblQ=;
        b=SRIYC5YPQwH5A0WChBwU4DDJiNlPaS9OqnQduz6N14oYn0aPPzSy+Ec54lMITV4WWU
         gAkF+RzJK9135qQz7Wd9o8Xu20TXdm1UxtjOKvOvD5GiqbdOAzqqh+GO9+gFoDEmbaDS
         cX/luOGJ+jmQvmfXf3Rad+66Wi7b3Gw98ryZ8wHy1/sht7OLXfodh3zVUcFtqGan5Bjt
         Y0JCUgVJN61dOuTPBMQCc9pgAmaBQjTsk5E4vXh+1d26U/Gc2rZfveANyXOw6mpw0azm
         4ldtldVqM9Lq5pHKQwhuIGeH/gCjfJwCojZ3wm6rBI2xMJc12C1Il7+w2z8CJIl29XXD
         jp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sW+j/XKYMsqDf8PANCMztexlMqz8lIFr2FXWlhrblQ=;
        b=IIYFWwprdf7EWijRjnrg0YaS+3ZQrmMSmEEeLY8A2zXWCORA12wSdMgyBnMP8fKIgE
         5m5vOSKHESIDYVP4oGHVEOEyX7g/XvueGkOORZuvaCZTuOgvoVx5t3dONOOgj3WEYmyY
         XhsA0qdud3Fhf3lyQjaWoB3z/J9qT9iWTq4lRsrJq5fZkY1nPuq9HDl14PbfbWtRMHvm
         DANx6rjrs1kKLrDWziytksP77bkmW811fPevoSeHiyP0Q1bFV6k39df80s/ZXTCVBi2f
         v2cajA19B//ulpi2XfHk42lOTt9flInV4e7Ofy+XuKmk1OroizeVh/xO2zuxiNlhCt6J
         tlLw==
X-Gm-Message-State: AOAM531zFBS5u9m8BCHIA5P9xPFup/OsW0qbTnlMYYTg7yKr1nv7tZ14
        K8cfhKSfst957pWAKjhK91r+vg==
X-Google-Smtp-Source: ABdhPJzmR81sbdPoi2CPGj0RhZkS7gJMwz5qLxF/0KsQe8emmVdAjdHWHUGIEH5+5ATiK6TrZpYpgw==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr13691413wme.70.1596424247984;
        Sun, 02 Aug 2020 20:10:47 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:47 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 01/36] wcn36xx: Add ability to identify WCN3680
Date:   Mon,  3 Aug 2020 04:10:57 +0100
Message-Id: <20200803031132.1427063-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WCN3680 has some specific behaviours that we want to capture to
distinguish it from the WCN3620 and WCN3660 respectively.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 2 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index f389cd4676e3..73ba30a4d727 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1298,6 +1298,8 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 	if (iris_node) {
 		if (of_device_is_compatible(iris_node, "qcom,wcn3620"))
 			wcn->rf_id = RF_IRIS_WCN3620;
+		if (of_device_is_compatible(iris_node, "qcom,wcn3680"))
+			wcn->rf_id = RF_IRIS_WCN3680;
 		of_node_put(iris_node);
 	}
 
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 3221fed15620..821c4ce61afd 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -92,6 +92,7 @@ enum wcn36xx_ampdu_state {
 
 #define RF_UNKNOWN	0x0000
 #define RF_IRIS_WCN3620	0x3620
+#define RF_IRIS_WCN3680	0x3680
 
 static inline void buff_to_be(u32 *buf, size_t len)
 {
-- 
2.27.0

