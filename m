Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF65F8FC6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKLMke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:40:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35309 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKLMkd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:40:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so1647928lfl.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Sqm3/Atz5RClYiYSLOTyjJ1qxSb0WxsX/5dNJbrB0s=;
        b=eWHEtNYcLlj0zJowG+spGVziZcmbcfArOdLM+CPHG/CH2DqS6YaVumSZebVJZ7ytUa
         iVqdfbWo7Sgb3sfI3WJWTU1wg0XTt4AouNa7rXCZRahL37uFggD4mrUNZDhew0QxsYR/
         aZBR64htskemNVKTRtRK7udYfPqboxeAfjcRzkTCHDB9LSWG02Xxg3FyTnbKAUfo9Ag6
         qmVjEiegZ0CisuAXB5xkZtk6OEA/mUeVaeNoBdXw2W38wj0wLhN50O9vxOkw0chMe0QR
         GMtemx2bJabrMtr3Cj/05q5CiwH1+/WsEBhWhcIELaPiWMg41Dx/LAlteO4SWzzMz7Q1
         qPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Sqm3/Atz5RClYiYSLOTyjJ1qxSb0WxsX/5dNJbrB0s=;
        b=AZzWGv5eCvnh5b3PBKR3g6atEzQ9SKgJkaGClKnubyVGRG8LrvzchTMykHh+hEKu96
         IPV7G6KcX0gAAH5ehJA2Byj8SNg1b+GM6IlPb7LmxWKOTKaQP9c/RgmlgYZXtHpwcemN
         Yzi8F+2hiXxW8riIB+at5rhkghInnGVaxcO4MrGBdQzjCDi22HJe+B45yA8MBVCQQQZG
         KnOmziUQONfdeUyJuLH53RXPGeAtYHRR39mUzNnkiU++rPBXuSwwAcqxVMNMG1zwtDXb
         xxVOfidxpkd+XlonxNBVDXaCvZkZZho3RR1v/S5/eUc0hQWF/YyWfCazdVJlj96ADJlK
         yXjQ==
X-Gm-Message-State: APjAAAXG1/wyHRANim7uZCQP9WN8S/UhXvbWf92YbP/CnrL/lPT3SF/z
        8Tn8eHylyQD4IAObpJ6oKwVCmw==
X-Google-Smtp-Source: APXvYqwzEDPfwldBJhdBgC0pcUdsBDZ5Sg3IMXMrmP1OC5WRnUap6oE9INtgqyGc/0FBimeDtVZJ9w==
X-Received: by 2002:ac2:5395:: with SMTP id g21mr561053lfh.50.1573562431424;
        Tue, 12 Nov 2019 04:40:31 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z19sm8375096ljk.66.2019.11.12.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:40:30 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH v3 2/3] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
Date:   Tue, 12 Nov 2019 13:40:20 +0100
Message-Id: <20191112124021.8718-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112124021.8718-1-ulf.hansson@linaro.org>
References: <20191112124021.8718-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
scanning only once for non-removable cards. Therefore, it's also not
possible that we can have a corresponding card bus attached (host->bus_ops
is NULL), when we are scanning non-removable cards.

For this reason, let' drop the check for mmc_card_is_removable() as it's
redundant.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..6f8342702c73 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/*
-	 * if there is a _removable_ card registered, check whether it is
-	 * still present
-	 */
-	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
+	/* Verify a registered card to be functional, else remove it. */
+	if (host->bus_ops && !host->bus_dead)
 		host->bus_ops->detect(host);
 
 	host->detect_change = 0;
-- 
2.17.1

