Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FDBF5E73
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Nov 2019 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKIKbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Nov 2019 05:31:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46648 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfKIKbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Nov 2019 05:31:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so8758100ljp.13
        for <linux-wireless@vger.kernel.org>; Sat, 09 Nov 2019 02:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EPWrQqTPprKbNvtZzwl7Za5KTqnwSV8dkxRhESPvVMk=;
        b=RAqHiaQMFxA519DIisu77r0ZpVMnv8kweBZO7SMmcg6i0g742jVy3xPif0n3vdm34V
         MV009qQmF9+y1gGekHF/Qgg17CNOxjc1hkX1S3WA1m7Q62Tn0Hw6AKNQTlHUGHP/8DAO
         /MSNwgaIpWUi7noyAV0LXnTcJVxjqNQnOqvBHImU8mRLPsVz4idOT1mH96kNEgHCHWKO
         9/LTrnXqtaiepxdnDkoUWXmlUy9lZwxp8MYN+pUbaIwtLmSFLKBz74VK3sBA2WiVChDs
         rojmiTtD/l8+1XGvEfzJiOeBrDvNdUE+/zAHY59tCi7vPZlaX7Sz9/hGj+a803Y0km2X
         2W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EPWrQqTPprKbNvtZzwl7Za5KTqnwSV8dkxRhESPvVMk=;
        b=GDYVYsfwfWZCwdDLzVTZHfKHnkMFvP4auPSrQ3dIdaBV6zjwwndabW1FaHnq71RW3B
         qfLghXDKGvQlYfkXEC9qUYyYe5oNOPsD6EtfrzEKfHp2oYSRPsE96jbnGBzyAD8vnHDp
         wCqG2AspmTcKFMOMRY7nQZO+W5yNTWOLGwzKdYNrVwmeCI0DMNmHIZUSO5TJHdAKkzlj
         0CT9+pppBXOgqJRAHaeblDLs4u6gqkHfRoul72WCQTjNdcCl/zM82flfNH3g5sZCgKeG
         OeFYFHBLbZLg8HiMKXwHN9d+6XdNnQ8MlGDX/r3hLoSxX9Oa79ii7rEX1L/oMj9N8fNB
         ZfPA==
X-Gm-Message-State: APjAAAWdE04ZLUXAzBzcSoieSTV++QHMtUym9OzufEvJJmP67sai8wR+
        Aro6HprMGa7HtZII4NTzd/vwxQ==
X-Google-Smtp-Source: APXvYqxMcNlet3RO6I64yAC6SNgkkocsxLQndYEuLIb2XeUMBXV3VvlCRMZuVWKcCw1fQBAgGNAsIA==
X-Received: by 2002:a2e:2a42:: with SMTP id q63mr8791758ljq.180.1573295457543;
        Sat, 09 Nov 2019 02:30:57 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z3sm343927lji.36.2019.11.09.02.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 02:30:57 -0800 (PST)
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
Subject: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
Date:   Sat,  9 Nov 2019 11:30:44 +0100
Message-Id: <20191109103046.26445-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191109103046.26445-1-ulf.hansson@linaro.org>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
when the SDIO card is shared with another SDIO func driver. This is the
case when the Bluetooth btmrvl driver is being used in combination with
mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
point, the btmrvl driver will fail to communicate with the SDIO card.

This is a generic problem for SDIO func drivers sharing an SDIO card, which
are about to be addressed in subsequent changes to the mmc core and the
mmc_hw_reset() interface. In principle, these changes means the
mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
the SDIO card, as to indicate to the caller that the reset needed to be
scheduled asynchronously through a hotplug mechanism of the SDIO card.

Let's prepare the mwifiex driver to support the upcoming new behaviour of
mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
support the asynchronous SDIO HW reset path. This also means, we need to
allow the ->remove() callback to run, without waiting for the FW to be
loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
called when a reset has been scheduled, but waiting to be executed. In this
scenario let's simply return -EBUSY to abort the suspend process, as to
allow the reset to be completed first.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
 drivers/net/wireless/marvell/mwifiex/main.h |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index a9657ae6d782..dbdbdd6769a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -76,6 +76,7 @@ static int mwifiex_register(void *card, struct device *dev,
 	*padapter = adapter;
 	adapter->dev = dev;
 	adapter->card = card;
+	adapter->is_adapter_up = false;
 
 	/* Save interface specific operations in adapter */
 	memmove(&adapter->if_ops, if_ops, sizeof(struct mwifiex_if_ops));
@@ -631,6 +632,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 
 	mwifiex_drv_get_driver_version(adapter, fmt, sizeof(fmt) - 1);
 	mwifiex_dbg(adapter, MSG, "driver_version = %s\n", fmt);
+	adapter->is_adapter_up = true;
 	goto done;
 
 err_add_intf:
@@ -1469,6 +1471,7 @@ int mwifiex_shutdown_sw(struct mwifiex_adapter *adapter)
 	mwifiex_deauthenticate(priv, NULL);
 
 	mwifiex_uninit_sw(adapter);
+	adapter->is_adapter_up = false;
 
 	if (adapter->if_ops.down_dev)
 		adapter->if_ops.down_dev(adapter);
@@ -1730,7 +1733,8 @@ int mwifiex_remove_card(struct mwifiex_adapter *adapter)
 	if (!adapter)
 		return 0;
 
-	mwifiex_uninit_sw(adapter);
+	if (adapter->is_adapter_up)
+		mwifiex_uninit_sw(adapter);
 
 	if (adapter->irq_wakeup >= 0)
 		device_init_wakeup(adapter->dev, false);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 095837fba300..7703d2e5d2e0 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1017,6 +1017,7 @@ struct mwifiex_adapter {
 
 	/* For synchronizing FW initialization with device lifecycle. */
 	struct completion *fw_done;
+	bool is_adapter_up;
 
 	bool ext_scan;
 	u8 fw_api_ver;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 24c041dad9f6..2417c94c29c0 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (!adapter->is_adapter_up)
+		return -EBUSY;
+
 	mwifiex_enable_wake(adapter);
 
 	/* Enable the Host Sleep */
@@ -2220,22 +2223,30 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
 	struct sdio_func *func = card->func;
 	int ret;
 
+	/* Prepare the adapter for the reset. */
 	mwifiex_shutdown_sw(adapter);
+	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
+	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
 
-	/* power cycle the adapter */
+	/* Run a HW reset of the SDIO interface. */
 	sdio_claim_host(func);
-	mmc_hw_reset(func->card->host);
+	ret = mmc_hw_reset(func->card->host);
 	sdio_release_host(func);
 
-	/* Previous save_adapter won't be valid after this. We will cancel
-	 * pending work requests.
-	 */
-	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
-	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
-
-	ret = mwifiex_reinit_sw(adapter);
-	if (ret)
-		dev_err(&func->dev, "reinit failed: %d\n", ret);
+	switch (ret) {
+	case 1:
+		dev_dbg(&func->dev, "SDIO HW reset asynchronous\n");
+		complete_all(adapter->fw_done);
+		break;
+	case 0:
+		ret = mwifiex_reinit_sw(adapter);
+		if (ret)
+			dev_err(&func->dev, "reinit failed: %d\n", ret);
+		break;
+	default:
+		dev_err(&func->dev, "SDIO HW reset failed: %d\n", ret);
+		break;
+	}
 }
 
 /* This function read/write firmware */
-- 
2.17.1

