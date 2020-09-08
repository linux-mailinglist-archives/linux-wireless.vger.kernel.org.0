Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3C261A34
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgIHSdR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgIHSck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE81C0617A2
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so249933wrv.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naU0RpV8J9Z6Qcq0aj4T/awPa3wV7pjar3MjYtbLY9w=;
        b=xUo/Mj/s1sJsaYWY+y3Gfo/CcSyX9jnhvjfW2EQ4K7CGpNlGtvMSEjilGQHeocn5y1
         h6DdqZfXl/hKp7fBVL6kqPAVEthkgx99duEEGk7GmgeYKTQeRlkUXBoCC2LiUZNvGN9W
         acsu9Ed3pgrhA9KTkXLPQJJgHvvsLBc2IJ8yiIrE3Fbz0c9iyAeTMzJ2yOvFsZa2yWaQ
         bjF/yATYZMrpqCa+v6rtAcSIvmzeSTypywXZa1Z2H2FlAloN4FnL+9cHycrzBj7HyaTq
         DjJ5umHfMikKtuSzBrmoOsgAbXbIweymhRrP3xCCYlZJdzVyzVINa73MBwgpkTPR5Obi
         zp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naU0RpV8J9Z6Qcq0aj4T/awPa3wV7pjar3MjYtbLY9w=;
        b=QvegXM6OYcDirFC2cqArBBAd4Nji4AzHZbuWmVmgFdwke6jE0cpSpshDzLlcEd1xtf
         8nhRNwIipyw27y0FknniBNNy0te7iZY7kBUQzhBEziT04vzuTbSR+e9SkjJSH1qkzasU
         DqZKMRKq7B7YW/7d3HuNXZYjhPjV00DWqkT4Rrc/eVeCPahfqclSeT7T1IQNjLddtRrm
         boZ/+itgYdRXkXdOcCzyL3gSUQaOfJn5zcl/qS2jHN4pFh2TyPt5BIyYrGA8msTj/pFt
         bk/RE/YTP1hSFxjdiv8+wVVlTB16UR9NzD665vjg5Tp13I9FY3QsE3sRYzKhMdXqiiNo
         X2cg==
X-Gm-Message-State: AOAM532Zkp+KffQ2VCy6ETqcV/iUXc80FXLCn2k5T6sFBMBoo+w6Dh0/
        DaUYv93av1K63hs+TfoscfcOzg==
X-Google-Smtp-Source: ABdhPJw+uCUWMi2lTNj7RnnRhDMTKx6oVVjvVvNeZu7CxHMP0u0bVqsfWa8gFh+xRX2t5cMETuhB+Q==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr968198wrn.358.1599589450623;
        Tue, 08 Sep 2020 11:24:10 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/7] wcn36xx: Move wcn36xx_smd_set_sta_params() inside wcn36xx_smd_config_bss()
Date:   Tue,  8 Sep 2020 19:24:50 +0100
Message-Id: <20200908182455.2870345-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to facilitate functional decomposition of
wcn36xx_smd_config_bss() we need to move wcn36xx_smd_set_sta_params() later
in function.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e26752396bdf..28a571918b19 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1606,7 +1606,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
 
 	bss->reserved = 0;
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
 	/* wcn->ssid is only valid in AP and IBSS mode */
 	bss->ssid.length = vif_priv->ssid.length;
@@ -1632,6 +1631,8 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	vif_priv->bss_type = bss->bss_type;
 
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
 		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-- 
2.27.0

