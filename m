Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB6256481
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgH2DjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgH2DjE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D5C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h15so848495wrt.12
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HF7pNf4fbKb1C6oMKd3EGPiCGGRyRUf2Kb2rIRMMGWI=;
        b=Y790U8AJA1GGX4VlxN9KQIZb/aM7dCIaSPkklN6wdO4pQ1G3P826sz5DnkiFt9dVrp
         VVTdjpmXpv5x3Rp/w2K+NDQTPAdgF6TRJkYZb7J4m1a5+JgCuOMMdIA+z4R2qnKKJHF7
         59GVSR0YNDBDopQ+Jfvi34azbTU2OpWnziRT8+bda1MqPBqnwSGUT8GLUuHgfTCvf+ql
         yM7+NRW1d8PcwE1DyGyOZX5RPf569A4uSbecGBve43TX5YtQ+Zz2XUsE3iXu76HxnNZN
         Pr/4lwakm3jKO173h1CAF2v83JsX+KWsbaJrXTUYVZiA7/tdDHX9EFUqs3vXGEcE0CxK
         1lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HF7pNf4fbKb1C6oMKd3EGPiCGGRyRUf2Kb2rIRMMGWI=;
        b=ZeX8K4YDCr/ou/MTWuGW0AaKHfZikAQtev/VuLZmviBt0AuaoCVLoJBLuJAMHkZ8/P
         ZSNY3QzzxAsjJTfx2SP5A9/lqwCIEjSUlSPl8MpUtkdd/Zg3zh4OW/kYleixtuBoxd48
         yZhZ3i/onKGwYcfy7d9Ckttx/iRpKrSWog0JK66k+y3W8aHGj4WK/gud19Pes+7flQR5
         L/k97GYS690/NDK65c56PYLfQ11svysFZU8todW7kf5VwETki6+yObatnRfO7vKhJPE9
         WBFmXqA4Cx26juybaDYQMBUtegkeqCEHS+35LQLTT83kakB8zEQN7M5Teu0QROPNoVbE
         uyRw==
X-Gm-Message-State: AOAM533ramc4ZcZeA9O7s9xnWD19OU3eTmamHsiwXFIDnTpWNORL/zEG
        Vj3gFe10XWTFU7FYWoJLOQ2b9w==
X-Google-Smtp-Source: ABdhPJychLw759r+cgI4A3p0klLrp1xeZVIjsYf1tuV9w10Snvfs3IhTLZiMys+b7zzK0qMVHSPNuw==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr1809740wrt.73.1598672343041;
        Fri, 28 Aug 2020 20:39:03 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l9sm1732151wmh.1.2020.08.28.20.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 2/5] wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
Date:   Sat, 29 Aug 2020 04:39:44 +0100
Message-Id: <20200829033947.2167817-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uses HW_VALUE_CHANNEL() to extract the channel number from a
struct ieee80211_channel->hw_value. Once done we can use the upper bits of
the hw_value to encode PHY related data.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2c58f7050836..729708d96586 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -764,8 +764,10 @@ int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	msg_body->num_channel = min_t(u8, req->n_channels,
 				     sizeof(msg_body->channels));
-	for (i = 0; i < msg_body->num_channel; i++)
-		msg_body->channels[i] = req->channels[i]->hw_value;
+	for (i = 0; i < msg_body->num_channel; i++) {
+		msg_body->channels[i] =
+			HW_VALUE_CHANNEL(req->channels[i]->hw_value);
+	}
 
 	msg_body->header.len -= WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

