Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22D398EF
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfFGWiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 18:38:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45006 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfFGWho (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 18:37:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so1331515pll.11
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/Emr8zkD81f/RoFF2bpt9vXXmYuPgcPH/tJJB2TNkM=;
        b=oQQs34ffYiXMPOR36xOya64Dt1KgLnf9z1SV0HDmj0CMof30gz507FOLOXiwLZF9vI
         1D4A3r35LVnz+omcfO1khnEJ5B5cf2uWoH3JxkZrIVrFp+vmy6UzYUj2ueHLGx4vpf7/
         59wQukIGshja6mS/TY/bI/w1srMb5f0chSNZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/Emr8zkD81f/RoFF2bpt9vXXmYuPgcPH/tJJB2TNkM=;
        b=qgZ6LEzYW86NIEAZbXRUX4dVH6h4c2/e/X8uj8wpnN0jNL6Sm/sXgOWDQc5441xBg6
         kC3ZVd1LlawjA1OxtHm6kr53Sz8km//KvawVR9mqLUzIkE+cu0OYfGGzqB0a0jwAFx/w
         it3BnASNsr3F3gI6u/+iJaRSXr/nTceufHnA5i0arHgnhdRZU10T8SkPk1sLoaHlS0Ow
         qLljLaukCZsxxyJ2HZQYmvMVAl/JOYOYvHvKSW7d2vRVSqXwQ1cy/GteMU1qA/ae5Ftt
         TR3KPnhCeCb9M5kTkIB9O8vkmm+PcyNpLPjdkqPlD6SsATmWw7do2IKDo4wANJN2qS4v
         llRw==
X-Gm-Message-State: APjAAAVmRRsij5BMXzVSSdMIKceIQ8wGxy0/EmNl4yALd/jdet96A4YL
        XmcqVSYoCO455yS3wMXiH2tHhg==
X-Google-Smtp-Source: APXvYqyNw/yZY/ZbD9VOj7XTh2VyqbwOrp6QXWwuAPrgMHCzudlnfDTuWjve7w8tswOe88lOZPL0rQ==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr57474438plb.26.1559947064218;
        Fri, 07 Jun 2019 15:37:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j23sm4185193pgb.63.2019.06.07.15.37.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 15:37:43 -0700 (PDT)
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
        Franky Lin <franky.lin@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 3/5] brcmfmac: sdio: Disable auto-tuning around commands expected to fail
Date:   Fri,  7 Jun 2019 15:37:14 -0700
Message-Id: <20190607223716.119277-4-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190607223716.119277-1-dianders@chromium.org>
References: <20190607223716.119277-1-dianders@chromium.org>
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

Changes in v3:
- Expect errors for all of brcmf_sdio_kso_control() (Adrian).

Changes in v2: None

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 4a750838d8cd..4040aae1f9ed 100644
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
@@ -667,6 +668,8 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 
 	brcmf_dbg(TRACE, "Enter: on=%d\n", on);
 
+	mmc_expect_errors_begin(bus->sdiodev->func1->card->host);
+
 	wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
 	/* 1st KSO write goes to AOS wake up core if device is asleep  */
 	brcmf_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val, &err);
@@ -727,6 +730,8 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 	if (try_cnt > MAX_KSO_ATTEMPTS)
 		brcmf_err("max tries: rd_val=0x%x err=%d\n", rd_val, err);
 
+	mmc_expect_errors_end(bus->sdiodev->func1->card->host);
+
 	return err;
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

