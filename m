Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAD239DAC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHCDLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgHCDLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F2BC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so29222143wrm.12
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vpNpHP9Fx27y3i+wK1ZfXMYtkK+cRyUpKFw3O+d/HP8=;
        b=Qxf5+W96Bx8CUdhG4VS8+T8paauRAgfFd2x8vEoOraaos5DudYtH2nT1ivpKhucGMT
         vY4Ew43dYwHt9PO8eKzuzzBxABKMg5P32XfK7korWZ4DqTRkHNjvBjhyrCrXBBIuYd4A
         zjKOdHQM2gsU3nsq4/cCXsDI+XX94LD68tTGAPGw/YXHNsPWq2MPSeXh/xgRbgye2tQj
         H8jBjhtqvvDETpNFJrB0+h3QiWYviHnXsPmuk3okU1jljTf3tj3LxorQXZ8YhdDfbGiq
         E+rKaeai3mOKML0KeskEZ1c9F04O25tVGKDBV+isCAOSBIgeroOAHp35pmznu+69hoOX
         Nqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vpNpHP9Fx27y3i+wK1ZfXMYtkK+cRyUpKFw3O+d/HP8=;
        b=B5DGRnXv7cstrkJmpJdDuBVRLkvEu5vsIWYY3rkKBTZQHNPsJrMlb+vWcgWyxv+K6l
         ZXRwz/FA0bTBvk1ELGu66JuENTYk6qIyXibdJQUKgplnrB2YuXPX8/OONo7Hqv2OK1gq
         pC4q8rYuWCWH7lTqhxqB9zaUPJx2/yaQJ0aUIeSheJwzvgvW91ftwq5ouFiAX141SXdP
         d+K3wKxMRqABpt/w3cxZ3aznw5e8dLVR2rY3V+D8HeEet3hlh63XTqqJussRqtArdjV2
         hMZNRp8PZbrLrSScBk3a6syaMt8ZXauEvztRsK6FboeAEiVv8dFoBHeHCqRMjrLPX26T
         XOOw==
X-Gm-Message-State: AOAM5301DCKHAAla6MlMKjgY4Q22+G3gDSpAjuxqM7mEG+mt3mRL4DJ5
        golptMvtFt1EmkbFndYD4Lp2bA==
X-Google-Smtp-Source: ABdhPJxCgXa4O4lCr5jufMzLbid1hV31YZ6Ksyj6RMw1lKhNPd+vfhqnw2YtfCvj7Fslbau82j3MHg==
X-Received: by 2002:a5d:526d:: with SMTP id l13mr12419614wrc.279.1596424258806;
        Sun, 02 Aug 2020 20:10:58 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:58 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 11/36] wcn36xx: Add wcn36xx_set_default_rates_v1
Date:   Mon,  3 Aug 2020 04:11:07 +0100
Message-Id: <20200803031132.1427063-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 3b27ff6f6dac..9f56f1af6dc4 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -785,6 +785,14 @@ void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
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
index c3615704b543..18ccc6c31a38 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -270,6 +270,7 @@ static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
 		wcn->fw_revision == revision);
 }
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates);
+void wcn36xx_set_default_rates_v1(struct wcn36xx_hal_supported_rates_v1 *rates);
 
 static inline
 struct ieee80211_sta *wcn36xx_priv_to_sta(struct wcn36xx_sta *sta_priv)
-- 
2.27.0

