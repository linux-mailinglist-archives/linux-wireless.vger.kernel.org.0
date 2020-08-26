Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EC252A72
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgHZJjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgHZJe2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E206C0617BA
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so1074959wrs.11
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvbW1gaMEShMzK91x3sz003pknPcT/UGnfug8AZOG8Q=;
        b=rQ8jCjlDnJ/GRppenxBEfbplj3jYE5RBgm+J6KHql5+Pg/1QEb7cydp3GzxR9z9P9g
         kaNXpfoEQB5mmgt9LoYH3pR5GB3v+D5WgOQkOlTACzKZODywKeCgN/fCJejCa2YL7C6m
         EuyPPPWx2lYZCCpmNF7aTOVFzmzAeHKX7QvJ2WI3LXWSq6BsGHtgOeTtuZ5xByM5hJ/c
         3topIy18stYrkfvrYRGnFTk2dDQj6dcc5ZZZhodNwJTgMnEMIuH8CRCIc6Xj/Ac5XXKS
         Lys68RV/tWshmsbCXYV5FsOtleZ8NHJlJSq9L8KNLpD8Y7djV6hT/OzyXmNIfoETueSL
         ES4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvbW1gaMEShMzK91x3sz003pknPcT/UGnfug8AZOG8Q=;
        b=WwF7kUQ8rFte2VC6WIOq+yfpvPj/A48dfwwyeiJrhwnJe0KcVlgRdyxeALKQkVU2Ji
         SCx+wgQCvADnnkcTYrTO4vkF9DVG3Dt0rKQn6AutKa5im/gZ1Q8qf6mknrSFgmZZYlQ0
         2CeOtyjPF3KspM+nBN04rLOINak9hZWzHym+gZLdNuggNnXenlbA+ZtwU2OBEOs+2cTK
         GNiEU+TGHXP5ygZr3/S6vkSPaPsi1RE5CbVIWH1OcXCRUcY2rSWvhO+m7zyZNxcD4APU
         llc7+R7TaxzqESfZntFmyGI1W2qPJKBe0BVK+QIgIsw44/A+j8IRIZyPOTDtMC6CHNU5
         0e6Q==
X-Gm-Message-State: AOAM533n2YloBWd+WMzBZJoT3XXz/gDwrBbk5jSVUarltWTeY7OK8/Lb
        SpY3v52EKime5BhdBoVYI4sy8Q==
X-Google-Smtp-Source: ABdhPJz6VriS1ahmx3lVI3NC0tIR4r2FGRbzEGod+MghqZwR+s3ityu0O28GUlNxiuDvHHNPRgJq0Q==
X-Received: by 2002:adf:c64d:: with SMTP id u13mr15254648wrg.114.1598434454816;
        Wed, 26 Aug 2020 02:34:14 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 08/30] wireless: broadcom: brcmsmac: phy_cmn: Remove a unused variables 'vbat' and 'temp'
Date:   Wed, 26 Aug 2020 10:33:39 +0100
Message-Id: <20200826093401.1458456-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c:12:
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c: In function ‘wlc_phy_upd_env_txpwr_rate_limits’:
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c:1516:11: warning: variable ‘vbat’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c:1516:5: warning: variable ‘temp’ set but not used [-Wunused-but-set-variable]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c  | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index 2441714169de1..ccc621b8ed9f2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -1513,14 +1513,12 @@ static s8 wlc_phy_env_measure_temperature(struct brcms_phy *pi)
 static void wlc_phy_upd_env_txpwr_rate_limits(struct brcms_phy *pi, u32 band)
 {
 	u8 i;
-	s8 temp, vbat;
 
 	for (i = 0; i < TXP_NUM_RATES; i++)
 		pi->txpwr_env_limit[i] = BRCMS_TXPWR_MAX;
 
-	vbat = wlc_phy_env_measure_vbat(pi);
-	temp = wlc_phy_env_measure_temperature(pi);
-
+	wlc_phy_env_measure_vbat(pi);
+	wlc_phy_env_measure_temperature(pi);
 }
 
 static s8
-- 
2.25.1

