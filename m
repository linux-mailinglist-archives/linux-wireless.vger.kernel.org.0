Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B268261A4E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgIHSej (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4AC061386
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so198652wrn.10
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hC7svxUBC9+5fAYER72YcMO5aUlPkhhS9EHYF1mTiIk=;
        b=h4dRPqirVG/ZcKO5UTT1JH1P+lYaS6pw0Ng70MDiUXh/v9D90SgbAsSoEHIwyBh17o
         BxmLFvEkp5N3amoRRmgk1PpJAGbnisVGUae3b/erXlFemb8FaMBG1rCDYiSlbSlvNG20
         /JxV6YUSVy1V7oV2/+4IKkizDm9Dulztjm+yrMb1WRuY5fXxyDlIPWeLVkXGc2+z0J2S
         AJ/vyN0484pPVwPJk+luypI6duA1pWYmZ1zf60UjtKZpxApFha0gV2xdDSG7IJivuSB8
         SsCRA8DOpaNUdcLYtkquCHdtFPOA+7zdoAgMJmWjleT1gxeLpmluux7p7z2H0ZYgGC1r
         v7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hC7svxUBC9+5fAYER72YcMO5aUlPkhhS9EHYF1mTiIk=;
        b=hPX/mXiKy5NHh4qo+3XtaQzlTsromAaUOre1naNMRNBbMsvA5TWRTRSulZ4/cV+e+w
         wwXDmw6FRAuE1k01kA/ScKNdoVOdVInyadh43u7x8BYy0T2gaADn8XAIMM5rueo6kA7K
         4cP3v905MqQAnNqGfL7+mO2wQ1APIwi6hr5EBmqhTADVuy3mbDfcixc1IJI6Y3qaCHDG
         +9ngJwDmNij+GwAeCsCUC3I21k/DLUTgztku814W397Vegwm9qk2AFF9YXgenMWoVFl9
         lg2KUeSu5kezlEAVe3pLFnpid+pPC3q8w/1PIg+B2qvYBVS79eL4p4PPXDiBHb3kvvPh
         3G1w==
X-Gm-Message-State: AOAM533mVeMzFjUkTBUHM0UIPbhmmc9e+LD1OnbXYh7EQX2gdw9lYv00
        JwpNjK+TkC2AaCJgSrOesGjxpQ==
X-Google-Smtp-Source: ABdhPJz0qKdvDPX3/EyhKr1Mjo26OJBWDZBlgu1+sOq/CkdlNHzfXkzzCa6LSOpjAQ3mcPwQzo21wQ==
X-Received: by 2002:adf:dccd:: with SMTP id x13mr942502wrm.403.1599589486224;
        Tue, 08 Sep 2020 11:24:46 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b84sm381427wmd.0.2020.09.08.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 4/4] wcn36xx: Latch VHT specific BSS parameters to firmware
Date:   Tue,  8 Sep 2020 19:25:29 +0100
Message-Id: <20200908182529.2870478-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
References: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
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
index 4672581a4354..b09a3dba757f 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1679,6 +1679,8 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss->tx_mgmt_power = bss_v0.tx_mgmt_power;
 	bss->max_tx_power = bss_v0.max_tx_power;
 
+	wcn36xx_smd_set_bss_vht_params(vif, sta_80211, bss);
+
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
-- 
2.27.0

