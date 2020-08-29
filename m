Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0F25646D
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH2Dit (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgH2DiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19DBC061237
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so877764wmj.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECKlC4vLs4zIz+kTN0kAbndn3GkZ3/BNt24XyoyX1hY=;
        b=MWweZxH5QAlm1G+GpzRhGqLNbmtshK4QotzqtYaGmRdy7Xn3WQ44Bexs5Z/o7bLGxb
         nZMughlCJanGGaw1hVBCodrl2MaZgIyI24w1We2s2TpeLZQSsIB7xN94d5GnP1bl1gYO
         jl3wA9iDPW0VTO508EVGCIoLg//JnexjLS41XngXe3rhl8s8+t2OfpsNI90HlnxdBzW2
         JCTesGjcwJAiF9vExbDcG2UfmpbD1cln4ZDRdUEvJ8+4xZVRV2ZJrDrFc13deyRE6yf5
         CIKL5niYEiboptRur55NqmHvYMRd6jAgcI8OtITKQGuTNkhJWUIaoIIOt/xmYcwffl4F
         7hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECKlC4vLs4zIz+kTN0kAbndn3GkZ3/BNt24XyoyX1hY=;
        b=c7o61DBCyflQhjTNhm++F49io74W4Zdj+4VICmNJ+nj26SXxPuY6D9CujwH6BHbxNN
         rr1P3B3elvv//2N4FCQdV6K6DKnVlfe4a+rBPuxzFqH4lth8XIsbB7JANzs10WEfqoXC
         zT5dC3nUw+470m8l89iMF5H1/pGJ2jJFywoXqW1dtTK13pzjpYfbnwkEv2hZHP6vG+Id
         PgpUbXspRhyGPlZ4Yz/FGCCQNjXiKTCt+RJRsPSk1b/kw7M+OmjNePnTCeyHyYdmEJJD
         g5mw7ojvR2OXX9T68OnEaGpFp2/zhDReoXeXBM9VXOHPbe+NA3AhfYj/aGngFMPllX7t
         N/RA==
X-Gm-Message-State: AOAM531SI5Y3CTXCnuA6kJOMWfOhdtUMyoGCF18vDauOcyBGdoTt9f1V
        i7FI+1zDcfeTCQVh4wTv2moi8A==
X-Google-Smtp-Source: ABdhPJzh0zO7KE8MQqjKnJjo0mZUF62AaHw3QtLKL/oKz9o7Xg660/8KUzI701TMb2P+PjSmQEV21Q==
X-Received: by 2002:a05:600c:284:: with SMTP id 4mr1505635wmk.48.1598672293409;
        Fri, 28 Aug 2020 20:38:13 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:12 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 10/10] wcn36xx: Set feature DOT11AC for wcn3680
Date:   Sat, 29 Aug 2020 04:38:46 +0100
Message-Id: <20200829033846.2167619-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order for the firmware to process extended V1 parameters with the
addtional VHT fields added we need to first enable the feature bit DOT11AC.
Once done the version number in the HAL message header will be acted upon
by the firmware.

Extended V1 parameters are a prerequisite for 802.11ac speeds since we
cannot communicate VHT parameters to the firmware absent the extended data
structures.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 9490b1bf4e05..4c30036e2e56 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2084,6 +2084,8 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FEATURE_CAPS_EXCHANGE_REQ);
 
 	set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		set_feat_caps(msg_body.feat_caps, DOT11AC);
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
-- 
2.27.0

