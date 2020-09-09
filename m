Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248DA2630A8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgIIPgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7CC061364
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so3487775wrn.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIXgUDCAw5H+6nCd7qyCvsfy5qAJIAQL+JK4lt32D9s=;
        b=eKRhlStCkuMr4/tC8YCMRh8j107aOkvK4lTslY4lHfiqyORjUsWw0n4xOrCbIeLPia
         ld3FttlmTezZROqvALiXJ/c7uhXy15aBv2sNwszWS55pd+M0U1YlQvgBQlytYGbXvIqd
         c7xin0waA46/jJbIKSmuWVMh6H8u2l6PkVELk9XpO+dTxjg8rGdXt6ZcdmFRATcrI9Gy
         NGc0gajAN9o2SlQSIh2GZLRvYcazLUU2HefEv7Z5H5/9SvcGPVvpyQZTrhO8AOqYdaKa
         juXWNt1e4HldFXPKB1xop5hwi8TqFrR4BorIzNGuSzo5yqUjNC0lIw4qO8KIIU/Gy2Dx
         YUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIXgUDCAw5H+6nCd7qyCvsfy5qAJIAQL+JK4lt32D9s=;
        b=cv6m5XZgQu+f/Qu0BfrbfpWL8AGLGS+WrrZDNSqbtjZ29D62GfO7Ktl6Fk0CIFefgP
         HpqGYln6HCmBtPH0Bb4oZwEkR6NP18U+jCvaj8fvq4lrAYSTmLMcBAM7tYPufEC3PfI4
         tk1nv8nngN98fXDyKTbXrjC4/69rRbbkW6glYHpNRM7GB4U5DgesVblkiPZNoSsdomaV
         rpjhzRj3nBcEDAmw8O2I0OcHdK5vwys8n1TTP5M3DvW/sPZOdTGGsF5jWWJn+y0p+wQs
         Q9kAZNYnh9IuYNr5XxN8Gfjd2+7rlQBG7NkbiXsZPthj860GL3UsMnxn1KJaeKovfibk
         WnQA==
X-Gm-Message-State: AOAM530uL/j6w82QI6PVXiF83Cq8nwDULrNWg6yxMjZTrVi6+haXXL6/
        q/+NApQarvG/HgbnLNFc7L9Z3Q==
X-Google-Smtp-Source: ABdhPJzsOuG+sLkMJhadLbz7LALyL2YYbJJjVFWKm9IinM1h/eof1hdrIYqJFxe1yiWRN0xgPnTZzA==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr4778533wrv.148.1599665724737;
        Wed, 09 Sep 2020 08:35:24 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 5/7] wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
Date:   Wed,  9 Sep 2020 16:36:05 +0100
Message-Id: <20200909153607.2904822-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
References: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds a routine to allow setting the LDPC bit for HT parameter passing
inside the version 1 STA parameters data structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index a563a30c3a0c..14af98af42f3 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -196,6 +196,15 @@ void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 	}
 }
 
+void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (sta->ht_cap.ht_supported) {
+		sta_params->ht_ldpc_enabled =
+			is_cap_supported(sta->ht_cap.cap, IEEE80211_HT_CAP_LDPC_CODING);
+	}
+}
+
 static void wcn36xx_smd_set_sta_default_ht_params(
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

