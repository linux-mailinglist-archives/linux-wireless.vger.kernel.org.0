Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C86233D11
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 04:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgGaCBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 22:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgGaCBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 22:01:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FCFC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 19:01:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so2675256wmi.3
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 19:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPTOwu7UHWpC3pZFTpj5ZOQFP25apNpGMtND+wg3zXg=;
        b=lj41+XirH/QLRS46SNN6bQxxdThnpuov9wqjQSyOqUHFSRocWesW40WoVTx2HDlVmU
         lrKWlKAjRRMtap8dGBFve/ld33JEJsZ+LNiDni5JjPFZ+qVEeYqzIKt+zjzCp85Re9UC
         oLtO7QJvNbfXn/02c36U5XFm/EcF9JQT1MydvG8jY8kA1QotnpJsHK0QJjSumOhwKCC7
         Qra4drvA8RYtCTVY6FR2Fbihc3LTJq5s8k1Ovjfjp/lG/WUmVk5B6FMcHfIrkEeR2Qbv
         St+g9zx5WL9tEmIXwRF8LeVj2LuKsPs/KrHEZG4xHFlwpUzd91oXWj+P+vR0VSqGfyev
         MQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hPTOwu7UHWpC3pZFTpj5ZOQFP25apNpGMtND+wg3zXg=;
        b=RIIXjFU30AkwlOzBXBRhs+mK0cWM/R595+rp4uv6aOBRFBsGQteemAaNA7HgZRQ9oR
         bITdNcgOGsIAR4dorfhHMB0RiB9AF9mHN6QEzVsSynwGFMWwHdjFkSdauNFy5iIEM1qD
         TPBkC641L2/ggMixaPBraa//AMgMZHDSoQ6+MUe+DTP01mUJcmPHYU+8UOtLqQ68GcoU
         E1Qk2dgiiECj8wbiyBFA84MNo3O9bKv/Zt2YOSvc8MayHC1jCht0eQBUYgUN60G2gvYh
         4fzgkuEHFX1Js2atr5y9/UNMjnBWh6GwmfSxJlq/pMk2/Kz+QgZNle4plPbTQ/Ylu4vU
         XY4A==
X-Gm-Message-State: AOAM532fpUQChnLGqgnkJ2hvKN2ZxDMxREhw44Sf4a0E8JKhhXHvYp4a
        yt6zn0BPi4QLUnT6SiSWvvna2w==
X-Google-Smtp-Source: ABdhPJw+NGhDuNzlisX8XGifRA0PGzh/BQDMf84sh2dhiAnIzDShE05LNPXybc6+038f+WGhxXhjhw==
X-Received: by 2002:a7b:c953:: with SMTP id i19mr1589422wml.103.1596160872870;
        Thu, 30 Jul 2020 19:01:12 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a10sm11566954wrx.15.2020.07.30.19.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 19:01:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, loic.poulain@linaro.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH] wcn36xx: Set sw-scan chan to 0 when not associated
Date:   Fri, 31 Jul 2020 03:01:57 +0100
Message-Id: <20200731020157.744145-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A patch in ath/pending rewrites the software scan for the wcn36xx to
accommodate multiplexing with data, link monitoring and so on.

However if a device disassociates from an AP then the last operating
channel will not be re-scanned.

After some discussion and testing on this topic

https://www.spinics.net/lists/linux-wireless/msg201242.html
https://www.spinics.net/lists/linux-wireless/msg201254.html

this patch implements a relatively simple fix. It sets the initial software
scan channel to 0 if we are not associated with an AP or to the current
operating channel if we are assciated with an AP.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index fb8978a3c11e..87fdc073c957 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -697,10 +697,14 @@ static void wcn36xx_sw_scan_start(struct ieee80211_hw *hw,
 				  const u8 *mac_addr)
 {
 	struct wcn36xx *wcn = hw->priv;
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 
 	wcn->sw_scan = true;
 	wcn->sw_scan_vif = vif;
-	wcn->sw_scan_opchannel = WCN36XX_HW_CHANNEL(wcn);
+	if (vif_priv->sta_assoc)
+		wcn->sw_scan_opchannel = WCN36XX_HW_CHANNEL(wcn);
+	else
+		wcn->sw_scan_opchannel = 0;
 }
 
 static void wcn36xx_sw_scan_complete(struct ieee80211_hw *hw,
-- 
2.27.0

