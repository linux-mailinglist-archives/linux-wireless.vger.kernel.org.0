Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D118C25646F
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgH2Diu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgH2Dib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8AC061236
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so870802wmh.4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmR05A4AK9OYzFaj9nhkuPpkc17LEC7HRemOYw1ipAM=;
        b=chkDDSvXyNhrlh1LTOIS4kjVq/z8+YDiHm+mGi0xHbX5Z+p6tVgWEP76vX1T+YdJ7Y
         fn8BNI1hq98BdC9JnWYMcn00sLk5aNJ3WtcqSw4D3ofaHeekkXR5iqGFEQOxZ4pKjCBC
         MVNMOc0YCji8md2v0Od7Sw10neR8GBdE9MLHREjWbneYZFZz/xjP87acfiV+wp8hI7SI
         g+Sr7RYwwG0q0Tof6LiBcOFh5w3IK2g1ehk1cxPfI7UqPia5jGHa7p01rq41dsZ4QnFu
         VRDki7nJdYuSyL6PP7TTG7iYSAmKuCnSAzpyrDoVLSdjgYun49PkH2uNmA/SasSgsyDw
         ihHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmR05A4AK9OYzFaj9nhkuPpkc17LEC7HRemOYw1ipAM=;
        b=ifQJOK3I0cuxBKC0nST+SmpJTNZJOD0asIBWxFO0+3GgXk7fNM45VONrPZJA8C+Vzy
         2zBq0Jfh93bE+7myTb+Jm5hmT2jxFGUPTR9MuGeRasGvFhF8PR83p/3E9Ry2Z9v+8yYh
         t3V/wtYP7REm5SSZlE3IA/Dvhx45B0EWxauC9Inom2OJLVN7f62avq8AXRgoFX3/Gz/8
         Og+yj3yORwzulI+Tj2XQUVd59oy/qdgtOFAT2Wrg1nMK7FPTM6MxKRQgFOltQTG8SFSH
         pM7R1hhtcSFg9qLAabCVZW1BIn1CsVBGzRTeGKj2894ETNYu7n0RtR0t+ebpP+9fA2Ur
         ytog==
X-Gm-Message-State: AOAM533S62n/i9XhGVhDieIneuCXgCmQxW2hhtiEPTn6jvyN9S7Px2n8
        2uP6bIMZrD0UYgiXFTaQxi/EGg==
X-Google-Smtp-Source: ABdhPJx4y9LSGi/OIH6gEh8R7fURUj4ACslBLW327W98NCoJvT1MmLNcZw4pj9ZJTsMIZRCpKe+bDQ==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr1431306wmp.166.1598672309743;
        Fri, 28 Aug 2020 20:38:29 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 07/12] wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
Date:   Sat, 29 Aug 2020 04:39:03 +0100
Message-Id: <20200829033908.2167689-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/smd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index cf20a0f63259..e44e4a21153e 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -174,6 +174,26 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 	}
 }
 
+static void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
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

