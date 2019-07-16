Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F016AD03
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbfGPQmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 12:42:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbfGPQmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 12:42:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so9372928pff.9
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2019 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0ynwreDQx55Cdn2k1+KVcd1p88/D0r6svcv1QlBO3o=;
        b=irjFbOPzoCsmoIZq13YOds5hccWx9OiE071z79slMWaKwUnr0Gw8NqkCvXGuxofvkE
         b2DbVQ8khrwbZ1fgtJzGUdLN3xC5o1VqML1rE0tFczdIs5fX+WoRn0m64ZSj09uLaKp8
         W4JTJ5GuZwoocTLDXiTmbxT27wq8MYbdfM4/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0ynwreDQx55Cdn2k1+KVcd1p88/D0r6svcv1QlBO3o=;
        b=M9IqtOKUGKPxXofn6CtT6mbdvw6UHrIFh2qJhnfMmWNOjPgjCoug7p562G98p26rAG
         EUED4p2G3psh5FJoZe4Ji5ZDFLzN3OkIAaaPH7jEzJejkXRLBoLWfFbpTqAuKfWmlYhT
         pYQCL/+niuq/P+lN3ykknXaGA9lWfDK82EKtjwusXU+QIJwAuH9wzWKtBu/xeFoS1yeR
         oCqY0USZHLnoZBq5+tofjt3axzdGKqt53DFF/6Ko+BPVoIC/eyb6chBKBaTLrk3SXE7l
         ZYP1WWPkApcLOfm2cdCf7mM6TldTuJa5d8Kx/DMUhNxHm0Q2BDid7j4sRZdFEVxDQe7c
         PKFg==
X-Gm-Message-State: APjAAAXq19O5PSCLPiUg17HHAXh/0MkalH4WWGBm0yZhTD4yUGvES85v
        Jz5XNtTVcpGofqKWfMydUJAuCw==
X-Google-Smtp-Source: APXvYqxTvrAricfH4zSCJjfNseyILhC1mVPFZVt33bDXH1vSrEY0L19EpCl6w3rTFJO8Jdf66uAxVQ==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr36366127pju.110.1563295366371;
        Tue, 16 Jul 2019 09:42:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r1sm25456468pfq.100.2019.07.16.09.42.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:42:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        linux-mmc@vger.kernel.org, davem@davemloft.net,
        Xinming Hu <huxinming820@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mwifiex: Make use of the new sdio_trigger_replug() API to reset
Date:   Tue, 16 Jul 2019 09:42:09 -0700
Message-Id: <20190716164209.62320-3-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716164209.62320-1-dianders@chromium.org>
References: <20190716164209.62320-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As described in the patch ("mmc: core: Add sdio_trigger_replug()
API"), the current mwifiex_sdio_card_reset() is broken in the cases
where we're running Bluetooth on a second SDIO func on the same card
as WiFi.  The problem goes away if we just use the
sdio_trigger_replug() API call.

NOTE: Even though with this new solution there is less of a reason to
do our work from a workqueue (the unplug / plug mechanism we're using
is possible for a human to perform at any time so the stack is
supposed to handle it without it needing to be called from a special
context), we still need a workqueue because the Marvell reset function
could called from a context where sleeping is invalid and thus we
can't claim the host.  One example is Marvell's wakeup_timer_fn().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/wireless/marvell/mwifiex/sdio.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 24c041dad9f6..f77ad2615f08 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2218,14 +2218,6 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
 {
 	struct sdio_mmc_card *card = adapter->card;
 	struct sdio_func *func = card->func;
-	int ret;
-
-	mwifiex_shutdown_sw(adapter);
-
-	/* power cycle the adapter */
-	sdio_claim_host(func);
-	mmc_hw_reset(func->card->host);
-	sdio_release_host(func);
 
 	/* Previous save_adapter won't be valid after this. We will cancel
 	 * pending work requests.
@@ -2233,9 +2225,9 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
 	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
 	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
 
-	ret = mwifiex_reinit_sw(adapter);
-	if (ret)
-		dev_err(&func->dev, "reinit failed: %d\n", ret);
+	sdio_claim_host(func);
+	sdio_trigger_replug(func);
+	sdio_release_host(func);
 }
 
 /* This function read/write firmware */
-- 
2.22.0.510.g264f2c817a-goog

