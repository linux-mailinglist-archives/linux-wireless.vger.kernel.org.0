Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD44525646C
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgH2Dir (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgH2Di1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A85AC061235
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so859598wrn.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nY+hO7+YD8XCHQqADSniuLxqB82KrBsfnqLkBYlMHwY=;
        b=DywYRRRpr+7zl7H02erezX/Lq8ylwnbjDFT4gFborvKHBdMYy3UF3+9nEERLiYona3
         ELPKUI4yewnjsv6phO2TCMDA9FO2ijTGHhLW3Gb02WLoryph8ntLtFRqhALntGuF4DIh
         11HlZU0vJMgnR8mq9hlRbLsHvunQGIfrzQGdxl4z7WPbsKeYcmHA1W6GpOBgt1Pfrhp8
         6TXXIj5ken5Om5GF+lCs0/rdbt2p/vBjt+E9W+McMwHROj9RB/+nIz6jAUKl6buV941M
         wrCAAmqTjr1sqos7w5NcAQddxz4mVeNC5P04JmNXaaHAYBvNDMoYKCvZSm684F1sKwVS
         8Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nY+hO7+YD8XCHQqADSniuLxqB82KrBsfnqLkBYlMHwY=;
        b=KykKyyDN/Qr6CeZC+0+5CO3JiaWYvwZFwJQN8RfEa/qMeMvjqdocKKBZx51ELx/iAu
         pFc1ZHP5I45tKlqPi9w/feye+4146NkXrOEJueG1CXVkGDL/D+PUSPHQVZt+o1WV6mBW
         OhuMznMSoCFnCw8po1Be83NsKS+Fq7W96T9qzvozAt6bbsESGSziDLocMoY+l4AZm0ZO
         QR6HhIoTVYBio9XuWIMVguiqUQqyRKOfHK3Aa4vmQg/PDV3DuBcEBjWqDphiuB0XkWeK
         Lb3XceeKyqNZFowCbhKpJuk8g74rGVkyx1XfeSPsZBxb3BYzx07m8o5PVocHA6agbbWs
         c8Iw==
X-Gm-Message-State: AOAM531fB1I8RdfhOuOmbUo+dPic4Sn+K/xkdgl+wHJepIqPwqQxY0eY
        YFPxJvdYTM1Dt3J2I5UEHoaLZA==
X-Google-Smtp-Source: ABdhPJyxFvU7DRBDqBwqV/HpYizqxnqRqs7ZfX8FrFLY1OkjvaJXJaMuhA5mSB9P2MUT3Byfp+Nd8g==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr1695903wrw.8.1598672305271;
        Fri, 28 Aug 2020 20:38:25 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 03/12] wcn36xx: Add wcn36xx_set_default_rates_v1
Date:   Sat, 29 Aug 2020 04:38:59 +0100
Message-Id: <20200829033908.2167689-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a routine to set some additional default parameters associated with the
V1 data structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 8 ++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 08e23dbb60fb..d589a00d901b 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -793,6 +793,14 @@ void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
 		sizeof(*ofdm_rates) * WCN36XX_HAL_NUM_OFDM_RATES);
 	rates->supported_mcs_set[0] = 0xFF;
 }
+
+void wcn36xx_set_default_rates_v1(struct wcn36xx_hal_supported_rates_v1 *rates)
+{
+	rates->op_rate_mode = STA_11ac;
+	rates->vht_rx_mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9;
+	rates->vht_tx_mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9;
+}
+
 static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index d7d349de20e6..2da81d9926c4 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -271,6 +271,7 @@ static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
 		wcn->fw_revision == revision);
 }
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates);
+void wcn36xx_set_default_rates_v1(struct wcn36xx_hal_supported_rates_v1 *rates);
 
 static inline
 struct ieee80211_sta *wcn36xx_priv_to_sta(struct wcn36xx_sta *sta_priv)
-- 
2.27.0

