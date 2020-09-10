Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371A264F15
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgIJTeU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgIJPq4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:46:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5DC0617A2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so7050992wrw.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vs96u/qi7chpLeX5SwWqqSg+eACXy2WDHCGDCKt1xWU=;
        b=EpVdyZCt6A7xsrh45J2RD2x0lR3dYPwxd8i6XP3A+vCmpVx5iv66Upql1TH5ezlixe
         Q8pMtpLBWKf9dCtZW8xP9vrrkcYsn4kbS4r1Yf1p/XqMbh2I8zZqUa50+QRJrQd9Nqig
         emrzwZG6AkP9AkJ2P+9M3wIOtTlmf4CUFCMo/pjpy/s/L+rDgL0cueu2Ca+7HfzszvK+
         2UIideNvjNyYoQ1gff/hPYlwlA4AHDqKIg76LSOYDG3O3R1El/WozPL1C9owmBy5uWZ+
         BAqBOFcV9QIfT8K4wgqydBW4Pe7S5WidrPmsXc2LA/wpeMu73Xcw+a0yE2bYmJbOciTG
         g+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vs96u/qi7chpLeX5SwWqqSg+eACXy2WDHCGDCKt1xWU=;
        b=V/2iJrUJW3JvIknsLdKnfPgAZDtkVvgKNRuLVpGihSvvo6OLbemK2poFoA/+HipiD3
         O/scq/U6BDfiQyKIq8eKWmOz/BeQx87dJnhErOS9VAfA109R+Fzmu5nA334hfJpRslO1
         WLsqrtgKyx5DYlshrm6yPuCopqC4ddqc9kG2SfiNbANJ0Pr+YNY+7rXmEHXTitopM8Gb
         0fJ94w9e/Wo8sK8JGg6wZsPppIcdf+ASI8NL/2rDx1vIIzwyQvRAadYvt7dA+FsEOr09
         Qp1eMCPhy5EQtIaxh5l/HwdqOhZYbW3dLUpeNt4RIGybOzZUPXRqZZafTwheLEsdRBAi
         zKgw==
X-Gm-Message-State: AOAM530Bej5qkpLTrwLNiWdaNcmZ1riQ4tG+cKJuYfijuIIDJYFAUrtw
        aJqdD2Zwp8CwVRVaB4yxBdpTJA==
X-Google-Smtp-Source: ABdhPJyh+mqxzOs0kYND7lZrQHcHGnMYyUWJulh+IgHFStK7UShjCXPwAkVcfeNRZq1cMCZODFuHsw==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr9187531wru.89.1599750349431;
        Thu, 10 Sep 2020 08:05:49 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 6/7] wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
Date:   Thu, 10 Sep 2020 16:06:30 +0100
Message-Id: <20200910150631.2178970-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A previous patch added wcn36xx_smd_config_bss_v0() this patch converts the
version 0 data-path in wcn36xx_smd_config_bss() to use
wcn36xx_smd_config_bss_v0().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 57833eec16eb..5ae6a2ccfebc 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1731,9 +1731,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
 	} else {
-		PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
-
-		ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
 	}
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
-- 
2.27.0

