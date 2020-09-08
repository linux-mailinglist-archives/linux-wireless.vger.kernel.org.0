Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED2261A5B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbgIHSe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbgIHScb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03A5C061798
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so319366wmi.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRk+Q9bEx9jVxUktPh3Y718LsTPSVLh7wgm2w67dQZg=;
        b=rlVXfZHZTQ8fR/OJyfrsuIAIwYMSj1mSlKU9L76KwedlHBg3VpWf63pguI3doij2A5
         ASkLZsv3ka8Dd9LjTZzsj3HiHn42wqAU5u/txDu96Ow8WadDdmtpBMpQaDWNxHolH/g3
         PFpU36A9wLoLF2jnb8avElhwQbgM7KvlWgGp0NdakcK0MunWu+AMIKy+PqP9ou4PqaZF
         aLCLm7u2IVGODPdiaokIRYOibLBJ9COsXMuWLmO9KEWNqNzk0UHaCViLiLpGGOENjGfE
         c3zaw+8MrYySOUvisYmUJ4wpfF2HRd2VK216qnJFUf08rYmdt71Ei1R3fI9tHHdXKlPY
         b43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRk+Q9bEx9jVxUktPh3Y718LsTPSVLh7wgm2w67dQZg=;
        b=jUemJ5OUaiT/uzq7mLXH9okg7no4NC40IkgLyurpviqI6MTIzK+LXd9n2qQyPa8jBe
         0uOsIO2tnCHJIX9N6NTKXUrg/OFqmYKUUG0ZVzs3Nc9YP91uHDhIh9TGE4teG4nLV+0A
         Chh+vL+XQADKe7LbYGzjSvkhuEK9LtNCOoF/jWjcMSa7HcH2Q3FxF3gTaDh6cZ228Zps
         i6ptQLrOuRTK2mFhaYSdh7fGBc1Rx2pGClx4wJ9Ki6ETx5+uWrtc0J2nNAkKx23Fp0ce
         Br5y14pr4sIBqAiWdbKg1TqbnNKmAzuaZMDyHyUXD9bnAyBdS4y8tcbTeKSTkInq7MZH
         2Tuw==
X-Gm-Message-State: AOAM532CnhGZ6bPm3VODrQiBQ/RKKV46FZjHt8aGnIaOi5EIHiQdOKhr
        ND8uUbk29Xspk0sprLcIFw1k3w==
X-Google-Smtp-Source: ABdhPJyvzH5jKqBQjqEIJ+xeSJJqZr/txpSQ/oGYiJZp6skcvGJZGawWt+dFeljNIyqY2ylCTcnxxQ==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr396218wmc.84.1599589432446;
        Tue, 08 Sep 2020 11:23:52 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:52 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/7] wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
Date:   Tue,  8 Sep 2020 19:24:32 +0100
Message-Id: <20200908182437.2870281-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
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

