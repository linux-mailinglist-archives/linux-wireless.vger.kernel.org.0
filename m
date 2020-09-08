Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4474261A6D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgIHSfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbgIHSc3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54FC06179B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so187922wme.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIXgUDCAw5H+6nCd7qyCvsfy5qAJIAQL+JK4lt32D9s=;
        b=Am0e6ABT6mWjoCC+451SwrlPEHFiWuCdQBmfAeUhYsBZEsC2Q02Lsnc7ODIa8tfa24
         wtR0ZwWNnFO9BQCurNKzCuwrfO/o1WE5y3KEkXlJ1232Mak+QgxOX2Il2t7oIEwUBbnb
         BcorjGQutPtrJrnl+tNxqQnIfD/XnGTUL93eLv877RdZIlpnre5z3RACLYbty+g4WWzg
         6+PaxqUypYlfk6r33boAmX+gNv7/IRK0702YkLN4LmKOS9+m0puVQDC0e2DJ2ITLWnyW
         a1idco+6FztxFnfLc/6dPxoit1KFB6VqCRUsXa53vfJ+FjOPaMUSSiBiE7qYN6JXKL2t
         1U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIXgUDCAw5H+6nCd7qyCvsfy5qAJIAQL+JK4lt32D9s=;
        b=KKcRlhIMrP26UlYb5TAR0geQwP8nu7RWo5VIa3+/5SVuN/dSezaDFYxoeWYWuq1Dr6
         L0iCW8SBFSufLExqXv6OTP5ByVmBaec2B9Uv/AWdkOJzEhPx9tw1cnEIcexDimJJB8HU
         ngz/eUR2UtDfi6EQBimAilQH/C94qf8hzhgfXBq0NktexTJexnkMWb7BhOL4v8im18Ni
         bd6fSshS+M1+dSiuiMmoLTEm6HeeFkb93igYU2CuJprPqd0Aq1jjIiODT2AXb6jh2gS5
         gQHjwj9tiCQAmBTNcpehhu5CiVrIXLzZ7elqnfl/glvca0L8dadwQQFrjmDS5kwGMGl2
         fCqg==
X-Gm-Message-State: AOAM531Bpwh/gprrkK/Bc3EW0n9m/RmakO7eAvdWmpqNp9EYGl6nTllK
        wiXs4U7jMGx92qYvotY9vG9Tcg==
X-Google-Smtp-Source: ABdhPJzIkQdaxPaZ0eNhU/6/jza9oxGPEJN2dKzSMbg7Nb50Av9ZUxQXuJjjOZk7FT5gVnoMKe4W3g==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr383075wmj.138.1599589435367;
        Tue, 08 Sep 2020 11:23:55 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:54 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 5/7] wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
Date:   Tue,  8 Sep 2020 19:24:35 +0100
Message-Id: <20200908182437.2870281-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
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

