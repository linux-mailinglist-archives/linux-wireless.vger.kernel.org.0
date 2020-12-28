Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9904A2E67D3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633588AbgL1Q3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441820AbgL1Q2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824BC06179C
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c133so10722851wme.4
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2379O66VphKJpmO2g82hANsVKjqZJjjcsBFp5fQ4u1I=;
        b=EVKR8oMhtX0As5WNmh8JN3OWq+S7RHBuBSTyUloI/QRt+WWdJmTIiCnTgFqe22EbSK
         /BCoL3lZW99W6I9f/AJgaoveCGSHHK8RJr1bvY67hJ0oZ50/ktoK6fOpF30kgQKNPiRi
         gVwz84mYOeis8CuPen4bhTm2fVb211DfWpVJzmPmeeXQBEjAWOiOxRnuC8EwOmzPqwBJ
         3bxFuT+4007KXisS1zsILzcQzcWLmZC9H0sU1Fge2OEJwXJ8TM1EXC9DIkoHj/hHsNYB
         DNChGbM8kMMfjQ+eGUJJJFFcs2Tlrr3qde0xeVmZbu7TvdfyLWENiqZzM+ZROD6LE4Go
         garQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2379O66VphKJpmO2g82hANsVKjqZJjjcsBFp5fQ4u1I=;
        b=Zl7QN95yTorm/6iQ4bujm6lXiP1pY4cz4qS9SD2GZuIhLLmFQNgvzPpde+wth1wRxr
         zUl1p20WQypwT12aApTYvu4oiFmAkl/LwyxB7r6dleHIDDRlwunkmu5/JvARV93g4fMU
         4KcjL1MqUMAm0eEsiRfFbPEGb3tHaErkqGYY6e4IU9rZw4/i0ou/bIa7KP/aLw4oYiak
         Y9jkRvwyZqEv1EW2uDO0wzneUKkNY4JIS7aPH9uf1wS6wHa1GowPoE60ayEPIcSGrke7
         65NqGaDEWBmjjEN2I6+3DsMz5xXfnqVg7F9B5z02I9IQu2BYDqIb31VECS7Ek2oM20Xz
         eu7w==
X-Gm-Message-State: AOAM533Ff2LuGcc2ZsTksdgtuYGq4ChOPZ68hEiB7jzWGYM5G2i1xLyj
        dih5xegS308XWydjPrmTo09C3A==
X-Google-Smtp-Source: ABdhPJwfxAT34MaGNszfs1MTK8IvsPqekqhgAg+xUQgdam4xQNaddv8WmEcaQ8MaLu7VTals74oQtw==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr21392477wmk.92.1609172857943;
        Mon, 28 Dec 2020 08:27:37 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:37 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 07/13] wcn36xx: Flag WIPHY_WOWLAN_MAGIC_PKT
Date:   Mon, 28 Dec 2020 16:28:33 +0000
Message-Id: <20201228162839.369156-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set a flag to indicate magic packet wakeup support on wcn36xx.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 579bb7f4db9c..cfa2e2d20a20 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -173,7 +173,7 @@ static struct ieee80211_supported_band wcn_band_5ghz = {
 #ifdef CONFIG_PM
 
 static const struct wiphy_wowlan_support wowlan_support = {
-	.flags = WIPHY_WOWLAN_ANY
+	.flags = WIPHY_WOWLAN_ANY | WIPHY_WOWLAN_MAGIC_PKT
 };
 
 #endif
-- 
2.29.2

