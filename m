Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A02327EC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 01:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgG2XO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jul 2020 19:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2XOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jul 2020 19:14:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915BC061794
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jul 2020 16:14:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so4129193wmi.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jul 2020 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sntpPHY2+VZ5d6bcCmwMMBCh31oWFRBbmJ2q4E5saAE=;
        b=mWIlv/GNoNJMTUafs0TSSGkdSB9ozl+knMbZGGiLcTqU421FhRN/Qy0EpPyInKYg8I
         nxjFmZJAF4Eu31gZksIa5ZcWFFjH2D4x/m1+X7+/y+WbrR/S9+6mWFdQS6ju+GulwiLl
         QfWm/Pxc0Ve31oQEPG40iOzZpKYbpmlXujnK2gk2yCP72BcUZWWVAq2qTbPvqOoUfo6s
         EUVjYX1v6wHzVIxqr5oyNi9gEmQ3ud2KUZqA+M2m0o62kK1EvD9uivYBF1IX+VhSLZHb
         uUffOJrLM/E13fCtswq+H5z3rW7n7h1uXoa8GynSo64yEIZR7j5SrCvpiKdLAvGWJr6l
         PsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sntpPHY2+VZ5d6bcCmwMMBCh31oWFRBbmJ2q4E5saAE=;
        b=bYnUrKuDrOptdEYA4VTdUHI6jVrJIiyzlKrfBYx7PQ/lBu0YEYcXcgJEZOPJx//NXm
         8mN+O230JdsFrd/ia/PN70ca+4CX3Dhdm4sRMGmQ8utigMtB7wHR92ePfg0jrSyxdaNY
         fjZYU6YCGIe92oERCKpdVB7HfBtnE3tCMJCVNU3V9tU5yPWx9pDhrai/fNxaaja/pbCq
         pz71bamKM0n4RNxQipoC/anSB0LgMmRFPMWDS8E/GatpLteS2Xa6uNbqs05PjBFSIdcC
         /GzQ6/OQbVu/yEq/i0MRMXtzlo5ZiaUEPRhhaU/SmKNjfNNgnhrQMqr6wcO3WqpM1d8b
         bniA==
X-Gm-Message-State: AOAM531xcyoVSMJ1CTkVCzJbUUzVsHWSi7AyX8mo5fBTIb9duXUlWlph
        xakgCQ+JTX8+f362hdRtDxkfSnLN7yU=
X-Google-Smtp-Source: ABdhPJwV+5Y5AmPDCdKjKuOHLOQOlAHXu9LRvvbrNOtc88DKdNZP59TPCDnbqPFHobwWO5lc9mjNbg==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr10133558wmb.47.1596064493813;
        Wed, 29 Jul 2020 16:14:53 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h11sm7738301wrb.68.2020.07.29.16.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 16:14:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, loic.poulain@linaro.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH] wcn36xx: Ensure software scans scan on operational channel
Date:   Thu, 30 Jul 2020 00:15:38 +0100
Message-Id: <20200729231538.3965043-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need to ensure that the operational channel is scanned, because if the
AP deauthenticates us for whatever reason, subsequent scans will not work.

This fixes an issue I'm seeing on wcn3680 where my AP de-authenticates my
device but on a subsequent scan of available channels the channel we were
initially connected to fails to show up. In this case I either need to
shift the AP to another channel or reboot the device.

Ensuring the operational channel is scanned means we can never get into
that situation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index fb8978a3c11e..51fed732328e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -416,17 +416,10 @@ static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
 		wcn36xx_dbg(WCN36XX_DBG_MAC, "wcn36xx_config channel switch=%d\n",
 			    ch);
 
-		if (wcn->sw_scan_opchannel == ch) {
-			/* If channel is the initial operating channel, we may
-			 * want to receive/transmit regular data packets, then
-			 * simply stop the scan session and exit PS mode.
-			 */
-			wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN,
-						wcn->sw_scan_vif, ch);
-		} else if (wcn->sw_scan) {
-			/* A scan is ongoing, do not change the operating
-			 * channel, but start a scan session on the channel.
-			 */
+		if (wcn->sw_scan) {
+			if (wcn->sw_scan_opchannel != ch)
+				wcn36xx_change_opchannel(wcn, ch);
+
 			wcn36xx_smd_init_scan(wcn, HAL_SYS_MODE_SCAN,
 					      wcn->sw_scan_vif);
 			wcn36xx_smd_start_scan(wcn, ch);
-- 
2.27.0

