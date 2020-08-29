Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF2256462
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgH2DiO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgH2DiH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085FC06121B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so867262wrp.8
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXKEi/HoMMsHZxH4yOeDvKa0RuCCtL95AFd9xgH5tmA=;
        b=zkoSQL7WX9g1fDWQx8gKsqkXSmOkkyl2rUtJC/8+ekwNenOYXPwZWnYqU4b6yRMmaW
         YSGzXNGuxrbGGv43NWMJkycrNayItjj1aCJtllCOepPVKC8Nkv/ur3DO57l0J2sRPCz7
         y1r7AewhrxW5X1QkS/h0hnEb9pyqa+5/DjRp7oelBHRJglhAchi7SOor7qJ86EXENH4V
         KTJR3rEusaAxO9nWENfhc23pkD6xPijqEmGSQc6KS5+pVyrqWYbwP/h14iL6R5udoJF0
         aPwBOCklO79YhsyHY5RoNrTkqjy2U71DYKvW0RAUXARt9ZePDt+sFWDXAqe1IOqDkqGE
         Pyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXKEi/HoMMsHZxH4yOeDvKa0RuCCtL95AFd9xgH5tmA=;
        b=Oq0onL2GYnCPbg6OSkOAo244QreGjf3HykF6keIhik5035Nx1/JpyJH06MNlWe7wh6
         0bDdBg1JqiTm1XRZTxY5lojn984+CP0NiyfYdbapy6cfKhcINzJ7a1KzXp94IoVj0iME
         R6+yxjbdZtRuPEIIS3kNC8MoeDHWgdAKDdHwX0EmdgAN+SuEpyQ6t0VNcMYVST5+0ooi
         ofhKNwEE8WP0ImpThgkVT3B/Frch9T1cMXlC5maH+3dZfQNU2jSudLVnu6EiUc4Ez68O
         rrXyAflNJ04luWcT/SYaWqEE5DwTx+OIw8L9DaBcryv2UYsIlwnLlT4tW6EhnMZ6xVY6
         txWA==
X-Gm-Message-State: AOAM532avbRlj1LmVYYRpokjsUOEUrmkp9RRN50WQz+n7ytCF1IZaBeQ
        fFBqpYnVVpDnB10On88X1u9Tvg==
X-Google-Smtp-Source: ABdhPJz/5+6bOGPykNIHRbS48PbvYX2D7h8eyrnMNUnWJ46MhlKIokwL/PLSkg+v3USehKVRZe9E+g==
X-Received: by 2002:adf:81e1:: with SMTP id 88mr1831849wra.57.1598672285502;
        Fri, 28 Aug 2020 20:38:05 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 02/10] wcn36xx: Hook and identify RF_IRIS_WCN3680
Date:   Sat, 29 Aug 2020 04:38:38 +0100
Message-Id: <20200829033846.2167619-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If DT indicates we are dealing with a WCN3680 mark the rf_id field as
RF_IRIS_WCN3680 allowing for further chip-specific logic.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 44b8707d3fe9..eb518bd88870 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1309,6 +1309,8 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 	if (iris_node) {
 		if (of_device_is_compatible(iris_node, "qcom,wcn3620"))
 			wcn->rf_id = RF_IRIS_WCN3620;
+		if (of_device_is_compatible(iris_node, "qcom,wcn3680"))
+			wcn->rf_id = RF_IRIS_WCN3680;
 		of_node_put(iris_node);
 	}
 
-- 
2.27.0

