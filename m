Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FF256488
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgH2Dj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgH2DjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17910C061232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so852629wrs.11
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBPSamWvTI8jSIxlpjkAWuODo8a6eVtbug19TSHtbA0=;
        b=fnd4teTtsXaDTK5YTab+19NYzem1hkFE+V6UKgWIUleTHs8xHmUAEvol59niuWh+qM
         ma7Y35ApH+GxlbmU96FMfZsy9aZ7rT0lWn/RnS5Z1tT+1VVfEGSRIyQRDePqSHjS4BwX
         OWJrxAOwXNEwZBLUmLLqiMZhoFqozUlcU1a6eLkrvO8hzh/C5YTZC6d9qniTT1HcZNYP
         Y45RQWVLx/XcgUGrO+J+2oj4UphCv+2ip6V10alQbkKWzWWN9Pl0fC2zAux9JSdNZYm3
         IRdv3Y2iJkc7TZyc2QGu2A4IklqdbogJjnCkmesLjCHpEw6d8FJt8NHNSnEvqP9OCFZ1
         x9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBPSamWvTI8jSIxlpjkAWuODo8a6eVtbug19TSHtbA0=;
        b=uam+s041zPvqKB+raMMe1iPVS0AaAVan14Uu49IFHCtDl1A6Bvx2F5Bll8hYrXr/UD
         N8U+RTDNfha+Br2gpg9B28jQviYTQb21MNHYZY2LoT11CH8VUjxnHIInI0WAnjSqcjLn
         rqrhXkBznqlxwe9n2PRiYb0irLStLNFA0ZbwYJVM/F9Hv2wtoFQWNoanQcJQBVOhtr+q
         1OWXZb1QBGNmndNFJun5wKe7ieh311ybYBxC6+avmoJcKtGImyrmKtgRqeyMYcu/lGt/
         m32a6L/f/Ex8jy+viVA55LhzU86tqpRMgoHfdO0skOOgbHaUrDtC6y9oI94T/N9VdqYJ
         pXsg==
X-Gm-Message-State: AOAM530FHvrtpMZY6nZba3P4Rn/4np0Qa7fXIBvJI/hlBjHHCt5JEkcb
        v1MPbbsrMG200/3XO2I1E3eJbQ==
X-Google-Smtp-Source: ABdhPJzJBpfIabQOhdlLDLHEcLxdA20U3Qx5yhWuBQXBli5EiD9ljNbaphyfzxGmwyBjG+55FA2QMw==
X-Received: by 2002:adf:9ed1:: with SMTP id b17mr1705289wrf.227.1598672358848;
        Fri, 28 Aug 2020 20:39:18 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v3sm1735083wmh.6.2020.08.28.20.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 3/4] wcn36xx: Add ability to download wcn3680 specific firmware parameters
Date:   Sat, 29 Aug 2020 04:40:01 +0100
Message-Id: <20200829034002.2167878-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829034002.2167878-1-bryan.odonoghue@linaro.org>
References: <20200829034002.2167878-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit modifies wcn36xx_smd_start() so that it can download wcn3680
specific firmware parameters if we are talking to the wcn3680. If not the
original generic firmware parameter table should continue to be used for
wcn3620 and wcn3660.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index b19c83b93cd8..3785931d3df6 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -616,6 +616,8 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	int ret;
 	int i;
 	size_t len;
+	int cfg_elements;
+	static struct wcn36xx_cfg_val *cfg_vals;
 
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_START_REQ);
@@ -628,9 +630,17 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	body = (struct wcn36xx_hal_mac_start_req_msg *)wcn->hal_buf;
 	len = body->header.len;
 
-	for (i = 0; i < ARRAY_SIZE(wcn36xx_cfg_vals); i++) {
-		ret = put_cfg_tlv_u32(wcn, &len, wcn36xx_cfg_vals[i].cfg_id,
-				      wcn36xx_cfg_vals[i].value);
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		cfg_vals = wcn3680_cfg_vals;
+		cfg_elements = ARRAY_SIZE(wcn3680_cfg_vals);
+	} else {
+		cfg_vals = wcn36xx_cfg_vals;
+		cfg_elements = ARRAY_SIZE(wcn36xx_cfg_vals);
+	}
+
+	for (i = 0; i < cfg_elements; i++) {
+		ret = put_cfg_tlv_u32(wcn, &len, cfg_vals[i].cfg_id,
+				      cfg_vals[i].value);
 		if (ret)
 			goto out;
 	}
-- 
2.27.0

