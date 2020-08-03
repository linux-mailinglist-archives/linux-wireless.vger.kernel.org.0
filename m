Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDD239DAF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHCDLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgHCDLD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE4C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so32762286wrh.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsN/Tm5UUbnXfV08uwv1LnbG1GnG/9PP7eJ2Z/tnej0=;
        b=CrNG9EZkmha+mhtxCrzJFNWjl18boOBTZ24XTJFK5vskKYM488wv2t0kVKuEuqE4R8
         2HI/6ttCevYELidGsrqeiHTA+aNsYablniD0PrYvmFS/pW0jFijkjvn+J2RoCK9mojAx
         HzfwJKMH0gjx3fc56xzaXrNMel7pWfgPk+qoFM7L3ezaNqvB2VcgOgLtRMQgy2T5GbkY
         4fUZmwV/mbQ7wcsX+oMxWWhLsBeydL3QK3oCkl62xWqdeHZD/oLnLW0GEHdHjsYTaiGY
         bQOX7O8er1DWxhuiYBReTE7QVJ/97Q4zWVBrbw6uhoHHUmOxIWhjT8sxJzEUod24X1mR
         +NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsN/Tm5UUbnXfV08uwv1LnbG1GnG/9PP7eJ2Z/tnej0=;
        b=l8cNR9e7HtOWBrprPXdxfwAQZaNgAbdk/PkBsFBi9Ys0VohWTW1qh239Z9QuX8ids9
         nmfBFgNYb/ZDffZ703V1MDyJBfqpVi438jz9dGtq19DelnpMb7i6NRBOkAYCKUAxmr08
         WhjBF/Dq3NjndQawcsGO9eWX0b5wKyKLCK/6uQwL1gKlcOin4q2eyOJs9IeORXYs3gfD
         DmZMCG5JO1ZqmXHac6TF0G53GDW0rfb4tFMcxt5u5YWjPRr30gF8cQRlZohGTs5OwKOQ
         ME6zgzNGYXD5gf0BPxiJuWRpe9UkXUj0iqQs1QjGV1eiMtE6LRhA0XkrMvi4GSBGUNJz
         ST5A==
X-Gm-Message-State: AOAM532wnC31GNIynQkPUKU2RGTKISZSgzjhgxtCLVlHFpkjMXFFsdwT
        5rSOm0Q5rLFoh5hRfgECRpcJmQD94Y4=
X-Google-Smtp-Source: ABdhPJz86mv/8MU7ZfODrE3zFw/cRfW7kYAqRepRy5liOfY4K99VPrtxftxStH5gxCUV4tv13ymQWg==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr12658098wrm.382.1596424262105;
        Sun, 02 Aug 2020 20:11:02 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 14/36] wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
Date:   Mon,  3 Aug 2020 04:11:10 +0100
Message-Id: <20200803031132.1427063-15-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index df7e2125b503..88fb4b7f1356 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -205,6 +205,15 @@ static void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
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

