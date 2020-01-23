Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E716B1474CE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 00:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgAWX3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jan 2020 18:29:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41567 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAWX3q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jan 2020 18:29:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id w62so156644pfw.8
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2020 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLJZo46tQPRXDmKRyvfvXMbLAN2h1kL3Vua+/I58BTE=;
        b=hcYWKNAo8Cy8EeRiueJAEn+mXal6m5OY6GOKQabIHmRKD6AGZLLsfjrNZKv3rt9MFc
         JTAf6Lqkvg5zu5qR+nH7g7Ou3JUx87svy/KnmRVTQRQNNl+gn/17w+2G1xdrH07eBTrF
         ey32vEsWdRNpQN0unvqosgXbFWv9VUiHd/tmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLJZo46tQPRXDmKRyvfvXMbLAN2h1kL3Vua+/I58BTE=;
        b=MAqUrNiNC7IgVaMQoKtJ+4so9F7++Kb/syM6hiO15sFycIpackr/LStZ+DsmAjPD21
         S0xXaMMGNBG+33LIxD2Eme+W4j2DrqwTE3ZXMlZs6c3r5cywgjP8ELQHXEfPTGTsQ6sy
         MPyQGp37WXPfKjFwb1DxuoIcT5f3Tg+4p420mgNyj2picjyGnBP2JImNCU4SGBngp3f3
         pEvaEWp07d/XYOSPs/MYY5/1S3jGty7gsHrwpjL3evXuYGz0q/0KWnQwO4kMoyFdjXr6
         kt9lqsO8TbS687lhlXefQ23ULO+VU9isy4XvjPR5BZ4wXEVjK/HfpfycqysSIn8liOdm
         47BQ==
X-Gm-Message-State: APjAAAXJdMlzwppj4pXM4WHRzqM+mQJtK31mNc1pQStEP/JLm8D73kdN
        vEQYEtfMqwP/PlVOTVAicsFmaA==
X-Google-Smtp-Source: APXvYqzGg6/xG/ALOXguOUyZGSJKC0EKTomJZgx4LZsRS1iAXgQ5k6JifZ8wlhHRo551vRDHtc+yCw==
X-Received: by 2002:a62:d405:: with SMTP id a5mr661947pfh.254.1579822185284;
        Thu, 23 Jan 2020 15:29:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 3sm3973649pjg.27.2020.01.23.15.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:29:44 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] ath10k: Use device_get_match_data() to simplify code
Date:   Thu, 23 Jan 2020 15:29:44 -0800
Message-Id: <20200123232944.39247-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use device_get_match_data() here to simplify the code a bit.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 19a4d053d1de..88900f0399f5 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1466,7 +1466,6 @@ MODULE_DEVICE_TABLE(of, ath10k_snoc_dt_match);
 static int ath10k_snoc_probe(struct platform_device *pdev)
 {
 	const struct ath10k_snoc_drv_priv *drv_data;
-	const struct of_device_id *of_id;
 	struct ath10k_snoc *ar_snoc;
 	struct device *dev;
 	struct ath10k *ar;
@@ -1474,14 +1473,13 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 	int ret;
 	u32 i;
 
-	of_id = of_match_device(ath10k_snoc_dt_match, &pdev->dev);
-	if (!of_id) {
+	dev = &pdev->dev;
+	drv_data = device_get_match_data(dev);
+	if (!drv_data) {
 		dev_err(&pdev->dev, "failed to find matching device tree id\n");
 		return -EINVAL;
 	}
 
-	drv_data = of_id->data;
-	dev = &pdev->dev;
 
 	ret = dma_set_mask_and_coherent(dev, drv_data->dma_mask);
 	if (ret) {
-- 
Sent by a computer, using git, on the internet

