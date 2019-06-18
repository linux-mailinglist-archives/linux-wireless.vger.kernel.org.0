Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9A4A583
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfFRPfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 11:35:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38197 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfFRPfI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 11:35:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so7365ljg.5
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eio1rBJiXbAWHfP/5yZZpxExzsuzz/VQXaABMKwUz1s=;
        b=CiqtmVs1O7WUxp0c8LA8vVFi4qYer4R0mJQ/igwJV1BCqNCUcI3fnHmGOwSWK2B8DO
         3LPIA5GtovHe+mPAlWVq5UPetkOcLnPBbJIq5Jeh1H5reB9bsKo5XVhFeMF3jjMMDwRz
         TcxXSwb0sUixM+eACxy+1EYpLJcuO51RPho+zAgWk1vmY+U8mXukv09+lEwH/gZmpTRd
         2NAfdT36kfBdwVhrRcBF+OsP7iWKNGeOW/Lv40rY+/75NrUEU79o5AT5CYQ/vHpOeoWd
         sj8ARY1ChBP2ul/qBWMT0A2yRbHl+jZx9biXecU1Hp1A5uXlWqq5nznZFHH0yY+zmGks
         FB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eio1rBJiXbAWHfP/5yZZpxExzsuzz/VQXaABMKwUz1s=;
        b=D3JaXTzX+ZZ3j+lYVxGaHoMnY5LRZUMQUr03jpLPLQ3B6TOg2toOLG9F8aSlCWtcM9
         0Y3KlXLgA+c0JV8Jhw1L8j7JqELk2+R36jWo1g6MkwJ/OiLmG0P2HZddTFA9t3MaZvpw
         Q6f2L6p4MQhIN1YYLcwBmN1gut58b5FfouzA4U/R+sLu75YVJUZ6iBkjkwMQZYP+4F8v
         jnPJ6K2rRPYFZ8Me2w8V23u580zolmpiq8tgCDm0Pd64QE5ljQ3IIgxG51yBs195wOcg
         PXzluNVS6AoknlG26M6RIpL6OwXnoq3807CgYCYfBCep1OaVTrsAsjfpmct3fUGeMnYi
         HozQ==
X-Gm-Message-State: APjAAAWMU1vFpI4aE2b4RMF53DRaQFqJCCNtgI24/UvhBk5U2FUT4sI1
        +5ScaURNH/Kn2NVSDo3Zy+qUog==
X-Google-Smtp-Source: APXvYqzDLTL4QE/CEhY3P6VAQOmWh2YCo3YYWY667+/MrWCmuTWHUVHLgfW4j2uiZywQJ56lw5myFA==
X-Received: by 2002:a2e:9997:: with SMTP id w23mr30443359lji.45.1560872105883;
        Tue, 18 Jun 2019 08:35:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d15sm2203121lfq.76.2019.06.18.08.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:35:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] mmc: sdio: Don't re-initialize powered-on removable SDIO cards at resume
Date:   Tue, 18 Jun 2019 17:34:46 +0200
Message-Id: <20190618153448.27145-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618153448.27145-1-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It looks like the original idea behind always doing a re-initialization of
a removable SDIO card during system resume in mmc_sdio_resume(), is to try
to play safe to detect whether the card has been removed.

However, this seems like a really a bad idea as it will most likely screw
things up, especially when the card is expected to remain powered on during
system suspend by the SDIO func driver.

Let's fix this, simply by trusting that the detect work checks if the card
is alive and inserted, which is being scheduled at the PM_POST_SUSPEND
notification anyway.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index a9bfcae8db5b..945416c53b56 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -982,7 +982,11 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
 
-	/* Restore power if needed */
+	/*
+	 * Restore power and reinitialize the card when needed. Note that a
+	 * removable card is checked from a detect work later on in the resume
+	 * process.
+	 */
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_up(host, host->card->ocr);
 		/*
@@ -996,12 +1000,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 			pm_runtime_set_active(&host->card->dev);
 			pm_runtime_enable(&host->card->dev);
 		}
-	}
-
-	/* No need to reinitialize powered-resumed nonremovable cards */
-	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
-		err = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
-	} else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
+		err = mmc_sdio_reinit_card(host, 0);
+	} else if (mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
 	}
-- 
2.17.1

