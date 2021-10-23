Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB371438107
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJWAma (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhJWAm2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 20:42:28 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BB1C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:40:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h2so6014635ili.11
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpY5YvAdI88mEgTssdajQ0m3zcXKz4URVV+QOXC/Psg=;
        b=VlINocpShO4JR2wYePuwlwKsZPdwBrjouwtL4GJypO6FreYqyAuZwbbjXLNEpqE8cL
         EKkRH5tGk7KVwUJweiPakGMiAMjcHTCu/lWTFLvl24m2aHNhBCIIVLigKfjWrw0Fwzmb
         nu5gGCzC1Sg32Sq+Ir1skyeUWt/ZLv/ci6cUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpY5YvAdI88mEgTssdajQ0m3zcXKz4URVV+QOXC/Psg=;
        b=xoTkf2ozNVLTlR/6YQ3vUR4w/pEy3Y24FqoAy/YVh/wrcVKSQJrSmDGoR+ZhVHicA1
         aG16rveCCsPnCjOtLgpsOkWApwbUB+aS88WERqdJsufVdtWOI3nMDxgaaCiTonvFrsx8
         eSpK/lvPejHzJosVKudzc30ztpesWITlGCkt9aFkEEqCGAvqsF9ZlAEUm88K3TBw+4ak
         4vcrnwfxzifHywLcFtd+L73OWN7/Odl0sGO69r4oRIBJT0rThnklDJyII2vUAcHdCSHR
         3JSP1Edjfx/AskRfKoQNqCpNxz4jtE8e0jwBjhgLb+z5VeGqega56DNBhvPeC3R8NoHl
         ty0Q==
X-Gm-Message-State: AOAM530WKc8WbMAXWEvzp4UlNXoRDjleYAKBHs3gzYyTIA50BVjI4aKq
        Imx2BoVU9XgZuPqU6gBdXSuLKQ==
X-Google-Smtp-Source: ABdhPJyqAioSuiNA6gyq8L25PoMRsoa2slBy5PTrS9tx9fJG4ydmejds7bkrZRXCWX3LzVXBL3WzPg==
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr1833998ilv.142.1634949609106;
        Fri, 22 Oct 2021 17:40:09 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id k16sm4945474ior.50.2021.10.22.17.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 17:40:08 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Joseph Gates <jgates@squareup.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eugene Krasnikov <k.eugene.e@gmail.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] wcn36xx: add debug prints for sw_scan start/complete
Date:   Fri, 22 Oct 2021 17:39:46 -0700
Message-Id: <20211023003949.3082900-2-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023003949.3082900-1-benl@squareup.com>
References: <20211023003949.3082900-1-benl@squareup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add some MAC debug prints for more easily demarcating a software scan
when parsing logs.

Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 263af65a889ab..81ac86eeaf60b 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -711,6 +711,8 @@ static void wcn36xx_sw_scan_start(struct ieee80211_hw *hw,
 	struct wcn36xx *wcn = hw->priv;
 	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 
+	wcn36xx_dbg(WCN36XX_DBG_MAC, "sw_scan_start");
+
 	wcn->sw_scan = true;
 	wcn->sw_scan_vif = vif;
 	wcn->sw_scan_channel = 0;
@@ -725,6 +727,8 @@ static void wcn36xx_sw_scan_complete(struct ieee80211_hw *hw,
 {
 	struct wcn36xx *wcn = hw->priv;
 
+	wcn36xx_dbg(WCN36XX_DBG_MAC, "sw_scan_complete");
+
 	/* ensure that any scan session is finished */
 	wcn36xx_smd_finish_scan(wcn, HAL_SYS_MODE_SCAN, wcn->sw_scan_vif);
 	wcn->sw_scan = false;
-- 
2.25.1

