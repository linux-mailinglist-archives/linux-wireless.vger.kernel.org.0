Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B7264F99
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgIJPZ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbgIJPFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:05:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B05C061796
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so7060890wrm.9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKVnCy4wmdEaKgi/x5VI6aI0MpqpfMkf4mS3vr+tRpY=;
        b=RZt1wPImechtv562sczfWCXSD198o0wSTi3foTtwCQNCxxO7J5KM49Ya0ww0l8APrc
         DFBpON3JAiQu/UqyRtDdoa2oCRI6RLoLARvnf+KtCLI5QZWaV5oXA5WsJLfJgp/w+4AX
         Z1R268xv6FE8Ej6PieBybfz+8UKC/pXXTTb9D8JWTiDevserEsn/FrlOSWoFUt2G64pi
         0FTTq9FC9sPxVQY2qzjT1Qz6mQsvFMEPHQiWYlcIKdt2nB2GrlDk136TLvVw0j7NYDPQ
         +Lowx/hmf1jv2VJhYGI7dCG1waJ/GaIHItJI2z/DcphwPIBGONtXeZimSL0NT43gpuI0
         l1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKVnCy4wmdEaKgi/x5VI6aI0MpqpfMkf4mS3vr+tRpY=;
        b=S3/fkeHaAWujuRn7y4Qmq59kCwQImqA+Eh7SQ9HQrMzfkmHJeJPJpWPYWMa9yInS5n
         z2Ep9rjR46uJQ9ME5dMzdzbwqAFfeOJQvqamMz1K8enWwbbu2Y7ng+pUvK/cEWC82bcK
         Art9cPLX23kyBPVEJAlCbygVPCYzNIK+ECzLOtYN5jgm3wJuq8gAvvOHciniE07/x9bp
         aLc5j7OQzyPmEsAjDb+pypu97x0WJctTX5vyA0EGfcYqGgTuyd09bBkDHqFTVExHQwzA
         14oSDZezOlW4ISJMfzNQ/J8hn5ai9VVUFUo0JMVyPsoVCEGJSfUNc7jEFOCk0ZAO84HB
         SY+A==
X-Gm-Message-State: AOAM531RbjaJgsSl/mnrkipziXysPFxREgqYLy6gdRKDPqfGGfD1kiCs
        SnsME6i8dH+VhmZuczJR8KBVzQ==
X-Google-Smtp-Source: ABdhPJxh8hY07XFgWJstn87GOE1ymM+W9EAZT8wucpH2/l3S2bNDAzeqNnNV8KQQ7VDMOEW/yY527Q==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr9410811wrw.223.1599750306568;
        Thu, 10 Sep 2020 08:05:06 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:06 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 2/7] wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
Date:   Thu, 10 Sep 2020 16:05:47 +0100
Message-Id: <20200910150552.2178882-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds support for setting default VHT parameters, which are
exposed by the extended version 1 STA parameter type.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index d5ca9907af86..bf584ac382cb 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -190,6 +190,24 @@ static void wcn36xx_smd_set_sta_default_ht_params(
 	sta_params->dsss_cck_mode_40mhz = 1;
 }
 
+void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
+void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		sta_params->vht_capable = 1;
+		sta_params->vht_tx_mu_beamformee_capable = 1;
+	} else {
+		sta_params->vht_capable = 0;
+		sta_params->vht_tx_mu_beamformee_capable = 0;
+	}
+
+	sta_params->vht_ldpc_enabled = 0;
+	sta_params->vht_tx_channel_width_set = 0;
+	sta_params->vht_tx_bf_enabled = 0;
+}
+
 static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
-- 
2.27.0

