Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34A256472
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgH2Di4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgH2Dic (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03563C061237
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so878010wmj.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YukgF9ny7x7bUouMS+yibqhw3SZTHLceFKqCja3C2JQ=;
        b=vfzq8nARrDNrxKHgWhybVRWKHk13HdNHCNfoZgcR5bNWd8iN/NfR0vDreMK45Pn6zD
         +Mc37QIf8lB+ufdVsAOA8vtmUCk3YQMAJEfwyjzugO/ebFzcsWvWEjW+nQnBBTXr3sYB
         U4ynH7PHySupCczEE/sy1pQhs06Cfxp6nWVu2vo1CXOHfp9VmLggScttxLhpzrLKy3F7
         6rAhjkTTVXHS7xLr+id11IcF/WUxSMvuX6WhQAJCMAYLIwzvNSOu99doWER/r1sec501
         dLkS7tH8l54/DnN+bKaM2llbk1/DJ0INfMPv6B+NVNc0ocyJdTYshP1QF0mRE2buHDDE
         cHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YukgF9ny7x7bUouMS+yibqhw3SZTHLceFKqCja3C2JQ=;
        b=uE3UYURnVRPvz2TNZuyTHeKr846xujE0HbcwD4IUTg5a+/mp7dz4XegjLUse3pee3X
         zXCg6n++xEiIXoJOJ7MfOUWwNgYLaGgdRxg8ncfcijAkfqUpNbDEVwm7yCKq4cEyvs1h
         M3/c/HOtSlImLI7QFXc9EmtG+gOJ2PeeWykUv0PwZxgaYCoNn9e1MvjSdCZqQBUUF2QZ
         JS0dM+3qKcQVBDgpgBvsDEl9T9Utaofn9Ltjv+hcWMcW6wPEjCVoF+eLe+TgrRDv7pn7
         mz8cJ5SNF1B3pzWkmCOMOUQm8VZU6EU5NOV4fDyqoCqs+MTmyA1GHX2amdSjFPJqct71
         /gaQ==
X-Gm-Message-State: AOAM5309+qkdy7hVCGbHJNn+DNsU6qyxVFGIF59nI/LX6QQ6PmINGlZe
        yq6oI0JQrrFQE8VBtv2V3Reb8Q==
X-Google-Smtp-Source: ABdhPJyIqSR9qiGEWiytOGLh5MUVvsW6fZ6DxtRRjH2wJUqvyfmXpDZKTaMgG5IQPuzKoXoOVJB52A==
X-Received: by 2002:a1c:56d6:: with SMTP id k205mr1465262wmb.88.1598672310743;
        Fri, 28 Aug 2020 20:38:30 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:30 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 08/12] wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
Date:   Sat, 29 Aug 2020 04:39:04 +0100
Message-Id: <20200829033908.2167689-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
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
index e44e4a21153e..a6106ba9cc89 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -194,6 +194,15 @@ static void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 	}
 }
 
+static void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
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

