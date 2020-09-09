Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2027B2630AA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIPh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0EC06134A
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so3477691wrr.4
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRk+Q9bEx9jVxUktPh3Y718LsTPSVLh7wgm2w67dQZg=;
        b=TcvelvCgJwMqXFAmH7XepZ7yjnv4D3CBrQijZp4eWMuzGSj/4L853SV8BCJyqnU1sn
         k2AIp8mV5GWZvv2HWN8NziCzWxVHENTB+A9ZxGMY0FWSRM8Vs2H2ST/XJ4MihCeYCsB+
         fI1wwfw1G5oa4ud+Dsg3lyzu5xiPZH6UTwgsxgZAEEs+UiBw50guYEUrDbmwRN057nSZ
         Z/VWJn4Psngsk51f7JU+vuqYqB4DRxtNloLlUFB+eRT+Xs6bC8aznWdeRnZ3jMXWhJmP
         pDN+S0CUsjyqvo5arv183dMW2eieV99JpKW7O7/M7LjTb3uHWitXk1ga8t2S+9AaCxJf
         RnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRk+Q9bEx9jVxUktPh3Y718LsTPSVLh7wgm2w67dQZg=;
        b=HJkKGBG3yHTXr4NoTc9Rop8romTj7vII7ycF46unlepZntwrs2O3PRoOrvkmeckijl
         EUXtFlPQJb2aen8clhK787KlV1eHacMwmA14UOeWsNMIhBlyjv5g0pyMdJnd4avE5pUf
         3AFS6l/uUs2WzzASdy4LwfIIQeuBzFH71vQFI8ipBfbnLrBO9lwMsMBt/BuBs6IH8FDr
         P/CvuE7VxCbiezJ/qQjA6kKNWGzkoe2aq7Q4LGJvXhenJy4JI550Rv7AqOXQoqdJi2p3
         IbmG7kd3GNZlSE/hjpAGbjRLco75XrxsVdNeBxJgfUf91qoyoQxrFSTrkOqAL6IpUwk7
         W3rQ==
X-Gm-Message-State: AOAM530jYiRqboP8pAy5K4oxFpuS2CooNZokcVPwlqgz5YfNzr9S5hFm
        d+3JanlPLOs8i+Oohv1txWa7LQ==
X-Google-Smtp-Source: ABdhPJzulFpVKf4f2RIhrdGDR+kLtYmJvPUYY+kTUhK9+Bco/C3jIUDt13whm94n+wlCHmrDkXCNnw==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr4646209wrs.27.1599665721708;
        Wed, 09 Sep 2020 08:35:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 2/7] wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
Date:   Wed,  9 Sep 2020 16:36:02 +0100
Message-Id: <20200909153607.2904822-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
References: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/smd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index d5ca9907af86..bb31c4d4d9a8 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -190,6 +190,22 @@ static void wcn36xx_smd_set_sta_default_ht_params(
 	sta_params->dsss_cck_mode_40mhz = 1;
 }
 
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

