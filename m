Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E9D239DBD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgHCDLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgHCDLS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130FC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so10196039wmc.0
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/x0eExpVICVKXEktjj0SGBU1wjl5TjsRllYZDRNbK8=;
        b=laCKwgH931UpB6FaFWchH4vSzf5kAW/zaUI6nNweH62neq5EF3MYKPUJfQURyvf3Mi
         t8HyLhj6DErxSLI1eaAybNSb6ziIgVw4eMj3B+8N86Dz45Xn2L/5FkvfOrIL13hzqdsf
         qZddPGbw9JCPguNBhZVwLt/V+Oj6BOXNHtCe+YXecmE6LoydnvMmeXaLA4CI+8gkQk0b
         s/s6guDsLVEuMbtpap7qb7ZiYcwozsOk5vcIw1CheBztrFcusvuB1rfGJfN8ETnbiNXP
         8sHITTDOQ5hnxf70yKq5qmwoDyNCO0w2Mk5LlEvC4o2NO65DLKE4lAeDImYu0aBDoUjM
         OEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/x0eExpVICVKXEktjj0SGBU1wjl5TjsRllYZDRNbK8=;
        b=jG0vKLCyu6iy/QGjJcusQjL1TXTFh1T3du2P3aFFojwrihDKEymNKnGBDi9EAHefLL
         vBw3I3gF1s93U3PSYjuC7n/pnbQLVwOZlM/kSYIyE9AX7QmMV8y91VLZOLJDgNV1aI9L
         7fj3yCykmzPVkqodi6rJgwokOLIItTy8nZq9T8aChkkFs9Qy4JmSrU9JUaq4l+TNyDmP
         IOyqzI63LlIwAJv9uDdp42PJ7dFFNLRqcZIqdlCCitWDuAVfjGm/oINAsaxDOv4qlZRG
         tAKia/AtLF5bjEFKs6vIJPXQHbElRotj0G3Ype/Sp67vWXYYoEknpT8p0UBIa4kIn+fC
         mh8A==
X-Gm-Message-State: AOAM5333j2Nnl0d3UXHvuZ/QBNcjVexxXH3WfcxlT3O1DXK6A/HptYpW
        +PsBv+q1gAQke5p/+xH6SY3PEg==
X-Google-Smtp-Source: ABdhPJzXPbh8AE4RgmMHru4aSU1xEzx2iCsI/M9vTS9nkVAXz0wBq094cl1hiTNGX5DeMaY/53C7kQ==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr12997055wmi.63.1596424276604;
        Sun, 02 Aug 2020 20:11:16 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 28/36] wcn36xx: Latch VHT specific BSS parameters to firmware
Date:   Mon,  3 Aug 2020 04:11:24 +0100
Message-Id: <20200803031132.1427063-29-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 1eb13765e1f2..cedf4391a69a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1569,6 +1569,8 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	bss->tx_mgmt_power = bss_v0.tx_mgmt_power;
 	bss->max_tx_power = bss_v0.max_tx_power;
 
+	wcn36xx_smd_set_bss_vht_params(vif, sta_80211, bss);
+
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
-- 
2.27.0

