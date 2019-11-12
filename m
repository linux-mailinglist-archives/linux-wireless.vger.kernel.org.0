Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8AF8FC5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 13:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfKLMkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 07:40:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36895 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKLMkd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 07:40:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so12712225lfp.4
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ua0Ewl6JuBhKFh9q7mTyegdBAFgNWUEtu2UoO7aKj0U=;
        b=iquP1sqSevDyN6H4A0gAob9E9nwT6mnSoekR+cRxTs9X53+YlmG+LaN167dDKZ5Gan
         gZoWe5j1hLDegpBYIb3CM+6rqy3xxqj1HIe/sDGSrKqgB0FOCq6hstZ6bV33oYwIBxwR
         xmk8GVvhquNb7xsF1HBK5Z86pK6yHlSwQBB3a3/J20s353hEdEoGD6h+G9dMvnnL2/bh
         T1fbssj4pvKA6CkccU034eVO8Xc6LhuswNyDGOTi75CQwgh2+eGSZCDHnGWeWzc888QV
         6G8voK5p+WOpR1Sn+04Nx+S2aMEfUgyNHIRyAXTABA4o6ahmb98wkKkXaare8o4uoHNU
         FxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ua0Ewl6JuBhKFh9q7mTyegdBAFgNWUEtu2UoO7aKj0U=;
        b=VAniMO9W8hfzmoxaqA6OYPCGFx6MoWpBv88/2htKWYoRHG8+fj0cKUhD0QtBKP1aBG
         bvTc6d5aWGu9snn3lGjlg0gsN5ydPTBwKbVdiuH7Yhtt6uZjc9wiW7iPEASYl/zCaVFR
         2KTqGsiaHt/CoClQZHj8j2KTFTN7opUjXzHbsYYL4/tWXza9eJlnqL13T9iyYpLRJHrq
         6KHkhNwyvy63wDdAu9/FvHwvAvrsRtGADhWfnFhpFxcbM46/DSzMtkQ5mghlez6Eb33E
         DtmCr3notyw0TjhAjpILAkZu19qGXwXc9tvsj+WSY1ui2IM0bTsRKQukwNW16+kiyUjs
         x4Mw==
X-Gm-Message-State: APjAAAWlEe7Omto/HPrdw+KGt1OD8L92nufzmQxwndHP13mqs+pQk3ZC
        vyKc/OqPQSxHuU3m9+q9Zitkko/pN4Q=
X-Google-Smtp-Source: APXvYqxxXzYQvwF+vKgB/yos7imzceRusxPiynjFik+jDFzy0koMp4aiZO329S7Es2YzErYJ7JFiXQ==
X-Received: by 2002:a19:22d3:: with SMTP id i202mr19032642lfi.69.1573562429941;
        Tue, 12 Nov 2019 04:40:29 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z19sm8375096ljk.66.2019.11.12.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:40:29 -0800 (PST)
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
Subject: [PATCH v3 1/3] mwifiex: Re-work support for SDIO HW reset
Date:   Tue, 12 Nov 2019 13:40:19 +0100
Message-Id: <20191112124021.8718-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112124021.8718-1-ulf.hansson@linaro.org>
References: <20191112124021.8718-1-ulf.hansson@linaro.org>
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/main.c |  5 +++-
 drivers/net/wireless/marvell/mwifiex/main.h |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index a9657ae6d782..d14e55e3c9da 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -631,6 +631,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 
 	mwifiex_drv_get_driver_version(adapter, fmt, sizeof(fmt) - 1);
 	mwifiex_dbg(adapter, MSG, "driver_version = %s\n", fmt);
+	adapter->is_up = true;
 	goto done;
 
 err_add_intf:
@@ -1469,6 +1470,7 @@ int mwifiex_shutdown_sw(struct mwifiex_adapter *adapter)
 	mwifiex_deauthenticate(priv, NULL);
 
 	mwifiex_uninit_sw(adapter);
+	adapter->is_up = false;
 
 	if (adapter->if_ops.down_dev)
 		adapter->if_ops.down_dev(adapter);
@@ -1730,7 +1732,8 @@ int mwifiex_remove_card(struct mwifiex_adapter *adapter)
 	if (!adapter)
 		return 0;
 
-	mwifiex_uninit_sw(adapter);
+	if (adapter->is_up)
+		mwifiex_uninit_sw(adapter);
 
 	if (adapter->irq_wakeup >= 0)
 		device_init_wakeup(adapter->dev, false);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 095837fba300..547ff3c578ee 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1017,6 +1017,7 @@ struct mwifiex_adapter {
 
 	/* For synchronizing FW initialization with device lifecycle. */
 	struct completion *fw_done;
+	bool is_up;
 
 	bool ext_scan;
 	u8 fw_api_ver;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 24c041dad9f6..fec38b6e86ff 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
 		return 0;
 	}
 
+	if (!adapter->is_up)
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

