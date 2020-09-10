Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6784F264F9C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgIJPZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgIJPFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:05:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E935C061799
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so370602wmi.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4Wm7zFdeM/PXkNGWzim4XzgHqQTMapz68tBAyod2iU=;
        b=XhvUAiTcPyQFkGpIWZwHI1zHlr55baPSQMkdq5SfjBQRf7DHDnQDCmA2/Jfpixf3yB
         ZltpY+FAT1VUZdu4L2strNyyUTYMIjqf0FZCkAZGBdIkCPsvX8Vdk5GgSaSLwPtrgbiO
         u/By95FDOTAosQAr4tDiLqJboOJvmF+SpWEiWbH6/giFEUKiN9l4FxWfIyRHk3/95mDZ
         kIwdGoU0AX09KnxNafhm+gs9lXzxBlk2klokLGlVympQZJ9vp98T3sldLMkaCMUycYB4
         5AAvlUrqR3EGYivk4ymHdeY3qUtWbbH49qlme3fzpqo/Pc1lK0csmcs9JIpH22JbUs/h
         LcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4Wm7zFdeM/PXkNGWzim4XzgHqQTMapz68tBAyod2iU=;
        b=esmTx9odLHe9h7LezO7KDjm1IUdsEyxAWmz6n7ikwkuoT855O49bBJ8scYXXZLBpdt
         fN4D36r/U68AVJBGS2WTrmuoQOFDKhI0pXCQKgCCDcyEt/OA6Pb7++TRdHDZHg7sB7b1
         QciCih0QFKogD2nu+VZei1JoEaBWJWTJZW55oeLoeBCF1nObCpbi8mDwn3NVzTjUezPv
         NBHniIInsUQDj/ZFb1QgyzHodIXuseUw3/uVrsHlSPctLbDygW+PwjGnoiyGuVh4RTel
         8C198SaNVrQcS+ugWmaZuzg3SOjJZgzQ9v39/f5BAbKi6IF4H8uzgEnTlPLTcqvE+T7v
         JJOg==
X-Gm-Message-State: AOAM530RwO+63X6U02U9X8x+bTDqNXjLkkcH+ICemCIvPBIE+W/ytDK2
        p+/PjQE6cx03Tj/kSD8iQRPnLg==
X-Google-Smtp-Source: ABdhPJx2RJti/ve4EreyzXH6NxnbtGYtLRaEEQevCzISnCuRTmIkXoBrgREJ5VDpNpe/vKvxbDsLQQ==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr444074wmk.148.1599750308810;
        Thu, 10 Sep 2020 08:05:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 4/7] wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
Date:   Thu, 10 Sep 2020 16:05:49 +0100
Message-Id: <20200910150552.2178882-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/smd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e926bbaec220..1432f310f758 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -174,6 +174,31 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 	}
 }
 
+void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
+		struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
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

