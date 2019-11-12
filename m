Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4C1F8FC9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLMkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:40:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43251 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKLMkf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:40:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so17586944ljh.10
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VYIHY64Ig6hMKas5CfEIAmktuNgjbKEtyRGq8tTo16M=;
        b=aMrH3JlvfQFUbEz0UlQFVtwnt/lyMDpRuRM2OClIiWMID0mbPC7n+/hAVDdw4higmm
         QWe+1bYEU4Q2z7A2bIKdt5ZuF4o8qiYv1tkL1LP2BoDMjRk5E66nr9J4AUf04jEzmt4I
         bI6v8wAz/vgPwpZ5HUftcchHbgU4niROZW3QH4rtTi1/nUd+drXYVFJF9zTJ/lCa4shQ
         itUafgd5XCubbbFeIdukgApht9j4eqxAT/Qum3ixjnlSMCl/0mezP3nxtxYBPYuZAYLZ
         7i7/NWoMYFbLqD6RCnWWBeQGsVSdTAlcj3EFfKZM5IxmQA/ScBntUxCP95GW4878MAYb
         A7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VYIHY64Ig6hMKas5CfEIAmktuNgjbKEtyRGq8tTo16M=;
        b=HFWtQztFUo23q7isyFIocCAp0D+799tTIvXpZdDzBudcGwX95xQtImblXF+v/Ad/EI
         MoEzJLLOnjc2EC0BFbCGl78gmfb6ld54Of5YNijmE5A97jq2xDjVkY8bdMc2txmpXMxF
         S2gLeL1DhJkZisF/RefUoIt2mCQIfZIsMgOdCUOcdfOeNzpjXZc9yMdQUmExhscrO6sJ
         XoY2PfjpoyBNVo3CC0nEstGjeSQf/Ed4DIOwRjPwSllNhw4GGfGXBoL2isO4BxS/WVmw
         wE+JkncJ68YNoRj5vKiMw1aE8SdPXjo7q3223NpEcQ6Wea0HCWDo9ZK2TT1OlG4+QqLB
         08kA==
X-Gm-Message-State: APjAAAXBNKTAj4t+wvzIUI3b4tqccAC1S/qQilwlo9QdzR6p0a/YLNF+
        Zo8SB1HlAR/go+rKrlNXnxA0qQ==
X-Google-Smtp-Source: APXvYqzoUipiI2KkVe9Qz1ndQr2QucogrG5ac6Irt0iozB5VCIRCCN8QE3tN54Hxvo7ukpV1GvFZRw==
X-Received: by 2002:a2e:558:: with SMTP id 85mr20280094ljf.67.1573562432644;
        Tue, 12 Nov 2019 04:40:32 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z19sm8375096ljk.66.2019.11.12.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:40:32 -0800 (PST)
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
Subject: [PATCH v3 3/3] mmc: core: Re-work HW reset for SDIO cards
Date:   Tue, 12 Nov 2019 13:40:21 +0100
Message-Id: <20191112124021.8718-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112124021.8718-1-ulf.hansson@linaro.org>
References: <20191112124021.8718-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It have turned out that it's not a good idea to unconditionally do a power
cycle and then to re-initialize the SDIO card, as currently done through
mmc_hw_reset() -> mmc_sdio_hw_reset(). This because there may be multiple
SDIO func drivers probed, who also shares the same SDIO card.

To address these scenarios, one may be tempted to use a notification
mechanism, as to allow the core to inform each of the probed func drivers,
about an ongoing HW reset. However, supporting such an operation from the
func driver point of view, may not be entirely trivial.

Therefore, let's use a more simplistic approach to solve the problem, by
instead forcing the card to be removed and re-detected, via scheduling a
rescan-work. In this way, we can rely on existing infrastructure, as the
func driver's ->remove() and ->probe() callbacks, becomes invoked to deal
with the cleanup and the re-initialization.

This solution may be considered as rather heavy, especially if a func
driver doesn't share its card with other func drivers. To address this,
let's keep the current immediate HW reset option as well, but run it only
when there is one func driver probed for the card.

Finally, to allow the caller of mmc_hw_reset(), to understand if the reset
is being asynchronously managed from a scheduled work, it returns 1
(propagated from mmc_sdio_hw_reset()). If the HW reset is executed
successfully and synchronously it returns 0, which maintains the existing
behaviour.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c     |  5 ++---
 drivers/mmc/core/core.h     |  2 ++
 drivers/mmc/core/sdio.c     | 28 +++++++++++++++++++++++++++-
 drivers/mmc/core/sdio_bus.c |  9 ++++++++-
 include/linux/mmc/card.h    |  1 +
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6f8342702c73..abf8f5eb0a1c 100644
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
@@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
 	ret = host->bus_ops->hw_reset(host);
 	mmc_bus_put(host);
 
-	if (ret)
+	if (ret < 0)
 		pr_warn("%s: tried to HW reset card, got error %d\n",
 			mmc_hostname(host), ret);
 
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
index 26cabd53ddc5..ebb387aa5158 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1048,9 +1048,35 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 	return ret;
 }
 
+/*
+ * SDIO HW reset
+ *
+ * Returns 0 if the HW reset was executed synchronously, returns 1 if the HW
+ * reset was asynchronously scheduled, else a negative error code.
+ */
 static int mmc_sdio_hw_reset(struct mmc_host *host)
 {
-	mmc_power_cycle(host, host->card->ocr);
+	struct mmc_card *card = host->card;
+
+	/*
+	 * In case the card is shared among multiple func drivers, reset the
+	 * card through a rescan work. In this way it will be removed and
+	 * re-detected, thus all func drivers becomes informed about it.
+	 */
+	if (atomic_read(&card->sdio_funcs_probed) > 1) {
+		if (mmc_card_removed(card))
+			return 1;
+		host->rescan_entered = 0;
+		mmc_card_set_removed(card);
+		_mmc_detect_change(host, 0, false);
+		return 1;
+	}
+
+	/*
+	 * A single func driver has been probed, then let's skip the heavy
+	 * hotplug dance above and execute the reset immediately.
+	 */
+	mmc_power_cycle(host, card->ocr);
 	return mmc_sdio_reinit_card(host);
 }
 
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2963e6542958..3cc928282af7 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -138,6 +138,8 @@ static int sdio_bus_probe(struct device *dev)
 	if (ret)
 		return ret;
 
+	atomic_inc(&func->card->sdio_funcs_probed);
+
 	/* Unbound SDIO functions are always suspended.
 	 * During probe, the function is set active and the usage count
 	 * is incremented.  If the driver supports runtime PM,
@@ -153,7 +155,10 @@ static int sdio_bus_probe(struct device *dev)
 	/* Set the default block size so the driver is sure it's something
 	 * sensible. */
 	sdio_claim_host(func);
-	ret = sdio_set_block_size(func, 0);
+	if (mmc_card_removed(func->card))
+		ret = -ENOMEDIUM;
+	else
+		ret = sdio_set_block_size(func, 0);
 	sdio_release_host(func);
 	if (ret)
 		goto disable_runtimepm;
@@ -165,6 +170,7 @@ static int sdio_bus_probe(struct device *dev)
 	return 0;
 
 disable_runtimepm:
+	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
 	dev_pm_domain_detach(dev, false);
@@ -181,6 +187,7 @@ static int sdio_bus_remove(struct device *dev)
 		pm_runtime_get_sync(dev);
 
 	drv->remove(func);
+	atomic_dec(&func->card->sdio_funcs_probed);
 
 	if (func->irq_handler) {
 		pr_warn("WARNING: driver %s did not remove its interrupt handler!\n",
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9b6336ad3266..e459b38ef33c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -291,6 +291,7 @@ struct mmc_card {
 	struct sd_switch_caps	sw_caps;	/* switch (CMD6) caps */
 
 	unsigned int		sdio_funcs;	/* number of SDIO functions */
+	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
 	struct sdio_cccr	cccr;		/* common card info */
 	struct sdio_cis		cis;		/* common tuple info */
 	struct sdio_func	*sdio_func[SDIO_MAX_FUNCS]; /* SDIO functions (devices) */
-- 
2.17.1

