Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE1F5E75
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2019 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfKIKbE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Nov 2019 05:31:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44356 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfKIKbD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Nov 2019 05:31:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so8771524ljl.11
        for <linux-wireless@vger.kernel.org>; Sat, 09 Nov 2019 02:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=43TLBzD+brgRSav+FBPD6YlPA+X6uN9U0bQoOJqUWac=;
        b=RxUww9sLiE2jv3n6iM+WDlCT7GBVNYvgjghW/cZfIc0BBUTgAYupb2eXtPWCG2FnIQ
         NOgqrlErw/xaTDL6CBD6zVKuZEa0dI4MB6ezt9XD4PlHRS0j1/m4u9QejzpdhSj79zWq
         AEpZYn+KklCAEMEgN3tzR/GCDQR26TvQBeeSSjduK/4gLIo0O0yi+sehqmU6IE0mz8yV
         Sn/kJebpVYfK4eYqtrFQfPiQjhnfZzcJ2MC/uMu7Zl6x+0HVhwxqankKVgukFKhfzzoq
         o+RdWYpgvErl2OMrNq02W+lSgkUSJ/7UdMWAFh9uDVRY222MZdw8ykib/P9lu4c/mMMv
         LeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=43TLBzD+brgRSav+FBPD6YlPA+X6uN9U0bQoOJqUWac=;
        b=WMCkiP+P3Cb3G36STlstwB/88QDq0n9PPsuhxoIWhVdmkLfb6coD97on+v9WYvF1p9
         bJ60qo+3DGcJwhn764jnoLugqDHDemxOdsIFbjVWmVuELjTED6scSJAc8dACVlq40tVT
         koOTShs/JDlaYfX9n3GgU/jJNvDmpU0ld5xuPzC9jAi8HnYiXOYp5kRkMVL2FqrAqxgv
         lwmuhkBxZnmyaxx6k+0nHhlQdfCtlqRL3oqWzGlvbkIknZoz5KQ3Pynz3rDoA2LRqCWC
         /4xY3Z1nLG13H8eyJzGEQuN+XVQzEAZc600u0XsRQ1Qb65WECCVGeR0H9zKZSIfz995T
         4RLA==
X-Gm-Message-State: APjAAAWfMOaJBk1Unz6VMIQps+kFN6yRk/0W862VJFtuI0J2N9JjyoeO
        YROKjY43W3sN/QIuNTav/D8N5w==
X-Google-Smtp-Source: APXvYqw57oSCDmLhEK/T+cTX47L5QIJWO6b9etZKfvoraSKwP/ZQ4FPlblc/SUqB0LOTdezhz3c0DA==
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr10128391lji.141.1573295460431;
        Sat, 09 Nov 2019 02:31:00 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z3sm343927lji.36.2019.11.09.02.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 02:30:59 -0800 (PST)
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
Subject: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
Date:   Sat,  9 Nov 2019 11:30:46 +0100
Message-Id: <20191109103046.26445-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191109103046.26445-1-ulf.hansson@linaro.org>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
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

