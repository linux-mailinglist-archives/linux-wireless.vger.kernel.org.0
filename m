Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D297F3EE190
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 02:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbhHQAz6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 20:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhHQAzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 20:55:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F1C0612A6
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 17:55:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i28so8805182ljm.7
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cz2cdyq9bfTQbWydu62Y30PBEuomfVq7X4iE+OcyqAc=;
        b=DXOv9zywG0v5J0JH95Tt8TXDFmxZ6qUNwRVvFf1Uj2RpuzZM0XTVLTllvnNUBCs5H3
         3DzQPj2wZI5FFR1EGWl7Ywp1K4Yg0kiYXVj3OOYLfrAsJ+/BX5wxCKKwzBu6wDNYhPOB
         b1jW+JPrFTFUd+2q/QG4OfBeFr8WCXCuuiLfHKmwqvokiQH1V9qfUHnygHfFJDQu2Aif
         Klla4JwL9uV1qHozO8/8WweWpBiTBoF/QuXen8Miu0ssquD2cNiI5GJEkPjqLw6gFoNi
         XWPm1vyRP01A1mAfNnH9mQuLaimALgKU+u9BRppYw2UuwHDQ6Vu5l8Li9/pSxjsuWWu1
         Zgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cz2cdyq9bfTQbWydu62Y30PBEuomfVq7X4iE+OcyqAc=;
        b=JJxjOFHWQn0XlYp7sJejZ6GyeZHyG/DpGjGuAbbj07ol6yUgvQyxAysOAbANU06SNc
         6FhNh00MbLn/0j2aTlTMqlOl1/NsYMjqSU4r4ObLc4y6zuCSZhM5QcWHCWMLQTrqBdFB
         YHXghUb4S+ZJKDR7ap6OsNsTD+6Fmd2YaUm8I8+KV2h7Kk0NINjRmdeaxusOFgc0cL0u
         bULVjOSkP+xt7Lm9wTqw3PrGa1eNzshFxXNWzRxNI8CTmiss/XgbSdx8bnpItJghIFiA
         5B8XxQawlxekxhrZuBRhlfmm6CKMplbePGi9cHtWqwO9qZyP5jQb6MYroKaTBM+XlDFd
         BPhA==
X-Gm-Message-State: AOAM532ecdx455cgA3d5/AYGBgq+0Qof1EZ+QmFpzwgQwIjSGPsJHxMk
        lzX+3R0zrnmgydAuuYHE4RQS+Q==
X-Google-Smtp-Source: ABdhPJxjM9khOl2mTz77h1I67+yFB2G6eXp+QyBPa0lv71WVFHCclb5KEzUp1athAqLgve0EIpTp+w==
X-Received: by 2002:a2e:b8c5:: with SMTP id s5mr796868ljp.36.1629161718233;
        Mon, 16 Aug 2021 17:55:18 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z6sm40719lfb.251.2021.08.16.17.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:55:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC PATCH 06/15] Bluetooth: hci_qca: merge init paths
Date:   Tue, 17 Aug 2021 03:54:58 +0300
Message-Id: <20210817005507.1507580-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hci_qca driver has almost identical init paths. Merge them together
to remove duplication in preparation to adding power sequencer support.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 76 ++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a21cec44720a..279b802f0952 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2020,11 +2020,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
-	if (data &&
-	    (qca_is_wcn399x(data->soc_type) ||
-	    qca_is_wcn6750(data->soc_type))) {
+	if (data)
 		qcadev->btsoc_type = data->soc_type;
+	else
+		qcadev->btsoc_type = QCA_ROME;
 
+	if (data && data->num_vregs) {
 		err = qca_init_regulators(qcadev, &serdev->dev, data->vregs,
 					  data->num_vregs);
 		if (err) {
@@ -2033,48 +2034,33 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		qcadev->vregs_on = false;
+	}
 
-		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
-					       GPIOD_OUT_LOW);
-		if (!qcadev->bt_en && data->soc_type == QCA_WCN6750) {
+	qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
+			GPIOD_OUT_LOW);
+	if (!qcadev->bt_en) {
+		if (qca_is_wcn6750(data->soc_type)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
 			power_ctrl_enabled = false;
-		}
-
-		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
-					       GPIOD_IN);
-		if (!qcadev->sw_ctrl && data->soc_type == QCA_WCN6750)
-			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
-
-		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
-		if (IS_ERR(qcadev->susclk)) {
-			dev_err(&serdev->dev, "failed to acquire clk\n");
-			return PTR_ERR(qcadev->susclk);
-		}
-
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("wcn3990 serdev registration failed");
-			return err;
-		}
-	} else {
-		if (data)
-			qcadev->btsoc_type = data->soc_type;
-		else
-			qcadev->btsoc_type = QCA_ROME;
-
-		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
-					       GPIOD_OUT_LOW);
-		if (!qcadev->bt_en) {
+		} else if (!qca_is_wcn399x(data->soc_type)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
+	}
 
-		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
-		if (IS_ERR(qcadev->susclk)) {
-			dev_warn(&serdev->dev, "failed to acquire clk\n");
-			return PTR_ERR(qcadev->susclk);
-		}
+	qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
+			GPIOD_IN);
+	if (!qcadev->sw_ctrl && qca_is_wcn6750(data->soc_type))
+		dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+
+	qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
+	if (IS_ERR(qcadev->susclk)) {
+		dev_err(&serdev->dev, "failed to acquire clk\n");
+		return PTR_ERR(qcadev->susclk);
+	}
+
+	if (!qca_is_wcn399x(data->soc_type) &&
+	    !qca_is_wcn6750(data->soc_type)) {
 		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
 		if (err)
 			return err;
@@ -2082,13 +2068,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		err = clk_prepare_enable(qcadev->susclk);
 		if (err)
 			return err;
+	}
 
-		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err) {
-			BT_ERR("Rome serdev registration failed");
+	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+	if (err) {
+		BT_ERR("QCA serdev registration failed");
+
+		if (!qca_is_wcn399x(data->soc_type) &&
+		    !qca_is_wcn6750(data->soc_type))
 			clk_disable_unprepare(qcadev->susclk);
-			return err;
-		}
+
+		return err;
 	}
 
 	hdev = qcadev->serdev_hu.hdev;
-- 
2.30.2

