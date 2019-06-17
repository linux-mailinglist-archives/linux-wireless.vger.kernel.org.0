Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBEB48AFB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfFQR6R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 13:58:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfFQR6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 13:58:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so6080200pfg.10
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6daAnpQe6cozjuM2w5Q9ZcYevWIcs6lbDUbFi+TV60=;
        b=Vk97Y5AL/opLKskhzLbYl4lP+wZ3m8biOf8jgbmmhA1N3oDEpmKgowQpFMacThsXxY
         axRVxxGYvaMPD2ExpDi13Nrw8LIJDIfrZo4umkpyF7GDZ5g37H5+/VSh1Rmfc6PhsOAe
         NBfb2+cYL9ScL6VY5yGI7GdMmEfong8HmFMXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6daAnpQe6cozjuM2w5Q9ZcYevWIcs6lbDUbFi+TV60=;
        b=sLAdaRnyETDfiM+Vl3LQA0vw8o5ugbElxBLWdG4b0Nb0OZeWsoNRZkseCRhsyN8pY/
         sF6zwWrMr9drsNFKGKrxbURCiogOXjZjF92sxxUiSCuYqHqb0OxOr8FilMzXNP+trTw/
         UaQ991an8ung4jD6Sv/Gkw8ruBRMarGaNI/BWlhGEUWoatBy256iFJL8yiVPVi8gOEWZ
         6Zf3cwL2kSoETnbf5NvddWL/E+O35BCI0UmFkY4d4LAUPl/vgf05gkx1r3r8rhl3pLWL
         dUebMmhh8aOBbR3HsAsjro7eIHeVVql1JZGT9ZGahIksc4r0zwIYJhk1wCFmjj8AWFcE
         qUOQ==
X-Gm-Message-State: APjAAAW1EU6H3YcUog9p0RrovFKqNPkpjHL2FwKbJnss0G099cq2/4Ga
        NNtUGbk2om5mxPTYFEpdxkEdFg==
X-Google-Smtp-Source: APXvYqyFO1jgt5qCfLkMUXJT3GKthCKBFtUHJPL+pI8WRu8aMZ04C28O89NV9OfBU/kreJcyirLwYg==
X-Received: by 2002:a17:90a:32ed:: with SMTP id l100mr27029812pjb.11.1560794296346;
        Mon, 17 Jun 2019 10:58:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q1sm15145809pfn.178.2019.06.17.10.57.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 10:57:48 -0700 (PDT)
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
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v5 1/5] Revert "brcmfmac: disable command decode in sdio_aos"
Date:   Mon, 17 Jun 2019 10:56:49 -0700
Message-Id: <20190617175653.21756-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190617175653.21756-1-dianders@chromium.org>
References: <20190617175653.21756-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 29f6589140a10ece8c1d73f58043ea5b3473ab3e.

After that patch landed I find that my kernel log on
rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110

This seems to happen every time the Broadcom WiFi transitions out of
sleep mode.  Reverting the commit fixes the problem for me, so that's
what this patch does.

Note that, in general, the justification in the original commit seemed
a little weak.  It looked like someone was testing on a SD card
controller that would sometimes die if there were CRC errors on the
bus.  This used to happen back in early days of dw_mmc (the controller
on my boards), but we fixed it.  Disabling a feature on all boards
just because one SD card controller is broken seems bad.

Fixes: 29f6589140a1 ("brcmfmac: disable command decode in sdio_aos")
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Double Lo <double.lo@cypress.com>
Cc: Madhan Mohan R <madhanmohan.r@cypress.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit to land in the wireless tree.  OK to land it separately
from the rest of the series.

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- A full revert, not just a partial one (Arend).  ...with explicit Cc.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 4e15ea57d4f5..4a750838d8cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3364,11 +3364,7 @@ static int brcmf_sdio_download_firmware(struct brcmf_sdio *bus,
 
 static bool brcmf_sdio_aos_no_decode(struct brcmf_sdio *bus)
 {
-	if (bus->ci->chip == CY_CC_43012_CHIP_ID ||
-	    bus->ci->chip == CY_CC_4373_CHIP_ID ||
-	    bus->ci->chip == BRCM_CC_4339_CHIP_ID ||
-	    bus->ci->chip == BRCM_CC_4345_CHIP_ID ||
-	    bus->ci->chip == BRCM_CC_4354_CHIP_ID)
+	if (bus->ci->chip == CY_CC_43012_CHIP_ID)
 		return true;
 	else
 		return false;
-- 
2.22.0.410.gd8fdbe21b5-goog

