Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F702630A7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgIIPgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA2C06134E
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so3425015wrn.10
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvzZFSwrpgxQ+WGjQnmFyunvxfM/MsB1Cn6EiHCvmSY=;
        b=mrzHj7PkoKxaWbAiMRcoNDlZ2GZ8PDAayUNOVzfyIYiPaWME9V0JZp/E+cb7sSCYTg
         ICEb8H5GobNU/iI88f8jZP3S60JNE8EFmAvmBDm/AuWk022IU1Z/BUlZCtd+xCyji52o
         92kOq7Oo9zF+XzYpwm0guUQZG/dJLXzWHKO7S32hmcJbu8o1V3qTcy4y6TEsojREDv/2
         jOVoJNZGmAdYC6e0BFUB97mv0g7f791yygtQh0Jte+cFmS4+AwCfyfzwm2RTV+Gq5CA0
         QhlGPfMRcgAd9+IZ+yU2iYsc/Z+eky6dToSGZ5GV3rp5uqvBX5blm7xlv1SY01sAgthv
         r0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvzZFSwrpgxQ+WGjQnmFyunvxfM/MsB1Cn6EiHCvmSY=;
        b=mBMqIf6jiypDdJvqsNfUbxZTKdPQw54G+YAslCjt869qsz8yIUEi1JBpMLRiVUB0Dh
         s0deWb3FIcTvQRPmAQU2wxJrCrvx0Zr4hVra1VZgk+wL9jOvSsq+/Yt7UlgKIo73WkGE
         W8CrEc9BY17jRsabjzi8kT5sl2z+cyiI0RcZ2Lf2hztGFBQcEdbGez7+DDThUH2fpbjM
         1XgsTegAqms8zt/swu5FrZLMPZbWbqnYfxurLo9hgjzQ8EE/tkudj6Bt8+LYRTZcWBuB
         G69a40E6ntGJqlmfN40FL5UCLsfVX0g1HUEuVb+W54+8y1C2ahqWrvrtYy7lrlpzAm8R
         9J2Q==
X-Gm-Message-State: AOAM533b4o/43RuB8FdsK7T0Sd7fUxS4uuIw4ZCJjkKBuMGV1cotfAm4
        szFxsO4FIOCbcywHaILxQmu0rw==
X-Google-Smtp-Source: ABdhPJxAMGciObmICOVeSOdwbSPqQUaKByVqgEB4dJEltXHIyVCCVVTR07el+uEDFmNEp2CZCq3DtA==
X-Received: by 2002:a05:6000:100c:: with SMTP id a12mr4731941wrx.115.1599665722734;
        Wed, 09 Sep 2020 08:35:22 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 3/7] wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
Date:   Wed,  9 Sep 2020 16:36:03 +0100
Message-Id: <20200909153607.2904822-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
References: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toggling the LDPC enabled bit is possible only via the extended V1
data-structure. This function provides a means of setting the default
depending on chip-type.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index bb31c4d4d9a8..3f57acfe11bb 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -206,6 +206,15 @@ void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
+void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		sta_params->ht_ldpc_enabled = 1;
+	else
+		sta_params->ht_ldpc_enabled = 0;
+}
+
 static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
-- 
2.27.0

