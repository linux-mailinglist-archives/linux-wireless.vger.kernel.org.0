Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B94378A2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhJVOFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJVOFL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 10:05:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E5C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:02:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y132-20020a1c7d8a000000b0032ca5765d6cso281297wmc.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4Nk3Hb1HsyhZPRogPEUdNfaLZGUChQQzivfooHsEkM=;
        b=fLir7Dqk6fgYma37ewRvTVRxn6IZc1RrbPajMnaSA0kE5BeD+XRNoVolBNruhQE7vm
         EpmhKcMoOLMh/fjc7wnyX/ZRTgxOtCLKB3FNtvJAM/MJV52fmf/xCl6KTUz4glzkt7v5
         jGJmhpH+beeMHGTQjQNEQ9iSxsaM/LaOsRhaFVMTdDRbdXcdCsAyC2bqtR4BX98yFQ6g
         y8NyvC9flihxVz7yzq78MQzTqx3csoHIFfaWs4Ub6ZSBcIXrMX5XxFU+iOTmNNiGQx+c
         mRH/PC3paMGbg0Zx7gbCGOSW7rk3HuLTxPMFKgkVbZACT6GqtALv6/RNyePCDjyUT0tZ
         RA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4Nk3Hb1HsyhZPRogPEUdNfaLZGUChQQzivfooHsEkM=;
        b=xUbXpfyGx/EEW3fgSBsRcfMlBxcwF/yy+AtNEs0+E/8x2FbAzns68kAB9QsYrU5sHR
         lFcd0ibIFsKJ2AZE7Mzi4cGhy5jptvDM1tGGvci6pdqs1oAVVJrY0ZUyHUxt3u9nYgTV
         /nXFHuRq1X3P5WAn4d+/yyeVhm4l6m02Qk5TaxQeS9ouhidRhPzZiU5bX5tchYm6vXnv
         uIgABFir/a2i/LfhW7Bfn6VgI4hzxiOmhQMBfETLlUk4ZJTGRioHmceI8ugSrcVAKAam
         NWZCFAUKdvGXyxYaPJSt6dckgzrdcHS6t82gbSAV5ceK6eDhp8G9OXabij/gHINsLyKW
         Ue1A==
X-Gm-Message-State: AOAM531EYkO1wzM6TCzOWEujVN/wL9oE3XiMsHoGQ3M9KrMzHoAGhGS8
        IOggFPSzzv1sKM8RoufOQyANfw==
X-Google-Smtp-Source: ABdhPJwNySe/TdHrB59BkjqVvej9xeChcDXT+ro27RHq/6FxTlJ6gp6joPQdeosFngSEgU6+rEV2YQ==
X-Received: by 2002:a05:600c:3b99:: with SMTP id n25mr86934wms.50.1634911371435;
        Fri, 22 Oct 2021 07:02:51 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u10sm4789913wrm.34.2021.10.22.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:02:50 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 2/2] Revert "wcn36xx: Disable bmps when encryption is disabled"
Date:   Fri, 22 Oct 2021 15:04:47 +0100
Message-Id: <20211022140447.2846248-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022140447.2846248-1-bryan.odonoghue@linaro.org>
References: <20211022140447.2846248-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit c6522a5076e1a65877c51cfee313a74ef61cabf8.

Testing on tip-of-tree shows that this is working now. Revert this and
re-enable BMPS for Open APs.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 10 ----------
 drivers/net/wireless/ath/wcn36xx/pmc.c     |  5 +----
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index fbfa9947c4a5b..ad75e6faa3bae 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -630,15 +630,6 @@ static int wcn36xx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 				}
 			}
 		}
-		/* FIXME: Only enable bmps support when encryption is enabled.
-		 * For any reasons, when connected to open/no-security BSS,
-		 * the wcn36xx controller in bmps mode does not forward
-		 * 'wake-up' beacons despite AP sends DTIM with station AID.
-		 * It could be due to a firmware issue or to the way driver
-		 * configure the station.
-		 */
-		if (vif->type == NL80211_IFTYPE_STATION)
-			vif_priv->allow_bmps = true;
 		break;
 	case DISABLE_KEY:
 		if (!(IEEE80211_KEY_FLAG_PAIRWISE & key_conf->flags)) {
@@ -966,7 +957,6 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				    vif->addr,
 				    bss_conf->aid);
 			vif_priv->sta_assoc = false;
-			vif_priv->allow_bmps = false;
 			wcn36xx_smd_set_link_st(wcn,
 						bss_conf->bssid,
 						vif->addr,
diff --git a/drivers/net/wireless/ath/wcn36xx/pmc.c b/drivers/net/wireless/ath/wcn36xx/pmc.c
index 592a9416e51f9..d8119241b2fe8 100644
--- a/drivers/net/wireless/ath/wcn36xx/pmc.c
+++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
@@ -25,10 +25,7 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
 {
 	int ret = 0;
 	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
-
-	if (!vif_priv->allow_bmps)
-		return -ENOTSUPP;
-
+	/* TODO: Make sure the TX chain clean */
 	ret = wcn36xx_smd_enter_bmps(wcn, vif);
 	if (!ret) {
 		wcn36xx_dbg(WCN36XX_DBG_PMC, "Entered BMPS\n");
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 871aab7fd4e60..8111488fed7bf 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -128,7 +128,6 @@ struct wcn36xx_vif {
 	enum wcn36xx_hal_bss_type bss_type;
 
 	/* Power management */
-	bool allow_bmps;
 	enum wcn36xx_power_state pw_state;
 
 	u8 bss_index;
-- 
2.33.0

