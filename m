Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC733842
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFCSiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 14:38:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42051 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfFCSiB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 14:38:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so7296712plb.9
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2019 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8wwxq9VxptsURCry2b+aTfA85f9o72dfCgQNjFbLVk=;
        b=OoHOFFjgzLmkfMx69PpDw1GCFMxg+4mC3LGY9v8drB9Wns2TR4K59tgzJJx+TIUwgM
         xgZv1h8aB3DRO5FFXODObJQkwbi6Sr2sXsXKBfZrJCH3TG+vi6Qe/3jPtb5RsIIFhYME
         LCF9vDlm1NdGoKiRNrKIL9Vh4qwj9eWNIm2Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8wwxq9VxptsURCry2b+aTfA85f9o72dfCgQNjFbLVk=;
        b=R8xq1UBlke1w/RV4E8eGeR8W5sRxu9r9hk13oDjrQs2zEnRSOam6LYKr8ko9197ag2
         Yc2F2x2ArB5z6QN5EeleuYGNhbt5wDowWD7TKfeXMP+VWO7PBcip/XnO5fH19iOoOg7s
         80FwR/mR09g6eFO/Kzt4qalg7wbdWqwPlzB9eoStjW06xkJrrBH0i0gpTnHNQprlFpgW
         8aYQyIHp5jeGg0ER/IukuR3AMC4l6SFcthGAODfviZMqMx7k2NwPlQHAaCmKyTHqykiW
         I1ERMd6TFj1vlP1RhNKtmIHIC8gGXMSegLsgVBz5ZUkxIPHxOCa1IGzJQmxk7oUBWnyY
         quXw==
X-Gm-Message-State: APjAAAXMcOyVTnNAlRjpvmAG/d3jRb87MOrPNaPrVHn9eaAbajcdZ4OU
        xRi+rzEHvlyoqERWNzoinFz5TSef0lk=
X-Google-Smtp-Source: APXvYqy0yhloB5894+QBKfjxD938Rjte+CYfFTXs3NtclcxDXGASENk362PIU8f/7EORJkc4NCJG+Q==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr32669828plb.130.1559587080394;
        Mon, 03 Jun 2019 11:38:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id t2sm14808969pfh.166.2019.06.03.11.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:37:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Douglas Anderson <dianders@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around commands expected to fail
Date:   Mon,  3 Jun 2019 11:37:40 -0700
Message-Id: <20190603183740.239031-4-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183740.239031-1-dianders@chromium.org>
References: <20190603183740.239031-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are certain cases, notably when transitioning between sleep and
active state, when Broadcom SDIO WiFi cards will produce errors on the
SDIO bus.  This is evident from the source code where you can see that
we try commands in a loop until we either get success or we've tried
too many times.  The comment in the code reinforces this by saying
"just one write attempt may fail"

Unfortunately these failures sometimes end up causing an "-EILSEQ"
back to the core which triggers a retuning of the SDIO card and that
blocks all traffic to the card until it's done.

Let's disable retuning around the commands we expect might fail.

Fixes: bd11e8bd03ca ("mmc: core: Flag re-tuning is needed on CRC errors")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 4a750838d8cd..e0cfcc078a54 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/core.h>
 #include <linux/semaphore.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
@@ -697,6 +698,7 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 		bmask = SBSDIO_FUNC1_SLEEPCSR_KSO_MASK;
 	}
 
+	mmc_expect_errors_begin(bus->sdiodev->func1->card->host);
 	do {
 		/* reliable KSO bit set/clr:
 		 * the sdiod sleep write access is synced to PMU 32khz clk
@@ -719,6 +721,7 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 				   &err);
 
 	} while (try_cnt++ < MAX_KSO_ATTEMPTS);
+	mmc_expect_errors_end(bus->sdiodev->func1->card->host);
 
 	if (try_cnt > 2)
 		brcmf_dbg(SDIO, "try_cnt=%d rd_val=0x%x err=%d\n", try_cnt,
-- 
2.22.0.rc1.311.g5d7573a151-goog

