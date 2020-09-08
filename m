Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075E5261A45
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgIHSeY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgIHScx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC38C061797
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so196138wrn.10
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLRqP0UInT6/AdhLdK71Y86cDeh3fCR/pcMIonkjMoI=;
        b=SmTEGwEZQG6wXCTPyYjWIn3jeLFANvjtPiQ38Ztow3DkSQ3vc1jTFkqZdoCqjlKjWr
         S2K75Th1aMeRlRf9sSxFRWFqsvi7fjM5rIHCd64ckGRHwgtPCuAblLMDGf66YX5IH9ip
         PjtHkysjWJ7D+bAsdaWGOu4B4Y6Oi9epEtnVXelpQ6ypP2IoH21FxEScC/sqmcHWlMu7
         OW0oI7PEyCyXH6bsPZdvxIZrP8W2hNZ8wzI1/Qznk4S2ydD+2N8u8cKazUSD2ZU7Am+h
         sQLzebFkAyR2HGV5t3RzO6dJ/muTFDfEG1yDsV//MkN4ApO4tScJe2DCIiLWWGc2woI4
         4PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLRqP0UInT6/AdhLdK71Y86cDeh3fCR/pcMIonkjMoI=;
        b=A/Xu/Nfjj2bf6WxGofVx1QuboTxzwrVaCiAtSNwzn2pnr1na6z6M62epkWmMjny8cd
         U9q4AEkVb3BA1vAkKWEJ534zDur/F1yzsHPgN776BW+kCiIqMFwNodOvtgV1zsrrYRma
         ehM/0QRo3Bis11e3ErZ1a3DSqLX12wxCt017I/wtezxBVbgdJ6DIYGj+/t2ZMI6nzdzG
         jgknkoP7DNSmSPtf9luzo4hv2wX1UuJIB51puQQLrodCnTfD4PdO+IF1MFPICQWTlTmQ
         3gOEZkhbSuYL7wxdX9AM3NqaYNxTBziavHjEP08w7ydsK+4Et0F61bB5oMf3Tjpb7hmQ
         0cVA==
X-Gm-Message-State: AOAM533U7Xcv8cBCiTBe8i6EAAtxyh7sJhT/tYJne8AiPqA2JcNCKkMK
        2GzHA2DPQqxK97J+b0+b33J5GQ==
X-Google-Smtp-Source: ABdhPJz90UAS3wKGMgR//5WUKSyEQz5P21njTPBZ417vPlGfOFtujBhDM5DtiyIE6DsIcayghW7Y3Q==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr908365wrt.366.1599589431460;
        Tue, 08 Sep 2020 11:23:51 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:51 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/7] wcn36xx: Add wcn36xx_set_default_rates_v1
Date:   Tue,  8 Sep 2020 19:24:31 +0100
Message-Id: <20200908182437.2870281-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
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
index eb518bd88870..ba37439352a7 100644
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

