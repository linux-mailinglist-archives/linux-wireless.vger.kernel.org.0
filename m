Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF14059A6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbhIIOtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbhIIOtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 10:49:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E87CC0613CF
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 07:42:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so1588804wms.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Sep 2021 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dv1391ZJpfbE5d0G7Ee4lP1GAG4bmKBnL172I+Jvp+o=;
        b=yx1anUGKM1bVMqtRxTVz2c9uv/c5eepSPWVza6fb56AEOQKDjdbJt9ybEgWM+F6fjw
         7B1TfxSr4YlcrsZgSbEf5FLipKIgbccINxlLvbKVuznOl5UrvVIKU6GfiWT9GlG1/7oO
         uoKUDs+NKZEyiees65Qf91vm4IMImVR7zyC8UUpz8d6wg7nqINb2YmOqjxz71Lk13OFU
         D/KHz8D8Xubo4b7zYcbnr3QuUYkpLRXsQ/8Xz8+6EMAotw3Ef3l4radTl2LKRIgw2QiZ
         +DtfNZ4IuJi9vL7mFjFuDgt3+rR7OZ3QVVN3b+z/Zvs5f3GQOJyI/qwOGdGc3PCcj1rj
         AFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dv1391ZJpfbE5d0G7Ee4lP1GAG4bmKBnL172I+Jvp+o=;
        b=n+Ys6mKIx9sciWDW+hlty3Pdn36VNe9PQ6IovQvEYK0oveWFWISUxpsnikcYQG6+h5
         8IDfGZgRDr4W5ZKQXJsFZ5i+torMsdrg85i7rEARTmAuNjWAbod7M3Efujlg3dmGcwTN
         KMj6y7zcVkTg70VTfG0h5YtR9CBYJ+ekitbeXn1V9wC7aPwa//8hK4PsH3CKfrsJ19lh
         KQI+DqqrmcWIov5glELszXFqsHXOzhzfvhhKXW3O5RKfK4r2wEpL3i/S8iqOCnZCvoUG
         /YIMpwAAmvUANQ13Piu57Ls5lEum6y+/m/4Bt6VHJP3WWgpplfD6TbWZhtFuALvBCVKD
         JuBw==
X-Gm-Message-State: AOAM5336gQrftyfyT96YI04lgwKS/+vRU3dqAUNWALb3phwaDvRVW92P
        FZIjRcqY4Vb/0Eu/7vM7HvkDTQ==
X-Google-Smtp-Source: ABdhPJwkyR2b4kW0YuyrMm3U9DmfMAuRHnr1FXYsAZGo70VZP0wb0huf52hywhfQ8jJ7mdR5wl75vw==
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr3359386wmj.25.1631198556926;
        Thu, 09 Sep 2021 07:42:36 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k29sm1160712wms.24.2021.09.09.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:42:36 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 2/2] wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req to pass two's complement
Date:   Thu,  9 Sep 2021 15:44:28 +0100
Message-Id: <20210909144428.2564650-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909144428.2564650-1-bryan.odonoghue@linaro.org>
References: <20210909144428.2564650-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Qcom documents suggest passing of negative values to the dump command,
however currently we convert from string to u32 not s32, so we cannot pass
a two's complement value to the firmware in this way.

There is in fact only one parameter which takes a two's complement value
<tigger threshold> in the antenna diversity switch command.

Downstream:
iwpriv wlan0 dump 71 3 <schedule period> <trigger threshold> <hysteresis value>

Upstream:
echo "71 3 <schedule period> <trigger threshold> <hysteresis value>" > /sys/kernel/debug/ieee80211/phy0/wcn36xx/dump

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/debug.c b/drivers/net/wireless/ath/wcn36xx/debug.c
index 389b5e7129a6..6af306ae41ad 100644
--- a/drivers/net/wireless/ath/wcn36xx/debug.c
+++ b/drivers/net/wireless/ath/wcn36xx/debug.c
@@ -120,7 +120,7 @@ static ssize_t write_file_dump(struct file *file,
 		if (begin == NULL)
 			break;
 
-		if (kstrtou32(begin, 0, &arg[i]) != 0)
+		if (kstrtos32(begin, 0, &arg[i]) != 0)
 			break;
 	}
 
-- 
2.33.0

