Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE44236A1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 05:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhJFD5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 23:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbhJFD4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 23:56:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42964C06178C
        for <linux-wireless@vger.kernel.org>; Tue,  5 Oct 2021 20:54:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so4430424lfd.12
        for <linux-wireless@vger.kernel.org>; Tue, 05 Oct 2021 20:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLxBTtcfVl4dtJ5J9RXz2IWihrIE1icg8208P8LI768=;
        b=o7/Ze/q0htXc3MD9r6CcG3LU411fiLFkjclIYt5gxydc/GKQKyTk+c7fhvbcoYtnXY
         7/e9Y6P+WvNC7PaRnuR6Fs8f/HGSu4cm8HPQMOPF+D42Ao70Z9MCpH+fqsIDFK5zJkDR
         R6gWSvzoe/3HsUDPDcO1qFwjWV7xhaNAeaxJGZ4Ca0smcF2WjV7pCfl0Im0ofCDBFxmf
         ZqpC8OxUr+Gjxy55TUUZGalgayt6UEOiDNBvCOqr7z2uJPL94ZyCRoG6wWTIlDvMj9/F
         Fom9EcqTv3xJHX1Gutf93jM/YB4tttS/qRFlfCz1mTrwIXBMkWVUSeIxW/9VKgUMzgNQ
         ExTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLxBTtcfVl4dtJ5J9RXz2IWihrIE1icg8208P8LI768=;
        b=DV5xIRnbYiOJnris/0w8t5Fgh9eTc6rl7IxuTFKeW5OE26DImh8E2GPQy5042D5W3W
         pCQMgOoAVMlprenHlaI8UZm45x7snsqBonsUDLF/04EylVfvhqIKmDqXmfzRzncevBQ8
         N0LxdyL4lSqBcAQWHe1Rv27M6cw+cLW9laOLu7cQIpJM/O/dH63qAEanyckaeWMSThzP
         h9S+euT8Smy09L3y9ZFu/2oVXDWKbBIg6JCtjtRb192J7hUIQ4rcLqtb146Iorf1Xidq
         v3TMYUU10N9lJw+6FDWs2BwTF48NPaewM4I7cYYa+IRc2eJ8/wE6oeAAA9k2BQ1eFFkd
         SnUg==
X-Gm-Message-State: AOAM532J3NIfIDBjg0e1KhWE2oJcMqWKtzFd6eh4246AAM4ngPgRmy1R
        Ycy7U6nDE5c4Y15BcR+HZ5fwcA==
X-Google-Smtp-Source: ABdhPJy89+pMq9hJpLFoCh7hciqRs5MkSybaUyFLo80FMybatgUVnxZf/pBhBn/cocZ6nF3Qd4LzIg==
X-Received: by 2002:ac2:4c51:: with SMTP id o17mr7353777lfk.457.1633492460649;
        Tue, 05 Oct 2021 20:54:20 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:19 -0700 (PDT)
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
Subject: [PATCH v1 10/15] ath10k: add support for pwrseq sequencing
Date:   Wed,  6 Oct 2021 06:54:02 +0300
Message-Id: <20211006035407.1147909-11-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Power sequencing for Qualcomm WiFi+BT chipsets are being reworked to use
pwrseq rather than individually handling all the regulators. Add support
for pwrseq to ath10k SNOC driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 45 +++++++++++++-------------
 drivers/net/wireless/ath/ath10k/snoc.h |  4 +--
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index ea00fbb15601..8578c56982df 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/of_address.h>
 #include <linux/iommu.h>
+#include <linux/pwrseq/consumer.h>
 
 #include "ce.h"
 #include "coredump.h"
@@ -41,14 +42,6 @@ static char *const ce_name[] = {
 	"WLAN_CE_11",
 };
 
-static const char * const ath10k_regulators[] = {
-	"vdd-0.8-cx-mx",
-	"vdd-1.8-xo",
-	"vdd-1.3-rfa",
-	"vdd-3.3-ch0",
-	"vdd-3.3-ch1",
-};
-
 static const char * const ath10k_clocks[] = {
 	"cxo_ref_clk_pin", "qdss",
 };
@@ -1010,10 +1003,14 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
-	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
+	ret = pwrseq_full_power_on(ar_snoc->pwrseq);
 	if (ret)
 		return ret;
 
+	ret = regulator_enable(ar_snoc->vreg_cx_mx);
+	if (ret)
+		goto vreg_pwrseq_off;
+
 	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
 	if (ret)
 		goto vreg_off;
@@ -1021,11 +1018,14 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 	return ret;
 
 vreg_off:
-	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	regulator_disable(ar_snoc->vreg_cx_mx);
+vreg_pwrseq_off:
+	pwrseq_power_off(ar_snoc->pwrseq);
+
 	return ret;
 }
 
-static int ath10k_hw_power_off(struct ath10k *ar)
+static void ath10k_hw_power_off(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
@@ -1033,7 +1033,9 @@ static int ath10k_hw_power_off(struct ath10k *ar)
 
 	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
 
-	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	regulator_disable(ar_snoc->vreg_cx_mx);
+
+	pwrseq_power_off(ar_snoc->pwrseq);
 }
 
 static void ath10k_snoc_wlan_disable(struct ath10k *ar)
@@ -1691,20 +1693,19 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_release_resource;
 	}
 
-	ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
-	ar_snoc->vregs = devm_kcalloc(&pdev->dev, ar_snoc->num_vregs,
-				      sizeof(*ar_snoc->vregs), GFP_KERNEL);
-	if (!ar_snoc->vregs) {
-		ret = -ENOMEM;
+	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wifi");
+	if (IS_ERR(ar_snoc->pwrseq)) {
+		ret = PTR_ERR(ar_snoc->pwrseq);
+		if (ret != -EPROBE_DEFER)
+			ath10k_warn(ar, "failed to acquire pwrseq: %d\n", ret);
 		goto err_free_irq;
 	}
-	for (i = 0; i < ar_snoc->num_vregs; i++)
-		ar_snoc->vregs[i].supply = ath10k_regulators[i];
 
-	ret = devm_regulator_bulk_get(&pdev->dev, ar_snoc->num_vregs,
-				      ar_snoc->vregs);
-	if (ret < 0)
+	ar_snoc->vreg_cx_mx = devm_regulator_get(&pdev->dev, "vdd-0.8-cx-mx");
+	if (IS_ERR(ar_snoc->vreg_cx_mx)) {
+		ret = PTR_ERR(ar_snoc->vreg_cx_mx);
 		goto err_free_irq;
+	}
 
 	ar_snoc->num_clks = ARRAY_SIZE(ath10k_clocks);
 	ar_snoc->clks = devm_kcalloc(&pdev->dev, ar_snoc->num_clks,
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 5095d1893681..5188d6f6f850 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -70,10 +70,10 @@ struct ath10k_snoc {
 	struct ath10k_snoc_ce_irq ce_irqs[CE_COUNT_MAX];
 	struct ath10k_ce ce;
 	struct timer_list rx_post_retry;
-	struct regulator_bulk_data *vregs;
-	size_t num_vregs;
+	struct regulator *vreg_cx_mx;
 	struct clk_bulk_data *clks;
 	size_t num_clks;
+	struct pwrseq *pwrseq;
 	struct ath10k_qmi *qmi;
 	unsigned long flags;
 	bool xo_cal_supported;
-- 
2.33.0

