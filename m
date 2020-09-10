Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A4263E0F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgIJHIq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgIJHBP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 03:01:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CDC061372
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 23:55:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so5416390wrn.6
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zDMT6nbFqbhZHba3WX8w2cu4960tHUb5zkPcYbpeIM=;
        b=tL6+bIkh8G7HqBgucCbpBctHS9j+I2AJgR6G49WHHWrcfJGS1GWrRY+zOduX5bNnmp
         XwEMjo52Sr2j5+KKnUGpRdkT17kCz542Em6ZWz+F67g7UjluqnoZCLUtOIQQoUsdZ6yx
         11//MDz21fLJyAhQRayi5tFo9NdrADRlwjbuMrwLTcoN5ItXF7fox9TKwZFHHGVcxrHK
         EoCtUSwP7GVeYUAc6r0t/CpQGNqS83EmDot6qao2ORB8J1cDaolslhu2hV5s0HRSt1Te
         v/symznRHA4ChYd/6CMxuy7KsAM+MwhH7v+BSxZHCpJJcxroS12fStSuVMKNKeN4ltRW
         e28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zDMT6nbFqbhZHba3WX8w2cu4960tHUb5zkPcYbpeIM=;
        b=ocvv7IyZd7lWscgoylwHCEJ39hjAMZJzDLmubROKW04wcghmvyr4UmvQB9RDKlAau9
         iy4sbaW3BdNAc5KjxushrJlsJXSWaIqOqd0QULpbLscupFhjViwjuuHr4WmoX930ZRHs
         S2VNLa4QxpMqHDDocbyjsLsv45WWmML/KW0/gzviV8HT3+usvb9I2uMPg84Y13O2LY+Q
         NmBj2rKP28/GxEC4Jlb3gSrkp1/sbbo6uM+RpF15g6bCFFKwyIjArknhhlmagTYwALFD
         C+PtM8Sws7nnlIbBnHR0BrWltpmg4TZlSot5fKoAH6z7sTVakvKlvcehxXavbSdICkkg
         YC1Q==
X-Gm-Message-State: AOAM532t/dCIwTTAnyK9yLd4rTJ+oAu9b0HPMDHoFwdwlwIRY2Q6suJA
        qIhPQ+kT7GI8HJGlIFqXwBSSiA==
X-Google-Smtp-Source: ABdhPJyk20V9H1NNPnqtUHlIgQaIzDY7mmVMEIQUDafx1slmQBnfmIizNpGswUF/Rjdi6TlRcOLd7A==
X-Received: by 2002:a5d:43cb:: with SMTP id v11mr7886927wrr.188.1599720926684;
        Wed, 09 Sep 2020 23:55:26 -0700 (PDT)
Received: from dell.default ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id m3sm2444028wme.31.2020.09.09.23.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:55:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 29/29] brcmsmac: phy_lcn: Remove unused variable 'lcnphy_rx_iqcomp_table_rev0'
Date:   Thu, 10 Sep 2020 07:54:31 +0100
Message-Id: <20200910065431.657636-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910065431.657636-1-lee.jones@linaro.org>
References: <20200910065431.657636-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:361:25: warning: unused variable 'lcnphy_rx_iqcomp_table_rev0' [-Wunused-const-variable]
 struct lcnphy_rx_iqcomp lcnphy_rx_iqcomp_table_rev0[] = {
                         ^
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c | 55 -------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index b8193c99e8642..7071b63042cd4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -357,61 +357,6 @@ u16 rxiq_cal_rf_reg[11] = {
 	RADIO_2064_REG12A,
 };
 
-static const
-struct lcnphy_rx_iqcomp lcnphy_rx_iqcomp_table_rev0[] = {
-	{1, 0, 0},
-	{2, 0, 0},
-	{3, 0, 0},
-	{4, 0, 0},
-	{5, 0, 0},
-	{6, 0, 0},
-	{7, 0, 0},
-	{8, 0, 0},
-	{9, 0, 0},
-	{10, 0, 0},
-	{11, 0, 0},
-	{12, 0, 0},
-	{13, 0, 0},
-	{14, 0, 0},
-	{34, 0, 0},
-	{38, 0, 0},
-	{42, 0, 0},
-	{46, 0, 0},
-	{36, 0, 0},
-	{40, 0, 0},
-	{44, 0, 0},
-	{48, 0, 0},
-	{52, 0, 0},
-	{56, 0, 0},
-	{60, 0, 0},
-	{64, 0, 0},
-	{100, 0, 0},
-	{104, 0, 0},
-	{108, 0, 0},
-	{112, 0, 0},
-	{116, 0, 0},
-	{120, 0, 0},
-	{124, 0, 0},
-	{128, 0, 0},
-	{132, 0, 0},
-	{136, 0, 0},
-	{140, 0, 0},
-	{149, 0, 0},
-	{153, 0, 0},
-	{157, 0, 0},
-	{161, 0, 0},
-	{165, 0, 0},
-	{184, 0, 0},
-	{188, 0, 0},
-	{192, 0, 0},
-	{196, 0, 0},
-	{200, 0, 0},
-	{204, 0, 0},
-	{208, 0, 0},
-	{212, 0, 0},
-	{216, 0, 0},
-};
-
 static const u32 lcnphy_23bitgaincode_table[] = {
 	0x200100,
 	0x200200,
-- 
2.25.1

