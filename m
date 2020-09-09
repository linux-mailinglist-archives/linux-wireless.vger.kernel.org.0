Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C32633CF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgIIRKu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A925C061360
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so2834240wmk.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kUBjvvwl59BwNDewkzvG1ZSSZyLN3Mzs35/KuiVmWA=;
        b=aQ8/qJTnIosWf8oaUZYlsVXTXol7ua5ZbHXFTI2Txf0+d87Iak0A0pgHxBuBO3wR6v
         4jSFPyDL5RG7JZ/4F3ILmdgo4J2pJtVeTUuo/np/+tYy2acon7gLX1Vczazf2bIjUUQM
         2aspNUTnkPsshWET/2uiWme4dlj4LhZOmwgXcnS9cV/lQfPw8JuLEfmz34tpRvECrOo6
         OENWY6IdANrg59qeUhih4d2HHK+VasFrft8qcO1DgexWNK+3pqtmhvnBJ2g0OaIrIp9G
         9LsZ+vVTZsmKZUBg0YBKhlAUvUjUw4jGPvSbaKHTWP36e2F/JeIIntK2ribRNG+w7oqv
         UDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kUBjvvwl59BwNDewkzvG1ZSSZyLN3Mzs35/KuiVmWA=;
        b=Qf7E5WnsAuzXffBbBUFVxzbXfUxt9NvbERt+O7ujy40fnop07DIC6EieVX/QqhMgsV
         urfv2SQ3EffkNpLmjfVn+4772ZtDt9fnpqR8HKWZbwxFwEJQ6HWRJ6Vkup1crxexdylL
         dDlNFQ6ESWLDgaVb/51ysk2lt8AqxhkeUFb7uSZHS6Gsj4f4Wnmq/yQvZdTWl4yd1GQo
         uI6kSrWPIcTA3ttH+uuriD2gr0JoQeT5BNVKE5eQQpf4w7xxw36Va+hWOZ1gMsXtwfCm
         f1DLF6ITuAzE8Fo+0dWlxH3QKFS+m7YDhnlLG2D8KoYLy4NNl2r32JW3j4yoaRgI8htu
         tEww==
X-Gm-Message-State: AOAM533OLiLPHqhrFSxoSQkmSl4WFzDaGXdU1GYjE1uhKeI1NOkMxXF6
        3BbTL/jokm4Xi8Q4Rryfd+wj6w==
X-Google-Smtp-Source: ABdhPJzL5IF+LAclLJDn2I0yWlA0AwjjUDUHHgW0afA6dlAA1r8eGoDGh04yVj+Qh15JmMEAzREjZw==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr4297084wmm.102.1599665723762;
        Wed, 09 Sep 2020 08:35:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 4/7] wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
Date:   Wed,  9 Sep 2020 16:36:04 +0100
Message-Id: <20200909153607.2904822-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
References: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds support for setting VHT parameters based on the declared
VHT capability bits in the VHT capability structure.

We cannot do 160MHz so VHT Channel width set should be zero.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3f57acfe11bb..a563a30c3a0c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -174,6 +174,28 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 	}
 }
 
+void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
+		struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (sta->vht_cap.vht_supported) {
+		unsigned long caps = sta->vht_cap.cap;
+
+		sta_params->vht_capable = sta->vht_cap.vht_supported;
+		sta_params->vht_ldpc_enabled =
+			is_cap_supported(caps, IEEE80211_VHT_CAP_RXLDPC);
+		if (get_feat_caps(wcn->fw_feat_caps, MU_MIMO)) {
+			sta_params->vht_tx_mu_beamformee_capable =
+				is_cap_supported(caps, IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
+			if (sta_params->vht_tx_mu_beamformee_capable)
+			       sta_params->vht_tx_bf_enabled = 1;
+		} else {
+			sta_params->vht_tx_mu_beamformee_capable = 0;
+		}
+		sta_params->vht_tx_channel_width_set = 0;
+	}
+}
+
 static void wcn36xx_smd_set_sta_default_ht_params(
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

