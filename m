Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3C261A52
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgIHSep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731855AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D9C06179A
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so303567wme.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kUBjvvwl59BwNDewkzvG1ZSSZyLN3Mzs35/KuiVmWA=;
        b=mzC+qw3PBiNDtT3lcLfVPhDiSpqYDd06JZfexYQ4PrNGCgSwzhbC13oSWY9nVLojy0
         Ba6n/nRYKOMnCqCz3ivfD/WdLGM7CUiRKXQncfcN10ad8t3m9Fs5tQZl/zs+ALihrw9x
         8uVdP+JbF0Gqj4phgy9qgBo16eMN3LJ/GhM/6kVon7YJO5IXHxcaRxgfst7ji3XvtoPJ
         38vvyIopps6bW95W+4PTuzougoCQ0n+Be+vQm890Iw9vg05mtSLRzhw0v/ClbX48iC2t
         Uj4XZR9rhqocM1f397uS4SFCt+7lXh+FwY2oGxFE9Tb9bG2wCWzmIBTEvvG5mrjSjys7
         CHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kUBjvvwl59BwNDewkzvG1ZSSZyLN3Mzs35/KuiVmWA=;
        b=YmW8DsUlnHYoz9KvjyyZkL/3P6DZAmFbXaL9L3ZMaVV3MuMvL3JUxdDRnecpgmu6lz
         OKRqgKor+2piHMiKSdYxWs3pz4MsFXfVPLuXILXir9IGqnTbUsmiIQZzVJ2ULfjB9Hbz
         SLv/TCkl3whMzc5G51GFQoksppLHrqpeGCMZ25aHsvGj+rJFJ9EWX8Ho5l6anj5G4nL1
         ieu61yc1sas5IVVV0K/zdSUJQ0hMxE6KDoUm6DmqOmnrw0uak4Bv0VV3QfBk4zIJT6nq
         DjVuyDQleN0BkUSRisKS5nYszb6VfXLtTuF457l+TXtKC1iUwiwtm69z6aJWy7V4WLaM
         C+Bw==
X-Gm-Message-State: AOAM532a2F1cZa3cNO04O/44hIfZOXKRKZPfesatODOZaMBuZtT+DFat
        Ji/4opTZZT5HAe4JvYRV1iOblw==
X-Google-Smtp-Source: ABdhPJw3mMWB4C4/adZFd183ZMjr5XfxlV58gzMDvo1115bO+wcyjGoQB6w+iTokzLtEk7+4n4Tteg==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr362132wmf.109.1599589434392;
        Tue, 08 Sep 2020 11:23:54 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 4/7] wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
Date:   Tue,  8 Sep 2020 19:24:34 +0100
Message-Id: <20200908182437.2870281-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
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

