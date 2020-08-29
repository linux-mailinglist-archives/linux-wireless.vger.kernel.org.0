Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B165256470
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgH2Diy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgH2Die (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33134C06123B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i7so843420wre.13
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RMYH/02M6oKiIjtt+8hGNskxoP4IIcoXrMVBUBG1Lo=;
        b=HsD/yBUEYbSEtZLLJw3SgUCr9d8/UuJi6LSbknVKix1y7/gVJD17qoniEXrxPxlnjQ
         NJ+sPqQRkF11QZ/x9YFG+1UOVibOS/ByBFPBqIovhHzEhRFRoKxjSuHVcjrGx5BZ/Vxp
         rdojZojW6laTHl9WODWrZ5ERS1jWWjX6FwjaCPHRBIVF7bTFJfi3vHhZL3JDTERu/4Jd
         ZcNygK6e5+7LtF3k+4TdOzuuQXdS6mTtyIjIa2a6/YWKr9+DqUqV+2hCmoyajF9sqt2q
         wdvadmpLl66SwGmc0kVVp6uRCbzSANiviTO9JgiCcja0wJlKtKAKg84DDsIqkGcbavgz
         EzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RMYH/02M6oKiIjtt+8hGNskxoP4IIcoXrMVBUBG1Lo=;
        b=CNkM9nehm+Q885BJDPxb2hIVDzImRwAJj0b9YUeIQdQjLOracbRAhTi7SAB257mAUP
         SO0c1T1t/zWNpnQJlwoEO3rcdowk8E1kqiAzYQBWQuWBtvc0Pc/OPRk8nSPlIkqIsAWM
         YwUErpoPfSpjkmoZWdzUbFGtN/R1DZJXWjJy722jUWGzH10hBMPjlWC+lkT0kQEQTgTs
         40lUHPsqosGL7YYt/ZAJZqJQEKamCsoHYk0fIC7ETDPfZAnEjqxJgrBi3CbkGERCLyBL
         bXSTmNUIYqNpNzubAxKnwKUTQhFvjCiityHH3D2a7fHa3itgzEG+fOVToV7DDJ6RGvW8
         +MhQ==
X-Gm-Message-State: AOAM532ijx4K0AUFVypZM90h6PeoHLkylglcPFghed/VQ1u2A3A0tbTO
        ZzbYBnOFSHjYT3+10suujeZOxQ==
X-Google-Smtp-Source: ABdhPJwD5/ZELK/FrZAqb/37zPkCtpQnbxpyy40fkMgrEBJMXib+zHhznb+eFV7bl2a/obzRdT93ew==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr1695838wrw.322.1598672312952;
        Fri, 28 Aug 2020 20:38:32 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 10/12] wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
Date:   Sat, 29 Aug 2020 04:39:06 +0100
Message-Id: <20200829033908.2167689-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds a wrapper function wcn36xx_smd_set_sta_params_v1() which
calls into wcn36xx_smd_set_sta_params() and then subsequently sets
version-1 specific parameters.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index b311b170fd36..86411f3da79d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1247,6 +1247,31 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
+static void
+wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct wcn36xx_hal_config_sta_params_v1 *sta_par)
+{
+	struct wcn36xx_sta *sta_priv = NULL;
+	struct wcn36xx_hal_config_sta_params sta_par_v0;
+
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, &sta_par_v0);
+	wcn36xx_smd_convert_sta_to_v1(wcn, &sta_par_v0, sta_par);
+
+	if (sta) {
+		sta_priv = wcn36xx_sta_to_priv(sta);
+		wcn36xx_smd_set_sta_vht_params(wcn, sta, sta_par);
+		wcn36xx_smd_set_sta_ht_ldpc_params(sta, sta_par);
+		memcpy(&sta_par->supported_rates, &sta_priv->supported_rates,
+		       sizeof(sta_par->supported_rates));
+	} else {
+		wcn36xx_set_default_rates_v1(&sta_par->supported_rates);
+		wcn36xx_smd_set_sta_default_vht_params(wcn, sta_par);
+		wcn36xx_smd_set_sta_default_ht_ldpc_params(wcn, sta_par);
+	}
+}
+
 static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_sta *sta,
 				      void *buf,
-- 
2.27.0

