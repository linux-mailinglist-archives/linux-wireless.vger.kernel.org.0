Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D823261A55
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgIHSeu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27AAC061388
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so243468wrm.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTCWkwRmuH8PVjJv41u3EUB522Tf7wb2bKFIwOAThY0=;
        b=WZCyRBI7k1r6YEf9qStznnaywdXgAeKWhpKgffvuEoBG0GSc1U0uZdbVzMfCpNVcId
         48SPYOBKez9GDaT0aNWm08ir1ANaXe64vIS5HRTlkE4GJLuIBqaS6+RSnB66Wj/bwJ02
         FRqo7Ste9VqBaAQZMWnoJlplzq/5jNz17wyiMAJt8cpcCV+XyKC0KfIYEqCUI0lUR1Md
         Fiy9LPeKOs7o6WCm+ESSbXKBuFAzV8Zi/w187SrFZeKE49L8RKY/F8NwFtEkQrLtr4Qz
         Wlq3rLPQgPvlH+siI3C6TMaudFgQHgfH7QOXUQrR4n6xxdHL3x9jmf2trYTK+KQ6X5MH
         oQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTCWkwRmuH8PVjJv41u3EUB522Tf7wb2bKFIwOAThY0=;
        b=o3fYPEmpD9As0EuAZVSBz2h8cmWPWZy9hj23Vd0gEsX6WAMHnTDkR9OiW3zue0Sh+g
         LVcP1zhy2I27PWhMPteZ3nc7BP/nJJk2DwsRDqPJ+3KITxXLDGtoaxmsRb7KNf7Y0h3Q
         Pn3hvFkzRWD1k8DucB2mnIwoUS6D87QXN+A9nO9wNMV7/D0AUdTpSnnqetqoPFM3OcCc
         3kux5La+RnGtLfmr+PtzMZpCBedsm6LB37ofjHjjTrV86DEEymcij6N2hZe25KKct1m8
         8Ctpvs7DpqfrnHJo8tfCDe3n6GLdMy3WmiDk5+b2hF8+V+N2YHYzMo0Cb05H4iYIHOGX
         W/UQ==
X-Gm-Message-State: AOAM531CHvdu82dpsgg2gOJAlmp6gYT5/74e1MjQu6cTei3sJ8N+8e9K
        yx78DFpWrssiDRYCGmuv9UlSaQ==
X-Google-Smtp-Source: ABdhPJyNVA8R2MA5tIdh1MRyXgm+n4f/aH9hb2Ea2DAg01muSJHUjrjljRlB829dD58e/1OLlIQmYQ==
X-Received: by 2002:adf:f190:: with SMTP id h16mr942210wro.202.1599589496380;
        Tue, 08 Sep 2020 11:24:56 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c4sm334348wrp.85.2020.09.08.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:55 -0700 (PDT)
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/2] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
Date:   Tue,  8 Sep 2020 19:25:41 +0100
Message-Id: <20200908182542.2870535-2-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182542.2870535-1-pure.logic@nexus-software.ie>
References: <20200908182542.2870535-1-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This commit adds VHT rates to the wcn36xx_update_allowed_rates() routine.
Thus allowing the driver to latch the declared rates and transmit them to
the firmware in the same way as other 80211.n rates are.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 2c2b6178c8cd..9c283c110e07 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -766,6 +766,14 @@ static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
 		       sta->ht_cap.mcs.rx_mask,
 		       sizeof(sta->ht_cap.mcs.rx_mask));
 	}
+
+	if (sta->vht_cap.vht_supported) {
+		sta_priv->supported_rates.op_rate_mode = STA_11ac;
+		sta_priv->supported_rates.vht_rx_mcs_map =
+				sta->vht_cap.vht_mcs.rx_mcs_map;
+		sta_priv->supported_rates.vht_tx_mcs_map =
+				sta->vht_cap.vht_mcs.tx_mcs_map;
+	}
 }
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
 {
-- 
2.27.0

