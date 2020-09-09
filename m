Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2354D2630BA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIIPkV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgIIPgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0EC061290
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so3482213wrv.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWzCrrKoKysbfFMFWJQIl3auUUYuPdk6I6S0pbeF+DY=;
        b=LYCnKcOcTXyGT/c2JMpMfO3Omd4+PrBdpFL9aah1ciQX9HeVZ5ealJ9A3B9DskQBwf
         LT3KYg9sBGqDxG9N61vp1IN1I1G7aU2aufdEi5w98KGPszZUse6tRP8vQyN/W/6Arfhi
         +2sNN56JFya9L17qWLZh14XgrWg5Jnee9vrHEp4DewFGWH6QogJafGvX1Gfi0/ljoe8w
         whYZ5HY0qeZrJNBqKx5+ynVcLR63pwbjASPMJKi6kADpU3l47KK1RKf7SMPB06upEfrS
         XvwnigcXzJoMj7sE+Nvi7CVVusOToYwG1kyS4whVLNCahpDqyDONNzgEJZOml05yNsiK
         F0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWzCrrKoKysbfFMFWJQIl3auUUYuPdk6I6S0pbeF+DY=;
        b=O0uN3g8F2iHDR8NpLNGgO7C2JtXIBKx9nhPDvo8JoNzTsrhd/B7PW5C6kScH+aio8n
         6PrksF9ocEh/MgwdPteUm22Yqz62Pu4bX7H1lsbTXW6557Qj42CVNLG2mDHPpJT+0AZ1
         eIVzkw08A3+FSkxSMvr2RjaNF/VgYnBwlmrQRun6Hi5Iz6qrcb9c0g3JLy42gkQkR7hW
         GE+sxmCjt/xagbK/drrQpFv/vEDmS3ofm+oCpp+RFs9qzc0TW7LXwJASV+/NIo+7Bj6A
         tLecaUiB6mcsmUCC33MluiyCaCBYp32oUH8oUfJrqd7rA5BwkSFQZtjv+wTmTQd/QKBl
         uNhw==
X-Gm-Message-State: AOAM5317/3TT3B0wCkoPBZA2LR99DkTEo+X7soWRqzGEyBoKsNGiiNrK
        In73E/KdNOV4ytVWtPo7Bu83Hw==
X-Google-Smtp-Source: ABdhPJyAYUT1kgsVecItl5G2mxAfdgZTV0OMbbS2C3fkNZTTgy3qC5iGMOmI/aT4d0m3a9Am6ahxQQ==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr4590691wrq.345.1599665794071;
        Wed, 09 Sep 2020 08:36:34 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m185sm4605220wmf.5.2020.09.09.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:33 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 4/4] wcn36xx: Latch VHT specific BSS parameters to firmware
Date:   Wed,  9 Sep 2020 16:37:17 +0100
Message-Id: <20200909153717.2905037-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
References: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit makes use of wcn36xx_smd_set_bss_vht_params() to extract VHT
parameters from the 80211_sta structure and latch appropriate bits in the
bss_params_v1 structure for transmission to the wcnss firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 6805de3f58e7..ad36d6e744a6 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1681,6 +1681,8 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss->tx_mgmt_power = bss_v0.tx_mgmt_power;
 	bss->max_tx_power = bss_v0.max_tx_power;
 
+	wcn36xx_smd_set_bss_vht_params(vif, sta_80211, bss);
+
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
-- 
2.27.0

