Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814BB239DB3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHCDLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgHCDLI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9700DC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so14104915wma.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KouWK8WECSEN05fvf0840cgRztNjkH3BZYdSGFVlz4M=;
        b=Yh6JHZpUZHFpNMw4crydqKnCrTDn0LIZ1lQLiwLxzxqXYxfyGNVdErNj4/iayJjR+B
         I+SejTDrx05Z1bsi/qil7Y3iPnRCNVNeA/OACr+P/TsTjNJaBV1JnsUMTZWr4Kx8Anqy
         HVetXfy+ggXJs2UoFWLR0/oUlV7PfRh/nJ5s3eoMWdFzVehs0sCUzLthDJKl2VUpx0sA
         mN5uYuYR0Ki0PGBNREsSH48EYeYLqKHCX9tRSaQC2cb7WDI1QEqVqt3y/gHAm34vJ+Zh
         qAVLTkIXwpg0QvSr/6i8SonFOzr65peday6NQgHAen6QDJBZMRtpJ/MPrmNMjuGOjHY4
         cNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KouWK8WECSEN05fvf0840cgRztNjkH3BZYdSGFVlz4M=;
        b=AgMoHlH62lBDi6dk3a/u2U+wnGvPVf/NOqqC5X846MHI+RarsE1zxrwEQA316pj9Ro
         rncfLQjq9RALIf2gIMDb8NuH4IYbRUg4uzNv57C/qn/VEPBgodj+kejiige64cpK+4mp
         qUix347hQYxuvxHjiVVrBy8wngVy/YqgOvlE5/ACb+aRaQSXuz0VTL3F2FHh/xCxiSXO
         DrpgzK+I3LRvpzf2Vu1WRjtV7SeHD0LKLt5USbYf3Fgb8AkaAxVRfQliMf39l4/wK8y6
         mizZfGEr1vu+t4nAdSivmyXlV8rOlQjcSNHJ0BuDPxJb7r2wSv+ImPX4SIvBWNPKbTrM
         zF4Q==
X-Gm-Message-State: AOAM530OMIli9cKI2xJvz8UPz3Wqd/PeIu70yZQ43iGCyI1gf2/kskal
        1kEMoCwIZuzfleFEGPVw4bpKMQ==
X-Google-Smtp-Source: ABdhPJypP/oGHzV7PccfNI+wKB7lwPYiNb4zun3Qm40qcZB/XnxP9FO69L3VK6xcAiNlEqY85UV3pQ==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr667020wmb.57.1596424263363;
        Sun, 02 Aug 2020 20:11:03 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 15/36] wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
Date:   Mon,  3 Aug 2020 04:11:11 +0100
Message-Id: <20200803031132.1427063-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds support for setting VHT parameters based on the declared
VHT capability bits in the VHT capability structure.

The bit-field TX-BF is purposefully left out since wcn3680 is the only
wcn36xx that can do VHT/80211.ac and is not TX beamformer capable. TX-BF is
a dead bit.

Similarly we cannot do 160MHz so VHT Channel width set should be zero.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 88fb4b7f1356..2632ea2ad9fa 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -173,6 +173,21 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 	}
 }
 
+static void wcn36xx_smd_set_sta_vht_params(struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (sta->vht_cap.vht_supported) {
+		unsigned long caps = sta->vht_cap.cap;
+
+		sta_params->vht_capable = sta->vht_cap.vht_supported;
+		sta_params->vht_ldpc_enabled =
+			is_cap_supported(caps, IEEE80211_VHT_CAP_RXLDPC);
+		sta_params->vht_tx_mu_beamformee_capable =
+			is_cap_supported(caps, IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+		sta_params->vht_tx_channel_width_set = 0;
+	}
+}
+
 static void wcn36xx_smd_set_sta_default_ht_params(
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

