Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D1F11FA82
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 19:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfLOSnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 13:43:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36072 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOSnj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 13:43:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so4305319ljg.3;
        Sun, 15 Dec 2019 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LH/0zcyS2tN4td5pD8aR0i/TpwaV4FiJpG/372fyzp8=;
        b=J6iJOrGMCWuVVZsHSjxKG56ysHXvOD3mqWNDhq38TP97+e39sE5hShC0qV6eX0JE9/
         /bX2dDdIZ6q98cOw6u6ZOJzlBQPBgq65j81vgbrqyGpHGKACda+1Q6OMiqrDvCEjX+tl
         lu2Eg+GTJVM92RnyQk0FMFaVvrYVmYX/fQGMp/Mv+HlnoBBloISkJtv4xQbsutbZR9iO
         tIOK2+ZSi0boHuagmqN3BQGpcbYl78BaztV35hQZmKhwyZn8Q4HwFmoCx2ihjO8h7Ib3
         1kLorHCUBXtUEttOI4r9KG0SbdZR+4EbGIBZVnbFt5K2K6qdymV2cxikiF7BLiubiGwo
         4CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LH/0zcyS2tN4td5pD8aR0i/TpwaV4FiJpG/372fyzp8=;
        b=lh0YB+9grb9aJBu4CRWe6VONfNO5fU2nkeVExI3FMs+i5aJJ/pHO8QFBMCjZE1s7Pb
         uyMFSztXiKXBJbdztl+t8YN2WhJYRQgbuOzxlrXpCdwoOKmsF+baTBgRFIjD+KCFpoZH
         NK9zr4z8ax9aZRE+cyfbdMA8waGHEr4XWNUwY/1ARruCGhZj4VOi30x1+NDTtfVzpQSt
         BQtF0mmfuE99hEsfEiPPo9QTJ3Or4Ywwk+KcIp2E22u/l3Y1AeFX5r5WaKtgFjz4umlh
         5hOwCajp6yheDLi3BfYWjQ1q1raPzjCXmdp3CDoKN/ESYElzoOQIWGbp01ITewY8J6oZ
         Vv5w==
X-Gm-Message-State: APjAAAVp+p7CjUP2fA1vhUuNsa7gVBuNeSzuh5gvvkiXFl2ZgWEEU3Ir
        nIEw81pINev+HREyfO4wMAI=
X-Google-Smtp-Source: APXvYqxfsMaK41jJkcs7vssL2EU4WHp3FndAzOUnht3wmhFCnObcwoYSdbTmLzYwX6sWSAO6pqVKqw==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr6107941ljk.179.1576435416835;
        Sun, 15 Dec 2019 10:43:36 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id k5sm7455513lfd.86.2019.12.15.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:43:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] brcmfmac: Keep OOB wake-interrupt disabled when it shouldn't be enabled
Date:   Sun, 15 Dec 2019 21:42:24 +0300
Message-Id: <20191215184224.11827-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NVIDIA Tegra SoCs do not like when OOB wake is enabled and WiFi interface
is in DOWN state during suspend. This results in a CPU hang on programming
OOB wake-up state of the GPIO controller during of system's suspend.

The solution is trivial: don't enable wake for the OOB interrupt when it
should be disabled.

This fixes hang on Tegra20 (Acer A500) and Tegra30 (Nexus 7) devices which
are using BCM4329 and BCM4330 WiFi chips respectively.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  | 10 +++++-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.h    |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 96fd8e2bf773..b5088379b595 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -119,7 +119,7 @@ int brcmf_sdiod_intr_register(struct brcmf_sdio_dev *sdiodev)
 			brcmf_err("enable_irq_wake failed %d\n", ret);
 			return ret;
 		}
-		sdiodev->irq_wake = true;
+		disable_irq_wake(pdata->oob_irq_nr);
 
 		sdio_claim_host(sdiodev->func1);
 
@@ -178,10 +178,6 @@ void brcmf_sdiod_intr_unregister(struct brcmf_sdio_dev *sdiodev)
 		sdio_release_host(sdiodev->func1);
 
 		sdiodev->oob_irq_requested = false;
-		if (sdiodev->irq_wake) {
-			disable_irq_wake(pdata->oob_irq_nr);
-			sdiodev->irq_wake = false;
-		}
 		free_irq(pdata->oob_irq_nr, &sdiodev->func1->dev);
 		sdiodev->irq_en = false;
 		sdiodev->oob_irq_requested = false;
@@ -1167,6 +1163,10 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
 	} else {
+		if (sdiodev->wowl_enabled &&
+		    sdiodev->settings->bus.sdio.oob_irq_supported)
+			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+
 		brcmf_sdiod_freezer_off(sdiodev);
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 0bd47c119dae..163fd664780a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -178,7 +178,6 @@ struct brcmf_sdio_dev {
 	bool sd_irq_requested;
 	bool irq_en;			/* irq enable flags */
 	spinlock_t irq_en_lock;
-	bool irq_wake;			/* irq wake enable flags */
 	bool sg_support;
 	uint max_request_size;
 	ushort max_segment_count;
-- 
2.24.0

