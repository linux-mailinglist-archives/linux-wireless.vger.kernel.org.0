Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5DE1B6A79
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgDXAti (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgDXAti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D5C09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so8182928ljl.6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=la2G1HCrrxK1MLNy6dIeXCgUDsqvGwugG5O298GMJH0=;
        b=ivfmR3fxwtTtJZ7Kps8x3n0DD5etjSZuYFLSIBl+FzwgZWpQt53VX+7HgnQB6k0bXl
         qwNvpya5UywSba9PVKj3CCJmLRwujWaVjPnUgEOzKnUeljPDQnZQ5ByNYxycRTY6Tm9T
         4DPmcBlZTX/ZjssCSqolhpt3g4/nd5wov8O+a4TNPlyLU49SG23E7gQU4Ri6e9Bmb56V
         gv+DMSkBCEnDQz+ijyaJSa63YlJiliQPa8G6ZvBTo1hmpElsuFWynOy+CrTqGIYY6fyl
         j6smX9YiOtCmJHnG7tqAzXAj7TeZ+NFMoO8L5er+Hze7eVV619Jn6FAv47VZGe1vf+nY
         cvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=la2G1HCrrxK1MLNy6dIeXCgUDsqvGwugG5O298GMJH0=;
        b=g0w3669QFwjUIebHoHEPVuw8y/d4DcHsKp5VmkQyKmKWNE6wOaZG3SCmPMBZIcLj+x
         7z9cLQdsOd3DypdLlc2E8/Or1YURS2SDKqD9pLfJGOThhi8GXFTBrSk+urxcEQUZvZad
         3tZJgPpiOzQ1F9OlVbNkLzkVl8FttDJfzO9s4fp9H0kfHGZJqWA0HzPER1TWe3rRSzOy
         vSZgCE4jqzWGfjTyQU/FpFYA4S7V0/QfnqqxtQkrI9rGFmASSvtjJ/ABgGobGx4nBFBs
         FCSTmd/IHkfF9koBchm3fElthsn+i12aMwSWqoKIwU0kChwgoTTw0epTFBoRq/yZZ4MO
         q04A==
X-Gm-Message-State: AGi0PuZEuKZQQZPtlFlul55vxZvGqGhsrazxnl5bgtB1XWfasI7lYjFl
        3uwqCDXwNsvPKTzVOeplIb95IzHW
X-Google-Smtp-Source: APiQypLOQn7S7ljmLV9Rd91S7f06hsLdK2yHiRPxjwAP+WbP/PX1VlbZJwMjJWMThpjb1nzJfB8Bzg==
X-Received: by 2002:a05:651c:403:: with SMTP id 3mr3944631lja.231.1587689376268;
        Thu, 23 Apr 2020 17:49:36 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:35 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] ath9k: fix AR9002 ADC and NF calibrations
Date:   Fri, 24 Apr 2020 03:49:18 +0300
Message-Id: <20200424004923.17129-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ADC calibration is only required for a 80 MHz sampling rate (i.e. for
40 MHz channels), when the chip utilizes the pair of ADCs in interleved
mode. Calibration on a 20 MHz channel will never be completed.

Previous channel check is trying to exclude all channels where the
calibration will get stuck. It effectively blocks the calibration run
for HT20 channels, but fails to exclude 20 MHz channels without HT (e.g.
legacy mode channels).

Fix this issue by reworking the channel check to explicitly allow ADCs
gain & DC offset calibrations for HT40 channels only. Also update the
complicated comment to make it clear that these calibrations are for
multi-ADC mode only.

Stuck ADCs calibration blocks the NF calibration, what could make it
impossible to work in a noisy evironment: too big Rx attentuation,
invalid RSSI value, etc. So this change is actually more of a NF
calibration fix rather then the ADC calibration fix.

Run tested with AR9220.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_calib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_calib.c b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
index fd9db8ca99d7..14eee06744ed 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
@@ -37,9 +37,8 @@ static bool ar9002_hw_is_cal_supported(struct ath_hw *ah,
 		break;
 	case ADC_GAIN_CAL:
 	case ADC_DC_CAL:
-		/* Run ADC Gain Cal for non-CCK & non 2GHz-HT20 only */
-		if (!((IS_CHAN_2GHZ(chan) || IS_CHAN_A_FAST_CLOCK(ah, chan)) &&
-		      IS_CHAN_HT20(chan)))
+		/* Run even/odd ADCs calibrations for HT40 channels only */
+		if (IS_CHAN_HT40(chan))
 			supported = true;
 		break;
 	}
-- 
2.24.1

