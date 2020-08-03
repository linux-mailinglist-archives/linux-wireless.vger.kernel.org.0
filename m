Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9730E239DAE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHCDLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgHCDLC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49399C061756
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so32762264wrh.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0xU/dOb+LnLns/kX1ZtFyu9J+wVoP3941KcJL2LnEo=;
        b=UkGqSwyUC7NcETveDjLdMlQ7VI2NnUqmZvtN2Y4GXUD4mSChmF0z9utMz8Wl522Iub
         0bNS1CduO9tCT0lS8+xKCSj6bJG/fkpd2QGuO+u4Bf/5EoCAwKmq/Nwb3QmpVZssTCbx
         Qe8oF0aFiW8Q0U1nN83X3ExRdsrYUt+sljBnur5VKSCZaL28kUeCZsoeTJo29OCS6G0P
         h1+xhZcvmKnG1c8ZXykKWufHX7AG3XLcM9/NUuiAKd3/VSUJ+7peHeaAp1WUfeTrDLsp
         za6a/EZUrOazQUHA1qPI/Plc2SlwRgiB+jJaHRt7sOjzxDAbC1xePilw0e8091oapoxQ
         MZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0xU/dOb+LnLns/kX1ZtFyu9J+wVoP3941KcJL2LnEo=;
        b=BfI1taTIGc2jkAAMUKNA20jeHDNJS4CAm+4Sp4uEcRl3suxxPmHGvkBv+/xi6Qsl3k
         L60fM9MGE8/pADuW/cgREkmZcrKV3DD72D7gtNqm/pHBjmDef7X3GJucW1TyQFBL7e6M
         n+bXu9N34Aj3TRLZYrEDgj3u6s1sksReSDLMhm385pcMT0o2MrnvTZTu0i3tMJYvZEDs
         cvJQmOHa8kldz/92AEla6rWAfLRp5lzECoA0B1Fp2gHWQHtlFris9Gws+6WTd6lLC+Fj
         J1K9VFpFH3xIAM79E9uLwGlOtsJ5rIAX9qmK/a+F0KwsM19kfwfOMy1bpPXuuY18vKpp
         XDGg==
X-Gm-Message-State: AOAM530EnnEZq4l46p2xLk0IQteDy9Dit5gsLJ2H0jLiXpnvAol+wIm7
        PnrEzRaTaKwgXpqkxD2NkL179A==
X-Google-Smtp-Source: ABdhPJzFZNLt7i8K31NBSiGKiTBGOQv4as2fmUgxxUGyHIgq0bEbb6TljC1+3yezu1Gvhhc9VXuymw==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr12756722wrm.113.1596424261097;
        Sun, 02 Aug 2020 20:11:01 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 13/36] wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
Date:   Mon,  3 Aug 2020 04:11:09 +0100
Message-Id: <20200803031132.1427063-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index a4e45114991b..df7e2125b503 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -189,6 +189,22 @@ static void wcn36xx_smd_set_sta_default_ht_params(
 	sta_params->dsss_cck_mode_40mhz = 1;
 }
 
+static void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
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

