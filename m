Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1BDAEDF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437340AbfJQN57 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 09:57:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33632 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437329AbfJQN56 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 09:57:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so2702863ljd.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnxS2XcZzdmlSU7FWbs0spB90/BTPVuxJl5GN2SI/co=;
        b=LATakpY7OV1xSLKlXscaDeuX8qO2K20YfT4oZdMmUy4lt6LTHrt8mzvOSRQFx2X6F7
         YBfZ2gv+CnJFNq9l4xoiYuOdFs3HtO6jZwP7PrpwEoN/oipWcUhv0sWI9yl5jOoBZ1wB
         mYBlnkIEEUcSbWz2QyjAdanz29kpRSBdnI87Eu//eSD07Z+29lqLAbxXyDDvBMmK8I33
         VCBoxtduq36x8yIJ+AnUM6do3Ij9mUSb0XdcY0VTaJlbv9CM0ItuQCrUcprjFnxQVn9+
         9cI8DcfPTCuEGO2ZsJ8bgijSt9qwKh16MqxVvZgxoYmOdiSNHVIICpu51UjtvMrrkCus
         c7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnxS2XcZzdmlSU7FWbs0spB90/BTPVuxJl5GN2SI/co=;
        b=hmxkbu9VoGkuFqVtUCT/DMOiAvNMr3HQSKRgR8+caBwO8Cm1vZ73x43fhoLLdFHFyB
         DqI+se4qOKIvqIndTzm01sPA7BPnslHkzO9KI9NzUrqLy89erwaRX6cq/r02dW2X7p63
         TloCg5KaqB73yvmSyvs5+dC4Kt148cqfItUX+I50sT8h4VGAxXcTY0srSpIAPWzeL3V7
         FbJHuQ7SgMB97IUJiwMRym1fuMCr0Z55JE1CJ96wmFdv3dJ3yUDHv4+RgxRwjc/4qNsq
         eC0LVHJm7i70DZ3RZuc6lzGOtlEPLF9rhT6+S+Jvgn3TQFatbrgIQ5GcIMs0rhT8pnRW
         XURg==
X-Gm-Message-State: APjAAAWJ1u2uVWWWcwODYE0Stq9+9HFk05DhpdcBaEvua9AT8v5atYfr
        6XhJiDAoh+3gvABkzA5s/GVLNg==
X-Google-Smtp-Source: APXvYqw3vvsTZvTtxmCVOnu1swpXk54GoLGrxLXWlh71VuyIjZ7b3hcGeCd4vUWQTzz2BawLP8n5jw==
X-Received: by 2002:a2e:9848:: with SMTP id e8mr2699331ljj.128.1571320676674;
        Thu, 17 Oct 2019 06:57:56 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x17sm975088lji.62.2019.10.17.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 06:57:56 -0700 (PDT)
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
Subject: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
Date:   Thu, 17 Oct 2019 15:57:39 +0200
Message-Id: <20191017135739.1315-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017135739.1315-1-ulf.hansson@linaro.org>
References: <20191017135739.1315-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It have turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, via mmc_hw_reset. This because there may be
multiple SDIO funcs attached to the same SDIO card.

To solve this problem, we would need to inform each of the SDIO func in
some way when mmc_sdio_hw_reset() gets called, but that isn't an entirely
trivial operation. Therefore, let's instead take the easy way out, by
triggering a card removal and force a new rescan of the SDIO card.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |  3 +--
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/sdio.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6f8342702c73..39c4567e39d8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
 	mmc_bus_put(host);
 }
 
-static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
-				bool cd_irq)
+void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
 {
 	/*
 	 * If the device is configured as wakeup, we prevent a new sleep for
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 328c78dbee66..575ac0257af2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -70,6 +70,8 @@ void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
 
+void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
+			bool cd_irq);
 int _mmc_detect_card_removed(struct mmc_host *host);
 int mmc_detect_card_removed(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 26cabd53ddc5..5d7462c223c3 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1050,8 +1050,15 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 
 static int mmc_sdio_hw_reset(struct mmc_host *host)
 {
-	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sdio_reinit_card(host);
+	/*
+	 * We may have more multiple SDIO funcs. Rather than to inform them all,
+	 * let's trigger a removal and force a new rescan of the card.
+	 */
+	host->rescan_entered = 0;
+	mmc_card_set_removed(host->card);
+	_mmc_detect_change(host, 0, false);
+
+	return 0;
 }
 
 static int mmc_sdio_sw_reset(struct mmc_host *host)
-- 
2.17.1

