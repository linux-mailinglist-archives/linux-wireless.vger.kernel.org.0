Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4FF256478
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgH2DjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgH2Di3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A82C061239
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so887364wmi.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8NDadMddxQkL9vVY4EL66xho6wVXd/4Nkgt+tvWO/s=;
        b=zI1RbSbS0/45UpyCgu7DAsld3+IS12Zy14XjROrsdhv7V0UfnWJraO8TBPk+Je1dZF
         MrdFmE3bp1elt7clnECQQrZvjUwHHpJEd1vCB54dcavHw4AQ0wpedg8EaFyxO0HL5LPg
         fkasMjIPvmmF6z4IqbXUfrtG3LGi6e/tHavpRqP2AWrc7b1ZpQ7jOM/GCECy8vy1uG58
         3hsQN/E2CWf0MtPB/6yF+fxZ9Meu7no4KXPHzBId86XLpaDSXdG7bCMYcvXEue0pQ2/p
         dsH/KMHq4TVNWVmpbovFGH7sbpOM8EXW9CF+NxFXpjrt8UYYD6ntfv+6CrRWkoq4RiaK
         wU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8NDadMddxQkL9vVY4EL66xho6wVXd/4Nkgt+tvWO/s=;
        b=rpRqJlNLAb9uTrrrDxqxeyNV+yPnoXMGfKIiwQq6hklKXh7HGH9xQLZGuRa6SSFKgH
         C5kTuZq5YpVjbhtMfDyRHtUbapsV/Uuk8i1QYSIiszYgF0SyT7wlE0UV4OA9anzL+O1C
         Qp12q72AVPQ9letxobjYKijdzLYsubTeZNZrSsT3+URwT9ZT1zgUNWiE/NPMCjHzucJo
         gVrbRa6USjDDzYn3OrhFxN78sfykVRZ1hkzGvKRw6MvWAHaWDKLBD+aLcwmNqpr4JArz
         iaMrnQbpC5KIeUIu6yAiC3EzsqShpWWSMPVVQjM45Hwx2ovhtPG5lmkLOuQ4AUUTLjQn
         +qMw==
X-Gm-Message-State: AOAM5303EWIp4Oz5rWBnlaKBJw/wBqPaaOn653trps20JrVUhGHIfeYY
        peY2WEaYzOyOgvuljAKCkJixMcBvOzrKHdRp
X-Google-Smtp-Source: ABdhPJzOIQqETkT5IpauLJl4zCHcOR+Cxf45SSV0o6XDX2rM08bjPw4tpWwIF6RWcIdImd6QsMMeQQ==
X-Received: by 2002:a7b:c116:: with SMTP id w22mr1510021wmi.149.1598672307502;
        Fri, 28 Aug 2020 20:38:27 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 05/12] wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
Date:   Sat, 29 Aug 2020 04:39:01 +0100
Message-Id: <20200829033908.2167689-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
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
index 8534d36c3ae0..45359e72a877 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -190,6 +190,22 @@ static void wcn36xx_smd_set_sta_default_ht_params(
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

