Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2877E25646E
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgH2Div (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgH2Dia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A227C06121B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o4so906020wrn.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nw0ynGFCG+q9mOyMnMyXRqRYzplLQrlsLY+fl+O+R1g=;
        b=tFc+jhuOvaf/IhUgxEvbzVJtii6FUuS3haW2/YczCBTPs3vneSeda95BNkYMnJ+vrc
         bxSWG21p1VyM9Ndoj/RQ0pT/2qUS7s6TRtksUqgGMhEuKZd68u064NWakbZynEVjDJ5T
         TkX3wZINdU48/UKp6JE/pgxTp2ZnT517UliFTJ0JULKeEzhYrm9UJ7LiVdAoTTvJsCSV
         d4o/26NsTQwHizbxrYEcFw6bK8DFjgJWYDnczjuDMYFeVWyzjPcW4L/MyvYCsb4ylnAl
         LsllhwmRJUtqdLPqLoWccAwewEyD7wZfPC5MTcn07+f+Oi0RRT7aRM5ZnZXrynBJOx8x
         TwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nw0ynGFCG+q9mOyMnMyXRqRYzplLQrlsLY+fl+O+R1g=;
        b=AUUUo4u+KhXaWjY5uMnGT8pWGcLeuhn8YHB3U/sdh5RvnaOLkrPxQ9cSyzuRMt0Ogf
         zHDn7dDPjzTrMvlNV5NqKxpwEeGHD3am3X3Fsqn8ZKMg7M/wl/RMNra15DNy7zvUKSTs
         xtFbjxDXuYTtK3xq1dHlli2GG1+qoyBW29iYpVfRtHTyvz3ytVvg68cb6JPKuinIJ7x6
         OhRfqU1eOqUE+oS9Xj/bqAdtt08JqXfVvEuL0mYVDqCiXFZkeWEI+9me4KgHD9hqDi3H
         Y0c+zZJdjisiVGf+2ov3yie8Vt4kaU+uXgHh/QwDhuCKtL27rcSCXCTa+x/eOKPI88Q5
         47xw==
X-Gm-Message-State: AOAM533UjI59/wfMVvn3apjo5BWPfPKRBCL8H3t9HPcX5kDzU4VyCGOH
        ztJ8WvLRxalzDJUxOYfKSpO2CA==
X-Google-Smtp-Source: ABdhPJxaiWQ/R0idFEhmB7YXIcENKD3bfog0lZsRJT/Np4W+BPL34uXSEEk/uUAIlE/D0d9h/HdDtA==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr1781530wrq.187.1598672308820;
        Fri, 28 Aug 2020 20:38:28 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 06/12] wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
Date:   Sat, 29 Aug 2020 04:39:02 +0100
Message-Id: <20200829033908.2167689-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toggling the LDPC enabled bit is possible only via the extended V1
data-structure. This function provides a means of setting the default
depending on chip-type.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 45359e72a877..cf20a0f63259 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -206,6 +206,15 @@ static void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
+static void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		sta_params->ht_ldpc_enabled = 1;
+	else
+		sta_params->ht_ldpc_enabled = 0;
+}
+
 static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
-- 
2.27.0

